codeunit 50101 "Events"
{
    Permissions = tabledata 50011 = RIMD, tabledata 271 = RIMD;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", 'OnBeforeInitPost', '', false, false)]
    local procedure OnBeforeInitPost(var BankAccReconciliation: Record "Bank Acc. Reconciliation")
    var
        BankStatementL: Record "Bank Statement Report";
        OutStream: OutStream;
        InStream: InStream;
        BankReconStatementReport: Report "Bank Acc. Recon. - Test LT";
        RecBankAccRecon: Record "Bank Acc. Reconciliation";
        DocumentRef: RecordRef;
    begin
        // "Statement Type"::"Payment Application":
        //  "Statement Type"::"Bank Reconciliation":
        Clear(RecBankAccRecon);
        RecBankAccRecon.SetRange("Statement Type", BankAccReconciliation."Statement Type");
        RecBankAccRecon.SetRange("Bank Account No.", BankAccReconciliation."Bank Account No.");
        RecBankAccRecon.SetRange("Statement No.", BankAccReconciliation."Statement No.");
        if RecBankAccRecon.FindFirst() then begin

            BankStatementL.Init();
            BankStatementL."Entry No." := 0;
            BankStatementL.Insert(true);
            BankStatementL."Bank Account No." := BankAccReconciliation."Bank Account No.";
            BankStatementL."Statement No." := BankAccReconciliation."Statement No.";
            BankStatementL."Statement Date" := BankAccReconciliation."Statement Date";

            Clear(OutStream);
            BankStatementL."PDF Report Data".CreateOutStream(OutStream);

            Clear(DocumentRef);
            DocumentRef.GetTable(RecBankAccRecon);

            Clear(BankReconStatementReport);
            BankReconStatementReport.UseRequestPage := false;
            BankReconStatementReport.SetPrintOutstandingTransactions(true);
            BankReconStatementReport.SetTableView(RecBankAccRecon);
            BankReconStatementReport.SaveAs('', ReportFormat::Pdf, OutStream, DocumentRef);

            Clear(OutStream);
            Clear(BankReconStatementReport);
            BankReconStatementReport.UseRequestPage := false;
            BankReconStatementReport.SetPrintOutstandingTransactions(true);
            BankReconStatementReport.SetTableView(RecBankAccRecon);
            BankStatementL."Excel Report Data".CreateOutStream(OutStream);
            BankReconStatementReport.SaveAs('', ReportFormat::Excel, OutStream, DocumentRef);
            BankStatementL.Modify(true);
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line");
    begin
        BankAccountLedgerEntry."Payment Method Code" := GenJournalLine."Payment Method Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Bank Acc. Reconciliation Post", 'OnPostPaymentApplicationsOnAfterInitGenJnlLine', '', false, false)]
    local procedure OnPostPaymentApplicationsOnAfterInitGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line");
    begin
        GenJournalLine."Payment Method Code" := BankAccReconciliationLine."Payment Method Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforePurchOrderLineInsert', '', false, false)]
    local procedure OnBeforePurchOrderLineInsert(var PurchOrderHeader: Record "Purchase Header"; var PurchOrderLine: Record "Purchase Line"; var ReqLine: Record "Requisition Line"; CommitIsSuppressed: Boolean);
    var
        RecVendor: Record Vendor;
        RecSalesLine: Record "Sales Line";
        RecSalesHeader: Record "Sales Header";
        CurrencyFactor, ExchangeRateAmt : Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        if PurchOrderHeader."Buy-from Vendor No." <> '' then begin
            Clear(RecVendor);
            if RecVendor.GET(PurchOrderHeader."Buy-from Vendor No.") then begin
                if RecVendor."Price Basis" = RecVendor."Price Basis"::Absolute then
                    exit
                else begin
                    Clear(RecSalesLine);
                    RecSalesLine.GET(RecSalesLine."Document Type"::Order, ReqLine."Sales Order No.", ReqLine."Sales Order Line No.");
                    Clear(RecSalesHeader);
                    RecSalesHeader.GET(RecSalesHeader."Document Type"::Order, ReqLine."Sales Order No.");
                    if RecSalesHeader."Currency Code" = PurchOrderHeader."Currency Code" then begin
                        PurchOrderLine.Validate("Direct Unit Cost", RecSalesLine."Unit Price" * RecVendor.Percentage / 100);
                    end else begin

                        Clear(CurrencyFactor);
                        if PurchOrderHeader."Currency Factor" <> 0 then
                            CurrencyFactor := PurchOrderHeader."Currency Factor"
                        else
                            CurrencyFactor := 1;

                        Clear(CurrencyExchangeRate);
                        ExchangeRateAmt := CurrencyExchangeRate.GetCurrentCurrencyFactor(RecSalesHeader."Currency Code");
                        PurchOrderLine.Validate("Direct Unit Cost", Round((RecSalesLine."Unit Price" / CurrencyFactor) * ExchangeRateAmt, 0.01, '=') * RecVendor.Percentage / 100);
                    end;
                end;
            end;
        end
    end;

    //Calculate Amount LCY for Queries
    [EventSubscriber(ObjectType::Table, Database::"Sales Invoice Line", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnAfterValidateEventSalesInvLine(var Rec: Record "Sales Invoice Line"; RunTrigger: Boolean);
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
    begin
        if Rec."Document No." = '' then exit;
        Clear(SalesInvoiceHeader);
        if SalesInvoiceHeader.GET(Rec."Document No.") then begin
            if SalesInvoiceHeader."Currency Factor" <> 0 then
                Rec."Amount LCY" := Rec.Amount / SalesInvoiceHeader."Currency Factor"
            else
                Rec."Amount LCY" := Rec.Amount;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Cr.Memo Line", 'OnBeforeInsertEvent', '', false, false)]
    local procedure OnAfterValidateEventSalesCrMemoLine(var Rec: Record "Sales Cr.Memo Line"; RunTrigger: Boolean);
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
    begin
        if Rec."Document No." = '' then exit;
        Clear(SalesCrMemoHeader);
        if SalesCrMemoHeader.GET(Rec."Document No.") then begin
            if SalesCrMemoHeader."Currency Factor" <> 0 then
                Rec."Amount LCY" := Rec.Amount / SalesCrMemoHeader."Currency Factor"
            else
                Rec."Amount LCY" := Rec.Amount;
        end;
    end;

    procedure OpenbankLedgerEntry(var RecBankLedger: Record "Bank Account Ledger Entry")
    begin
        if RecBankLedger.FindSet() then begin
            repeat
                RecBankLedger.Open := true;
                RecBankLedger."Statement Status" := RecBankLedger."Statement Status"::Open;
                RecBankLedger."Remaining Amount" := RecBankLedger.Amount;
                RecBankLedger."Statement No." := '';
                RecBankLedger."Statement Line No." := 0;
                RecBankLedger.Modify();
            until RecBankLedger.Next() = 0;
        end

    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCopySellToCustomerAddressFieldsFromCustomer', '', false, false)]
    local procedure OnAfterCopySellToCustomerAddressFieldsFromCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer; CurrentFieldNo: Integer; var SkipBillToContact: Boolean);
    begin
        //CH-20210507-02 -->
        SalesHeader."VAT Customer Name" := SellToCustomer."VAT Customer Name";
        SalesHeader."VAT Address & Telephone" := SellToCustomer."VAT Address & Telephone";
        SalesHeader."VAT Bank Name & Account" := SellToCustomer."VAT Bank Name & Account";
        SalesHeader."VAT Invoice Mail Address" := SellToCustomer."VAT Invoice Mail Address";
        SalesHeader."VAT Contact Information" := SellToCustomer."VAT Contact Information";
        SalesHeader."Sell-to Customer Name 3" := SellToCustomer."Name 3";
        //CH-20210507-02 <--
        //LT-28JULY2021 -->
        SalesHeader."Application area" := SellToCustomer."Application area";
        //LT-28JULY2021 <--
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnShowDocDimOnBeforeUpdateSalesLines', '', false, false)]
    local procedure OnShowDocDimOnBeforeUpdateSalesLines(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header");
    var
        RecGLSetup: Record "General Ledger Setup";
        RecDimSetEntry: Record "Dimension Set Entry";
    begin
        RecGLSetup.GET;
        CLEAR(RecDimSetEntry);
        IF RecDimSetEntry.GET(SalesHeader."Dimension Set ID", RecGLSetup."Shortcut Dimension 4 Code") THEN
            SalesHeader."Shortcut Dimension 4 Code" := RecDimSetEntry."Dimension Value Code";
    end;


}