codeunit 50011 "Dimension Xsens  Mgt"
{
    // version XSS5.006

    // 20110427 GFR 25579: functies fReturnDimension3Value, fReturnDimension3Name, fLookupDimension toegevoegd.
    // 20110427 GFR 25579: functies fReturnDocDimension3Value, fLookupDocDimension, fReturnPostDocDimension3Value toegevoegd.
    // 20110427 GFR 25579: functies fLookupPostDocDimension toegevoegd toegevoegd.
    // 20110622 GFR 25917: Functie fLookupPostDocDimension  toegevoegd.
    // 20111207 GFR 27136: fExitstsDimensionValue toegevoegd.
    // 20120201 GFR 27492: Nieuw codeunit;

    Permissions = TableData "G/L Entry" = rimd,
                  TableData "G/L Budget Entry" = rimd,
                  TableData "General Ledger Setup" = rimd;

    trigger OnRun();
    begin
    end;

    var
        Text50000: TextConst ENU = 'Document deleted', NLD = 'Document verwijderd';
        Text50001: Label 'U wijzigd de shortcut dimensie niet, wilt u deze toch corrigeren/bijwerken.';
        Text50002: Label 'Wilt u Shortcut dimension 3 veranderen van %1 naar %2';
        Text50003: Label 'Post ####1###### wordt bijgewerkt.';
        Text50004: TextConst ENU = '<Empty>', NLD = '<Leeg>';
        Text30000: Label '"UPGRADE AANPASSING CDU %1 Funcie %2 Herbeoordelen. "';

    procedure fReturnDimension3Value(pIntTableID: Integer; pCodNo: Code[20]) RetDimensionValue: Code[20];
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
        lRecDefaultDimension: Record "Default Dimension";
    begin
        /* fReturnDimension3 */

        lRecGeneralLedgerSetup.GET;
        if (lRecGeneralLedgerSetup."Shortcut Dimension 3 Code" = '') then exit;

        lRecDefaultDimension.RESET;
        lRecDefaultDimension.SETCURRENTKEY("Table ID", "No.", "Dimension Code");
        lRecDefaultDimension.SETRANGE("Table ID", pIntTableID);
        lRecDefaultDimension.SETRANGE("No.", pCodNo);
        lRecDefaultDimension.SETRANGE("Dimension Code", lRecGeneralLedgerSetup."Shortcut Dimension 3 Code");
        if lRecDefaultDimension.FINDFIRST then
            RetDimensionValue := lRecDefaultDimension."Dimension Value Code";
        exit(RetDimensionValue);

    end;

    procedure fReturnDimension3Name() RetDimensionName: Code[20];
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fReturnDimension3Name */

        lRecGeneralLedgerSetup.GET;
        if (lRecGeneralLedgerSetup."Shortcut Dimension 3 Code" <> '') then
            RetDimensionName := lRecGeneralLedgerSetup."Shortcut Dimension 3 Code";
        exit(RetDimensionName);

    end;

    procedure fLookupDimension(pIntTableID: Integer; pCodNo: Code[20]; pCodDimension: Code[20]);
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
        lRecDefaultDimension: Record "Default Dimension";
        lFrmDefaultDimensions: Page "Default Dimensions";
    begin
        /* fLookupDimension */

        lRecDefaultDimension.RESET;
        lRecDefaultDimension.SETCURRENTKEY("Table ID", "No.", "Dimension Code");
        lRecDefaultDimension.SETRANGE("Table ID", pIntTableID);
        lRecDefaultDimension.SETRANGE("No.", pCodNo);
        lRecDefaultDimension.SETRANGE("Dimension Code", pCodDimension);
        CLEAR(lFrmDefaultDimensions);
        lFrmDefaultDimensions.SETRECORD(lRecDefaultDimension);
        lFrmDefaultDimensions.SETTABLEVIEW(lRecDefaultDimension);
        lFrmDefaultDimensions.RUNMODAL;

    end;

    procedure fReturnDocDimension3Value(pIntTableID: Integer; pOptDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," "; pCodDocumentNo: Code[20]) RetDimensionValue: Code[20];
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fReturnDocDimension3Value */

        ERROR(Text30000, 50011, 'fReturnDocDimension3Value');

        //lRecGeneralLedgerSetup.GET;
        //IF (lRecGeneralLedgerSetup."Shortcut Dimension 3 Code" = '') THEN EXIT;

        //lRecDocumentDimension.RESET;
        //lRecDocumentDimension.SETCURRENTKEY("Table ID","Document Type","Document No.","Line No.","Dimension Code");
        //lRecDocumentDimension.SETRANGE("Table ID"       , pIntTableID);
        //lRecDocumentDimension.SETRANGE("Document Type"  , pOptDocumentType);
        //lRecDocumentDimension.SETRANGE("Document No."   , pCodDocumentNo);
        //lRecDocumentDimension.SETRANGE("Dimension Code" , lRecGeneralLedgerSetup."Shortcut Dimension 3 Code");
        //IF lRecDocumentDimension.FINDFIRST THEN
        ///  RetDimensionValue := lRecDocumentDimension."Dimension Value Code";
        //EXIT(RetDimensionValue);

    end;

    procedure fLookupDocDimension(pIntTableID: Integer; pOptDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"," "; pCodDocumentNo: Code[20]; pCodDimension: Code[20]);
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fLookupDocDimension */

        ERROR(Text30000, 50011, ' flookupDocDimension');


        //lRecDocumentDimension.RESET;
        //lRecDocumentDimension.SETCURRENTKEY("Table ID","Document Type","Document No.","Line No.","Dimension Code");
        //lRecDocumentDimension.SETRANGE("Table ID"       , pIntTableID);
        //lRecDocumentDimension.SETRANGE("Document Type"  , pOptDocumentType);
        //lRecDocumentDimension.SETRANGE("Document No."   , pCodDocumentNo);
        //lRecDocumentDimension.SETRANGE("Dimension Code" , pCodDimension);
        //CLEAR(lFrmDocumentDimensions);
        //lFrmDocumentDimensions.SETRECORD(lRecDocumentDimension);
        //lFrmDocumentDimensions.SETTABLEVIEW(lRecDocumentDimension);
        //lFrmDocumentDimensions.RUNMODAL;

    end;

    procedure fReturnPostDocDimension3Value(pIntTableID: Integer; pCodDocumentNo: Code[20]) RetDimensionValue: Code[20];
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fReturnPostDocDimension3Value */

        ERROR(Text30000, 50011, ' fReturnPostDocDimension3Value');


        //lRecGeneralLedgerSetup.GET;
        //IF (lRecGeneralLedgerSetup."Shortcut Dimension 3 Code" = '') THEN EXIT;

        //lRecPostedDocumentDimension.RESET;
        //lRecPostedDocumentDimension.SETCURRENTKEY("Table ID","Document No.","Line No.","Dimension Code");
        //lRecPostedDocumentDimension.SETRANGE("Table ID"       , pIntTableID);
        //lRecPostedDocumentDimension.SETRANGE("Document No."   , pCodDocumentNo);
        //lRecPostedDocumentDimension.SETRANGE("Dimension Code" , lRecGeneralLedgerSetup."Shortcut Dimension 3 Code");
        //IF lRecPostedDocumentDimension.FINDFIRST THEN
        //  RetDimensionValue := lRecPostedDocumentDimension."Dimension Value Code";
        //EXIT(RetDimensionValue);

    end;

    procedure fReturnArchDocDimension3Value(pCodDocumentNo: Code[20]; pArchDocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; pIntDocNoOccurrence: Integer; pIntVersionNo: Integer) RetDimensionValue: Code[20];
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fReturnArchDocDimension3Value */

        ERROR(Text30000, 50011, 'fReturnArchDocDimension3Value');

        //lRecGeneralLedgerSetup.GET;
        //IF (lRecGeneralLedgerSetup."Shortcut Dimension 3 Code" = '') THEN EXIT;

        //lRecDocumentDimensionArchive.RESET;
        //lRecDocumentDimensionArchive.SETCURRENTKEY("Table ID","Document Type","Document No.","Line No.",
        //"Doc. No. Occurrence","Version No.","Dimension Code");
        //lRecDocumentDimensionArchive.SETRANGE("Document Type"      , pArchDocumentType);
        //lRecDocumentDimensionArchive.SETRANGE("Document No."       , pCodDocumentNo);
        //lRecDocumentDimensionArchive.SETRANGE("Dimension Code"     , lRecGeneralLedgerSetup."Shortcut Dimension 3 Code");
        //lRecDocumentDimensionArchive.SETRANGE("Doc. No. Occurrence", pIntDocNoOccurrence);
        //lRecDocumentDimensionArchive.SETRANGE("Version No."        , pIntVersionNo);
        //IF lRecDocumentDimensionArchive.FINDFIRST THEN
        //  RetDimensionValue := lRecDocumentDimensionArchive."Dimension Value Code";
        //EXIT(RetDimensionValue);

    end;

    procedure fLookupPostDocDimension(pIntTableID: Integer; pCodDocumentNo: Code[20]; pCodDimension: Code[20]);
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fLookupPostDocDimension */

        ERROR(Text30000, 50011, 'fLookupPostDocDimension');

        //lRecPostedDocumentDimension.RESET;
        ///lRecPostedDocumentDimension.SETCURRENTKEY("Table ID","Document No.","Line No.","Dimension Code");
        //lRecPostedDocumentDimension.SETRANGE("Table ID"       , pIntTableID);
        //lRecPostedDocumentDimension.SETRANGE("Document No."   , pCodDocumentNo);
        //lRecPostedDocumentDimension.SETRANGE("Dimension Code" , pCodDimension);
        //CLEAR(lFrmPostedDocumentDimensions);
        //lFrmPostedDocumentDimensions.SETRECORD(lRecPostedDocumentDimension);
        //lFrmPostedDocumentDimensions.SETTABLEVIEW(lRecPostedDocumentDimension);
        //lFrmPostedDocumentDimensions.EDITABLE(FALSE);
        //lFrmPostedDocumentDimensions.RUNMODAL;

    end;

    procedure fReturnDimension1Name() RetDimensionName: Code[20];
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fReturnDimension1Name */

        lRecGeneralLedgerSetup.GET;
        if (lRecGeneralLedgerSetup."Shortcut Dimension 1 Code" <> '') then
            RetDimensionName := lRecGeneralLedgerSetup."Shortcut Dimension 1 Code";
        exit(RetDimensionName);

    end;

    procedure fExitstsDimensionValue(pIntDim: Integer; pCodValue: Code[20]): Boolean;
    var
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
        lRecDimensionValue: Record "Dimension Value";
        lCodDimensionvalue: Code[20];
    begin
        /* fExitstsDimensionValue */

        lRecGeneralLedgerSetup.GET;
        if pIntDim = 1 then begin
            if (lRecGeneralLedgerSetup."Shortcut Dimension 1 Code" = '') then exit(false);
            lCodDimensionvalue := lRecGeneralLedgerSetup."Shortcut Dimension 1 Code";
        end;
        if pIntDim = 2 then begin
            if (lRecGeneralLedgerSetup."Shortcut Dimension 2 Code" = '') then exit(false);
            lCodDimensionvalue := lRecGeneralLedgerSetup."Shortcut Dimension 2 Code";
        end;

        lRecDimensionValue.RESET;
        lRecDimensionValue.SETCURRENTKEY("Dimension Code", Code);
        lRecDimensionValue.SETRANGE("Dimension Code", lCodDimensionvalue);
        lRecDimensionValue.SETRANGE(Code, pCodValue);
        if lRecDimensionValue.FINDFIRST then
            exit(true);
        exit(false);

    end;

    procedure fBoekDimensie3ToGLEntry(pRecGenJournalLine: Record "Gen. Journal Line"; var pvRecGLEntry: Record "G/L Entry");
    begin
        /* fBoekDimensie3ToGLEntry */

        pvRecGLEntry."Shortcut Dimension 3 Code" := pRecGenJournalLine."Shortcut Dimension 3 Code";

    end;

    procedure fFillDimensie3ToJournal(var pvRecGenJournalLine: Record "Gen. Journal Line");
    begin
        /* fFillDimensie3ToJournal */

        ERROR(Text30000, 50011, ' fFillDimensie3ToJournal');

        //TempJnlLineDim2.RESET;
        //IF TempJnlLineDim2.FINDFIRST THEN BEGIN
        //  REPEAT
        //    IF (TempJnlLineDim2."Dimension Code" = fReturnDimension3Name) AND
        //       (TempJnlLineDim2."Dimension Value Code" <> '') THEN
        //      pvRecGenJournalLine."Shortcut Dimension 3 Code" := TempJnlLineDim2."Dimension Value Code";
        //  UNTIL TempJnlLineDim2.NEXT = 0;
        //END;

    end;

    procedure fLookUpDimensionvalues(pIntDimensieNr: Integer; var pvDimensionValue: Code[20]): Code[20];
    var
        lRecDimensionValue: Record "Dimension Value";
        lFrmDimensionValues: Page "Dimension Values";
        lCodDimensionName: Code[20];
        lRecGeneralLedgerSetup: Record "General Ledger Setup";
    begin
        /* fLookUpDimensionvalues */

        lRecGeneralLedgerSetup.GET;
        case pIntDimensieNr of
            1:
                begin
                    if (lRecGeneralLedgerSetup."Global Dimension 1 Code" <> '') then
                        lCodDimensionName := lRecGeneralLedgerSetup."Global Dimension 1 Code";
                end;
            2:
                begin
                    if (lRecGeneralLedgerSetup."Global Dimension 2 Code" <> '') then
                        lCodDimensionName := lRecGeneralLedgerSetup."Global Dimension 2 Code";
                    ;
                end;
            3:
                begin
                    if (lRecGeneralLedgerSetup."Shortcut Dimension 3 Code" <> '') then
                        lCodDimensionName := lRecGeneralLedgerSetup."Shortcut Dimension 3 Code";
                end;
            4:
                begin
                    if (lRecGeneralLedgerSetup."Shortcut Dimension 4 Code" <> '') then
                        lCodDimensionName := lRecGeneralLedgerSetup."Shortcut Dimension 4 Code";
                end;
            5:
                begin
                    if (lRecGeneralLedgerSetup."Shortcut Dimension 5 Code" <> '') then
                        lCodDimensionName := lRecGeneralLedgerSetup."Shortcut Dimension 5 Code";
                end;
            6:
                begin
                    if (lRecGeneralLedgerSetup."Shortcut Dimension 6 Code" <> '') then
                        lCodDimensionName := lRecGeneralLedgerSetup."Shortcut Dimension 6 Code";
                end;
            7:
                begin
                    if (lRecGeneralLedgerSetup."Shortcut Dimension 7 Code" <> '') then
                        lCodDimensionName := lRecGeneralLedgerSetup."Shortcut Dimension 7 Code";
                end;
            8:
                begin
                    if (lRecGeneralLedgerSetup."Shortcut Dimension 8 Code" <> '') then
                        lCodDimensionName := lRecGeneralLedgerSetup."Shortcut Dimension 8 Code";
                end;
        end;
        if lCodDimensionName = '' then exit;
        lRecDimensionValue.RESET;
        lRecDimensionValue.SETCURRENTKEY("Dimension Code", Code);
        lRecDimensionValue.SETRANGE("Dimension Code", lCodDimensionName);
        CLEAR(lFrmDimensionValues);
        lFrmDimensionValues.LOOKUPMODE(true);
        lFrmDimensionValues.EDITABLE(false);
        lFrmDimensionValues.SETRECORD(lRecDimensionValue);
        lFrmDimensionValues.SETTABLEVIEW(lRecDimensionValue);
        if lFrmDimensionValues.RUNMODAL = ACTION::LookupOK then begin
            lFrmDimensionValues.GETRECORD(lRecDimensionValue);
            pvDimensionValue := lRecDimensionValue.Code;
        end;
        exit(lRecDimensionValue.Code);

    end;

    procedure fChangeDimension3GLEntryBudget(pCodNieuwDimensieName: Code[20]; var pRecGLSetup: Record "General Ledger Setup");
    var
        lRecGLentry: Record "G/L Entry";
        lRecGLBudgetEntry: Record "G/L Budget Entry";
        lCodHuidigeDimensieName: Code[20];
        lCodNieuwDimensieName: Code[20];
        lDialog: Dialog;
    begin
        /* fChangeDimension3ValueEntry */


        ERROR(Text30000, 50011, ' fFillDimensie3ToJournal');

        //lCodHuidigeDimensieName := pRecGLSetup."Shortcut Dimension 3 Code";
        //IF (lCodHuidigeDimensieName = pCodNieuwDimensieName) THEN BEGIN
        //  IF NOT(CONFIRM(Text50001)) THEN EXIT;
        //END;
        //IF lCodHuidigeDimensieName = '' THEN
        //  lCodHuidigeDimensieName := Text50004;
        //IF pCodNieuwDimensieName = '' THEN
        //  pCodNieuwDimensieName := Text50004;
        //IF NOT(CONFIRM(STRSUBSTNO(Text50002,lCodHuidigeDimensieName,pCodNieuwDimensieName))) THEN
        //  EXIT;
        //IF pCodNieuwDimensieName = Text50004 THEN
        // pCodNieuwDimensieName := '';
        //IF lCodHuidigeDimensieName = Text50004 THEN
        //  lCodHuidigeDimensieName := '';

        ///lRecGLentry.RESET;
        //lRecGLentry.SETCURRENTKEY("Entry No.");
        //IF lRecGLentry.FINDFIRST THEN BEGIN
        //  lRecGLentry.MODIFYALL("Shortcut Dimension 3 Code",'',FALSE);
        //END;

        //lRecLedgerEntryDimension.RESET;
        //lRecLedgerEntryDimension.SETCURRENTKEY("Table ID","Entry No.","Dimension Code");
        //lRecLedgerEntryDimension.SETRANGE("Table ID"      , 17);
        //lRecLedgerEntryDimension.SETRANGE("Dimension Code", pCodNieuwDimensieName);
        //IF lRecLedgerEntryDimension.FINDFIRST THEN BEGIN
        //  lDialog.OPEN(Text50003);
        //  REPEAT
        //    IF lRecGLentry.GET(lRecLedgerEntryDimension."Entry No.") THEN BEGIN
        //      lDialog.UPDATE(1,lRecGLentry."Entry No.");
        //      lRecGLentry."Shortcut Dimension 3 Code" := lRecLedgerEntryDimension."Dimension Value Code";
        //      lRecGLentry.MODIFY(FALSE);
        //    END;
        //  UNTIL lRecLedgerEntryDimension.NEXT = 0;
        //  lDialog.CLOSE;
        //END;
        //
        //lRecGLBudgetEntry.RESET;
        ///lRecGLBudgetEntry.SETCURRENTKEY("Entry No.");
        //IF lRecGLBudgetEntry.FINDFIRST THEN BEGIN
        //  lRecGLBudgetEntry.MODIFYALL("Shortcut Dimension 3 Code",'',FALSE);
        //END;
        //
        //lRecGLBudgetDimension.RESET;
        //lRecGLBudgetDimension.SETCURRENTKEY("Entry No.","Dimension Code");
        //lRecGLBudgetDimension.SETRANGE("Dimension Code", pCodNieuwDimensieName);
        //IF lRecGLBudgetDimension.FINDFIRST THEN BEGIN
        //  lDialog.OPEN(Text50003);
        //  REPEAT
        //    IF lRecGLBudgetEntry.GET(lRecGLBudgetDimension."Entry No.") THEN BEGIN
        //     lDialog.UPDATE(1,lRecGLBudgetEntry."Entry No.");
        //      lRecGLBudgetEntry."Shortcut Dimension 3 Code" := lRecGLBudgetDimension."Dimension Value Code";
        //      lRecGLBudgetEntry.MODIFY(FALSE);
        //    END;
        //  UNTIL lRecGLBudgetDimension.NEXT = 0;
        //  lDialog.CLOSE;
        //END;

        //IF (pRecGLSetup."Shortcut Dimension 3 Code" <> pCodNieuwDimensieName) THEN BEGIN
        //  pRecGLSetup.VALIDATE("Shortcut Dimension 3 Code", pCodNieuwDimensieName);
        //  pRecGLSetup.MODIFY(TRUE);
        //END;
        //COMMIT;

    end;

    procedure ffillGLEntryProjectDimensie(pIntvolgnummer: Integer; pCodDimensieWaarde: Code[20]);
    begin
        /* ffillGLEntryDimensie3 */

        ERROR(Text30000, 50011, 'ffillGLEntryDimensie3');

        //IF NOT(lRecLedgerEntryDimension.GET(17,pIntvolgnummer,fReturnDimension3Name)) THEN BEGIN
        //  lRecLedgerEntryDimension.INIT;
        //  lRecLedgerEntryDimension."Table ID"               := 17;
        //  lRecLedgerEntryDimension."Entry No."              := pIntvolgnummer;
        //  lRecLedgerEntryDimension."Dimension Code"         := fReturnDimension3Name;
        //  lRecLedgerEntryDimension."Dimension Value Code"   := pCodDimensieWaarde;
        //  lRecLedgerEntryDimension.INSERT(TRUE);
        //END;

    end;

    procedure ffillJournalLinedimensie(pvRecGenJournalline: Record "Gen. Journal Line"; pCodDimensieWaarde: Code[20]);
    begin
        /* ffillJournalLinedimensie */

        ERROR(Text30000, 50011, 'ffillJournalLinedimensie');

        //IF NOT(lRecJournalLineDimension.GET(81,pvRecGenJournalline."Journal Template Name",pvRecGenJournalline."Journal Batch Name",
        //                                     pvRecGenJournalline."Line No.",'',fReturnDimension3Name,''))
        //                                     AND (pCodDimensieWaarde <> '') THEN BEGIN
        //
        //  lRecJournalLineDimension.INIT;
        //  lRecJournalLineDimension."Journal Template Name"  := pvRecGenJournalline."Journal Template Name";
        //  lRecJournalLineDimension."Journal Batch Name"     := pvRecGenJournalline."Journal Batch Name";
        //  lRecJournalLineDimension."Journal Line No."       := pvRecGenJournalline."Line No.";
        //  lRecJournalLineDimension."Dimension Code"         := fReturnDimension3Name;
        //  lRecJournalLineDimension."Dimension Value Code"   := pCodDimensieWaarde;
        //  lRecJournalLineDimension.INSERT(TRUE);
        //END;
        //IF pCodDimensieWaarde = '' THEN BEGIN
        //  IF lRecJournalLineDimension.GET(81,pvRecGenJournalline."Journal Template Name",pvRecGenJournalline."Journal Batch Name",
        //                                    pvRecGenJournalline."Line No.",'',fReturnDimension3Name,'') THEN
        //   lRecJournalLineDimension.DELETE(TRUE);
        //END;

    end;

    procedure ffillJournalwithdim3(pCodSoort: Code[20]);
    var
        lRecGenJournalline: Record "Gen. Journal Line";
    begin
        /* ffillJournalwithdim3 */

        ERROR(Text30000, 50011, 'ffillJournalwithdim3');

        //IF NOT(pvRecJournalLineDimension."Table ID" = 81) THEN EXIT;
        //IF NOT(pvRecJournalLineDimension."Dimension Code" = fReturnDimension3Name) THEN EXIT;
        //IF NOT(lRecGenJournalline.GET(pvRecJournalLineDimension."Journal Template Name",pvRecJournalLineDimension."Journal Batch Name",
        //                              pvRecJournalLineDimension."Journal Line No.")) THEN EXIT;
        //
        //IF (pCodSoort = 'I') OR (pCodSoort = 'M') THEN BEGIN
        //  lRecGenJournalline."Shortcut Dimension 3 Code" := pvRecJournalLineDimension."Dimension Value Code";
        //  lRecGenJournalline.MODIFY(TRUE);
        //END;
        //IF (pCodSoort = 'V') THEN BEGIN
        /// lRecGenJournalline."Shortcut Dimension 3 Code" := '';
        //  lRecGenJournalline.MODIFY(TRUE);
        //END;

    end;

    procedure ffillBudgetlLinedimensie(pvRecGLBudgetEntry: Record "G/L Budget Entry"; pCodDimensieWaarde: Code[20]);
    begin
        /* ffillBudgetlLinedimensie */
        ERROR(Text30000, 50011, 'ffillBudgetlLinedimensie');

        //IF NOT(lRecGLBudgetDimension.GET(pvRecGLBudgetEntry."Entry No.",fReturnDimension3Name)) AND (pCodDimensieWaarde <> '') THEN BEGIN
        //  lRecGLBudgetDimension."Entry No."                := pvRecGLBudgetEntry."Entry No.";
        // lRecGLBudgetDimension."Dimension Code"           := fReturnDimension3Name;
        //  lRecGLBudgetDimension."Dimension Value Code"     := pCodDimensieWaarde;
        // lRecGLBudgetDimension.INSERT(FALSE);
        //END;
        //IF pCodDimensieWaarde = '' THEN
        // IF lRecGLBudgetDimension.GET(pvRecGLBudgetEntry."Entry No.",fReturnDimension3Name) THEN
        //   lRecGLBudgetDimension.DELETE(FALSE);

    end;

    procedure ffillbudgetwithdim3(pCodSoort: Code[20]);
    var
        lRecGLBudgetEntry: Record "G/L Budget Entry";
    begin
        /* ffillBudgetwithdim3 */

        //Error(Text30000,50011,'ffillBudgetwithdim3');
        //IF NOT(pvRecGLBudgetDimension."Dimension Code" = fReturnDimension3Name) THEN EXIT;
        //IF NOT(lRecGLBudgetEntry.GET(pvRecGLBudgetDimension."Entry No.")) THEN EXIT;

        //IF (pCodSoort = 'I') OR (pCodSoort = 'M') THEN BEGIN
        //  lRecGLBudgetEntry."Shortcut Dimension 3 Code" := pvRecGLBudgetDimension."Dimension Value Code";
        //  lRecGLBudgetEntry.MODIFY(TRUE);
        //END;
        //IF (pCodSoort = 'V') THEN BEGIN
        //  lRecGLBudgetEntry."Shortcut Dimension 3 Code" := '';
        //  lRecGLBudgetEntry.MODIFY(TRUE);
        //END;

    end;
}

