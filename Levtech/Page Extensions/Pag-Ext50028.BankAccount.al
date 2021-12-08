pageextension 50047 "Bank Account" extends "Bank Account Card"
{

    actions
    {
        addfirst(processing)
        {
            action("Update Currency")
            {
                ApplicationArea = All;
                Image = Currency;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    ReportUpdateCUrrency: Report UpdateCurrecny;
                begin
                    Clear(ReportUpdateCUrrency);
                    ReportUpdateCUrrency.SetRecord(Rec."No.");
                    ReportUpdateCUrrency.RunModal();
                end;
            }
        }
    }
    /*trigger OnOpenPage()
    var
        COEvent: Codeunit Events;
    begin
        COEvent.CheckAndUpdateCurrency();
    end;*/


}
pageextension 50046 PaymentHistoryList extends "Payment History List"
{


    actions
    {
        // Add changes to page actions here
        /*modify(Export)
        {
            trigger OnBeforeAction()
            var
                COEvent: Codeunit Events;
            begin
                COEvent.CheckAndUpdateCurrency();
            end;
        }*/
    }

    var
        myInt: Integer;
}