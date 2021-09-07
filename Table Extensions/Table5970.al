tableextension 50052 "Filed Service Contract Header" extends "Filed Service Contract Header"
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
