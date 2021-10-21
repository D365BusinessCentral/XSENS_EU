tableextension 50009 Item extends Item
{
    fields
    {
        field(50100; "Copy Serive Item Components"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50200; "Estimated Sales Price"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Estimated Sales Price',
                        NLD = 'Gewaardeerde Verkoopprijs';
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }
        field(50201; "Revenue Type"; Option)
        {
            CaptionML = ENU = 'Revenue Type',
                        NLD = 'Omzet Type';
            OptionCaptionML = ENU = 'Upon Sales,Straight Line,Upon Rendering',
                              NLD = 'Bij Verkoop,Lineair spreiden,Bij Levering';
            OptionMembers = "Upon Sales","Straight Line","Upon Rendering";
        }
        field(50203; "Default ESP-periods"; Integer)
        {
            CaptionML = ENU = 'Default ESP-periods',
                        NLD = 'Standaard ESP-periodes';
            MaxValue = 120;
            MinValue = 0;
        }
        field(50204; "Recurring Revenue Price"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Recurring Revenue Price',
                        NLD = 'Door te schuiven prijs';
            MinValue = 0;
        }
        field(50300; "Item Code"; Option)
        {
            CaptionML = ENU = 'Item Code',
                        NLD = 'Artikel Code';
            OptionCaptionML = ENU = 'Main,Sub',
                              NLD = 'Hoofd,Sub';
            OptionMembers = Main,Sub;
        }
        field(50301; "Softwarekey mandatory"; Boolean)
        {
            Description = 'No longer used';
        }
        field(50302; "Hardwareversion mandatory"; Boolean)
        {
            Description = 'No longer used';
        }
        field(50303; "Referencekey mandatory"; Boolean)
        {
            Description = 'No longer used';
        }
        /*field(50304; "Purchasing Code"; Code[10])
        {
            CaptionML = ENU = 'Purchasing Code',
                        NLD = 'Inkoopcode';
            TableRelation = Purchasing;
        }*/
        field(50305; "Purchasing Company"; Code[20])
        {
            CaptionML = ENU = 'Vendor No.',
                        NLD = 'Inkoopbedrijf';
            TableRelation = Vendor;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            var
                lRecVendor: Record Vendor;
            begin
                if "Purchasing Company" <> '' then begin
                    if lRecVendor.GET("Purchasing Company") then begin
                        if lRecVendor.Blocked = lRecVendor.Blocked::All then
                            ERROR(Text50300, lRecVendor."No.");
                    end;
                end;
            end;
        }
        field(50306; "Not synchronize to SF"; Boolean)
        {
            CaptionML = ENU = 'Not synchronize to SF',
                        NLD = 'Niet synchroniseren naar SF';
        }
        /*//Remove as per client's & amit's request
        field(50307; "Inverted Unit Price"; Boolean)
        {
            CaptionML = ENU = 'Inverted Unit Price',
                        NLD = 'Omgekeerde Eenheidsprijs';
        }
        field(50308; "On Hold"; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FIELD("Location Filter"),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "On hold" = CONST(true)));
            CaptionML = ENU = 'On Hold',
                        NLD = 'On Hold';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }*/
        field(50309; "Print Item Description 2"; Boolean)
        {
            CaptionML = ENU = 'Print Item Description 2',
                        NLD = 'Artikel omschrijvng 2 afdrukken';
        }

        field(50310; "In Isolation"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = filter('Isolation'),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Unit of Measure Code" = FIELD("Unit of Measure Filter"),
                                                                  "Package No." = FIELD("Package No. Filter")));
            Caption = 'Isolation';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
    }
    var
        Text50300: Label 'De gekozen leverancier %1 is geblokkeerd!';
}