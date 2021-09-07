tableextension 50032 "Service Item Group" extends "Service Item Group"
{
    fields
    {
        field(50300; "Default Warranty Duration"; DateFormula)
        {
            CaptionML = ENU = 'Default Warranty Duration',
                        NLD = 'Std. garantieperiode';
        }
        field(50301; "Skip on shipment document"; Boolean)
        {
            CaptionML = ENU = 'Skip on shipment document',
                        NLD = 'Niet afdrukken op levering';
            Description = 'No longer used';
        }
    }
}
