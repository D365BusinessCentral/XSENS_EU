report 72141 "R6636 Purchase - RetShipmt DCR"
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

    Caption = 'Purchase - Return Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(ShptHdr; "Return Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Posted Return Shipment';
            column(lblBankAccNo; Trl('BankAccNo'))
            {
            }
            column(lblBankName; Trl('BankName'))
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
            column(lblLineDimensions; Trl('LineDimensions'))
            {
            }
            column(lblLotNo; Trl('LotNo'))
            {
            }
            column(lblNo; Trl('No'))
            {
            }
            column(lblPageOf; Trl('Page{0}of{1}'))
            {
            }
            column(lblPhoneNo; Trl('PhoneNo'))
            {
            }
            column(lblPayToAddress; Trl('PayToVendorAddress'))
            {
            }
            column(lblPayToVendorNo; Trl('PayToVendorNo'))
            {
            }
            column(lblPostingDate; Trl('PostingDate'))
            {
            }
            column(lblPurchPerson; Trl('PurchPerson'))
            {
            }
            column(lblQuantity; Trl('Quantity'))
            {
            }
            column(lblReturnOrderNo; Trl('ReturnOrderNo'))
            {
            }
            column(lblReturnShipmentNo; Trl('ReturnShipmentNo'))
            {
            }
            column(lblShipment; Trl('Shipment'))
            {
            }
            column(lblSerialNo; Trl('SerialNo'))
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
            column(lblUOM; Trl('UOM'))
            {
            }
            column(lblVATRegistrationNo; Trl('VATRegistrationNo'))
            {
            }
            column(lblYourReference; Trl('YourReference'))
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
            column(LanguageCode; "Language Code")
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
            column(SalesPurchPersonName; wgRecSalesPurchPerson.Name)
            {
            }
            column(ShipmentMethodDesc; "Shipment Method Code")//"Shipment Method Code")//wgCduDocCreatorTransLationMgt.wgFncGetShipmMethodTrl("Shipment Method Code"))//Krishna)//krishna
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
            column(ShowCorrectionLines; wgShowCorrectionLines)
            {
            }
            column(ShowInternalInfo; wgShowInternalInfo)
            {
            }
            column(ShowLotSN; wgShowLotSN)
            {
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
                column(PurchReturnShipmentTitle; STRSUBSTNO(Trl('PurchReturnShipment%1'), wgCopyText))
                {
                }
                dataitem(HdrComment; "Purch. Comment Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = ShptHdr;
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                        WHERE("Document Type" = CONST("Posted Return Shipment"),
                                              "Document Line No." = CONST(0));
                    column(Comment; Comment)
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
                    DataItemLinkReference = ShptHdr;
                    DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");
                    column(DimText; "Dimension Value Name")//wgDimText)//Krishna
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        // wgCduDocCreatorReportFunctions.wgFncGetDimText(HeaderDim, wgDimText);//Krishna
                    end;

                    trigger OnPreDataItem();
                    begin
                        IF NOT wgShowInternalInfo THEN
                            CurrReport.BREAK;
                    end;
                }
                dataitem(ShptLine; "Return Shipment Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemLinkReference = ShptHdr;
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    column(Description; Description)
                    {
                    }
                    column(LineNo; "Line No.")
                    {
                    }
                    column(No_2; "No.")
                    {
                    }
                    column(Quantity; Quantity)
                    {
                    }
                    column(Type; FORMAT(Type))
                    {
                    }
                    column(TypeNo; Type.AsInteger() + 0)
                    {
                    }
                    column(UOM; "Unit of Measure Code")//"Unit of Measure Code")//wgCduDocCreatorTransLationMgt.wgFncGetUnitOfMeaseTrl("Unit of Measure Code")//Krishna)//Krishna
                    {
                    }
                    dataitem(LineComment; "Purch. Comment Line")
                    {
                        DataItemLink = "No." = FIELD("Document No."),
                                       "Document Line No." = FIELD("Line No.");
                        DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.")
                                            WHERE("Document Type" = CONST("Posted Return Shipment"));
                        column(Comment_2; LineComment.Comment)
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
                        column(DimText_2; "Dimension Value Name")//wgDimText)//Krishna
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

                        trigger OnAfterGetRecord();
                        begin
                            wgTotalTrackingQty += TrackingSpec."Quantity (Base)";
                        end;

                        trigger OnPreDataItem();
                        begin
                            IF NOT wgShowLotSN THEN
                                CurrReport.BREAK;

                            RESET;
                            SETRANGE("Source Ref. No.", ShptLine."Line No.");
                            wgTotalTrackingQty := 0;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        IF NOT wgShowCorrectionLines AND Correction THEN
                            CurrReport.SKIP;
                    end;

                    trigger OnPreDataItem();
                    var
                        wlMoreLines: Boolean;
                    begin
                        wlMoreLines := ShptLine.FIND('+');
                        WHILE wlMoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
                            wlMoreLines := NEXT(-1) <> 0;
                        IF NOT wlMoreLines THEN
                            CurrReport.BREAK;
                        SETRANGE("Line No.", 0, "Line No.");
                    end;
                }
                dataitem(Total; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(TotalTrackingQty; wgTotalTrackingQty)
                    {
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    IF Number > 1 THEN BEGIN
                        wgCopyText := Trl('Copy');
                        wgOutputNo += 1;
                    END;
                end;

                trigger OnPostDataItem();
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        wgCduRcptCountPrinted.RUN(ShptHdr);
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
            begin
                //CurrReport.LANGUAGE := wgRecLanguage.GetLanguageID("Language Code");//Krishna
                CurrReport.LANGUAGE := wgRecLanguageCod.GetLanguageID("Language Code");
                //wgCduDocCreatorTransLationMgt.wgSetLanguageCode("Language Code");//Krishna

                wlFncFormatDocumentFields(ShptHdr);
                wlFncFormatAddressFields(ShptHdr);

                IF wgLogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        wgCduSegManagement.LogDocument(
                          21, "No.", 0, 0, DATABASE::Vendor, "Buy-from Vendor No.", "Purchaser Code", '', "Posting Description", '');

                // Get Item Tracking
                TrackingSpec.RESET;
                TrackingSpec.DELETEALL;
                IF wgShowLotSN THEN BEGIN
                    wgCduItemTrackingDocMgt.SetRetrieveAsmItemTracking(FALSE);
                    wgCduItemTrackingDocMgt.RetrieveDocumentItemTracking(TrackingSpec, ShptHdr."No.",
                        DATABASE::"Return Shipment Header", 0);
                END;
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
                    field(LogInteraction; wgLogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = wgLogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field("Show Correction Lines"; wgShowCorrectionLines)
                    {
                        Caption = 'Show Correction Lines';
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
            wgLogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage();
        begin
            ////CODEUNIT.RUN(CODEUNIT::wDocCreatorForcePrinterDialog);//Krishna //DR004AB.n Always Run Printer Selection after Request Page//krishna
            wgLogInteraction := wgCduSegManagement.FindInteractTmplCode(21) <> '';
            wgLogInteractionEnable := wgLogInteraction;

            wgNoOfCopies := 0;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        wgRecSalesSetup.GET;

        wgRecCompanyInfo.GET;

        IF wgRecSalesSetup."Logo Position on Documents" <> wgRecSalesSetup."Logo Position on Documents"::"No Logo" THEN
            wgRecCompanyInfo.CALCFIELDS(Picture);
    end;

    var
        wgRecLanguage: Record Language;
        wgRecSalesPurchPerson: Record "Salesperson/Purchaser";
        wgRecCompanyInfo: Record "Company Information";
        wgRecSalesSetup: Record "Sales & Receivables Setup";
        wgCduFormatAddr: Codeunit "Format Address";
        wgCduFormatDoc: Codeunit "Format Document";
        wgCduSegManagement: Codeunit SegManagement;
        wgCduItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
        wgCduRcptCountPrinted: Codeunit "Return Shipment - Printed";
        //wgCduDocCreatorTransLationMgt: Codeunit 11249655;
        //wgCduDocCreatorReportFunctions: Codeunit 11249656;
        wgCompanyAddr: array[8] of Text[50];
        wgCompanyInfoFaxNo: Text;
        wgCompanyInfoPhoneNo: Text;
        wgCopyText: Text[30];
        wgDimText: Text[120];
        wgPayToVendAddr: array[8] of Text[50];
        wgShipToAddr: array[8] of Text[50];
        wgTotalTrackingQty: Decimal;
        wgNoOfCopies: Integer;
        wgNoOfLoops: Integer;
        wgOutputNo: Integer;
        wgReportId: Integer;
        wgLogInteraction: Boolean;
        [InDataSet]
        wgLogInteractionEnable: Boolean;
        wgShowCorrectionLines: Boolean;
        wgShowInternalInfo: Boolean;
        wgShowLotSN: Boolean;
        wgRecLanguageCod: Codeunit Language;

    local procedure Trl(pLblName: Text): Text;
    begin
        /*/*if wgReportId = 0 then begin
            EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(false), '=', DELCHR(CurrReport.OBJECTID(false), '=', '1234567890')));
            //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        end;
        exit(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));*/
        exit(pLblName);//Krishna
    end;

    procedure InitializeRequest(pNewNoOfCopies: Integer; pNewShowInternalInfo: Boolean; pNewLogInteraction: Boolean; pNewShowCorrectionLines: Boolean);
    begin
        wgNoOfCopies := pNewNoOfCopies;
        wgShowInternalInfo := pNewShowInternalInfo;
        wgLogInteraction := pNewLogInteraction;
        wgShowCorrectionLines := pNewShowCorrectionLines;
    end;

    local procedure wlFncFormatDocumentFields(pRecSalesShptHeader: Record "Return Shipment Header");
    var
        wlSalesPersonText: Text[30];
    begin
        // WITH pRecSalesShptHeader DO BEGIN//Krishna
        //     wgCduFormatDoc.SetPurchaser(wgRecSalesPurchPerson, "Purchaser Code", wlSalesPersonText);
        // END;
        wgCduFormatDoc.SetPurchaser(wgRecSalesPurchPerson, pRecSalesShptHeader."Purchaser Code", wlSalesPersonText);//Krishna
    end;

    local procedure wlFncFormatAddressFields(var vRecSalesShptHeader: Record "Return Shipment Header");
    var
        wlRecRespCenter: Record "Responsibility Center";
    begin
        wgCduFormatAddr.GetCompanyAddr(vRecSalesShptHeader."Responsibility Center", wlRecRespCenter, wgRecCompanyInfo, wgCompanyAddr);
        wgCompanyInfoPhoneNo := wgRecCompanyInfo."Phone No.";
        wgCompanyInfoFaxNo := wgRecCompanyInfo."Fax No.";
        wgCduFormatAddr.PurchShptBuyFrom(wgShipToAddr, vRecSalesShptHeader);
        wgCduFormatAddr.PurchShptPayTo(wgPayToVendAddr, vRecSalesShptHeader);
    end;
}

