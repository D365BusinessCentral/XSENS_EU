report 50021 UpdateCurrecny
{
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(Currency; Currency)
                    {
                        ApplicationArea = All;
                        TableRelation = Currency;

                    }
                }
            }
        }
    }
    trigger OnPostReport()
    begin
        if Currency = '' then
            if not Confirm('Do you want to update blank currency?', false) then exit;
        RecBankAccount."Currency Code" := Currency;
        RecBankAccount.Modify();
    end;

    procedure SetRecord(AccountNo: code[20])
    begin
        Clear(RecBankAccount);
        RecBankAccount.GET(AccountNo);
    end;

    var
        Currency: Code[10];
        RecBankAccount: Record "Bank Account";
}