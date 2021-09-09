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
            }
        }
        addafter("Line No.")
        {
            field("Sorting No."; Rec."Sorting No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
