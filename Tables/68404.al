table 68404 "Klacht koppelingen"
{
    // version KLA1.00,XSS5.006

    Caption = 'Complaint Associations';

    fields
    {
        field(1; Stuknummer; Code[20])
        {
            CaptionML = ENU = 'Source No.',
                        NLD = 'Stuknummer';
        }
        field(4; Documentsoort; Code[20])
        {
            CaptionML = ENU = 'Document Type',
                        NLD = 'Documentsoort';
            TableRelation = "XSS Complaint Type".Code WHERE(Codesoort = CONST('KLACHTRELATIE'));

            trigger OnValidate();
            begin
                gCduKlacht.fKKPDocumentsoortOnvalidate(xRec, Rec);
            end;
        }
        field(5; "Documentnr."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        NLD = 'Documentnr.';

            trigger OnLookup();
            begin
                gCduKlacht.fKKPLookupDocument(Rec, TRUE);
            end;

            trigger OnValidate();
            begin
                gCduKlacht.fKKPDocumentnrOnvalidate(xRec, Rec);
            end;
        }
        field(6; "Documentregelnr."; Integer)
        {
            CaptionML = ENU = 'Document Line No.',
                        NLD = 'Documentregelnr.';

            trigger OnLookup();
            begin
                gCduKlacht.fKKPLookupDocument(Rec, FALSE);
            end;
        }
    }

    keys
    {
        key(Key1; Stuknummer, Documentsoort, "Documentnr.", "Documentregelnr.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        gCduKlacht.fKKPOnInsert(Rec);
    end;

    trigger OnModify();
    begin
        gCduKlacht.fKKPOnModify(Rec);
    end;

    trigger OnRename();
    begin
        gCduKlacht.fKKPOnRename(Rec)
    end;

    var
        gCduKlacht: Codeunit 68400;
}

