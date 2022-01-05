report 72110 "R117 Reminder DCR"
{
    // version DCR3.45.100.01

    // ********************************************************************************
    // IDYN - Document Creator
    // ********************************************************************************
    // 
    // ID        Date        Author
    // --------------------------------------------------------------------------------
    // [DR004AC] 22-12-17,   RB,
    //           New Object.
    // --------------------------------------------------------------------------------
    // [DR004AC] 28-02-18,   RB,
    //           Added date-columns to dataset, Updated labels

    Caption = 'Reminder';

    dataset
    {
        dataitem(ReminderHdr; "Issued Reminder Header")
        {
            CalcFields = "Remaining Amount", "Interest Amount", "Additional Fee", "VAT Amount";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeading = 'Reminder';
            column(lblAdditionalFee; Trl('AdditionalFee'))
            {
            }
            column(lblAddress; Trl('Address'))
            {
            }
            column(lblAmountInclVAT; Trl('AmountInclVAT'))
            {
            }
            column(lblBankAccNo; Trl('BankAccNo'))
            {
            }
            column(lblBankName; Trl('BankName'))
            {
            }
            column(lblCompanyRegistrationNo; Trl('CompanyRegistrationNo'))
            {
            }
            column(lblCustomerNo; Trl('CustomerNo'))
            {
            }
            column(lblDaysExpired; Trl('DaysExpired'))
            {
            }
            column(lblDocumentDate; Trl('DocumentDate'))
            {
            }
            column(lblDocumentNo; Trl('DocumentNo'))
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
            column(lblHeaderDimensions; Trl('HeaderDimensions'))
            {
            }
            column(lblHomePage; Trl('HomePage'))
            {
            }
            column(lblIBAN; Trl('IBAN'))
            {
            }
            column(lblInterest; Trl('InterestAmount'))
            {
            }
            column(lblNoOfReminders; Trl('NoOfReminders'))
            {
            }
            column(lblOriginalAmount; Trl('Original Amount'))
            {
            }
            column(lblOpenNotExpired; Trl('OpenNotExpired'))
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
            column(lblRemainingAmount; Trl('RemainingAmount'))
            {
            }
            column(lblReminderNo; Trl('ReminderNo'))
            {
            }
            column(lblReminderTitle; Trl('Reminder'))
            {
            }
            column(lblSWIFT; Trl('SWIFT'))
            {
            }
            column(lblTotal; Trl('Total'))
            {
            }
            column(lblTotalExpired; Trl('TotalExpired'))
            {
            }
            column(lblTotalOpen; Trl('TotalOpen'))
            {
            }
            column(lblTotalTransFooter; Trl('TotalTransFooter'))
            {
            }
            column(lblTotalTransHeader; Trl('TotalTransHeader'))
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
            column(lblVATClause; Trl('VATClause'))
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
            column(CustomerNo; "Customer No.")
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
            column(MoveTextLinesToHdrFtr; wgMoveRemTxtLinesToHdrFtr)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(PostingDateText; FORMAT("Posting Date", 0, 4))
            {
            }
            column(ShowNotDueAmounts; wgShowNotDueAmounts)
            {
            }
            column(TotalAmountInclVAT; wgTotAmountInclVAT)
            {
                AutoFormatExpression = "Currency Code";
                AutoFormatType = 1;
            }
            column(TotalInclVATText; wgTotalInclVATText)
            {
            }
            column(TotalText; wgTotalText)
            {
            }
            column(VATRegNo; "VAT Registration No.")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            dataitem(HdrComment; "Reminder Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemLinkReference = ReminderHdr;
                DataItemTableView = SORTING(Type, "No.", "Line No.") ORDER(Ascending) WHERE(Type = CONST("Issued Reminder"));
                column(Comment; Comment)
                {
                }
            }
            dataitem(HeaderDim; "Dimension Set Entry")
            {
                DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                DataItemLinkReference = ReminderHdr;
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
            dataitem(ReminderTextBegin; "Reminder Text")
            {
                DataItemLink = "Reminder Terms Code" = FIELD("Reminder Terms Code"), "Reminder Level" = FIELD("Reminder Level");
                DataItemLinkReference = ReminderHdr;
                DataItemTableView = SORTING("Reminder Terms Code", "Reminder Level", Position, "Line No.") WHERE(Position = CONST(Beginning));
                column(Text; wlFncStrSubstNoText(ReminderTextBegin))
                {
                }
            }
            dataitem(ReminderLine; "Issued Reminder Line")
            {
                DataItemLink = "Reminder No." = FIELD("No.");
                DataItemLinkReference = ReminderHdr;
                DataItemTableView = SORTING("Reminder No.", "Line No.");
                UseTemporary = true;
                column(Amount; Amount)
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(DaysExpired; wgDaysExpired)
                {
                }
                column(Description; Description)
                {
                }
                column(DocumentDate_2; "Document Date")
                {
                }
                column(DocumentNo_2; "Document No.")
                {
                }
                column(DueDate_2; "Due Date")
                {
                }
                column(LineNo; "Line No.")
                {
                }
                column(LineType; "Line Type")
                {
                }
                column(LineTypeIx; "Line Type".AsInteger() + 0)
                {
                }
                column(NoOfReminders; "No. of Reminders")
                {
                }
                column(OriginalAmount; "Original Amount")
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(RemainingAmount_2; "Remaining Amount")
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(Type; Type)
                {
                }
                column(TypeIx; Type.AsInteger() + 0) //Type + 0)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    wgDaysExpired := 0;

                    case Type of
                        Type::"G/L Account":
                            begin
                                wgTotAddFee += Amount;
                                "Remaining Amount" := Amount; //In case the line is shown
                            end;
                        Type::"Line Fee":
                            begin
                                wgTotAddFee += Amount;
                                "Remaining Amount" := Amount; //In case the line is shown
                            end;
                        Type::"Customer Ledger Entry":
                            begin
                                wgTotOpen += "Remaining Amount";
                                if "Line Type" = "Line Type"::"Reminder Line" then begin
                                    wgTotExpired += "Remaining Amount";
                                    wgTotInterest += Amount;
                                    if "Due Date" > 0D then
                                        wgDaysExpired := ReminderHdr."Posting Date" - "Due Date"
                                end;
                            end;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    RESET;
                    wgTotExpired := 0;
                    wgTotInterest := 0;
                    wgTotAddFee := 0;
                    wgTotOpen := 0;
                end;
            }
            dataitem(VATAmtLine; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(AmountInclVAT; "Amount Including VAT")
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATAmount_2; "VAT Amount")
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATBase; "VAT Base")
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
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
            dataitem(VATClause; "VAT Amount Line")
            {
                DataItemTableView = SORTING("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                UseTemporary = true;
                column(Description_4; wgRecVATClause.Description)
                {
                }
                column(Description2; wgRecVATClause."Description 2")
                {
                }
                column(VATAmount_4; "VAT Amount")
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(VATClauseCode; "VAT Clause Code")
                {
                }
                column(VATIdentifier_4; "VAT Identifier")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if "VAT Clause Code" = '' then
                        CurrReport.SKIP;
                    if wgRecVATClause.Code <> "VAT Clause Code" then
                        if not wgRecVATClause.GET("VAT Clause Code") then
                            CurrReport.SKIP;

                    wgRecVATClause.TranslateDescription(ReminderHdr."Language Code");
                end;

                trigger OnPreDataItem();
                begin
                    COPY(VATAmtLine, true); //Set VATClause to VATAmtLine
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
                        ReminderHdr."Posting Date", ReminderHdr."Currency Code", wgCurrencyFactor);
                    wgVALVATAmountLCY :=
                      VATAmtLine.GetAmountLCY(
                        ReminderHdr."Posting Date", ReminderHdr."Currency Code", wgCurrencyFactor);

                    wgTotVALVATBaseLCY += wgVALVATBaseLCY;
                    wgTotVALVATAmountLCY += wgVALVATAmountLCY;
                end;

                trigger OnPreDataItem();
                begin
                    if not wgShowVATLCY then
                        CurrReport.BREAK;

                    COPY(VATAmtLine, true); //Set VATAmtLineLCY to VATAmtLine
                    RESET;
                end;
            }
            dataitem(ReminderTextEnd; "Reminder Text")
            {
                DataItemLink = "Reminder Terms Code" = FIELD("Reminder Terms Code"), "Reminder Level" = FIELD("Reminder Level");
                DataItemLinkReference = ReminderHdr;
                DataItemTableView = SORTING("Reminder Terms Code", "Reminder Level", Position, "Line No.") WHERE(Position = CONST(Ending));
                column(Text_2; wlFncStrSubstNoText(ReminderTextEnd))
                {
                }
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
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotAdditionalFee; wgTotAddFee)
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotExpired; wgTotExpired)
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotInterest; wgTotInterest)
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotOpen; wgTotOpen)
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
                    AutoFormatType = 1;
                }
                column(TotVATAmount; wgTotVATAmount)
                {
                    AutoFormatExpression = ReminderHdr."Currency Code";
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
            var
                wlRecGLAccount: Record "G/L Account";
                VATPostingSetup: Record "VAT Posting Setup";
                wlCurrencyCode: Code[10];
            begin
                //CurrReport.LANGUAGE := wgRecLanguage.GetLanguageID("Language Code");//Krishna
                //wgCduDocCreatorTransLationMgt.wgSetLanguageCode("Language Code");//Krishna

                wlFncGetReminderLevel("Reminder Terms Code", "Reminder Level");

                wgCduFormatAddr.IssuedReminder(wgCustAddr, ReminderHdr);  // NAV2017/NAV2018

                wlCurrencyCode := "Currency Code";
                if wlCurrencyCode = '' then begin
                    wgRecGLSetup.TESTFIELD("LCY Code");
                    wlCurrencyCode := wgRecGLSetup."LCY Code";
                end;
                wgTotalText := STRSUBSTNO(Trl('Total%1'), wlCurrencyCode);
                wgTotalInclVATText := STRSUBSTNO(Trl('Total%1InclVAT'), wlCurrencyCode);

                if not CurrReport.PREVIEW then begin
                    if wgLogInteraction then
                        wgCduSegManagement.LogDocument(
                          8, "No.", 0, 0, DATABASE::Customer, "Customer No.", '', '', "Posting Description", '');
                    IncrNoPrinted;
                end;

                //Get Reminder Lines
                ReminderLine.RESET;
                ReminderLine.DELETEALL;
                VATAmtLine.RESET;
                VATAmtLine.DELETEALL;
                wlFncGetReminderLines(ReminderLine);

                //Get VAT Amount Lines
                wlFncCalcVATAmountLines(ReminderLine, VATAmtLine);
                wgTotVATAmount := VATAmtLine.GetTotalVATAmount;
                wgTotAmount := VATAmtLine.GetTotalVATBase;
                wgTotAmountInclVAT := VATAmtLine.GetTotalAmountInclVAT;

                //Prepare VAT Amount Lines LCY
                if (not wgRecGLSetup."Print VAT specification in LCY") or
                   (ReminderHdr."Currency Code" = '') or
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
                    wgRecCurrExchRate.FindCurrency(ReminderHdr."Posting Date", ReminderHdr."Currency Code", 1);
                    wgVALExchRate := STRSUBSTNO(Trl('ExchangeRate%1/%2'), wgRecCurrExchRate."Relational Exch. Rate Amount", wgRecCurrExchRate."Exchange Rate Amount");
                    wgCurrencyFactor := wgRecCurrExchRate.ExchangeRate(ReminderHdr."Posting Date", ReminderHdr."Currency Code");
                end;

                //Get Additional Fee
                CALCFIELDS("Additional Fee");
                TESTFIELD("Customer Posting Group");
                wlFncGetCustPostingGroup("Customer Posting Group");
                if wlRecGLAccount.GET(wgRecCustPostingGroup."Additional Fee Account") then begin
                    wlFncGetVATPostingSetup("VAT Bus. Posting Group", wlRecGLAccount."VAT Prod. Posting Group");
                    wgAdditionalFeeInclVAT := "Additional Fee" * (1 + VATPostingSetup."VAT %" / 100);
                end else
                    wgAdditionalFeeInclVAT := "Additional Fee";

                //Get Interest VAT Percentage
                CALCFIELDS("Interest Amount");
                if "Interest Amount" <> 0 then begin
                    wlRecGLAccount.GET(wgRecCustPostingGroup."Interest Account");
                    wlFncGetVATPostingSetup("VAT Bus. Posting Group", wlRecGLAccount."VAT Prod. Posting Group");
                    wgInterestVATPerc := VATPostingSetup."VAT %";
                end else
                    wgInterestVATPerc := 0;
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
                    field(ShowInternalInfo; wgShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                        ApplicationArea = All;
                    }
                    field(LogInteraction; wgLogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = wgLogInteractionEnable;
                        ApplicationArea = All;
                    }
                    field(ShowNotDueAmounts; wgShowNotDueAmounts)
                    {
                        Caption = 'Show Not Due Amounts';
                        ApplicationArea = All;
                    }
                    field(MoveRemTxtLinesToHdrFtr; wgMoveRemTxtLinesToHdrFtr)
                    {
                        Caption = 'Move Reminder Text Lines to Header/Footer';
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
            wgLogInteraction := wgCduSegManagement.FindInteractTmplCode(8) <> '';
            wgLogInteractionEnable := wgLogInteraction;
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

        wgCduFormatAddr.Company(wgCompanyAddr, wgRecCompanyInfo);
    end;

    var
        wgRecFinChargeTerms: Record "Finance Charge Terms";
        wgRecLanguage: Record Language;
        wgRecCompanyInfo: Record "Company Information";
        wgRecCustPostingGroup: Record "Customer Posting Group";
        wgRecGLSetup: Record "General Ledger Setup";
        wgRecReminderLevel: Record "Reminder Level";
        wgRecSalesSetup: Record "Sales & Receivables Setup";
        wgRecVATPostingSetup: Record "VAT Posting Setup";
        wgRecCurrExchRate: Record "Currency Exchange Rate";
        wgRecVATClause: Record "VAT Clause";
        //wgCduApplicationMgt: Codeunit ApplicationManagement;
        wgCduFormatAddr: Codeunit "Format Address";
        wgCduSegManagement: Codeunit SegManagement;
        //wgCduDocCreatorTransLationMgt: Codeunit wDocCreatorTranslationMgt;//Krishna
        //wgCduDocCreatorReportFunctions: Codeunit wDocCreatorReportFunctions;//Krishna
        wgCompanyAddr: array[8] of Text[50];
        wgCustAddr: array[8] of Text[50];
        wgDimText: Text[120];
        wgTotalInclVATText: Text[50];
        wgTotalText: Text[50];
        wgVALExchRate: Text[50];
        wgVALSpecLCYHeader: Text[80];
        wgVATAmountText: Text[30];
        wgAdditionalFeeInclVAT: Decimal;
        wgCurrencyFactor: Decimal;
        wgInterestVATPerc: Decimal;
        wgTotAddFee: Decimal;
        wgTotAmount: Decimal;
        wgTotAmountInclVAT: Decimal;
        wgTotExpired: Decimal;
        wgTotInterest: Decimal;
        wgTotOpen: Decimal;
        wgTotVALVATAmountLCY: Decimal;
        wgTotVALVATBaseLCY: Decimal;
        wgTotVATAmount: Decimal;
        wgVALVATAmountLCY: Decimal;
        wgVALVATBaseLCY: Decimal;
        wgDaysExpired: Integer;
        wgNoOfVATAmountLines: Integer;
        wgReportId: Integer;
        wgLogInteraction: Boolean;
        [InDataSet]
        wgLogInteractionEnable: Boolean;
        wgMonolithicVAT: Boolean;
        wgMoveRemTxtLinesToHdrFtr: Boolean;
        wgShowInternalInfo: Boolean;
        wgShowNotDueAmounts: Boolean;
        wgShowVATLCY: Boolean;

    local procedure Trl(pLblName: Text): Text;
    begin
        /*if wgReportId = 0 then begin
            EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(false), '=', DELCHR(CurrReport.OBJECTID(false), '=', '1234567890')));
            //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        end;
        exit(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));*/
        exit(pLblName);
    end;

    local procedure wlFncGetReminderLines(var vRecIssuedReminderLine: Record "Issued Reminder Line");
    var
        wlRecIssuedReminderLine: Record "Issued Reminder Line";
    begin
        wlRecIssuedReminderLine.SETRANGE("Reminder No.", ReminderHdr."No.");
        if wlRecIssuedReminderLine.FINDSET then
            repeat
                vRecIssuedReminderLine := wlRecIssuedReminderLine;
                vRecIssuedReminderLine.INSERT;
            until wlRecIssuedReminderLine.NEXT = 0;
    end;

    procedure wlFncCalcVATAmountLines(var vRecIssuedReminderLine: Record "Issued Reminder Line"; var vRecVATAmountLine: Record "VAT Amount Line");
    begin
        vRecVATAmountLine.DELETEALL;
        vRecIssuedReminderLine.RESET;
        if vRecIssuedReminderLine.FINDSET then
            repeat
                vRecVATAmountLine.INIT;
                vRecVATAmountLine."VAT Identifier" := vRecIssuedReminderLine."VAT Identifier";
                vRecVATAmountLine."VAT Calculation Type" := vRecIssuedReminderLine."VAT Calculation Type";
                vRecVATAmountLine."Tax Group Code" := vRecIssuedReminderLine."Tax Group Code";
                vRecVATAmountLine."VAT %" := vRecIssuedReminderLine."VAT %";
                vRecVATAmountLine."VAT Base" := vRecIssuedReminderLine.Amount;
                vRecVATAmountLine."VAT Amount" := vRecIssuedReminderLine."VAT Amount";
                vRecVATAmountLine."Amount Including VAT" := vRecIssuedReminderLine.Amount + vRecIssuedReminderLine."VAT Amount";
                vRecVATAmountLine."VAT Clause Code" := vRecIssuedReminderLine."VAT Clause Code";
                vRecVATAmountLine.InsertLine;
            until vRecIssuedReminderLine.NEXT = 0;
    end;

    local procedure wlFncGetReminderLevel(pReminderTermsCode: Code[10]; pReminderLevel: Integer);
    begin
        if (wgRecReminderLevel."Reminder Terms Code" <> pReminderTermsCode) or
           (wgRecReminderLevel."No." <> pReminderLevel)
        then
            wgRecReminderLevel.GET(pReminderTermsCode, pReminderLevel);
    end;

    local procedure wlFncGetCustPostingGroup(pCustPostingGroup: Code[10]);
    begin
        if wgRecCustPostingGroup.Code <> pCustPostingGroup then
            wgRecCustPostingGroup.GET(pCustPostingGroup);
    end;

    local procedure wlFncGetVATPostingSetup(pVATBusPostingGroup: Code[10]; pVATProdPostingGroup: Code[10]);
    begin
        if (wgRecVATPostingSetup."VAT Bus. Posting Group" <> pVATBusPostingGroup) or
           (wgRecVATPostingSetup."VAT Prod. Posting Group" <> pVATProdPostingGroup)
        then
            wgRecVATPostingSetup.GET(pVATBusPostingGroup, pVATProdPostingGroup);
    end;

    local procedure wlFncStrSubstNoText(var vRecReminderText: Record "Reminder Text"): Text;
    var
        wlReminderTotalAmount: Decimal;
    begin
        if ReminderHdr."Fin. Charge Terms Code" <> '' then begin
            if wgRecFinChargeTerms.Code <> ReminderHdr."Fin. Charge Terms Code" then
                if not wgRecFinChargeTerms.GET(ReminderHdr."Fin. Charge Terms Code") then
                    CLEAR(wgRecFinChargeTerms);
        end else
            CLEAR(wgRecFinChargeTerms);

        wlReminderTotalAmount :=
          ReminderHdr."Remaining Amount"
          + ReminderHdr."Interest Amount"
          + ReminderHdr."Additional Fee"
          + ReminderHdr."VAT Amount";

        exit(
          STRSUBSTNO(vRecReminderText.Text,
          ReminderHdr."Document Date",
          ReminderHdr."Due Date",
          wgRecFinChargeTerms."Interest Rate",
          ReminderHdr."Remaining Amount",
          ReminderHdr."Interest Amount",
          ReminderHdr."Additional Fee",
          FORMAT(wlReminderTotalAmount),//, 0, wgCduApplicationMgt.AutoFormatTranslate(1, ReminderHdr."Currency Code")),//Krishna
          ReminderHdr."Reminder Level",
          ReminderHdr."Currency Code",
          ReminderHdr."Posting Date",
          wgRecCompanyInfo.Name));
    end;
}

