tableextension 50036 "Ship-to Address" extends "Ship-to Address"
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}
