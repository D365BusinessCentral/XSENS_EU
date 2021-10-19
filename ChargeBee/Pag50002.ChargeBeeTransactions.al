page 50002 "ChargeBee Transactions"
{

    ApplicationArea = All;
    Caption = 'ChargeBee Transactions';
    PageType = List;
    SourceTable = "Chargebee Transactions";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    ToolTip = 'Specifies the value of the ID field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field("InvoiceNr."; Rec."InvoiceNr.")
                {
                    ToolTip = 'Specifies the value of the InvoiceNr. field.';
                    ApplicationArea = All;
                }
                field(Customer; Rec.Customer)
                {
                    ToolTip = 'Specifies the value of the Customer field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
                field(Succeeded; Rec.Succeeded)
                {
                    ToolTip = 'Specifies the value of the Succeeded field.';
                    ApplicationArea = All;
                }
                field("Log Date"; Rec."Log Date")
                {
                    ToolTip = 'Specifies the value of the Log Date field.';
                    ApplicationArea = All;
                }
            }
        }
    }

}
