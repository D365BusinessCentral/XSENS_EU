tableextension 50089 "Handled IC Outbox Sales Header" extends "Handled IC Outbox Sales Header"
{
    fields
    {
        field(50000; "US Payment terms"; Code[10])
        {
            CaptionML = ENU = 'US Payment terms',
                        NLD = 'US Betalingscondities';
            TableRelation = "Payment Terms";
        }
    }
}
