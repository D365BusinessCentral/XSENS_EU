tableextension 50077 "Handled IC Inbox Purch. Header" extends "Handled IC Inbox Purch. Header"
{
    fields
    {
        field(50000; "Ontvangst geboekt via IC-doc"; Boolean)
        {
            CaptionML = ENU = 'Receipt posted by IC-doc',
                        NLD = 'Ontvangst geboekt via IC-doc';
        }
        field(50001; "Verkoopfact geboekt via IC-doc"; Boolean)
        {
            CaptionML = ENU = 'Salesinvoice posted by IC-doc',
                        NLD = 'Verkoopfact geboekt via IC-doc';
        }
        field(50002; "Inkoopfact geboekt via IC-doc"; Boolean)
        {
            CaptionML = ENU = 'Purch.invoice posted by IC-doc',
                        NLD = 'Inkoopfact geboekt via IC-doc';
        }
        field(50003; "US Payment terms"; Code[10])
        {
            CaptionML = ENU = 'US Payment terms',
                        NLD = 'US Betalingscondities';
            TableRelation = "Payment Terms";
        }
    }
}
