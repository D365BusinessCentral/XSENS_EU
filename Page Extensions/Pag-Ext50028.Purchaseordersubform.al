pageextension 50028 "Purchase order subform" extends "Purchase Order Subform"
{
    layout
    {
        modify("Line Discount %")
        {
            Visible = true;
        }
        modify("Line Discount Amount")
        {
            Visible = true;
        }
    }
}
