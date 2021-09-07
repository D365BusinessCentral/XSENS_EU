pageextension 50034 "Payment Reconciliation journal" extends "Payment Reconciliation Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Post)
        {
            Visible = false;
        }
    }
}
