pageextension 50034 "Payment Reconciliation journal" extends "Payment Reconciliation Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(Post)
        {
            Visible = false;
        }
        /* modify(ImportBankTransactions)
         {
             trigger OnBeforeAction()
             var
                 EventCodeunit: Codeunit Events;
             begin
                 EventCodeunit.StoreCurrencyFieldInCustomField();
             end;

             trigger OnAfterAction()
             var
                 EventCodeunit: Codeunit Events;
             begin
                 EventCodeunit.StoreCurrencyCustomInStandardField();
             end;
         }*/
    }

}
pageextension 50045 GiroJournalList extends "Bank/Giro Journal List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        /*modify("Import Bank Statement")
        {
            trigger OnBeforeAction()
            var
                EventCodeunit: Codeunit Events;
            begin
                EventCodeunit.StoreCurrencyFieldInCustomField();
            end;

            trigger OnAfterAction()
            var
                EventCodeunit: Codeunit Events;
            begin
                EventCodeunit.StoreCurrencyCustomInStandardField();
            end;
        }*/
    }
}

