pageextension 50038 "Bank account Recon" extends "Bank Acc. Reconciliation"
{
    actions
    {
        /*modify(ImportBankStatement)
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
/*pageextension 50039 PaymentRecon extends "Pmt. Reconciliation Journals"
{


    actions
    {
        modify(ImportBankTransactionsToNew)
        {
            Visible = false;
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
        }
    }
}*/
