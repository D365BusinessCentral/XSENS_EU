report 50001 "Sales - Order Confirm XSS DCR"
{
    // version DCR3.45.100.01,XSS5.094

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
    // 
    // 20190212 KBG NMSD-288: Function fUpdateDateOrderConfimation added.
    // 20191007 KBG NMSD-2422: CompanyInfo added.

    Caption = 'Sales - Order Confirmation';
    PreviewMode = PrintLayout;
    UseRequestPage = true;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Report50001\Report50001.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(SalesHdr; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';
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
            column(lblInvoiceDate; Trl('InvoiceDate'))
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
            column(lblLotNo; Trl('LotNo'))
            {
            }
            column(lblNo; Trl('No'))
            {
            }
            column(lblOrderNo; Trl('Order No.'))
            {
            }
            column(lblPageOf; Trl('Page%1of%2'))
            {
            }
            column(lblPaymentDiscountVAT; Trl('PaymentDiscountVAT'))
            {
            }
            column(lblPaymentTerms; Trl('Payment Terms'))
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
            column(lblSalesPerson; Trl('Salesperson'))
            {
            }
            column(lblSellToCustomerNo; Trl('SellToCustomerNo'))
            {
            }
            column(lblSerialNo; Trl('SerialNo'))
            {
            }
            column(lblShipment; Trl('Shipment'))
            {
            }
            column(lblShipmentDate; Trl('Shipment Date'))
            {
            }
            column(lblShipmentMethod; Trl('Shipment Method'))
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
            column(lblVATRegistrationNo; Trl('VAT Registration No.'))
            {
            }
            column(lblYourReference; Trl('Your Reference'))
            {
            }
            column(lblBIC; Trl('BIC'))
            {
            }
            column(lblPage; Trl('Page'))
            {
            }
            column(lblPaymentMethod; Trl('Payment Method'))
            {
            }
            column(lblTermsAndCond; Trl('TermsAndCond'))
            {
            }
            column(lblOrder; Trl('Order'))
            {
            }
            column(lblLine; Trl('Line'))
            {
            }
            column(LblComment; Trl('Comment'))
            {
            }
            column(lblProductNo; Trl('ProductNo'))
            {
            }
            column(lblTaxID; Trl('TaxID'))
            {
            }
            column(lblRoutingNo; Trl('RoutingNo'))
            {
            }
            column(lblLockbox; Trl('LockBox'))
            {
            }
            column(lblPaymentDiscountTax; Trl('PaymentDiscountTax'))
            {
            }
            column(lblQuoteNo; Trl('QuoteNo'))
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
            column(CompanyAddr7; wgCompanyAddr[7])
            {
            }
            column(CompanyAddr8; wgCompanyAddr[8])
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
            column(CompanyBankNameUSD; wgRecCompanyInfo."Bank Name USD")
            {
            }
            column(CompanyIBANUSD; wgRecCompanyInfo."IBAN USD")
            {
            }
            column(CompanySWIFTUSD; wgRecCompanyInfo."SWIFT Code USD")
            {
            }
            column(CompanyPaymentNote; wgRecCompanyInfo."Payment Note")
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
            column(DueDateText; FORMAT("Due Date", 0, '<Day> <Month Text> <Year4>'))
            {
            }
            column(DocumentDate; "Document Date")
            {
            }
            column(DocumentDateText; FORMAT("Document Date", 0, '<Day> <Month Text> <Year4>'))
            {
            }
            column(DocumentNo; "No.")
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
            column(PaymentTermsDesc; PaymentTermsG.Description) //"Payment Terms Code")//wgCduDocCreatorTransLationMgt.wgFncGetPaymTermsTrl("Payment Terms Code")//Krishna)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(PostingDateText; FORMAT("Posting Date", 0, '<Day> <Month Text> <Year4>'))
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
            column(ShipmentMethodDesc; ShipmentMethodG.Description) //"Shipment Method Code")//wgCduDocCreatorTransLationMgt.wgFncGetShipmMethodTrl("Shipment Method Code"))//Krishna)
            {
            }
            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(ShipToAddr2; ShipToAddr[2])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }
            column(ShipToAddrSet; wgShowShippingAddr)
            {
            }
            column(BillToAddr1; BillToAddr[1])
            {
            }
            column(BillToAddr2; BillToAddr[2])
            {
            }
            column(BillToAddr3; BillToAddr[3])
            {
            }
            column(BillToAddr4; BillToAddr[4])
            {
            }
            column(BillToAddr5; BillToAddr[5])
            {
            }
            column(BillToAddr6; BillToAddr[6])
            {
            }
            column(BillToAddr7; BillToAddr[7])
            {
            }
            column(BillToAddr8; BillToAddr[8])
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
            column(VATRegNo; CustomerG."VAT Registration No.") //"VAT Registration No.")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(SalesPurchPersonEMail; wgRecSalesPurchPerson."E-Mail")
            {
            }
            column(SellToCustAddr1; gTxtSellToCustAddr[1])
            {
            }
            column(SellToCustAddr2; gTxtSellToCustAddr[2])
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(USSalesordernumber; "US Sales Order No.")
            {
            }
            column(CompanyLocation; gIntCompanyLocation)
            {
            }
            // column(CompanyFederalIDNo; wgRecCompanyInfo."Federal ID No.")
            // {
            // }
            column(CompanyLockbox; wgRecCompanyInfo.Lockbox)
            {
            }
            column(RoutingNumber; gRecXSENSSetup."Routing number")
            {
            }
            column(QuoteNo; SalesHdr."External Document No.")
            {
            }
            //31.08.2021
            column(Sell_to_E_Mail; "Sell-to E-Mail") { }
            //01.09.2021
            column(TotLineAmount; wgTotLineAmount)
            {
            }
            column(VATAmtText; VATAmtLine.VATAmountText())
            {
            }
            column(ShipmentDate; FORMAT(SalesHdr."Shipment Date", 0, '<Day> <Month Text> <Year4>'))
            {
            }
            column(PaymentMethodDesc; PaymentMethodG.Description) //SalesHdr."Payment Method Code")//wgCduDocCreatorTransLationMgt.wgFncGetPaymTermsTrl(SalesHdr."Payment Method Code"))//Krishna)
            {
            }
            column(ShipmentMethodExternal; "Shipment Method Description")
            {
            }
            column(AmountInclVAT; "Amount Including VAT")
            {
            }
            column(VATAmount; VATAmtLine."VAT Amount")
            {
            }
            column(SalesForce_Comment; "SalesForce Comment")
            {
            }
            column(Sell_to_Contact; "Sell-to Contact")
            {
            }
            column(US_Sales_Order_No_; "US Sales Order No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(OutputNo; wgOutputNo)
                {
                }
                column(SalesOrderConfirmationTitle; STRSUBSTNO(Trl('SalesOrderConfirmation%1'), wgCopyText))
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
                    column(LineNo; "Line No.")
                    {
                    }
                    //09.09.2021
                    column(Sorting_No_; "Sorting No.")
                    {
                    }
                    column(Description2; SalesLine."Description 2")
                    {
                    }
                    column(PrintItemDescription2; gRecItem."Print Item Description 2")
                    {
                    }
                    //31.08.2021
                    column(TotalSubTotal; TotalSubTotal) { }
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
                    dataitem(AsmLine; "Assembly Line")
                    {
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        column(Description_3; Description)
                        {
                        }
                        column(LineNo_2; "No.")
                        {
                        }
                        column(Quantity_3; Quantity)
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(UOM_2; "Unit of Measure Code")//wgCduDocCreatorTransLationMgt.wgFncGetUnitOfMeaseTrl("Unit of Measure Code")//Krishna)
                        {
                            //DecimalPlaces = 0:5;
                        }
                        column(VariantCode; "Variant Code")
                        {
                            //DecimalPlaces = 0:5;
                        }

                        trigger OnPreDataItem();
                        begin
                            if not wgDisplayAssemblyInformation then
                                CurrReport.BREAK;
                            if not wgAsmInfoExistsForLine then
                                CurrReport.BREAK;
                            SETRANGE("Document Type", wgRecAsmHeader."Document Type");
                            SETRANGE("Document No.", wgRecAsmHeader."No.");
                        end;
                    }
                    dataitem(TrackingSpec; "Tracking Specification")
                    {
                        DataItemTableView = SORTING("Entry No.");
                        UseTemporary = true;
                        column(LotNo; "Lot No.")
                        {
                        }
                        column(SerialNo; "Serial No.")
                        {
                        }
                        column(Quantity_4; "Quantity (Base)")
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            if not wgShowLotSN then
                                CurrReport.BREAK;
                            RESET;
                            SETRANGE("Source Ref. No.", SalesLine."Line No.");
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if wgDisplayAssemblyInformation then
                            wgAsmInfoExistsForLine := SalesLine.AsmToOrderExists(wgRecAsmHeader);

                        if not SalesHdr."Prices Including VAT" and
                           (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                        then
                            SalesLine."Line Amount" := 0;

                        if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not wgShowInternalInfo) then
                            SalesLine."No." := '';

                        if Type = SalesLine.Type::Item then
                            gRecItem.GET(SalesLine."No.")
                        else
                            gRecItem.INIT;

                        //31.08.2021
                        TotalSubTotal += "Line Amount";
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

                        SETCURRENTKEY("Document No.", "Sorting No.", "Line No.");
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
                    // column(VATAmount; "VAT Amount")
                    // {
                    //     AutoFormatExpression = SalesHdr."Currency Code";
                    //     AutoFormatType = 1;
                    // }
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
                        CurrReport.BREAK; //GW
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
                        CurrReport.BREAK; //GW
                        if not wgShowVATLCY then
                            CurrReport.BREAK;

                        VATAmtLineLCY.COPY(VATAmtLine, true); //Set VATAmtLineLCY to VATAmtLine
                        RESET;
                    end;
                }
                dataitem(TermsAndConditions; "Integer")
                {
                    DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));
                    // column(PaymentMethodDesc; SalesHdr."Payment Method Code")//wgCduDocCreatorTransLationMgt.wgFncGetPaymTermsTrl(SalesHdr."Payment Method Code"))//Krishna)
                    // {
                    // }
                    column(SalesForceComment; SalesHdr."SalesForce Comment")
                    {
                    }
                    // column(ShipmentDate; FORMAT(SalesHdr."Shipment Date", 0, '<Day> <Month Text> <Year4>'))
                    // {
                    // }
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
                    // column(TotLineAmount; wgTotLineAmount)
                    // {
                    // }
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
                    // column(VATAmtText; wgVATAmountText)
                    // {
                    // }
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
                        //NM_BEGIN GW
                        case wgRecCompanyInfo."Company Location" of
                            wgRecCompanyInfo."Company Location"::Holland:
                                begin
                                    if wgMonolithicVAT then
                                        wgVATAmountText := STRSUBSTNO(Trl('Total VAT Amount %1 Perc'), VATAmtLine."VAT %")
                                    else
                                        wgVATAmountText := Trl('Total VAT Amount');
                                end;
                            wgRecCompanyInfo."Company Location"::"North America":
                                begin
                                    if wgMonolithicVAT then
                                        wgVATAmountText := STRSUBSTNO(Trl('Total Tax Amount %1 Perc'), VATAmtLine."VAT %")
                                    else
                                        wgVATAmountText := Trl('Total Tax Amount');
                                end;
                        end;
                        //NM_END
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        wgCopyText := Trl('Copy');
                        wgOutputNo += 1;
                    end;

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
                CountryRegionL: Record "Country/Region";
            begin
                //CurrReport.LANGUAGE := wgRecLanguage.GetLanguageID('ENU'); //GW//krishna
                //wgCduDocCreatorTransLationMgt.wgSetLanguageCode('ENU');    //GW//Krishna

                ShipToAddr[1] := SalesHdr."Ship-to Name";
                ShipToAddr[2] := SalesHdr."Ship-to Contact";
                ShipToAddr[3] := SalesHdr."Ship-to Address";
                ShipToAddr[4] := SalesHdr."Ship-to Address 2";
                ShipToAddr[5] := SalesHdr."Ship-to City";
                ShipToAddr[6] := SalesHdr."Ship-to County";
                ShipToAddr[7] := SalesHdr."Ship-to Post Code";
                Clear(CountryRegionL);
                if CountryRegionL.Get(SalesHdr."Ship-to Country/Region Code") then;
                ShipToAddr[8] := CountryRegionL.Name;

                BillToAddr[1] := SalesHdr."Bill-to Name";
                BillToAddr[2] := SalesHdr."Bill-to Contact";
                BillToAddr[3] := SalesHdr."Bill-to Address";
                BillToAddr[4] := SalesHdr."Bill-to Address 2";
                BillToAddr[5] := SalesHdr."Bill-to City";
                BillToAddr[6] := SalesHdr."Bill-to County";
                BillToAddr[7] := SalesHdr."Bill-to Post Code";
                Clear(CountryRegionL);
                if CountryRegionL.Get(SalesHdr."Bill-to Country/Region Code") then;
                BillToAddr[8] := CountryRegionL.Name;

                wlFncFormatAddressFields(SalesHdr);
                //wlFncFormatDocumentFields(SalesHdr);

                if wgPrint then begin
                    if wgArchiveDocument then
                        wgCduArchiveManagement.StoreSalesDocument(SalesHdr, wgLogInteraction);

                    if wgLogInteraction then begin
                        CALCFIELDS("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            wgCduSegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            wgCduSegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
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

                //Get Item Tracking
                TrackingSpec.RESET;
                TrackingSpec.DELETEALL;
                if wgShowLotSN then begin
                    wgCduItemTrackingDocMgt.SetRetrieveAsmItemTracking(true);
                    wgCduItemTrackingDocMgt.RetrieveDocumentItemTracking(TrackingSpec, SalesHdr."No.",
                        DATABASE::"Sales Header", SalesHdr."Document Type".AsInteger());
                end;

                //Set HideLineDiscount
                wlRecRef.GETTABLE(SalesHdr);
                ////wgHideLineDiscount := wgCduDocCreatorReportFunctions.wgFncHideLineDiscount(wlRecRef);//Krishna

                fUpdateDateOrderConfimation(SalesHdr);
                //09.09.2021
                Clear(ShipmentMethodG);
                if ShipmentMethodG.Get("Shipment Method Code") then;
                Clear(PaymentMethodG);
                if PaymentMethodG.Get("Payment Method Code") then;
                Clear(PaymentTermsG);
                if PaymentTermsG.Get("Payment Terms Code") then;
                Clear(CustomerG);
                if CustomerG.Get("Bill-to Customer No.") then;

                wlFncFormatDocumentFields(SalesHdr);
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
                    field(ShowLotSN; wgShowLotSN)
                    {
                        Caption = 'Show Serial/Lot Number';
                        Visible = false;
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
                    field(ShowAssemblyComponents; wgDisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components';
                        ApplicationArea = All;
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
            ////wgArchiveDocument := wgRecSalesSetup."Archive Quotes and Orders";//Krishna//Krishna
            wgLogInteraction := wgCduSegManagement.FindInteractTmplCode(3) <> '';

            wgLogInteraction := false; //AA102AF.n  No Log Interaction for Pilot Document

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

        gIntCompanyLocation := wgRecCompanyInfo."Company Location";
        //gRecXSENSSetup.GET;
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
        wgRecAsmHeader: Record "Assembly Header";
        wgCduFormatAddr: Codeunit "Format Address";
        wgCduFormatDoc: Codeunit "Format Document";
        wgCduSegManagement: Codeunit SegManagement;
        wgCduArchiveManagement: Codeunit ArchiveManagement;
        wgCduItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        //wgCduDocCreatorTransLationMgt: Codeunit wDocCreatorTranslationMgt;//Krishna
        //wgCduDocCreatorReportFunctions: Codeunit wDocCreatorReportFunctions;//Krishna
        wgCompanyAddr: array[8] of Text[50];
        wgCompanyInfoFaxNo: Text;
        wgCompanyInfoPhoneNo: Text;
        wgCopyText: Text[30];
        wgCustAddr: array[8] of Text[50];
        wgDimText: Text[120];
        wgShipToAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        BillToAddr: array[8] of Text[50];
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
        wgNoOfVATAmountLines: Integer;
        wgOutputNo: Integer;
        wgReportId: Integer;
        wgArchiveDocument: Boolean;
        [InDataSet]
        wgArchiveDocumentEnable: Boolean;
        wgAsmInfoExistsForLine: Boolean;
        wgDisplayAssemblyInformation: Boolean;
        wgHideLineDiscount: Boolean;
        wgLogInteraction: Boolean;
        [InDataSet]
        wgLogInteractionEnable: Boolean;
        wgMonolithicVAT: Boolean;
        wgPrint: Boolean;
        wgShowInternalInfo: Boolean;
        wgShowLotSN: Boolean;
        wgShowShippingAddr: Boolean;
        wgShowVATLCY: Boolean;
        gRecXSENSSetup: Record "XSENS Setup";
        gRecItem: Record Item;
        gTxtSellToCustAddr: array[8] of Text[50];
        gIntCompanyLocation: Integer;
        //31.08.2021
        TotalSubTotal: Decimal;
        //09.09.2021
        PaymentMethodG: Record "Payment Method";
        ShipmentMethodG: Record "Shipment Method";
        PaymentTermsG: Record "Payment Terms";
        Serial: Page "Posted Sales Shipment";
        CustomerG: Record Customer;

    local procedure Trl(pLblName: Text): Text;
    begin
        /*/*if wgReportId = 0 then begin
            EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(false), '=', DELCHR(CurrReport.OBJECTID(false), '=', '1234567890')));
            //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        end;
        exit(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));*/
        exit(pLblName);
    end;

    procedure InitializeRequest(pNoOfCopiesFrom: Integer; pShowInternalInfoFrom: Boolean; pArchiveDocumentFrom: Boolean; pLogInteractionFrom: Boolean; pPrintFrom: Boolean; pDisplayAsmInfo: Boolean);
    begin
        wgNoOfCopies := pNoOfCopiesFrom;
        wgShowInternalInfo := pShowInternalInfoFrom;
        wgArchiveDocument := pArchiveDocumentFrom;
        wgLogInteraction := pLogInteractionFrom;
        wgPrint := pPrintFrom;
        wgDisplayAssemblyInformation := pDisplayAsmInfo;
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
        //NM_BEGIN GW
        // case wgRecCompanyInfo."Company Location" of
        //     wgRecCompanyInfo."Company Location"::Holland:
        //         begin
        //             if wgTotVATAmount = 0 then
        //                 wgTotalInclVATText := STRSUBSTNO(Trl('Total %1'), wlCurrencyCode)
        //             else
        //                 wgTotalInclVATText := STRSUBSTNO(Trl('Total %1 Incl VAT.'), wlCurrencyCode);
        //             wgTotalExclVATText := STRSUBSTNO(Trl('Total %1 Excl VAT.'), wlCurrencyCode);
        //         end;
        //     wgRecCompanyInfo."Company Location"::"North America":
        //         begin
        //             if wgTotVATAmount = 0 then
        //                 wgTotalInclVATText := STRSUBSTNO(Trl('Total %1'), wlCurrencyCode)
        //             else
        //                 wgTotalInclVATText := STRSUBSTNO(Trl('Total %1 Incl Tax.'), wlCurrencyCode);
        //             wgTotalExclVATText := STRSUBSTNO(Trl('Total %1 Excl Tax.'), wlCurrencyCode);
        //         end;
        // end;
        //NM_END
        wgTotalInclVATText := STRSUBSTNO(Trl('Total %1 Incl VAT.'), wlCurrencyCode);
        if wgTotVATAmount = 0 then
            wgTotalExclVATText := STRSUBSTNO(Trl('Total %1'), wlCurrencyCode)
        else
            wgTotalExclVATText := STRSUBSTNO(Trl('Total %1 Excl VAT.'), wlCurrencyCode);
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
        //NM_BEGIN GW
        wgCduFormatAddr.FormatAddr(
  gTxtSellToCustAddr, vRecSalesHeader."Sell-to Customer Name", vRecSalesHeader."Sell-to Customer Name 2", vRecSalesHeader."Sell-to Contact", '', '',
  '', '', '', vRecSalesHeader."Sell-to Country/Region Code");
        //NM_END
    end;

    local procedure fUpdateDateOrderConfimation(pRecSalesHeader: Record "Sales Header");
    begin
        if pRecSalesHeader."Date Order confimation" <> 0D then exit;
        pRecSalesHeader."Date Order confimation" := WORKDATE;
        pRecSalesHeader.MODIFY;
    end;
}

