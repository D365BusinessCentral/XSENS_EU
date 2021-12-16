table 50014 ChargebeeSetupLine
{
    // version XSSCB1.3


    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; Connectie; Code[20])
        {
            Caption = 'Connection';
        }
        field(20; APIKey; Text[100])
        {
            Caption = 'API Key';
        }
        field(30; "Last updated"; Date)
        {
            Caption = 'Last updated';
        }
        field(40; InstantBooking; Boolean)
        {
            Caption = 'Instant booking';
        }
        field(45; "Invoice prefix"; Text[2])
        {

        }
        // field(50; "GL Account"; Code[20])
        // {
        //     CaptionML = NLD = 'Grootboekrekening debiteuren',
        //                 ENG = 'Select GL/Account for Accounts Receivable';
        //     Description = 'Enter the Sales Receivable account';
        //     TableRelation = "G/L Account";
        // }
        field(60; "Base url"; Text[100])
        {
            Description = 'Enter complete url for the Chargebee-connection (incl. /api/v2)';
            InitValue = 'https://xsens-us-test.chargebee.com/api/v2';
        }
        // field(70; "Use Sales Tax"; Boolean)
        // {
        // }
        // field(80; "Sales Tax account"; Code[20])
        // {
        //     Description = 'Enter the G/L account for the Sales Tax (if applicable)';
        //     TableRelation = "G/L Account";
        // }
        // field(90; "Full VAT"; Code[20])
        // {
        //     Description = 'Product Posting Group for Full VAT';
        //     TableRelation = "VAT Product Posting Group";
        // }
        // field(100; "No VAT"; Code[20])
        // {
        //     Description = 'Product Posting Grioup for No VAT';
        //     TableRelation = "VAT Product Posting Group";
        // }
        // field(110; "Segment Code"; Code[20])
        // {
        //     Description = 'Segment Code';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        // }
        // field(111; "Product Lines"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        // }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        EnableTaxAccount: Boolean;
}

