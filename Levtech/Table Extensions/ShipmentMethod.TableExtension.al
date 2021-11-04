tableextension 50095 "Shipment Method Ext" extends "Shipment Method"
{
    fields
    {
        field(50000; "Description 2"; Text[100])
        {
            Caption = 'Description 2';
        }
    }

    var
        myInt: Integer;
}