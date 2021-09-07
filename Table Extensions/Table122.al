tableextension 50027 "Purch. Inv. Header" extends "Purch. Inv. Header"
{
    fields
    {
        field(50000; Approved; Boolean)
        {
            CaptionML = ENU = 'Order is approved',
                        NLD = 'Order is goedgekeurd';
            DataClassification = ToBeClassified;
        }
        field(50300; "Shipment date IC order"; Date)
        {
            CaptionML = ENU = 'Shipment date IC order',
                        NLD = 'Verzenddatum IC order';
        }
        field(50301; "Salesperson Code"; Code[10])
        {
            CaptionML = ENU = 'Salesperson Code',
                        NLD = 'Verkoper';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50302; "Sales Your Reference"; Text[30])
        {
            CaptionML = ENU = 'Your Reference',
                        NLD = 'Uw referentie';
            Editable = false;
        }
        field(50303; "Sales Quote No."; Code[20])
        {
            CaptionML = ENU = 'Quote No.',
                        NLD = 'Offertenr.';
            Editable = false;
            //This property is currently not supported
            //TestTableRelation = false;
            //ValidateTableRelation = false;
        }
        field(50304; "Sales Order no."; Code[20])
        {
            CaptionML = ENU = 'Sales Order no.',
                        NLD = 'Verkooporder';
            Editable = false;
        }
        field(50305; "Boekingsdatum akkoord"; Boolean)
        {
            CaptionML = ENU = 'Posting date agreed',
                        NLD = 'Boekingsdatum akkoord';
        }
    }
}
