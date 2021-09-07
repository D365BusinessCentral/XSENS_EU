page 68402 "XSS Complaint Comments"
{
    // version XSS5.017

    CaptionML = ENU = 'Complaint Comments',
                NLD = 'Klachtopmerkingen';
    PageType = List;
    SourceTable = "XSS Complaint Comment";
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
                field("Regelnr."; Rec."Regelnr.")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Regelnr.';
                }
                field(Datum; Rec.Datum)
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Datum';
                }
                field(Commentaar; Rec.Commentaar)
                {
                    ApplicationArea = All;
                    Caption = 'Commentaar';
                }
                field(Stuksoort; Rec.Stuksoort)
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Stuksoort';
                }
            }
        }
    }

    actions
    {
    }
}

