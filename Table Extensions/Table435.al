tableextension 50072 "IC Inbox Sales Line" extends "IC Inbox Sales Line"
{
    fields
    {
        field(50100; "Payment Terms Code (US)"; Code[10])
        {
            CaptionML = ENU = 'Payment Terms Code (US)',
                        NLD = 'Betalingsconditie (VS)';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
        }
        field(50101; "Sales Order No. (US)"; Code[20])
        {
            CaptionML = ENU = 'Sales Order No. (US)',
                        NLD = 'Verkoopordernummer (VS)';
            DataClassification = ToBeClassified;
        }
        field(50102; "SalesForce Comment"; Text[250])
        {
            CaptionML = ENU = 'SalesForce Comment',
                        NLD = 'Opmerking SalesForce';
            DataClassification = ToBeClassified;
        }
        field(50103; "SalesForce Comment 2"; Text[100])
        {
            CaptionML = ENU = 'SalesForce Comment 2',
                        NLD = 'Opmerking 2 SalesForce';
            DataClassification = ToBeClassified;
        }
        field(50104; "Your Reference (US)"; Text[35])
        {
            CaptionML = ENU = 'Your Reference (US)',
                        NLD = 'Uw referentie (VS)';
            DataClassification = ToBeClassified;
        }
        field(50105; "Sales Person Code (US)"; Code[20])
        {
            CaptionML = ENU = 'Sales Person Code (US)',
                        NLD = 'Verkoper (VS)';
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
        }
        field(50106; "Business Unit Code (US)"; Code[20])
        {
            CaptionML = ENU = 'Business Unit Code (US)',
                        NLD = 'Businessunit (VS)';
            DataClassification = ToBeClassified;
        }
        field(50300; "Sales Order No."; Code[20])
        {
            CaptionML = ENU = 'Sales Order No.',
                        NLD = 'Verk.-ordernr.';
            Description = 'No longer used';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(50301; "Sales Order Line No."; Integer)
        {
            CaptionML = ENU = 'Sales Order Line No.',
                        NLD = 'Verk.-orderregelnr.';
            Description = 'No longer used';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                            "Document No." = FIELD("Sales Order No."));
        }
        field(50302; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                        NLD = 'Shortcutdimensie 1';
            Description = 'No longer used';
        }
        field(50303; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                        NLD = 'Shortcutdimensie 2';
            Description = 'No longer used';
        }
        field(50304; "Shipment Date"; Date)
        {
            CaptionML = ENU = 'Shipment Date',
                        NLD = 'Verzenddatum';
            Description = 'No longer used';

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
            Description = 'No longer used';
        }
    }
}
