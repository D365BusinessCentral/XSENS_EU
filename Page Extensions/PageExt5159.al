pageextension 50018 "Sales Order Archive" extends "Sales Order Archive"
{
    layout
    {
        addlast(Invoicing)
        {
            field("Bill-to Email"; Rec."Bill-to Email")
            {
                ApplicationArea = All;
            }
        }
    }
}
