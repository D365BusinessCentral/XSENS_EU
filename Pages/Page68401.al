page 68401 "XSS Complaint Subform"
{
    // version XSS5.006

    CaptionML = ENU = 'Complaint Subform',
                NLD = 'Klacht subform';
    PageType = ListPart;
    SourceTable = "XSS Complaint Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Stuknummer; Rec.Stuknummer)
                {
                    ApplicationArea = All;
                    Caption = 'Stuknummer';
                }
                field("Regelnr."; Rec."Regelnr.")
                {
                    ApplicationArea = All;
                    Caption = 'Regelnr.';
                }
                field(Datum; Rec.Datum)
                {
                    ApplicationArea = All;
                    Caption = 'Datum';
                }
                field("Behandeld door"; Rec."Behandeld door")
                {
                    ApplicationArea = All;
                    Caption = 'Behandeld door';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field(Omschrijving; Rec.Omschrijving)
                {
                    ApplicationArea = All;
                    Caption = 'Omschrijving';
                }
                field(Stuksoort; Rec.Stuksoort)
                {
                    ApplicationArea = All;
                    Caption = 'Stuksoort';
                }
                field("Fout Code"; Rec."Fout Code")
                {
                    ApplicationArea = All;
                    Caption = 'Fout Code';
                }
                field("Oplossing code"; Rec."Oplossing code")
                {
                    ApplicationArea = All;
                    Caption = 'Oplossing code';
                }
                field("Repair time"; Rec."Repair time")
                {
                    ApplicationArea = All;
                    Caption = 'Repair time';
                }
                field("Repair value"; Rec."Repair value")
                {
                    ApplicationArea = All;
                    Caption = 'Repair value';
                }
                field(ChangedTreatment; Rec.ChangedTreatment)
                {
                    ApplicationArea = All;
                    Caption = 'ChangedTreatment';
                }
            }
        }
    }

    actions
    {
    }
}

