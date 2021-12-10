tableextension 50071 "IC Inbox Sales Header" extends "IC Inbox Sales Header"
{
    fields
    {
        field(50000; "Expected Receipt Date"; Date)
        {
            CaptionML = ENU = 'Expected Receipt Date',
                        NLD = 'Verwachte ontvangstdatum';
            Editable = false;
        }
        field(50001; "Ship-to Post Code_M"; Code[20])
        {
            CaptionML = ENU = 'Sell-to Post Code',
                        NLD = 'Postcode';
            Editable = false;
        }
        field(50002; "Ship-to Address 2_M"; Text[50])
        {
            CaptionML = ENU = 'Ship-to Address 2',
                        NLD = 'Verzendadres 2';
            Editable = false;
        }
        field(50003; "Ship-to Contact"; Text[50])
        {
            CaptionML = ENU = 'Ship-to Contact',
                        NLD = 'Verzendcontact';
            Editable = false;
        }
        field(50004; "Salesperson Code"; Code[10])
        {
            CaptionML = ENU = 'Salesperson Code',
                        NLD = 'Verkoper';
            Editable = false;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50006; "Sales Your Reference"; Text[30])
        {
            CaptionML = ENU = 'Your Reference',
                        NLD = 'Uw referentie';
            Editable = false;
        }
        field(50007; "Sales Quote No."; Code[20])
        {
            CaptionML = ENU = 'Quote No.',
                        NLD = 'Offertenr.';
            Editable = false;
        }
        field(50008; "Ship-to County_M"; Text[30])
        {
            CaptionML = ENU = 'Sell-to County',
                        NLD = 'Provincie';
            TableRelation = County.County;
        }
        field(50009; "Ship-to Country/Region M"; Code[10])
        {
            CaptionML = ENU = 'Sell-to Country/Region Code',
                        NLD = 'Land-/regiocode klant';
            TableRelation = "Country/Region";
        }
        field(50360; "Sell-to IC Customer No."; Code[20])
        {
            CaptionML = ENU = 'Sell-to IC Customer No.',
                        NLD = 'IC Orderklantnr.';
            Editable = false;
            TableRelation = Customer;
        }
        field(50361; "Sell-to IC Name"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Name',
                        NLD = 'IC Ordernaam';
            Editable = false;
        }
        field(50362; "Sell-to IC Name 2"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Name 2',
                        NLD = 'IC Ordernaam 2';
            Editable = false;
        }
        field(50363; "Sell-to IC Address"; Text[100])
        {
            CaptionML = ENU = 'Sell-to IC Address',
                        NLD = 'IC Orderadres';
            Editable = false;

            trigger OnValidate();
            var
                PhoneNo: Text[30];
                FaxNo: Text[30];
            begin
            end;
        }
        field(50364; "Sell-to IC Address 2"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Address 2',
                        NLD = 'IC Orderadres 2';
            Editable = false;
        }
        field(50365; "Sell-to IC City"; Text[30])
        {
            CaptionML = ENU = 'Sell-to IC City',
                        NLD = 'IC Orderplaats';
            Editable = false;
        }
        field(50366; "Sell-to IC Contact"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Contact',
                        NLD = 'IC Ordercontact';
            Editable = false;
        }
        field(50367; "Sell-to IC Post Code"; Code[20])
        {
            CaptionML = ENU = 'Sell-to IC Post Code',
                        NLD = 'IC Postcode';
            Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50368; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                        NLD = 'Shortcutdimensie 1';
        }
        field(50369; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                        NLD = 'Shortcutdimensie 2';
        }
        field(50370; "US Payment terms"; Code[10])
        {
            CaptionML = ENU = 'US Payment terms',
                        NLD = 'US Betalingscondities';
            TableRelation = "Payment Terms";
        }
        field(50371; "US Sales Order number"; Code[20])
        {
            CaptionML = ENU = 'US Sales order number',
                        NLD = 'US Verkoop ordernummer';
        }
        field(50372; "SalesForce Comment"; Text[250])
        {
        }
        field(50373; "Comment 2"; Text[100])
        {
            CaptionML = ENU = 'Comment 2',
                        NLD = 'Opmerking 2';
        }
    }
}
