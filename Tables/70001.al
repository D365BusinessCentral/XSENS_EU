table 70001 "DatabaseMgt - Filename"
{
    // version XSS5.006


    fields
    {
        field(1; "Type No."; Integer)
        {
        }
        field(2; "Before No. Text"; Code[100])
        {
        }
        field(3; "No."; Integer)
        {
        }
        field(4; Text; Code[100])
        {
        }
    }

    keys
    {
        key(Key1; "Type No.", "Before No. Text", "No.", Text)
        {
        }
    }

    fieldgroups
    {
    }
}

