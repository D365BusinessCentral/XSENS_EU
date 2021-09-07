report 50020 "Update Spare parts"
{
    // version XSS5.101

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Update Spare parts.rdlc';

    dataset
    {
        dataitem("Service Item"; "Service Item")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord();
            begin
                //IF "Service Item"."No." <> '174321'  THEN EXIT;
                if ("Service Item"."Warranty Starting Date (Parts)" >= 20181118D) and ("Service Item"."Warranty Starting Date (Parts)" < 20190403D)
                  then begin
                    //"Service Item"."Warranty Ending Date (Parts)" := CALCDATE('2Y' ,"Service Item"."Warranty Starting Date (Parts)");
                    //"Service Item"."Warranty Ending Date (Labor)" := CALCDATE('2Y' ,"Service Item"."Warranty Starting Date (Labor)");
                    fFindICCustomer("Service Item");
                    "Service Item".MODIFY;
                end;
            end;

            trigger OnPostDataItem();
            begin
                MESSAGE('%1 Service Item bijgewerkt', gTeller);
            end;

            trigger OnPreDataItem();
            begin
                gTeller := 0;

                "Service Item".SETRANGE("Customer No.", 'C02302');  // Xsens INC
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

    var
        gTeller: Integer;

    local procedure fFindItemLedgerEntry(var pRecServiceItem: Record "Service Item");
    var
        lRecSalesShipmentHeader: Record "Sales Shipment Header";
        lRecSalesShipmentLine: Record "Sales Shipment Line";
        lRecItemLedgerEntry: Record "Item Ledger Entry";
    begin
        /* fFindItemLedgerEntry */

        lRecItemLedgerEntry.RESET;
        lRecItemLedgerEntry.SETCURRENTKEY("Item No.");
        lRecItemLedgerEntry.SETRANGE("Item No.", pRecServiceItem."Item No.");
        lRecItemLedgerEntry.SETRANGE("Entry Type", lRecItemLedgerEntry."Entry Type"::Sale);
        lRecItemLedgerEntry.SETRANGE("Document Type", lRecItemLedgerEntry."Document Type"::"Sales Shipment");
        lRecItemLedgerEntry.SETRANGE("Document No.", pRecServiceItem."Sales/Serv. Shpt. Document No.");
        lRecItemLedgerEntry.SETRANGE("Document Line No.", pRecServiceItem."Sales/Serv. Shpt. Line No.");
        lRecItemLedgerEntry.SETRANGE("Source No.", 'C02302');
        if lRecItemLedgerEntry.FINDFIRST then begin
            if lRecSalesShipmentHeader.GET(lRecItemLedgerEntry."Document No.") then begin
                if pRecServiceItem."Sell-to IC Customer No." = '' then begin
                    pRecServiceItem."Sell-to IC Customer No." := lRecSalesShipmentHeader."Sell-to IC Customer No.";
                    pRecServiceItem."Sell-to IC Name" := lRecSalesShipmentHeader."Sell-to IC Name";
                    gTeller := gTeller + 1;
                end;
            end;
        end;

    end;

    local procedure fFindICCustomer(var pRecServiceItem: Record "Service Item");
    var
        lRecSalesShipmentHeader: Record "Sales Shipment Header";
        lRecSalesShipmentLine: Record "Sales Shipment Line";
        lRecItemLedgerEntry: Record "Item Ledger Entry";
        lRecSalesShipmentHeaderIC: Record "Sales Shipment Header";
        lRecSalesShipmentLineIC: Record "Sales Shipment Line";
    begin
        /* fFindICCustomer */

        if pRecServiceItem."Sell-to IC Customer No." <> '' then exit;
        if pRecServiceItem."Sell-to IC Name" <> '' then exit;
        lRecItemLedgerEntry.RESET;
        lRecItemLedgerEntry.SETCURRENTKEY("Item No.");
        lRecItemLedgerEntry.SETRANGE("Item No.", pRecServiceItem."Item No.");
        lRecItemLedgerEntry.SETRANGE("Entry Type", lRecItemLedgerEntry."Entry Type"::Sale);
        lRecItemLedgerEntry.SETRANGE("Document Type", lRecItemLedgerEntry."Document Type"::"Sales Shipment");
        lRecItemLedgerEntry.SETRANGE("Document No.", pRecServiceItem."Sales/Serv. Shpt. Document No.");
        lRecItemLedgerEntry.SETRANGE("Document Line No.", pRecServiceItem."Sales/Serv. Shpt. Line No.");
        lRecItemLedgerEntry.SETRANGE("Source No.", 'C02302');
        if lRecItemLedgerEntry.FINDFIRST then begin
            if lRecSalesShipmentHeader.GET(lRecItemLedgerEntry."Document No.") then begin
                lRecSalesShipmentHeaderIC.CHANGECOMPANY('Xsens North America Inc.');
                lRecSalesShipmentLineIC.CHANGECOMPANY('Xsens North America Inc.');
                lRecSalesShipmentLineIC.RESET;
                lRecSalesShipmentLineIC.SETCURRENTKEY("Document No.", "Line No.");
                lRecSalesShipmentLineIC.SETRANGE("No.", pRecServiceItem."Item No.");
                lRecSalesShipmentLineIC.SETRANGE("Purchase Order No.", lRecSalesShipmentHeader."External Document No.");
                if lRecSalesShipmentLineIC.FINDFIRST then begin
                    if lRecSalesShipmentHeaderIC.GET(lRecSalesShipmentLineIC."Document No.") then begin
                        pRecServiceItem."Sell-to IC Customer No." := lRecSalesShipmentHeaderIC."Sell-to Customer No.";
                        pRecServiceItem."Sell-to IC Name" := lRecSalesShipmentHeaderIC."Sell-to Customer Name";

                        gTeller := gTeller + 1;
                    end;
                end;
            end;
        end;

    end;
}

