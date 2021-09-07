tableextension 50074 "IC Inbox Purchase Line" extends "IC Inbox Purchase Line"
{
    fields
    {
        field(50300; "Sales Order No."; Code[20])
        {
            CaptionML = ENU = 'Sales Order No.',
                        NLD = 'Verk.-ordernr.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(50301; "Sales Order Line No."; Integer)
        {
            CaptionML = ENU = 'Sales Order Line No.',
                        NLD = 'Verk.-orderregelnr.';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Sales Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                            "Document No." = FIELD("Sales Order No."));
        }
        field(50302; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                        NLD = 'Shortcutdimensie 1';
        }
        field(50303; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                        NLD = 'Shortcutdimensie 2';
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
    }
}
