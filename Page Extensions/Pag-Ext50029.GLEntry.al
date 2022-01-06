pageextension 50029 GLEntry extends "General Ledger Entries"
{
    layout

    {
        addlast(Control1)
        {
            /*field("Vendor No."; Rec."Credit Card Payee No.")
            {
                ApplicationArea = All;
                Caption = 'Vendor No.';
            }
            field("Vendor Name"; Rec."Credit Card Payee Name")
            {
                ApplicationArea = All;
                Caption = 'Vendor Name';
            }*/
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
            }
            field("Business Unit Code"; Rec."Business Unit Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Source Type")
        {
            Visible = true;
        }
        modify("Source No.")
        {
            Visible = true;
        }
    }
}
