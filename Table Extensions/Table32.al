tableextension 50010 "Item Ledger Entry" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; "On hold"; Boolean)
        {
            CaptionML = ENU = 'On hold',
                        NLD = 'Gereserveerd';
        }
        field(50001; "On hold comment"; Text[50])
        {
            CaptionML = ENU = 'On hold comment',
                        NLD = 'Gereserveerd opmerking';
        }
    }
}