tableextension 50042 "Tax Jurisdiction" extends "Tax Jurisdiction"
{
    fields
    {
        field(50000; Country; Option)
        {
            CaptionML = ENU = 'Country',
                        ESM = 'País',
                        FRC = 'Pays',
                        ENC = 'Country';
            OptionCaptionML = ENU = 'US,CA',
                              ESM = 'EE.UU.,CA',
                              FRC = 'ÉU,CA',
                              ENC = 'US,CA';
            OptionMembers = US,CA;
        }
    }
}
