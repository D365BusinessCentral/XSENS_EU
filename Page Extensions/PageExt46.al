pageextension 50009 "Sales Order Subform" extends "Sales Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field(COC; Rec.COC)
            {
                ApplicationArea = All;
            }
            field(ExternalID; Rec.ExternalID)
            {
                ApplicationArea = All;
                Editable = true;
                Enabled = true;
            }
        }
        addafter("Line No.")
        {
            field("Sorting No."; Rec."Sorting No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = All;
            }
        }
    }
}
