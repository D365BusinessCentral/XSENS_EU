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
            field("Closed by Entry No."; Rec."Closed by Entry No.")
            {
                ApplicationArea = All;
            }
            field("Closed at Date"; Rec."Closed at Date")
            {
                ApplicationArea = All;
            }
            field("Closed by Amount"; Rec."Closed by Amount")
            {
                ApplicationArea = all;
            }
            field("Closed by Amount (LCY)"; Rec."Closed by Amount (LCY)")
            {
                ApplicationArea = All;
            }
            field(Positive; Rec.Positive)
            {
                ApplicationArea = All;
            }
            field("Transaction No."; Rec."Transaction No.")
            {
                ApplicationArea = All;
            }
        }
    }
}