tableextension 50048 "Transfer Receipt Header" extends "Transfer Receipt Header"
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