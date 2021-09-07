pageextension 50011 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Quote No. Supplier"; Rec."Quote No. Supplier")
            {
                ApplicationArea = All;
            }
        }
    }
}