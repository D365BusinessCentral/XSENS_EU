table 75001 "Part Tracking Specification"
{
    // version KLA1.00,XSS5.006

    // 20170613 KBG 09800: New table

    CaptionML = ENU = 'Tracking Specification',
                NLD = 'Traceringsspecificatie';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            CaptionML = ENU = 'Entry No.',
                        NLD = 'Volgnummer';
        }
        field(2; "Item No."; Code[20])
        {
            CaptionML = ENU = 'Item No.',
                        NLD = 'Artikelnr.';
            TableRelation = Item;
        }
        field(3; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        NLD = 'Vestiging';
            TableRelation = Location;
        }
        field(4; "Quantity (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity (Base)',
                        NLD = 'Aantal (Basis)';
            DecimalPlaces = 0 : 5;
        }
        field(7; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        NLD = 'Omschrijving';
        }
        field(8; "Creation Date"; Date)
        {
            CaptionML = ENU = 'Creation Date',
                        NLD = 'Gemaakt op';
        }
        field(10; "Source Type"; Integer)
        {
            CaptionML = ENU = 'Source Type',
                        NLD = 'Bronsoort';
        }
        field(11; "Source Subtype"; Option)
        {
            CaptionML = ENU = 'Source Subtype',
                        NLD = 'Bronsubsoort';
            OptionCaptionML = ENU = '0,1,2,3,4,5,6,7,8,9,10',
                              NLD = '0,1,2,3,4,5,6,7,8,9,10';
            OptionMembers = "0","1","2","3","4","5","6","7","8","9","10";
        }
        field(12; "Source ID"; Code[20])
        {
            CaptionML = ENU = 'Source ID',
                        NLD = 'Voor id';
        }
        field(13; "Part No."; Code[20])
        {
            CaptionML = ENU = 'Part No.',
                        NLD = 'Partnummer';
            NotBlank = true;

            trigger OnValidate();
            begin
                IF DELCHR("Part No.", '=') = '' THEN
                    ERROR(Text006, FIELDCAPTION("Part No."));
            end;
        }
        field(14; "Source Ref. No."; Integer)
        {
            CaptionML = ENU = 'Source Ref. No.',
                        NLD = 'Bronreferentienr.';
        }
        field(50; "Qty. to Handle (Base)"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Handle (Base)',
                        NLD = 'Te verwerken aantal (Basis)';
            DecimalPlaces = 0 : 5;
        }
        field(51; "Qty. to Invoice (Base)"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Invoice (Base)',
                        NLD = 'Te factureren aantal (Basis)';
            DecimalPlaces = 0 : 5;
        }
        field(52; "Quantity Handled (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity Handled (Base)',
                        NLD = 'Verwerkt aantal (Basis)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(53; "Quantity Invoiced (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity Invoiced (Base)',
                        NLD = 'Gefactureerd aantal (Basis)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(60; "Qty. to Handle"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Handle',
                        NLD = 'Te verwerken aantal';
            DecimalPlaces = 0 : 5;
        }
        field(61; "Qty. to Invoice"; Decimal)
        {
            CaptionML = ENU = 'Qty. to Invoice',
                        NLD = 'Te factureren aantal';
            DecimalPlaces = 0 : 5;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Source ID", "Source Type", "Source Subtype")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: TextConst ENU = 'You cannot invoice more than %1 units.', NLD = 'U kunt niet meer dan %1 eenheden factureren.';
        Text001: TextConst ENU = 'You cannot handle more than %1 units.', NLD = 'U kunt niet meer dan %1 eenheden verwerken.';
        Text002: TextConst ENU = 'must not be less than %1', NLD = 'mag niet kleiner dan %1 zijn.';
        Text003: TextConst ENU = '%1 must be -1, 0 or 1 when %2 is stated.', NLD = '%1 moet -1, 0 of 1 zijn wanneer %2 is ingevuld.';
        Text004: TextConst ENU = 'Expiration date has been established by existing entries and cannot be changed.', NLD = 'Verloopdatum wordt bepaald door bestaande posten en kan niet worden gewijzigd.';
        WMSManagement: Codeunit 7302;
        Text005: TextConst ENU = '%1 in %2 for %3 %4, %5: %6, %7: %8 is currently %9. It must be %10.', NLD = '%1 in %2 for %3 %4, %5: %6, %7: %8 is momenteel %9 maar moet %10 zijn.';
        SkipSerialNoQtyValidation: Boolean;
        Text006: Label '%1 mag niet leeg zijn.';
}

