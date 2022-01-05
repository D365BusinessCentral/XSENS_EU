report 72104 "R208 Sales - Shipment DCR"
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

    Caption = 'Sales - Shipment';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(ShptHdr; "Sales Shipment Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Shipment';
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
            column(lblLineDimensions; Trl('LineDimensions'))
            {
            }
            column(lblLotNo; Trl('LotNo'))
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
            column(lblPhoneNo; Trl('PhoneNo'))
            {
            }
            column(lblPostingDate; Trl('PostingDate'))
            {
            }
            column(lblQuantity; Trl('Quantity'))
            {
            }
            column(lblSalesPerson; Trl('SalesPerson'))
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
            column(lblShipmentDate; Trl('ShipmentDate'))
            {
            }
            column(lblShipmentMethod; Trl('ShipmentMethod'))
            {
            }
            column(lblShipmentNo; Trl('ShipmentNo'))
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
            column(CustAddrSet; wgShowCustAddr)
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
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(LanguageCode; "Language Code")
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
            column(ShowCorrectionLines; wgShowCorrectionLines)
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
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(OutputNo; wgOutputNo)
                {
                }
                column(SalesShipmentTitle; STRSUBSTNO(Trl('SalesShipment%1'), wgCopyText))
                {
                }
                dataitem(HdrComment; "Sales Comment Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = ShptHdr;
                    DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Document Line No." = CONST(0));
                    column(Comment; Comment)
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
                    DataItemLinkReference = ShptHdr;
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
                dataitem(ShptLine; "Sales Shipment Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemLinkReference = ShptHdr;
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    column(Description; Description)
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
                    column(TypeNo; Type.AsInteger() + 0) //Type + 0)
                    {
                    }
                    column(UOM; "Unit of Measure Code")//wgCduDocCreatorTransLationMgt.wgFncGetUnitOfMeaseTrl("Unit of Measure Code")//Krishna)
                    {
                    }
                    dataitem(LineComment; "Sales Comment Line")
                    {
                        DataItemLink = "No." = FIELD("Document No."), "Document Line No." = FIELD("Line No.");
                        DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment));
                        column(Comment_2; LineComment.Comment)
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
                    dataitem(AsmLine; "Posted Assembly Line")
                    {
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        UseTemporary = true;
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
                            //DecimalPlaces = 0 : 5;//Krishna
                        }

                        trigger OnPreDataItem();
                        begin
                            RESET;
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
                            if not wgShowLotSN then
                                CurrReport.BREAK;

                            RESET;
                            SETRANGE("Source Ref. No.", ShptLine."Line No.");
                            wgTotalTrackingQty := 0;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if not wgShowCorrectionLines and Correction then
                            CurrReport.SKIP;

                        if wgDisplayAssemblyInformation then
                            wlFncCollectAsmInformation(ShptLine, AsmLine);
                    end;

                    trigger OnPreDataItem();
                    var
                        wlMoreLines: Boolean;
                    begin
                        wlMoreLines := ShptLine.FIND('+');
                        while wlMoreLines and (Description = '') and ("No." = '') and (Quantity = 0) do
                            wlMoreLines := NEXT(-1) <> 0;
                        if not wlMoreLines then
                            CurrReport.BREAK;
                        SETRANGE("Line No.", 0, "Line No.");
                    end;
                }
                dataitem(Total; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(TotalTrackingQty; wgTotalTrackingQty)
                    {
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    if Number > 1 then begin
                        wgCopyText := Trl('Copy');
                        wgOutputNo += 1;
                    end;
                end;

                trigger OnPostDataItem();
                begin
                    if not CurrReport.PREVIEW then
                        CODEUNIT.RUN(CODEUNIT::"Sales Shpt.-Printed", ShptHdr);
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
                //wgCduDocCreatorTransLationMgt.wgSetLanguageCode("Language Code");//Krishna

                wlFncFormatAddressFields(ShptHdr);
                wlFncFormatDocumentFields(ShptHdr);

                if wgLogInteraction then
                    if not CurrReport.PREVIEW then
                        wgCduSegManagement.LogDocument(
                          5, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                          "Campaign No.", "Posting Description", '');

                // Get Item Tracking
                TrackingSpec.RESET;
                TrackingSpec.DELETEALL;
                if wgShowLotSN then begin
                    wgCduItemTrackingDocMgt.SetRetrieveAsmItemTracking(true);
                    wgCduItemTrackingDocMgt.RetrieveDocumentItemTracking(TrackingSpec, ShptHdr."No.",
                        DATABASE::"Sales Shipment Header", 0);
                end;
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
            wlFncInitLogInteraction;

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

        if wgRecSalesSetup."Logo Position on Documents" <> wgRecSalesSetup."Logo Position on Documents"::"No Logo" then
            wgRecCompanyInfo.CALCFIELDS(Picture);
    end;

    trigger OnPreReport();
    begin
        if not CurrReport.USEREQUESTPAGE then begin
            wlFncInitLogInteraction;
            wgNoOfCopies := 0;
        end;
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
        //wgCduDocCreatorTransLationMgt: Codeunit wDocCreatorTranslationMgt;//Krishna
        //wgCduDocCreatorReportFunctions: Codeunit wDocCreatorReportFunctions;//Krishna
        wgCompanyAddr: array[8] of Text[50];
        wgCompanyInfoFaxNo: Text;
        wgCompanyInfoPhoneNo: Text;
        wgCopyText: Text[30];
        wgCustAddr: array[8] of Text[50];
        wgDimText: Text[120];
        wgShipToAddr: array[8] of Text[50];
        wgTotalTrackingQty: Decimal;
        wgNoOfCopies: Integer;
        wgNoOfLoops: Integer;
        wgOutputNo: Integer;
        wgReportId: Integer;
        wgDisplayAssemblyInformation: Boolean;
        wgLogInteraction: Boolean;
        [InDataSet]
        wgLogInteractionEnable: Boolean;
        wgShowCorrectionLines: Boolean;
        wgShowCustAddr: Boolean;
        wgShowInternalInfo: Boolean;
        wgShowLotSN: Boolean;

    local procedure Trl(pLblName: Text): Text;
    begin
        /*if wgReportId = 0 then begin
            EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(false), '=', DELCHR(CurrReport.OBJECTID(false), '=', '1234567890')));
            //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        end;
        exit(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));*/
        exit(pLblName);
    end;

    procedure InitializeRequest(pNewNoOfCopies: Integer; pNewShowInternalInfo: Boolean; pNewLogInteraction: Boolean; pNewShowCorrectionLines: Boolean; pNewShowLotSN: Boolean; pDisplayAsmInfo: Boolean);
    begin
        wgNoOfCopies := pNewNoOfCopies;
        wgShowInternalInfo := pNewShowInternalInfo;
        wgLogInteraction := pNewLogInteraction;
        wgShowCorrectionLines := pNewShowCorrectionLines;
        wgShowLotSN := pNewShowLotSN;
        wgDisplayAssemblyInformation := pDisplayAsmInfo;
    end;

    local procedure wlFncInitLogInteraction();
    begin
        wgLogInteraction := wgCduSegManagement.FindInteractTmplCode(5) <> '';
    end;

    local procedure wlFncCollectAsmInformation(var vRecSalesShptLine: Record "Sales Shipment Line"; var vRecPostedAsmLine: Record "Posted Assembly Line");
    var
        wlRecSalesShipmentLine: Record "Sales Shipment Line";
        wlRecPostedAsmHeader: Record "Posted Assembly Header";
        wlRecPostedAsmLine: Record "Posted Assembly Line";
    begin
        //According CollectAsmInformation Report 206
        if wlRecSalesShipmentLine.AsmToShipmentExists(wlRecPostedAsmHeader) then begin
            wlRecPostedAsmLine.SETRANGE("Document No.", wlRecPostedAsmHeader."No.");
            if wlRecPostedAsmLine.FINDSET then
                repeat
                    wlFncTreatAsmLineBuffer(wlRecPostedAsmLine, vRecPostedAsmLine);
                until wlRecPostedAsmLine.NEXT = 0;
        end;
    end;

    local procedure wlFncTreatAsmLineBuffer(var vRecPostedAsmLine: Record "Posted Assembly Line"; var vRecPostedAsmLineBuffer: Record "Posted Assembly Line");
    begin
        //According TreatAsmLineBuffer Report 206
        //Needed for AsmLine
        CLEAR(vRecPostedAsmLineBuffer);
        vRecPostedAsmLineBuffer.SETRANGE(Type, vRecPostedAsmLine.Type);
        vRecPostedAsmLineBuffer.SETRANGE("No.", vRecPostedAsmLine."No.");
        vRecPostedAsmLineBuffer.SETRANGE("Variant Code", vRecPostedAsmLine."Variant Code");
        vRecPostedAsmLineBuffer.SETRANGE(Description, vRecPostedAsmLine.Description);
        vRecPostedAsmLineBuffer.SETRANGE("Unit of Measure Code", vRecPostedAsmLine."Unit of Measure Code");
        if vRecPostedAsmLineBuffer.FINDFIRST then begin
            vRecPostedAsmLineBuffer.Quantity += vRecPostedAsmLine.Quantity;
            vRecPostedAsmLineBuffer.MODIFY;
        end else begin
            CLEAR(vRecPostedAsmLineBuffer);
            vRecPostedAsmLineBuffer := vRecPostedAsmLine;
            vRecPostedAsmLineBuffer.INSERT;
        end;
    end;

    local procedure wlFncFormatDocumentFields(pRecSalesShptHeader: Record "Sales Shipment Header");
    var
        wlSalesPersonText: Text[30];
    begin
        wgCduFormatDoc.SetSalesPerson(wgRecSalesPurchPerson, pRecSalesShptHeader."Salesperson Code", wlSalesPersonText);
    end;

    local procedure wlFncFormatAddressFields(var vRecSalesShptHeader: Record "Sales Shipment Header");
    var
        wlRecRespCenter: Record "Responsibility Center";
    begin
        wgCduFormatAddr.GetCompanyAddr(vRecSalesShptHeader."Responsibility Center", wlRecRespCenter, wgRecCompanyInfo, wgCompanyAddr);
        wgCompanyInfoPhoneNo := wgRecCompanyInfo."Phone No.";
        wgCompanyInfoFaxNo := wgRecCompanyInfo."Fax No.";
        wgCduFormatAddr.SalesShptShipTo(wgShipToAddr, vRecSalesShptHeader);
        wgShowCustAddr := wgCduFormatAddr.SalesShptBillTo(wgCustAddr, wgShipToAddr, vRecSalesShptHeader);
    end;
}

