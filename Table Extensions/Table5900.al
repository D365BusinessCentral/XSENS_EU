tableextension 50049 "Service Header" extends "Service Header"
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
        modify("Bill-to County")
        {
            TableRelation = County.County;
        }
        modify("Ship-to County")
        {
            TableRelation = County.County;
        }
    }
}