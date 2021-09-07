tableextension 50090 VendorLedgerEntry extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        //Below two field has been added by LT-22JUNE2021
        /*field(50006; "Credit Card Payee No. LT"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Card Payee No.';
            TableRelation = Vendor;
            Editable = false;
        }
        field(50007; "Credit Card Payee Name LT"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Credit Card Payee Name';
            Editable = false;
        }*/
        //- Above two fields added by LT - 22JUNE2021
    }

    var
        myInt: Integer;
}