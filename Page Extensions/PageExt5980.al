pageextension 50021 "Service Item Card" extends "Service Item Card"
{
    layout
    {
        addlast(Shipping)
        {
            field("Sell-to IC Customer No."; Rec."Sell-to IC Customer No.")
            {
                ApplicationArea = All;
            }
            field("Sell-to IC Name"; Rec."Sell-to IC Name")
            {
                ApplicationArea = All;
            }
        }
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        modify("Service Item Group Code")
        {
            ApplicationArea = All;
        }
    }
}
