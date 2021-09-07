tableextension 50026 "Purch. Rcpt. Line" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50300; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                        NLD = 'Redencode';
            TableRelation = "Reason Code";
        }
        field(50450; "FA Class Code"; Code[10])
        {
            CaptionML = ENU = 'FA Class Code',
                        NLD = 'VA-categorie';
            TableRelation = "FA Class";
        }
        field(50451; "FA Subclass Code"; Code[10])
        {
            CaptionML = ENU = 'FA Subclass Code',
                        NLD = 'VA-subcategorie';
            TableRelation = "FA Subclass";
        }
    }
}
