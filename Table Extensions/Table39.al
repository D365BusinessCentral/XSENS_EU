tableextension 50014 "Purchase Line" extends "Purchase Line"
{
    fields
    {

        field(50300; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                        NLD = 'Redencode';
            TableRelation = "Reason Code";
        }
        field(50304; "Shipment Date"; Date)
        {
            CaptionML = ENU = 'Shipment Date',
                        NLD = 'Verzenddatum';

            trigger OnValidate();
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(50305; Sorting; Integer)
        {
            CaptionML = ENU = 'Sorting',
                        NLD = 'Sortering';
        }
        field(50450; "FA Class Code"; Code[10])
        {
            CaptionML = ENU = 'FA Class Code',
                        NLD = 'VA-categorie';
            Description = 'No longer used';
            TableRelation = "FA Class";
        }
        field(50451; "FA Subclass Code"; Code[10])
        {
            CaptionML = ENU = 'FA Subclass Code',
                        NLD = 'VA-subcategorie';
            Description = 'No longer used';
            TableRelation = "FA Subclass";
        }
    }
}