tableextension 50045 "Bank Account" extends "Bank Account"
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
        field(50000; "Currency Code Buffer"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
}