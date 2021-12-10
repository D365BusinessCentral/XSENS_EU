tableextension 50081 "Sales Header Archive" extends "Sales Header Archive"
{
    fields
    {
        field(50004; "Application area"; Text[30])
        {
            Editable = false;
        }
        field(50005; Application; Text[30])
        {
            Editable = false;
        }
        field(50010; ExternalID; Text[30])
        {
            Editable = false;
        }
        field(50300; "Sales Date"; Date)
        {
            Editable = false;
        }
        field(50301; "Archive option"; Option)
        {
            Caption = 'Archief optie';
            Editable = false;
            OptionMembers = " ",Deleted,Archived;
        }
        field(50302; "Sell-to Contact E-mail"; Text[80])
        {
            CaptionML = ENU = 'Sell-to Contact',
                        NLD = 'Contact E-mail';
            Editable = false;
        }
        field(50303; "Sell-to Contact Phone"; Text[20])
        {
            CaptionML = ENU = 'Sell-to Contact Phone',
                        NLD = 'Telefoon';
            Editable = false;
        }
        field(50304; "SalesForce Comment"; Text[250])
        {
            Editable = false;
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
        field(50450; "Bill-to Email"; Text[80])
        {
            CaptionML = ENU = 'Bill-to Email',
                        NLD = 'Factuur naar Email';
        }
        field(50500; "IC Purchase order created"; Boolean)
        {
            CaptionML = ENU = 'IC Purchase order created',
                        NLD = 'IC Inkooporder aangemaakt';
            Editable = false;
        }
        field(50501; "IC Purchase order send"; Boolean)
        {
            CaptionML = ENU = 'IC Purchase order send',
                        NLD = 'IC Inkooporder verstuurd';
            Editable = false;
        }
        field(50502; "IC Purchase order"; Code[20])
        {
            Editable = false;
        }
    }
}
