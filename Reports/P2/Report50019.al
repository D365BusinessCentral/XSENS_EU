report 50019 "XSS - Reminder - North America"
{
    // version NAVW111.00.00.23019,XSS5.086

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\XSS - Reminder - North America.rdlc';
    CaptionML = ENU = 'Reminder',
                NLD = 'Aanmaning';

    dataset
    {
        dataitem("Issued Reminder Header"; "Issued Reminder Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            RequestFilterHeadingML = ENU = 'Reminder',
                                     NLD = 'Aanmaning';
            column(No_IssuedReminderHeader; "No.")
            {
            }
            column(DueDateCaption; DueDateCaptionLbl)
            {
            }
            column(VATAmountCaption; VATAmountCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATPercentCaption; VATPercentCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(DocDateCaption; DocDateCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(DueDate_IssuedReminderHdr; FORMAT("Issued Reminder Header"."Due Date"))
                {
                }
                column(PostDate_IssuedReminderHdr; FORMAT("Issued Reminder Header"."Posting Date"))
                {
                }
                column(No1_IssuedReminderHdr; "Issued Reminder Header"."No.")
                {
                }
                column(YourRef_IssueReminderHdr; "Issued Reminder Header"."Your Reference")
                {
                }
                column(Contact_IssuedReminderHdr; "Issued Reminder Header".Contact)
                {
                }
                column(ReferenceText; ReferenceText)
                {
                }
                column(VatRegNo_IssueReminderHdr; "Issued Reminder Header"."VAT Registration No.")
                {
                }
                column(VATNoText; VATNoText)
                {
                }
                column(DocDate_IssueReminderHdr; FORMAT("Issued Reminder Header"."Document Date"))
                {
                }
                column(CustNo_IssueReminderHdr; "Issued Reminder Header"."Customer No.")
                {
                }
                column(CompanyInfoBankAccNo; CompanyInfo1."Bank Account No.")
                {
                }
                column(CompanyInfoBankName; CompanyInfo."Bank Name")
                {
                }
                column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                {
                }
                column(CompanyInfoVATRegNo; gTxtTaxID)
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfoEMail; 'AR@xsens.com')
                {
                }
                column(CustAddr8; CustAddr[8])
                {
                }
                column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                {
                }
                column(CustAddr7; CustAddr[7])
                {
                }
                column(CustAddr6; CustAddr[6])
                {
                }
                column(CompanyAddr6; CompanyAddr[6])
                {
                }
                column(CustAddr5; CustAddr[5])
                {
                }
                column(CompanyAddr5; CompanyAddr[5])
                {
                }
                column(CustAddr4; CustAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(CustAddr3; CustAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(CustAddr2; CustAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(CustAddr1; CustAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(CurrReportPageNo; STRSUBSTNO(Text002, ''))// CurrReport.PAGENO))
                {
                }
                column(TextPage; TextPageLbl)
                {
                }
                column(PostingDateCaption; PostingDateCaptionLbl)
                {
                }
                column(ReminderNoCaption; ReminderNoCaptionLbl)
                {
                }
                column(BankAccNoCaption; BankAccNoCaptionLbl)
                {
                }
                column(BankNameCaption; BankNameCaptionLbl)
                {
                }
                column(GiroNoCaption; GiroNoCaptionLbl)
                {
                }
                column(TaxIDCaption; VATRegNoCaptionLbl)
                {
                }
                column(PhoneNoCaption; PhoneNoCaptionLbl)
                {
                }
                column(ReminderCaption; ReminderCaptionLbl)
                {
                }
                column(CustNo_IssueReminderHdrCaption; "Issued Reminder Header".FIELDCAPTION("Customer No."))
                {
                }
                column(CompanyInfoIBAN; gTxtAccountNo)
                {
                }
                column(CompanyInfoBIC; gTxtRoutingNo)
                {
                }
                column(RoutingCaption; BICCaptionLbl)
                {
                }
                column(AccountNoCaption; IBANCaptionLbl)
                {
                }
                dataitem(DimensionLoop; "Integer")
                {
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(DimText; DimText)
                    {
                    }
                    column(Number_IntegerLine; Number)
                    {
                    }
                    column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if Number = 1 then begin
                            if not DimSetEntry.FINDSET then
                                CurrReport.BREAK;
                        end else
                            if not Continue then
                                CurrReport.BREAK;

                        CLEAR(DimText);
                        Continue := false;
                        repeat
                            OldDimText := DimText;
                            if DimText = '' then
                                DimText := STRSUBSTNO('%1 - %2', DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code")
                            else
                                DimText :=
                                  STRSUBSTNO(
                                    '%1; %2 - %3', DimText,
                                    DimSetEntry."Dimension Code", DimSetEntry."Dimension Value Code");
                            if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                DimText := OldDimText;
                                Continue := true;
                                exit;
                            end;
                        until DimSetEntry.NEXT = 0;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not ShowInternalInfo then
                            CurrReport.BREAK;
                    end;
                }
                dataitem(ReminderLnBeginingTxt; "Issued Reminder Line")
                {
                    DataItemLink = "Reminder No." = FIELD("No.");
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = SORTING("Reminder No.", "Line No.") WHERE(Type = CONST(" "), "Line Type" = CONST("Beginning Text"));
                    column(Description_ReminderLnBeginingTxt; Description)
                    {
                    }
                    column(LineNo_ReminderLnBeginingTxt; "Line No.")
                    {
                    }
                }
                dataitem("Issued Reminder Line"; "Issued Reminder Line")
                {
                    DataItemLink = "Reminder No." = FIELD("No.");
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = SORTING("Reminder No.", "Line No.");
                    column(RemAmt_IssuedReminderLine; "Remaining Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(Desc_IssuedReminderLine; Description)
                    {
                    }
                    column(Type_IssuedReminderLine; FORMAT(Type, 0, 2))
                    {
                    }
                    column(DocDate_IssuedReminderLine; FORMAT("Document Date"))
                    {
                    }
                    column(DocNo_IssuedReminderLine; "Document No.")
                    {
                    }
                    column(DocNoCaption_IssuedReminderLine; FIELDCAPTION("Document No."))
                    {
                    }
                    column(DueDate_IssuedReminderLine; FORMAT("Due Date"))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLine; "Original Amount")
                    {
                        AutoFormatExpression = GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(DocType_IssuedReminderLine; "Document Type")
                    {
                    }
                    column(LineNo_IssuedReminderLine; "No.")
                    {
                    }
                    column(ShowInternalInfo; ShowInternalInfo)
                    {
                    }
                    column(NNCInterestAmt; NNC_InterestAmount)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                    column(NNCTotal; NNC_Total)
                    {
                    }
                    column(TotalInclVATText; TotalInclVATText)
                    {
                    }
                    column(NNCVATAmt; NNC_VATAmount)
                    {
                    }
                    column(NNCTotalInclVAT; NNC_TotalInclVAT)
                    {
                    }
                    column(TotalVATAmt; TotalVATAmount)
                    {
                    }
                    column(RemNo_IssuedReminderLine; "Reminder No.")
                    {
                    }
                    column(DocumentDateCaption1; DocumentDateCaption1Lbl)
                    {
                    }
                    column(InterestAmountCaption; InterestAmountCaptionLbl)
                    {
                    }
                    column(RemAmt_IssuedReminderLineCaption; FIELDCAPTION("Remaining Amount"))
                    {
                    }
                    column(DocNo_IssuedReminderLineCaption; FIELDCAPTION("Document No."))
                    {
                    }
                    column(OriginalAmt_IssuedReminderLineCaption; FIELDCAPTION("Original Amount"))
                    {
                    }
                    column(DocType_IssuedReminderLineCaption; FIELDCAPTION("Document Type"))
                    {
                    }
                    column(Interest; Interest)
                    {
                    }
                    column(RemainingAmountText; RemainingAmt)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        VATAmountLine.INIT;
                        VATAmountLine."VAT Identifier" := "VAT Identifier";
                        VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                        VATAmountLine."Tax Group Code" := "Tax Group Code";
                        VATAmountLine."VAT %" := "VAT %";
                        VATAmountLine."VAT Base" := Amount;
                        VATAmountLine."VAT Amount" := "VAT Amount";
                        VATAmountLine."Amount Including VAT" := Amount + "VAT Amount";
                        VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                        VATAmountLine.InsertLine;

                        case Type of
                            Type::"G/L Account":
                                "Remaining Amount" := Amount;
                            Type::"Line Fee":
                                "Remaining Amount" := Amount;
                            Type::"Customer Ledger Entry":
                                ReminderInterestAmount := Amount;
                        end;

                        NNC_InterestAmountTotal += ReminderInterestAmount;
                        NNC_RemainingAmountTotal += "Remaining Amount";
                        NNC_VATAmountTotal += "VAT Amount";

                        NNC_InterestAmount := (NNC_InterestAmountTotal + NNC_VATAmountTotal + "Issued Reminder Header"."Additional Fee" -
                                               AddFeeInclVAT + "Issued Reminder Header"."Add. Fee per Line" - AddFeePerLineInclVAT) /
                          (VATInterest / 100 + 1);
                        NNC_Total := NNC_RemainingAmountTotal + NNC_InterestAmountTotal;
                        NNC_VATAmount := NNC_VATAmountTotal;
                        NNC_TotalInclVAT := NNC_RemainingAmountTotal + NNC_InterestAmountTotal + NNC_VATAmountTotal;

                        TotalRemAmt += "Remaining Amount";

                        RemainingAmt := '';

                        if ("Remaining Amount" = 0) and ("Due Date" = 0D) then
                            RemainingAmt := ''
                        else
                            RemainingAmt := FORMAT("Remaining Amount");
                    end;

                    trigger OnPreDataItem();
                    begin
                        CLEAR(CompanyInfo.Picture);
                        CLEAR(CompanyInfo1.Picture);
                        CLEAR(CompanyInfo2.Picture);
                        CLEAR(CompanyInfo3.Picture);

                        SETFILTER("Line Type", '<>%1', "Line Type"::"Beginning Text");

                        if FINDLAST then begin
                            EndLineNo := "Line No." + 1;
                            repeat
                                Continue :=
                                  not ShowNotDueAmounts and
                                  ("No. of Reminders" = 0) and ((Type = Type::"Customer Ledger Entry") or (Type = Type::"Line Fee")) or (Type = Type::" ");
                                if Continue then
                                    EndLineNo := "Line No.";
                            until (NEXT(-1) = 0) or not Continue;
                        end;

                        VATAmountLine.DELETEALL;
                        SETFILTER("Line No.", '<%1', EndLineNo);
                        //CurrReport.CREATETOTALS("Remaining Amount", "VAT Amount", ReminderInterestAmount);
                    end;
                }
                dataitem(IssuedReminderLine2; "Issued Reminder Line")
                {
                    DataItemLink = "Reminder No." = FIELD("No.");
                    DataItemLinkReference = "Issued Reminder Header";
                    DataItemTableView = SORTING("Reminder No.", "Line No.");
                    column(Desc1_IssuedReminderLine; Description)
                    {
                    }
                    column(LineNo1_IssuedReminderLine; "Line No.")
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        SETFILTER("Line No.", '>=%1', EndLineNo);
                        if not ShowNotDueAmounts then begin
                            SETFILTER(Type, '<>%1', Type::" ");
                            if FINDFIRST then
                                if "Line No." > EndLineNo then begin
                                    SETRANGE(Type);
                                    SETRANGE("Line No.", EndLineNo, "Line No." - 1); // find "Open Entries Not Due" line
                                    if FINDLAST then
                                        SETRANGE("Line No.", EndLineNo, "Line No." - 1);
                                end;
                            SETRANGE(Type);
                        end;
                    end;
                }
                dataitem(VATCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VATAmtLineAmtIncludVAT; VATAmountLine."Amount Including VAT")
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATAmount; VALVATAmount)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATBase; VALVATBase)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseVALVATAmt; VALVATBase + VALVATAmount)
                    {
                        AutoFormatExpression = "Issued Reminder Line".GetCurrencyCodeFromHeader;
                        AutoFormatType = 1;
                    }
                    column(VATAmtLineVAT; VATAmountLine."VAT %")
                    {
                    }
                    column(AmountIncVATCaption; AmountIncVATCaptionLbl)
                    {
                    }
                    column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
                    {
                    }
                    column(ContinuedCaption; ContinuedCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        VATAmountLine.GetLine(Number);
                        VALVATBase := VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100);
                        VALVATAmount := VATAmountLine."Amount Including VAT" - VALVATBase;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if VATAmountLine.GetTotalVATAmount = 0 then
                            CurrReport.BREAK;

                        SETRANGE(Number, 1, VATAmountLine.COUNT);

                        VALVATBase := 0;
                        VALVATAmount := 0;
                    end;
                }
                dataitem(VATClauseEntryCounter; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                    {
                    }
                    column(VATClauseCode; VATAmountLine."VAT Clause Code")
                    {
                    }
                    column(VATClauseDescription; VATClause.Description)
                    {
                    }
                    column(VATClauseDescription2; VATClause."Description 2")
                    {
                    }
                    column(VATClauseAmount; VATAmountLine."VAT Amount")
                    {
                        AutoFormatExpression = "Issued Reminder Header"."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATClausesCaption; VATClausesCap)
                    {
                    }
                    column(VATClauseVATIdentifierCaption; VATIdentifierCap)
                    {
                    }
                    column(VATClauseVATAmtCaption; VATAmountCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        VATAmountLine.GetLine(Number);
                        if not VATClause.GET(VATAmountLine."VAT Clause Code") then
                            CurrReport.SKIP;
                        VATClause.TranslateDescription("Issued Reminder Header"."Language Code");
                    end;

                    trigger OnPreDataItem();
                    begin
                        CLEAR(VATClause);
                        SETRANGE(Number, 1, VATAmountLine.COUNT);
                        //CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
                    end;
                }
                dataitem(VATCounterLCY; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(VALExchRate; VALExchRate)
                    {
                    }
                    column(VALSpecLCYHeader; VALSpecLCYHeader)
                    {
                    }
                    column(VALVATAmountLCY; VALVATAmountLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VALVATBaseLCY; VALVATBaseLCY)
                    {
                        AutoFormatType = 1;
                    }
                    column(VATAmtLineVATCtrl107; VATAmountLine."VAT %")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(ContinuedCaption1; ContinuedCaption1Lbl)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        VATAmountLine.GetLine(Number);

                        VALVATBaseLCY := ROUND(VATAmountLine."Amount Including VAT" / (1 + VATAmountLine."VAT %" / 100) / CurrFactor);
                        VALVATAmountLCY := ROUND(VATAmountLine."Amount Including VAT" / CurrFactor - VALVATBaseLCY);
                    end;

                    trigger OnPreDataItem();
                    begin
                        if (not GLSetup."Print VAT specification in LCY") or
                           ("Issued Reminder Header"."Currency Code" = '') or
                           (VATAmountLine.GetTotalVATAmount = 0)
                        then
                            CurrReport.BREAK;

                        SETRANGE(Number, 1, VATAmountLine.COUNT);

                        VALVATBaseLCY := 0;
                        VALVATAmountLCY := 0;

                        if GLSetup."LCY Code" = '' then
                            VALSpecLCYHeader := Text011 + Text012
                        else
                            VALSpecLCYHeader := Text011 + FORMAT(GLSetup."LCY Code");

                        CurrExchRate.FindCurrency("Issued Reminder Header"."Posting Date", "Issued Reminder Header"."Currency Code", 1);
                        CustEntry.SETRANGE("Customer No.", "Issued Reminder Header"."Customer No.");
                        CustEntry.SETRANGE("Document Type", CustEntry."Document Type"::Reminder);
                        CustEntry.SETRANGE("Document No.", "Issued Reminder Header"."No.");
                        if CustEntry.FINDFIRST then begin
                            CustEntry.CALCFIELDS("Amount (LCY)", Amount);
                            CurrFactor := 1 / (CustEntry."Amount (LCY)" / CustEntry.Amount);
                            VALExchRate := STRSUBSTNO(Text013, ROUND(1 / CurrFactor * 100, 0.000001), CurrExchRate."Exchange Rate Amount");
                        end else begin
                            CurrFactor := CurrExchRate.ExchangeRate("Issued Reminder Header"."Posting Date", "Issued Reminder Header"."Currency Code");
                            VALExchRate := STRSUBSTNO(Text013, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    end;
                }
                dataitem(LetterText; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(GreetingText; GreetingLbl)
                    {
                    }
                    column(AmtDueText; AmtDueTxt)
                    {
                    }
                    column(BodyText; BodyLbl)
                    {
                    }
                    column(ClosingText; ClosingLbl)
                    {
                    }
                    column(DescriptionText; DescriptionLbl)
                    {
                    }
                    column(TotalRemAmt_IssuedReminderLine; TotalRemAmt)
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        AmtDueTxt := '';
                        if FORMAT("Issued Reminder Header"."Due Date") <> '' then
                            AmtDueTxt := STRSUBSTNO(AmtDueLbl, "Issued Reminder Header"."Due Date");
                    end;
                }
            }

            trigger OnAfterGetRecord();
            var
                GLAcc: Record "G/L Account";
                CustPostingGroup: Record "Customer Posting Group";
                VATPostingSetup: Record "VAT Posting Setup";
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                DimSetEntry.SETRANGE("Dimension Set ID", "Dimension Set ID");

                FormatAddr.IssuedReminder(CustAddr, "Issued Reminder Header");
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    ReferenceText := FIELDCAPTION("Your Reference");
                if "VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text000, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                end else begin
                    TotalText := STRSUBSTNO(Text000, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text001, "Currency Code");
                end;
                //CurrReport.PAGENO := 1;
                if not CurrReport.PREVIEW then begin
                    if LogInteraction then
                        SegManagement.LogDocument(
                          8, "No.", 0, 0, DATABASE::Customer, "Customer No.", '', '', "Posting Description", '');
                    IncrNoPrinted;
                end;
                CALCFIELDS("Additional Fee");
                CustPostingGroup.GET("Customer Posting Group");
                if GLAcc.GET(CustPostingGroup."Additional Fee Account") then begin
                    VATPostingSetup.GET("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    AddFeeInclVAT := "Additional Fee" * (1 + VATPostingSetup."VAT %" / 100);
                end else
                    AddFeeInclVAT := "Additional Fee";

                CALCFIELDS("Add. Fee per Line");
                AddFeePerLineInclVAT := "Add. Fee per Line" + CalculateLineFeeVATAmount;

                CALCFIELDS("Interest Amount", "VAT Amount");
                if ("Interest Amount" <> 0) and ("VAT Amount" <> 0) then begin
                    GLAcc.GET(CustPostingGroup."Interest Account");
                    VATPostingSetup.GET("VAT Bus. Posting Group", GLAcc."VAT Prod. Posting Group");
                    VATInterest := VATPostingSetup."VAT %";
                    Interest :=
                      ("Interest Amount" +
                       "VAT Amount" + "Additional Fee" - AddFeeInclVAT + "Add. Fee per Line" - AddFeePerLineInclVAT) / (VATInterest / 100 + 1);
                end else begin
                    Interest := "Interest Amount";
                    VATInterest := 0;
                end;

                TotalVATAmount := "VAT Amount";
                NNC_InterestAmountTotal := 0;
                NNC_RemainingAmountTotal := 0;
                NNC_VATAmountTotal := 0;
                NNC_InterestAmount := 0;
                NNC_Total := 0;
                NNC_VATAmount := 0;
                NNC_TotalInclVAT := 0;
                TotalRemAmt := 0;
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET;
                FormatAddr.Company(CompanyAddr, CompanyInfo);
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
                    CaptionML = ENU = 'Options',
                                NLD = 'Opties';
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Advanced;
                        CaptionML = ENU = 'Show Internal Information',
                                    NLD = 'Interne informatie weergeven';
                        ToolTipML = ENU = 'Specifies if you want the printed report to show information that is only for internal use.',
                                    NLD = 'Hiermee wordt opgegeven of het afgedrukte rapport informatie moet bevatten die alleen bestemd is voor intern gebruik.';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Advanced;
                        CaptionML = ENU = 'Log Interaction',
                                    NLD = 'Interactie registreren';
                        Enabled = LogInteractionEnable;
                        ToolTipML = ENU = 'Specifies if you want the reminder that you print to be recorded as interaction, and to be added to the Interaction Log Entry table.',
                                    NLD = 'Hiermee wordt opgegeven of de aanmaning die u afdrukt, moet worden geregistreerd als interactie en moet worden toegevoegd aan de tabel Interactielogpost.';
                    }
                    field(ShowNotDueAmounts; ShowNotDueAmounts)
                    {
                        ApplicationArea = Advanced;
                        CaptionML = ENU = 'Show Not Due Amounts',
                                    NLD = 'Niet vervallen bedragen';
                        ToolTipML = ENU = 'Specifies if you want to show amounts that are not due from customers.',
                                    NLD = 'Hiermee wordt opgegeven of bedragen moeten worden weergegeven die niet door klanten verschuldigd zijn.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage();
        begin
            LogInteraction := SegManagement.FindInteractTmplCode(8) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        GLSetup.GET;
        SalesSetup.GET;

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                end;
        end;
    end;

    var
        Text000: TextConst ENU = 'Total %1', NLD = 'Totaal %1';
        Text001: TextConst ENU = 'Total %1 Incl. VAT', NLD = 'Totaal %1 incl. btw';
        Text002: TextConst ENU = 'Page %1', NLD = 'Pagina %1';
        CustEntry: Record "Cust. Ledger Entry";
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        DimSetEntry: Record "Dimension Set Entry";
        Language: Codeunit Language; //Record Language;
        CurrExchRate: Record "Currency Exchange Rate";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        CustAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        VATNoText: Text[30];
        ReferenceText: Text[35];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        ReminderInterestAmount: Decimal;
        EndLineNo: Integer;
        Continue: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CurrFactor: Decimal;
        Text011: TextConst ENU = 'VAT Amount Specification in ', NLD = 'Specificatie btw-bedrag in ';
        Text012: TextConst ENU = 'Local Currency', NLD = 'Lokale valuta';
        Text013: TextConst ENU = 'Exchange rate: %1/%2', NLD = 'Wisselkoers: %1/%2';
        AddFeeInclVAT: Decimal;
        AddFeePerLineInclVAT: Decimal;
        TotalVATAmount: Decimal;
        VATInterest: Decimal;
        Interest: Decimal;
        VALVATBase: Decimal;
        VALVATAmount: Decimal;
        NNC_InterestAmount: Decimal;
        NNC_Total: Decimal;
        NNC_VATAmount: Decimal;
        NNC_TotalInclVAT: Decimal;
        NNC_InterestAmountTotal: Decimal;
        NNC_RemainingAmountTotal: Decimal;
        NNC_VATAmountTotal: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        ShowNotDueAmounts: Boolean;
        TextPageLbl: TextConst ENU = 'Page', NLD = 'Pagina';
        PostingDateCaptionLbl: TextConst ENU = 'Posting Date', NLD = 'Boekingsdatum';
        ReminderNoCaptionLbl: TextConst ENU = 'Reminder No.', NLD = 'Aanmaningsnr.';
        BankAccNoCaptionLbl: TextConst ENU = 'Account No.', NLD = 'Rekeningnr.';
        BankNameCaptionLbl: TextConst ENU = 'Bank', NLD = 'Bank';
        GiroNoCaptionLbl: TextConst ENU = 'Giro No.', NLD = 'Gironr.';
        VATRegNoCaptionLbl: TextConst ENU = 'Tax ID', NLD = 'Btw ID';
        PhoneNoCaptionLbl: TextConst ENU = 'Phone No.', NLD = 'Telefoon';
        ReminderCaptionLbl: TextConst ENU = 'Reminder', NLD = 'Aanmaning';
        HeaderDimensionsCaptionLbl: TextConst ENU = 'Header Dimensions', NLD = 'Kopdimensies';
        DocumentDateCaption1Lbl: TextConst ENU = 'Document Date', NLD = 'Documentdatum';
        InterestAmountCaptionLbl: TextConst ENU = 'Interest Amount', NLD = 'Rentebedrag';
        AmountIncVATCaptionLbl: TextConst ENU = 'Amount Including VAT', NLD = 'Bedrag incl. btw';
        VATAmtSpecCaptionLbl: TextConst ENU = 'VAT Amount Specification', NLD = 'Specificatie btw-bedrag';
        VATClausesCap: TextConst ENU = 'VAT Clause', NLD = 'Btw-clausule';
        VATIdentifierCap: TextConst ENU = 'VAT Identifier', NLD = 'Btw-identificatie';
        ContinuedCaptionLbl: TextConst ENU = 'Continued', NLD = 'Vervolg';
        ContinuedCaption1Lbl: TextConst ENU = 'Continued', NLD = 'Vervolg';
        DueDateCaptionLbl: TextConst ENU = 'Due Date', NLD = 'Vervaldatum';
        VATAmountCaptionLbl: TextConst ENU = 'VAT Amount', NLD = 'Btw-bedrag';
        VATBaseCaptionLbl: TextConst ENU = 'VAT Base', NLD = 'Basisbedrag btw';
        VATPercentCaptionLbl: TextConst ENU = 'VAT %', NLD = 'Btw %';
        TotalCaptionLbl: TextConst ENU = 'Total', NLD = 'Totaal';
        PageCaptionLbl: TextConst ENU = 'Page', NLD = 'Pagina';
        DocDateCaptionLbl: TextConst ENU = 'Document Date', NLD = 'Documentdatum';
        HomePageCaptionLbl: TextConst ENU = 'Home Page', NLD = 'Startpagina';
        EMailCaptionLbl: TextConst ENU = 'Email', NLD = 'E-mail';
        GreetingLbl: TextConst ENU = 'Hello', NLD = 'Hallo';
        AmtDueLbl: TextConst Comment = '%1 = A due date', ENU = 'You are receiving this email to formally notify you that payment owed by you is past due. The payment was due on %1. Enclosed is a copy of invoice with the details of remaining amount.', NLD = 'Met dit e-mailbericht wordt u formeel geïnformeerd over het feit dat een betaling die u verschuldigd bent, achterstallig is. De betaling had moeten worden voldaan op %1. Bijgesloten vindt u een kopie van de factuur met de details van het resterende bedrag.';
        BodyLbl: TextConst ENU = 'If you have already made the payment, please disregard this email. Thank you for your business.', NLD = 'Als u de betaling al hebt gedaan, kunt u dit e-mailbericht negeren. Bedankt voor uw aankoop.';
        ClosingLbl: TextConst ENU = 'Sincerely', NLD = 'Met vriendelijke groeten,';
        DescriptionLbl: TextConst ENU = 'Description', NLD = 'Beschrijving';
        AmtDueTxt: Text;
        RemainingAmt: Text;
        TotalRemAmt: Decimal;
        BICCaptionLbl: TextConst ENU = 'Routing No.', NLD = 'Banknr.';
        IBANCaptionLbl: TextConst ENU = 'Account No.', NLD = 'Accountnr';
        gTxtTaxID: Label '80-0608557';
        gTxtAccountNo: Label '3302641594';
        gTxtRoutingNo: Label '121140399';
}

