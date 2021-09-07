tableextension 50054 "Service Invoice Header" extends "Service Invoice Header"
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
