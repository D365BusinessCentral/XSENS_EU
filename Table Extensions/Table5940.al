tableextension 50033 "Service Item" extends "Service Item"
{
    fields
    {
        field(50300; "Int Ship-to Name"; Text[50])
        {
            CaptionML = ENU = 'Int Ship-to Name',
                        NLD = 'Int Verzendnaam';
            Editable = false;
        }
        field(50301; "Int Ship-to Address"; Text[50])
        {
            CaptionML = ENU = 'Int Ship-to Address',
                        NLD = 'Int Verzendadres';
            Editable = false;
        }
        field(50302; "Int Ship-to Address 2"; Text[50])
        {
            CaptionML = ENU = 'Int Ship-to Address 2',
                        NLD = 'Int Verzendadres 2';
            Editable = false;
        }
        field(50303; "Int Ship-to Post Code"; Code[20])
        {
            CaptionML = ENU = 'Int Ship-to Post Code',
                        NLD = 'Int Verzendpostcode';
            Editable = false;
        }
        field(50304; "Int Ship-to City"; Text[30])
        {
            CaptionML = ENU = 'Int Ship-to City',
                        NLD = 'Int Verzendplaats';
            Editable = false;
        }
        field(50305; "Int Ship-to Contact"; Text[50])
        {
            CaptionML = ENU = 'Int Ship-to Contact',
                        NLD = 'Int Verzendcontact';
            Editable = false;
        }
        field(50306; "Int Ship-to Phone No."; Text[30])
        {
            CaptionML = ENU = 'Int Ship-to Phone No.',
                        NLD = 'Int Telefoonnr.';
            Editable = false;
            ExtendedDatatype = PhoneNo;
        }
        field(50360; "Sell-to IC Customer No."; Code[20])
        {
            CaptionML = ENU = 'Sell-to IC Customer No.',
                        NLD = 'IC Orderklantnr.';
            Editable = true;
        }
        field(50361; "Sell-to IC Name"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Name',
                        NLD = 'IC Ordernaam';
            Editable = true;
        }
    }
    procedure fGetSerialInfoSoftwareversie(pRecServiceItem: Record "Service Item"): Text[30];
    var
        lRecSerialNoInformation: Record "Serial No. Information";
        lRecServiceItem: Record "Service Item";
    begin
        /* fGetSerialInfoSoftwareversie */

        if pRecServiceItem."Serial No." = '' then exit('');

        if lRecSerialNoInformation.GET(pRecServiceItem."Item No.",
                                       pRecServiceItem."Variant Code",
                                       pRecServiceItem."Serial No.") then
            exit(lRecSerialNoInformation.Softwarekey);

        exit('');

    end;

    procedure fGetSerialInfoReferencekey(pRecServiceItem: Record "Service Item"): Text[30];
    var
        lRecSerialNoInformation: Record "Serial No. Information";
        lRecServiceItem: Record "Service Item";
    begin
        /* fGetSerialInfoReferencekey */

        if pRecServiceItem."Serial No." = '' then exit('');

        if lRecSerialNoInformation.GET(pRecServiceItem."Item No.",
                                       pRecServiceItem."Variant Code",
                                       pRecServiceItem."Serial No.") then
            exit(lRecSerialNoInformation.Referencekey);

        exit('');

    end;
}
