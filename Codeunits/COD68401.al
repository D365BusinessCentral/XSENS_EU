codeunit 68401 "XSS Complaint Events"
{
    // version KLA1.00,XSS5.020


    trigger OnRun();
    begin
    end;

    var
        Text901800: TextConst ENU = 'Action aborted by user.', NLD = 'Actie afgebroken door gebruiker.';
        Text901801: Label '"Deze actie is niet toegestaan. "';
        Text901802: Label 'Klacht %1 is gekoppeld aan één of meer documenten en kan niet verwijderd worden.\Verwijder de koppelingen en probeer het opnieuw.';
        Text901803: Label 'U bent verplicht een document in te vullen!';
        Text901804: Label 'Serviceartikel %1 behoort tot leverancier %2. Het serviceartikel zal worden leeggemaakt. Wilt u doorgaan?';
        Text901805: Label 'Serviceartikel %1 behoort tot klant %2. Het serviceartikel zal worden leeggemaakt. Wilt u doorgaan?';
        Text901806: Label 'U kunt de klachtstatus niet leegmaken. Selecteert u de juiste status van de klacht.';
        Text50000: TextConst ENU = 'No interactions found.', NLD = 'Geen interacties gevonden.';
        Text50001: TextConst ENU = 'Sales Order cannot be created. Customer cannot be found. Contact is linked to a vendor.', NLD = 'Er kan geen verkooporder van deze klacht worden gemaakt om de contact niet gekoppeld is aan een klant maar aan een leverancier';
        Text50002: TextConst ENU = 'Customer cannot be found.', NLD = 'Er is geen gekoppelde klant gevonden';

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    procedure BeforeSalesShptHeaderInsert(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header");
    begin
        CopyLinks('VERKOOPORDER', SalesHeader."No.", 0, 'VERKOOPLEVERING', SalesShptHeader."No.", 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvHeaderInsert', '', false, false)]
    procedure AfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header");
    begin
        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::Order:
                CopyLinks('VERKOOPORDER', SalesHeader."No.", 0, 'VERKOOPFACTUURGB', SalesInvHeader."No.", 0);
            SalesHeader."Document Type"::Invoice:
                CopyLinks('VERKOOPFACTUUR', SalesHeader."No.", 0, 'VERKOOPFACTUURGB', SalesInvHeader."No.", 0);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesCrMemoHeaderInsert', '', false, false)]
    procedure AfterSalesCrMemoHeaderInsert(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header");
    begin
        CopyLinks('VERKOOPCREDITNOTA', SalesHeader."No.", 0, 'VERKOOPCREDITNOTAGB', SalesCrMemoHeader."No.", 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesShptLineInsert', '', false, false)]
    procedure AfterSalesShptLineInsert(var SalesShipmentLine: Record "Sales Shipment Line"; SalesLine: Record "Sales Line");
    begin
        CopyLinks('VERKOOPORDER', SalesLine."Document No.", SalesLine."Line No.", 'VERKOOPLEVERING', SalesShipmentLine."Document No.", SalesShipmentLine."Line No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvLineInsert', '', false, false)]
    procedure AfterSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean);
    begin
        CopyLinks('VERKOOPORDER', SalesLine."Document No.", SalesLine."Line No.", 'VERKOOPFACTUURGB', SalesInvLine."Document No.", SalesInvLine."Line No.");
        CopyLinks('VERKOOPFACTUUR', SalesLine."Document No.", SalesLine."Line No.", 'VERKOOPFACTUURGB', SalesInvLine."Document No.", SalesInvLine."Line No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesCrMemoLineInsert', '', false, false)]
    procedure AfterSalesCrMemoLineInsert(var SalesCrMemoLine: Record "Sales Cr.Memo Line"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line");
    begin
        CopyLinks('VERKOOPCREDITNOTA', SalesLine."Document No.", SalesLine."Line No.", 'VERKOOPCREDITNOTAGB', SalesCrMemoLine."Document No.", SalesCrMemoLine."Line No.");
    end;

    local procedure CopyLinks(pCodeFromDocumentsoort: Code[20]; pCodeFfromDocumentNo: Code[20]; pCodeFromLineNo: Integer; pCodeToDocumentsoort: Code[20]; pCodeToDocumentNo: Code[20]; pCodeToLineNo: Integer);
    var
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
        lTmpRecKlachtkoppelingen: Record "Klacht koppelingen" temporary;
    begin
        FillTempTable(lTmpRecKlachtkoppelingen, pCodeFromDocumentsoort, pCodeFfromDocumentNo, pCodeFromLineNo);

        lTmpRecKlachtkoppelingen.RESET;
        if lTmpRecKlachtkoppelingen.FINDFIRST then begin
            repeat
                if not lRecKlachtkoppelingen.GET(lTmpRecKlachtkoppelingen.Stuknummer, pCodeToDocumentsoort, pCodeToDocumentNo,
                                                 pCodeToLineNo) then begin
                    lRecKlachtkoppelingen.INIT;
                    lRecKlachtkoppelingen.TRANSFERFIELDS(lTmpRecKlachtkoppelingen);
                    lRecKlachtkoppelingen.Documentsoort := pCodeToDocumentsoort;
                    lRecKlachtkoppelingen."Documentnr." := pCodeToDocumentNo;
                    lRecKlachtkoppelingen."Documentregelnr." := pCodeToLineNo;
                    lRecKlachtkoppelingen.INSERT;
                end;
            until lTmpRecKlachtkoppelingen.NEXT = 0;
        end;
    end;

    local procedure FillTempTable(var pvTmpRecKlachtkoppelingen: Record "Klacht koppelingen" temporary; pCodeDocumentsoort: Code[20]; pCodeDocumentNo: Code[20]; pIntLineNo: Integer);
    var
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
    begin
        pvTmpRecKlachtkoppelingen.RESET;
        pvTmpRecKlachtkoppelingen.DELETEALL;

        lRecKlachtkoppelingen.RESET;
        lRecKlachtkoppelingen.SETRANGE(Documentsoort, pCodeDocumentsoort);
        lRecKlachtkoppelingen.SETRANGE("Documentnr.", pCodeDocumentNo);
        lRecKlachtkoppelingen.SETFILTER("Documentregelnr.", '%1', pIntLineNo);
        if lRecKlachtkoppelingen.FINDFIRST then begin
            repeat
                pvTmpRecKlachtkoppelingen.INIT;
                pvTmpRecKlachtkoppelingen.TRANSFERFIELDS(lRecKlachtkoppelingen);
                pvTmpRecKlachtkoppelingen.INSERT;
            until lRecKlachtkoppelingen.NEXT = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPurchRcptHeaderInsert', '', false, false)]
    procedure AfterPurchRcpttHeaderInsert(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header");
    begin
        CopyLinks('INKOOPORDER', PurchaseHeader."No.", 0, 'INKOOPONTVANGST', PurchRcptHeader."No.", 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPurchInvHeaderInsert', '', false, false)]
    procedure AfterPurchInvHeaderInsert(var PurchInvHeader: Record "Purch. Inv. Header"; var PurchHeader: Record "Purchase Header");
    begin
        case PurchHeader."Document Type" of
            PurchHeader."Document Type"::Order:
                CopyLinks('INKOOPORDER', PurchHeader."No.", 0, 'INKOOPFACTUURGB', PurchInvHeader."No.", 0);
            PurchHeader."Document Type"::Invoice:
                CopyLinks('INKOOPFACTUUR', PurchHeader."No.", 0, 'INKOOPFACTUURGB', PurchInvHeader."No.", 0);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPurchCrMemoHeaderInsert', '', false, false)]
    procedure AfterPurchCrMemoHeaderInsert(var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchHeader: Record "Purchase Header");
    begin
        CopyLinks('INKOOPCREDITNOTA', PurchHeader."No.", 0, 'INKOOPCREDITNOTAGB', PurchCrMemoHdr."No.", 0);
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPurchRcptLineInsert', '', false, false)]
    procedure AfterPurchRcptLineInsert(PurchaseLine: Record "Purchase Line"; PurchRcptLine: Record "Purch. Rcpt. Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean);
    begin
        CopyLinks('INKOOPORDER', PurchaseLine."Document No.", PurchaseLine."Line No.", 'INKOOPONTVANGST', PurchRcptLine."Document No.", PurchRcptLine."Line No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPurchInvLineInsert', '', false, false)]
    procedure AfterPurchInvLineInsert(var PurchInvLine: Record "Purch. Inv. Line"; PurchInvHeader: Record "Purch. Inv. Header"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean);
    begin
        case PurchLine."Document Type" of
            PurchLine."Document Type"::Order:
                CopyLinks('INKOOPORDER', PurchLine."Document No.", PurchLine."Line No.", 'INKOOPFACTUURGB', PurchInvLine."Document No.", PurchInvLine."Line No.");
            PurchLine."Document Type"::Invoice:
                CopyLinks('INKOOPFACTUUR', PurchLine."Document No.", PurchLine."Line No.", 'INKOOPFACTUURGB', PurchInvLine."Document No.", PurchInvLine."Line No.");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnAfterPurchCrMemoLineInsert', '', false, false)]
    procedure AfterPurchCrMemoLineInsert(var PurchCrMemoLine: Record "Purch. Cr. Memo Line"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var PurchLine: Record "Purchase Line");
    begin
        CopyLinks('INKOOPCREDITNOTA', PurchLine."Document No.", PurchLine."Line No.", 'INKOOPCREDITNOTAGB', PurchCrMemoLine."Document No.", PurchCrMemoLine."Line No.");
    end;
}

