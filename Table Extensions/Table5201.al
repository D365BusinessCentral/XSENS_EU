tableextension 50064 "Alternative Address" extends "Alternative Address"
{

    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}
