codeunit 50002 Financieel
{
    // version XSS5.105

    // 20110526 GFR 50000: fGLEntryDimensieInvoegen en fVerwijderVanGLEntry toegevoegd.
    // 20110526 GFR 25674: fWerkRelationalExchRateBij toegevoegd.

    Permissions = TableData "G/L Account" = rmd,
                  TableData "G/L Entry" = rmd;

    trigger OnRun();
    begin
    end;

    procedure fGLEntryDimensieInvoegen(pIntToTableID: Integer; pIntEntryNo: Integer; pCodDimensionCode: Code[20]): Boolean;
    var
        lRecGLEntry: Record "G/L Entry";
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
        lRecGLAccount: Record "G/L Account";
        lRecDimensie: Record Dimension;
    begin
        /* fGLEntryDimensieInvoegen */

        lRecGeneralLedgerSetup.GET;
        if not (pIntToTableID = 17) then exit(true);
        if lRecGLEntry.GET(pIntEntryNo) then begin
            if (lRecGLAccount.GET(lRecGLEntry."G/L Account No.")) and
               (lRecGLAccount."Income/Balance" = lRecGLAccount."Income/Balance"::"Balance Sheet") then begin
                if (lRecDimensie.GET(pCodDimensionCode)) and (lRecDimensie."Blokkeren voor Balans rek.") then begin
                    fVerwijderVanGLEntry(lRecGLEntry, pCodDimensionCode);
                    exit(false);
                end;
            end;
        end;
        exit(true);

    end;

    procedure fVerwijderVanGLEntry(pRecGLEntry: Record "G/L Entry"; pCodDimensionCode: Code[20]);
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fVerwijderVanGLEntry */

        lRecGeneralLedgerSetup.GET;
        if (lRecGeneralLedgerSetup."Global Dimension 1 Code" = pCodDimensionCode) then begin
            pRecGLEntry."Global Dimension 1 Code" := '';
            pRecGLEntry.MODIFY(true);
        end;
        if (lRecGeneralLedgerSetup."Global Dimension 2 Code" = pCodDimensionCode) then begin
            pRecGLEntry."Global Dimension 2 Code" := '';
            pRecGLEntry.MODIFY(true);
        end;

    end;

    procedure fWerkRelationalExchRateBij(pRecCurrencyExchangeRate: Record "Currency Exchange Rate");
    var
        lRecCurrencyExchangeRate: Record "Currency Exchange Rate";
        lRecTmpCurrencyExchangeRate: Record "Currency Exchange Rate" temporary;
        lRecCurrency: Record Currency;
    begin
        /* fWerkRelationalExchRateBij */

        lRecTmpCurrencyExchangeRate.INIT;
        lRecTmpCurrencyExchangeRate.TRANSFERFIELDS(pRecCurrencyExchangeRate);
        lRecTmpCurrencyExchangeRate.INSERT(false);

        lRecCurrencyExchangeRate.RESET;
        lRecCurrencyExchangeRate.SETCURRENTKEY("Currency Code", "Starting Date");
        lRecCurrencyExchangeRate.SETRANGE("Currency Code", pRecCurrencyExchangeRate."Currency Code");
        if lRecCurrencyExchangeRate.FINDFIRST then begin
            repeat
                if not (lRecTmpCurrencyExchangeRate.GET(lRecCurrencyExchangeRate."Currency Code", lRecCurrencyExchangeRate."Starting Date")) then begin
                    lRecTmpCurrencyExchangeRate.INIT;
                    lRecTmpCurrencyExchangeRate.TRANSFERFIELDS(lRecCurrencyExchangeRate);
                    lRecTmpCurrencyExchangeRate.INSERT(false);
                end;
            until lRecCurrencyExchangeRate.NEXT = 0;
        end;
        lRecTmpCurrencyExchangeRate.RESET;
        lRecTmpCurrencyExchangeRate.SETCURRENTKEY("Currency Code", "Starting Date");
        if lRecTmpCurrencyExchangeRate.FINDLAST then begin
            if lRecCurrency.GET(lRecTmpCurrencyExchangeRate."Currency Code") then begin
                lRecCurrency."Relational Exch. Rate Amount" := lRecTmpCurrencyExchangeRate."Exchange Rate Amount";
                lRecCurrency.MODIFY(true);
            end;
        end;

    end;

    procedure fLookUpBusinessUnitTotFilter(var pvTxtBusinessUnit: Text[30]): Boolean;
    var
        lRecBusinessUnit: Record "Business Unit";
        lFrmBusinessUnit: Page "Business Unit List";
    begin
        /* fLookUpBusinessUnitTotFilter */

        lRecBusinessUnit.RESET;
        CLEAR(lFrmBusinessUnit);
        lFrmBusinessUnit.LOOKUPMODE(true);
        lFrmBusinessUnit.SETTABLEVIEW(lRecBusinessUnit);
        if lFrmBusinessUnit.RUNMODAL = ACTION::LookupOK then begin
            lFrmBusinessUnit.GETRECORD(lRecBusinessUnit);
            pvTxtBusinessUnit := pvTxtBusinessUnit + lFrmBusinessUnit.GetSelectionFilter;
            exit(true);
        end else
            exit(false)

    end;

    procedure fGetDimensionFromID(pDimSetID: Integer; pDimCode: Code[20]) RetDimValue: Text;
    var
        lRecDimSetEntry: Record "Dimension Set Entry";
    begin
        lRecDimSetEntry.RESET;
        lRecDimSetEntry.SETRANGE("Dimension Set ID", pDimSetID);
        lRecDimSetEntry.SETRANGE("Dimension Code", pDimCode);

        if not lRecDimSetEntry.FIND('-') then
            exit('');


        exit(lRecDimSetEntry."Dimension Value Code");
    end;

    procedure fGetDimensionValueFromID(pDimSetID: Integer; pDimCode: Code[20]) RetDimValue: Text;
    var
        lRecDimSetEntry: Record "Dimension Set Entry";
    begin
        lRecDimSetEntry.RESET;
        lRecDimSetEntry.SETRANGE("Dimension Set ID", pDimSetID);
        lRecDimSetEntry.SETRANGE("Dimension Code", pDimCode);

        if not lRecDimSetEntry.FIND('-') then
            exit('');

        lRecDimSetEntry.CALCFIELDS("Dimension Value Name");
        if pDimCode = 'COST CENTRE' then
            exit(lRecDimSetEntry."Dimension Value Code");
        exit(lRecDimSetEntry."Dimension Value Name");
    end;
}

