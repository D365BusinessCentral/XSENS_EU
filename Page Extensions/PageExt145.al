pageextension 50016 "Posted Purchase Receipts" extends "Posted Purchase Receipts"
{
    layout
    {
        addfirst(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = NOT IsOfficeAddin;
            }
        }
    }
    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
    end;

    trigger OnOpenPage();
    var
        OfficeMgt: Codeunit "Office Management";
        HasFilters: Boolean;
    begin
        HasFilters := Rec.GETFILTERS <> '';
        Rec.SetSecurityFilterOnRespCenter;
        if HasFilters then
            if Rec.FINDFIRST then;
        IsOfficeAddin := OfficeMgt.IsAvailable;
    end;

    var
        IsOfficeAddin: Boolean;
}
