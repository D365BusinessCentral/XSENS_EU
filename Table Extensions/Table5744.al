tableextension 50047 "Transfer Shipment Header" extends "Transfer Shipment Header"
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
