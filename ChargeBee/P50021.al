page 50021 "Chargebee Transaction Logging"
{

    ApplicationArea = All;
    Caption = 'Transaction Logging';
    PageType = List;
    SourceTable = "Chargebee Transactions";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = true;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Connectie; Rec.Connectie)
                {
                    ApplicationArea = All;
                    Caption = 'Connection';
                }
                field("Log Date"; Rec."Log Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("InvoiceNr."; Rec."InvoiceNr.")
                {
                    ApplicationArea = All;
                }
                field(Customer; Rec.Customer)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Succeeded; Rec.Succeeded)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
