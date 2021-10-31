pageextension 50025 "Sales Order List" extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("US Sales Order No."; Rec."US Sales Order No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field(Comment; Rec.Comment)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            field(fReturnComment; fReturnComment)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Comment',
                                NLD = 'Opmerking';
            }
            field("Comment 2"; Rec."Comment 2")
            {
                ApplicationArea = All;
            }
            field("SalesForce Comment"; Rec."SalesForce Comment")
            {
                ApplicationArea = All;
            }
            field("Document Type"; Rec."Document Type")
            {
                ApplicationArea = All;
            }
            field("US Payment Terms"; Rec."US Payment Terms")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Declaration Statement"; Rec."Declaration Statement")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Order Date"; Rec."Order Date")
            {
                ApplicationArea = All;
            }
            field("Payment Method Code"; Rec."Payment Method Code")
            {
                ApplicationArea = All;
            }
            field("Date Order confimation"; Rec."Date Order confimation")
            {
                ApplicationArea = All;
            }
            field("Ready to Ship"; Rec."Ready to Ship")
            {
                ApplicationArea = All;
            }
        }
    }
    local procedure fReturnComment(): Text[80];
    var
        lRecSalesCommentLine: Record "Sales Comment Line";
    begin
        lRecSalesCommentLine.RESET;
        lRecSalesCommentLine.SETRANGE("Document Type", lRecSalesCommentLine."Document Type"::Order);
        lRecSalesCommentLine.SETRANGE(lRecSalesCommentLine."No.", Rec."No.");
        if lRecSalesCommentLine.FINDLAST then
            exit(lRecSalesCommentLine.Comment);
    end;
}
