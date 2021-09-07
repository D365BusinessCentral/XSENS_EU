pageextension 50027 "VAT Entries" extends "VAT Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Tax Jurisdiction Code"; Rec."Tax Jurisdiction Code")
            {
                ApplicationArea = All;
            }
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
