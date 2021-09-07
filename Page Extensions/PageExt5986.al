pageextension 50022 "Service Item Component List" extends "Service Item Component List"
{
    layout
    {
        addlast(Control1)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
            }
        }

    }
}
