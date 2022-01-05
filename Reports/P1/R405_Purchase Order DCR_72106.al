report 72106 "R405 Purchase - Order DCR"
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

    Caption = 'Purchase - Order';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(PurchHdr; "Purchase Header")
        {
            DataItemTableView = SORTING("Document Type", "No.")
                                WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
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
            column(lblBuyFromAddress; Trl('BuyFromAddress'))
            {
            }
            column(lblBuyFromVendorNo; Trl('BuyFromVendorNo'))
            {
            }
            column(lblCompanyRegistrationNo; Trl('CompanyRegistrationNo'))
            {
            }
            column(lblDescription; Trl('Description'))
            {
            }
            column(lblDirectUnitCost; Trl('DirectUnitCost'))
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
            column(lblExpectedReceiptDate; Trl('ExpectedReceiptDate'))
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
            column(lblNo; Trl('No'))
            {
            }
            column(lblOrderNo; Trl('OrderNo'))
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
            column(lblPayToAddress; Trl('PayToVendorAddress'))
            {
            }
            column(lblPayToVendorNo; Trl('PayToVendorNo'))
            {
            }
            column(lblPhoneNo; Trl('PhoneNo'))
            {
            }
            column(lblPrepaymentPaymentTerms; Trl('PrepaymentPaymentTerms'))
            {
            }
            column(lblPrepaymentSpecification; Trl('PrepaymentSpecification'))
            {
            }
            column(lblPrepaymentVATSpecification; Trl('PrepaymentVATSpecification'))
            {
            }
            column(lblPricesInclVAT; Trl('PricesInclVAT'))
            {
            }
            column(lblPromisedReceiptDate; Trl('PromisedReceiptDate'))
            {
            }
            column(lblPurchPerson; Trl('PurchPerson'))
            {
            }
            column(lblQuantity; Trl('Quantity'))
            {
            }
            column(lblRequestedReceiptDate; Trl('RequestedReceiptDate'))
            {
            }
            column(lblShipment; Trl('Shipment'))
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
            column(BuyFromAddr1; wgBuyFromAddr[1])
            {
            }
            column(BuyFromAddr2; wgBuyFromAddr[2])
            {
            }
            column(BuyFromAddr3; wgBuyFromAddr[3])
            {
            }
            column(BuyFromAddr4; wgBuyFromAddr[4])
            {
            }
            column(BuyFromAddr5; wgBuyFromAddr[5])
            {
            }
            column(BuyFromAddr6; wgBuyFromAddr[6])
            {
            }
            column(BuyFromAddr7; wgBuyFromAddr[7])
            {
            }
            column(BuyFromAddr8; wgBuyFromAddr[8])
            {
            }
            column(BuyFromVendorNo; "Buy-from Vendor No.")
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
            column(DocumentDate; "Document Date")
            {
            }
            column(DocumentDateText; FORMAT("Document Date", 0, 4))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DueDate; "Due Date")
            {
            }
            column(DueDateText; FORMAT("Due Date", 0, 4))
            {
            }
            column(HideLineDiscount; wgHideLineDiscount)
            {
            }
            column(LanguageCode; "Language Code")
            {
            }
            column(PaymentTermsDesc; "Payment Terms Code")// "Payment Terms Code")//wgCduDocCreatorTransLationMgt.wgFncGetPaymTermsTrl("Payment Terms Code")//Krishna)
            {
            }
            column(PayToAddr1; wgPayToVendAddr[1])
            {
            }
            column(PayToAddr2; wgPayToVendAddr[2])
            {
            }
            column(PayToAddr3; wgPayToVendAddr[3])
            {
            }
            column(PayToAddr4; wgPayToVendAddr[4])
            {
            }
            column(PayToAddr5; wgPayToVendAddr[5])
            {
            }
            column(PayToAddr6; wgPayToVendAddr[6])
            {
            }
            column(PayToAddr7; wgPayToVendAddr[7])
            {
            }
            column(PayToAddr8; wgPayToVendAddr[8])
            {
            }
            column(PayToVendorNo; "Pay-to Vendor No.")
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(PostingDateText; FORMAT("Posting Date", 0, 4))
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
            column(ShipmentMethodDesc; "Shipment Method Code")/// "Shipment Method Code")//wgCduDocCreatorTransLationMgt.wgFncGetShipmMethodTrl("Shipment Method Code"))//Krishna)
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
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                column(OutputNo; wgOutputNo)
                {
                }
                column(PurchOrderTitle; STRSUBSTNO(Trl('PurchOrder%1'), wgCopyText))
                {
                }
                dataitem(HdrComment; "Purch. Comment Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "No." = FIELD("No.");
                    DataItemLinkReference = PurchHdr;
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                        WHERE("Document Line No." = CONST(0));
                    column(Comment_2; Comment)
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        IF NOT wgShowInternalInfo THEN
                            CurrReport.BREAK;
                    end;
                }
                dataitem(HeaderDim; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                    DataItemLinkReference = PurchHdr;
                    DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");
                    column(DimText; "Dimension Value Name")// wgDimText)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        // wgCduDocCreatorReportFunctions.wgFncGetDimText(HeaderDim, wgDimText);
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF NOT wgShowInternalInfo THEN
                            CurrReport.BREAK;
                    end;
                }
                dataitem(PurchLine; "Purchase Line")
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
                    column(DirectUnitCost; "Direct Unit Cost")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 2;
                    }
                    column(ExpectedReceiptDate; "Expected Receipt Date")
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
                    column(PromisedReceiptDate; "Promised Receipt Date")
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(RequestedReceiptDate; "Requested Receipt Date")
                    {
                    }
                    column(Type; FORMAT(Type))
                    {
                    }
                    column(TypeNo; Type.AsInteger() + 0)
                    {
                    }
                    column(UOM; "Unit of Measure")// "Unit of Measure Code")//wgCduDocCreatorTransLationMgt.wgFncGetUnitOfMeaseTrl("Unit of Measure Code")//Krishna)//krishna
                    {
                    }
                    column(VATIdentifier; "VAT Identifier")
                    {
                    }
                    dataitem(LineComment; "Sales Comment Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "No." = FIELD("Document No."),
                                       "Document Line No." = FIELD("Line No.");
                        DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.");
                        column(Comment; LineComment.Comment)
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            IF NOT wgShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(LineDim; "Dimension Set Entry")
                    {
                        DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                        DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");
                        column(DimText_2; "Dimension Value Name")//wgDimText)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //wgCduDocCreatorReportFunctions.wgFncGetDimText(LineDim, wgDimText);//Krishna
                        end;

                        trigger OnPreDataItem();
                        begin
                            IF NOT wgShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        IF NOT PurchHdr."Prices Including VAT" AND
                           (PurchLine."VAT Calculation Type" = PurchLine."VAT Calculation Type"::"Full VAT")
                        THEN
                            PurchLine."Line Amount" := 0;

                        IF (PurchLine.Type = PurchLine.Type::"G/L Account") AND (NOT wgShowInternalInfo) THEN
                            PurchLine."No." := '';
                    end;

                    trigger OnPreDataItem();
                    var
                        wlMoreLines: Boolean;
                    begin
                        RESET;
                        wlMoreLines := PurchLine.FIND('+');
                        WHILE wlMoreLines AND (PurchLine.Description = '') AND (PurchLine."Description 2" = '') AND
                              (PurchLine."No." = '') AND (PurchLine.Quantity = 0) AND
                              (PurchLine.Amount = 0)
                        DO
                            wlMoreLines := PurchLine.NEXT(-1) <> 0;
                        IF NOT wlMoreLines THEN
                            CurrReport.BREAK;
                        PurchLine.SETRANGE("Line No.", 0, PurchLine."Line No.");
                    end;
                }
                dataitem(VATAmtLine; "VAT Amount Line")
                {
                    DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                    UseTemporary = true;
                    column(InvDiscAmount_2; "Invoice Discount Amount")
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(InvDiscBaseAmount; "Inv. Disc. Base Amount")
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount_2; "Line Amount")
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATAmount; "VAT Amount")
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATBase; "VAT Base")
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
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
                        IF wgTotVATAmount = 0 THEN
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
                            PurchHdr."Posting Date", PurchHdr."Currency Code", PurchHdr."Currency Factor");
                        wgVALVATAmountLCY :=
                          VATAmtLine.GetAmountLCY(
                            PurchHdr."Posting Date", PurchHdr."Currency Code", PurchHdr."Currency Factor");

                        wgTotVALVATBaseLCY += wgVALVATBaseLCY;
                        wgTotVALVATAmountLCY += wgVALVATAmountLCY;
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF NOT wgShowVATLCY THEN
                            CurrReport.BREAK;

                        VATAmtLineLCY.COPY(VATAmtLine, TRUE); //Set VATAmtLineLCY to VATAmtLine
                        RESET;
                    end;
                }
                dataitem(Total; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(MonolithicVAT; wgMonolithicVAT)
                    {
                    }
                    column(NoOfVATAmtLines; wgNoOfVATAmountLines)
                    {
                    }
                    column(TotAmount; wgTotAmount)
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
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
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotVATAmount; wgTotVATAmount)
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
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
                        ////wgMonolithicVAT := wgCduDocCreatorReportFunctions.wgFncIsMonolithicVAT(VATAmtLine);//Krishna/Krishna
                        IF wgMonolithicVAT THEN
                            wgVATAmountText := STRSUBSTNO(Trl('TotalVATAmount%1Perc'), VATAmtLine."VAT %")
                        ELSE
                            wgVATAmountText := Trl('TotalVATAmount');
                    end;
                }
                dataitem(PrepmtLine; "Prepayment Inv. Line Buffer")
                {
                    DataItemTableView = SORTING(Adjustment);
                    UseTemporary = true;
                    column(LineAmount_3; wgPrepmtLineAmount)
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Description_2; Description)
                    {
                    }
                    column(GLAccountNo; "G/L Account No.")
                    {
                    }
                    column(Amount_2; Amount)
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    dataitem(PrepmtDim; "Dimension Set Entry")
                    {
                        DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                        DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");
                        column(DimText_3; "Dimension Value Name")//wgDimText)
                        {
                        }

                        trigger OnAfterGetRecord();
                        begin
                            //wgCduDocCreatorReportFunctions.wgFncGetDimText(PrepmtDim, wgDimText);//krishna
                        end;

                        trigger OnPreDataItem();
                        begin
                            IF NOT wgShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        IF PurchHdr."Prices Including VAT" THEN
                            wgPrepmtLineAmount := "Amount Incl. VAT"
                        ELSE
                            wgPrepmtLineAmount := Amount;
                    end;

                    trigger OnPreDataItem();
                    begin
                        RESET;
                    end;
                }
                dataitem(PrepmtVATAmtLine; "VAT Amount Line")
                {
                    DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                    UseTemporary = true;
                    column(VATAmount_2; "VAT Amount")
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATBase_2; "VAT Base")
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount_4; "Line Amount")
                    {
                        AutoFormatExpression = PurchHdr."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATPerc_3; "VAT %")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(VATIdentifier_4; "VAT Identifier")
                    {
                    }
                }
                dataitem(PrepmtTotal; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(TotPrepmtLineAMount; wgTotPrepmtLineAmount)
                    {
                    }
                    column(TotPrepmtVATAmount; wgTotPrepmtVATAmount)
                    {
                    }
                    column(TotPrepmtAmount; wgTotPrepmtAmount)
                    {
                    }
                    column(VATAmtText_2; wgVATAmountText)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        wgNoOfVATAmountLines := VATAmtLine.COUNT;
                        ////wgMonolithicVAT := wgCduDocCreatorReportFunctions.wgFncIsMonolithicVAT(VATAmtLine);//Krishna//Krishna
                        IF wgMonolithicVAT THEN
                            wgVATAmountText := STRSUBSTNO(Trl('TotalVATAmount%1Perc'), VATAmtLine."VAT %")
                        ELSE
                            wgVATAmountText := Trl('TotalVATAmount');
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number > 1 THEN BEGIN
                        wgCopyText := Trl('Copy');
                        wgOutputNo += 1;
                    END;

                    wgTotVALVATBaseLCY := 0;
                    wgTotVALVATAmountLCY := 0;
                end;

                trigger OnPostDataItem();
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        CODEUNIT.RUN(CODEUNIT::"Purch.Header-Printed", PurchHdr);
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
                wlRecTempPrepmtPurchLine: Record "Purchase Line" temporary;
                wlRecTempPurchLine: Record "Purchase Line" temporary;
                wlRecTempPrepmtVATAmountLineDeduct: Record 290 temporary;
                wlCduPurchPost: Codeunit 90;
                wlRecRef: RecordRef;
            begin
                //CurrReport.LANGUAGE := wgRecLanguage.GetLanguageID("Language Code");//Krishna
                CurrReport.LANGUAGE := wgRecLanguagecod.GetLanguageID("Language Code");//krishna
                //wgCduDocCreatorTransLationMgt.wgSetLanguageCode("Language Code");//krishna

                wlFncFormatAddressFields(PurchHdr);
                wlFncFormatDocumentFields(PurchHdr);

                IF NOT CurrReport.PREVIEW THEN BEGIN
                    IF wgArchiveDocument THEN
                        wgCduArchiveManagement.StorePurchDocument(PurchHdr, wgLogInteraction);

                    IF wgLogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        wgCduSegManagement.LogDocument(
                          13, "No.", "Doc. No. Occurrence", "No. of Archived Versions", DATABASE::Vendor, "Buy-from Vendor No.",
                          "Purchaser Code", '', "Posting Description", '');
                    END;
                END;

                //Get Purchase Lines
                CLEAR(wlCduPurchPost);
                PurchLine.RESET;
                PurchLine.DELETEALL;
                VATAmtLine.RESET;
                VATAmtLine.DELETEALL;
                wlCduPurchPost.GetPurchLines(PurchHdr, PurchLine, 0);  //0 = General

                //Get VAT Amount Lines
                PurchLine.CalcVATAmountLines(0, PurchHdr, PurchLine, VATAmtLine); //0 = General
                PurchLine.UpdateVATOnLines(0, PurchHdr, PurchLine, VATAmtLine);   //0 = General

                wgTotInvDiscAmount := VATAmtLine.GetTotalInvDiscAmount;
                wgTotInvDiscBaseAmount := VATAmtLine.GetTotalInvDiscBaseAmount(PurchHdr."Prices Including VAT", PurchHdr."Currency Code");
                wgTotLineAmount := VATAmtLine.GetTotalLineAmount(PurchHdr."Prices Including VAT", PurchHdr."Currency Code");
                wgTotVATAmount := VATAmtLine.GetTotalVATAmount;
                wgTotPaymentDiscOnVAT := -(wgTotLineAmount - wgTotInvDiscAmount - VATAmtLine.GetTotalAmountInclVAT);
                wgTotAmount := VATAmtLine.GetTotalVATBase;

                //Prepare VAT Amount Lines LCY
                IF (NOT wgRecGLSetup."Print VAT specification in LCY") OR
                   (PurchHdr."Currency Code" = '') OR
                   (VATAmtLine.GetTotalVATAmount = 0)
                THEN BEGIN
                    wgShowVATLCY := FALSE;
                    wgVALSpecLCYHeader := '';
                    wgVALExchRate := '';
                END
                ELSE BEGIN
                    wgShowVATLCY := TRUE;
                    IF wgRecGLSetup."LCY Code" = '' THEN
                        wgVALSpecLCYHeader := Trl('VATAmtSpecIn') + ' ' + Trl('LocalCurrency')
                    ELSE
                        wgVALSpecLCYHeader := Trl('VATAmtSpecIn') + ' ' + FORMAT(wgRecGLSetup."LCY Code");
                    wgRecCurrExchRate.FindCurrency(PurchHdr."Posting Date", PurchHdr."Currency Code", 1);
                    wgVALExchRate := STRSUBSTNO(Trl('ExchangeRate%1/%2'), wgRecCurrExchRate."Relational Exch. Rate Amount", wgRecCurrExchRate."Exchange Rate Amount");
                END;

                //Get Prepayment Lines
                PrepmtLine.RESET;
                PrepmtLine.DELETEALL;
                PrepmtVATAmtLine.RESET;
                PrepmtVATAmtLine.DELETEALL;
                wgCduPurchPostPrepmt.GetPurchLines(PurchHdr, 0, wlRecTempPrepmtPurchLine);    //0 = Invoice

                IF NOT wlRecTempPrepmtPurchLine.ISEMPTY THEN BEGIN
                    wgCduPurchPostPrepmt.GetPurchLinesToDeduct(PurchHdr, wlRecTempPurchLine);
                    IF NOT wlRecTempPurchLine.ISEMPTY THEN
                        wgCduPurchPostPrepmt.CalcVATAmountLines(PurchHdr, wlRecTempPurchLine, wlRecTempPrepmtVATAmountLineDeduct, 1);
                END;

                //Get Prepayment VAT Amount Lines
                wgCduPurchPostPrepmt.CalcVATAmountLines(PurchHdr, wlRecTempPrepmtPurchLine, PrepmtVATAmtLine, 0);
                // PrepmtVATAmtLine.DeductVATAmountLine(wlRecTempPrepmtVATAmountLineDeduct);
                // Note: "VAT Amount Line".DeductVATAmountLine is not available in NAVW1 CU1, replaced by local function:
                DeductVATAmountLine(PrepmtVATAmtLine, wlRecTempPrepmtVATAmountLineDeduct);

                wgCduPurchPostPrepmt.UpdateVATOnLines(PurchHdr, wlRecTempPrepmtPurchLine, PrepmtVATAmtLine, 0);
                //wgCduPurchPostPrepmt.BuildInvLineBuffer2(PurchHdr, wlRecTempPrepmtPurchLine, 0, PrepmtLine);//Krishna 
                wgCduPurchPostPrepmt.BuildInvLineBuffer(PurchHdr, wlRecTempPrepmtPurchLine, 0, PrepmtLine);//Krishna

                wgTotPrepmtLineAmount := VATAmtLine.GetTotalLineAmount(PurchHdr."Prices Including VAT", PurchHdr."Currency Code");
                wgTotPrepmtVATAmount := VATAmtLine.GetTotalVATAmount;
                wgTotPrepmtAmount := PrepmtVATAmtLine.GetTotalVATBase;


                //Set HideLineDiscount
                wlRecRef.GETTABLE(PurchHdr);
                ////wgHideLineDiscount := wgCduDocCreatorReportFunctions.wgFncHideLineDiscount(wlRecRef);//Krishna//Krishna
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
                            IF NOT wgArchiveDocument THEN
                                wgLogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; wgLogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = wgLogInteractionEnable;
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            IF wgLogInteraction THEN
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
            wgLogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage();
        begin
            ////CODEUNIT.RUN(CODEUNIT::wDocCreatorForcePrinterDialog);//Krishna //DR004AB.n Always Run Printer Selection after Request Page?//krishna
            //wgArchiveDocument := wgRecPurchSetup."Archive Quotes and Orders";//Krishna 
            wgArchiveDocument := (wgRecPurchSetup."Archive Quotes" <> wgRecPurchSetup."Archive Quotes"::Never) OR (wgRecPurchSetup."Archive Orders");//Krishna
            wgLogInteraction := wgCduSegManagement.FindInteractTmplCode(13) <> '';

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

        wgRecPurchSetup.GET;

        wgRecCompanyInfo.GET;
        wgRecCompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport();
    begin
        IF CurrReport.USEREQUESTPAGE = FALSE THEN
            wgNoOfCopies := 0;
    end;

    var
        wgRecLanguage: Record Language;
        wgRecLanguageCod: Codeunit Language;
        wgRecSalesPurchPerson: Record "Salesperson/Purchaser";
        wgRecCompanyInfo: Record "Company Information";
        wgRecGLSetup: Record "General Ledger Setup";
        wgRecPurchSetup: Record "Purchases & Payables Setup";
        wgRecCurrExchRate: Record "Currency Exchange Rate";
        wgCduFormatAddr: Codeunit "Format Address";
        wgCduFormatDoc: Codeunit "Format Document";
        wgCduPurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        wgCduSegManagement: Codeunit SegManagement;
        wgCduArchiveManagement: Codeunit ArchiveManagement;
        // wgCduDocCreatorTransLationMgt: Codeunit "11249655";
        // wgCduDocCreatorReportFunctions: Codeunit "11249656";
        wgBuyFromAddr: array[8] of Text[50];
        wgCompanyAddr: array[8] of Text[50];
        wgCompanyInfoFaxNo: Text;
        wgCompanyInfoPhoneNo: Text;
        wgCopyText: Text[30];
        wgDimText: Text[120];
        wgPayToVendAddr: array[8] of Text[50];
        wgShipToAddr: array[8] of Text[50];
        wgTotalExclVATText: Text[50];
        wgTotalInclVATText: Text[50];
        wgTotalText: Text[50];
        wgVALExchRate: Text[50];
        wgVALSpecLCYHeader: Text[80];
        wgVATAmountText: Text[30];
        wgPrepmtLineAmount: Decimal;
        wgTotAmount: Decimal;
        wgTotInvDiscAmount: Decimal;
        wgTotInvDiscBaseAmount: Decimal;
        wgTotLineAmount: Decimal;
        wgTotPaymentDiscOnVAT: Decimal;
        wgTotPrepmtAmount: Decimal;
        wgTotPrepmtLineAmount: Decimal;
        wgTotPrepmtVATAmount: Decimal;
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
        wgHideLineDiscount: Boolean;
        wgLogInteraction: Boolean;
        [InDataSet]
        wgLogInteractionEnable: Boolean;
        wgMonolithicVAT: Boolean;
        wgShowInternalInfo: Boolean;
        wgShowVATLCY: Boolean;

    local procedure Trl(pLblName: Text): Text;
    begin
        // IF wgReportId = 0 THEN BEGIN//Krishna
        //     EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(FALSE), '=', DELCHR(CurrReport.OBJECTID(FALSE), '=', '1234567890')));
        //     //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        // END;
        // EXIT(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));
        exit(pLblName);//krishna
    end;

    procedure InitializeRequest(pNoOfCopiesFrom: Integer; pShowInternalInfoFrom: Boolean; pArchiveDocumentFrom: Boolean; pLogInteractionFrom: Boolean);
    begin
        wgNoOfCopies := pNoOfCopiesFrom;
        wgShowInternalInfo := pShowInternalInfoFrom;
        wgArchiveDocument := pArchiveDocumentFrom;
        wgLogInteraction := pLogInteractionFrom;
    end;

    procedure DeductVATAmountLine(var VATAmounLine: Record "VAT Amount Line"; var VATAmountLineDeduct: Record "VAT Amount Line");
    begin
        // TEMPORARY
        // According "VAT Amount Line".DeductVATAmountLine wich is not available in NAVW1 CU1
        // Note: If available "VAT Amount Line".DeductVATAmountLine can be use instead
        //WITH VATAmounLine DO BEGIN
        IF VATAmounLine.FINDSET THEN
            REPEAT
                VATAmountLineDeduct := VATAmounLine;
                IF VATAmountLineDeduct.FIND THEN BEGIN
                    VATAmounLine."VAT Base" -= VATAmountLineDeduct."VAT Base";
                    VATAmounLine."VAT Amount" -= VATAmountLineDeduct."VAT Amount";
                    VATAmounLine."Amount Including VAT" -= VATAmountLineDeduct."Amount Including VAT";
                    VATAmounLine."Line Amount" -= VATAmountLineDeduct."Line Amount";
                    VATAmounLine."Inv. Disc. Base Amount" -= VATAmountLineDeduct."Inv. Disc. Base Amount";
                    VATAmounLine."Invoice Discount Amount" -= VATAmountLineDeduct."Invoice Discount Amount";
                    VATAmounLine."Calculated VAT Amount" -= VATAmountLineDeduct."Calculated VAT Amount";
                    VATAmounLine."VAT Difference" -= VATAmountLineDeduct."VAT Difference";
                    VATAmounLine.MODIFY;
                END;
            UNTIL VATAmounLine.NEXT = 0;
        //END;
    end;

    local procedure wlFncFormatDocumentFields(pRecPurchHeader: Record "Purchase Header");
    var
        wlPurchPersonText: Text[30];
        wlCurrencyCode: Code[10];
    begin
        //WITH pRecPurchHeader DO BEGIN
        wlCurrencyCode := pRecPurchHeader."Currency Code";
        IF wlCurrencyCode = '' THEN BEGIN
            wgRecGLSetup.TESTFIELD("LCY Code");
            wlCurrencyCode := wgRecGLSetup."LCY Code";
        END;
        wgTotalText := STRSUBSTNO(Trl('Total%1'), wlCurrencyCode);
        wgTotalInclVATText := STRSUBSTNO(Trl('Total%1InclVAT'), wlCurrencyCode);
        wgTotalExclVATText := STRSUBSTNO(Trl('Total%1ExclVAT'), wlCurrencyCode);
        wgCduFormatDoc.SetPurchaser(wgRecSalesPurchPerson, pRecPurchHeader."Purchaser Code", wlPurchPersonText);
        //END;
    end;

    local procedure wlFncFormatAddressFields(var vRecPurchHeader: Record "Purchase Header");
    var
        wlRecRespCenter: Record "Responsibility Center";
    begin
        wgCduFormatAddr.GetCompanyAddr(vRecPurchHeader."Responsibility Center", wlRecRespCenter, wgRecCompanyInfo, wgCompanyAddr);
        wgCompanyInfoPhoneNo := wgRecCompanyInfo."Phone No.";
        wgCompanyInfoFaxNo := wgRecCompanyInfo."Fax No.";
        wgCduFormatAddr.PurchHeaderPayTo(wgPayToVendAddr, vRecPurchHeader);
        wgCduFormatAddr.PurchHeaderShipTo(wgShipToAddr, vRecPurchHeader);
        wgCduFormatAddr.PurchHeaderBuyFrom(wgBuyFromAddr, vRecPurchHeader);
    end;
}

