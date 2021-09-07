pageextension 50032 "Bank ledger Entry" extends "Bank Account Ledger Entries"
{

    layout
    {
        addlast(Control1)
        {
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(navigation)
        {
            action("Open")
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    RecbankLeg: Record "Bank Account Ledger Entry";
                    CodeunitEvent: Codeunit Events;
                begin
                    Clear(RecbankLeg);
                    CurrPage.SetSelectionFilter(RecbankLeg);
                    if RecbankLeg.FindSet() then
                        CodeunitEvent.OpenbankLedgerEntry(RecbankLeg);
                end;
            }
        }
    }
    var
        cod: Codeunit 45;
}
