pageextension 50036 "Item tracking lines" extends "Item Tracking Lines"
{
    layout
    {
        modify("Lot No.")
        {
            QuickEntry = false;
        }
        modify("Quantity (Base)")
        {
            QuickEntry = false;
        }
        modify("Qty. to Handle (Base)")
        {
            QuickEntry = false;
        }
        modify("Qty. to Invoice (Base)")
        {
            QuickEntry = false;
        }
        modify("Appl.-to Item Entry")
        {
            QuickEntry = false;
        }
        modify("Appl.-from Item Entry")
        {
            QuickEntry = false;
        }
    }
}