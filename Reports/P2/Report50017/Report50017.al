report 50017 "Aged Accounts Receivable US"
{
    // version NAVW111.00.00.19846,XSS5.080

    // 20190409 KBG NMSD-801: Layoutaanpassing
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Report50017\Aged Accounts Receivable US.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    CaptionML = ENU = 'Aged Accounts Receivable US',
                NLD = 'Vervallen vorderingen US';

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";
            column(TodayFormatted; TodayFormatted)
            {
            }
            column(CompanyName; CompanyDisplayName)
            {
            }
            column(FormatEndingDate; STRSUBSTNO(Text006, FORMAT(EndingDate, 0, 4)))
            {
            }
            column(PostingDate; STRSUBSTNO(Text007, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(PrintAmountInLCY; PrintAmountInLCY)
            {
            }
            column(TableCaptnCustFilter; TABLECAPTION + ': ' + CustFilter)
            {
            }
            column(CustFilter; CustFilter)
            {
            }
            column(AgingByDueDate; AgingBy = AgingBy::"Due Date")
            {
            }
            column(AgedbyDocumnetDate; STRSUBSTNO(Text004, SELECTSTR(AgingBy + 1, Text009)))
            {
            }
            column(HeaderText5; HeaderText[5])
            {
            }
            column(HeaderText4; HeaderText[4])
            {
            }
            column(HeaderText3; HeaderText[3])
            {
            }
            column(HeaderText2; HeaderText[2])
            {
            }
            column(HeaderText1; HeaderText[1])
            {
            }
            column(PrintDetails; PrintDetails)
            {
            }
            column(GrandTotalCLE5RemAmt; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE4RemAmt; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE3RemAmt; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE2RemAmt; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1RemAmt; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLEAmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
            {
                AutoFormatType = 1;
            }
            column(GrandTotalCLE1CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE2CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE3CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE4CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(GrandTotalCLE5CustRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
            {
            }
            column(AgedAccReceivableCptn; AgedAccReceivableCptnLbl)
            {
            }
            column(CurrReportPageNoCptn; CurrReportPageNoCptnLbl)
            {
            }
            column(AllAmtinLCYCptn; AllAmtinLCYCptnLbl)
            {
            }
            column(AgedOverdueAmtCptn; AgedOverdueAmtCptnLbl)
            {
            }
            column(CLEEndDateAmtLCYCptn; CLEEndDateAmtLCYCptnLbl)
            {
            }
            column(CLEEndDateDueDateCptn; CLEEndDateDueDateCptnLbl)
            {
            }
            column(CLEEndDateDocNoCptn; CLEEndDateDocNoCptnLbl)
            {
            }
            column(CLEEndDatePstngDateCptn; CLEEndDatePstngDateCptnLbl)
            {
            }
            column(CLEEndDateDocTypeCptn; CLEEndDateDocTypeCptnLbl)
            {
            }
            column(OriginalAmtCptn; OriginalAmtCptnLbl)
            {
            }
            column(TotalLCYCptn; TotalLCYCptnLbl)
            {
            }
            column(NewPagePercustomer; NewPagePercustomer)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(CountryGroupCptn; CountryGroupCptnLbl)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code");

                trigger OnAfterGetRecord();
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    CustLedgEntry.SETCURRENTKEY("Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Closed by Entry No.", "Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    if CustLedgEntry.FINDSET(false, false) then
                        repeat
                            InsertTemp(CustLedgEntry);
                        until CustLedgEntry.NEXT = 0;

                    if "Closed by Entry No." <> 0 then begin
                        CustLedgEntry.SETRANGE("Closed by Entry No.", "Closed by Entry No.");
                        if CustLedgEntry.FINDSET(false, false) then
                            repeat
                                InsertTemp(CustLedgEntry);
                            until CustLedgEntry.NEXT = 0;
                    end;

                    CustLedgEntry.RESET;
                    CustLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                    CustLedgEntry.SETRANGE("Posting Date", 0D, EndingDate);
                    if CustLedgEntry.FINDSET(false, false) then
                        repeat
                            InsertTemp(CustLedgEntry);
                        until CustLedgEntry.NEXT = 0;
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Posting Date", EndingDate + 1, DMY2DATE(31, 12, 9999));
                end;
            }
            dataitem(OpenCustLedgEntry; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Customer No.", Open, Positive, "Due Date", "Currency Code");

                trigger OnAfterGetRecord();
                begin
                    if AgingBy = AgingBy::"Posting Date" then begin
                        CALCFIELDS("Remaining Amt. (LCY)");
                        if "Remaining Amt. (LCY)" = 0 then
                            CurrReport.SKIP;
                    end;

                    InsertTemp(OpenCustLedgEntry);
                    CurrReport.SKIP;
                end;

                trigger OnPreDataItem();
                begin
                    if AgingBy = AgingBy::"Posting Date" then begin
                        SETRANGE("Posting Date", 0D, EndingDate);
                        SETRANGE("Date Filter", 0D, EndingDate);
                    end;
                end;
            }
            dataitem(CurrencyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                PrintOnlyIfDetail = true;
                dataitem(TempCustLedgEntryLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(Name1_Cust; Customer.Name)
                    {
                        IncludeCaption = true;
                    }
                    column(No_Cust; Customer."No.")
                    {
                        IncludeCaption = true;
                    }
                    column(CountryRegion_Cust; Customer."Country/Region Code")
                    {
                        IncludeCaption = true;
                    }
                    column(CountryGroup_CountryRegion; gRecCountryRegion."Country Group")
                    {
                        IncludeCaption = true;
                    }
                    column(CLEEndDateRemAmtLCY; CustLedgEntryEndingDate."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE1RemAmtLCY; AgedCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE2RemAmtLCY; AgedCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE3RemAmtLCY; AgedCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE4RemAmtLCY; AgedCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(AgedCLE5RemAmtLCY; AgedCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CLEEndDateAmtLCY; CustLedgEntryEndingDate."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CLEEndDueDate; FORMAT(CustLedgEntryEndingDate."Due Date"))
                    {
                    }
                    column(CLEEndDateDocNo; CustLedgEntryEndingDate."Document No.")
                    {
                    }
                    column(CLEDocType; FORMAT(CustLedgEntryEndingDate."Document Type"))
                    {
                    }
                    column(CLEPostingDate; FORMAT(CustLedgEntryEndingDate."Posting Date"))
                    {
                    }
                    column(AgedCLE5TempRemAmt; AgedCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE4TempRemAmt; AgedCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE3TempRemAmt; AgedCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE2TempRemAmt; AgedCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(AgedCLE1TempRemAmt; AgedCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(RemAmt_CLEEndDate; CustLedgEntryEndingDate."Remaining Amount")
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(CLEEndDate; CustLedgEntryEndingDate.Amount)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(Name_Cust; STRSUBSTNO(Text005, Customer.Name))
                    {
                    }
                    column(TotalCLE1AmtLCY; TotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1RemAmtLCY; TotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE2RemAmtLCY; TotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE3RemAmtLCY; TotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE4RemAmtLCY; TotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE5RemAmtLCY; TotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(CurrrencyCode; CurrencyCode)
                    {
                        AutoFormatExpression = CurrencyCode;
                        AutoFormatType = 1;
                    }
                    column(TotalCLE5RemAmt; TotalCustLedgEntry[5]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE4RemAmt; TotalCustLedgEntry[4]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE3RemAmt; TotalCustLedgEntry[3]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE2RemAmt; TotalCustLedgEntry[2]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1RemAmt; TotalCustLedgEntry[1]."Remaining Amount")
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCLE1Amt; TotalCustLedgEntry[1].Amount)
                    {
                        AutoFormatType = 1;
                    }
                    column(TotalCheck; CustFilterCheck)
                    {
                    }
                    column(GrandTotalCLE1AmtLCY; GrandTotalCustLedgEntry[1]."Amount (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE5PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE3PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE2PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE1PctRemAmtLCY; Pct(GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)", GrandTotalCustLedgEntry[1]."Amount (LCY)"))
                    {
                    }
                    column(GrandTotalCLE5RemAmtLCY; GrandTotalCustLedgEntry[5]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE4RemAmtLCY; GrandTotalCustLedgEntry[4]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE3RemAmtLCY; GrandTotalCustLedgEntry[3]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE2RemAmtLCY; GrandTotalCustLedgEntry[2]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }
                    column(GrandTotalCLE1RemAmtLCY; GrandTotalCustLedgEntry[1]."Remaining Amt. (LCY)")
                    {
                        AutoFormatType = 1;
                    }

                    trigger OnAfterGetRecord();
                    var
                        PeriodIndex: Integer;
                    begin
                        if Number = 1 then begin
                            if not TempCustLedgEntry.FINDSET(false, false) then
                                CurrReport.BREAK;
                        end else
                            if TempCustLedgEntry.NEXT = 0 then
                                CurrReport.BREAK;

                        CustLedgEntryEndingDate := TempCustLedgEntry;
                        DetailedCustomerLedgerEntry.SETRANGE("Cust. Ledger Entry No.", CustLedgEntryEndingDate."Entry No.");
                        if DetailedCustomerLedgerEntry.FINDSET(false, false) then
                            repeat
                                if (DetailedCustomerLedgerEntry."Entry Type" =
                                    DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry") and
                                   (CustLedgEntryEndingDate."Posting Date" > EndingDate) and
                                   (AgingBy <> AgingBy::"Posting Date")
                                then begin
                                    if CustLedgEntryEndingDate."Document Date" <= EndingDate then
                                        DetailedCustomerLedgerEntry."Posting Date" :=
                                          CustLedgEntryEndingDate."Document Date"
                                    else
                                        if (CustLedgEntryEndingDate."Due Date" <= EndingDate) and
                                           (AgingBy = AgingBy::"Due Date")
                                        then
                                            DetailedCustomerLedgerEntry."Posting Date" :=
                                              CustLedgEntryEndingDate."Due Date"
                                end;

                                if (DetailedCustomerLedgerEntry."Posting Date" <= EndingDate) or
                                   (TempCustLedgEntry.Open and
                                    (AgingBy = AgingBy::"Due Date") and
                                    (CustLedgEntryEndingDate."Due Date" > EndingDate) and
                                    (CustLedgEntryEndingDate."Posting Date" <= EndingDate))
                                then begin
                                    if DetailedCustomerLedgerEntry."Entry Type" in
                                       [DetailedCustomerLedgerEntry."Entry Type"::"Initial Entry",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Loss",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Unrealized Gain",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Realized Loss",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Realized Gain",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount (VAT Adjustment)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Tolerance (VAT Adjustment)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                        DetailedCustomerLedgerEntry."Entry Type"::"Payment Discount Tolerance (VAT Adjustment)"]
                                    then begin
                                        CustLedgEntryEndingDate.Amount := CustLedgEntryEndingDate.Amount + DetailedCustomerLedgerEntry.Amount;
                                        CustLedgEntryEndingDate."Amount (LCY)" :=
                                          CustLedgEntryEndingDate."Amount (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    end;
                                    if DetailedCustomerLedgerEntry."Posting Date" <= EndingDate then begin
                                        CustLedgEntryEndingDate."Remaining Amount" :=
                                          CustLedgEntryEndingDate."Remaining Amount" + DetailedCustomerLedgerEntry.Amount;
                                        CustLedgEntryEndingDate."Remaining Amt. (LCY)" :=
                                          CustLedgEntryEndingDate."Remaining Amt. (LCY)" + DetailedCustomerLedgerEntry."Amount (LCY)";
                                    end;
                                end;
                            until DetailedCustomerLedgerEntry.NEXT = 0;

                        if CustLedgEntryEndingDate."Remaining Amount" = 0 then
                            CurrReport.SKIP;

                        case AgingBy of
                            AgingBy::"Due Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Due Date");
                            AgingBy::"Posting Date":
                                PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Posting Date");
                            AgingBy::"Document Date":
                                begin
                                    if CustLedgEntryEndingDate."Document Date" > EndingDate then begin
                                        CustLedgEntryEndingDate."Remaining Amount" := 0;
                                        CustLedgEntryEndingDate."Remaining Amt. (LCY)" := 0;
                                        CustLedgEntryEndingDate."Document Date" := CustLedgEntryEndingDate."Posting Date";
                                    end;
                                    PeriodIndex := GetPeriodIndex(CustLedgEntryEndingDate."Document Date");
                                end;
                        end;
                        CLEAR(AgedCustLedgEntry);
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amount" := CustLedgEntryEndingDate."Remaining Amount";
                        AgedCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" := CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amount" += CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[PeriodIndex]."Remaining Amt. (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        TotalCustLedgEntry[1].Amount += CustLedgEntryEndingDate."Remaining Amount";
                        TotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                        GrandTotalCustLedgEntry[1]."Amount (LCY)" += CustLedgEntryEndingDate."Remaining Amt. (LCY)";
                    end;

                    trigger OnPostDataItem();
                    begin
                        if not PrintAmountInLCY then
                            UpdateCurrencyTotals;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if not PrintAmountInLCY then begin
                            if (TempCurrency.Code = '') or (TempCurrency.Code = GLSetup."LCY Code") then
                                TempCustLedgEntry.SETFILTER("Currency Code", '%1|%2', GLSetup."LCY Code", '')
                            else
                                TempCustLedgEntry.SETRANGE("Currency Code", TempCurrency.Code);
                        end;

                        PageGroupNo := NextPageGroupNo;
                        if NewPagePercustomer and (NumberOfCurrencies > 0) then
                            NextPageGroupNo := PageGroupNo + 1;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(TotalCustLedgEntry);

                    if Number = 1 then begin
                        if not TempCurrency.FINDSET(false, false) then
                            CurrReport.BREAK;
                    end else
                        if TempCurrency.NEXT = 0 then
                            CurrReport.BREAK;

                    if TempCurrency.Code <> '' then
                        CurrencyCode := TempCurrency.Code
                    else
                        CurrencyCode := GLSetup."LCY Code";

                    NumberOfCurrencies := NumberOfCurrencies + 1;
                end;

                trigger OnPreDataItem();
                begin
                    NumberOfCurrencies := 0;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if NewPagePercustomer then
                    PageGroupNo += 1;
                TempCurrency.RESET;
                TempCurrency.DELETEALL;
                TempCustLedgEntry.RESET;
                TempCustLedgEntry.DELETEALL;
                if not gRecCountryRegion.GET(Customer."Country/Region Code") then
                    gRecCountryRegion.INIT;
            end;
        }
        dataitem(CurrencyTotals; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
            column(CurrNo; Number = 1)
            {
            }
            column(TempCurrCode; TempCurrency2.Code)
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE6RemAmt; AgedCustLedgEntry[6]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE1RemAmt; AgedCustLedgEntry[1]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE2RemAmt; AgedCustLedgEntry[2]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE3RemAmt; AgedCustLedgEntry[3]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE4RemAmt; AgedCustLedgEntry[4]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(AgedCLE5RemAmt; AgedCustLedgEntry[5]."Remaining Amount")
            {
                AutoFormatExpression = CurrencyCode;
                AutoFormatType = 1;
            }
            column(CurrSpecificationCptn; CurrSpecificationCptnLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                if Number = 1 then begin
                    if not TempCurrency2.FINDSET(false, false) then
                        CurrReport.BREAK;
                end else
                    if TempCurrency2.NEXT = 0 then
                        CurrReport.BREAK;

                CLEAR(AgedCustLedgEntry);
                TempCurrencyAmount.SETRANGE("Currency Code", TempCurrency2.Code);
                if TempCurrencyAmount.FINDSET(false, false) then
                    repeat
                        if TempCurrencyAmount.Date <> DMY2DATE(31, 12, 9999) then
                            AgedCustLedgEntry[GetPeriodIndex(TempCurrencyAmount.Date)]."Remaining Amount" :=
                              TempCurrencyAmount.Amount
                        else
                            AgedCustLedgEntry[6]."Remaining Amount" := TempCurrencyAmount.Amount;
                    until TempCurrencyAmount.NEXT = 0;
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
                    field(AgedAsOf; EndingDate)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Aged As Of',
                                    NLD = 'Vervallen op';
                        ToolTipML = ENU = 'Specifies the date that you want the aging calculated for.',
                                    NLD = 'Hiermee wordt de datum opgegeven waarvoor u het verval wilt berekenen.';
                    }
                    field(Agingby; AgingBy)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Aging by',
                                    NLD = 'Vervallen per';
                        OptionCaptionML = ENU = 'Due Date,Posting Date,Document Date',
                                          NLD = 'Vervaldatum,Boekingsdatum,Documentdatum';
                        ToolTipML = ENU = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.',
                                    NLD = 'Hiermee wordt opgegeven of het verval wordt berekend vanaf de vervaldatum, de boekingsdatum of de documentdatum.';
                    }
                    field(PeriodLength; PeriodLength)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Period Length',
                                    NLD = 'Periodelengte';
                        ToolTipML = ENU = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.',
                                    NLD = 'Hiermee wordt de periode opgegeven waarvoor gegevens worden weergegeven in het rapport, bijvoorbeeld ''1M'' voor één maand, ''30D'' voor dertig dagen ''3Q'' voor drie kwartaal of ''5Y'' voor vijf jaar.';
                    }
                    field(AmountsinLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Amounts in LCY',
                                    NLD = 'Bedragen in LV afdrukken';
                        ToolTipML = ENU = 'Specifies if you want the report to specify the aging per customer ledger entry.',
                                    NLD = 'Hiermee wordt opgegeven of u het verval per klantenpost wilt weergeven in het rapport.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Details',
                                    NLD = 'Details afdrukken';
                        ToolTipML = ENU = 'Specifies if you want the report to show the detailed entries that add up the total balance for each customer.',
                                    NLD = 'Hiermee wordt opgegeven of u gedetailleerde posten in het rapport wilt weergeven die samen het totale saldo voor elke klant vormen.';
                    }
                    field(HeadingType; HeadingType)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Heading Type',
                                    NLD = 'Type kop';
                        OptionCaptionML = ENU = 'Date Interval,Number of Days',
                                          NLD = 'Datuminterval,Aantal dagen';
                        ToolTipML = ENU = 'Specifies if the column heading for the three periods will indicate a date interval or the number of days overdue.',
                                    NLD = 'Hiermee wordt opgegeven of de kolomkop voor de drie perioden een datuminterval moet weergeven of het aantal dagen dat de betalingstermijn is verstreken.';
                    }
                    field(perCustomer; NewPagePercustomer)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'New Page per Customer',
                                    NLD = 'Nieuwe pagina per klant';
                        ToolTipML = ENU = 'Specifies if each customer''s information is printed on a new page if you have chosen two or more customers to be included in the report.',
                                    NLD = 'Hiermee wordt opgegeven of de gegevens van de klant op een nieuwe pagina moeten worden afgedrukt als u hebt opgegeven dat u twee of meer klanten in het rapport wilt opnemen.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            if EndingDate = 0D then
                EndingDate := WORKDATE;
            if FORMAT(PeriodLength) = '' then
                EVALUATE(PeriodLength, '<1M>');
        end;
    }

    labels
    {
        label(BalanceCaption; ENU = 'Balance',
                             NLD = 'Saldo')
    }

    trigger OnPreReport();
    var
    //CaptionManagement : Codeunit CaptionManagement;
    begin
        CustFilter := Customer.GetFilters; //CaptionManagement.GetRecordFiltersWithCaptions(Customer);/Krishna

        GLSetup.GET;

        CalcDates;
        CreateHeadings;

        PageGroupNo := 1;
        NextPageGroupNo := 1;
        CustFilterCheck := (CustFilter <> 'No.');

        TodayFormatted := TypeHelper.GetFormattedCurrentDateTimeInUserTimeZone('f');
        CompanyDisplayName := COMPANYPROPERTY.DISPLAYNAME;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        TempCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        CustLedgEntryEndingDate: Record "Cust. Ledger Entry";
        TotalCustLedgEntry: array[5] of Record "Cust. Ledger Entry";
        GrandTotalCustLedgEntry: array[5] of Record "Cust. Ledger Entry";
        AgedCustLedgEntry: array[6] of Record "Cust. Ledger Entry";
        TempCurrency: Record Currency temporary;
        TempCurrency2: Record Currency temporary;
        TempCurrencyAmount: Record "Currency Amount" temporary;
        DetailedCustomerLedgerEntry: Record "Detailed Cust. Ledg. Entry";
        TypeHelper: Codeunit "Type Helper";
        CustFilter: Text;
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePercustomer: Boolean;
        PeriodStartDate: array[5] of Date;
        PeriodEndDate: array[5] of Date;
        HeaderText: array[5] of Text[30];
        Text000: TextConst ENU = 'Not Due', NLD = 'Niet vervallen';
        Text001: TextConst ENU = 'Before', NLD = 'Voor';
        CurrencyCode: Code[10];
        Text002: TextConst ENU = 'days', NLD = 'dagen';
        Text003: TextConst ENU = 'More than', NLD = 'Meer dan';
        Text004: TextConst ENU = 'Aged by %1', NLD = 'Vervallen per %1';
        Text005: TextConst ENU = 'Total for %1', NLD = 'Totaal voor %1';
        Text006: TextConst ENU = 'Aged as of %1', NLD = 'Vervallen op %1';
        Text007: TextConst ENU = 'Aged by %1', NLD = 'Vervallen per %1';
        NumberOfCurrencies: Integer;
        Text009: TextConst ENU = 'Due Date,Posting Date,Document Date', NLD = 'Vervaldatum,Boekingsdatum,Documentdatum';
        Text010: TextConst ENU = 'The Date Formula %1 cannot be used. Try to restate it. E.g. 1M+CM instead of CM+1M.', NLD = 'De datumformule %1 kan niet gebruikt worden. Probeer ze anders te formuleren, bijvoorbeeld 1M+CM i.p.v. CM+1M.';
        PageGroupNo: Integer;
        NextPageGroupNo: Integer;
        CustFilterCheck: Boolean;
        Text032: TextConst Comment = 'Negating the period length: %1 is the period length', ENU = '-%1', NLD = '-%1';
        AgedAccReceivableCptnLbl: TextConst ENU = 'Aged Accounts Receivable', NLD = 'Vervallen vorderingen';
        CurrReportPageNoCptnLbl: TextConst ENU = 'Page', NLD = 'Pagina';
        AllAmtinLCYCptnLbl: TextConst ENU = 'All Amounts in LCY', NLD = 'Alle bedragen in LV';
        AgedOverdueAmtCptnLbl: TextConst ENU = 'Aged Overdue Amounts', NLD = 'Vervallen bedragen';
        CLEEndDateAmtLCYCptnLbl: TextConst ENU = 'Original Amount ', NLD = 'Oorspronkelijke bedrag ';
        CLEEndDateDueDateCptnLbl: TextConst ENU = 'Due Date', NLD = 'Vervaldatum';
        CLEEndDateDocNoCptnLbl: TextConst ENU = 'Document No.', NLD = 'Documentnr.';
        CLEEndDatePstngDateCptnLbl: TextConst ENU = 'Posting Date', NLD = 'Boekingsdatum';
        CLEEndDateDocTypeCptnLbl: TextConst ENU = 'Document Type', NLD = 'Documenttype';
        OriginalAmtCptnLbl: TextConst ENU = 'Currency Code', NLD = 'Valutacode';
        TotalLCYCptnLbl: TextConst ENU = 'Total (LCY)', NLD = 'Totaal (LV)';
        CurrSpecificationCptnLbl: TextConst ENU = 'Currency Specification', NLD = 'Valutaspecificatie';
        EnterDateFormulaErr: TextConst ENU = 'Enter a date formula in the Period Length field.', NLD = 'Voer in het veld Periodelengte een datumformule in.';
        TodayFormatted: Text;
        CompanyDisplayName: Text;
        gRecCountryRegion: Record "Country/Region";
        CountryGroupCptnLbl: TextConst ENU = 'Country Group', NLD = 'Landgroep';

    local procedure CalcDates();
    var
        i: Integer;
        PeriodLength2: DateFormula;
    begin
        if not EVALUATE(PeriodLength2, STRSUBSTNO(Text032, PeriodLength)) then
            ERROR(EnterDateFormulaErr);
        if AgingBy = AgingBy::"Due Date" then begin
            PeriodEndDate[1] := DMY2DATE(31, 12, 9999);
            PeriodStartDate[1] := EndingDate + 1;
        end else begin
            PeriodEndDate[1] := EndingDate;
            PeriodStartDate[1] := CALCDATE(PeriodLength2, EndingDate + 1);
        end;
        for i := 2 to ARRAYLEN(PeriodEndDate) do begin
            PeriodEndDate[i] := PeriodStartDate[i - 1] - 1;
            PeriodStartDate[i] := CALCDATE(PeriodLength2, PeriodEndDate[i] + 1);
        end;
        PeriodStartDate[i] := 0D;

        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if PeriodEndDate[i] < PeriodStartDate[i] then
                ERROR(Text010, PeriodLength);
    end;

    local procedure CreateHeadings();
    var
        i: Integer;
    begin
        if AgingBy = AgingBy::"Due Date" then begin
            HeaderText[1] := Text000;
            i := 2;
        end else
            i := 1;
        while i < ARRAYLEN(PeriodEndDate) do begin
            if HeadingType = HeadingType::"Date Interval" then
                HeaderText[i] := STRSUBSTNO('%1\..%2', PeriodStartDate[i], PeriodEndDate[i])
            else
                HeaderText[i] :=
                  STRSUBSTNO('%1 - %2 %3', EndingDate - PeriodEndDate[i] + 1, EndingDate - PeriodStartDate[i] + 1, Text002);
            i := i + 1;
        end;
        if HeadingType = HeadingType::"Date Interval" then
            HeaderText[i] := STRSUBSTNO('%1 %2', Text001, PeriodStartDate[i - 1])
        else
            HeaderText[i] := STRSUBSTNO('%1 \%2 %3', Text003, EndingDate - PeriodStartDate[i - 1] + 1, Text002);
    end;

    local procedure InsertTemp(var CustLedgEntry: Record "Cust. Ledger Entry");
    var
        Currency: Record Currency;
    begin
        if TempCustLedgEntry.GET(CustLedgEntry."Entry No.") then
            exit;
        TempCustLedgEntry := CustLedgEntry;
        TempCustLedgEntry.INSERT;
        if PrintAmountInLCY then begin
            CLEAR(TempCurrency);
            TempCurrency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
            if TempCurrency.INSERT then;
            exit;
        end;
        if TempCurrency.GET(TempCustLedgEntry."Currency Code") then
            exit;
        if TempCurrency.GET('') and (TempCustLedgEntry."Currency Code" = GLSetup."LCY Code") then
            exit;
        if TempCurrency.GET(GLSetup."LCY Code") and (TempCustLedgEntry."Currency Code" = '') then
            exit;
        if TempCustLedgEntry."Currency Code" <> '' then
            Currency.GET(TempCustLedgEntry."Currency Code")
        else begin
            CLEAR(Currency);
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        end;
        TempCurrency := Currency;
        TempCurrency.INSERT;
    end;

    local procedure GetPeriodIndex(Date: Date): Integer;
    var
        i: Integer;
    begin
        for i := 1 to ARRAYLEN(PeriodEndDate) do
            if Date in [PeriodStartDate[i] .. PeriodEndDate[i]] then
                exit(i);
    end;

    local procedure Pct(a: Decimal; b: Decimal): Text[30];
    begin
        if b <> 0 then
            exit(FORMAT(ROUND(100 * a / b, 0.1), 0, '<Sign><Integer><Decimals,2>') + '%');
    end;

    local procedure UpdateCurrencyTotals();
    var
        i: Integer;
    begin
        TempCurrency2.Code := CurrencyCode;
        if TempCurrency2.INSERT then;
        for i := 1 to ARRAYLEN(TotalCustLedgEntry) do begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := PeriodStartDate[i];
            if TempCurrencyAmount.FIND then begin
                TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalCustLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.MODIFY;
            end else begin
                TempCurrencyAmount."Currency Code" := CurrencyCode;
                TempCurrencyAmount.Date := PeriodStartDate[i];
                TempCurrencyAmount.Amount := TotalCustLedgEntry[i]."Remaining Amount";
                TempCurrencyAmount.INSERT;
            end;
        end;
        TempCurrencyAmount."Currency Code" := CurrencyCode;
        TempCurrencyAmount.Date := DMY2DATE(31, 12, 9999);
        if TempCurrencyAmount.FIND then begin
            TempCurrencyAmount.Amount := TempCurrencyAmount.Amount + TotalCustLedgEntry[1].Amount;
            TempCurrencyAmount.MODIFY;
        end else begin
            TempCurrencyAmount."Currency Code" := CurrencyCode;
            TempCurrencyAmount.Date := DMY2DATE(31, 12, 9999);
            TempCurrencyAmount.Amount := TotalCustLedgEntry[1].Amount;
            TempCurrencyAmount.INSERT;
        end;
    end;

    procedure InitializeRequest(NewEndingDate: Date; NewAgingBy: Option; NewPeriodLength: DateFormula; NewPrintAmountInLCY: Boolean; NewPrintDetails: Boolean; NewHeadingType: Option; NewPagePercust: Boolean);
    begin
        EndingDate := NewEndingDate;
        AgingBy := NewAgingBy;
        PeriodLength := NewPeriodLength;
        PrintAmountInLCY := NewPrintAmountInLCY;
        PrintDetails := NewPrintDetails;
        HeadingType := NewHeadingType;
        NewPagePercustomer := NewPagePercust;
    end;
}

