report 50011 "XSS Certificate of Conformance"
{
    // version XSS5.097

    // DefaultLayout = RDLC;
    // RDLCLayout = 'Reports\P2\XSS Certificate of Conformance.rdlc';
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Report50011\Report50011.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(SalesHdr; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.") ORDER(Ascending) WHERE("Document Type" = CONST(Order));
            RequestFilterFields = "No.", "Your Reference";
            column(lblDate; Trl('Date'))
            {
            }
            column(lblOrderNumber; Trl('Order No.'))
            {
            }
            column(lblReferenceText; Trl('Your Reference'))
            {
            }
            column(lblRegards; Trl('Regards'))
            {
            }
            column(lblName; Trl('Name'))
            {
            }
            column(lblFunction; Trl('Function'))
            {
            }
            column(lblQuantity; Trl('Quantity'))
            {
            }
            column(lblModelName; Trl('ModelName'))
            {
            }
            column(lblDescription; Trl('Description'))
            {
            }
            column(lblSerialNo; Trl('SerialNo'))
            {
            }
            column(lblLotNo; Trl('LotNo'))
            {
            }
            column(CompanyInfoPicture; CompanyInfo.Picture)
            {
            }
            column(DocumentNo; "No.")
            {
            }
            // column(lblConformanceTitle; Trl('ConformanceTitle'))
            // {
            // }
            //02.09.2021
            column(lblConformanceTitle; Trl('CERTIFICATE OF CONFORMANCE'))
            {
            }
            column(OrderNo; "No.")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(Name; Text001)
            {
            }
            column("Function"; Text002)
            {
            }
            //02.09.2021
            column(Posting_Date; "Posting Date") { }
            column(lblSincerely; Trl('Sincerely,'))
            {
            }
            column(lblMoniqueBos; Trl('Monique Bos'))
            {
            }
            column(lblTeamleaderInternalSale; Trl('Teamleader Internal Sale'))
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));
                    column(Workdate; FORMAT(WORKDATE, 0, '<Day,2>-<Month,2>-<Year4>'))
                    {
                    }
                    dataitem(ExtendedTextLine; "Extended Text Line")
                    {
                        //DataItemTableView = SORTING("Table Name", "No.", "Language Code", "Text No.", "Line No.") ORDER(Ascending) WHERE("Table Name" = CONST("Sales Header"));
                        DataItemTableView = SORTING("Table Name", "No.", "Language Code", "Text No.", "Line No.") ORDER(Ascending) WHERE("Table Name" = CONST("Sales Header"));//Krishna- Added Sales in Enum Later
                        column(Text; Text)
                        {
                        }

                        trigger OnPreDataItem();
                        begin
                            SETRANGE(ExtendedTextLine."No.", SalesHdr."No.");
                            SETRANGE(ExtendedTextLine."Language Code", SalesHdr."Language Code");
                        end;
                    }
                    dataitem(Sales_Line; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");
                        DataItemLinkReference = SalesHdr;
                        DataItemTableView = SORTING("Document Type", "Document No.",Sorting,"Line No.");

                        trigger OnPreDataItem();
                        begin
                            CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = SORTING(Number);
                        column(Quantity1; gDecQuantity)
                        {
                        }
                        column(Item1; gCodItem)
                        {
                        }
                        column(Description1; gTxtDescription)
                        {
                        }
                        column(SerialNo1; '-')
                        {
                        }
                        dataitem(TrackingSpecification; "Tracking Specification")
                        {
                            DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Source Type" = CONST(37), "Source Subtype" = CONST("1"));
                            column(Quantity2; gDecQuantity)
                            {
                            }
                            column(Item2; gCodItem)
                            {
                            }
                            column(Description2; gTxtDescription)
                            {
                            }
                            column(SerialNo2; TrackingSpecification."Serial No.")
                            {
                            }
                            column(LotNo1; TrackingSpecification."Lot No.")
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                gIntLine := gIntLine + 1;
                                if (gIntLine > 1) and (gCodItem = TrackingSpecification."Item No.") then begin
                                    gDecQuantity := 0;
                                    gCodItem := '';
                                    gTxtDescription := '';
                                end;
                            end;

                            trigger OnPreDataItem();
                            begin
                                //SETRANGE(TrackingSpecification."Source ID",Sales_Line."Document No.");
                                SETRANGE(TrackingSpecification."Source ID", SalesLine."Document No.");
                                //SETRANGE(TrackingSpecification."Source Ref. No.",Sales_Line."Line No.");
                                SETRANGE(TrackingSpecification."Source Ref. No.", SalesLine."Line No.");

                                gDecQuantity := SalesLine.Quantity;
                                gCodItem := SalesLine."No.";
                                gTxtDescription := SalesLine.Description;
                                gIntLine := 0;
                            end;
                        }
                        dataitem(ReservationEntry; "Reservation Entry")
                        {
                            DataItemTableView = SORTING("Entry No.", Positive) ORDER(Ascending) WHERE("Source Type" = CONST(37), "Source Subtype" = CONST("1"));
                            column(Quantity3; gDecQuantity)
                            {
                            }
                            column(Item3; gCodItem)
                            {
                            }
                            column(Description3; gTxtDescription)
                            {
                            }
                            column(SerialNo3; ReservationEntry."Serial No.")
                            {
                            }
                            column(LotNo2; ReservationEntry."Lot No.")
                            {
                            }

                            trigger OnAfterGetRecord();
                            begin
                                gIntLine := gIntLine + 1;
                                if (gIntLine > 1) and (gCodItem = TrackingSpecification."Item No.") then begin
                                    gDecQuantity := 0;
                                    gCodItem := '';
                                    gTxtDescription := '';
                                end;
                            end;

                            trigger OnPreDataItem();
                            begin
                                SETRANGE(ReservationEntry."Source ID", Sales_Line."Document No.");
                                SETRANGE(ReservationEntry."Source Ref. No.", Sales_Line."Line No.");
                            end;
                        }

                        trigger OnAfterGetRecord();
                        begin
                            if Number = 1 then
                                SalesLine.FIND('-')
                            else
                                SalesLine.NEXT;
                            Sales_Line := SalesLine;

                            gDecQuantity := SalesLine.Quantity;
                            gCodItem := SalesLine."No.";
                            gTxtDescription := SalesLine.Description;
                            gIntLine := 0;
                        end;

                        trigger OnPostDataItem();
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem();
                        begin
                            // MoreLines := SalesLine.FIND('+');
                            // WHILE MoreLines AND (SalesLine.Description = '') AND  (SalesLine."Description 2"= '') AND
                            //      (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                            //      (SalesLine.Amount = 0)
                            //
                            // DO
                            //  MoreLines := SalesLine.NEXT(-1) <> 0;
                            // IF NOT MoreLines THEN
                            //  CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");
                            SalesLine.SETRANGE(COC, true);
                            SETRANGE(Number, 1, SalesLine.COUNT);
                            SalesLine.SETCURRENTKEY("Document Type", "Document No.", "Sorting No.", "Line No.");
                        end;
                    }
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(SalesLine);
                    SalesLine.DELETEALL;
                    wgCduSalesPost.GetSalesLines(SalesHdr, SalesLine, 0);
                    //CurrReport.PAGENO := 1;
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnPreDataItem();
            var
                wlCduSalesPost: Codeunit "Sales-Post";
            begin
                //CurrReport.LANGUAGE := wgRecLanguage.GetLanguageID('ENU'); //GW//krishna
                //wgCduDocCreatorTransLationMgt.wgSetLanguageCode('ENU');    //GW//Krishna   //GW

                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        label(lblWorkdate; ENU = 'Date',
                          NLD = 'Datum')
    }

    var
        wgRecLanguage: Record Language;
        //wgCduDocCreatorTransLationMgt: Codeunit wDocCreatorTranslationMgt;
        wgReportId: Integer;
        GLSetup: Record "General Ledger Setup";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesLine: Record "Sales Line" temporary;
        Language: Record Language;
        ReferenceText: Text[30];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        i: Integer;
        LogInteraction: Boolean;
        gCduAlgemeen: Codeunit Algemeen;
        gDecQuantity: Decimal;
        gCodItem: Code[20];
        gTxtDescription: Text[50];
        gIntLine: Integer;
        Regards: TextConst ENU = 'Sincerely,', NLD = 'Sincerely,';
        Text001: TextConst ENU = 'Monique Bos', NLD = 'Monique Bos';
        Text002: TextConst ENU = 'Teamleader Internal Sales', NLD = 'Teamleader Internal Sales';
        wgCduSalesPost: Codeunit "Sales-Post";

    local procedure Trl(pLblName: Text): Text;
    begin
        /*if wgReportId = 0 then begin
            EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(false), '=', DELCHR(CurrReport.OBJECTID(false), '=', '1234567890')));
            //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        end;
        exit(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));*/
        exit(pLblName);
    end;

    procedure fInTrackingSpecification(pRecSalesLine: Record "Sales Line"): Boolean;
    var
        lRecTrackingSpecification: Record "Tracking Specification";
    begin
        /* fInTrackingSpecification */

        lRecTrackingSpecification.RESET;
        lRecTrackingSpecification.SETCURRENTKEY("Entry No.");
        lRecTrackingSpecification.SETRANGE("Source ID", pRecSalesLine."Document No.");
        lRecTrackingSpecification.SETRANGE("Source Ref. No.", pRecSalesLine."Line No.");
        if lRecTrackingSpecification.FINDFIRST then
            exit(true)
        else
            exit(false);

    end;

    procedure fInReservation(pRecSalesLine: Record "Sales Line"): Boolean;
    var
        lRecReservationEntry: Record "Reservation Entry";
    begin
        /* fInReservation */

        lRecReservationEntry.RESET;
        lRecReservationEntry.SETCURRENTKEY("Entry No.");
        lRecReservationEntry.SETRANGE("Source ID", pRecSalesLine."Document No.");
        lRecReservationEntry.SETRANGE("Source Ref. No.", pRecSalesLine."Line No.");
        if lRecReservationEntry.FINDFIRST then
            exit(true)
        else
            exit(false);

    end;
}

