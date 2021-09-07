tableextension 50058 "Return Shipment Header" extends "Return Shipment Header"
{
    fields
    {
        field(50000; Approved; Boolean)
        {
            CaptionML = ENU = 'Order is approved',
                        NLD = 'Order is goedgekeurd';
            DataClassification = ToBeClassified;
        }
        modify("Pay-to County")
        {
            TableRelation = County.County;
        }
        modify("Buy-from County")
        {
            TableRelation = County.County;
        }
        modify("Ship-to County")
        {
            TableRelation = County.County;
        }
    }
}
