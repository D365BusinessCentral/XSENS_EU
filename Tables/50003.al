table 50003 "BI Line"
{
    // version XSS5.044

    CaptionML = ENU = 'BI Lines',
                NLD = 'BI-regel';

    fields
    {
        field(1; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        NLD = 'Document Type';
            OptionMembers = "Sales Invoice","Sales Credit","Service Invoice","Service Credit","Purchase Invoice","Purchase Credit";
        }
        field(2; "Sell-to Cust. / Buy From Vend."; Code[20])
        {
            CaptionML = ENU = 'Sell-to Customer No.',
                        NLD = 'Orderklantnr. / Orderlevnr.',
                        ENG = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        NLD = 'Documentnr.',
                        ENG = 'Document No.';
            TableRelation = IF ("Document Type" = CONST("Sales Invoice")) "Sales Invoice Header"
            ELSE
            IF ("Document Type" = CONST("Sales Credit")) "Sales Cr.Memo Header"
            ELSE
            IF ("Document Type" = CONST("Service Invoice")) "Service Invoice Header"
            ELSE
            IF ("Document Type" = CONST("Service Credit")) "Service Cr.Memo Header"
            ELSE
            IF ("Document Type" = CONST("Purchase Invoice")) "Purch. Inv. Header"
            ELSE
            IF ("Document Type" = CONST("Purchase Credit")) "Purch. Cr. Memo Hdr.";
        }
        field(4; "Line No."; Integer)
        {
            CaptionML = ENU = 'Line No.',
                        NLD = 'Regelnr.',
                        ENG = 'Line No.';
        }
        field(5; Type; Option)
        {
            CaptionML = ENU = 'Type',
                        NLD = 'Soort',
                        ENG = 'Type';
            OptionCaptionML = ENU = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item),Service Cost',
                              NLD = ' ,Grootboekrekening,Artikel,Resource,Vast activum,Toeslag (Artikel),Servicekosten';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)","Service Cost";
        }
        field(6; "No."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        NLD = 'Nr.';
            TableRelation = IF (Type = CONST("G/L Account")) "G/L Account"
            ELSE
            IF (Type = CONST(Item)) Item
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST("Service Cost")) "Service Cost";
        }
        field(7; "Location Code"; Code[10])
        {
            CaptionML = ENU = 'Location Code',
                        NLD = 'Vestiging',
                        ENG = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(8; "Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Posting Group',
                        NLD = 'Boekingsgroep',
                        ENG = 'Posting Group';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Shipment Date"; Date)
        {
            CaptionML = ENU = 'Shipment Date',
                        NLD = 'Verzenddatum',
                        ENG = 'Shipment Date';
        }
        field(11; Description; Text[80])
        {
            CaptionML = ENU = 'Description',
                        NLD = 'Omschrijving',
                        ENG = 'Description';
        }
        field(12; "Description 2"; Text[80])
        {
            CaptionML = ENU = 'Description 2',
                        NLD = 'Omschrijving 2',
                        ENG = 'Description 2';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            CaptionML = ENU = 'Unit of Measure',
                        NLD = 'Eenheid',
                        ENG = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity',
                        NLD = 'Aantal',
                        ENG = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price / Direct Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Unit Price',
                        NLD = 'Eenheidsprijs / Directe kostprijs',
                        ENG = 'Unit Price';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Unit Cost (LCY)',
                        NLD = 'Kostprijs (LV)',
                        ENG = 'Unit Cost (LCY)';
        }
        field(25; "VAT %"; Decimal)
        {
            CaptionML = ENU = 'VAT %',
                        NLD = 'Btw %',
                        ENG = 'VAT %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            CaptionML = ENU = 'Line Discount %',
                        NLD = 'Regelkorting %',
                        ENG = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Line Discount Amount',
                        NLD = 'Regelkortingbedrag',
                        ENG = 'Line Discount Amount';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount',
                        NLD = 'Bedrag',
                        ENG = 'Amount';
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount Including VAT',
                        NLD = 'Bedrag incl. btw',
                        ENG = 'Amount Including VAT';
        }
        field(31; "Unit Price (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Unit Price (LCY)',
                        NLD = 'Eenheidsprijs (LV)',
                        ENG = 'Unit Price (LCY)';
        }
        field(34; "Gross Weight"; Decimal)
        {
            CaptionML = ENU = 'Gross Weight',
                        NLD = 'Brutogewicht',
                        ENG = 'Gross Weight';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            CaptionML = ENU = 'Net Weight',
                        NLD = 'Nettogewicht',
                        ENG = 'Net Weight';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            CaptionML = ENU = 'Units per Parcel',
                        NLD = 'Aantal per collo',
                        ENG = 'Units per Parcel';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            CaptionML = ENU = 'Unit Volume',
                        NLD = 'Volume',
                        ENG = 'Unit Volume';
            DecimalPlaces = 0 : 5;
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                        NLD = 'Shortcutdimensie 1',
                        ENG = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                        NLD = 'Shortcutdimensie 2',
                        ENG = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(42; "Customer Price Group"; Code[10])
        {
            CaptionML = ENU = 'Customer Price Group',
                        NLD = 'Klantenprijsgroep',
                        ENG = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(45; "Job No."; Code[20])
        {
            CaptionML = ENU = 'Job No.',
                        NLD = 'Projectnr.',
                        ENG = 'Job No.';
            Enabled = false;
            TableRelation = Job;
        }
        field(52; "Work Type Code"; Code[10])
        {
            CaptionML = ENU = 'Work Type Code',
                        NLD = 'Werksoort',
                        ENG = 'Work Type Code';
            Enabled = false;
            TableRelation = "Work Type";
        }
        field(54; "Indirect Cost %"; Decimal)
        {
            CaptionML = ENU = 'Indirect Cost %',
                        NLD = 'Indirecte kosten %';
            DecimalPlaces = 0 : 5;
            Enabled = false;
            MinValue = 0;
        }
        field(68; "Bill-to Cust. / Pay-to Vend."; Code[20])
        {
            CaptionML = ENU = 'Bill-to Customer No.',
                        NLD = 'Factureren aan / Betalen aan',
                        ENG = 'Bill-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Inv. Discount Amount',
                        NLD = 'Factuurkorting',
                        ENG = 'Inv. Discount Amount';
        }
        field(70; "Vendor Item No."; Text[20])
        {
            CaptionML = ENU = 'Vendor Item No.',
                        NLD = 'Artikelnr. leverancier';
            Enabled = false;
        }
        field(73; "Drop Shipment"; Boolean)
        {
            CaptionML = ENU = 'Drop Shipment',
                        NLD = 'Doorverzending',
                        ENG = 'Drop Shipment';
        }
        field(74; "Gen. Bus. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Bus. Posting Group',
                        NLD = 'Bedrijfsboekingsgroep',
                        ENG = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[10])
        {
            CaptionML = ENU = 'Gen. Prod. Posting Group',
                        NLD = 'Productboekingsgroep',
                        ENG = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";
        }
        field(78; "Transaction Type"; Code[10])
        {
            CaptionML = ENU = 'Transaction Type',
                        NLD = 'Transactiesoort',
                        ENG = 'Transaction Nature Code';
            Enabled = false;
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            CaptionML = ENU = 'Transport Method',
                        NLD = 'Transportmethode',
                        ENG = 'Transport Method';
            Enabled = false;
            TableRelation = "Transport Method";
        }
        field(81; "Exit Point / Entry Point"; Code[10])
        {
            CaptionML = ENU = 'Exit Point',
                        NLD = 'Uitvoerhaven',
                        ENG = 'Exit Point';
            Enabled = false;
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            CaptionML = ENU = 'Area',
                        NLD = 'District',
                        ENG = 'Area';
            Enabled = false;
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            CaptionML = ENU = 'Transaction Specification',
                        NLD = 'Transactieomschrijving',
                        ENG = 'Transaction Specification';
            Enabled = false;
            TableRelation = "Transaction Specification";
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Unit Cost',
                        NLD = 'Kostprijs',
                        ENG = 'Unit Cost';
            Editable = false;
            Enabled = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Line Amount',
                        NLD = 'Regelbedrag',
                        ENG = 'Line Amount';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'VAT Difference',
                        NLD = 'Btw-verschil',
                        ENG = 'VAT Difference';
            Enabled = false;
        }
        field(106; "VAT Identifier"; Code[10])
        {
            CaptionML = ENU = 'VAT Identifier',
                        NLD = 'Btw-identificatie',
                        ENG = 'VAT Identifier';
            Editable = false;
            Enabled = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            CaptionML = ENU = 'IC Partner Ref. Type',
                        NLD = 'IC-partnerreferentiesoort',
                        ENG = 'IC Partner Ref. Type';
            Enabled = false;
            OptionCaptionML = ENU = ' ,G/L Account,Item,,,Charge (Item),Cross reference,Common Item No.',
                              ENG = ' ,G/L Account,Item,,,Charge (Item),Cross reference,Common Item No.';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross reference","Common Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            CaptionML = ENU = 'IC Partner Reference',
                        NLD = 'IC-partnerreferentie',
                        ENG = 'IC Partner Reference';
            Enabled = false;
        }
        field(123; "Prepayment Line"; Boolean)
        {
            CaptionML = ENU = 'Prepayment Line',
                        NLD = 'Vooruitbetalingsregel',
                        ENG = 'Prepayment Line';
            Editable = false;
            Enabled = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            CaptionML = ENU = 'IC Partner Code',
                        NLD = 'IC-partnercode',
                        ENG = 'IC Partner Code';
            Enabled = false;
            TableRelation = "IC Partner";
        }
        field(131; "Posting Date"; Date)
        {
            CaptionML = ENU = 'Posting Date',
                        NLD = 'Boekingsdatum',
                        ENG = 'Posting Date';
        }
        field(1001; "Job Task No."; Code[20])
        {
            CaptionML = ENU = 'Job Task No.',
                        NLD = 'Projecttaaknr.',
                        ENG = 'Job Task No.';
            Editable = false;
            Enabled = false;
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Contract Entry No."; Integer)
        {
            CaptionML = ENU = 'Job Contract Entry No.',
                        NLD = 'Postnr. projectcontract',
                        ENG = 'Job Contract Entry No.';
            Editable = false;
            Enabled = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            CaptionML = ENU = 'Variant Code',
                        NLD = 'Variant',
                        ENG = 'Variant Code';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            CaptionML = ENU = 'Qty. per Unit of Measure',
                        NLD = 'Aantal per eenheid',
                        ENG = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            Enabled = false;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            CaptionML = ENU = 'Unit of Measure Code',
                        NLD = 'Eenheidscode',
                        ENG = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            CaptionML = ENU = 'Quantity (Base)',
                        NLD = 'Aantal (Basis)',
                        ENG = 'Quantity (Base)';
            DecimalPlaces = 0 : 5;
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            CaptionML = ENU = 'Responsibility Center',
                        NLD = 'Divisie',
                        ENG = 'Responsibility Centre';
            Enabled = false;
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            CaptionML = ENU = 'Cross-Reference No.',
                        NLD = 'Kruisverwijzingsnr.',
                        ENG = 'Cross-Reference No.';
            Enabled = false;
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            CaptionML = ENU = 'Unit of Measure (Cross Ref.)',
                        NLD = 'Eenheid (Kruisverwijzing)',
                        ENG = 'Unit of Measure (Cross Ref.)';
            Enabled = false;
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            CaptionML = ENU = 'Cross-Reference Type',
                        NLD = 'Kruisverwijzingssoort',
                        ENG = 'Cross-Reference Type';
            Enabled = false;
            OptionCaptionML = ENU = ' ,Customer,Vendor,Bar Code',
                              ENG = ' ,Customer,Vendor,Bar Code';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            CaptionML = ENU = 'Cross-Reference Type No.',
                        NLD = 'Kruisverwijzingssoortnr.',
                        ENG = 'Cross-Reference Type No.';
            Enabled = false;
        }
        field(5709; "Item Category Code"; Code[20])
        {
            CaptionML = ENU = 'Item Category Code',
                        NLD = 'Artikelcategoriecode',
                        ENG = 'Item Category Code';
            TableRelation = IF (Type = CONST(Item)) "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            CaptionML = ENU = 'Nonstock',
                        NLD = 'Niet-voorraad',
                        ENG = 'Nonstock';
            Enabled = false;
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            CaptionML = ENU = 'Purchasing Code',
                        NLD = 'Inkoopcode',
                        ENG = 'Purchasing Code';
            Enabled = false;
            TableRelation = Purchasing;
        }
        field(5712; "Product Group Code"; Code[10])
        {
            CaptionML = ENU = 'Product Group Code',
                        NLD = 'Productgroepcode',
                        ENG = 'Product Group Code';
            //TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(5902; "Service Item No."; Code[20])
        {
            CaptionML = ENU = 'Service Item No.',
                        NLD = 'Serviceartikelnr.',
                        ENG = 'Service Item No.';
            TableRelation = "Service Item"."No.";
        }
        field(5905; "Service Item Serial No."; Code[20])
        {
            CaptionML = ENU = 'Service Item Serial No.',
                        NLD = 'Serviceartikelserienr.',
                        ENG = 'Service Item Serial No.';
        }
        field(5916; "Ship-to Code"; Code[10])
        {
            CaptionML = ENU = 'Ship-to Code',
                        NLD = 'Verzendcode',
                        ENG = 'Ship-to Code';
            Editable = false;
            TableRelation = "Ship-to Address".Code WHERE("Customer No." = FIELD("Sell-to Cust. / Buy From Vend."));
        }
        field(5929; "Fault Area Code"; Code[10])
        {
            CaptionML = ENU = 'Fault Area Code',
                        NLD = 'Probleemgebiedcode',
                        ENG = 'Fault Area Code';
            TableRelation = "Fault Area";
        }
        field(5930; "Symptom Code"; Code[10])
        {
            CaptionML = ENU = 'Symptom Code',
                        NLD = 'Symptoomcode',
                        ENG = 'Symptom Code';
            //TableRelation = Table 88204;
        }
        field(5931; "Fault Code"; Code[10])
        {
            CaptionML = ENU = 'Fault Code',
                        NLD = 'Probleemcode',
                        ENG = 'Fault Code';
            TableRelation = "Fault Code".Code WHERE("Fault Area Code" = FIELD("Fault Area Code"),
                                                     "Symptom Code" = FIELD("Symptom Code"));
        }
        field(5932; "Resolution Code"; Code[10])
        {
            CaptionML = ENU = 'Resolution Code',
                        NLD = 'Oplossingscode',
                        ENG = 'Resolution Code';
            TableRelation = "Resolution Code";
        }
        field(5933; "Exclude Warranty"; Boolean)
        {
            CaptionML = ENU = 'Exclude Warranty',
                        NLD = 'Exclusief garantie',
                        ENG = 'Exclude Warranty';
            Editable = true;
        }
        field(5934; Warranty; Boolean)
        {
            CaptionML = ENU = 'Warranty',
                        NLD = 'Garantie',
                        ENG = 'Warranty';
            Editable = false;
        }
        field(5936; "Contract No."; Code[20])
        {
            CaptionML = ENU = 'Contract No.',
                        NLD = 'Contractnr.',
                        ENG = 'Contract No.';
            Editable = false;
            TableRelation = "Service Contract Header"."Contract No." WHERE("Contract Type" = CONST(Contract));
        }
        field(5967; "Fault Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Fault Reason Code',
                        NLD = 'Probleemoorzaak',
                        ENG = 'Fault Reason Code';
            TableRelation = "Fault Reason Code";
        }
        field(5968; "Replaced Item No."; Code[20])
        {
            CaptionML = ENU = 'Replaced Item No.',
                        NLD = 'Vervangen artikelnr.',
                        ENG = 'Replaced Item No.';
            Enabled = false;
            TableRelation = IF ("Replaced Item Type" = CONST("Service Item")) "Service Item"
            ELSE
            IF ("Replaced Item Type" = CONST(Item)) Item;
        }
        field(5970; "Replaced Item Type"; Option)
        {
            CaptionML = ENU = 'Replaced Item Type',
                        NLD = 'Vervangen artikeltype',
                        ENG = 'Replaced Item Type';
            Enabled = false;
            OptionCaptionML = ENU = ' ,Service Item,Item',
                              ENG = ' ,Service Item,Item';
            OptionMembers = " ","Service Item",Item;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Return Reason Code',
                        NLD = 'Retourreden',
                        ENG = 'Return Reason Code';
            Enabled = false;
            TableRelation = "Return Reason";
        }
        field(7002; "Customer Disc. Group"; Code[20])
        {
            CaptionML = ENU = 'Customer Disc. Group',
                        NLD = 'Klantenkortingsgroep',
                        ENG = 'Customer Disc. Group';
            TableRelation = "Customer Discount Group";
        }
        field(50000; "Shipment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Shipment Method Code',
                        NLD = 'Verzendwijze',
                        ENG = 'Shipment Method Code';
            TableRelation = "Shipment Method";
        }
        field(50002; "Salesperson / Purchaser Code"; Code[10])
        {
            CaptionML = ENU = 'Salesperson Code',
                        NLD = 'Verkoper / Inkoper',
                        ENG = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50003; "Sell-to/Buy-from Country"; Code[10])
        {
            CaptionML = ENU = 'Sell-to Country/Region Code',
                        NLD = 'Land-/regiocode klant/leverancier',
                        ENG = 'Sell-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50004; "Ship-to Country/Region Code"; Code[10])
        {
            CaptionML = ENU = 'Ship-to Country/Region Code',
                        NLD = 'Land-/regiocode verzending',
                        ENG = 'Ship-to Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50005; "Payment Method Code"; Code[10])
        {
            CaptionML = ENU = 'Payment Method Code',
                        NLD = 'Betalingswijze',
                        ENG = 'Payment Method Code';
            TableRelation = "Payment Method";
        }
        field(50006; "Shipping Agent Code"; Code[10])
        {
            CaptionML = ENU = 'Shipping Agent Code',
                        NLD = 'Expediteur',
                        ENG = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        field(50007; "Service Order Type"; Code[10])
        {
            CaptionML = ENU = 'Service Order Type',
                        NLD = 'Serviceordersoort',
                        ENG = 'Service Order Type';
            TableRelation = "Service Order Type";
        }
        field(50008; "NAV module"; Text[10])
        {
            CaptionML = ENU = 'NAV module',
                        NLD = 'NAV module';
        }
        field(50009; "Service Address"; Code[20])
        {
            CaptionML = ENU = 'Service Address',
                        NLD = 'Service Adres';
            //TableRelation = Table80003.Field5 WHERE (Field1=FIELD("Sell-to Cust. / Buy From Vend."));
        }
        field(50010; "Contact Person"; Code[20])
        {
            CaptionML = ENU = 'Contact Person',
                        NLD = 'Contactpersoon';
            TableRelation = Contact."No." WHERE(Type = CONST(Person));
        }
        field(50011; "Service Contact Person"; Code[20])
        {
            CaptionML = ENU = 'Service Contact Person',
                        NLD = 'Service Contactpersoon';
            TableRelation = Contact."No." WHERE(Type = CONST(Person));
        }
        field(50101; "Total Gross Weight"; Decimal)
        {
            CaptionML = ENU = 'Total Gross Weight',
                        NLD = 'Totaal brutogewicht';
        }
        field(50102; "Total Net Weight"; Decimal)
        {
            CaptionML = ENU = 'Total Net Weight',
                        NLD = 'Totaal nettogewicht';
        }
        field(50103; Segment; Code[20])
        {
            CaptionML = ENU = 'Segment',
                        NLD = 'Segment';
        }
        field(60000; "Currency Code"; Code[10])
        {
            CaptionML = ENU = 'Currency Code',
                        ENG = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(60001; "Currency Factor"; Decimal)
        {
            CaptionML = ENU = 'Currency Factor',
                        ENG = 'Currency Factor';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(60002; "Unit Price / Dir.Unit Cost LCY"; Decimal)
        {
            AutoFormatType = 2;
            CaptionML = ENU = 'Unit Price / Dir.Unit Cost LCY',
                        ENG = 'Unit Price / Dir.Unit Cost LCY';
        }
        field(60003; "Line Discount Amount LCY"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Line Discount Amount LCY',
                        ENG = 'Line Discount Amount LCY';
        }
        field(60004; "Amount LCY"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount LCY',
                        ENG = 'Amount LCY';
        }
        field(60005; "Amount Including VAT LCY"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount Including VAT LCY',
                        ENG = 'Amount Including VAT LCY';
        }
        field(60006; "Inv. Discount Amount LCY"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Inv. Discount Amount LCY',
                        ENG = 'Inv. Discount Amount LCY';
        }
        field(60007; "Line Amount LCY"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Line Amount LCY',
                        ENG = 'Line Amount LCY';
        }
        field(60008; "VAT Difference LCY"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'VAT Difference LCY',
                        ENG = 'VAT Difference LCY';
            Enabled = false;
        }
        field(60009; "Reverse Charge LCY"; Decimal)
        {
            CaptionML = ENU = 'Reverse Charge LCY',
                        ENG = 'Reverse Charge LCY';
            Enabled = false;
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

