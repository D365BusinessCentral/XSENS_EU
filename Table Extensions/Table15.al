tableextension 50004 "G/L Account" extends "G/L Account"
{
    fields
    {
        field(50300; "Shortcut Dimension 3 Filter"; Code[20])
        {
            CaptionML = ENU = 'Shortcut Dimensie 3 filter',
                        NLD = 'Shortcut Dimensie 3 filter';
            Description = 'No longer used';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnLookup();
            var
                lCduDimensionXsensMgt: Codeunit "Dimension Xsens  Mgt";
                lCodDimensie3: Code[20];
            begin
                lCduDimensionXsensMgt.fLookUpDimensionvalues(3, lCodDimensie3);
            end;
        }
    }
}