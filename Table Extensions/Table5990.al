tableextension 50053 "Service Shipment Header" extends "Service Shipment Header"
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
