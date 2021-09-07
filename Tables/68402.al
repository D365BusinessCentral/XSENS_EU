table 68402 "XSS Complaint Comment"
{
    // version KLA1.00,XSS5.042

    // 20090918 GFR 20799: Veld 5: Stuksoort toegevoegd
    // 20090918 GFR 20799: Stuksoort aan primary key toegevoegd.

    Caption = 'Complaint Comment Lines';

    fields
    {
        field(1; Stuknummer; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        NLD = 'Stuknummer';
        }
        field(2; "Regelnr."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        NLD = 'Regelnr.';
        }
        field(3; Datum; Date)
        {
            CaptionML = ENU = 'Date',
                        NLD = 'Datum';
        }
        field(4; Commentaar; Text[250])
        {
            CaptionML = ENU = 'Comment',
                        NLD = 'Commentaar';
        }
        field(5; Stuksoort; Option)
        {
            OptionCaptionML = ENU = 'Complaint,Corrective actions,Root Cause,Preventive actions',
                              NLD = 'Klacht,Corrigeren,Root Cause,Preventief';
            OptionMembers = Klacht,Corrigeren,"Root Cause",Preventief;
        }
    }

    keys
    {
        key(Key1; Stuknummer, Stuksoort, Datum, "Regelnr.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        gCduKlacht.fKORInsert(Rec);
    end;

    var
        gCduKlacht: Codeunit 68400;
}

