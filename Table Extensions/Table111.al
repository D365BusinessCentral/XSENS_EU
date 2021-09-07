tableextension 50020 "Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(50200; "ESP (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'ESP (LCY)',
                        NLD = 'ESP (EV)';
            DecimalPlaces = 2 : 2;
            Description = 'EV';
            Editable = false;
            Enabled = false;
        }
        field(50201; "ESP Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'ESP Line Amount (LCY)',
                        NLD = 'ESP Regelbedrag (EV)';
            DecimalPlaces = 2 : 2;
            Description = 'EV';
            Editable = false;
            Enabled = false;
        }
        field(50202; "ESP % of Total Amount"; Decimal)
        {
            CaptionML = ENU = 'ESP % of Total Amount',
                        NLD = 'ESP % van totaal bedrag';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
        }
        field(50203; "ESP Disc.Amount"; Decimal)
        {
            CaptionML = ENU = 'ESP % of Total Amount',
                        NLD = 'ESP kortingsbedrag';
            DecimalPlaces = 2 : 2;
            Description = 'VV';
            Editable = false;
            Enabled = false;
        }
        field(50204; "ESP Nett Line Amount"; Decimal)
        {
            CaptionML = ENU = 'ESP Nett Line Amount',
                        NLD = 'ESP Netto Regelbedrag';
            Description = 'VV';
            Editable = false;
            Enabled = false;
        }
        field(50205; "Revenue Type"; Option)
        {
            CaptionML = ENU = 'Revenue Type',
                        NLD = 'Omzet Type';
            Editable = false;
            Enabled = false;
            OptionCaptionML = ENU = 'Upon Sales,Straight Line,Upon Rendering',
                              NLD = 'Bij Verkoop,Lineair spreiden,Bij Levering';
            OptionMembers = "Upon Sales","Straight Line","Upon Rendering";
        }
        field(50208; "ESP Line Amount"; Decimal)
        {
            CaptionML = ENU = 'ESP Line Amount',
                        NLD = 'ESP Regelbedrag';
            Description = 'VV';
            Enabled = false;
        }
        field(50210; "RRP (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'RRP (LCY)',
                        NLD = 'RRP (EV)';
            DecimalPlaces = 2 : 2;
            Description = 'EV';
            Editable = false;
            Enabled = false;
        }
        field(50211; "RRP Line Amount (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'RRP Line Amount (LCY)',
                        NLD = 'RRP Regelbedrag (EV)';
            DecimalPlaces = 2 : 2;
            Description = 'EV';
            Editable = false;
            Enabled = false;
        }
        field(50212; "RRP % of Total Amount"; Decimal)
        {
            CaptionML = ENU = 'RRP % of Total Amount',
                        NLD = 'RRP % van totaal bedrag';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
        }
        field(50213; "RRP Disc.Amount"; Decimal)
        {
            CaptionML = ENU = 'RRP Disc.Amount',
                        NLD = 'RRP kortingsbedrag';
            DecimalPlaces = 2 : 2;
            Description = 'VV';
            Editable = false;
            Enabled = false;
        }
        field(50214; "RRP Nett Line Amount"; Decimal)
        {
            CaptionML = ENU = 'RRP Nett Line Amount',
                        NLD = 'RRP Netto Regelbedrag';
            Description = 'VV';
            Editable = false;
            Enabled = false;
        }
        field(50215; "RRP Line Amount"; Decimal)
        {
            CaptionML = ENU = 'RRP Line Amount',
                        NLD = 'RRP Regelbedrag';
            Description = 'VV';
            Enabled = false;
        }
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
        field(50450; Sorting; Integer)
        {
            CaptionML = ENU = 'Sorting',
                        NLD = 'Sortering';
        }
        field(50451; ExternalID; Text[30])
        {
        }
        field(50452; COC; Boolean)
        {
            CaptionML = ENU = 'COC',
                        NLD = 'COC';
        }
        field(87000; "Starting Date"; Date)
        {
            CaptionML = ENU = 'Starting Date',
                        NLD = 'Start datum';
            Enabled = false;
            TableRelation = "Accounting Period";
        }
        field(87003; "No. of Periods"; Integer)
        {
            CaptionML = ENU = 'No. of Periods',
                        NLD = 'Aantal periodes';
            Enabled = false;
        }
    }
}
