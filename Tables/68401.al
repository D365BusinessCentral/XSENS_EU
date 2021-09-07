table 68401 "XSS Complaint Line"
{
    // version KLA1.00,XSS5.036

    // 20090918 GFR 20799: Velden 7 t/m 9 toegevoegd.
    // 20090918 GFR 20799: Stuksoort aan primary key toegevoegd.
    // 20091014 GFR 21074: Velden 10 en 11 toegevoegd, verwijzing naar funtie gemaakt.

    CaptionML = ENU = 'Complaint Line',
                NLD = 'Klachtregel';

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
        field(4; "Behandeld door"; Code[10])
        {
            CaptionML = ENU = 'Treated by',
                        NLD = 'Behandeld door';
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                gCduKlacht.fChangeAssignedToByTreatmentBy(Rec, xRec);  //20091014 GFR 21074
                ChangedTreatment := TRUE;
            end;
        }
        field(5; Status; Code[20])
        {
            CaptionML = ENU = 'Status',
                        NLD = 'Status';
            TableRelation = "XSS Complaint Type".Code WHERE(Codesoort = CONST('KLACHTSTATUS'),
                                                             Actief = CONST(true));

            trigger OnValidate();
            begin
                gCduKlacht.fKRGOnValidateStatus(xRec, Rec);
            end;
        }
        field(6; Omschrijving; Text[250])
        {
            CaptionML = ENU = 'Description',
                        NLD = 'Omschrijving';
        }
        field(7; Stuksoort; Option)
        {
            OptionCaptionML = ENU = 'Status History,diagnosis overview,Repair overview,Corrective actions,Root Cause,Preventive actions',
                              NLD = 'Status historie,Diagnose overzicht,Reparatie overzicht,Corrigeren,Root Cause,Preventief';
            OptionMembers = "Status historie","Diagnose overzicht","Reparatie overzicht",Corrigeren,"Root Cause",Preventief;
        }
        field(8; "Fout Code"; Code[20])
        {
            CaptionML = ENU = 'Fault code',
                        NLD = 'Fout Code';
            TableRelation = "Fault Code".Code;
        }
        field(9; "Oplossing code"; Code[20])
        {
            CaptionML = ENU = 'Resolution Code',
                        NLD = 'Oplossing Code';
            TableRelation = "Resolution Code".Code;
        }
        field(10; "Repair time"; Time)
        {
        }
        field(11; "Repair value"; Code[20])
        {
        }
        field(12; ChangedTreatment; Boolean)
        {
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

    var
        gCduKlacht: Codeunit 68400;
}

