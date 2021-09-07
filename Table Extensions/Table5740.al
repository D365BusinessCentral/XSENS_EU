tableextension 50067 "Transfer Header" extends "Transfer Header"
{

    fields
    {
        modify("Transfer-to County")
        {
            TableRelation = County.County;
        }
        modify("Transfer-from County")
        {
            TableRelation = County.County;
        }
    }
}
