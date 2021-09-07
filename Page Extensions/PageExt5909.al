pageextension 50020 "Service Item Groups" extends "Service Item Groups"
{
    layout
    {
        addlast(Control1)
        {
            field("Default Warranty Duration"; Rec."Default Warranty Duration")
            {
                ApplicationArea = All;
            }
            field("Skip on shipment document"; Rec."Skip on shipment document")
            {
                ApplicationArea = Service;
            }
        }
    }
}
