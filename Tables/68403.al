table 68403 "XSS Complaint Type"
{
    // version KLA1.00,XSS5.036

    CaptionML = ENU = 'Complaint Type',
                NLD = 'Klachtensoort';
    DrillDownPageID = 68404;
    LookupPageID = 68404;

    fields
    {
        field(1; Codesoort; Code[20])
        {
            CaptionML = ENU = 'Codetype',
                        NLD = 'Codesoort';
        }
        field(2; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code',
                        NLD = 'Code';
        }
        field(3; Omschrijving; Text[30])
        {
            CaptionML = ENU = 'Description',
                        NLD = 'Omschrijving';
        }
        field(4; Subtype; Code[20])
        {
            CaptionML = ENU = 'Subtype',
                        NLD = 'Subtype';
        }
        field(5; Volgorde; Integer)
        {
            CaptionML = ENU = 'Order',
                        NLD = 'Volgorde';
        }
        field(6; "Code ENU"; Code[20])
        {
            CaptionML = ENU = 'Code ENU',
                        NLD = 'Code ENU';
        }
        field(7; "Omschrijving ENU"; Text[30])
        {
            CaptionML = ENU = 'Description ENU',
                        NLD = 'Omschrijving ENU';
        }
        field(10; Actief; Boolean)
        {
            CaptionML = ENU = 'Active',
                        NLD = 'Actief';
            InitValue = true;
        }
    }

    keys
    {
        key(Key1; Codesoort, "Code")
        {
        }
        key(Key2; Volgorde, Codesoort, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        gCduKlacht.fKSGOnDelete(Rec);
    end;

    trigger OnInsert();
    begin
        gCduKlacht.fKSGOnInsert(Rec);
    end;

    trigger OnModify();
    begin
        gCduKlacht.fKSGOnModify(xRec, Rec);
    end;

    trigger OnRename();
    begin
        gCduKlacht.fKSGOnDelete(Rec);
    end;

    var
        gCduKlacht: Codeunit 68400;
}

