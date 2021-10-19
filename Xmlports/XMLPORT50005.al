xmlport 50005 "Import Journaalposten"
{
    // version RUI5.001,XSS5.057

    CaptionML = ENU = 'Import Journal Entries',
                NLD = 'Import Journal posten';


    //kk
    Direction = Import;
    Format = VariableText;
    TextEncoding = UTF8;
    FieldSeparator = ';';
    //kk

    //default***************
    //DefaultFieldsValidation = false;
    // FieldDelimiter = '<">';
    // FieldSeparator = ';';
    // Format = VariableText;
    //Encoding = UTF16;
    //default****************
    schema
    {
        textelement(root)
        {
            tableelement("Item Journal Line"; "Item Journal Line")
            {
                XmlName = 'JournalLines';
                textelement(gtxtaccounttype)
                {
                    XmlName = 'Field1';
                    Width = 6;
                }
                textelement(gtxtaccountno)
                {
                    //MinOccurs = Once;
                    XmlName = 'Field2';
                    Width = 30;
                }
                textelement(gtxtdescription)
                {
                    XmlName = 'Field3';
                    Width = 8;
                }
                textelement(gtxtworkdate)
                {
                    XmlName = 'Field4';
                    Width = 8;
                }
                textelement(gtxtamount)
                {
                    XmlName = 'Field5';
                    Width = 8;
                }
                textelement(gtxtdimension1)
                {
                    MinOccurs = Zero;
                    XmlName = 'Field6';
                    Width = 6;
                }
                textelement(gtxtdimension2)
                {
                    MinOccurs = Zero;
                    XmlName = 'Field7';
                    Width = 30;
                    // trigger OnAfterAssignVariable()
                    // begin
                    //     fImportRecord;
                    // end;
                }
                textelement(gtxtInterCompanyPartner)
                {
                    MinOccurs = Zero;//kk
                    XmlName = 'Field8';
                    Width = 25;
                }
                textelement(gtxtdimension3)
                {
                    MinOccurs = Zero;//kk
                    XmlName = 'Field9';
                    Width = 25;
                }
                textelement(gtxtTax)
                {
                    MinOccurs = Zero;//kk
                    XmlName = 'Field10';
                    Width = 25;
                    trigger OnAfterAssignVariable()
                    begin
                        fImportRecord;
                    end;
                }
                // textelement(gtxtCreditCardPayee)
                // {
                //     MinOccurs = Zero;//kk
                //     XmlName = 'Field11';
                //     Width = 25;

                //     trigger OnAfterAssignVariable()
                //     begin
                //         //fImportRecord;
                //     end;
                // }

                trigger OnBeforeInsertRecord();
                begin
                    fClrVar;
                    currXMLport.SKIP;
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Control1100510001)
                {
                    field(gCodFinJournalTemplate; gCodFinJournalTemplate)
                    {
                        CaptionML = ENU = 'Gen. Journal Template',
                                    NLD = 'Fin. dagboeksjabloon';
                        TableRelation = "Gen. Journal Template";
                        ApplicationArea = All;
                    }
                    field(gCodJournalBatch; gCodJournalBatch)
                    {
                        CaptionML = ENU = 'Fin. JournalBatch',
                                    NLD = 'Fin. dagboekbatch';
                        ApplicationArea = All;
                    }
                    field(gCodDocumentNo; gCodDocumentNo)
                    {
                        CaptionML = ENU = 'Document No.',
                                    NLD = 'Document Nr.';
                        Visible = gBlnDocNoVisible;
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort();
    begin
        if GUIALLOWED then begin
            gDialog.CLOSE;
            MESSAGE(Text50000, gTxtFileName, gIntCounterImported);
        end;
    end;

    trigger OnPreXmlPort();
    var
        gRecWithDrawalLocation: Record Location;
    begin
        gRecGenJournalBatch.RESET;
        gRecGenJournalBatch.SETRANGE("Journal Template Name", gCodFinJournalTemplate);
        gRecGenJournalBatch.SETRANGE(Name, gCodJournalBatch);
        if gRecGenJournalBatch.FINDFIRST then begin
            if (gRecGenJournalBatch."No. Series" = '') then
                gBlnDocNoVisible := true
            else begin
                gBlnDocNoVisible := false;
                gCodDocumentNo := '';
            end;
        end;
        gRecGenJournalBatch.RESET;
        gDialog.OPEN(Text50001);
        gTxtFileName := gCduFileMgt.GetFileName(currXMLport.FILENAME);
    end;

    var
        gIntCounter: Integer;
        gDialog: Dialog;
        gTxtFileName: Text;
        gDecAmount: Decimal;
        gRecGenJournalLine: Record "Gen. Journal Line";
        gRecGenJournalBatch: Record "Gen. Journal Batch";
        gRecFinanceJournalLine: Record "Gen. Journal Line";
        gCduGenJnlManagement: Codeunit GenJnlManagement;
        gDecBalance: Decimal;
        gDecTotalBalance: Decimal;
        gBoolShowBalance: Boolean;
        gBoolShowTotalBalance: Boolean;
        gCodDocumentNo: Code[20];
        gBlnUseTheSameNumber: Boolean;
        gCodGenJournalBatch: Code[10];
        gCodJournalBatch: Code[10];
        Text50001: Label '"Artikel memoriaal dagboekregels #1#######  worden geimporteerd #2####### "';
        Text50000: TextConst ENU = 'Imported File %1/Records : %2/Records Imported. ', NLD = 'Geïmporteerd bestand %1\Aantal records geïmporteerd %2.';
        Text50002: TextConst ENU = 'Please enter a journal template.', NLD = 'Geef eerst een dagboeksjabloon in.';
        Text50003: TextConst ENU = 'There are no journal batches with the journal template %1.', NLD = 'Er bestaan geen dagboekbatches bij het dagboeksjabloon %1.';
        Text50004: TextConst ENU = 'The journal batch was not found.', NLD = 'De opgeven dagboekbatch is niet gevonden.';
        gIntCounterImported: Integer;
        gCduFileMgt: Codeunit "File Management";
        [InDataSet]
        gBlnDocNoVisible: Boolean;
        gCodFinJournalTemplate: Code[10];
        gCodShortcutDimCode3: Code[20];
        gShortcutDim8: Code[20];
        gShortcutDim7: Code[20];
        gShortcutDim5: Code[20];

    procedure fConvertStringToDate(pTxtString: Text[30]): Date;
    var
        lIntDay: Integer;
        lIntMonth: Integer;
        lIntYear: Integer;
        lDate: Date;
    begin
        /* fConvertStringToDate */

        /*EVALUATE(lIntDay, COPYSTR(pTxtString, 1, 2));
        EVALUATE(lIntMonth, COPYSTR(pTxtString, 4, 2));
        EVALUATE(lIntYear, COPYSTR(pTxtString, 7, 4));
        lDate := DMY2DATE(lIntDay, lIntMonth, lIntYear);
        exit(DMY2DATE(lIntDay, lIntMonth, lIntYear));*/
        Evaluate(lDate, pTxtString);//commented above code to accept date based on region- dd/mm/yyyy and mm/dd/yyyy both
        exit(lDate);
    end;

    procedure fConvertStringToInteger(pTxtString: Text[30]): Integer;
    var
        lInt: Integer;
    begin
        EVALUATE(lInt, pTxtString);

        exit(lInt);
    end;

    procedure fConvertStringToDecimal(pTxtString: Text[30]): Decimal;
    var
        lDec: Decimal;
    begin
        EVALUATE(lDec, pTxtString);

        exit(lDec);
    end;

    procedure fClrVar();
    begin

        gTxtAccountType := '';
        gTxtAccountNo := '';
        gTxtDescription := '';
        gTxtWorkDate := '';
        gTxtAmount := '';
        gTxtDimension1 := '';
        gTxtDimension2 := '';
        gTxtDimension3 := '';
        gtxtTax := '';
        gtxtInterCompanyPartner := '';
    end;

    procedure fImportRecord();
    begin
        gIntCounter := gIntCounter + 1;
        if gIntCounter = 1 then
            //exit;
            currXMLport.Skip();
        gDialog.UPDATE(1, gTxtFileName);
        gDialog.UPDATE(2, gIntCounter);

        gIntCounterImported := gIntCounterImported + 1;


        EVALUATE(gDecAmount, gTxtAmount);
        CLEAR(gRecGenJournalLine);

        gRecGenJournalLine.RESET;
        gRecGenJournalLine.VALIDATE("Journal Template Name", gRecGenJournalBatch."Journal Template Name");
        gRecGenJournalLine.VALIDATE("Journal Batch Name", gRecGenJournalBatch.Name);
        gRecGenJournalLine.SETRANGE("Journal Template Name", gRecGenJournalBatch."Journal Template Name");
        gRecGenJournalLine.SETRANGE("Journal Batch Name", gRecGenJournalBatch.Name);

        gRecFinanceJournalLine.RESET;
        gRecFinanceJournalLine.SETRANGE("Journal Template Name", gRecGenJournalBatch."Journal Template Name");
        gRecFinanceJournalLine.SETRANGE("Journal Batch Name", gRecGenJournalBatch.Name);
        if gRecFinanceJournalLine.FINDLAST then begin
            gCduGenJnlManagement.CalcBalance(gRecGenJournalLine, gRecFinanceJournalLine, gDecBalance, gDecTotalBalance,
                                         gBoolShowBalance, gBoolShowTotalBalance);
        end else begin
            gCduGenJnlManagement.CalcBalance(gRecGenJournalLine, gRecFinanceJournalLine, gDecBalance, gDecTotalBalance,
                                         gBoolShowBalance, gBoolShowTotalBalance);
        end;

        if (gCodDocumentNo = '') then begin
            if not gBlnUseTheSameNumber then begin
                COMMIT;
                gRecGenJournalLine.SetUpNewLine(gRecFinanceJournalLine, gDecBalance, true);
                gBlnUseTheSameNumber := true;
            end else begin
                gRecGenJournalLine.SetUpNewLine(gRecFinanceJournalLine, gDecBalance, false);
            end;
        end;

        fCreateNewJournalLine(gRecGenJournalBatch,
                                gRecGenJournalLine);
    end;

    procedure fCreateNewJournalLine(pRecGenJournalBatch: Record "Gen. Journal Batch"; var pRecGenJournalLine: Record "Gen. Journal Line"): Boolean;
    var
        lRecFindagboeksjabloon: Record "Gen. Journal Template";
        lBoolBelowxRec: Boolean;
        lRecFindagboekregel: Record "Gen. Journal Line";
    begin

        lRecFindagboekregel.RESET;
        lRecFindagboekregel.SETRANGE("Journal Template Name", pRecGenJournalBatch."Journal Template Name");
        lRecFindagboekregel.SETRANGE("Journal Batch Name", pRecGenJournalBatch.Name);
        if not lRecFindagboekregel.FIND('+') then begin
            lRecFindagboekregel."Line No." := 0;
        end;
        if lRecFindagboeksjabloon.GET(gCodFinJournalTemplate) then;

        pRecGenJournalLine."Line No." := lRecFindagboekregel."Line No." + 10000;
        pRecGenJournalLine.VALIDATE("Source Code", lRecFindagboeksjabloon."Source Code");
        pRecGenJournalLine.VALIDATE("Reason Code", pRecGenJournalBatch."Reason Code");
        pRecGenJournalLine.VALIDATE("Posting No. Series", pRecGenJournalBatch."Posting No. Series");
        pRecGenJournalLine.VALIDATE("Posting Date", fConvertStringToDate(gTxtWorkDate));
        case gTxtAccountType of
            'G':
                pRecGenJournalLine.VALIDATE("Account Type", pRecGenJournalLine."Account Type"::"G/L Account");
            'V':
                pRecGenJournalLine.VALIDATE("Account Type", pRecGenJournalLine."Account Type"::Vendor);
            'C':
                pRecGenJournalLine.VALIDATE("Account Type", pRecGenJournalLine."Account Type"::Customer);
            'B':
                pRecGenJournalLine.VALIDATE("Account Type", pRecGenJournalLine."Account Type"::"Bank Account");
        end;
        pRecGenJournalLine.VALIDATE("Account No.", gTxtAccountNo);
        pRecGenJournalLine.VALIDATE(Amount, gDecAmount);
        pRecGenJournalLine.VALIDATE("Shortcut Dimension 1 Code", gTxtDimension1);
        pRecGenJournalLine.VALIDATE("Shortcut Dimension 2 Code", gTxtDimension2);
        //LT-Start
        //pRecGenJournalLine.Validate("Credit Card Payee No.", gtxtVendorNumber);

        if Evaluate(gShortcutDim5, gtxtInterCompanyPartner) then
            pRecGenJournalLine.ValidateShortcutDimCode(3, gShortcutDim5);

        if EVALUATE(gCodShortcutDimCode3, gTxtDimension3) then
            pRecGenJournalLine.ValidateShortcutDimCode(4, gCodShortcutDimCode3); //20190102 KBG NMSD-240

        if Evaluate(gShortcutDim7, gtxtTax) then
            pRecGenJournalLine.ValidateShortcutDimCode(5, gShortcutDim7);

        // if Evaluate(gShortcutDim7, gtxtTax) then
        //     pRecGenJournalLine.ValidateShortcutDimCode(7, gShortcutDim7);

        // if Evaluate(gShortcutDim8, gtxtCreditCardPayee) then
        //     pRecGenJournalLine.ValidateShortcutDimCode(8, gShortcutDim8);

        //LT-End
        //pRecGenJournalLine."Shortcut Dimension 3 Code"         := gTxtDimension3;
        //pRecGenJournalLine."Shortcut Dimension 3 Code"         := gTxtDimension3; //20181122 JS Projectveld=Dimension3 toegevoegd

        pRecGenJournalLine.Description := COPYSTR(gTxtDescription, 1, 50);
        if (gCodDocumentNo <> '') then
            pRecGenJournalLine."Document No." := gCodDocumentNo;
        pRecGenJournalLine.INSERT(true);

        exit(true);
    end;

    procedure fLookupDagboekBatch();
    var
        lRecGenJournalBatch: Record "Gen. Journal Batch";
        lFrmGeneralJournalBatches: Page "General Journal Batches";
    begin


        if (gCodFinJournalTemplate = '') then
            ERROR(Text50002);

        lRecGenJournalBatch.RESET;
        lRecGenJournalBatch.SETRANGE("Journal Template Name", gCodFinJournalTemplate);

        if (lRecGenJournalBatch.FIND('-')) then begin
            CLEAR(lFrmGeneralJournalBatches);
            lFrmGeneralJournalBatches.SETTABLEVIEW(lRecGenJournalBatch);
            lFrmGeneralJournalBatches.LOOKUPMODE(true);
            if (lFrmGeneralJournalBatches.RUNMODAL = ACTION::LookupOK) then begin
                lFrmGeneralJournalBatches.GETRECORD(lRecGenJournalBatch);
                gCodJournalBatch := lRecGenJournalBatch.Name;
            end;
        end else
            MESSAGE(Text50003, gCodFinJournalTemplate);

        if (lRecGenJournalBatch."No. Series" = '') then
            gBlnDocNoVisible := true
        else begin
            gBlnDocNoVisible := false;
            gCodDocumentNo := '';
        end;

    end;
}

