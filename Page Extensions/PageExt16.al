pageextension 50001 "Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {
        addlast(Control1)
        {
            field("No. of Blank Lines"; Rec."No. of Blank Lines")
            {
                ApplicationArea = All;
            }
        }
    }
}

