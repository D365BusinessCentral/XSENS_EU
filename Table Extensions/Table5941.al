tableextension 50050 "Service Item Component" extends "Service Item Component"
{
    fields
    {
        field(50000; "Quantity (Base)"; Decimal)
        {
            DecimalPlaces = 0 : 5;
        }
        field(50001; "Scrap %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Scrap %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
        }
        field(50002; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            TableRelation = "Routing Link";
        }
        field(50003; "Quantity Per"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Unit of Measure Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
    }
}
