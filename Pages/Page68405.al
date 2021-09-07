page 68405 "XSS Complaint Document Factbox"
{
    // version XSS5.017

    PageType = ListPart;
    SourceTable = "Klacht koppelingen";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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

