tableextension 50006 Customer extends Customer
{
    fields
    {
        field(50000; "Transport extra text"; Text[50])
        {
        }
        field(50001; "Industry Group Code"; Code[10])
        {
            CaptionML = ENU = 'Industry Group',
                        NLD = 'Sector';
            Description = 'No longer used';
            TableRelation = "Industry Group";
        }
        /*field(50003; "Bank Communication"; Option)
        {
            CaptionML = ENU = 'Bank Communication',
                        ESM = 'Comunicación banco',
                        FRC = 'Communication avec la banque',
                        ENC = 'Bank Communication';
            Description = 'No longer used';
            OptionCaptionML = ENU = 'E English,F French,S Spanish',
                              ESM = 'I Inglés,F Francés,E Español',
                              FRC = 'E Anglais, F Français, S Espagnol',
                              ENC = 'E English,F French,S Spanish';
            OptionMembers = "E English","F French","S Spanish";
        }*/
        field(50004; "Application area"; Text[30])
        {
            Description = 'No longer used';
        }
        field(50005; Application; Text[30])
        {
            Description = 'No longer used';
        }
        field(50010; ExternalID; Text[30])
        {
        }
        field(50011; SFDCAccountID; Text[30])
        {
            Enabled = false;
        }
        field(50015; "Name 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "VAT Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "VAT Address & Telephone"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "VAT Bank Name & Account"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "VAT Invoice Mail Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "VAT Contact Information"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50450; "Bill-to Email"; Text[80])
        {
            CaptionML = ENU = 'Bill-to Email',
                        NLD = 'Factuur naar Email';
            Description = 'No longer used';
        }
        /*field(11000000; "Transaction Mode Code"; Code[20])
        {
            CaptionML = ENU = 'Transaction Mode Code',
                        NLD = 'Code transactiewijze';
            TableRelation = "Transaction Mode".Code WHERE("Account Type" = CONST(Customer));

            trigger OnValidate();
            var
                TrMode: Record "Transaction Mode";
            begin
                if "Transaction Mode Code" <> '' then begin
                    TrMode.GET(TrMode."Account Type"::Customer, "Transaction Mode Code");
                    if TrMode."Payment Method Code" <> '' then
                        "Payment Method Code" := TrMode."Payment Method Code";
                    if TrMode."Payment Terms Code" <> '' then
                        "Payment Terms Code" := TrMode."Payment Terms Code";
                end;
            end;
        }*/
    }
}