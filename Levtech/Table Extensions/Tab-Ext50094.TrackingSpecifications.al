tableextension 50094 "Tracking Specifications" extends "Tracking Specification"
{
    fields
    {
        modify("Serial No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                if "Serial No." <> '' then begin
                    Validate("Quantity (Base)", 1);
                end;
            end;
        }
    }
}
