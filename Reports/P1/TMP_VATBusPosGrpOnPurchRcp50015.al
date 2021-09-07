report 50015 "TMP: VATBusPostGrp on PurchRcp"
{
    // version XSS5.068

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P1\TMP VATBusPostGrp on PurchRcp.rdlc';
    Permissions = TableData 120 = rimd,
                  TableData 121 = rimd;

    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {

            trigger OnAfterGetRecord();
            var
                lRecVendor: Record Vendor;
                lRecPurchRcptLine: Record "Purch. Rcpt. Line";
            begin
                IF "Purch. Rcpt. Header"."VAT Bus. Posting Group" = '' THEN BEGIN
                    IF NOT lRecVendor.GET("Purch. Rcpt. Header"."Buy-from Vendor No.") THEN
                        lRecVendor.INIT;
                    IF lRecVendor."VAT Bus. Posting Group" <> '' THEN BEGIN
                        "Purch. Rcpt. Header"."VAT Bus. Posting Group" := lRecVendor."VAT Bus. Posting Group";

                        lRecPurchRcptLine.RESET;
                        lRecPurchRcptLine.SETRANGE(lRecPurchRcptLine."Document No.", "Purch. Rcpt. Header"."No.");
                        IF lRecPurchRcptLine.FINDFIRST THEN BEGIN
                            REPEAT
                                IF lRecPurchRcptLine."VAT Bus. Posting Group" = '' THEN
                                    lRecPurchRcptLine."VAT Bus. Posting Group" := "Purch. Rcpt. Header"."VAT Bus. Posting Group";
                                lRecPurchRcptLine.MODIFY;
                            UNTIL lRecPurchRcptLine.NEXT = 0;
                        END;
                        "Purch. Rcpt. Header".MODIFY;
                    END;
                END;
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

