tableextension 50045 "Bank Account" extends "Bank Account"
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}