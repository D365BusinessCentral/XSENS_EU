table 70000 "DatabaseMgt - Setup"
{
    // version XSS5.006

    // LVL_BEGIN
    // 20031028 FVE  Veld User ID vergroot van 10 naar 80 posities.
    // LVL_END

    //DrillDownPageID = 99022;//Krishna
    //LookupPageID = 99022;//Krishna

    fields
    {
        field(1; "User ID"; Code[80])
        {
            CaptionML = ENU = 'User ID',
                        NLD = 'Gebruikers-id';
            TableRelation = User;
        }
        field(2; "Open File Command"; Text[50])
        {
        }
        field(3; "OS Command"; Text[50])
        {
        }
        field(4; "Combined File Name"; Text[50])
        {
            InitValue = '%1\1.TXT';
        }
        field(5; "List File Name"; Text[50])
        {
            InitValue = '%1\2.TXT';
        }
        field(6; "Log File Name"; Text[50])
        {
            InitValue = 'LOG.TXT';
        }
        field(7; "Source Folder"; Text[50])
        {
            InitValue = '%1\SOURCE';
        }
        field(8; "Target Folder"; Text[50])
        {
            InitValue = '%1\TARGET';
        }
        field(10; "Show Only Differences"; Boolean)
        {
        }
        field(11; "Delete Unmodified Files"; Boolean)
        {
        }
        field(12; "Reversed Compare"; Boolean)
        {
        }
        field(13; "No. of Matching Lines"; Integer)
        {
            InitValue = 2;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        IF "User ID" <> '' THEN
            IF FileSetup.GET THEN BEGIN
                FileSetup."User ID" := "User ID";
                Rec := FileSetup;
            END;
    end;

    var
        FileSetup: Record "DatabaseMgt - Setup";

    procedure MakeRecord();
    begin
        IF NOT GET(USERID) THEN
            IF NOT GET THEN BEGIN
                INIT;
                INSERT;
                COMMIT;
            END;
    end;
}

