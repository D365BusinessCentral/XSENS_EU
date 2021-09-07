pageextension 50004 "Item Ledger Entries" extends "Item Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("On hold"; Rec."On hold")
            {
                Editable = IsOpen;
                ApplicationArea = All;
            }
            field("On hold comment"; Rec."On hold comment")
            {
                Editable = IsOpen;
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IsOpen := Rec.Open;
    end;


    var
        IsOpen: Boolean;


}

