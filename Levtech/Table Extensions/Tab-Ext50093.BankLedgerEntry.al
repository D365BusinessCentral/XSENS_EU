tableextension 50093 "Bank Ledger Entry" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50000; "Payment Method Code"; Code[20])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
    }
}
