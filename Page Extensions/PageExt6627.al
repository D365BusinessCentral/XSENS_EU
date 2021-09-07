pageextension 50023 "Sales Return Order Archive" extends "Sales Return Order Archive"
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
