table 50004 "Chargebee Transactions"
{
    // version XSSCB1.3


    fields
    {
        field(5; Connectie; Code[20])
        {
            Caption = 'Connection';
        }
        field(10; Type; Option)
        {
            OptionMembers = Invoice,Payment,Error;
        }
        field(20; ID; Code[20])
        {
        }
        field(30; Description; Text[100])
        {
        }
        field(40; "InvoiceNr."; Code[20])
        {
        }
        field(50; Customer; Code[20])
        {
        }
        field(60; Amount; Decimal)
        {
        }
        field(70; Succeeded; Boolean)
        {
        }
        field(80; "Log Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; Type, ID)
        {
        }
    }

    fieldgroups
    {
    }
}

