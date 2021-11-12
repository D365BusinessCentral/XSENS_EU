pageextension 60030 "Assembly Order Ext" extends "Assembly Order"
{
    layout
    {
        addafter(Status)
        {
            // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
            // {
            //     ApplicationArea = All;
            // }
            // field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
            // {
            //     ApplicationArea = All;
            // }
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}