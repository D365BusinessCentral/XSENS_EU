page 68404 "XSS Complaint Types"
{
    // version XSS5.006

    CaptionML = ENU = 'Complaint Types',
                NLD = 'Klachtensoorten';
    PageType = List;
    SourceTable = "XSS Complaint Type";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Codesoort; Rec.Codesoort)
                {
                    ApplicationArea = All;
                    Caption = 'Codesoort';
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field(Omschrijving; Rec.Omschrijving)
                {
                    ApplicationArea = All;
                    Caption = 'Omschrijving';
                }
                field("Code ENU"; Rec."Code ENU")
                {
                    ApplicationArea = All;
                    Caption = 'Code ENU';
                }
                field("Omschrijving ENU"; Rec."Omschrijving ENU")
                {
                    ApplicationArea = All;
                    Caption = 'Omschrijving ENU';
                }
                field(Actief; Rec.Actief)
                {
                    ApplicationArea = All;
                    Caption = 'Actief';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1100510009; Links)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            systempart(Control1100510008; Notes)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

