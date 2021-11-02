pageextension 60028 "CustLedgerExt" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Customer No.")
        {
            field("Sell-to Customer No."; Rec."Sell-to Customer No.")
            {
                ApplicationArea = All;
            }
        }
    }
}