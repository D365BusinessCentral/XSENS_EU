tableextension 50000 CompanyInformation extends "Company Information"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Use US Tax System"; Boolean)
        {
            CaptionML = ENU = 'Use US Tax System',
                        NLD = 'Gebruik belastingsysteem VS';
        }
        field(50304; "Std. Purchasing Code"; Code[10])
        {
            CaptionML = ENU = 'Purchasing Code',
                        NLD = 'Std. Inkoopcode';
            TableRelation = Purchasing;
        }
        field(50305; "Std. Purchasing Company"; Code[20])
        {
            CaptionML = ENU = 'Vendor No.',
                        NLD = 'Std. Inkoopbedrijf';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            var
                lRecVendor: Record Vendor;
            begin
                IF "Std. Purchasing Company" <> '' THEN BEGIN
                    IF lRecVendor.GET("Std. Purchasing Company") THEN BEGIN
                        IF lRecVendor.Blocked = lRecVendor.Blocked::All THEN
                            ERROR(Text50300, lRecVendor."No.");
                    END;
                END;
            end;
        }
        /*field(50306; "Federal ID No."; Text[30])
        {
            CaptionML = ENU = 'Federal ID No.',
                        ESM = 'CURP',
                        FRC = 'N° d''identification fédéral',
                        ENC = 'Federal BIN No.';
        }*/
        field(50307; Lockbox; Text[50])
        {
        }
        field(50308; "Tax Area Los Angeles"; Boolean)
        {
        }
        field(50309; "Company Location"; Option)
        {
            CaptionML = ENU = 'Company Location',
                        NLD = 'Bedrijfslocatie';
            OptionCaptionML = ENU = 'The Netherlands,North-America',
                              NLD = 'Nederland,Noord-Amerika';
            OptionMembers = Holland,"North America";
        }
        field(50310; "Company Name for Intercompany"; Text[50])
        {
            CaptionML = ENU = 'Company Name for Intercompany',
                        NLD = 'Bedrijfsnaam voor Intercompany';
        }
        field(50311; "Bank Name USD"; Text[50])
        {
            CaptionML = ENU = 'Bank Name',
                        NLD = 'Banknaam';
            DataClassification = ToBeClassified;
        }
        field(50312; "IBAN USD"; Code[50])
        {
            CaptionML = ENU = 'IBAN',
                        NLD = 'IBAN';
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                CheckIBAN("IBAN USD");
            end;
        }
        field(50313; "SWIFT Code USD"; Code[20])
        {
            CaptionML = ENU = 'SWIFT Code',
                        NLD = 'SWIFT-code';
            DataClassification = ToBeClassified;
        }
        field(50314; "Payment Note"; Text[250])
        {
            CaptionML = ENU = 'Payment Note',
                        NLD = 'Betalingsopmerking';
            DataClassification = ToBeClassified;
        }
    }

    var
        Text50300: Label 'De gekozen leverancier %1 is geblokkeerd!';
}

