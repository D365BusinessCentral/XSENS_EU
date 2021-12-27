pageextension 50048 "Posted Sales Invoices" extends "Posted Sales Invoices"
{
    layout
    {
        modify("Order No.")
        {
            Visible = true;
        }
        addlast(Control1)
        {
            field("Your Reference"; Rec."Your Reference")
            {
                ApplicationArea = All;
            }
        }
    }
}
