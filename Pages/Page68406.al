page 68406 "XSS Complaint Documents"
{
    // version XSS5.017

    PageType = List;
    SourceTable = "Klacht koppelingen";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Stuknummer; Rec.Stuknummer)
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Stuknummer';
                }
                field(Documentsoort; Rec.Documentsoort)
                {
                    ApplicationArea = All;
                    Caption = 'Documentsoort';
                }
                field("Documentnr."; Rec."Documentnr.")
                {
                    ApplicationArea = All;
                    Caption = 'Documentnr.';
                }
                field("Documentregelnr."; Rec."Documentregelnr.")
                {
                    ApplicationArea = All;
                    Caption = 'Documentregelnr.';
                }
            }
        }
    }

    actions
    {
    }
}

