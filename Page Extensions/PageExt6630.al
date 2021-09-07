pageextension 50024 "Sales Return Order" extends "Sales Return Order"
{
    layout
    {
        addlast("Bill-to")
        {
            field("Bill-to Email"; Rec."Bill-to Email")
            {
                ApplicationArea = All;
            }
        }
    }
}
