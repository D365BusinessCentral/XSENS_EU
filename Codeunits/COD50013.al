codeunit 50013 "Permanence ESP"
{
    // version XSS5.006

    // 20141018 ELA 00279: Codeunit added


    trigger OnRun();
    begin
        exit;
    end;

    var
        Text850: TextConst ENU = 'ESP in item %1 can not be empty.', NLD = 'ESP moet zijn ingevuld voor artikel %1.';
        Text851: TextConst ENU = 'Invalid Dates/Periods entered for Permanence Posting', NLD = 'Datumberekening voor Permanence boeking is mislukt.';
        Text852: TextConst ENU = 'Sales Invoice %1 - %2', NLD = 'Verk.fact. %1 - %2';
        Text853: Label 'Niet alle permanence-gegevens zijn ingevuld (startdatum en einddatum of aantal periodes) voor artikel %1';
        Text854: Label 'Boekingsperiodes ontbreken na %1';
        Text856: TextConst ENU = 'Document Date can not be empty: it is needed to calculate the startingdate of ESP-postings.', NLD = 'Documentdatum moet ingevuld zijn: is nodig voor de berekening van de startdatum van de ESP-boekingen.';
        Text857: Label 'Er is geen boekingsperiode meer ingegeven na %1.';
        Text855: TextConst ENU = 'ESP in %1 %2 can not be empty.', NLD = 'ESP moet zijn ingevuld voor dit artikel';
        "Text856-2": TextConst ENU = 'Customer must be filled.', NLD = 'Klant moet zijn ingevuld.';

    procedure fOnValidateItemAndQty(pRecSalesHeader: Record "Sales Header"; var pvRecSalesLine: Record "Sales Line"; pRecItem: Record Item);
    begin
        /* fOnValidateItemAndQty */

        if not fIsESPDocument(pRecSalesHeader) then
            exit;

        if pRecItem."Estimated Sales Price" = 0 then
            ERROR(Text850, pRecItem."No.");

        pvRecSalesLine."ESP (LCY)" := pRecItem."Estimated Sales Price";
        pvRecSalesLine."RRP (LCY)" := pRecItem."Recurring Revenue Price";
        pvRecSalesLine."Revenue Type" := pRecItem."Revenue Type";
        if pRecItem."Revenue Type" = pRecItem."Revenue Type"::"Straight Line" then begin
            pvRecSalesLine."No. of Periods" := pRecItem."Default ESP-periods";
            fCalculateStartingDate(pvRecSalesLine);
        end else begin
            pvRecSalesLine."No. of Periods" := 0;
            pvRecSalesLine."Starting Date" := 0D;
        end;

        pvRecSalesLine."ESP Line Amount (LCY)" := pvRecSalesLine.Quantity * pvRecSalesLine."ESP (LCY)";
        pvRecSalesLine."RRP Line Amount (LCY)" := pvRecSalesLine.Quantity * pvRecSalesLine."RRP (LCY)";

    end;

    procedure fCalcESP(var pvRecSalesHeader: Record "Sales Header");
    var
        lRecCurrency: Record Currency;
        lRecSalesLine: Record "Sales Line";
        lRecCurrExchRate: Record "Currency Exchange Rate";
        lDecTotalLineAmount: Decimal;
        lDecTotalESPAmountLCY: Decimal;
        lDecTotalESPAmount: Decimal;
        lDecTotalRRPAmountLCY: Decimal;
        lDecTotalRRPAmount: Decimal;
    begin
        /* fCalcESP */

        if pvRecSalesHeader."Document Type" <> pvRecSalesHeader."Document Type"::Order then
            exit;

        lRecSalesLine.RESET;
        lRecSalesLine.SETRANGE("Document Type", pvRecSalesHeader."Document Type");
        lRecSalesLine.SETRANGE("Document No.", pvRecSalesHeader."No.");
        lRecSalesLine.SETRANGE(Type, lRecSalesLine.Type::Item);
        lRecSalesLine.SETFILTER("Revenue Type", '<>%1', lRecSalesLine."Revenue Type"::"Upon Rendering");

        if not lRecSalesLine.FINDSET(true, false) then
            exit;

        // De volgende velden zijn in EV
        // lRecSalesLine."ESP (LCY)"
        // lRecSalesLine."ESP Line Amount (LCY)"
        // lRecSalesLine."RRP (LCY)"
        // lRecSalesLine."RRP Line Amount (LCY)"
        // En deze in VV:
        // lRecSalesLine."ESP Disc.Amount"
        // lRecSalesLine."ESP Nett Line Amount"
        // lRecSalesLine."ESP Line Amount"
        // lRecSalesLine."RRP Disc.Amount"
        // lRecSalesLine."RRP Nett Line Amount"
        // lRecSalesLine."RRP Line Amount"

        //eventueel omrekenen naar VV
        if pvRecSalesHeader."Currency Code" = '' then
            lRecCurrency.InitRoundingPrecision
        else
            lRecCurrency.GET(pvRecSalesHeader."Currency Code");

        lDecTotalLineAmount := 0; //totaal van kolom 'NR' = bedragen minus korting
        lDecTotalESPAmountLCY := 0;   //totaal van kolom 'ESP' = aantal * ESP-prijs
        lDecTotalRRPAmountLCY := 0;

        repeat
            if lRecSalesLine."ESP (LCY)" = 0 then
                ERROR(Text850, lRecSalesLine."No.");
            lDecTotalLineAmount := lDecTotalLineAmount + lRecSalesLine."Line Amount";                   // in VV
            lDecTotalESPAmountLCY := lDecTotalESPAmountLCY + lRecSalesLine."ESP Line Amount (LCY)";     // in EV
            lDecTotalRRPAmountLCY := lDecTotalRRPAmountLCY + lRecSalesLine."RRP Line Amount (LCY)";     // in EV

        until lRecSalesLine.NEXT = 0;

        //reken totaal ESP-bedrag om in VV
        lDecTotalESPAmount := ROUND(lRecCurrExchRate.ExchangeAmtLCYToFCY(pvRecSalesHeader."Posting Date", pvRecSalesHeader."Currency Code",
                                    lDecTotalESPAmountLCY, pvRecSalesHeader."Currency Factor"),
                                    lRecCurrency."Unit-Amount Rounding Precision");

        lDecTotalRRPAmount := ROUND(lRecCurrExchRate.ExchangeAmtLCYToFCY(pvRecSalesHeader."Posting Date", pvRecSalesHeader."Currency Code",
                                    lDecTotalRRPAmountLCY, pvRecSalesHeader."Currency Factor"),
                                    lRecCurrency."Unit-Amount Rounding Precision");


        lRecSalesLine.FINDSET(true, false);
        repeat
            //in VV
            lRecSalesLine."ESP % of Total Amount" := ROUND(lRecSalesLine."ESP Line Amount (LCY)" /
                                                          (lDecTotalESPAmountLCY + lDecTotalRRPAmountLCY) * 100, 0.00001);
            lRecSalesLine."ESP Disc.Amount" := (lDecTotalLineAmount - lDecTotalESPAmount - lDecTotalRRPAmount) *
                                                lRecSalesLine."ESP % of Total Amount" / 100;

            lRecSalesLine."RRP % of Total Amount" := ROUND(lRecSalesLine."RRP Line Amount (LCY)" /
                                                          (lDecTotalESPAmountLCY + lDecTotalRRPAmountLCY) * 100, 0.00001);
            lRecSalesLine."RRP Disc.Amount" := (lDecTotalLineAmount - lDecTotalESPAmount - lDecTotalRRPAmount) *
                                                lRecSalesLine."RRP % of Total Amount" / 100;

            //reken regelbedragen om in VV
            lRecSalesLine."ESP Line Amount" := ROUND(
                                        lRecCurrExchRate.ExchangeAmtLCYToFCY(pvRecSalesHeader."Posting Date", pvRecSalesHeader."Currency Code",
                                        lRecSalesLine."ESP Line Amount (LCY)", pvRecSalesHeader."Currency Factor"),
                                        lRecCurrency."Unit-Amount Rounding Precision");
            lRecSalesLine."RRP Line Amount" := ROUND(
                                        lRecCurrExchRate.ExchangeAmtLCYToFCY(pvRecSalesHeader."Posting Date", pvRecSalesHeader."Currency Code",
                                        lRecSalesLine."RRP Line Amount (LCY)", pvRecSalesHeader."Currency Factor"),
                                        lRecCurrency."Unit-Amount Rounding Precision");

            //bereken netto regelbedrag in VV
            lRecSalesLine."ESP Nett Line Amount" := lRecSalesLine."ESP Line Amount" + lRecSalesLine."ESP Disc.Amount";
            lRecSalesLine."RRP Nett Line Amount" := lRecSalesLine."RRP Line Amount" + lRecSalesLine."RRP Disc.Amount";

            lRecSalesLine.MODIFY(false);
        until lRecSalesLine.NEXT = 0;

    end;

    procedure fSalesCreatePermanenceLines(pRecSalesHeader: Record "Sales Header");
    var
        lRecCurrency: Record Currency;
        lRecSalesLine: Record "Sales Line";
        lRecSetup: Record "XSENS Setup";
        lRecGenJournalBatch: Record "Gen. Journal Batch";
        lRecGenJournalTemplate: Record "Gen. Journal Template";
        lRecAccPeriod: Record "Accounting Period";
        lRecGenJournalLine: Record "Gen. Journal Line";
        lRecCurrExchRate: Record "Currency Exchange Rate";
        lTmpRecDate: Record Date temporary;
        lCduNoSeriesMgt: Codeunit NoSeriesManagement;
        lCduGenJnlPostBatch: Codeunit "Gen. Jnl.-Post Batch";
        lIntNumberOfDates: Integer;
        lIntCurrentDateNo: Integer;
        lIntLineNo: Integer;
        lIntFirstLineNo: Integer;
        lCodDummyCod: Code[10];
        lCodDocumentNo: Code[10];
        lTxtPeriod: Text[30];
        lDecAmountLCY: Decimal;
        lDecAmountPrev: Decimal;
    begin
        /* fSalesCreatePermanenceLines */

        if not fIsESPDocument(pRecSalesHeader) then
            exit;

        // Step 1: Get Saleslines with Revenue Type = Straight Line
        lRecSalesLine.RESET;
        lRecSalesLine.SETRANGE("Document Type", pRecSalesHeader."Document Type");
        lRecSalesLine.SETRANGE("Document No.", pRecSalesHeader."No.");
        lRecSalesLine.SETRANGE(Type, lRecSalesLine.Type::Item);
        lRecSalesLine.SETRANGE("Revenue Type", lRecSalesLine."Revenue Type"::"Straight Line");
        if not lRecSalesLine.FINDFIRST then
            exit;

        repeat
            fCheckStraightLine(lRecSalesLine);
        until lRecSalesLine.NEXT = 0;

        // Step 2: Checks
        lRecSetup.GET;
        lRecSetup.TESTFIELD("Permanence Journal Template");
        lRecSetup.TESTFIELD("Permanence Journal batch");
        lRecSetup.TESTFIELD("Omzet spreiding (Permanence)");
        lRecSetup.TESTFIELD("Tussenrekening (Permanence)");
        lRecSetup.TESTFIELD("Omzet periodiek (Permanence)");
        lRecGenJournalTemplate.GET(lRecSetup."Permanence Journal Template");
        lRecGenJournalTemplate.TESTFIELD("Source Code");

        if pRecSalesHeader."Currency Code" = '' then
            lRecCurrency.InitRoundingPrecision
        else
            lRecCurrency.GET(pRecSalesHeader."Currency Code");


        lRecSalesLine.FINDSET(true, false);
        repeat
            // Step 3: Determine posting dates
            // Op de factuur ingegeven datum is altijd de eerste van de volgende maand.
            // Vanaf die datum moet, verspreid over de periodes, de permanence geboekt worden.
            // De boeking zelf moet op de laatste van elke periode plaatsvinden.
            lTmpRecDate.DELETEALL(false);
            lIntNumberOfDates := 0;

            lRecAccPeriod.RESET;
            lRecAccPeriod.SETFILTER("Starting Date", '%1..%2', lRecSalesLine."Starting Date", 20291231D);
            lRecAccPeriod.FINDFIRST;
            while lIntNumberOfDates < lRecSalesLine."No. of Periods" do begin
                lTmpRecDate."Period Start" := lRecAccPeriod."Starting Date";
                lTmpRecDate.INSERT;
                lIntNumberOfDates += 1;
                if lRecAccPeriod.NEXT = 0 then
                    ERROR(Text854, lRecAccPeriod."Starting Date");
            end;
            if lIntNumberOfDates = 0 then
                ERROR(Text851);

            // Step 4: Determine the last line in the permanence journal:
            lIntLineNo := 0;
            lRecGenJournalLine.RESET;
            lRecGenJournalLine.SETRANGE("Journal Template Name", lRecSetup."Permanence Journal Template");
            lRecGenJournalLine.SETRANGE("Journal Batch Name", lRecSetup."Permanence Journal batch");
            if lRecGenJournalLine.FINDLAST then begin
                lIntLineNo := lRecGenJournalLine."Line No.";
                lIntFirstLineNo := lIntLineNo;
            end;

            // Step 5: Enter debit/credit line for totals
            lIntLineNo += 10000;
            lRecGenJournalLine.INIT;
            lRecGenJournalLine."Journal Template Name" := lRecSetup."Permanence Journal Template";
            lRecGenJournalLine."Journal Batch Name" := lRecSetup."Permanence Journal batch";
            lRecGenJournalLine."Source Code" := lRecGenJournalTemplate."Source Code";
            lRecGenJournalLine."Line No." := lIntLineNo;
            lRecGenJournalLine.INSERT;
            lRecGenJournalLine.VALIDATE("Account Type", lRecGenJournalLine."Account Type"::"G/L Account");
            lRecGenJournalLine.VALIDATE("Account No.", lRecSetup."Omzet spreiding (Permanence)");
            lRecGenJournalLine.VALIDATE("Posting Date", pRecSalesHeader."Posting Date");
            lRecGenJournalLine.VALIDATE("Currency Code", pRecSalesHeader."Currency Code");
            lRecGenJournalLine.Description := COPYSTR(STRSUBSTNO(Text852, pRecSalesHeader."Posting No.", lRecSalesLine."No."), 1, 50);
            lRecGenJournalLine.Permanence := true;
            lRecGenJournalLine."Permanence Document No." := pRecSalesHeader."Posting No.";
            lRecGenJournalLine."Sell-to/Buy-from No." := pRecSalesHeader."Sell-to Customer No.";
            lRecGenJournalLine."Document No." := pRecSalesHeader."Posting No.";
            lCodDocumentNo := lRecGenJournalLine."Document No.";
            lRecGenJournalLine.VALIDATE(Amount, lRecSalesLine."ESP Nett Line Amount");
            lDecAmountLCY := ROUND(lRecCurrExchRate.ExchangeAmtFCYToLCY(pRecSalesHeader."Posting Date", pRecSalesHeader."Currency Code",
                               lRecSalesLine."ESP Nett Line Amount", pRecSalesHeader."Currency Factor"),
                               lRecCurrency."Unit-Amount Rounding Precision");
            lRecGenJournalLine.VALIDATE(Amount, lRecSalesLine."ESP Nett Line Amount");
            //lRecGenJournalLine."Amount (LCY)" := lDecAmountLCY;
            lRecGenJournalLine.VALIDATE("Gen. Posting Type", 0);
            lRecGenJournalLine.VALIDATE("Gen. Bus. Posting Group", '');
            lRecGenJournalLine.VALIDATE("Gen. Prod. Posting Group", '');
            lRecGenJournalLine.VALIDATE("VAT Bus. Posting Group", '');
            lRecGenJournalLine.VALIDATE("VAT Prod. Posting Group", '');
            lRecGenJournalLine."System-Created Entry" := true;
            //lRecGenJournalLine."Dimension Set ID" := lRecSalesLine."Dimension Set ID";
            lRecGenJournalLine.MODIFY(false);

            // Credit Line:
            lIntLineNo += 10000;
            lRecGenJournalLine."Line No." := lIntLineNo;
            lRecGenJournalLine."Account No." := lRecSetup."Tussenrekening (Permanence)"; //validate?
            lDecAmountPrev := lRecGenJournalLine."Amount (LCY)";
            lRecGenJournalLine.VALIDATE(Amount, -lRecGenJournalLine.Amount);
            lRecGenJournalLine.VALIDATE("Amount (LCY)", -lDecAmountPrev);
            lRecGenJournalLine.INSERT(false);

            // Step 6: For every Date in lTmpRecDate enter a debit/credit line in the permanence Template:
            lTmpRecDate.FINDFIRST;
            lIntCurrentDateNo := 0;
            repeat
                lIntLineNo += 10000;
                // Debit Line:
                lIntCurrentDateNo += 1;
                lRecGenJournalLine.INIT;
                lRecGenJournalLine."Journal Template Name" := lRecSetup."Permanence Journal Template";
                lRecGenJournalLine."Journal Batch Name" := lRecSetup."Permanence Journal batch";
                lRecGenJournalLine."Source Code" := lRecGenJournalTemplate."Source Code";
                lRecGenJournalLine."Line No." := lIntLineNo;
                lRecGenJournalLine.INSERT;
                lRecGenJournalLine.VALIDATE("Account Type", lRecGenJournalLine."Account Type"::"G/L Account");
                lRecGenJournalLine.VALIDATE("Account No.", lRecSetup."Tussenrekening (Permanence)");
                lRecGenJournalLine.VALIDATE("Posting Date", CALCDATE('+27D', lTmpRecDate."Period Start"));
                lRecGenJournalLine.VALIDATE("Currency Code", pRecSalesHeader."Currency Code");
                lTxtPeriod := FORMAT(lTmpRecDate."Period Start", 0, '<Month Text> <Year4>');
                lRecGenJournalLine.Description := COPYSTR(STRSUBSTNO(Text852, pRecSalesHeader."Posting No.", lRecSalesLine."No.")
                 + ' - ' + lTxtPeriod, 1, 50);
                lRecGenJournalLine.Permanence := true;
                lRecGenJournalLine."Permanence Document No." := pRecSalesHeader."Posting No.";
                lRecGenJournalLine."Sell-to/Buy-from No." := pRecSalesHeader."Sell-to Customer No.";
                lRecGenJournalLine."Document No." := lCodDocumentNo;
                if (lIntCurrentDateNo < lIntNumberOfDates) then
                    //      lRecGenJournalLine.VALIDATE(Amount,ROUND(lDecAmountLCY/lIntNumberOfDates,0.01))
                    lRecGenJournalLine.VALIDATE(Amount, ROUND(lRecSalesLine."ESP Nett Line Amount" / lIntNumberOfDates, 0.01))
                else
                    //      lRecGenJournalLine.VALIDATE(Amount,lDecAmountLCY -
                    //                                                 ((lIntNumberOfDates-1) * ROUND(lDecAmountLCY/lIntNumberOfDates,0.01)));
                    lRecGenJournalLine.VALIDATE(Amount, lRecSalesLine."ESP Nett Line Amount" -
                                      ((lIntNumberOfDates - 1) * ROUND(lRecSalesLine."ESP Nett Line Amount" / lIntNumberOfDates, 0.01)));

                lRecGenJournalLine.VALIDATE("Gen. Posting Type", 0);
                lRecGenJournalLine.VALIDATE("Gen. Bus. Posting Group", '');
                lRecGenJournalLine.VALIDATE("Gen. Prod. Posting Group", '');
                lRecGenJournalLine.VALIDATE("VAT Bus. Posting Group", '');
                lRecGenJournalLine.VALIDATE("VAT Prod. Posting Group", '');
                lRecGenJournalLine."System-Created Entry" := true;
                lRecGenJournalLine."Delay posting" := true;
                //dimensies?
                lRecGenJournalLine.MODIFY(false);

                // Credit Line:
                lIntLineNo += 10000;
                lRecGenJournalLine."Line No." := lIntLineNo;
                lRecGenJournalLine."Account No." := lRecSetup."Omzet periodiek (Permanence)";
                lRecGenJournalLine.VALIDATE(Amount, -lRecGenJournalLine.Amount);
                lRecGenJournalLine.INSERT(false);

                // Step 7: Post entries in permanence ledger:
                lRecGenJournalLine.RESET;
                lRecGenJournalLine.SETRANGE("Journal Template Name", lRecSetup."Permanence Journal Template");
                lRecGenJournalLine.SETRANGE("Journal Batch Name", lRecSetup."Permanence Journal batch");
                lRecGenJournalLine.SETRANGE("Source Code", lRecGenJournalTemplate."Source Code");
                lRecGenJournalLine.SETRANGE("Line No.", lIntFirstLineNo, lIntLineNo);
                lRecGenJournalLine.SETRANGE("Delay posting", false);
                if lRecGenJournalLine.FINDFIRST then begin
                    CLEAR(lCduGenJnlPostBatch);
                    lCduGenJnlPostBatch.RUN(lRecGenJournalLine);
                end;

            until lTmpRecDate.NEXT = 0;


        until lRecSalesLine.NEXT = 0;

    end;

    procedure fCheckStraightLine(pRecSalesLine: Record "Sales Line");
    begin
        /* fCheckStraightLine */

        if (pRecSalesLine."Starting Date" = 0D) or (pRecSalesLine."No. of Periods" = 0) then
            ERROR(Text853, pRecSalesLine."No.");

    end;

    procedure fCalculateStartingDate(var pvRecSalesLine: Record "Sales Line");
    var
        lRecSalesheader: Record "Sales Header";
        lRecAccPeriod: Record "Accounting Period";
    begin
        /* fCalculateStartingDate */

        lRecSalesheader.GET(pvRecSalesLine."Document Type", pvRecSalesLine."Document No.");
        if lRecSalesheader."Document Date" = 0D then
            ERROR(Text856);
        lRecAccPeriod.RESET;
        lRecAccPeriod.SETFILTER("Starting Date", '>%1', lRecSalesheader."Document Date");
        if not lRecAccPeriod.FINDFIRST then
            ERROR(Text857, lRecSalesheader."Document Date");
        pvRecSalesLine."Starting Date" := lRecAccPeriod."Starting Date";

    end;

    procedure fIsESPDocument(pRecSalesHeader: Record "Sales Header"): Boolean;
    var
        lRecCustomer: Record Customer;
    begin
        /* fIsESPDocument */

        if pRecSalesHeader."Sell-to Customer No." = '' then
            ERROR(Text856);

        lRecCustomer.GET(pRecSalesHeader."Sell-to Customer No.");

        if (pRecSalesHeader."Document Type" = pRecSalesHeader."Document Type"::Order) and
           (COPYSTR(lRecCustomer."Customer Posting Group", 1, 2) <> 'IC') then
            exit(true);

        exit(false);

    end;
}

