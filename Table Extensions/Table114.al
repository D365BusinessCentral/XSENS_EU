tableextension 50023 "Sales Cr.Memo Header" extends "Sales Cr.Memo Header"
{
    fields
    {
        field(50004; "Application area"; Text[30])
        {
        }
        field(50005; Application; Text[30])
        {
        }
        field(50010; ExternalID; Text[30])
        {
            Editable = false;
        }
        field(50012; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Blocked" = CONST(false));
        }
        field(50015; "Sell-to Customer Name 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50100; "VAT Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "VAT Address & Telephone"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "VAT Bank Name & Account"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "VAT Invoice Mail Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "VAT Contact Information"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50300; "Sales Date"; Date)
        {
        }
        field(50301; "Archive option"; Option)
        {
            Caption = 'Archief optie';
            Editable = false;
            OptionMembers = " ",Deleted,Archived;
        }
        field(50302; "Sell-to Contact E-mail"; Text[80])
        {
            CaptionML = ENU = 'Sell-to Contact E-mail',
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
        field(50305; "Boekingsdatum akkoord"; Boolean)
        {
            CaptionML = ENU = 'Posting date agreed',
                        NLD = 'Boekingsdatum akkoord';
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
    }
}
