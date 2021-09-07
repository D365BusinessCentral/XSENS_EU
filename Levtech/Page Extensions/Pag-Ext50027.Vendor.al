pageextension 50035 Vendor extends "Vendor Card"
{
    layout
    {
        addafter(Invoicing)
        {
            group("IC Vendor Price")
            {
                field("Price Basis"; Rec."Price Basis")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                    Editable = Rec."Price Basis" = Rec."Price Basis"::Percentage;
                }
            }
        }
    }
    var

        a: Page "Bank Acc. Reconciliation";
}
