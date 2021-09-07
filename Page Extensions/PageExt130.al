pageextension 50012 "Posted Sales Shipment" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(Billing)
        {
            field("Bill-to Email"; Rec."Bill-to Email")
            {
                ApplicationArea = All;
            }
        }
    }
}
