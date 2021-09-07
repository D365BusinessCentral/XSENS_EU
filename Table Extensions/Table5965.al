tableextension 50051 "Service Contract Header" extends "Service Contract Header"
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
