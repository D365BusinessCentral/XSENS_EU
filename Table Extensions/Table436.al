tableextension 50073 "IC Inbox Purchase Header" extends "IC Inbox Purchase Header"
{
    fields
    {
        field(50003; "US Payment terms"; Code[10])
        {
            CaptionML = ENU = 'US Payment terms',
                        NLD = 'US Betalingscondities';
            TableRelation = "Payment Terms";
        }
    }
}
