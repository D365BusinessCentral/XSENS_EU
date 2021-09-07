pageextension 50019 "Sales Quote Archive" extends "Sales Quote Archive"
{
    layout
    {
        addafter("Bill-to Contact")
        {
            field("Bill-to Email"; Rec."Bill-to Email")
            {
                ApplicationArea = All;
            }
        }
    }
}
