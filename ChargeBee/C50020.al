codeunit 50020 ProcessChargebee
{
    // version XSSCB1.5
    // Peter de Vries - Solutions-Factory: Modified for Business Central
    // version december 2021: Multiple Connections are now implemented

    trigger OnRun();
    var
        sNext_Offset: Text[100];
        LastDate: Date;
        sLast_Updated: Text[100];
        CBTrans: Record "Chargebee Transactions";
        ChargebeeSetup: Record ChargebeeSetup;
        ChargebeeLine: Record ChargebeeSetupLine;
    begin
        // INITIALIZE
        ChargebeeSetup.GET;
        gGLAccountDB := ChargebeeSetup."GL Account";
        ChangeLastUpdated := true;
        gSegmentCode := ChargebeeSetup."Segment Code";
        gProductLines := ChargebeeSetup."Product Lines";
        gUseSalesTax := ChargebeeSetup."Use Sales Tax";
        if gUseSalesTax then begin
            gSalesTaxAccount := ChargebeeSetup."Sales Tax account";
            gFullVAT := ChargebeeSetup."Full VAT";
            gNoVAT := ChargebeeSetup."No VAT";
        end;

        ChargebeeLine.FindFirst();
        repeat

            gConnectie := ChargebeeLine.Connectie;
            gURL := ChargebeeLine."Base url";
            //gAPIKey := gChargebeeSetup.gAPIKey + '::';
            gAPIKey := DELCHR(ChargebeeLine.APIKey, '>', ' ');
            LastDate := ChargebeeLine."Last updated";
            if LastDate = 0D then ERROR('You must provide a value for ''last updated'' in Chargebee Setup');
            LastDate := LastDate - 1;   //chargebee uses 'updated_after and there'll be a gap between running time and midnight (-2)
            sLast_Updated := ReturnEpoch(LastDate);
            sLast_Updated := DELCHR(sLast_Updated, '>', ' ');
            gbPost := ChargebeeLine.InstantBooking;
            gInvPrefixWithStar := ChargebeeLine."Invoice prefix" + '*';


            //TEST CONNECTION
            if GiveApiResult('', 'GET') = 'null' then begin
                SetTransaction(CBTrans.Type::Error, Format(CurrentDateTime), 'No Response...', '');
                if GuiAllowed then Message('No connection...');
                Commit();
                Error('');
            end;

            //GET INVOICES
            sNext_Offset := '';
            repeat
                sNext_Offset := ProcessInvoice(sNext_Offset, sLast_Updated, false);
            until sNext_Offset = '0';

            //GET CREDIT INVOICES
            sNext_Offset := '';
            repeat
                sNext_Offset := ProcessInvoice(sNext_Offset, sLast_Updated, true);
            until sNext_Offset = '0';

            //CHECK PAYMENTS
            CheckPayments(LastDate);

            //CLOSE
            if ChangeLastUpdated then
                ChargebeeLine."Last updated" := TODAY;
            ChargebeeLine.MODIFY;
        until ChargebeeLine.Next() = 0;
    end;

    local procedure ProcessInvoice(Offset: Text[100]; sLast_Updated: Text[100]; bCredit: Boolean): Text;
    var
        JObject: JsonObject;
        vID: Variant;
        vDateSerial: Variant;
        vNext_Offset: Variant;
        dOffsetDate: Date;
        NoOfDays: Decimal;
        dDocDate: Date;
        SalesHeader: Record "Sales Header";
        PostedSalesHeader: Record "Sales Invoice Header";
        PostedCreditMemo: Record "Sales Cr.Memo Header";
        SalesLine: Record "Sales Line";
        vValue: Variant;
        LoopValue: Variant;
        InvoiceNo: Code[20];
        lastURLPart: Text[300];
        Counter: Integer;
        ApiResult: Text;
        SalesPost: Codeunit "Sales-Post";
        CBTrans: Record "Chargebee Transactions";
        JObjectCust: JsonObject;
        ApiResultCust: Text;
        lastURLCustPart: Text[300];
        cCustomer: Code[20];
        dAmount: Decimal;
        recCustomer: Record Customer;
        JObjectItem: JsonObject;
        ApiResultItem: Text;
        LastURLItemPart: Text[300];
        cItem: Code[20];
        recItem: Record Item;
        ItemFound: Boolean;
        cDesc: Text[100];
        CanRelease: Boolean;
        dBTWCB: Decimal;
        dBTWNAV: Decimal;
        Instr: InStream;
        Outstr: OutStream;
        tmpText: Text[1024];
        IC: Text[12];
        iLineNo: Integer;
        LineQuantity: Decimal;
        LineAmount: Decimal;
        DiscountAmt: Decimal;
        jsontoken: JsonToken;
    begin

        // GET CHARGEBEE INVOICE
        Offset := DELCHR(Offset, '>', ' ');
        if not bCredit then begin
            IC := 'invoice';
            lastURLPart := 'invoices?limit=1&updated_at[after]=' + sLast_Updated + '&offset=' + Offset;
        end else begin
            IC := 'credit_note';
            lastURLPart := 'credit_notes?limit=1&updated_at[after]=' + sLast_Updated + '&offset=' + Offset;
        end;
        ApiResult := GiveApiResult(lastURLPart, 'GET');
        if ApiResult = 'null' then begin
            vNext_Offset := '0';
            exit(FORMAT(vNext_Offset)); //No records in the list
        end;
        JObject.ReadFrom(ApiResult);
        if JObject.SelectToken('next_offset', jsontoken) then
            vNext_Offset := jsontoken.AsValue().AsText()
        else begin
            vNext_Offset := '0';
            exit(FORMAT(vNext_Offset));
        end;
        if JObject.SelectToken('list[0].' + IC + '.id', jsontoken) then
            vID := jsontoken.AsValue().AsText()
        else begin
            vNext_Offset := '0';
            exit(FORMAT(vNext_Offset));
        end;

        EVALUATE(InvoiceNo, FORMAT(vID));

        if JObject.SelectToken('list[0].' + IC + '.date', jsontoken) then
            vDateSerial := jsontoken.AsValue().AsText()
        else
            vDateSerial := '0';

        SetTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Create Invoice..',
                                                                InvoiceNo);
        if not bCredit then begin
            if SalesHeader.GET(SalesHeader."Document Type"::Invoice, InvoiceNo) then begin
                SalesHeader.CALCFIELDS("Amount Including VAT");
                ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Invoice already exists in NAV', SalesHeader."Amount Including VAT", '', false);
                exit(FORMAT(vNext_Offset));
            end;
            if PostedSalesHeader.GET(InvoiceNo) then begin
                PostedSalesHeader.CALCFIELDS("Amount Including VAT");
                ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Booked Invoice already exists', PostedSalesHeader."Amount Including VAT", '', false);
                exit(FORMAT(vNext_Offset));
            end;
        end else begin
            if SalesHeader.GET(SalesHeader."Document Type"::"Credit Memo", InvoiceNo) then begin
                SalesHeader.CALCFIELDS("Amount Including VAT");
                ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Credit Memo already exists in NAV', SalesHeader."Amount Including VAT", '', false);
                exit(FORMAT(vNext_Offset));
            end;
            if PostedCreditMemo.GET(InvoiceNo) then begin
                PostedCreditMemo.CALCFIELDS("Amount Including VAT");
                ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Booked Credit Memo already exists', PostedCreditMemo."Amount Including VAT", '', false);
                exit(FORMAT(vNext_Offset));
            end;
        end;
        //GET CUSTOMER
        lastURLCustPart := '';
        if JObject.SelectToken('list[0].' + IC + '.customer_id', jsontoken) then
            lastURLCustPart := 'customers/' + jsontoken.AsValue().AsText()
        else begin
            ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Cannot find Customer in Chargebee on customer_id', 0, '', false);
            ChangeLastUpdated := false;
            exit(FORMAT(vNext_Offset));
        end;

        ApiResultCust := GiveApiResult(lastURLCustPart, 'GET');
        if ApiResultCust = 'null' then begin
            ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Cannot find Customer in Chargebee on customer_id', 0, '', false);
            ChangeLastUpdated := false;
            exit(FORMAT(vNext_Offset));
        end;

        JObjectCust.ReadFrom(ApiResultCust);
        cCustomer := '0';
        if JObjectCust.SelectToken('customer.cf_sfaccountnumber', jsontoken) then begin
            EVALUATE(cCustomer, jsontoken.AsValue().AsText());
        end else begin
            ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, STRSUBSTNO('Entity cf_sfaccountnumber %1 does not exist', lastURLCustPart), 0, '', false);
            ChangeLastUpdated := false;
            exit(FORMAT(vNext_Offset));      //entity cf_accountnumber bestaat niet
        end;
        if not recCustomer.GET(cCustomer) then begin
            ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, STRSUBSTNO('Customer %1 does not exist in NAV', cCustomer), 0, cCustomer, false);
            ChangeLastUpdated := false;
            exit(FORMAT(vNext_Offset));      //entity cf_accountnumber bestaat niet
        end;
        //CREATE SALES HEADER
        SalesHeader.INIT;
        if not bCredit then
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Invoice)
        else
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::"Credit Memo");
        SalesHeader.VALIDATE("No.", InvoiceNo);
        SalesHeader.VALIDATE("Document Date", ReturnDate(vDateSerial));
        //Posting date op vandaag (altijd)
        SalesHeader.VALIDATE("Posting Date", ReturnDate(vDateSerial));
        SalesHeader.VALIDATE("Sell-to Customer No.", cCustomer);
        if bCredit then begin
            SalesHeader.VALIDATE("Applies-to Doc. Type", SalesHeader."Applies-to Doc. Type"::Invoice);
            if JObject.SelectToken('list[0].credit_note.reference_invoice_id', jsontoken) then
                vValue := jsontoken.AsValue().AsText()
            else
                vValue := '';
            SalesHeader.VALIDATE("Applies-to Doc. No.", FORMAT(vValue));
            //"Applies-to ID" -> Mag niet worden gevuld
        end;
        //...

        SalesHeader.INSERT(true);
        SalesHeader."No. Series" := '';
        SalesHeader."Posting No. Series" := '';
        SalesHeader."Tax Area Code" := '';
        SalesHeader."Tax Liable" := false;
        SalesHeader.MODIFY(false);

        // ADD SALES INVOICE LINE
        Counter := 0;
        CanRelease := true;
        repeat

            if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].id', jsontoken) then begin
                LoopValue := jsontoken.AsValue().AsText();
            end else begin
                LoopValue := '0';
            end;
            // No choice but to get the null var so skip it
            if FORMAT(LoopValue) <> '0' then begin
                SalesLine.INIT;
                if not bCredit then
                    SalesLine."Document Type" := SalesLine."Document Type"::Invoice
                else
                    SalesLine."Document Type" := SalesLine."Document Type"::"Credit Memo";
                SalesLine."Document No." := InvoiceNo;
                SalesLine."Line No." := (Counter + 1) * 10000;
                if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].description', jsontoken) then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '';
                EVALUATE(SalesLine.Description, PADSTR(FORMAT(vValue), 50));

                if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].entity_type', jsontoken) then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := 'plan';

                SalesLine.Type := SalesLine.Type::Item;
                if FORMAT(vValue) = 'plan' then
                    SalesLine.Type := SalesLine.Type::" "
                else begin
                    //GET ITEM
                    LineQuantity := 0;
                    ItemFound := true;
                    if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].entity_id', jsontoken) then
                        vValue := jsontoken.AsValue().AsText()
                    else
                        vValue := '0';
                    LastURLItemPart := 'addons/' + FORMAT(vValue);
                    ApiResultItem := GiveApiResult(LastURLItemPart, 'GET');
                    if ApiResultItem = 'null' then begin
                        cDesc := STRSUBSTNO('Cannot find Charbee Item entity_id %1', LastURLItemPart);
                        ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, cDesc, 0, '', false);
                        ItemFound := false;
                        CanRelease := false;
                    end;
                    if ItemFound then begin
                        JObjectItem.ReadFrom(ApiResultItem);
                        if JObjectItem.SelectToken('addon.cf_nav_item_number', jsontoken) then
                            cItem := jsontoken.AsValue().AsText()
                        else
                            cItem := '0';

                        if cItem = '0' then begin
                            cDesc := STRSUBSTNO('Entity cf_nav_item_number %1 does not exist', LastURLItemPart);
                            ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, cDesc, 0, '', false);
                            ItemFound := false;
                            CanRelease := false;
                        end;
                        if (not recItem.GET(cItem)) and ItemFound then begin
                            cDesc := STRSUBSTNO('Item %1 does not exist in NAV', cItem);
                            ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, cDesc, 0, cCustomer, false);
                            ItemFound := false;
                            CanRelease := false;
                        end;
                        if ItemFound then begin
                            EVALUATE(SalesLine."No.", cItem);
                            SalesLine.VALIDATE("No.");
                        end
                        else begin
                            SalesLine.Type := SalesLine.Type::" ";
                            cDesc := COPYSTR(cDesc, 1, 50);
                            EVALUATE(SalesLine.Description, cDesc);
                        end;
                    end;
                    if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].quantity', jsontoken) then
                        vValue := jsontoken.AsValue().AsText()
                    else
                        vValue := '0';
                    EVALUATE(LineQuantity, FORMAT(vValue));
                    EVALUATE(SalesLine.Quantity, FORMAT(vValue));
                end;
                if ItemFound then
                    SalesLine.VALIDATE(Quantity);
                if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].amount', jsontoken) then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '0';
                EVALUATE(LineAmount, FORMAT(vValue));
                LineAmount := LineAmount / 100;
                if LineQuantity = 0 then begin
                    if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].unit_amount', jsontoken) then
                        vValue := jsontoken.AsValue().AsText()
                    else
                        vValue := '0';
                    EVALUATE(dAmount, FORMAT(vValue));
                    dAmount := dAmount / 100;
                    SalesLine.VALIDATE("Unit Price", dAmount);
                end
                else begin
                    SalesLine.VALIDATE("Unit Price", LineAmount / LineQuantity);
                end;
                SalesLine.VALIDATE(Amount, LineAmount);
                //Discount amount
                if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].discount_amount', jsontoken) then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '';
                EVALUATE(DiscountAmt, FORMAT(vValue));
                DiscountAmt := DiscountAmt / 100;
                if DiscountAmt > 0 then
                    SalesLine.VALIDATE("Line Discount Amount", DiscountAmt);
                SalesLine.VALIDATE("Shortcut Dimension 1 Code", gSegmentCode);
                SalesLine.ValidateShortcutDimCode(4, gProductLines);
                //SalesLine.Validate("Shortcut Dimension 4 Code", gProductLines);
                if gUseSalesTax then begin
                    SalesLine."Tax Area Code" := '';
                    SalesLine."Tax Category" := '';
                    SalesLine."Tax Group Code" := '';
                    SalesLine."Tax Liable" := false;
                    SalesLine.VALIDATE("VAT Prod. Posting Group", gNoVAT);
                end;
                SalesLine.INSERT(true);
                if JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].tax_amount', jsontoken) then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '0';
                EVALUATE(dBTWCB, FORMAT(vValue));
                dBTWCB := dBTWCB / 100;
                dBTWNAV := SalesLine."Amount Including VAT" - SalesLine.GetLineAmountExclVAT();
                if not gUseSalesTax then begin
                    if dBTWNAV <> dBTWCB then
                        UpdateWorkdescription(SalesHeader, dBTWNAV, dBTWCB, Counter + 1);
                end;
            end;
            Counter := Counter + 1;
        until FORMAT(LoopValue) = '0';
        if gUseSalesTax then begin
            if JObject.SelectToken('list[0].' + IC + '.tax', jsontoken) then
                vValue := jsontoken.AsValue().AsText()
            else
                vValue := '0';

            if FORMAT(vValue) <> '0' then begin
                EVALUATE(dAmount, FORMAT(vValue));
                dAmount := dAmount / 100;
                iLineNo := (Counter + 1) * 10000;
                AddSalesTaxLine(dAmount, bCredit, InvoiceNo, iLineNo);
            end;
        end;
        if CanRelease then
            SalesPost.ReleaseSalesDocument(SalesHeader);
        if gbPost then begin
            CLEAR(SalesPost);
            SalesPost.RUN(SalesHeader);
        end;
        SalesHeader.CALCFIELDS("Amount Including VAT");
        ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Invoice created in NAV. No of Lines : ' + Format(Counter - 1), SalesHeader."Amount Including VAT", cCustomer, true);
        exit(FORMAT(vNext_Offset));
    end;

    local procedure CheckPayments(LastDate: Date);
    var
        GLEntry: Record "G/L Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntryInvoice: Record "Cust. Ledger Entry";
        LastDateTime: DateTime;
        lastURLPart: Text[300];
        ApiResult: Text;
        JObject: JsonObject;
        jsontoken: JsonToken;
        vTransID: Variant;
        CBTrans: Record "Chargebee Transactions";
        cEntry: Code[20];
        Desc: Text[50];

    begin
        GLEntry.RESET;
        GLEntry.SETRANGE("G/L Account No.", gGLAccountDB);
        GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Payment);
        LastDateTime := CREATEDATETIME(LastDate, 000000T);
        GLEntry.SETFILTER("Last Modified DateTime", '>=%1', LastDateTime);
        if not GLEntry.FINDSET then begin
            SetTransaction(CBTrans.Type::Payment, format(CurrentDateTime), 'No payments found on ' + gGLAccountDB + ' after ' + format(LastDateTime), '');
            exit;
        end;
        repeat
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Transaction No.", GLEntry."Transaction No.");
            if CustLedgerEntry.FINDSET then begin
                CustLedgerEntryInvoice.RESET;
                CustLedgerEntryInvoice.SETFILTER("Document No.", gInvPrefixWithStar);
                CustLedgerEntryInvoice.SETRANGE("Entry No.", CustLedgerEntry."Closed by Entry No.");  //Deelbetalingen
                if not CustLedgerEntryInvoice.FINDFIRST then begin
                    CustLedgerEntryInvoice.RESET;
                    CustLedgerEntryInvoice.SETFILTER("Document No.", gInvPrefixWithStar);
                    CustLedgerEntryInvoice.SETRANGE("Closed by Entry No.", CustLedgerEntry."Entry No.");  //Afgesloten
                end;
                if CustLedgerEntryInvoice.FINDFIRST then begin
                    EVALUATE(cEntry, FORMAT(GLEntry."Transaction No."));
                    if SetTransaction(CBTrans.Type::Payment, cEntry, 'Start Payment...',
                                      CustLedgerEntryInvoice."Document No.") then begin
                        lastURLPart := 'invoices/';
                        lastURLPart := lastURLPart + CustLedgerEntryInvoice."Document No.";
                        ApiResult := GiveApiResult(lastURLPart, 'GET');
                        if ApiResult = 'null' then begin
                            Desc := STRSUBSTNO('INVOICE %1 NOT FOUND AT CHARGEBEE', CustLedgerEntryInvoice."Document No.");
                            ChangeTransaction(CBTrans.Type::Payment, cEntry, Desc, GLEntry.Amount, CustLedgerEntryInvoice."Customer No.", false);
                        end
                        else begin
                            lastURLPart := lastURLPart + '/record_payment?comment="Transaction Entry ' + FORMAT(cEntry) + 'from NAV"&transaction[amount]=';
                            lastURLPart := lastURLPart + DELCHR(DELCHR(FORMAT(ROUND(GLEntry.Amount, 0.01) * -100), '=', '.'), '=', ',');
                            lastURLPart := lastURLPart + '&transaction[payment_method]=bank_transfer';
                            ApiResult := GiveApiResult(lastURLPart, 'POST');
                            if ApiResult = 'null' then begin
                                ChangeTransaction(CBTrans.Type::Payment, cEntry, 'PAYMENT NOT REGISTERED IN CHARGEBEE', GLEntry.Amount, CustLedgerEntryInvoice."Customer No.", false);
                            end
                            else begin
                                JObject.ReadFrom(ApiResult);
                                if JObject.SelectToken('transaction.id', jsontoken) then
                                    vTransID := jsontoken.AsValue().AsText()
                                else
                                    vTransID := '0';
                                ChangeTransaction(CBTrans.Type::Payment, cEntry, 'Payment registered in Chargebee', GLEntry.Amount, CustLedgerEntryInvoice."Customer No.", true);
                            end;
                        end;
                    end;
                end;
            end;
        until GLEntry.NEXT = 0;
    end;

    local procedure GiveApiResult(lastURLPart: Text[300]; Method: Text[10]): Text;
    var
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;
        HttpRequestMessage: HttpRequestMessage;
        Instr: InStream;
        ApiResult: Text;
        lURL: Text[300];
    begin
        lURL := gURL + '/' + lastURLPart;
        HttpRequestMessage.SetRequestUri(lURL);
        HttpHeaders := HttpClient.DefaultRequestHeaders();
        HttpHeaders.Add('Authorization', CreateXSensAuthHeader(gAPIKey));
        HttpRequestMessage.Method := Method;
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                HttpResponseMessage.Content().ReadAs(ApiResult);
            end else begin
                exit('null');
            end;
            exit(ApiResult);

        end else begin
            exit('null')
        end;
    end;

    local procedure ReturnEpoch(LastDate: Date): Text;
    var
        dOffSetDate: Date;
    begin
        dOffSetDate := 19700101D;
        exit(FORMAT((LastDate - dOffSetDate) * 86400));
    end;

    local procedure SetTransaction(Type: Option; ID: Code[20]; Description: Text[100]; "InvoiceNr.": Code[20]): Boolean;
    var
        CBTrans: Record "Chargebee Transactions";
    begin
        CBTrans.RESET;
        if CBTrans.GET(Type, ID) then begin
            if CBTrans.Type = CBTrans.Type::Invoice then exit(false);
            if CBTrans.Type = CBTrans.Type::Payment then begin
                if CBTrans.Succeeded then exit(false) else exit(true);
            end;
        end;
        CBTrans.INIT;
        CBTrans.Connectie := gConnectie;
        CBTrans."Log Date" := TODAY;
        CBTrans.Type := Type;
        CBTrans.ID := ID;
        CBTrans.Description := Description;
        CBTrans."InvoiceNr." := "InvoiceNr.";
        CBTrans.INSERT;
        exit(true);
    end;

    local procedure ChangeTransaction(Type: Option; ID: Code[20]; Description: Text[100]; Amount: Decimal; Customer: Code[20]; Succeeded: Boolean): Boolean;
    var
        CBTrans: Record "Chargebee Transactions";
    begin
        CBTrans.RESET;
        if not CBTrans.GET(Type, ID) then exit(false);
        if CBTrans.Type = CBTrans.Type::Invoice then if CBTrans.Succeeded then exit(false);
        CBTrans.Description := Description;
        //if Amount <> 0 then
        CBTrans.Amount := Amount;
        if Customer <> '' then
            CBTrans.Customer := Customer;
        CBTrans.Succeeded := Succeeded;
        CBTrans.MODIFY;
        exit(true);
    end;

    local procedure ReturnEntryNow(): Integer;
    var
        dOffSetDate: Date;
        dOffSetTime: Time;
        Days: Integer;
        iSeconds: Integer;
    begin
        dOffSetDate := 19700101D;
        dOffSetTime := 020000T;
        Days := TODAY - dOffSetDate;
        iSeconds := TIME - dOffSetTime;
        exit(Days + iSeconds);
    end;

    local procedure UpdateWorkdescription(SalesHeader: Record "Sales Header"; dVATNAV: Decimal; dVATCH: Decimal; Counter: Integer);
    var
        Instr: InStream;
        Outstr: OutStream;
        tmpText: Text[1024];
    begin
        SalesHeader.CALCFIELDS("Work Description");
        SalesHeader."Work Description".CREATEINSTREAM(Instr);
        Instr.READTEXT(tmpText);
        SalesHeader."Work Description".CREATEOUTSTREAM(Outstr);
        if tmpText <> '' then begin
            Outstr.WRITETEXT(tmpText);
            Outstr.WRITETEXT;
        end;
        Outstr.WRITETEXT('Regel ' + FORMAT(Counter) + STRSUBSTNO(': Btw bedrag Chargebee %1. Btw bedrag NAV %2.', dVATCH, dVATNAV));
        Outstr.WRITETEXT;
        SalesHeader.MODIFY;
    end;

    local procedure AddSalesTaxLine(dTax: Decimal; bCredit: Boolean; pInvoiceNo: Code[20]; pLineNo: Integer);
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.INIT;
        if not bCredit then
            SalesLine."Document Type" := SalesLine."Document Type"::Invoice
        else
            SalesLine."Document Type" := SalesLine."Document Type"::"Credit Memo";
        SalesLine."Document No." := pInvoiceNo;
        SalesLine."Line No." := pLineNo;
        SalesLine.Type := SalesLine.Type::"G/L Account";
        SalesLine.VALIDATE("No.", gSalesTaxAccount);
        SalesLine.Description := 'Sales Tax amount';
        SalesLine.VALIDATE(Quantity, 1);
        SalesLine."Tax Area Code" := '';
        SalesLine."Tax Category" := '';
        SalesLine."Tax Group Code" := '';
        SalesLine."Tax Liable" := false;
        SalesLine.VALIDATE("Unit Price", dTax);
        SalesLine.VALIDATE("VAT Prod. Posting Group", gFullVAT);
        SalesLine.INSERT(true);
    end;

    local procedure ReturnDate(vDateSerial: Variant): Date;
    var
        NoOfDays: Decimal;
        dOffsetDate: Date;
    begin
        dOffsetDate := 19700101D;
        EVALUATE(NoOfDays, FORMAT(vDateSerial));
        NoOfDays := ROUND(NoOfDays / 86400, 1);
        exit(dOffsetDate + NoOfDays);
    end;

    local procedure CreateXSensAuthHeader(APIkey: Text): Text
    var
        AuthString: Text;
        BaseConv: Codeunit "Base64 Convert";
    begin
        AuthString := APIkey;
        AuthString := BaseConv.ToBase64(AuthString);
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        exit(AuthString);
    end;

    var
        gConnectie: Code[20];
        gURL: Text[300];
        gAPIKey: Text[100];
        ChangeLastUpdated: Boolean;
        gUseSalesTax: Boolean;
        gFullVAT: Code[20];
        gNoVAT: Code[20];
        gSalesTaxAccount: Code[20];
        gSegmentCode: Code[20];
        gProductLines: Code[20];
        gbPost: Boolean;
        gInvPrefixWithStar: Text[3];
        gGLAccountDB: Code[20];
}

