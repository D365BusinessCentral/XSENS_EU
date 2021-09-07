tableextension 50013 "Purchase Header" extends "Purchase Header"
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
        }
        field(50305; "Boekingsdatum akkoord"; Boolean)
        {
            CaptionML = ENU = 'Posting date agreed',
                        NLD = 'Boekingsdatum akkoord';

            trigger OnValidate();
            var
                lRecDummySalesHeader: Record "Sales Header";
            begin
            end;
        }
        field(50306; "Comment 2"; Text[100])
        {
            CaptionML = ENU = 'Comment 2',
                        NLD = 'Opmerking 2';
            Description = 'Used';
        }
        field(50307; "US Payment terms"; Code[10])
        {
            CaptionML = ENU = 'US Payments terms',
                        NLD = 'US Betalingscondities';
            Description = 'Used';
            TableRelation = "Payment Terms";
        }
        field(50308; "SalesForce Comment"; Text[250])
        {
        }
        field(50309; "Quote No. Supplier"; Code[10])
        {
            CaptionML = ENU = 'Quote No. Supplier',
                        NLD = 'Offertenr. leverancier';
            DataClassification = ToBeClassified;
        }
    }
}