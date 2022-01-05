codeunit 50000 Algemeen
{
    // version XSS5.083

    // 20190123 KBG NMSD-287: Function fInsertModificationLogSalesPurch added.
    // 20190715 MDO NMSD-59 : fBarcodeCreatorV15 geimplementeerd (Mibuso). Wel omgebouwd zodat de meegeleverde tabe niet nodig is. (Serviceartikel als tijdelijke tabel gebruikt).


    trigger OnRun();
    begin
    end;

    var
        Text50000: TextConst ENU = 'Document deleted', NLD = 'Document verwijderd';
        Text50001: Label 'Er zijn geen vrijgegeven verkooporders gevonden';
        Text50002: Label 'Verkoopordernummer kan niet langer zijn dan 20 karakters.';
        Text50003: Label 'Geen artikelen gevonden voor deze verkooporder %1';
        Text50004: Label 'Geen artikelen gevonden voor deze verkooporder %1 die voldoen aan de voorwaarden (tracering).';
        Text50005: Label 'Verkooporder %1 kan niet gevonden worden.';
        Text50006: Label 'Wilt u deze order boeken';
        Text50007: Label 'Productieordernummer kan niet langer zijn dan 20 karakters.';
        Text50008: Label 'Er zijn geen vrijgegeven productieorders gevonden';
        Text50009: Label 'Productieorder %1 kan niet gevonden worden.';
        Text50010: Label 'Geen materiaalregels gevonden voor deze productieorder %1';
        Text50011: Label 'Geen materiaalregels gevonden voor deze productieorder %1 die voldoen aan de voorwaarden (tracering).';
        Text50012: Label 'Wilt u deze order boeken?';
        Text50013: Label 'Artikelnummer kan niet langer zijn dan 20 karakters.';
        Text50014: Label 'Artikelnummer %1 niet in artikelbestand';
        Text50015: Label 'Er zijn geen artikelen gevonden';
        Text50016: Label '"Artikelnummer %1 komt niet voor op productieorder %2. "';
        lRecProdOrderComponent: Record "Prod. Order Component";
        gCduProdOrderStatusManagement: Codeunit "Prod. Order Status Management";
        Text004: TextConst ENU = '%1 %2 has not been finished. Some output is still missing. Do you still want to finish the order?', NLD = '%1 %2 kan niet gereedgemeld worden. Er ontbreekt nog output.';
        Text005: TextConst ENU = 'The update has been interrupted to respect the warning.', NLD = 'Het bijwerken is onderbroken vanwege de waarschuwing.';
        Text006: TextConst ENU = '%1 %2 has not been finished. Some consumption is still missing. Do you still want to finish the order?', NLD = '%1 %2 is niet gereedgemeld. Er ontbreekt nog verbruik.';
        Text007: TextConst ENU = 'The status of order %1 cannot be changed as it is related to planning line %2 in worksheet %3 %4.', NLD = 'De status van order %1 kan niet gewijzigd worden als deze gekoppeld is aan planningsregel %2 in voorstel %3 %4.';
        Text008: TextConst ENU = '%1 %2 cannot be finished as the associated subcontract order %3 has not been fully delivered.', NLD = '%1 %2 kan niet gereedgemeld worden omdat het gekoppelde uitbestedingsorder %3 niet volledig geleverd is.';
        gBoolHalfabrikaatGescand: Boolean;
        bxtBarcodeBinary: BigText;
        txcErrorSize: Label 'Valid values for the barcode size are 1, 2, 3, 4 & 5';
        txcErrorLength: Label 'Value to encode should be %1 digits.';
        txcErrorNumber: Label 'Only numbers allowed.';

    procedure fFillContactInfoSalesHeader(var pvRecSalesHeader: Record "Sales Header");
    var
        lRecContact: Record Contact;
        lRecCustomer: Record Customer;
    begin
        /* fFillContactInfoSalesHeader */

        pvRecSalesHeader."Sell-to Contact E-mail" := '';
        pvRecSalesHeader."Sell-to Contact Phone" := '';
        if (pvRecSalesHeader."Sell-to Contact No." <> '') and (pvRecSalesHeader."Sell-to Customer No." <> '') then begin
            if lRecContact.GET(pvRecSalesHeader."Sell-to Contact No.") then begin
                pvRecSalesHeader."Sell-to Contact E-mail" := lRecContact."E-Mail";
                pvRecSalesHeader."Sell-to Contact Phone" := lRecContact."Phone No.";
            end;
            if lRecCustomer.GET(pvRecSalesHeader."Sell-to Customer No.") then begin
                if (pvRecSalesHeader."Sell-to Contact E-mail" = '') then
                    pvRecSalesHeader."Sell-to Contact E-mail" := lRecCustomer."E-Mail";
                if (pvRecSalesHeader."Sell-to Contact Phone" = '') then
                    pvRecSalesHeader."Sell-to Contact Phone" := lRecCustomer."Phone No.";
            end;
        end;
        if (pvRecSalesHeader."Sell-to Contact No." = '') and (pvRecSalesHeader."Sell-to Customer No." <> '') then begin
            if lRecCustomer.GET(pvRecSalesHeader."Sell-to Customer No.") then begin
                pvRecSalesHeader."Sell-to Contact E-mail" := lRecCustomer."E-Mail";
                pvRecSalesHeader."Sell-to Contact Phone" := lRecCustomer."Phone No.";
            end;
        end;

    end;

    procedure fSelectSalesLine(pCodOrdernr: Code[20]): Code[20];
    var
        lFrmSalesHeader: Page "Sales List";
        lFrmSalesLines: Page "Sales Lines";
        lRecSalesHeader: Record "Sales Header";
        lRecSalesLine: Record "Sales Line";
        lRecTempSalesLine: Record "Sales Line" temporary;
        lRecItem: Record Item;
        lCodVerkoopordernr: Code[20];
        lCodArtikel: Code[20];
    begin
        /* fSelectSalesLine */

        if (STRLEN(pCodOrdernr) > 20) then
            ERROR(Text50002);

        lCodVerkoopordernr := pCodOrdernr;

        if (lCodVerkoopordernr = '') then begin
            lRecSalesHeader.RESET;
            lRecSalesHeader.SETCURRENTKEY("Document Type", "No.");
            lRecSalesHeader.SETRANGE("Document Type", lRecSalesHeader."Document Type"::Order);
            lRecSalesHeader.SETRANGE(Status, lRecSalesHeader.Status::Released);
            if not (lRecSalesHeader.FINDFIRST) then
                ERROR(Text50001);

            CLEAR(lFrmSalesHeader);
            lFrmSalesHeader.SETRECORD(lRecSalesHeader);
            lFrmSalesHeader.SETTABLEVIEW(lRecSalesHeader);
            lFrmSalesHeader.EDITABLE(false);
            lFrmSalesHeader.LOOKUPMODE(true);
            if lFrmSalesHeader.RUNMODAL = ACTION::LookupOK then begin
                lFrmSalesHeader.GETRECORD(lRecSalesHeader);
                lCodVerkoopordernr := lRecSalesHeader."No.";
            end;
        end;
        if (lCodVerkoopordernr = '') then exit;
        if not (lRecSalesHeader.GET(lRecSalesLine."Document Type"::Order, lCodVerkoopordernr)) then
            ERROR(Text50005, lCodVerkoopordernr);

        CLEAR(lRecTempSalesLine);
        lRecSalesLine.RESET;
        lRecSalesLine.SETCURRENTKEY("Document Type", "Document No.", "Line No.");
        lRecSalesLine.SETRANGE("Document Type", lRecSalesLine."Document Type"::Order);
        lRecSalesLine.SETRANGE("Document No.", lCodVerkoopordernr);
        if not (lRecSalesLine.FINDFIRST) then exit(STRSUBSTNO(Text50003, lCodVerkoopordernr));
        repeat
            if lRecItem.GET(lRecSalesLine."No.") and (lRecSalesLine.Type = lRecSalesLine.Type::Item) then begin
                if (lRecItem."Item Tracking Code" <> '') then begin
                    if not (lRecTempSalesLine.GET(lRecSalesLine."Document Type",
                                                 lRecSalesLine."Document No.",
                                                 lRecSalesLine."Line No.")) then begin
                        lRecTempSalesLine.INIT;
                        lRecTempSalesLine.COPY(lRecSalesLine);
                        lRecTempSalesLine.INSERT(false); //is temporary
                    end;
                end;
            end;
        until lRecSalesLine.NEXT = 0;
        if not (lRecTempSalesLine.FINDFIRST) then exit(STRSUBSTNO(Text50004, lCodVerkoopordernr));

        CLEAR(lFrmSalesLines);
        //<<UPGRADE lFrmSalesLines.fSetTraceringProperty(TRUE,lRecSalesLine);
        lFrmSalesLines.EDITABLE(false);
        lFrmSalesLines.LOOKUPMODE(true);
        if lFrmSalesLines.RUNMODAL = ACTION::LookupOK then begin
            lFrmSalesLines.GETRECORD(lRecSalesLine);
            lCodArtikel := lRecSalesLine."No.";
            //MESSAGE('test artikel %1',lCodArtikel);
            lRecSalesLine.OpenItemTrackingLines;
        end;
        exit('');

    end;

    procedure fSelectProductionLine(pCodProductieOrder: Code[20]; pCodItemNo: Code[20]): Code[20];
    var
        lCodProductieOrder: Code[20];
        lRecProductionOrder: Record "Production Order";
        lFrmProductionOrderList: Page "Production Order List";
        lRecProdOrderLine: Record "Prod. Order Line";
        lRecTempProdOrderLine: Record "Prod. Order Line" temporary;
        lRecItem: Record Item;
        lFrmProdOrderLineList: Page "Prod. Order Line List";
        lCodArtikel: Code[20];
        lCduProdJournalMgt: Codeunit "Production Journal Mgt";
        lRecReservationEntry: Record "Reservation Entry";
        //lOptNewStatus: Option Quote,Planned,"Firm Planned",Released,Finished;
        lOptNewStatus: Enum "Production Order Status";
        lDatNewPostingDate: Date;
        lBoolNewUpdateUnitCost: Boolean;
    begin
        /* fSelectProductionLine */

        if (STRLEN(pCodProductieOrder) > 20) then
            ERROR(Text50007);

        lCodProductieOrder := pCodProductieOrder;

        if (lCodProductieOrder = '') then begin
            lRecProductionOrder.RESET;
            lRecProductionOrder.SETCURRENTKEY(Status, "No.");
            lRecProductionOrder.SETRANGE(Status, lRecProductionOrder.Status::Released);
            if (pCodItemNo <> '') then
                lRecProductionOrder.SETRANGE("Source No.", pCodItemNo);
            if not (lRecProductionOrder.FINDFIRST) then
                ERROR(Text50008);

            CLEAR(lFrmProductionOrderList);
            lFrmProductionOrderList.SETRECORD(lRecProductionOrder);
            lFrmProductionOrderList.SETTABLEVIEW(lRecProductionOrder);


            lFrmProductionOrderList.EDITABLE(false);
            lFrmProductionOrderList.LOOKUPMODE(true);
            if lFrmProductionOrderList.RUNMODAL = ACTION::LookupOK then begin
                lFrmProductionOrderList.GETRECORD(lRecProductionOrder);
                lCodProductieOrder := lRecProductionOrder."No.";
            end;
        end;
        if (lCodProductieOrder = '') then exit;
        if not (lRecProductionOrder.GET(lRecProdOrderLine.Status::Released, lCodProductieOrder)) then
            ERROR(Text50009, lCodProductieOrder);
        if lRecProductionOrder."Source No." <> pCodItemNo then
            ERROR(Text50016, pCodItemNo, lCodProductieOrder);

        CLEAR(lRecTempProdOrderLine);
        lRecProdOrderLine.RESET;
        lRecProdOrderLine.SETCURRENTKEY(Status, "Prod. Order No.", "Line No.");
        //lRecProdOrderLine.SETRANGE(Status, lRecProdOrderLine.Status::Released);
        lRecProdOrderLine.SETRANGE("Prod. Order No.", lCodProductieOrder);
        if not (lRecProdOrderLine.FINDFIRST) then
            exit(STRSUBSTNO(Text50010, lCodProductieOrder));
        repeat
            if lRecItem.GET(lRecProdOrderLine."Item No.") and (lRecProdOrderLine.Status = lRecProdOrderLine.Status::Released) then begin
                if (lRecItem."Item Tracking Code" <> '') then begin
                    if not (lRecTempProdOrderLine.GET(lRecProdOrderLine.Status,
                                                 lRecProdOrderLine."Prod. Order No.",
                                                 lRecProdOrderLine."Line No.")) then begin
                        lRecTempProdOrderLine.INIT;
                        lRecTempProdOrderLine.COPY(lRecProdOrderLine);
                        lRecTempProdOrderLine.INSERT(false); //is temporary
                    end;
                end;
            end;
        until lRecProdOrderLine.NEXT = 0;
        if not (lRecTempProdOrderLine.FINDFIRST) then exit(STRSUBSTNO(Text50011, lCodProductieOrder));

        CLEAR(lFrmProdOrderLineList);
        lFrmProdOrderLineList.SETRECORD(lRecProdOrderLine);
        lFrmProdOrderLineList.SETTABLEVIEW(lRecProdOrderLine);
        //lFrmProdOrderLineList.fSetTraceringProperty(TRUE,lRecProdOrderLine);
        lFrmProdOrderLineList.EDITABLE(false);
        lFrmProdOrderLineList.LOOKUPMODE(true);
        if lFrmProdOrderLineList.RUNMODAL = ACTION::LookupOK then begin
            lFrmProdOrderLineList.GETRECORD(lRecProdOrderLine);
            lCodArtikel := lRecProdOrderLine."Item No.";
            //MESSAGE('test artikel %1',lCodArtikel);
            lRecProdOrderLine.OpenItemTrackingLines;

            //Nog halffabrikaten te scannen
            gBoolHalfabrikaatGescand := false;
            lRecProdOrderComponent.RESET;
            lRecProdOrderComponent.SETCURRENTKEY(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
            lRecProdOrderComponent.SETRANGE(Status, lRecProdOrderLine.Status::Released);
            lRecProdOrderComponent.SETRANGE("Prod. Order No.", lCodProductieOrder);
            lRecProdOrderComponent.SETRANGE("Prod. Order Line No.", lRecProdOrderLine."Line No.");
            if lRecProdOrderComponent.FINDFIRST then begin
                repeat
                    if lRecItem.GET(lRecProdOrderComponent."Item No.") then begin
                        if (lRecItem."Production BOM No." <> '') and (not (gBoolHalfabrikaatGescand)) then begin
                            lCduProdJournalMgt.Handling(lRecProductionOrder, lRecProdOrderLine."Line No.");
                            gBoolHalfabrikaatGescand := true;
                        end;
                    end;
                until lRecProdOrderComponent.NEXT = 0;
            end;

            lRecReservationEntry.RESET;
            lRecReservationEntry.SETCURRENTKEY("Entry No.", Positive);
            lRecReservationEntry.SETRANGE("Item No.", lCodArtikel);
            lRecReservationEntry.SETRANGE("Source ID", lRecProdOrderLine."Prod. Order No.");
            if lRecReservationEntry.FINDFIRST then begin
                if (lRecReservationEntry."Serial No." <> '') and (lRecReservationEntry."Qty. to Handle (Base)" > 0) then begin
                    if CONFIRM(Text50012, true) then begin
                        lRecProductionOrder.GET(lRecProdOrderLine.Status, lRecProdOrderLine."Prod. Order No.");
                        CLEAR(lCduProdJournalMgt);

                        //Echt doorboeken
                        lRecProductionOrder.SETRECFILTER;
                        fBoekProductieOrder(lRecProductionOrder, lRecProdOrderLine);

                    end;
                end;
            end;

            //Check voor gereedmelden
            fCheckBeforeFinishProdOrder(lRecProductionOrder);

            //Gereedmelden productieorder
            lOptNewStatus := lOptNewStatus::Finished;
            lDatNewPostingDate := WORKDATE;
            lBoolNewUpdateUnitCost := false;
            // gCduProdOrderStatusManagement.ChangeStatusOnProdOrder(lRecProductionOrder, lOptNewStatus,
            //                                                         lDatNewPostingDate, lBoolNewUpdateUnitCost);
            gCduProdOrderStatusManagement.ChangeProdOrderStatus(lRecProductionOrder, lOptNewStatus,
                                                                  lDatNewPostingDate, lBoolNewUpdateUnitCost);
            COMMIT;

        end;
        exit('');

    end;

    procedure fSelectItemNo(pCodItemNo: Code[20]): Code[20];
    var
        lFrmItem: Page "Item List";
        lRecItem: Record Item;
        lCodItemNo: Code[20];
        lCodArtikel: Code[20];
    begin
        /* fSelectItemNo */

        if (STRLEN(pCodItemNo) > 20) then
            ERROR(Text50013);

        lCodItemNo := pCodItemNo;

        if (lCodItemNo = '') then begin
            lRecItem.RESET;
            lRecItem.SETCURRENTKEY("No.");
            if not (lRecItem.GET) then
                ERROR(Text50015);

            CLEAR(lFrmItem);
            lFrmItem.SETRECORD(lRecItem);
            lFrmItem.SETTABLEVIEW(lRecItem);
            lFrmItem.EDITABLE(false);
            lFrmItem.LOOKUPMODE(true);
            if lFrmItem.RUNMODAL = ACTION::LookupOK then begin
                lFrmItem.GETRECORD(lRecItem);
                lCodItemNo := lRecItem."No.";
            end;
        end;
        if (lCodItemNo = '') then exit;
        if not (lRecItem.GET(lCodItemNo)) then
            ERROR(Text50014, lCodItemNo);

        exit(lCodItemNo);

    end;

    procedure fBoekProductieOrder(pRecProductionOrder: Record "Production Order"; pRecProdOrderLine: Record "Prod. Order Line");
    var
        lCduProductionJournalMgt: Codeunit "Production Journal Mgt";
    begin
        /* fBoekProductieOrder */

        //<<UPGRADE lCduProductionJournalMgt.HandlingWithPost(pRecProductionOrder,pRecProdOrderLine."Line No.");

    end;

    procedure fCheckBeforeFinishProdOrder(ProdOrder: Record "Production Order");
    var
        ProdOrderLine: Record "Prod. Order Line";
        ProdOrderComp: Record "Prod. Order Component";
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        PurchLine: Record "Purchase Line";
        ShowWarning: Boolean;
    begin
        /* fCheckBeforeFinishProdOrder */
        PurchLine.SETCURRENTKEY("Document Type", Type, "Prod. Order No.", "Prod. Order Line No.", "Routing No.", "Operation No.");
        PurchLine.SETRANGE("Document Type", PurchLine."Document Type"::Order);
        PurchLine.SETRANGE(Type, PurchLine.Type::Item);
        PurchLine.SETRANGE("Prod. Order No.", ProdOrder."No.");
        PurchLine.SETFILTER("Outstanding Quantity", '<>%1', 0);
        if PurchLine.FINDFIRST then
            ERROR(Text008, ProdOrder.TABLECAPTION, ProdOrder."No.", PurchLine."Document No.");

        ProdOrderLine.SETRANGE(Status, ProdOrder.Status);
        ProdOrderLine.SETRANGE("Prod. Order No.", ProdOrder."No.");
        ProdOrderLine.SETFILTER("Remaining Quantity", '<>0');
        if not ProdOrderLine.ISEMPTY then begin
            ProdOrderRtngLine.SETRANGE(Status, ProdOrder.Status);
            ProdOrderRtngLine.SETRANGE("Prod. Order No.", ProdOrder."No.");
            ProdOrderRtngLine.SETRANGE("Next Operation No.", '');
            if not ProdOrderRtngLine.ISEMPTY then begin
                ProdOrderRtngLine.SETFILTER("Flushing Method", '<>%1', ProdOrderRtngLine."Flushing Method"::Backward);
                ShowWarning := not ProdOrderRtngLine.ISEMPTY;
            end else
                ShowWarning := true;

            if ShowWarning then begin
                ;
                ERROR(Text004, ProdOrder.TABLECAPTION, ProdOrder."No.");
            end;
        end;

        ProdOrderComp.SETRANGE(Status, ProdOrder.Status);
        ProdOrderComp.SETRANGE("Prod. Order No.", ProdOrder."No.");
        ProdOrderComp.SETFILTER("Remaining Quantity", '<>0');
        if ProdOrderComp.FINDSET then
            repeat
                if ((ProdOrderComp."Flushing Method" <> ProdOrderComp."Flushing Method"::Backward) and
                    (ProdOrderComp."Flushing Method" <> ProdOrderComp."Flushing Method"::"Pick + Backward") and
                    (ProdOrderComp."Routing Link Code" = '')) or
                   ((ProdOrderComp."Routing Link Code" <> '') and not RtngWillFlushComp(ProdOrderComp))
                then begin
                    ERROR(Text006, ProdOrder.TABLECAPTION, ProdOrder."No.");
                end;
            until ProdOrderComp.NEXT = 0;

    end;

    local procedure RtngWillFlushComp(ProdOrderComp: Record "Prod. Order Component"): Boolean;
    var
        ProdOrderRtngLine: Record "Prod. Order Routing Line";
        ProdOrderLine: Record "Prod. Order Line";
    begin
        if ProdOrderComp."Routing Link Code" = '' then
            exit;

        ProdOrderLine.GET(ProdOrderComp.Status, ProdOrderComp."Prod. Order No.", ProdOrderComp."Prod. Order Line No.");

        ProdOrderRtngLine.SETCURRENTKEY("Prod. Order No.", Status, "Flushing Method");
        ProdOrderRtngLine.SETRANGE("Flushing Method", ProdOrderRtngLine."Flushing Method"::Backward);
        ProdOrderRtngLine.SETRANGE(Status, ProdOrderRtngLine.Status::Released);
        ProdOrderRtngLine.SETRANGE("Prod. Order No.", ProdOrderComp."Prod. Order No.");
        ProdOrderRtngLine.SETRANGE("Routing Link Code", ProdOrderComp."Routing Link Code");
        ProdOrderRtngLine.SETRANGE("Routing No.", ProdOrderLine."Routing No.");
        ProdOrderRtngLine.SETRANGE("Routing Reference No.", ProdOrderLine."Routing Reference No.");
        exit(ProdOrderRtngLine.FINDFIRST);
    end;

    procedure fRunSalesLabel(pRecSalesHeader: Record "Sales Header");
    begin
        /* fRunSalesLabel */

        //<<UPGRADE   CLEAR(lRepSalesLabel);
        pRecSalesHeader.SETRECFILTER;
        //<<UPGRADE  lRepSalesLabel.SETTABLEVIEW(pRecSalesHeader);
        //<<UPGRADE  lRepSalesLabel.RUNMODAL;

    end;

    procedure fReturnOutstandingAmountExcVAT(pCodKlant: Code[20]): Decimal;
    var
        lRecKlant: Record Customer;
        lRecSalesLine: Record "Sales Line";
        lDecAmountExcVAT: Decimal;
    begin
        /* fReturnOutstandingAmountExcVAT */

        lDecAmountExcVAT := 0;
        if lRecKlant.GET(pCodKlant) then begin
            lRecSalesLine.RESET;
            lRecSalesLine.SETCURRENTKEY("Document Type", "Bill-to Customer No.", "Currency Code");
            lRecSalesLine.SETRANGE("Document Type", lRecSalesLine."Document Type"::Order);
            lRecSalesLine.SETRANGE("Bill-to Customer No.", pCodKlant);
            if lRecSalesLine.FINDFIRST then
                repeat
                    if lRecSalesLine."VAT %" <> 0 then
                        lDecAmountExcVAT := lDecAmountExcVAT + (lRecSalesLine."Outstanding Amount (LCY)" / (100 + lRecSalesLine."VAT %") * 100)
                    else
                        lDecAmountExcVAT := lDecAmountExcVAT + lRecSalesLine."Outstanding Amount (LCY)";
                until lRecSalesLine.NEXT = 0;
        end;
        exit(lDecAmountExcVAT);

    end;

    procedure fRunCertificateOfConformance(pRecSalesHeader: Record "Sales Header");
    begin
        /* fRunCertificateOfConformance */

        //<<UPGRADE    CLEAR(lRepCertificateOfConformance);
        pRecSalesHeader.SETRECFILTER;
        //<<UPGRADE     lRepCertificateOfConformance.SETTABLEVIEW(pRecSalesHeader);
        //<<UPGRADE    lRepCertificateOfConformance.RUNMODAL;

    end;

    procedure fUseAmericanSalesTax(): Boolean;
    var
        lRecCompanyInformation: Record "Company Information";
    begin
        lRecCompanyInformation.GET;
        if lRecCompanyInformation."Use US Tax System" then
            exit(true);
    end;

    procedure fInsertModificationLogSalesPurch(pRecSalesHeader: Record "Sales Header"; pRecPurchaseHeader: Record "Purchase Header"; pBoolVerkoop: Boolean; pOptSoortWijziging: Option Akkoord,Boeken);
    var
        lRecWijzigingslogDocumenten: Record "Wijzigingslog documenten";
    begin
        /* fInsertModificationLogSalesPurch */

        if pBoolVerkoop then begin
            if not (lRecWijzigingslogDocumenten.GET(lRecWijzigingslogDocumenten."Document Soort"::Verkoop,
                                                   pRecSalesHeader."Document Type",
                                                   pRecSalesHeader."No.",
                                                   0,
                                                   WORKDATE,
                                                   TIME)) then begin
                lRecWijzigingslogDocumenten.INIT;
                lRecWijzigingslogDocumenten."Document Soort" := lRecWijzigingslogDocumenten."Document Soort"::Verkoop;
                lRecWijzigingslogDocumenten."Document Type" := pRecSalesHeader."Document Type".AsInteger();
                lRecWijzigingslogDocumenten."Document Nummer" := pRecSalesHeader."No.";
                lRecWijzigingslogDocumenten."Document Regel" := 0;
                lRecWijzigingslogDocumenten.Datum := WORKDATE;
                lRecWijzigingslogDocumenten.Tijd := TIME;
                lRecWijzigingslogDocumenten.Gebruiker := USERID;
                if pOptSoortWijziging = pOptSoortWijziging::Akkoord then begin
                    lRecWijzigingslogDocumenten."Boekingsdatum akkoord" := pRecSalesHeader."Boekingsdatum akkoord";
                    lRecWijzigingslogDocumenten."Boekingsdatum document" := pRecSalesHeader."Posting Date";
                end;
                if pOptSoortWijziging = pOptSoortWijziging::Boeken then begin
                    lRecWijzigingslogDocumenten."Boekingsdatum akkoord" := pRecSalesHeader."Boekingsdatum akkoord";
                    lRecWijzigingslogDocumenten."Boekingsdatum document" := pRecSalesHeader."Posting Date";
                    lRecWijzigingslogDocumenten."Document geboekt" := true;
                end;
                lRecWijzigingslogDocumenten.INSERT(true);
            end;
        end else begin
            if not (lRecWijzigingslogDocumenten.GET(lRecWijzigingslogDocumenten."Document Soort"::Inkoop,
                                                   pRecSalesHeader."Document Type",
                                                   pRecSalesHeader."No.",
                                                   0,
                                                   WORKDATE,
                                                   TIME)) then begin
                lRecWijzigingslogDocumenten.INIT;
                lRecWijzigingslogDocumenten."Document Soort" := lRecWijzigingslogDocumenten."Document Soort"::Inkoop;
                lRecWijzigingslogDocumenten."Document Type" := pRecPurchaseHeader."Document Type".AsInteger();
                lRecWijzigingslogDocumenten."Document Nummer" := pRecPurchaseHeader."No.";
                lRecWijzigingslogDocumenten."Document Regel" := 0;
                lRecWijzigingslogDocumenten.Datum := WORKDATE;
                lRecWijzigingslogDocumenten.Tijd := TIME;
                lRecWijzigingslogDocumenten.Gebruiker := USERID;
                if pOptSoortWijziging = pOptSoortWijziging::Akkoord then begin
                    lRecWijzigingslogDocumenten."Boekingsdatum akkoord" := pRecPurchaseHeader."Boekingsdatum akkoord";
                    lRecWijzigingslogDocumenten."Boekingsdatum document" := pRecPurchaseHeader."Posting Date";
                end;
                if pOptSoortWijziging = pOptSoortWijziging::Boeken then begin
                    lRecWijzigingslogDocumenten."Boekingsdatum akkoord" := pRecPurchaseHeader."Boekingsdatum akkoord";
                    lRecWijzigingslogDocumenten."Boekingsdatum document" := pRecPurchaseHeader."Posting Date";
                    lRecWijzigingslogDocumenten."Document geboekt" := true;
                end;
                lRecWijzigingslogDocumenten.INSERT(true);
            end;
        end;

    end;

    procedure fBlockEditingOnSalesForceOrders(pCodOrderNo: Code[10]; pOptDocType: Code[20]): Boolean;
    var
        lRecSalesHeader: Record "Sales Header";
        lCodDocType: Code[20];
    begin
        case pOptDocType of
            'ORDER':
                begin
                    lRecSalesHeader.GET(lRecSalesHeader."Document Type"::Order, pCodOrderNo);
                    if lRecSalesHeader."External Document No." <> '' then
                        exit(false)
                    else
                        exit(true)
                end;
        end;
    end;

    procedure fBarcodeCreatorV15EncodeEAN13(pcodBarcode: Code[250]; pintSize: Integer; pblnVertical: Boolean; var precTmpTempBlob: Record "Blob Management" temporary; BlobNumber: Integer); //TempBlob temporary);
    var
        lintCheckDigit: Integer;
        lcodBarInclCheckD: Code[13];
        ltxtWeight: Text[12];
        ltxtSentinel: Text[3];
        ltxtCenterGuard: Text[6];
        ltxtParEnc: array[10] of Text[6];
        ltxtSetEnc: array[10, 10] of Text[7];
        lintCount: Integer;
        lintCoding: Integer;
        lintNumber: Integer;
        ltxtBarcode: Text[30];
        lintLines: Integer;
        lintBars: Integer;
        loutBmpHeader: OutStream;
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        CLEAR(bxtBarcodeBinary);
        CLEAR(precTmpTempBlob);
        ltxtSentinel := '101';
        ltxtCenterGuard := '01010';
        ltxtWeight := '131313131313';

        if STRLEN(pcodBarcode) <> 12 then
            ERROR(txcErrorLength, 12);

        if not (pintSize in [1, 2, 3, 4, 5]) then
            ERROR(txcErrorSize);

        for lintCount := 1 to STRLEN(pcodBarcode) do begin
            if not (pcodBarcode[lintCount] in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']) then
                ERROR(txcErrorNumber);
        end;

        fBarcodeCreatorV15InitEAN813(ltxtParEnc, ltxtSetEnc);

        //CALCULATE CHECKDIGIT
        lintCheckDigit := STRCHECKSUM(pcodBarcode, ltxtWeight, 10);

        //PAYLOAD TO ENCODE
        lcodBarInclCheckD := COPYSTR(pcodBarcode, 2, STRLEN(pcodBarcode)) + FORMAT(lintCheckDigit);

        //EAN PARITY ENCODING TABLE
        EVALUATE(lintCoding, FORMAT(pcodBarcode[1]));
        lintCoding += 1;

        //ADD START SENTINEL
        bxtBarcodeBinary.ADDTEXT(ltxtSentinel);

        for lintCount := 1 to STRLEN(lcodBarInclCheckD) do begin

            //ADD CENTERGUARD
            if lintCount = 7 then
                bxtBarcodeBinary.ADDTEXT(ltxtCenterGuard);

            EVALUATE(lintNumber, FORMAT(lcodBarInclCheckD[lintCount]));

            if lintCount <= 6 then begin
                ltxtBarcode := ltxtParEnc[lintCoding];
                case ltxtBarcode[lintCount] of
                    'O':
                        bxtBarcodeBinary.ADDTEXT(ltxtSetEnc[lintNumber + 1] [1]);
                    'E':
                        bxtBarcodeBinary.ADDTEXT(ltxtSetEnc[lintNumber + 1] [2]);
                end;
            end else
                bxtBarcodeBinary.ADDTEXT(ltxtSetEnc[lintNumber + 1] [3]);

        end;

        //ADD STOP SENTINEL
        bxtBarcodeBinary.ADDTEXT(ltxtSentinel);

        lintBars := bxtBarcodeBinary.LENGTH;
        lintLines := ROUND(lintBars * 0.25, 1, '>');

        //precTmpTempBlob.Blob.CREATEOUTSTREAM(loutBmpHeader);
        case BlobNumber of
            1:
                precTmpTempBlob.Blob1.CREATEOUTSTREAM(loutBmpHeader);
            2:
                precTmpTempBlob.Blob2.CREATEOUTSTREAM(loutBmpHeader);
            3:
                precTmpTempBlob.Blob3.CREATEOUTSTREAM(loutBmpHeader);
        end;

        //WRITING HEADER
        fBarcodeCreatorV15CreateBMPHeader(loutBmpHeader, lintBars, lintLines, pintSize, pblnVertical);

        //WRITE BARCODE DETAIL
        fBarcodeCreatorV15CreateBarcodeDetail(lintLines, lintBars, pintSize, pblnVertical, loutBmpHeader);
    end;

    procedure fBarcodeCreatorV15EncodeCode128(pcodBarcode: Code[1024]; pintSize: Integer; pblnVertical: Boolean; var precTmpTempBlob: Record "Blob Management" temporary; BlobNumber: Integer); //TempBlob temporary);
    var
        lRecTMPCode: Record "Service Item" temporary;
        lintCount1: Integer;
        ltxtArray: array[2, 200] of Text[30];
        lcharCurrentCharSet: Char;
        lintWeightSum: Integer;
        lintCount2: Integer;
        lintConvInt: Integer;
        ltxtTerminationBar: Text[2];
        lintCheckDigit: Integer;
        lintConvInt1: Integer;
        lintConvInt2: Integer;
        lblnnumber: Boolean;
        lintLines: Integer;
        lintBars: Integer;
        loutBmpHeader: OutStream;
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        if not lRecTMPCode.ISTEMPORARY then
            ERROR('lRecTMPCode moet een tijdelijke tabel zijn');

        CLEAR(bxtBarcodeBinary);
        CLEAR(precTmpTempBlob);
        CLEAR(lRecTMPCode);
        lRecTMPCode.DELETEALL;
        CLEAR(lcharCurrentCharSet);
        ltxtTerminationBar := '11';

        if not (pintSize in [1, 2, 3, 4, 5]) then
            ERROR(txcErrorSize);

        fBarcodeCreatorV15InitCode128(lRecTMPCode);

        for lintCount1 := 1 to STRLEN(pcodBarcode) do begin
            lintCount2 += 1;
            lblnnumber := false;
            lRecTMPCode.RESET;

            if EVALUATE(lintConvInt1, FORMAT(pcodBarcode[lintCount1])) then
                lblnnumber := EVALUATE(lintConvInt2, FORMAT(pcodBarcode[lintCount1 + 1]));

            //A '.' IS EVALUATED AS A 0, EXTRA CHECK NEEDED
            if FORMAT(pcodBarcode[lintCount1]) = '.' then
                lblnnumber := false;

            if FORMAT(pcodBarcode[lintCount1 + 1]) = '.' then
                lblnnumber := false;

            if lblnnumber and (lintConvInt1 in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]) and (lintConvInt2 in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]) then begin
                if (lcharCurrentCharSet <> 'C') then begin
                    if (lintCount1 = 1) then begin
                        lRecTMPCode.GET('STARTC');
                        EVALUATE(lintConvInt, lRecTMPCode."Service Item Group Code");
                        lintWeightSum := lintConvInt;
                    end else begin
                        lRecTMPCode.GET('CODEC');
                        EVALUATE(lintConvInt, lRecTMPCode."Service Item Group Code");
                        lintWeightSum += lintConvInt * lintCount2;
                        lintCount2 += 1;
                    end;

                    bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));
                    lcharCurrentCharSet := 'C';
                end;
            end else begin
                if lcharCurrentCharSet <> 'A' then begin
                    if (lintCount1 = 1) then begin
                        lRecTMPCode.GET('STARTA');
                        EVALUATE(lintConvInt, lRecTMPCode."Service Item Group Code");
                        lintWeightSum := lintConvInt;
                    end else begin
                        //CODEA
                        lRecTMPCode.GET('FNC4');
                        EVALUATE(lintConvInt, lRecTMPCode."Service Item Group Code");
                        lintWeightSum += lintConvInt * lintCount2;
                        lintCount2 += 1;
                    end;

                    bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));
                    lcharCurrentCharSet := 'A';
                end;
            end;

            case lcharCurrentCharSet of
                'A':
                    begin
                        lRecTMPCode.GET(FORMAT(pcodBarcode[lintCount1]));

                        EVALUATE(lintConvInt, lRecTMPCode."Service Item Group Code");

                        lintWeightSum += lintConvInt * lintCount2;
                        bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));
                    end;
                'C':
                    begin
                        lRecTMPCode.RESET;
                        lRecTMPCode.SETCURRENTKEY("Service Item Group Code");
                        lRecTMPCode.SETRANGE("Service Item Group Code", (FORMAT(pcodBarcode[lintCount1]) + FORMAT(pcodBarcode[lintCount1 + 1])));
                        lRecTMPCode.FINDFIRST;

                        EVALUATE(lintConvInt, lRecTMPCode."Service Item Group Code");
                        lintWeightSum += lintConvInt * lintCount2;

                        bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));
                        lintCount1 += 1;
                    end;
            end;
        end;

        lintCheckDigit := lintWeightSum mod 103;

        //ADD CHECK DIGIT
        lRecTMPCode.RESET;
        lRecTMPCode.SETCURRENTKEY("Service Item Group Code");

        if lintCheckDigit <= 9 then
            lRecTMPCode.SETRANGE("Service Item Group Code", '0' + FORMAT(lintCheckDigit))
        else
            lRecTMPCode.SETRANGE("Service Item Group Code", FORMAT(lintCheckDigit));

        lRecTMPCode.FINDFIRST;
        bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));

        //ADD STOP CHARACTER
        lRecTMPCode.GET('STOP');
        bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));

        //ADD TERMINATION BAR
        bxtBarcodeBinary.ADDTEXT(ltxtTerminationBar);

        lintBars := bxtBarcodeBinary.LENGTH;
        lintLines := ROUND(lintBars * 0.25, 1, '>');

        //precTmpTempBlob.Blob.CREATEOUTSTREAM(loutBmpHeader);
        case BlobNumber of
            1:
                precTmpTempBlob.Blob1.CREATEOUTSTREAM(loutBmpHeader);
            2:
                precTmpTempBlob.Blob2.CREATEOUTSTREAM(loutBmpHeader);
            3:
                precTmpTempBlob.Blob3.CREATEOUTSTREAM(loutBmpHeader);
        end;

        //WRITING HEADER
        fBarcodeCreatorV15CreateBMPHeader(loutBmpHeader, lintBars, lintLines, pintSize, pblnVertical);

        //WRITE BARCODE DETAIL
        fBarcodeCreatorV15CreateBarcodeDetail(lintLines, lintBars, pintSize, pblnVertical, loutBmpHeader);
    end;

    procedure fBarcodeCreatorV15EncodeCode39(pcodBarcode: Code[1024]; pintSize: Integer; pblnCheckDigit: Boolean; pblnVertical: Boolean; var precTmpTempBlob: Record "Blob Management" temporary; BlobNumber: Integer); //TempBlob temporary);
    var
        lRecTMPCode: Record "Service Item" temporary;
        lintCount1: Integer;
        lintSum: Integer;
        lintConvInt: Integer;
        lintCheckDigit: Integer;
        lintLines: Integer;
        lintBars: Integer;
        loutBmpHeader: OutStream;
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        if not lRecTMPCode.ISTEMPORARY then
            ERROR('lRecTMPCode moet een tijdelijke tabel zijn');

        CLEAR(bxtBarcodeBinary);
        CLEAR(precTmpTempBlob);
        CLEAR(lRecTMPCode);
        lRecTMPCode.DELETEALL;
        lintSum := 0;

        if not (pintSize in [1, 2, 3, 4, 5]) then
            ERROR(txcErrorSize);

        fBarcodeCreatorV15InitCode39(lRecTMPCode);

        //CALCULATE CHECK DIGIT
        if pblnCheckDigit then begin
            for lintCount1 := 1 to STRLEN(pcodBarcode) do begin
                lRecTMPCode.GET(FORMAT(pcodBarcode[lintCount1]));
                EVALUATE(lintConvInt, lRecTMPCode."Service Item Group Code");
                lintSum += lintConvInt;
            end;
            lintCheckDigit := lintSum mod 43;
            pcodBarcode := pcodBarcode + FORMAT(lintCheckDigit);
        end;

        //ADD START CHARACTER
        lRecTMPCode.GET('*');
        bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));

        //ADD SEPERATOR
        bxtBarcodeBinary.ADDTEXT('0');

        for lintCount1 := 1 to STRLEN(pcodBarcode) do begin
            //ADD SEPERATOR
            bxtBarcodeBinary.ADDTEXT('0');

            lRecTMPCode.GET(FORMAT(pcodBarcode[lintCount1]));
            bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));
        end;

        //ADD SEPERATOR
        bxtBarcodeBinary.ADDTEXT('0');


        //ADD STOP CHARACTER
        lRecTMPCode.GET('*');
        bxtBarcodeBinary.ADDTEXT(FORMAT(lRecTMPCode."Item No."));

        lintBars := bxtBarcodeBinary.LENGTH;
        lintLines := ROUND(lintBars * 0.25, 1, '>');

        //precTmpTempBlob.Blob.CREATEOUTSTREAM(loutBmpHeader);
        case BlobNumber of
            1:
                precTmpTempBlob.Blob1.CREATEOUTSTREAM(loutBmpHeader);
            2:
                precTmpTempBlob.Blob2.CREATEOUTSTREAM(loutBmpHeader);
            3:
                precTmpTempBlob.Blob3.CREATEOUTSTREAM(loutBmpHeader);
        end;

        //WRITING HEADER
        fBarcodeCreatorV15CreateBMPHeader(loutBmpHeader, lintBars, lintLines, pintSize, pblnVertical);

        //WRITE BARCODE DETAIL
        fBarcodeCreatorV15CreateBarcodeDetail(lintLines, lintBars, pintSize, pblnVertical, loutBmpHeader);
    end;

    procedure fBarcodeCreatorV15EncodeEAN8(pcodBarcode: Code[250]; pintSize: Integer; pblnVertical: Boolean; var precTmpTempBlob: Record "Blob Management" temporary; BlobNumber: Integer); //TempBlob temporary);
    var
        ltxtWeight: Text[12];
        ltxtSentinel: Text[3];
        ltxtCenterGuard: Text[6];
        ltxtParEnc: array[10] of Text[6];
        ltxtSetEnc: array[10, 10] of Text[7];
        lintCheckDigit: Integer;
        lintCount: Integer;
        lintNumber: Integer;
        lintBars: Integer;
        lintLines: Integer;
        loutBmpHeader: OutStream;
        lcodBarInclCheckD: Code[8];
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        CLEAR(bxtBarcodeBinary);
        CLEAR(precTmpTempBlob);
        ltxtSentinel := '101';
        ltxtCenterGuard := '01010';
        ltxtWeight := '3131313';

        if STRLEN(pcodBarcode) <> 7 then
            ERROR(txcErrorLength, 7);

        if not (pintSize in [1, 2, 3, 4, 5]) then
            ERROR(txcErrorSize);

        for lintCount := 1 to STRLEN(pcodBarcode) do begin
            if not (pcodBarcode[lintCount] in ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']) then
                ERROR(txcErrorNumber);
        end;

        fBarcodeCreatorV15InitEAN813(ltxtParEnc, ltxtSetEnc);

        //CALCULATE CHECKDIGIT
        lintCheckDigit := STRCHECKSUM(pcodBarcode, ltxtWeight, 10);

        //PAYLOAD TO ENCODE
        lcodBarInclCheckD := pcodBarcode + FORMAT(lintCheckDigit);

        //ADD START SENTINEL
        bxtBarcodeBinary.ADDTEXT(ltxtSentinel);

        for lintCount := 1 to STRLEN(lcodBarInclCheckD) do begin
            //ADD CENTERGUARD
            if lintCount = 5 then
                bxtBarcodeBinary.ADDTEXT(ltxtCenterGuard);

            EVALUATE(lintNumber, FORMAT(lcodBarInclCheckD[lintCount]));

            if lintCount <= 4 then
                bxtBarcodeBinary.ADDTEXT(ltxtSetEnc[lintNumber + 1] [1])
            else
                bxtBarcodeBinary.ADDTEXT(ltxtSetEnc[lintNumber + 1] [3]);

        end;

        //ADD STOP SENTINEL
        bxtBarcodeBinary.ADDTEXT(ltxtSentinel);

        lintBars := bxtBarcodeBinary.LENGTH;
        lintLines := ROUND(lintBars * 0.25, 1, '>');

        //precTmpTempBlob.Blob.CREATEOUTSTREAM(loutBmpHeader);
        case BlobNumber of
            1:
                precTmpTempBlob.Blob1.CREATEOUTSTREAM(loutBmpHeader);
            2:
                precTmpTempBlob.Blob2.CREATEOUTSTREAM(loutBmpHeader);
            3:
                precTmpTempBlob.Blob3.CREATEOUTSTREAM(loutBmpHeader);
        end;

        //WRITING HEADER
        fBarcodeCreatorV15CreateBMPHeader(loutBmpHeader, lintBars, lintLines, pintSize, pblnVertical);

        //WRITE BARCODE DETAIL
        fBarcodeCreatorV15CreateBarcodeDetail(lintLines, lintBars, pintSize, pblnVertical, loutBmpHeader);
    end;

    local procedure fBarcodeCreatorV15CreateBMPHeader(var poutBmpHeader: OutStream; pintCols: Integer; pintRows: Integer; pintSize: Integer; pblnVertical: Boolean);
    var
        charInf: Char;
        lintResolution: Integer;
        lintWidth: Integer;
        lintHeight: Integer;
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        lintResolution := ROUND(2835 / pintSize, 1, '=');

        if pblnVertical then begin
            lintWidth := pintRows * pintSize;
            lintHeight := pintCols;
        end else begin
            lintWidth := pintCols * pintSize;
            lintHeight := pintRows * pintSize;
        end;

        charInf := 'B';
        poutBmpHeader.WRITE(charInf, 1);
        charInf := 'M';
        poutBmpHeader.WRITE(charInf, 1);
        poutBmpHeader.WRITE(54 + pintRows * pintCols * 3, 4); //SIZE BMP
        poutBmpHeader.WRITE(0, 4); //APPLICATION SPECIFIC
        poutBmpHeader.WRITE(54, 4); //OFFSET DATA PIXELS
        poutBmpHeader.WRITE(40, 4); //NUMBER OF BYTES IN HEADER FROM THIS POINT
        poutBmpHeader.WRITE(lintWidth, 4); //WIDTH PIXEL
        poutBmpHeader.WRITE(lintHeight, 4); //HEIGHT PIXEL
        poutBmpHeader.WRITE(65536 * 24 + 1, 4); //COLOR DEPTH
        poutBmpHeader.WRITE(0, 4); //NO. OF COLOR PANES & BITS PER PIXEL
        poutBmpHeader.WRITE(0, 4); //SIZE BMP DATA
        poutBmpHeader.WRITE(lintResolution, 4); //HORIZONTAL RESOLUTION
        poutBmpHeader.WRITE(lintResolution, 4); //VERTICAL RESOLUTION
        poutBmpHeader.WRITE(0, 4); //NO. OF COLORS IN PALETTE
        poutBmpHeader.WRITE(0, 4); //IMPORTANT COLORS
    end;

    local procedure fBarcodeCreatorV15CreateBarcodeDetail(pintLines: Integer; pintBars: Integer; pintSize: Integer; pblnVertical: Boolean; var poutBmpHeader: OutStream);
    var
        lintLineLoop: Integer;
        lintBarLoop: Integer;
        ltxtByte: Text[1];
        lchar: Char;
        lintChainFiller: Integer;
        lintSize: Integer;
        lintCount: Integer;
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        if pblnVertical then begin
            for lintBarLoop := 1 to (bxtBarcodeBinary.LENGTH) do begin

                for lintLineLoop := 1 to (pintLines * pintSize) do begin
                    bxtBarcodeBinary.GETSUBTEXT(ltxtByte, lintBarLoop, 1);

                    if ltxtByte = '1' then
                        lchar := 0
                    else
                        lchar := 255;

                    poutBmpHeader.WRITE(lchar, 1);
                    poutBmpHeader.WRITE(lchar, 1);
                    poutBmpHeader.WRITE(lchar, 1);
                end;

                for lintChainFiller := 1 to (lintLineLoop mod 4) do begin
                    //Adding 0 bytes if needed - line end
                    lchar := 0;
                    poutBmpHeader.WRITE(lchar, 1);
                end;
            end;
        end else begin
            for lintLineLoop := 1 to pintLines * pintSize do begin
                for lintBarLoop := 1 to bxtBarcodeBinary.LENGTH do begin
                    bxtBarcodeBinary.GETSUBTEXT(ltxtByte, lintBarLoop, 1);

                    if ltxtByte = '1' then
                        lchar := 0
                    else
                        lchar := 255;

                    for lintSize := 1 to pintSize do begin
                        //Putting Pixel: Black or White
                        poutBmpHeader.WRITE(lchar, 1);
                        poutBmpHeader.WRITE(lchar, 1);
                        poutBmpHeader.WRITE(lchar, 1);
                    end
                end;

                for lintChainFiller := 1 to ((lintBarLoop * pintSize) mod 4) do begin
                    //Adding 0 bytes if needed - line end
                    lchar := 0;
                    poutBmpHeader.WRITE(lchar, 1);
                end;
            end;
        end
    end;

    local procedure fBarcodeCreatorV15InitEAN813(var ptxtParEnc: array[10] of Text[6]; var ptxtSetEnc: array[10, 10] of Text[7]);
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        //INIT CONSTANTS
        //0
        ptxtParEnc[1] := 'OOOOOO';
        //1
        ptxtParEnc[2] := 'OOEOEE';
        //2
        ptxtParEnc[3] := 'OOEEOE';
        //3
        ptxtParEnc[4] := 'OOEEEO';
        //4
        ptxtParEnc[5] := 'OEOOEE';
        //5
        ptxtParEnc[6] := 'OEEOOE';
        //6
        ptxtParEnc[7] := 'OEEEOO';
        //7
        ptxtParEnc[8] := 'OEOEOE';
        //8
        ptxtParEnc[9] := 'OEOEEO';
        //9
        ptxtParEnc[10] := 'OEEOEO';

        //0
        ptxtSetEnc[1] [1] := '0001101';
        ptxtSetEnc[1] [2] := '0100111';
        ptxtSetEnc[1] [3] := '1110010';
        //1
        ptxtSetEnc[2] [1] := '0011001';
        ptxtSetEnc[2] [2] := '0110011';
        ptxtSetEnc[2] [3] := '1100110';
        //2
        ptxtSetEnc[3] [1] := '0010011';
        ptxtSetEnc[3] [2] := '0011011';
        ptxtSetEnc[3] [3] := '1101100';
        //3
        ptxtSetEnc[4] [1] := '0111101';
        ptxtSetEnc[4] [2] := '0100001';
        ptxtSetEnc[4] [3] := '1000010';
        //4
        ptxtSetEnc[5] [1] := '0100011';
        ptxtSetEnc[5] [2] := '0011101';
        ptxtSetEnc[5] [3] := '1011100';
        //5
        ptxtSetEnc[6] [1] := '0110001';
        ptxtSetEnc[6] [2] := '0111001';
        ptxtSetEnc[6] [3] := '1001110';
        //6
        ptxtSetEnc[7] [1] := '0101111';
        ptxtSetEnc[7] [2] := '0000101';
        ptxtSetEnc[7] [3] := '1010000';
        //7
        ptxtSetEnc[8] [1] := '0111011';
        ptxtSetEnc[8] [2] := '0010001';
        ptxtSetEnc[8] [3] := '1000100';
        //8
        ptxtSetEnc[9] [1] := '0110111';
        ptxtSetEnc[9] [2] := '0001001';
        ptxtSetEnc[9] [3] := '1001000';
        //9
        ptxtSetEnc[10] [1] := '0001011';
        ptxtSetEnc[10] [2] := '0010111';
        ptxtSetEnc[10] [3] := '1110100';
    end;

    local procedure fBarcodeCreatorV15InitCode128(var pvRecTMPCode: Record "Service Item" temporary);
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        if not pvRecTMPCode.ISTEMPORARY then
            ERROR('lrecTmpCode moet een tijdelijke tabel zijn');

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := ' ';
        pvRecTMPCode."Serial No." := ' ';
        pvRecTMPCode."Customer No." := ' ';
        pvRecTMPCode."Service Item Group Code" := '00';
        pvRecTMPCode."Item No." := '11011001100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '!';
        pvRecTMPCode."Serial No." := '!';
        pvRecTMPCode."Customer No." := '01';
        pvRecTMPCode."Service Item Group Code" := '01';
        pvRecTMPCode."Item No." := '11001101100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '"';
        pvRecTMPCode."Serial No." := '"';
        pvRecTMPCode."Customer No." := '02';
        pvRecTMPCode."Service Item Group Code" := '02';
        pvRecTMPCode."Item No." := '11001100110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '#';
        pvRecTMPCode."Serial No." := '#';
        pvRecTMPCode."Customer No." := '03';
        pvRecTMPCode."Service Item Group Code" := '03';
        pvRecTMPCode."Item No." := '10010011000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '$';
        pvRecTMPCode."Serial No." := '$';
        pvRecTMPCode."Customer No." := '04';
        pvRecTMPCode."Service Item Group Code" := '04';
        pvRecTMPCode."Item No." := '10010001100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '%';
        pvRecTMPCode."Serial No." := '%';
        pvRecTMPCode."Customer No." := '05';
        pvRecTMPCode."Service Item Group Code" := '05';
        pvRecTMPCode."Item No." := '10001001100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '&';
        pvRecTMPCode."Serial No." := '&';
        pvRecTMPCode."Customer No." := '06';
        pvRecTMPCode."Service Item Group Code" := '06';
        pvRecTMPCode."Item No." := '10011001000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '''';
        pvRecTMPCode."Serial No." := '''';
        pvRecTMPCode."Customer No." := '07';
        pvRecTMPCode."Service Item Group Code" := '07';
        pvRecTMPCode."Item No." := '10011000100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '(';
        pvRecTMPCode."Serial No." := '(';
        pvRecTMPCode."Customer No." := '08';
        pvRecTMPCode."Service Item Group Code" := '08';
        pvRecTMPCode."Item No." := '10001100100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := ')';
        pvRecTMPCode."Serial No." := ')';
        pvRecTMPCode."Customer No." := '09';
        pvRecTMPCode."Service Item Group Code" := '09';
        pvRecTMPCode."Item No." := '11001001000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '*';
        pvRecTMPCode."Serial No." := '*';
        pvRecTMPCode."Customer No." := '10';
        pvRecTMPCode."Service Item Group Code" := '10';
        pvRecTMPCode."Item No." := '11001000100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '+';
        pvRecTMPCode."Serial No." := '+';
        pvRecTMPCode."Customer No." := '11';
        pvRecTMPCode."Service Item Group Code" := '11';
        pvRecTMPCode."Item No." := '11000100100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := ',';
        pvRecTMPCode."Serial No." := ',';
        pvRecTMPCode."Customer No." := '12';
        pvRecTMPCode."Service Item Group Code" := '12';
        pvRecTMPCode."Item No." := '10110011100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '-';
        pvRecTMPCode."Serial No." := '-';
        pvRecTMPCode."Customer No." := '13';
        pvRecTMPCode."Service Item Group Code" := '13';
        pvRecTMPCode."Item No." := '10011011100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '.';
        pvRecTMPCode."Serial No." := '.';
        pvRecTMPCode."Customer No." := '14';
        pvRecTMPCode."Service Item Group Code" := '14';
        pvRecTMPCode."Item No." := '10011001110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '/';
        pvRecTMPCode."Serial No." := '/';
        pvRecTMPCode."Customer No." := '15';
        pvRecTMPCode."Service Item Group Code" := '15';
        pvRecTMPCode."Item No." := '10111001100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '0';
        pvRecTMPCode."Serial No." := '0';
        pvRecTMPCode."Customer No." := '16';
        pvRecTMPCode."Service Item Group Code" := '16';
        pvRecTMPCode."Item No." := '10011101100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '1';
        pvRecTMPCode."Serial No." := '1';
        pvRecTMPCode."Customer No." := '17';
        pvRecTMPCode."Service Item Group Code" := '17';
        pvRecTMPCode."Item No." := '10011100110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '2';
        pvRecTMPCode."Serial No." := '2';
        pvRecTMPCode."Customer No." := '18';
        pvRecTMPCode."Service Item Group Code" := '18';
        pvRecTMPCode."Item No." := '11001110010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '3';
        pvRecTMPCode."Serial No." := '3';
        pvRecTMPCode."Customer No." := '19';
        pvRecTMPCode."Service Item Group Code" := '19';
        pvRecTMPCode."Item No." := '11001011100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '4';
        pvRecTMPCode."Serial No." := '4';
        pvRecTMPCode."Customer No." := '20';
        pvRecTMPCode."Service Item Group Code" := '20';
        pvRecTMPCode."Item No." := '11001001110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '5';
        pvRecTMPCode."Serial No." := '5';
        pvRecTMPCode."Customer No." := '21';
        pvRecTMPCode."Service Item Group Code" := '21';
        pvRecTMPCode."Item No." := '11011100100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '6';
        pvRecTMPCode."Serial No." := '6';
        pvRecTMPCode."Customer No." := '22';
        pvRecTMPCode."Service Item Group Code" := '22';
        pvRecTMPCode."Item No." := '11001110100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '7';
        pvRecTMPCode."Serial No." := '7';
        pvRecTMPCode."Customer No." := '23';
        pvRecTMPCode."Service Item Group Code" := '23';
        pvRecTMPCode."Item No." := '11101101110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '8';
        pvRecTMPCode."Serial No." := '8';
        pvRecTMPCode."Customer No." := '24';
        pvRecTMPCode."Service Item Group Code" := '24';
        pvRecTMPCode."Item No." := '11101001100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '9';
        pvRecTMPCode."Serial No." := '9';
        pvRecTMPCode."Customer No." := '25';
        pvRecTMPCode."Service Item Group Code" := '25';
        pvRecTMPCode."Item No." := '11100101100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := ':';
        pvRecTMPCode."Serial No." := ':';
        pvRecTMPCode."Customer No." := '26';
        pvRecTMPCode."Service Item Group Code" := '26';
        pvRecTMPCode."Item No." := '11100100110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := ';';
        pvRecTMPCode."Serial No." := ';';
        pvRecTMPCode."Customer No." := '27';
        pvRecTMPCode."Service Item Group Code" := '27';
        pvRecTMPCode."Item No." := '11101100100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '<';
        pvRecTMPCode."Serial No." := '<';
        pvRecTMPCode."Customer No." := '28';
        pvRecTMPCode."Service Item Group Code" := '28';
        pvRecTMPCode."Item No." := '11100110100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '=';
        pvRecTMPCode."Serial No." := '=';
        pvRecTMPCode."Customer No." := '29';
        pvRecTMPCode."Service Item Group Code" := '29';
        pvRecTMPCode."Item No." := '11100110010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '>';
        pvRecTMPCode."Serial No." := '>';
        pvRecTMPCode."Customer No." := '30';
        pvRecTMPCode."Service Item Group Code" := '30';
        pvRecTMPCode."Item No." := '11011011000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '?';
        pvRecTMPCode."Serial No." := '?';
        pvRecTMPCode."Customer No." := '31';
        pvRecTMPCode."Service Item Group Code" := '31';
        pvRecTMPCode."Item No." := '11011000110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '@';
        pvRecTMPCode."Serial No." := '@';
        pvRecTMPCode."Customer No." := '32';
        pvRecTMPCode."Service Item Group Code" := '32';
        pvRecTMPCode."Item No." := '11000110110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'A';
        pvRecTMPCode."Serial No." := 'A';
        pvRecTMPCode."Customer No." := '33';
        pvRecTMPCode."Service Item Group Code" := '33';
        pvRecTMPCode."Item No." := '10100011000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'B';
        pvRecTMPCode."Serial No." := 'B';
        pvRecTMPCode."Customer No." := '34';
        pvRecTMPCode."Service Item Group Code" := '34';
        pvRecTMPCode."Item No." := '10001011000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'C';
        pvRecTMPCode."Serial No." := 'C';
        pvRecTMPCode."Customer No." := '35';
        pvRecTMPCode."Service Item Group Code" := '35';
        pvRecTMPCode."Item No." := '10001000110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'D';
        pvRecTMPCode."Serial No." := 'D';
        pvRecTMPCode."Customer No." := '36';
        pvRecTMPCode."Service Item Group Code" := '36';
        pvRecTMPCode."Item No." := '10110001000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'E';
        pvRecTMPCode."Serial No." := 'E';
        pvRecTMPCode."Customer No." := '37';
        pvRecTMPCode."Service Item Group Code" := '37';
        pvRecTMPCode."Item No." := '10001101000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'F';
        pvRecTMPCode."Serial No." := 'F';
        pvRecTMPCode."Customer No." := '38';
        pvRecTMPCode."Service Item Group Code" := '38';
        pvRecTMPCode."Item No." := '10001100010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'G';
        pvRecTMPCode."Serial No." := 'G';
        pvRecTMPCode."Customer No." := '39';
        pvRecTMPCode."Service Item Group Code" := '39';
        pvRecTMPCode."Item No." := '11010001000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'H';
        pvRecTMPCode."Serial No." := 'H';
        pvRecTMPCode."Customer No." := '40';
        pvRecTMPCode."Service Item Group Code" := '40';
        pvRecTMPCode."Item No." := '11000101000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'I';
        pvRecTMPCode."Serial No." := 'I';
        pvRecTMPCode."Customer No." := '41';
        pvRecTMPCode."Service Item Group Code" := '41';
        pvRecTMPCode."Item No." := '11000100010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'J';
        pvRecTMPCode."Serial No." := 'J';
        pvRecTMPCode."Customer No." := '42';
        pvRecTMPCode."Service Item Group Code" := '42';
        pvRecTMPCode."Item No." := '10110111000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'K';
        pvRecTMPCode."Serial No." := 'K';
        pvRecTMPCode."Customer No." := '43';
        pvRecTMPCode."Service Item Group Code" := '43';
        pvRecTMPCode."Item No." := '10110001110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'L';
        pvRecTMPCode."Serial No." := 'L';
        pvRecTMPCode."Customer No." := '44';
        pvRecTMPCode."Service Item Group Code" := '44';
        pvRecTMPCode."Item No." := '10001101110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'M';
        pvRecTMPCode."Serial No." := 'M';
        pvRecTMPCode."Customer No." := '45';
        pvRecTMPCode."Service Item Group Code" := '45';
        pvRecTMPCode."Item No." := '10111011000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'N';
        pvRecTMPCode."Serial No." := 'N';
        pvRecTMPCode."Customer No." := '46';
        pvRecTMPCode."Service Item Group Code" := '46';
        pvRecTMPCode."Item No." := '10111000110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'O';
        pvRecTMPCode."Serial No." := 'O';
        pvRecTMPCode."Customer No." := '47';
        pvRecTMPCode."Service Item Group Code" := '47';
        pvRecTMPCode."Item No." := '10001110110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'P';
        pvRecTMPCode."Serial No." := 'P';
        pvRecTMPCode."Customer No." := '48';
        pvRecTMPCode."Service Item Group Code" := '48';
        pvRecTMPCode."Item No." := '11101110110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'Q';
        pvRecTMPCode."Serial No." := 'Q';
        pvRecTMPCode."Customer No." := '49';
        pvRecTMPCode."Service Item Group Code" := '49';
        pvRecTMPCode."Item No." := '11010001110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'R';
        pvRecTMPCode."Serial No." := 'R';
        pvRecTMPCode."Customer No." := '50';
        pvRecTMPCode."Service Item Group Code" := '50';
        pvRecTMPCode."Item No." := '11000101110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'S';
        pvRecTMPCode."Serial No." := 'S';
        pvRecTMPCode."Customer No." := '51';
        pvRecTMPCode."Service Item Group Code" := '51';
        pvRecTMPCode."Item No." := '11011101000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'T';
        pvRecTMPCode."Serial No." := 'T';
        pvRecTMPCode."Customer No." := '52';
        pvRecTMPCode."Service Item Group Code" := '52';
        pvRecTMPCode."Item No." := '11011100010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'U';
        pvRecTMPCode."Serial No." := 'U';
        pvRecTMPCode."Customer No." := '53';
        pvRecTMPCode."Service Item Group Code" := '53';
        pvRecTMPCode."Item No." := '11011101110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'V';
        pvRecTMPCode."Serial No." := 'V';
        pvRecTMPCode."Customer No." := '54';
        pvRecTMPCode."Service Item Group Code" := '54';
        pvRecTMPCode."Item No." := '11101011000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'W';
        pvRecTMPCode."Serial No." := 'W';
        pvRecTMPCode."Customer No." := '55';
        pvRecTMPCode."Service Item Group Code" := '55';
        pvRecTMPCode."Item No." := '11101000110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'X';
        pvRecTMPCode."Serial No." := 'X';
        pvRecTMPCode."Customer No." := '56';
        pvRecTMPCode."Service Item Group Code" := '56';
        pvRecTMPCode."Item No." := '11100010110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'Y';
        pvRecTMPCode."Serial No." := 'Y';
        pvRecTMPCode."Customer No." := '57';
        pvRecTMPCode."Service Item Group Code" := '57';
        pvRecTMPCode."Item No." := '11101101000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'Z';
        pvRecTMPCode."Serial No." := 'Z';
        pvRecTMPCode."Customer No." := '58';
        pvRecTMPCode."Service Item Group Code" := '58';
        pvRecTMPCode."Item No." := '11101100010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '[';
        pvRecTMPCode."Serial No." := '[';
        pvRecTMPCode."Customer No." := '59';
        pvRecTMPCode."Service Item Group Code" := '59';
        pvRecTMPCode."Item No." := '11100011010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '\';
        pvRecTMPCode."Serial No." := '\';
        pvRecTMPCode."Customer No." := '60';
        pvRecTMPCode."Service Item Group Code" := '60';
        pvRecTMPCode."Item No." := '11101111010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := ']';
        pvRecTMPCode."Serial No." := ']';
        pvRecTMPCode."Customer No." := '61';
        pvRecTMPCode."Service Item Group Code" := '61';
        pvRecTMPCode."Item No." := '11001000010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '^';
        pvRecTMPCode."Serial No." := '^';
        pvRecTMPCode."Customer No." := '62';
        pvRecTMPCode."Service Item Group Code" := '62';
        pvRecTMPCode."Item No." := '11110001010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '_';
        pvRecTMPCode."Serial No." := '_';
        pvRecTMPCode."Customer No." := '63';
        pvRecTMPCode."Service Item Group Code" := '63';
        pvRecTMPCode."Item No." := '10100110000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'NUL';
        pvRecTMPCode."Serial No." := '`';
        pvRecTMPCode."Customer No." := '64';
        pvRecTMPCode."Service Item Group Code" := '64';
        pvRecTMPCode."Item No." := '10100001100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'SOH';
        pvRecTMPCode."Serial No." := 'a';
        pvRecTMPCode."Customer No." := '65';
        pvRecTMPCode."Service Item Group Code" := '65';
        pvRecTMPCode."Item No." := '10010110000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'STX';
        pvRecTMPCode."Serial No." := 'b';
        pvRecTMPCode."Customer No." := '66';
        pvRecTMPCode."Service Item Group Code" := '66';
        pvRecTMPCode."Item No." := '10010000110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'ETX';
        pvRecTMPCode."Serial No." := 'c';
        pvRecTMPCode."Customer No." := '67';
        pvRecTMPCode."Service Item Group Code" := '67';
        pvRecTMPCode."Item No." := '10000101100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'EOT';
        pvRecTMPCode."Serial No." := 'd';
        pvRecTMPCode."Customer No." := '68';
        pvRecTMPCode."Service Item Group Code" := '68';
        pvRecTMPCode."Item No." := '10000100110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'ENQ';
        pvRecTMPCode."Serial No." := 'e';
        pvRecTMPCode."Customer No." := '69';
        pvRecTMPCode."Service Item Group Code" := '69';
        pvRecTMPCode."Item No." := '10110010000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'ACK';
        pvRecTMPCode."Serial No." := 'f';
        pvRecTMPCode."Customer No." := '70';
        pvRecTMPCode."Service Item Group Code" := '70';
        pvRecTMPCode."Item No." := '10110000100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'BEL';
        pvRecTMPCode."Serial No." := 'g';
        pvRecTMPCode."Customer No." := '71';
        pvRecTMPCode."Service Item Group Code" := '71';
        pvRecTMPCode."Item No." := '10011010000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'BS';
        pvRecTMPCode."Serial No." := 'h';
        pvRecTMPCode."Customer No." := '72';
        pvRecTMPCode."Service Item Group Code" := '72';
        pvRecTMPCode."Item No." := '10011000010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'HT';
        pvRecTMPCode."Serial No." := 'i';
        pvRecTMPCode."Customer No." := '73';
        pvRecTMPCode."Service Item Group Code" := '73';
        pvRecTMPCode."Item No." := '10000110100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'LF';
        pvRecTMPCode."Serial No." := 'j';
        pvRecTMPCode."Customer No." := '74';
        pvRecTMPCode."Service Item Group Code" := '74';
        pvRecTMPCode."Item No." := '10000110010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'VT';
        pvRecTMPCode."Serial No." := 'k';
        pvRecTMPCode."Customer No." := '75';
        pvRecTMPCode."Service Item Group Code" := '75';
        pvRecTMPCode."Item No." := '11000010010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'FF';
        pvRecTMPCode."Serial No." := 'l';
        pvRecTMPCode."Customer No." := '76';
        pvRecTMPCode."Service Item Group Code" := '76';
        pvRecTMPCode."Item No." := '11001010000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'CR';
        pvRecTMPCode."Serial No." := 'm';
        pvRecTMPCode."Customer No." := '77';
        pvRecTMPCode."Service Item Group Code" := '77';
        pvRecTMPCode."Item No." := '11110111010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'SO';
        pvRecTMPCode."Serial No." := 'n';
        pvRecTMPCode."Customer No." := '78';
        pvRecTMPCode."Service Item Group Code" := '78';
        pvRecTMPCode."Item No." := '11000010100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'SI';
        pvRecTMPCode."Serial No." := 'o';
        pvRecTMPCode."Customer No." := '79';
        pvRecTMPCode."Service Item Group Code" := '79';
        pvRecTMPCode."Item No." := '10001111010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'DLE';
        pvRecTMPCode."Serial No." := 'p';
        pvRecTMPCode."Customer No." := '80';
        pvRecTMPCode."Service Item Group Code" := '80';
        pvRecTMPCode."Item No." := '10100111100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'DC1';
        pvRecTMPCode."Serial No." := 'q';
        pvRecTMPCode."Customer No." := '81';
        pvRecTMPCode."Service Item Group Code" := '81';
        pvRecTMPCode."Item No." := '10010111100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'DC2';
        pvRecTMPCode."Serial No." := 'r';
        pvRecTMPCode."Customer No." := '82';
        pvRecTMPCode."Service Item Group Code" := '82';
        pvRecTMPCode."Item No." := '10010011110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'DC3';
        pvRecTMPCode."Serial No." := 's';
        pvRecTMPCode."Customer No." := '83';
        pvRecTMPCode."Service Item Group Code" := '83';
        pvRecTMPCode."Item No." := '10111100100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'DC4';
        pvRecTMPCode."Serial No." := 't';
        pvRecTMPCode."Customer No." := '84';
        pvRecTMPCode."Service Item Group Code" := '84';
        pvRecTMPCode."Item No." := '10011110100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'NAK';
        pvRecTMPCode."Serial No." := 'u';
        pvRecTMPCode."Customer No." := '85';
        pvRecTMPCode."Service Item Group Code" := '85';
        pvRecTMPCode."Item No." := '10011110010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'SYN';
        pvRecTMPCode."Serial No." := 'v';
        pvRecTMPCode."Customer No." := '86';
        pvRecTMPCode."Service Item Group Code" := '86';
        pvRecTMPCode."Item No." := '11110100100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'ETB';
        pvRecTMPCode."Serial No." := 'w';
        pvRecTMPCode."Customer No." := '87';
        pvRecTMPCode."Service Item Group Code" := '87';
        pvRecTMPCode."Item No." := '11110010100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'CAN';
        pvRecTMPCode."Serial No." := 'x';
        pvRecTMPCode."Customer No." := '88';
        pvRecTMPCode."Service Item Group Code" := '88';
        pvRecTMPCode."Item No." := '11110010010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'EM';
        pvRecTMPCode."Serial No." := 'y';
        pvRecTMPCode."Customer No." := '89';
        pvRecTMPCode."Service Item Group Code" := '89';
        pvRecTMPCode."Item No." := '11011011110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'SUB';
        pvRecTMPCode."Serial No." := 'z';
        pvRecTMPCode."Customer No." := '90';
        pvRecTMPCode."Service Item Group Code" := '90';
        pvRecTMPCode."Item No." := '11011110110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'ESC';
        pvRecTMPCode."Serial No." := '{';
        pvRecTMPCode."Customer No." := '91';
        pvRecTMPCode."Service Item Group Code" := '91';
        pvRecTMPCode."Item No." := '11110110110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'FS';
        pvRecTMPCode."Serial No." := '|';
        pvRecTMPCode."Customer No." := '92';
        pvRecTMPCode."Service Item Group Code" := '92';
        pvRecTMPCode."Item No." := '10101111000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'GS';
        pvRecTMPCode."Serial No." := '}';
        pvRecTMPCode."Customer No." := '93';
        pvRecTMPCode."Service Item Group Code" := '93';
        pvRecTMPCode."Item No." := '10100011110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'RS';
        pvRecTMPCode."Serial No." := '~';
        pvRecTMPCode."Customer No." := '94';
        pvRecTMPCode."Service Item Group Code" := '94';
        pvRecTMPCode."Item No." := '10001011110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'US';
        pvRecTMPCode."Serial No." := 'DEL';
        pvRecTMPCode."Customer No." := '95';
        pvRecTMPCode."Service Item Group Code" := '95';
        pvRecTMPCode."Item No." := '10111101000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'FNC3';
        pvRecTMPCode."Serial No." := 'FNC3';
        pvRecTMPCode."Customer No." := '96';
        pvRecTMPCode."Service Item Group Code" := '96';
        pvRecTMPCode."Item No." := '10111100010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'FNC2';
        pvRecTMPCode."Serial No." := 'FNC2';
        pvRecTMPCode."Customer No." := '97';
        pvRecTMPCode."Service Item Group Code" := '97';
        pvRecTMPCode."Item No." := '11110101000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'SHIFT';
        pvRecTMPCode."Serial No." := 'SHIFT';
        pvRecTMPCode."Customer No." := '98';
        pvRecTMPCode."Service Item Group Code" := '98';
        pvRecTMPCode."Item No." := '11110100010';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'CODEC';
        pvRecTMPCode."Serial No." := 'CODEC';
        pvRecTMPCode."Customer No." := '99';
        pvRecTMPCode."Service Item Group Code" := '99';
        pvRecTMPCode."Item No." := '10111011110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'CODEB';
        pvRecTMPCode."Serial No." := 'FNC4';
        pvRecTMPCode."Customer No." := 'CODEB';
        pvRecTMPCode."Service Item Group Code" := '100';
        pvRecTMPCode."Item No." := '10111101110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'FNC4';
        pvRecTMPCode."Serial No." := 'CODEA';
        pvRecTMPCode."Customer No." := 'CODEA';
        pvRecTMPCode."Service Item Group Code" := '101';
        pvRecTMPCode."Item No." := '11101011110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'FNC1';
        pvRecTMPCode."Serial No." := 'FNC1';
        pvRecTMPCode."Customer No." := 'FNC1';
        pvRecTMPCode."Service Item Group Code" := '102';
        pvRecTMPCode."Item No." := '11110101110';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'STARTA';
        pvRecTMPCode."Serial No." := 'STARTA';
        pvRecTMPCode."Customer No." := 'STARTA';
        pvRecTMPCode."Service Item Group Code" := '103';
        pvRecTMPCode."Item No." := '11010000100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'STARTB';
        pvRecTMPCode."Serial No." := 'STARTB';
        pvRecTMPCode."Customer No." := 'STARTB';
        pvRecTMPCode."Service Item Group Code" := '104';
        pvRecTMPCode."Item No." := '11010010000';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'STARTC';
        pvRecTMPCode."Serial No." := 'STARTC';
        pvRecTMPCode."Customer No." := 'STARTC';
        pvRecTMPCode."Service Item Group Code" := '105';
        pvRecTMPCode."Item No." := '11010011100';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'STOP';
        pvRecTMPCode."Serial No." := 'STOP';
        pvRecTMPCode."Customer No." := 'STOP';
        pvRecTMPCode."Service Item Group Code" := '';
        pvRecTMPCode."Item No." := '11000111010';
        pvRecTMPCode.INSERT;
    end;

    local procedure fBarcodeCreatorV15InitCode39(var pvRecTMPCode: Record "Service Item" temporary);
    begin

        // mibuso.com/downloads/ean-8-13-code-39-128-barcode-creator-v1.5
        // EAN 8/13 Code 39/128 Barcode Creator v1.5

        if not pvRecTMPCode.ISTEMPORARY then
            ERROR('lrecTmpCode moet een tijdelijke tabel zijn');

        //THIS IS NOT THE EXTENDED CODE 39 ENCODING TABLE!

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '0';
        pvRecTMPCode."Service Item Group Code" := '0';
        pvRecTMPCode."Item No." := '101001101101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '1';
        pvRecTMPCode."Service Item Group Code" := '1';
        pvRecTMPCode."Item No." := '110100101011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '2';
        pvRecTMPCode."Service Item Group Code" := '2';
        pvRecTMPCode."Item No." := '101100101011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '3';
        pvRecTMPCode."Service Item Group Code" := '3';
        pvRecTMPCode."Item No." := '110110010101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '4';
        pvRecTMPCode."Service Item Group Code" := '4';
        pvRecTMPCode."Item No." := '101001101011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '5';
        pvRecTMPCode."Service Item Group Code" := '5';
        pvRecTMPCode."Item No." := '110100110101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '6';
        pvRecTMPCode."Service Item Group Code" := '6';
        pvRecTMPCode."Item No." := '101100110101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '7';
        pvRecTMPCode."Service Item Group Code" := '7';
        pvRecTMPCode."Item No." := '101001011011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '8';
        pvRecTMPCode."Service Item Group Code" := '8';
        pvRecTMPCode."Item No." := '110100101101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '9';
        pvRecTMPCode."Service Item Group Code" := '9';
        pvRecTMPCode."Item No." := '101100101101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'A';
        pvRecTMPCode."Service Item Group Code" := '10';
        pvRecTMPCode."Item No." := '110101001011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'B';
        pvRecTMPCode."Service Item Group Code" := '11';
        pvRecTMPCode."Item No." := '101101001011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'C';
        pvRecTMPCode."Service Item Group Code" := '12';
        pvRecTMPCode."Item No." := '110110100101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'D';
        pvRecTMPCode."Service Item Group Code" := '13';
        pvRecTMPCode."Item No." := '101011001011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'E';
        pvRecTMPCode."Service Item Group Code" := '14';
        pvRecTMPCode."Item No." := '110101100101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'F';
        pvRecTMPCode."Service Item Group Code" := '15';
        pvRecTMPCode."Item No." := '101101100101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'G';
        pvRecTMPCode."Service Item Group Code" := '16';
        pvRecTMPCode."Item No." := '101010011011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'H';
        pvRecTMPCode."Service Item Group Code" := '17';
        pvRecTMPCode."Item No." := '110101001101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'I';
        pvRecTMPCode."Service Item Group Code" := '18';
        pvRecTMPCode."Item No." := '101101001101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'J';
        pvRecTMPCode."Service Item Group Code" := '19';
        pvRecTMPCode."Item No." := '101011001101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'K';
        pvRecTMPCode."Service Item Group Code" := '20';
        pvRecTMPCode."Item No." := '110101010011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'L';
        pvRecTMPCode."Service Item Group Code" := '21';
        pvRecTMPCode."Item No." := '101101010011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'M';
        pvRecTMPCode."Service Item Group Code" := '22';
        pvRecTMPCode."Item No." := '110110101001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'N';
        pvRecTMPCode."Service Item Group Code" := '23';
        pvRecTMPCode."Item No." := '101011010011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'O';
        pvRecTMPCode."Service Item Group Code" := '24';
        pvRecTMPCode."Item No." := '110101101001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'P';
        pvRecTMPCode."Service Item Group Code" := '25';
        pvRecTMPCode."Item No." := '101101101001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'Q';
        pvRecTMPCode."Service Item Group Code" := '26';
        pvRecTMPCode."Item No." := '101010110011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'R';
        pvRecTMPCode."Service Item Group Code" := '27';
        pvRecTMPCode."Item No." := '110101011001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'S';
        pvRecTMPCode."Service Item Group Code" := '28';
        pvRecTMPCode."Item No." := '101101011001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'T';
        pvRecTMPCode."Service Item Group Code" := '29';
        pvRecTMPCode."Item No." := '101011011001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'U';
        pvRecTMPCode."Service Item Group Code" := '30';
        pvRecTMPCode."Item No." := '110010101011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'V';
        pvRecTMPCode."Service Item Group Code" := '31';
        pvRecTMPCode."Item No." := '100110101011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'W';
        pvRecTMPCode."Service Item Group Code" := '32';
        pvRecTMPCode."Item No." := '110011010101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'X';
        pvRecTMPCode."Service Item Group Code" := '33';
        pvRecTMPCode."Item No." := '100101101011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'Y';
        pvRecTMPCode."Service Item Group Code" := '34';
        pvRecTMPCode."Item No." := '110010110101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := 'Z';
        pvRecTMPCode."Service Item Group Code" := '35';
        pvRecTMPCode."Item No." := '100110110101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '-';
        pvRecTMPCode."Service Item Group Code" := '36';
        pvRecTMPCode."Item No." := '100101011011';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '.';
        pvRecTMPCode."Service Item Group Code" := '37';
        pvRecTMPCode."Item No." := '110010101101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := ' ';
        pvRecTMPCode."Service Item Group Code" := '38';
        pvRecTMPCode."Item No." := '100110101101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '$';
        pvRecTMPCode."Service Item Group Code" := '39';
        pvRecTMPCode."Item No." := '100100100101';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '/';
        pvRecTMPCode."Service Item Group Code" := '40';
        pvRecTMPCode."Item No." := '100100101001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '+';
        pvRecTMPCode."Service Item Group Code" := '41';
        pvRecTMPCode."Item No." := '100101001001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '%';
        pvRecTMPCode."Service Item Group Code" := '42';
        pvRecTMPCode."Item No." := '101001001001';
        pvRecTMPCode.INSERT;

        pvRecTMPCode.INIT;
        pvRecTMPCode."No." := '*';
        pvRecTMPCode."Service Item Group Code" := '';
        pvRecTMPCode."Item No." := '100101101101';
        pvRecTMPCode.INSERT;
    end;
}

