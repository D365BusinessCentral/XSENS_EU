report 72100 "R204 Sales - Quote DCR"
{
    // version DCR3.45.100.01

    // ********************************************************************************
    // IDYN - Document Creator
    // ********************************************************************************
    // 
    // ID        Date       Author
    // --------------------------------------------------------------------------------
    // [DR004AA] 09-05-17   TVW,
    //           New object.
    // --------------------------------------------------------------------------------
    // [DR004AB] 23-06-17,   CB,
    //           Always Run Printer Selection after Request Page (OnOpenPage)
    // --------------------------------------------------------------------------------
    // [DR004AC] 28-02-18,   RB,
    //           Added date-columns to dataset, Updated labels

    Caption = 'Sales - Quote';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(SalesHdr; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(lblAllowInvDisc; Trl('AllowInvDisc'))
            {
            }
            column(lblAmount; Trl('Amount'))
            {
            }
            column(lblBankAccNo; Trl('BankAccNo'))
            {
            }
            column(lblBankName; Trl('BankName'))
            {
            }
            column(lblBillToAddress; Trl('BillToAddress'))
            {
            }
            column(lblBillToCustomerNo; Trl('BillToCustomerNo'))
            {
            }
            column(lblCompanyRegistrationNo; Trl('CompanyRegistrationNo'))
            {
            }
            column(lblDescription; Trl('Description'))
            {
            }
            column(lblDocumentDate; Trl('DocumentDate'))
            {
            }
            column(lblDueDate; Trl('DueDate'))
            {
            }
            column(lblEmail; Trl('Email'))
            {
            }
            column(lblExternalDocumentNo; Trl('ExternalDocumentNo'))
            {
            }
            column(lblFaxNo; Trl('FaxNo'))
            {
            }
            column(lblGiroNo; Trl('GiroNo'))
            {
            }
            column(lblGLAccountNo; Trl('GLAccountNo'))
            {
            }
            column(lblHeaderDimensions; Trl('HeaderDimensions'))
            {
            }
            column(lblHomePage; Trl('HomePage'))
            {
            }
            column(lblIBAN; Trl('IBAN'))
            {
            }
            column(lblInvDiscAmount; Trl('InvDiscAmount'))
            {
            }
            column(lblInvDiscBaseAmount; Trl('InvDiscBaseAmount'))
            {
            }
            column(lblInvoiceNo; Trl('InvoiceNo'))
            {
            }
            column(lblLineAmount; Trl('LineAmount'))
            {
            }
            column(lblLineDimensions; Trl('LineDimensions'))
            {
            }
            column(lblLineDiscountPerc; Trl('LineDiscountPerc'))
            {
            }
            column(lblNo; Trl('No'))
            {
            }
            column(lblPageOf; Trl('Page{0}of{1}'))
            {
            }
            column(lblPaymentDiscountVAT; Trl('PaymentDiscountVAT'))
            {
            }
            column(lblPaymentTerms; Trl('PaymentTerms'))
            {
            }
            column(lblPhoneNo; Trl('PhoneNo'))
            {
            }
            column(lblPricesInclVAT; Trl('PricesInclVAT'))
            {
            }
            column(lblQuantity; Trl('Quantity'))
            {
            }
            column(lblQuoteDate; Trl('QuoteDate'))
            {
            }
            column(lblQuoteNo; Trl('QuoteNo'))
            {
            }
            column(lblSalesPerson; Trl('SalesPerson'))
            {
            }
            column(lblSellToCustomerNo; Trl('SellToCustomerNo'))
            {
            }
            column(lblShipment; Trl('Shipment'))
            {
            }
            column(lblShipmentDate; Trl('ShipmentDate'))
            {
            }
            column(lblShipmentMethod; Trl('ShipmentMethod'))
            {
            }
            column(lblShipToAddress; Trl('ShipToAddress'))
            {
            }
            column(lblSubtotal; Trl('Subtotal'))
            {
            }
            column(lblSWIFT; Trl('SWIFT'))
            {
            }
            column(lblTotal; Trl('Total'))
            {
            }
            column(lblTotalTransFooter; Trl('TotalTransFooter'))
            {
            }
            column(lblTotalTransHeader; Trl('TotalTransHeader'))
            {
            }
            column(lblUnitPrice; Trl('UnitPrice'))
            {
            }
            column(lblUOM; Trl('UOM'))
            {
            }
            column(lblVATAmount; Trl('VATAmount'))
            {
            }
            column(lblVATAmountSpecification; Trl('VATAmountSpecification'))
            {
            }
            column(lblVATBase; Trl('VATBase'))
            {
            }
            column(lblVATIdentifier; Trl('VATIdentifier'))
            {
            }
            column(lblVATPerc; Trl('VATPerc'))
            {
            }
            column(lblVATRegistrationNo; Trl('VATRegistrationNo'))
            {
            }
            column(lblYourReference; Trl('YourReference'))
            {
            }
            column(BilltoCustNo; "Bill-to Customer No.")
            {
            }
            column(CompanyAddr1; wgCompanyAddr[1])
            {
            }
            column(CompanyAddr2; wgCompanyAddr[2])
            {
            }
            column(CompanyAddr3; wgCompanyAddr[3])
            {
            }
            column(CompanyAddr4; wgCompanyAddr[4])
            {
            }
            column(CompanyAddr5; wgCompanyAddr[5])
            {
            }
            column(CompanyAddr6; wgCompanyAddr[6])
            {
            }
            column(CompanyBankAccNo; wgRecCompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankName; wgRecCompanyInfo."Bank Name")
            {
            }
            column(CompanyEMail; wgRecCompanyInfo."E-Mail")
            {
            }
            column(CompanyFaxNo; wgRecCompanyInfo."Fax No.")
            {
            }
            column(CompanyGiroNo; wgRecCompanyInfo."Giro No.")
            {
            }
            column(CompanyHomePage; wgRecCompanyInfo."Home Page")
            {
            }
            column(CompanyIBAN; wgRecCompanyInfo.IBAN)
            {
            }
            column(CompanyPhoneNo; wgRecCompanyInfo."Phone No.")
            {
            }
            column(CompanyPicture; wgRecCompanyInfo.Picture)
            {
            }
            column(CompanyRegistrationNo; wgRecCompanyInfo."Registration No.")
            {
            }
            column(CompanySWIFT; wgRecCompanyInfo."SWIFT Code")
            {
            }
            column(CompanyVATRegNo; wgRecCompanyInfo."VAT Registration No.")
            {
            }
            column(CustAddr1; wgCustAddr[1])
            {
            }
            column(CustAddr2; wgCustAddr[2])
            {
            }
            column(CustAddr3; wgCustAddr[3])
            {
            }
            column(CustAddr4; wgCustAddr[4])
            {
            }
            column(CustAddr5; wgCustAddr[5])
            {
            }
            column(CustAddr6; wgCustAddr[6])
            {
            }
            column(CustAddr7; wgCustAddr[7])
            {
            }
            column(CustAddr8; wgCustAddr[8])
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(DueDateText; FORMAT("Due Date", 0, 4))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DocumentDateText; FORMAT("Document Date", 0, 4))
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(HideLineDiscount; wgHideLineDiscount)
            {
            }
            column(LanguageCode; "Language Code")
            {
            }
            column(PaymentTermsDesc; "Payment Terms Code")//wgCduDocCreatorTransLationMgt.wgFncGetPaymTermsTrl("Payment Terms Code")//Krishna)
            {
            }
            column(PricesInclVAT; "Prices Including VAT")
            {
            }
            column(PricesInclVATYesNo; FORMAT("Prices Including VAT"))
            {
            }
            column(SalesPurchPersonName; wgRecSalesPurchPerson.Name)
            {
            }
            column(SelltoCustNo; "Sell-to Customer No.")
            {
            }
            column(ShipmentMethodDesc; "Shipment Method Code")//wgCduDocCreatorTransLationMgt.wgFncGetShipmMethodTrl("Shipment Method Code"))//Krishna)
            {
            }
            column(ShipToAddr1; wgShipToAddr[1])
            {
            }
            column(ShipToAddr2; wgShipToAddr[2])
            {
            }
            column(ShipToAddr3; wgShipToAddr[3])
            {
            }
            column(ShipToAddr4; wgShipToAddr[4])
            {
            }
            column(ShipToAddr5; wgShipToAddr[5])
            {
            }
            column(ShipToAddr6; wgShipToAddr[6])
            {
            }
            column(ShipToAddr7; wgShipToAddr[7])
            {
            }
            column(ShipToAddr8; wgShipToAddr[8])
            {
            }
            column(ShipToAddrSet; wgShowShippingAddr)
            {
            }
            column(TotalText; wgTotalText)
            {
            }
            column(TotalExclVATText; wgTotalExclVATText)
            {
            }
            column(TotalInclVATText; wgTotalInclVATText)
            {
            }
            column(VALExchRate; wgVALExchRate)
            {
            }
            column(VALSpecLCYHeader; wgVALSpecLCYHeader)
            {
            }
            column(VATBaseDiscPerc; "VAT Base Discount %")
            {
                AutoFormatType = 1;
            }
            column(VATRegNo; "VAT Registration No.")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(OutputNo; wgOutputNo)
                {
                }
                column(SalesQuoteTitle; STRSUBSTNO(Trl('SalesQuote%1'), wgCopyText))
                {
                }
                dataitem(HdrComment; "Sales Comment Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                    DataItemLinkReference = SalesHdr;
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Line No." = CONST(0));
                    column(Comment_2; Comment)
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        if not wgShowInternalInfo then
                            CurrReport.BREAK;
                    end;
                }
                dataitem(HeaderDim; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                    DataItemLinkReference = SalesHdr;
                    DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");
                    column(DimText; "Dimension Value Name")// wgDimText)//Krishna
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        //wgCduDocCreatorReportFunctions.wgFncGetDimText(HeaderDim, wgDimText);//Krishna
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not wgShowInternalInfo then
                            CurrReport.BREAK;
                    end;
                }
                dataitem(SalesLine; "Sales Line")
                {
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                    UseTemporary = true;
                    column(Amount; Amount)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountInclVAT; "Amount Including VAT")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Description; Description)
                    {
                    }
                    column(InvDiscAmount; -"Inv. Discount Amount")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount; "Line Amount")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineDiscPerc; "Line Discount %")
                    {
                    }
                    column(No_2; "No.")
                    {
                    }
                    column(PostedShipmentDate; "Shipment Date")
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(Type; FORMAT(Type))
                    {
                    }
                    column(TypeNo; Type.AsInteger() + 0) //Type + 0)
                    {
                    }
                    column(UnitPrice; "Unit Price")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 2;
                    }
                    column(UOM; "Unit of Measure Code")//wgCduDocCreatorTransLationMgt.wgFncGetUnitOfMeaseTrl("Unit of Measure Code")//Krishna)
                    {
                    }
                    column(VATIdentifier; "VAT Identifier")
                    {
                    }
                    dataitem(LineComment; "Sales Comment Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                        DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                        column(Comment; LineComment.Comment)
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            if not wgShowInternalInfo then
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(LineDim; "Dimension Set Entry")
                    {
                        DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                        DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");
                        column(DimText_2; "Dimension Value Name")// wgDimText)//Krishna
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //wgCduDocCreatorReportFunctions.wgFncGetDimText(LineDim, wgDimText);//Krishna
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not wgShowInternalInfo then
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if not SalesHdr."Prices Including VAT" and
                           (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                        then
                            SalesLine."Line Amount" := 0;

                        if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not wgShowInternalInfo) then
                            SalesLine."No." := '';
                    end;

                    trigger OnPreDataItem();
                    var
                        wlMoreLines: Boolean;
                    begin
                        RESET;
                        wlMoreLines := SalesLine.FIND('+');
                        while wlMoreLines and (SalesLine.Description = '') and (SalesLine."Description 2" = '') and
                              (SalesLine."No." = '') and (SalesLine.Quantity = 0) and
                              (SalesLine.Amount = 0)
                        do
                            wlMoreLines := SalesLine.NEXT(-1) <> 0;
                        if not wlMoreLines then
                            CurrReport.BREAK;
                        SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");
                    end;
                }
                dataitem(VATAmtLine; "VAT Amount Line")
                {
                    DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                    UseTemporary = true;
                    column(InvDiscAmount_2; "Invoice Discount Amount")
                    {
                        AutoFormatExpression = SalesHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(InvDiscBaseAmount; "Inv. Disc. Base Amount")
                    {
                        AutoFormatExpression = SalesHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount_2; "Line Amount")
                    {
                        AutoFormatExpression = SalesHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATAmount; "VAT Amount")
                    {
                        AutoFormatExpression = SalesHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATBase; "VAT Base")
                    {
                        AutoFormatExpression = SalesHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATIdentifier_2; "VAT Identifier")
                    {
                    }
                    column(VATPerc; "VAT %")
                    {
                        DecimalPlaces = 0 : 5;
                    }

                    trigger OnPreDataItem();
                    begin
                        if wgTotVATAmount = 0 then
                            CurrReport.BREAK;

                        RESET;
                    end;
                }
                dataitem(VATAmtLineLCY; "VAT Amount Line")
                {
                    DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                    UseTemporary = true;
                    column(VALVATBaseLCY; wgVALVATBaseLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATAmountLCY; wgVALVATAmountLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VATIdentifier_3; "VAT Identifier")
                    {
                    }
                    column(VATPerc_2; "VAT %")
                    {
                        DecimalPlaces = 0 : 5;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        wgVALVATBaseLCY :=
                          VATAmtLine.GetBaseLCY(
                            SalesHdr."Posting Date", SalesHdr."Currency Code", SalesHdr."Currency Factor");
                        wgVALVATAmountLCY :=
                          VATAmtLine.GetAmountLCY(
                            SalesHdr."Posting Date", SalesHdr."Currency Code", SalesHdr."Currency Factor");

                        wgTotVALVATBaseLCY += wgVALVATBaseLCY;
                        wgTotVALVATAmountLCY += wgVALVATAmountLCY;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not wgShowVATLCY then
                            CurrReport.BREAK;

                        VATAmtLineLCY.COPY(VATAmtLine, true); //Set VATAmtLineLCY to VATAmtLine
                        RESET;
                    end;
                }
                dataitem(Total; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(MonolithicVAT; wgMonolithicVAT)
                    {
                    }
                    column(NoOfVATAmtLines; wgNoOfVATAmountLines)
                    {
                    }
                    column(TotAmount; wgTotAmount)
                    {
                        AutoFormatExpression = SalesHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotInvDiscAmount; wgTotInvDiscAmount)
                    {
                    }
                    column(TotInvDiscBaseAmount; wgTotInvDiscBaseAmount)
                    {
                    }
                    column(TotLineAmount; wgTotLineAmount)
                    {
                    }
                    column(TotPaymentDiscOnVAT; wgTotPaymentDiscOnVAT)
                    {
                        AutoFormatExpression = SalesHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotVATAmount; wgTotVATAmount)
                    {
                        AutoFormatExpression = SalesHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATAmtText; wgVATAmountText)
                    {
                    }
                    column(TotVALVATBaseLCY; wgTotVALVATBaseLCY)
                    {
                    }
                    column(TotVALVATAmountLCY; wgTotVALVATAmountLCY)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        wgNoOfVATAmountLines := VATAmtLine.COUNT;
                        //wgMonolithicVAT := wgCduDocCreatorReportFunctions.wgFncIsMonolithicVAT(VATAmtLine);//Krishna
                        if wgMonolithicVAT then
                            wgVATAmountText := STRSUBSTNO(Trl('TotalVATAmount%1Perc'), VATAmtLine."VAT %")
                        else
                            wgVATAmountText := Trl('TotalVATAmount');
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        wgCopyText := Trl('Copy');
                        wgOutputNo += 1;
                    end;
                    //CurrReport.PAGENO := 1;

                    wgTotVALVATBaseLCY := 0;
                    wgTotVALVATAmountLCY := 0;
                end;

                trigger OnPostDataItem();
                begin
                    if wgPrint then
                        CODEUNIT.RUN(CODEUNIT::"Sales-Printed", SalesHdr);
                end;

                trigger OnPreDataItem();
                begin
                    wgNoOfLoops := ABS(wgNoOfCopies) + 1;
                    wgCopyText := '';
                    SETRANGE(Number, 1, wgNoOfLoops);
                    wgOutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord();
            var
                wlCduSalesPost: Codeunit "Sales-Post";
                wlRecRef: RecordRef;
            begin
                //CurrReport.LANGUAGE := wgRecLanguage.GetLanguageID("Language Code");//Krishna
                //wgCduDocCreatorTransLationMgt.wgSetLanguageCode("Language Code");//Krishna

                wlFncFormatAddressFields(SalesHdr);
                wlFncFormatDocumentFields(SalesHdr);

                if wgPrint then begin
                    if CurrReport.USEREQUESTPAGE and wgArchiveDocument or
                       not CurrReport.USEREQUESTPAGE and (wgRecSalesSetup."Archive Orders") //"Archive Quotes and Orders"//Krishna
                    then
                        wgCduArchiveManagement.StoreSalesDocument(SalesHdr, wgLogInteraction);

                    if wgLogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            wgCduSegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",     //1 = Sales Qte.
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            wgCduSegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",    //1 = Sales Qte.
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    end;
                end;

                //Get Sales Lines
                CLEAR(wlCduSalesPost);
                SalesLine.RESET;
                SalesLine.DELETEALL;
                VATAmtLine.RESET;
                VATAmtLine.DELETEALL;
                wlCduSalesPost.GetSalesLines(SalesHdr, SalesLine, 0);  //0 = General

                //Get VAT Amount Lines
                SalesLine.CalcVATAmountLines(0, SalesHdr, SalesLine, VATAmtLine); //0 = General
                SalesLine.UpdateVATOnLines(0, SalesHdr, SalesLine, VATAmtLine);   //0 = General

                wgTotInvDiscAmount := VATAmtLine.GetTotalInvDiscAmount;
                wgTotInvDiscBaseAmount := VATAmtLine.GetTotalInvDiscBaseAmount(SalesHdr."Prices Including VAT", SalesHdr."Currency Code");
                wgTotLineAmount := VATAmtLine.GetTotalLineAmount(SalesHdr."Prices Including VAT", SalesHdr."Currency Code");
                wgTotVATAmount := VATAmtLine.GetTotalVATAmount;
                wgTotPaymentDiscOnVAT := -(wgTotLineAmount - wgTotInvDiscAmount - VATAmtLine.GetTotalAmountInclVAT);
                wgTotAmount := VATAmtLine.GetTotalVATBase;

                //Prepare VAT Amount Lines LCY
                if (not wgRecGLSetup."Print VAT specification in LCY") or
                   (SalesHdr."Currency Code" = '') or
                   (VATAmtLine.GetTotalVATAmount = 0)
                then begin
                    wgShowVATLCY := false;
                    wgVALSpecLCYHeader := '';
                    wgVALExchRate := '';
                end
                else begin
                    wgShowVATLCY := true;
                    if wgRecGLSetup."LCY Code" = '' then
                        wgVALSpecLCYHeader := Trl('VATAmtSpecIn') + ' ' + Trl('LocalCurrency')
                    else
                        wgVALSpecLCYHeader := Trl('VATAmtSpecIn') + ' ' + FORMAT(wgRecGLSetup."LCY Code");
                    wgRecCurrExchRate.FindCurrency(SalesHdr."Posting Date", SalesHdr."Currency Code", 1);
                    wgVALExchRate := STRSUBSTNO(Trl('ExchangeRate%1/%2'), wgRecCurrExchRate."Relational Exch. Rate Amount", wgRecCurrExchRate."Exchange Rate Amount");
                end;

                //Set HideLineDiscount
                wlRecRef.GETTABLE(SalesHdr);
                //wgHideLineDiscount := wgCduDocCreatorReportFunctions.wgFncHideLineDiscount(wlRecRef);//Krishna
                MARK(true);
            end;

            trigger OnPostDataItem();
            var
                wlRecToDo: Record "To-do";
                wlCduFileManagement: Codeunit "File Management";
            begin
                MARKEDONLY := true;
                COMMIT;
                CurrReport.LANGUAGE := GLOBALLANGUAGE;
                //                if not wlCduFileManagement.IsWebClient then //Krishna
                if (CurrentClientType = ClientType::Web) then//krishna
                    if (wgNoOfRecords = 1) and wgPrint then
                        if wlRecToDo.WRITEPERMISSION and FINDFIRST then
                            if CONFIRM(wgCtx001) then
                                CreateTask;
            end;

            trigger OnPreDataItem();
            begin
                wgNoOfRecords := COUNT;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; wgNoOfCopies)
                    {
                        Caption = 'No. of Copies';
                        ApplicationArea = All;
                    }
                    field(ShowInternalInfo; wgShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = All;
                    }
                    field(ArchiveDocument; wgArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if not wgArchiveDocument then
                                wgLogInteraction := false;
                        end;
                    }
                    field(LogInteraction; wgLogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = wgLogInteractionEnable;
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            if wgLogInteraction then
                                wgArchiveDocument := wgArchiveDocumentEnable;
                        end;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            wgLogInteractionEnable := true;
        end;

        trigger OnOpenPage();
        begin
            //CODEUNIT.RUN(CODEUNIT::wDocCreatorForcePrinterDialog);//Krishna //DR004AB.n Always Run Printer Selection after Request Page
            //wgArchiveDocument := wgRecSalesSetup."Archive Quotes and Orders";//Krishna
            wgLogInteraction := wgCduSegManagement.FindInteractTmplCode(1) <> '';

            wgLogInteractionEnable := wgLogInteraction;

            wgNoOfCopies := 0;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        wgRecGLSetup.GET;

        wgRecSalesSetup.GET;

        wgRecCompanyInfo.GET;

        if wgRecSalesSetup."Logo Position on Documents" <> wgRecSalesSetup."Logo Position on Documents"::"No Logo" then
            wgRecCompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport();
    begin
        wgPrint := wgPrint or not CurrReport.PREVIEW;

        if CurrReport.USEREQUESTPAGE = false then
            wgNoOfCopies := 0;
    end;

    var
        wgRecLanguage: Record Language;
        wgRecSalesPurchPerson: Record "Salesperson/Purchaser";
        wgRecCompanyInfo: Record "Company Information";
        wgRecGLSetup: Record "General Ledger Setup";
        wgRecSalesSetup: Record "Sales & Receivables Setup";
        wgRecCurrExchRate: Record "Currency Exchange Rate";
        wgCduFormatAddr: Codeunit "Format Address";
        wgCduFormatDoc: Codeunit "Format Document";
        wgCduSegManagement: Codeunit SegManagement;
        wgCduArchiveManagement: Codeunit ArchiveManagement;
        //wgCduDocCreatorTransLationMgt: Codeunit wDocCreatorTranslationMgt;//Krishna
        //wgCduDocCreatorReportFunctions: Codeunit wDocCreatorReportFunctions;//Krishna
        wgCompanyAddr: array[8] of Text[50];
        wgCompanyInfoFaxNo: Text;
        wgCompanyInfoPhoneNo: Text;
        wgCopyText: Text[30];
        wgCustAddr: array[8] of Text[50];
        wgDimText: Text[120];
        wgShipToAddr: array[8] of Text[50];
        wgTotalExclVATText: Text[50];
        wgTotalInclVATText: Text[50];
        wgTotalText: Text[50];
        wgVALExchRate: Text[50];
        wgVALSpecLCYHeader: Text[80];
        wgVATAmountText: Text[30];
        wgTotAmount: Decimal;
        wgTotInvDiscAmount: Decimal;
        wgTotInvDiscBaseAmount: Decimal;
        wgTotLineAmount: Decimal;
        wgTotPaymentDiscOnVAT: Decimal;
        wgTotVALVATAmountLCY: Decimal;
        wgTotVALVATBaseLCY: Decimal;
        wgTotVATAmount: Decimal;
        wgVALVATAmountLCY: Decimal;
        wgVALVATBaseLCY: Decimal;
        wgNoOfCopies: Integer;
        wgNoOfLoops: Integer;
        wgNoOfRecords: Integer;
        wgNoOfVATAmountLines: Integer;
        wgOutputNo: Integer;
        wgReportId: Integer;
        wgArchiveDocument: Boolean;
        [InDataSet]
        wgArchiveDocumentEnable: Boolean;
        wgHideLineDiscount: Boolean;
        wgLogInteraction: Boolean;
        [InDataSet]
        wgLogInteractionEnable: Boolean;
        wgMonolithicVAT: Boolean;
        wgPrint: Boolean;
        wgShowInternalInfo: Boolean;
        wgShowShippingAddr: Boolean;
        wgShowVATLCY: Boolean;
        wgCtx001: Label 'Do you want to create a follow-up to-do?';

    local procedure Trl(pLblName: Text): Text;
    begin
        /*if wgReportId = 0 then begin
            EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(false), '=', DELCHR(CurrReport.OBJECTID(false), '=', '1234567890')));
            //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        end;
        exit(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));*/
        exit(pLblName);
    end;

    procedure InitializeRequest(pNoOfCopiesFrom: Integer; pShowInternalInfoFrom: Boolean; pArchiveDocumentFrom: Boolean; pLogInteractionFrom: Boolean; pPrintFrom: Boolean);
    begin
        wgNoOfCopies := pNoOfCopiesFrom;
        wgShowInternalInfo := pShowInternalInfoFrom;
        wgArchiveDocument := pArchiveDocumentFrom;
        wgLogInteraction := pLogInteractionFrom;
        wgPrint := pPrintFrom;
    end;

    local procedure wlFncFormatDocumentFields(pRecSalesHeader: Record "Sales Header");
    var
        wlSalesPersonText: Text[30];
        wlCurrencyCode: Code[10];
    begin
        wlCurrencyCode := pRecSalesHeader."Currency Code";
        if wlCurrencyCode = '' then begin
            wgRecGLSetup.TESTFIELD("LCY Code");
            wlCurrencyCode := wgRecGLSetup."LCY Code";
        end;
        wgTotalText := STRSUBSTNO(Trl('Total%1'), wlCurrencyCode);
        wgTotalInclVATText := STRSUBSTNO(Trl('Total%1InclVAT'), wlCurrencyCode);
        wgTotalExclVATText := STRSUBSTNO(Trl('Total%1ExclVAT'), wlCurrencyCode);
        wgCduFormatDoc.SetSalesPerson(wgRecSalesPurchPerson, pRecSalesHeader."Salesperson Code", wlSalesPersonText);
    end;

    local procedure wlFncFormatAddressFields(var vRecSalesHeader: Record "Sales Header");
    var
        wlRecRespCenter: Record "Responsibility Center";
    begin
        wgCduFormatAddr.GetCompanyAddr(vRecSalesHeader."Responsibility Center", wlRecRespCenter, wgRecCompanyInfo, wgCompanyAddr);
        wgCompanyInfoPhoneNo := wgRecCompanyInfo."Phone No.";
        wgCompanyInfoFaxNo := wgRecCompanyInfo."Fax No.";
        wgCduFormatAddr.SalesHeaderBillTo(wgCustAddr, vRecSalesHeader);
        wgShowShippingAddr := wgCduFormatAddr.SalesHeaderShipTo(wgShipToAddr, wgCustAddr, vRecSalesHeader);
    end;
}

