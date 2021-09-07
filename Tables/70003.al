table 70003 "DatabaseMgt - Search Text Line"
{
    // version XSS5.006


    fields
    {
        field(1; "File No."; Integer)
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; Text; Text[219])
        {
        }
        field(4; Obsolete; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "File No.", Text, "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

