tableextension 50043 "Reservation Entry" extends "Reservation Entry"
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
        field(50300; Softwarekey; Text[30])
        {
        }
        field(50301; Hardwarekey; Text[30])
        {
        }
        field(50302; Referencekey; Text[30])
        {
        }
    }
}
