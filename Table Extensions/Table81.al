tableextension 50016 "Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50001; "Description 2"; Text[50])
        {
            CaptionML = ENU = 'Description 2',
                        NLD = 'Omschrijving 2';
            DataClassification = ToBeClassified;
            Description = 'GBTxt';
        }
        /*field(50002; "Check Exported"; Boolean)
        {
            CaptionML = ENU = 'Check Exported',
                        ESM = 'Cheque exportado',
                        FRC = 'Chèque exporté',
                        ENC = 'Cheque Exported';
            DataClassification = ToBeClassified;
            Editable = false;
        }*/
        /*field(50003; "Export File Name"; Text[30])
        {
            CaptionML = ENU = 'Export File Name',
                        ESM = 'Export. nomb. arch.',
                        FRC = 'Nom du fichier d''exportation',
                        ENC = 'Export File Name';
            DataClassification = ToBeClassified;
            Editable = false;
        }*/
        field(50004; "Check Transmitted NM"; Boolean)
        {
            CaptionML = ENU = 'Check Transmitted',
                        ESM = 'Cheque emitido',
                        FRC = 'Chèque transmis',
                        ENC = 'Cheque Transmitted';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50005; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnLookup();
            var
                lCduDimensionXsensMgt: Codeunit "Dimension Xsens  Mgt";
            begin
                lCduDimensionXsensMgt.fLookUpDimensionvalues(3, "Shortcut Dimension 3 Code");
                VALIDATE("Shortcut Dimension 3 Code");
            end;

            trigger OnValidate();
            var
                lCduDimensionXsensMgt: Codeunit "Dimension Xsens  Mgt";
            begin
                lCduDimensionXsensMgt.ffillJournalLinedimensie(Rec, "Shortcut Dimension 3 Code");
            end;
        }
        //Below two field has been added by LT-22JUNE2021
        /*field(50006; "Credit Card Payee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor where("Payment Method Code" = const('CREDITCARD'));
            ValidateTableRelation = true;
            trigger OnValidate()
            var
                Recvendor: Record Vendor;
            begin
                if "Credit Card Payee No." <> '' then begin
                    Recvendor.GET("Credit Card Payee No.");
                    Validate("Credit Card Payee Name", Recvendor.Name);
                end else begin
                    Validate("Credit Card Payee Name", '');
                end;
            end;
        }
        field(50007; "Credit Card Payee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }*/
        //- Above two fields added by LT - 22JUNE2021
        field(87000; Permanence; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(87001; "Permanence Document No."; Code[20])
        {
            CaptionML = ENU = 'Permanence Document No.',
                        NLD = 'Permanence Document Nr.';
            DataClassification = ToBeClassified;
        }
        field(87002; "Delay posting"; Boolean)
        {
            CaptionML = ENU = 'Delay posting',
                        NLD = 'Uitgesteld boeken';
            DataClassification = ToBeClassified;
        }
    }
}