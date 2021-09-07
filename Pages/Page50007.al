page 50007 "Wijzigingslog documenten"
{
    // version XSS5.006

    PageType = List;
    SourceTable = "Wijzigingslog documenten";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Soort"; Rec."Document Soort")
                {
                    ApplicationArea = All;
                    Caption = 'Document Soort';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                }
                field("Document Nummer"; Rec."Document Nummer")
                {
                    ApplicationArea = All;
                    Caption = 'Document Nummer';
                }
                field("Document Regel"; Rec."Document Regel")
                {
                    ApplicationArea = All;
                    Caption = 'Document Regel';
                }
                field(Gebruiker; Rec.Gebruiker)
                {
                    ApplicationArea = All;
                    Caption = 'Gebruiker';
                }
                field(Datum; Rec.Datum)
                {
                    ApplicationArea = All;
                    Caption = 'Datum';
                }
                field(Tijd; Rec.Tijd)
                {
                    ApplicationArea = All;
                    Caption = 'Tijd';
                }
                field("Boekingsdatum akkoord"; Rec."Boekingsdatum akkoord")
                {
                    ApplicationArea = All;
                    Caption = 'Boekingsdatum akkoord';
                }
                field("Boekingsdatum document"; Rec."Boekingsdatum document")
                {
                    ApplicationArea = All;
                    Caption = 'Boekingsdatum document';
                }
                field("Document geboekt"; Rec."Document geboekt")
                {
                    ApplicationArea = All;
                    Caption = 'Document geboekt';
                }
            }
        }
    }

    actions
    {
    }
}

