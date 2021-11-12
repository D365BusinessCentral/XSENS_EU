table 50013 "Blob Management"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {

        }
        field(2; Blob1; Blob)
        {

        }
        field(3; Blob2; Blob)
        {

        }
        field(4; Blob3; Blob)
        {

        }

    }

    keys
    {
        key("Entry No."; "Entry No.")
        {
            Clustered = true;
        }
    }

    procedure SetBlobValue(value: Text; Field: Integer)
    var
        outStr: OutStream;
    begin
        case Field of
            1:
                Blob1.CreateOutStream(outStr);
            2:
                Blob2.CreateOutStream(outStr);
            3:
                Blob3.CreateOutStream(outStr);
        end;
        outStr.WriteText(value);
    end;

    procedure GetBlobValue(Field: Integer) Result: Text
    var
        InStream: InStream;
    begin
        case Field of
            1:
                begin
                    CalcFields(Blob1);
                    Blob1.CreateInStream(InStream, TEXTENCODING::Windows);
                end;
            2:
                begin
                    CalcFields(Blob2);
                    Blob2.CreateInStream(InStream, TEXTENCODING::Windows);
                end;
            3:
                begin
                    CalcFields(Blob2);
                    Blob3.CreateInStream(InStream, TEXTENCODING::Windows);
                end;
        end;
        InStream.Read(Result);
    end;

    procedure GetEntryNo(): Integer
    begin
        if Rec.FindLast() then
            exit(Rec."Entry No." + 1);
        exit(1);
    end;
}