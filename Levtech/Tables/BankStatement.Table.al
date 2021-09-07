table 50010 "Bank Statement Reports"
{
    DataClassification = ToBeClassified;
    ObsoleteState = Removed;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account No.';
        }
        field(3; "Statement No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Statement No.';
        }
        field(4; "Statement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statement Date';
        }
        field(5; "PDF Report Data"; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDF Report Data';
        }
        field(6; "Excel Report Data"; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(key1; "Bank Account No.", "Statement No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}

table 50011 "Bank Statement Report"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Bank Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bank Account No.';
        }
        field(3; "Statement No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Statement No.';
        }
        field(4; "Statement Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Statement Date';
        }
        field(5; "PDF Report Data"; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'PDF Report Data';
        }
        field(6; "Excel Report Data"; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(key1; "Entry No.")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}