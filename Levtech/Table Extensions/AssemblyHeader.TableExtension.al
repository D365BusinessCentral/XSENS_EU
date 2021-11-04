tableextension 50097 AssemblyHeaderExt extends "Assembly Header"
{
    fields
    {
        field(50000; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Blocked" = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
    }
}