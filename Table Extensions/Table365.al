tableextension 50083 "Analysis View Entry" extends "Analysis View Entry"
{
    fields
    {
        field(50000; "G/L Dim 1"; Code[20])
        {
            CalcFormula = Lookup("G/L Entry"."Global Dimension 1 Code" WHERE("Entry No." = FIELD("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50001; "G/L Dim 2"; Code[20])
        {
            CalcFormula = Lookup("G/L Entry"."Global Dimension 2 Code" WHERE("Entry No." = FIELD("Entry No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
