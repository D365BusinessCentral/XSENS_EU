pageextension 50026 "Purchase Order List" extends "Purchase Order List"
{
    layout
    {
        addafter("Amount Including VAT")
        {
            field("Quote No. Supplier"; Rec."Quote No. Supplier")
            {
                ApplicationArea = All;
            }
        }
    }
}
