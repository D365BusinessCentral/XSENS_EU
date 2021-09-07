report 50099 "TMP: Currency Sales Order"
{
    // version XSS5.080

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\TMP Currency Sales Order.rdlc';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.", "Sell-to Customer No.";

            trigger OnAfterGetRecord();
            var
                lRecSalesLine: Record "Sales Line";
            begin
                if "Sales Header"."Currency Code" = '' then begin
                    "Sales Header"."Currency Code" := 'USD';
                    "Sales Header"."Currency Factor" := 1.1442;
                    "Sales Header".MODIFY(false);

                    lRecSalesLine.RESET;
                    lRecSalesLine.SETRANGE("Document Type", "Sales Header"."Document Type");
                    lRecSalesLine.SETRANGE("Document No.", "Sales Header"."No.");
                    lRecSalesLine.SETRANGE(Type, lRecSalesLine.Type::Item);
                    if lRecSalesLine.FINDFIRST then begin
                        repeat
                            if lRecSalesLine."Currency Code" = '' then begin
                                lRecSalesLine."Currency Code" := 'USD';
                                lRecSalesLine.MODIFY(false);
                            end;
                        until lRecSalesLine.NEXT = 0;
                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

