report 50016 "Aged Accounts Payable US"
{
    // version XSS5.080

    // 20190328 KBG NMSD-975: New Report
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Report50016\Aged Accounts Payable US.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    CaptionML = ENU = 'Aged Accounts Payable US',
                NLD = 'Vervallen betalingen US';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Vendor Posting Group", "Payment Terms Code", "Purchaser Code";
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date", "Currency Code");

                trigger OnAfterGetRecord();
                begin
                    SETRANGE("Date Filter", 0D, PeriodEndingDate[1]);
                    CALCFIELDS("Remaining Amount");
                    if "Remaining Amount" <> 0 then
                        InsertTemp("Vendor Ledger Entry");
                    CurrReport.SKIP;    //  this fools the system into thinking that no details "printed"...yet
                end;

                trigger OnPreDataItem();
                begin
                    // Find ledger entries which are posted before the date of the aging.
                    SETRANGE("Posting Date", 0D, PeriodEndingDate[1]);

                    if (ShowOnlyOverDueBy <> '') and not (ShowAllForOverdue) then
                        SETRANGE("Due Date", 0D, CalculatedDate);
                end;
            }
            dataitem(Totals; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(VendorNo; Vendor."No.")
                {
                    IncludeCaption = true;
                }
                column(VendorName; Vendor.Name)
                {
                    IncludeCaption = true;
                }
                column(VendorCurrency; Vendor."Currency Code")
                {
                    IncludeCaption = true;
                }
                column(AgingDate; FORMAT(AgingDate, 0, '<Day>-<Month>-<Year4>'))
                {
                }
                column(Description_VendorLedgerEntry; "Vendor Ledger Entry".Description)
                {
                    IncludeCaption = true;
                }
                column(DocType_VendorLedgerEntry; "Vendor Ledger Entry"."Document Type")
                {
                    IncludeCaption = true;
                }
                column(DocumentNo; DocNo)
                {
                }
                column(AmountDueToPrint; AmountDueToPrint)
                {
                }
                column(CurrencyCodeToPrint; CurrencyCodeToPrint)
                {
                }
                column(AmountDue1; AmountDue[1])
                {
                }
                column(AmountDue2; AmountDue[2])
                {
                }
                column(AmountDue3; AmountDue[3])
                {
                }
                column(AmountDue4; AmountDue[4])
                {
                }
                column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
                {
                }
                column(ReportNameCaption; ReportNameCapionLbl)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(DateCaption; DateTitle)
                {
                }
                column(ShortDateCaption; ShortDateTitle)
                {
                }
                column(DocNoCaption; DocNoCaptionLbl)
                {
                }
                column(AmountToPrintCaption; AmountToPrintCaptionLbl)
                {
                }
                column(CurrencyCodeToPrintCaption; CurrencyCodeToPrintCaptionLbl)
                {
                }
                column(ColumnHead1Caption; ColumnHead[1])
                {
                }
                column(ColumnHead2Caption; ColumnHead[2])
                {
                }
                column(ColumnHead3Caption; ColumnHead[3])
                {
                }
                column(ColumnHead4Caption; ColumnHead[4])
                {
                }
                column(PrintDetails; PrintDetails)
                {
                }

                trigger OnAfterGetRecord();
                begin

                    if Number = 1 then
                        TempVendLedgEntry.FIND('-')
                    else
                        TempVendLedgEntry.NEXT;
                    TempVendLedgEntry.SETRANGE("Date Filter", 0D, PeriodEndingDate[1]);
                    TempVendLedgEntry.CALCFIELDS("Remaining Amount", "Remaining Amt. (LCY)");
                    if TempVendLedgEntry."Remaining Amount" = 0 then
                        CurrReport.SKIP;
                    if TempVendLedgEntry."Currency Code" <> '' then
                        /*TempVendLedgEntry."Remaining Amt. (LCY)" :=
                          ROUND(
                            CurrExchRate.ExchangeAmtFCYToFCY(
                              PeriodEndingDate[1],
                              TempVendLedgEntry."Currency Code",
                              '',
                              TempVendLedgEntry."Remaining Amount"));kk*/
                    if PrintAmountInLCY then begin
                            /*TempVendLedgEntry."Remaining Amount" :=
                              ROUND(
                                CurrExchRate.ExchangeAmtFCYToFCY(
                                  PeriodEndingDate[1],
                                  TempVendLedgEntry."Currency Code",
                                  Vendor."Currency Code",
                                  TempVendLedgEntry."Remaining Amount"),
                                Currency."Amount Rounding Precision");kk*/
                            AmountDueToPrint := TempVendLedgEntry."Remaining Amt. (LCY)";
                            //AmountDueToPrint := TempVendLedgEntry."Remaining Amount";
                        end else
                            AmountDueToPrint := TempVendLedgEntry."Remaining Amount";
                    //  AmountDueToPrint := TempVendLedgEntry."Remaining Amt. (LCY)";

                    case AgingMethod of
                        AgingMethod::"Due Date":
                            AgingDate := TempVendLedgEntry."Due Date";
                        AgingMethod::"Trans Date":
                            AgingDate := TempVendLedgEntry."Posting Date";
                        AgingMethod::"Document Date":
                            AgingDate := TempVendLedgEntry."Document Date";
                    end;
                    j := 0;
                    while AgingDate <= PeriodEndingDate[j + 1] do
                        j := j + 1;
                    if j = 0 then
                        j := 1;
                    clear(AmountDue);//Added on 8DEC2021
                    AmountDue[j] := AmountDueToPrint;
                    "BalanceDue$"[j] := "BalanceDue$"[j] + TempVendLedgEntry."Remaining Amt. (LCY)";


                    "Vendor Ledger Entry" := TempVendLedgEntry;
                    if UseExternalDocNo then
                        DocNo := "Vendor Ledger Entry"."External Document No."
                    else
                        DocNo := "Vendor Ledger Entry"."Document No.";

                    // Do NOT use the following fields in the sections:
                    //   "Applied-To Doc. Type"
                    //   "Applied-To Doc. No."
                    //   Open
                    //   "Paym. Disc. Taken"
                    //   "Closed by Entry No."
                    //   "Closed at Date"
                    //   "Closed by Amount"


                    if PrintAmountInLCY then begin
                        if PrintDetails then
                            CurrencyCodeToPrint := "Vendor Ledger Entry"."Currency Code"
                        else
                            CurrencyCodeToPrint := Vendor."Currency Code";
                        if CurrencyCodeToPrint = '' then
                            CurrencyCodeToPrint := GLSetup."LCY Code";
                    end;
                end;

                trigger OnPreDataItem();
                var
                    CurrencyCodeToPrint: Code[20];
                begin
                    //CurrReport.CREATETOTALS(AmountDueToPrint, AmountDue);//Krishna
                    SETRANGE(Number, 1, TempVendLedgEntry.COUNT);
                    TempVendLedgEntry.SETCURRENTKEY("Vendor No.", "Posting Date");
                end;
            }

            trigger OnAfterGetRecord();
            var
                VendLedgEntry: Record "Vendor Ledger Entry";
            begin
                if PrintAmountInLCY then begin
                    GetCurrencyRecord(Currency, "Currency Code");
                    CurrencyFactor := CurrExchRate.ExchangeRate(PeriodEndingDate[1], "Currency Code");
                end;

                if Blocked <> Blocked::" " then
                    BlockedDescription := STRSUBSTNO(Text50002, Blocked)
                else
                    BlockedDescription := '';

                TempVendLedgEntry.DELETEALL;

                if ShowOnlyOverDueBy <> '' then
                    CalculatedDate := CALCDATE('-' + ShowOnlyOverDueBy, PeriodEndingDate[1]);

                if ShowAllForOverdue and (ShowOnlyOverDueBy <> '') then begin
                    VendLedgEntry.SETRANGE("Vendor No.", "No.");
                    VendLedgEntry.SETRANGE(Open, true);
                    VendLedgEntry.SETRANGE("Due Date", 0D, CalculatedDate);
                    if not (VendLedgEntry.FINDSET) then CurrReport.SKIP;
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
                    CaptionML = ENU = 'Options',
                                NLD = 'Opties';
                    field(AgedAsOf; PeriodEndingDate[1])
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Aged As Of',
                                    NLD = 'Vervallen op';
                        ToolTipML = ENU = 'Specifies the date that you want the aging calculated for.',
                                    NLD = 'Hiermee wordt de datum opgegeven waarvoor u het verval wilt berekenen.';
                    }
                    field(AgingBy; AgingMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Aging by',
                                    NLD = 'Vervallen per';
                        OptionCaptionML = ENU = 'Due Date,Posting Date,Document Date',
                                          NLD = 'Vervaldatum,Boekingsdatum,Documentdatum';
                        ToolTipML = ENU = 'Specifies if the aging will be calculated from the due date, the posting date, or the document date.',
                                    NLD = 'Hiermee wordt opgegeven of het verval wordt berekend vanaf de vervaldatum, de boekingsdatum of de documentdatum.';
                    }
                    field(PeriodLength; PeriodCalculation)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Period Length',
                                    NLD = 'Periodelengte';
                        ToolTipML = ENU = 'Specifies the period for which data is shown in the report. For example, enter "1M" for one month, "30D" for thirty days, "3Q" for three quarters, or "5Y" for five years.',
                                    NLD = 'Hiermee wordt de periode opgegeven waarvoor gegevens worden weergegeven in het rapport, bijvoorbeeld ''1M'' voor één maand, ''30D'' voor dertig dagen ''3Q'' voor drie kwartaal of ''5Y'' voor vijf jaar.';
                    }
                    field(ShowOnlyOverDueBy; ShowOnlyOverDueBy)
                    {
                        Caption = 'Show if Overdue By';
                        ApplicationArea = All;
                    }
                    field(ShowAllForOverdue; ShowAllForOverdue)
                    {
                        Caption = 'Show All for Overdue';
                        ApplicationArea = All;
                    }
                    field(PrintAmountInLCY; PrintAmountInLCY)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Amounts in LCY',
                                    NLD = 'Bedragen in LV afdrukken';
                        ToolTipML = ENU = 'Specifies if you want the report to specify the aging per vendor ledger entry.',
                                    NLD = 'Hiermee wordt opgegeven of u het verval per leverancierspost wilt weergeven in het rapport.';
                    }
                    field(PrintDetails; PrintDetails)
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'Print Details',
                                    NLD = 'Details afdrukken';
                        ToolTipML = ENU = 'Specifies if you want the report to show the detailed entries that add up the total balance for each vendor.',
                                    NLD = 'Hiermee wordt opgegeven of u gedetailleerde posten in het rapport wilt weergeven die samen het totale saldo voor elke leverancier vormen.';
                    }
                    field(UseExternalDocNo; UseExternalDocNo)
                    {
                        Caption = 'Use External Doc. No';
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            if PeriodEndingDate[1] = 0D then begin
                PeriodEndingDate[1] := WORKDATE;
                PeriodCalculation := Text50001;
            end;
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CompanyInformation.GET;
        GLSetup.GET;
        FilterString := Vendor.GETFILTERS;

        if AgingMethod = AgingMethod::"Due Date" then begin
            PeriodEndingDate[2] := PeriodEndingDate[1];
            for j := 3 to 4 do
                PeriodEndingDate[j] := CALCDATE('-(' + PeriodCalculation + ')', PeriodEndingDate[j - 1]);
        end else begin
            for j := 2 to 4 do
                PeriodEndingDate[j] := CALCDATE('-(' + PeriodCalculation + ')', PeriodEndingDate[j - 1]);
        end;
        PeriodEndingDate[5] := 0D;


        if PeriodEndingDate[1] = 0D then
            PeriodEndingDate[1] := WORKDATE;

        if PrintDetails then begin
            SubTitle := Text50004;
        end else begin
            SubTitle := Text50005;
        end;
        SubTitle := SubTitle + Text50006 + ' ' + FORMAT(PeriodEndingDate[1], 0, 4) + ')';

        if AgingMethod = AgingMethod::"Due Date" then begin
            DateTitle := Text50007;
            ShortDateTitle := Text50008;
            ColumnHead[2] := Text50009 + ' '
                             + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                             + ' ' + Text50010;
            ColumnHeadHead := ' ' + Text50011 + ' ';
        end else
            if AgingMethod = AgingMethod::"Trans Date" then begin
                DateTitle := Text50012;
                ShortDateTitle := Text50013;
                ColumnHead[2] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                                 + ' - '
                                 + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                                 + ' ' + Text50010;
                ColumnHeadHead := ' ' + Text50014 + ' ';
            end else begin
                DateTitle := Text50015;
                ShortDateTitle := Text50016;
                ColumnHead[2] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[2] + 1)
                                 + ' - '
                                 + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3])
                                 + ' ' + Text50010;
                ColumnHeadHead := ' ' + Text50017 + ' ';
            end;

        ColumnHead[1] := Text50018;
        ColumnHead[3] := FORMAT(PeriodEndingDate[1] - PeriodEndingDate[3] + 1)
                         + ' - '
                         + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[4])
                         + ' ' + Text50010;
        ColumnHead[4] := 'Over '
                         + FORMAT(PeriodEndingDate[1] - PeriodEndingDate[4])
                         + ' ' + Text50010;
    end;

    var
        wgRecLanguage: Record Language;
        //wgCduDocCreatorTransLationMgt : Codeunit wDocCreatorTranslationMgt;
        wgReportId: Integer;
        CompanyInformation: Record "Company Information";
        TempVendLedgEntry: Record "Vendor Ledger Entry" temporary;
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
        PrintAmountInLCY: Boolean;
        EndingDate: Date;
        //AgingBy: Option "Due Date","Posting Date","Document Date";
        PeriodLength: DateFormula;
        PrintDetails: Boolean;
        HeadingType: Option "Date Interval","Number of Days";
        NewPagePerVendor: Boolean;
        ShowOnlyOverDueBy: Code[10];
        ShowAllForOverdue: Boolean;
        UseExternalDocNo: Boolean;
        AgingMethod: Option "Due Date","Trans Date","Document Date";
        FilterString: Text[250];
        j: Integer;
        PeriodEndingDate: array[5] of Date;
        PeriodCalculation: Code[20];
        Text50001: TextConst ENU = '30D', ESM = '30D', FRC = '30D', ENC = '30D';
        Text50002: TextConst ENU = '*** This vendor is blocked for %1 processing ***', ESM = '*** Proveedor bloqueado para el proceso %1 ***', FRC = '*** Le traitement de %1 pour ce fournisseur est bloqué ***', ENC = '*** This vendor is blocked for %1 processing ***';
        Text50004: TextConst ENU = '(Detail', ESM = '(Detalle', FRC = '(Détail', ENC = '(Detail';
        Text50005: TextConst ENU = '(Summary', ESM = '(Resumen', FRC = '(Sommaire', ENC = '(Summary';
        Text50006: TextConst ENU = ', aged as of', ESM = ', vencido desde', FRC = ', en date du', ENC = ', aged as of';
        Text50007: TextConst ENU = 'due date.', ESM = 'fecha vto.', FRC = 'date d''échéance.', ENC = 'due date.';
        Text50008: TextConst ENU = 'Due Date', ESM = 'Fecha vencimiento', FRC = 'Date d''échéance', ENC = 'Due Date';
        Text50009: TextConst ENU = 'Up To', ESM = 'Hasta', FRC = 'Jusqu''à', ENC = 'Up To';
        Text50010: TextConst ENU = 'Days', ESM = 'Días', FRC = 'Jours', ENC = 'Days';
        Text50011: TextConst ENU = 'Aged Overdue Amounts', ESM = 'Importes vencidos retrasados', FRC = 'Montants en souffrance classés chronologiquement', ENC = 'Aged Overdue Amounts';
        Text50012: TextConst ENU = 'transaction date.', ESM = 'fecha movimiento.', FRC = 'date de transaction.', ENC = 'transaction date.';
        Text50013: TextConst ENU = 'Trx Date', ESM = 'Fecha mov.', FRC = 'Date de trans.', ENC = 'Trx Date';
        Text50014: TextConst ENU = 'Aged Vendor Balances', ESM = 'Saldo prov. vencido', FRC = 'Soldes fournisseurs classés chronologiquement', ENC = 'Aged Vendor Balances';
        Text50015: TextConst ENU = 'document date.', ESM = 'fecha emisión doc.', FRC = 'date du document.', ENC = 'document date.';
        Text50016: TextConst ENU = 'Doc Date', ESM = 'Fecha doc.', FRC = 'Date doc.', ENC = 'Doc Date';
        Text50017: TextConst ENU = 'Aged Vendor Balances', ESM = 'Saldo prov. vencido', FRC = 'Soldes fournisseurs classés chronologiquement', ENC = 'Aged Vendor Balances';
        Text50018: TextConst ENU = 'Current', ESM = 'Actual', FRC = 'Courant', ENC = 'Current';
        AgingDate: Date;
        BlockedDescription: Text[80];
        CurrencyFactor: Decimal;
        CalculatedDate: Date;
        AmountDueToPrint: Decimal;
        AmountDue: array[4] of Decimal;
        "BalanceDue$": array[4] of Decimal;
        DocNo: Code[20];
        ColumnHead: array[4] of Text[20];
        ColumnHeadHead: Text[59];
        SubTitle: Text[88];
        DateTitle: Text[20];
        ShortDateTitle: Text[20];
        CurrencyCodeToPrint: Code[20];
        DocNoCaptionLbl: TextConst ENU = 'Document No.', ENG = 'Document No.';
        AmountToPrintCaptionLbl: TextConst ENU = 'Remaining Amount', ENG = 'Remaining Amount';
        CurrencyCodeToPrintCaptionLbl: TextConst ENU = 'Currency Code', ENG = 'Currency Code';
        ReportNameCapionLbl: TextConst ENU = 'Aged Accounts Payable US', ENG = 'Aged Accounts Payable US';
        CurrReportPageNoCaptionLbl: TextConst ENU = 'Page', NLD = 'Pagina';

    local procedure InsertTemp(var VendLedgEntry: Record "Vendor Ledger Entry");
    begin
        if TempVendLedgEntry.GET(VendLedgEntry."Entry No.") then
            exit;
        TempVendLedgEntry := VendLedgEntry;
        case AgingMethod of
            AgingMethod::"Due Date":
                TempVendLedgEntry."Posting Date" := TempVendLedgEntry."Due Date";
            AgingMethod::"Document Date":
                TempVendLedgEntry."Posting Date" := TempVendLedgEntry."Document Date";
            AgingMethod::"Trans Date":
                TempVendLedgEntry."Posting Date" := TempVendLedgEntry."Posting Date";
        end;
        TempVendLedgEntry.INSERT;
    end;

    local procedure GetCurrencyRecord(var Currency: Record Currency; CurrencyCode: Code[10]);
    begin
        if CurrencyCode = '' then begin
            CLEAR(Currency);
            Currency.Description := GLSetup."LCY Code";
            Currency."Amount Rounding Precision" := GLSetup."Amount Rounding Precision";
        end else
            if Currency.Code <> CurrencyCode then
                Currency.GET(CurrencyCode);
    end;
}

