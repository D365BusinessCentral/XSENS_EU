tableextension 50082 "Analysis View" extends "Analysis View"
{
    fields
    {
        field(50000; "Business Unit Code"; Code[10])
        {
            CaptionML = ENU = 'Business Unit Code',
                        NLD = 'Bedrijfsunit';
            TableRelation = "Business Unit";
        }
        field(50001; "Bijwerken Cost Centre"; Boolean)
        {
        }
    }
}
