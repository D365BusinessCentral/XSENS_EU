pageextension 50033 "Pstd. Pmt. Recon. Subform" extends "Pstd. Pmt. Recon. Subform"
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
}
