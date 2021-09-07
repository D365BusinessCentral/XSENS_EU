pageextension 50005 "Sales Quote" extends "Sales Quote"
{
    layout
    {
        addlast(Control49)
        {
            field("Bill-to Email"; Rec."Bill-to Email")
            {
                ApplicationArea = All;
            }
        }
    }
}
