page 50006 County
{
    // version XSS5.020

    // 0181025 ELN 14652: Object created

    Caption = 'County';
    PageType = Card;
    SourceTable = County;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                    Caption = 'County';
                }
                field(Omschrijving; Rec.Omschrijving)
                {
                    ApplicationArea = All;
                    Caption = 'Omschrijving';
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                    Caption = 'Tax Area Code';
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                    Caption = 'Tax Liable';
                }
            }
        }
    }

    actions
    {
    }
}

