tableextension 50092 "Posted Bank Rec Line" extends "Posted Payment Recon. Line"
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
