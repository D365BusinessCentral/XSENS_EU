codeunit 50020 ProcessChargebee
{
    // version XSSCB1.4


    trigger OnRun();
    var
        sNext_Offset: Text[100];
        APIKey: Text[100];
        LastDate: Date;
        sLast_Updated: Text[100];
        GLAccountDB: Code[20];
        bPost: Boolean;
    begin
        // INITIALIZE
        ChargebeeSetup.GET;
        LastDate := ChargebeeSetup."Last updated";
        if LastDate = 0D then ERROR('U moet de laatste update datum invullen in de Chargebee Setup');
        LastDate := LastDate - 1;   //chargebee uses 'updated_after and there'll be a gap between running time and midnight (-2)
        sLast_Updated := ReturnEpoch(LastDate);
        GLAccountDB := ChargebeeSetup."GL Account";
        sLast_Updated := DELCHR(sLast_Updated, '>', ' ');
        bPost := ChargebeeSetup.InstantBooking;
        ChangeLastUpdated := true;
        gBusinessUnit := ChargebeeSetup."Segment Code";
        gProductLines := ChargebeeSetup."Product Lines";
        bUseSalesTax := ChargebeeSetup."Use Sales Tax";
        if bUseSalesTax then begin
            gSalesTaxAccount := ChargebeeSetup."Sales Tax account";
            gFullVAT := ChargebeeSetup."Full VAT";
            gNoVAT := ChargebeeSetup."No VAT";
        end;

        //GET INVOICES
        sNext_Offset := '';
        repeat
            sNext_Offset := ProcessInvoice(sNext_Offset, sLast_Updated, bPost, false);
        until sNext_Offset = 'null';

        //GET CREDIT INVOICES
        sNext_Offset := '';
        repeat
            sNext_Offset := ProcessInvoice(sNext_Offset, sLast_Updated, bPost, true);
        until sNext_Offset = 'null';

        //CHECK PAYMENTS
        CheckPayments(LastDate, GLAccountDB);

        //CLOSE
        if ChangeLastUpdated then
            ChargebeeSetup."Last updated" := TODAY;
        ChargebeeSetup.MODIFY;
    end;

    var
        ChargebeeSetup: Record ChargebeeSetup;
        ChangeLastUpdated: Boolean;
        bUseSalesTax: Boolean;
        gFullVAT: Code[20];
        gNoVAT: Code[20];
        gSalesTaxAccount: Code[20];
        gBusinessUnit: Code[20];
        gProductLines: Code[20];

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

    local procedure CreateXSensAuthHeader(APIKey: Text[100]): Text;
    var
        AuthString: Text;
        TempBlob: Record TempBlob;
    begin
        TempBlob.INIT;
        TempBlob.WriteAsText(APIKey, TEXTENCODING::UTF8);
        AuthString := TempBlob.ToBase64String();
        AuthString := STRSUBSTNO('Basic %1', AuthString);
        exit(AuthString);
    end;

    local procedure ProcessInvoice(Offset: Text[100]; sLast_Updated: Text[100]; bPost: Boolean; bCredit: Boolean): Text;
    var
        //JObject: DotNet "'Newtonsoft.Json, Version=7.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed'.Newtonsoft.Json.Linq.JObject";
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
        InvoiceNo: Code[20];
        lastURLPart: Text[300];
        Counter: Integer;
        ApiResult: Text;
        SalesPost: Codeunit "Sales-Post";
        CBTrans: Record "Chargebee Transactions";
        //JObjectCust: DotNet "'Newtonsoft.Json, Version=7.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed'.Newtonsoft.Json.Linq.JObject";
        JObjectCust: JsonObject;
        ApiResultCust: Text;
        lastURLCustPart: Text[300];
        cCustomer: Code[20];
        dAmount: Decimal;
        recCustomer: Record Customer;
        //JObjectItem: DotNet "'Newtonsoft.Json, Version=7.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed'.Newtonsoft.Json.Linq.JObject";
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
        if ApiResult = 'null' then exit(FORMAT(vNext_Offset)); //No records in the list
        //JObject := JObject.Parse(ApiResult);
        JObject.ReadFrom(ApiResult);
        //vNext_Offset := JObject.SelectToken('next_offset');
        JObject.GET('next_offset', jsontoken);
        if not jsontoken.AsValue().IsNull then
            vNext_Offset := jsontoken.AsValue().AsText()
        else
            vNext_Offset := '';
        //vID := JObject.SelectToken('list[0].' + IC + '.id');
        JObject.Get('list[0].' + IC + '.id', jsontoken);
        if not jsontoken.AsValue().IsNull then
            vID := jsontoken.AsValue().AsText()
        else
            vID := '';

        EVALUATE(InvoiceNo, FORMAT(vID));

        //vDateSerial := JObject.SelectToken('list[0].' + IC + '.date');
        JObject.get('list[0].' + IC + '.date', jsontoken);
        if not jsontoken.AsValue().IsNull then
            vDateSerial := jsontoken.AsValue().AsText()
        else
            vDateSerial := '';

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
        //lastURLCustPart := 'customers/' + FORMAT(JObject.SelectToken('list[0].' + IC + '.customer_id'));
        JObject.get('list[0].' + IC + '.customer_id', jsontoken);
        if not jsontoken.AsValue().IsNull then
            lastURLCustPart := jsontoken.AsValue().AsText()
        else
            lastURLCustPart := '';

        ApiResultCust := GiveApiResult(lastURLCustPart, 'GET');
        if ApiResultCust = 'null' then begin
            ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Cannot find Customer in Chargebee on customer_id', 0, '', false);
            ChangeLastUpdated := false;
            exit(FORMAT(vNext_Offset));
        end;

        //JObjectCust := JObjectCust.Parse(ApiResultCust);
        JObjectCust.ReadFrom(ApiResultCust);

        //EVALUATE(cCustomer, FORMAT(JObjectCust.SelectToken('customer.cf_sfaccountnumber')));
        JObjectCust.get('customer.cf_sfaccountnumber', jsontoken);
        if not jsontoken.AsValue().IsNull then
            EVALUATE(cCustomer, jsontoken.AsValue().AsText())
        else
            cCustomer := '';

        if cCustomer = 'NULL' then begin
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
            //vValue := JObject.SelectToken('list[0].credit_note.reference_invoice_id');
            JObject.get('list[0].credit_note.reference_invoice_id', jsontoken);
            if not jsontoken.AsValue().IsNull then
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
        SalesHeader.MODIFY(false);

        // ADD SALES INVOICE LINE
        Counter := 0;
        CanRelease := true;
        repeat

            // vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].id');
            JObject.get('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].id', jsontoken);
            if not jsontoken.AsValue().IsNull then
                vValue := jsontoken.AsValue().AsText()
            else
                vValue := '';
            // No choice but to get the null var so skip it
            if FORMAT(vValue) <> 'null' then begin
                SalesLine.INIT;
                if not bCredit then
                    SalesLine."Document Type" := SalesLine."Document Type"::Invoice
                else
                    SalesLine."Document Type" := SalesLine."Document Type"::"Credit Memo";
                SalesLine."Document No." := InvoiceNo;
                SalesLine."Line No." := (Counter + 1) * 10000;
                // vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].description');
                JObject.GET('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].description', jsontoken);
                if not jsontoken.AsValue().IsNull then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '';

                EVALUATE(SalesLine.Description, PADSTR(FORMAT(vValue), 50));
                //vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].entity_type');
                JObject.GET('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].entity_type', jsontoken);
                if not jsontoken.AsValue().IsNull then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '';

                SalesLine.Type := SalesLine.Type::Item;
                if FORMAT(vValue) = 'plan' then
                    SalesLine.Type := SalesLine.Type::" "
                else begin
                    //GET ITEM
                    LineQuantity := 0;
                    ItemFound := true;
                    //vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].entity_id');
                    JObject.GET('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].entity_id', jsontoken);
                    if not jsontoken.AsValue().IsNull then
                        vValue := jsontoken.AsValue().AsText()
                    else
                        vValue := '';
                    LastURLItemPart := 'addons/' + FORMAT(vValue);
                    ApiResultItem := GiveApiResult(LastURLItemPart, 'GET');
                    if ApiResultItem = 'null' then begin
                        cDesc := STRSUBSTNO('Cannot find Charbee Item entity_id %1', LastURLItemPart);
                        ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, cDesc, 0, '', false);
                        ItemFound := false;
                        CanRelease := false;
                    end;
                    if ItemFound then begin
                        //JObjectItem := JObjectItem.Parse(ApiResultItem);
                        JObjectItem.ReadFrom(ApiResultItem);
                        //EVALUATE(cItem, FORMAT(JObjectItem.SelectToken('addon.cf_nav_item_number')));
                        JObjectItem.GET('addon.cf_nav_item_number', jsontoken);
                        if not jsontoken.AsValue().IsNull then
                            cItem := jsontoken.AsValue().AsText()
                        else
                            cItem := 'NULL';

                        if cItem = 'NULL' then begin
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
                    //vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].quantity');
                    JObject.GET('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].quantity', jsontoken);
                    if not jsontoken.AsValue().IsNull then
                        vValue := jsontoken.AsValue().AsText()
                    else
                        vValue := '';
                    EVALUATE(LineQuantity, FORMAT(vValue));
                    EVALUATE(SalesLine.Quantity, FORMAT(vValue));
                end;
                if ItemFound then
                    SalesLine.VALIDATE(Quantity);
                //vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].amount');
                JObject.GET('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].amount', jsontoken);
                if not jsontoken.AsValue().IsNull then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '';
                EVALUATE(LineAmount, FORMAT(vValue));
                LineAmount := LineAmount / 100;
                if LineQuantity = 0 then begin
                    //vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].unit_amount');
                    JObject.GET('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].unit_amount', jsontoken);
                    if not jsontoken.AsValue().IsNull then
                        vValue := jsontoken.AsValue().AsText()
                    else
                        vValue := '';
                    EVALUATE(dAmount, FORMAT(vValue));
                    dAmount := dAmount / 100;
                    SalesLine.VALIDATE("Unit Price", dAmount);
                end
                else begin
                    SalesLine.VALIDATE("Unit Price", LineAmount / LineQuantity);
                end;
                SalesLine.VALIDATE(Amount, LineAmount);
                //Discount amount
                //vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].discount_amount');
                JObject.GET('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].discount_amount', jsontoken);
                if not jsontoken.AsValue().IsNull then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '';
                EVALUATE(DiscountAmt, FORMAT(vValue));
                DiscountAmt := DiscountAmt / 100;
                if DiscountAmt > 0 then
                    SalesLine.VALIDATE("Line Discount Amount", DiscountAmt);
                //
                SalesLine.VALIDATE("Shortcut Dimension 1 Code", gBusinessUnit);
                SalesLine.Validate("Shortcut Dimension 4 Code", gProductLines);
                if bUseSalesTax then SalesLine.VALIDATE("VAT Prod. Posting Group", gNoVAT);
                SalesLine.INSERT(true);
                //vValue := JObject.SelectToken('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].tax_amount');
                JObject.GET('list[0].' + IC + '.line_items[' + FORMAT(Counter) + '].tax_amount', jsontoken);
                if not jsontoken.AsValue().IsNull then
                    vValue := jsontoken.AsValue().AsText()
                else
                    vValue := '';
                EVALUATE(dBTWCB, FORMAT(vValue));
                dBTWCB := dBTWCB / 100;
                dBTWNAV := SalesLine."Amount Including VAT" - SalesLine.Amount;
                if not bUseSalesTax then begin
                    if dBTWNAV <> dBTWCB then
                        UpdateWorkdescription(SalesHeader, dBTWNAV, dBTWCB, Counter);
                end;
            end;
            Counter := Counter + 1;
        until FORMAT(vValue) = 'null';
        if bUseSalesTax then begin
            //vValue := JObject.SelectToken('list[0].' + IC + '.tax');
            JObject.GET('list[0].' + IC + '.tax', jsontoken);
            if not jsontoken.AsValue().IsNull then
                vValue := jsontoken.AsValue().AsText()
            else
                vValue := '';

            if FORMAT(vValue) <> 'null' then begin
                EVALUATE(dAmount, FORMAT(vValue));
                dAmount := dAmount / 100;
                iLineNo := (Counter + 1) * 10000;
                AddSalesTaxLine(dAmount, bCredit, InvoiceNo, iLineNo);
            end;
        end;
        if CanRelease then
            SalesHeader.SetStatus(SalesHeader.Status::Released);
        if bPost then begin
            CLEAR(SalesPost);
            SalesPost.RUN(SalesHeader);
        end;
        SalesHeader.CALCFIELDS("Amount Including VAT");
        ChangeTransaction(CBTrans.Type::Invoice, InvoiceNo, 'Invoice created in NAV', SalesHeader."Amount Including VAT", cCustomer, true);
        exit(FORMAT(vNext_Offset));
    end;

    local procedure ReturnEpoch(LastDate: Date): Text;
    var
        dOffSetDate: Date;
    begin
        dOffSetDate := 19700101D;
        exit(FORMAT((LastDate - dOffSetDate) * 86400));
    end;

    local procedure CheckPayments(LastDate: Date; GLAccountDB: Code[20]);
    var
        GLEntry: Record "G/L Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        CustLedgerEntryInvoice: Record "Cust. Ledger Entry";
        LastDateTime: DateTime;
        lastURLPart: Text[300];
        ApiResult: Text;
        //JObject: DotNet "'Newtonsoft.Json, Version=7.0.0.0, Culture=neutral, PublicKeyToken=30ad4fe6b2a6aeed'.Newtonsoft.Json.Linq.JObject";
        JObject: JsonObject;
        jsontoken: JsonToken;
        vTransID: Variant;
        CBTrans: Record "Chargebee Transactions";
        cEntry: Code[20];
        Desc: Text[50];
    begin
        GLEntry.RESET;
        GLEntry.SETRANGE("G/L Account No.", GLAccountDB);
        GLEntry.SETRANGE("Document Type", GLEntry."Document Type"::Payment);
        LastDateTime := CREATEDATETIME(LastDate, 000000T);
        GLEntry.SETFILTER("Last Modified DateTime", '>=%1', LastDateTime);
        if not GLEntry.FINDSET then exit;
        repeat
            CustLedgerEntry.RESET;
            CustLedgerEntry.SETRANGE("Transaction No.", GLEntry."Transaction No.");
            if CustLedgerEntry.FINDSET then begin
                CustLedgerEntryInvoice.RESET;
                CustLedgerEntryInvoice.SETFILTER("Document No.", 'CB*');
                CustLedgerEntryInvoice.SETRANGE("Entry No.", CustLedgerEntry."Closed by Entry No.");  //Deelbetalingen
                if not CustLedgerEntryInvoice.FINDFIRST then begin
                    CustLedgerEntryInvoice.RESET;
                    CustLedgerEntryInvoice.SETFILTER("Document No.", 'CB*');
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
                                //JObject := JObject.Parse(ApiResult);
                                //vTransID := JObject.SelectToken('transaction.id');
                                JObject.ReadFrom(ApiResult);
                                JObject.get('transaction.id', jsontoken);
                                if not jsontoken.AsValue().IsNull then
                                    vTransID := jsontoken.AsValue().AsText();
                                ChangeTransaction(CBTrans.Type::Payment, cEntry, 'Payment registered in Chargebee', GLEntry.Amount, CustLedgerEntryInvoice."Customer No.", true);
                                //MESSAGE(FORMAT(vTransID));
                            end;
                        end;
                    end;
                end;
            end;
        until GLEntry.NEXT = 0;
    end;

    local procedure GiveApiResult(lastURLPart: Text[300]; Method: Text[10]): Text;
    var
        //HttpWebRequestMgt: Codeunit "Http Web Request Mgt.";
        HttpClient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;
        HttpRequestMessage: HttpRequestMessage;

        Instr: InStream;
        TempBlob: Record TempBlob;
        ApiResult: Text;
        ChargebeeSetup: Record ChargebeeSetup;
        sURL: Text[300];
        APIKey: Text[100];
    begin
        ChargebeeSetup.GET;
        APIKey := DELCHR(ChargebeeSetup.APIKey, '>', ' ');
        APIKey := ChargebeeSetup.APIKey + '::';
        sURL := ChargebeeSetup."Base url" + '/' + lastURLPart;
        /*HttpWebRequestMgt.Initialize(sURL);
        HttpWebRequestMgt.DisableUI;
        HttpWebRequestMgt.SetMethod(Method);
        HttpWebRequestMgt.SetReturnType('application/json');
        HttpWebRequestMgt.SetContentType('application/json');
        HttpWebRequestMgt.AddHeader('Authorization', CreateXSensAuthHeader(APIKey));*/
        HttpRequestMessage.Method(Method);
        HttpClient.SetBaseAddress(sURL);
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        //HttpHeaders.Add('Content-Type', 'Application/json');
        // HttpHeaders.Add('Accept', 'Application/json');
        HttpClient.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'Application/json');
        HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('Accept', 'Application/json');
        HttpClient.DefaultRequestHeaders.Add('Authorization', CreateXSensAuthHeader(APIKey));

        HttpRequestMessage.Content(HttpContent);
        //if HttpClient.Post(URL, HttpContent, HttpResponseMessage) then begin
        if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
            if HttpResponseMessage.IsSuccessStatusCode() then begin
                HttpResponseMessage.Content().ReadAs(ApiResult);
            end else begin
                exit('null');
                //HttpResponseMessage.Content().ReadAs(ApiResult);
            end;

            /*TempBlob.INIT;
            TempBlob.Blob.CREATEINSTREAM(Instr);
            if not HttpWebRequestMgt.GetResponseStream(Instr) then exit('null');
            //HttpWebRequestMgt.GetResponse(Instr,httpStatusCode,ResponseHeaders);
            //MESSAGE(ResponseHeaders.ToString);
            ApiResult := TempBlob.ReadAsText('', TEXTENCODING::UTF8);
            if ApiResult = '' then begin
                //  MESSAGE(GETLASTERRORTEXT);
                exit('null')
            end;*/
            exit(ApiResult);
        end else begin
            exit('null')
        end;
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
        if Amount > 0 then
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
        dBTWCB: Decimal;
        dBTWNAV: Decimal;
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
        Outstr.WRITETEXT('Regel ' + FORMAT(Counter) + STRSUBSTNO(': Btw bedrag Chargebee %1. Btw bedrag NAV %2.', dBTWCB, dBTWNAV));
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
        SalesLine."VAT Prod. Posting Group" := gFullVAT;
        SalesLine.VALIDATE("Unit Price", dTax);
        SalesLine.INSERT(true);
    end;
}

