table 50007 County
{
    // version XSS5.006

    // 20101025 GFR 23930: tablerelation voor veld County gemaakt.

    DrillDownPageID = 50006;
    LookupPageID = 50006;

    fields
    {
        field(1; County; Text[30])
        {
        }
        field(2; Omschrijving; Text[50])
        {
        }
        field(3; "Tax Area Code"; Code[20])
        {
            CaptionML = ENU = 'Tax Area Code',
                        NLD = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(4; "Tax Liable"; Boolean)
        {
            CaptionML = ENU = 'Tax Liable',
                        NLD = 'Tax Liable';
        }
    }

    keys
    {
        key(Key1; County)
        {
        }
    }

    fieldgroups
    {
    }
}

