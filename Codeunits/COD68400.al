codeunit 68400 "XSS Complaints Mgt."
{
    // version KLA1.00,XSS5.037


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
        gCduComplaintsMgt: Codeunit "XSS Complaints Mgt.";

    procedure fGetStamgegevensCode(pCodeSoort: Code[20]; pCodeCode: Code[20]): Text[30];
    var
        lRecKlachtStamgegevens: Record "XSS Complaint Type";
    begin
        /* fGetStamgegevensCode */

        if lRecKlachtStamgegevens.GET(pCodeSoort, pCodeCode) then
            if (GLOBALLANGUAGE = 1043) then
                exit(lRecKlachtStamgegevens.Code)
            else
                exit(lRecKlachtStamgegevens."Code ENU")
        else
            exit('')

    end;

    procedure fGetStamgegevensOmschrijving(pCodeSoort: Code[20]; pCodeCode: Code[20]): Text[30];
    var
        lRecKlachtStamgegevens: Record "XSS Complaint Type";
    begin
        /* fGetStamgegevensOmschrijving */

        if lRecKlachtStamgegevens.GET(pCodeSoort, pCodeCode) then
            if (GLOBALLANGUAGE = 1043) then
                exit(lRecKlachtStamgegevens.Omschrijving)
            else
                exit(lRecKlachtStamgegevens."Omschrijving ENU")
        else
            exit('')

    end;

    procedure fGetNamen(pCodeSoort: Code[20]; pCodeCode: Code[20]) RetVal: Text[50];
    var
        lRecContact: Record Contact;
        lRecEmployee: Record Employee;
        lRecSalesPurchPerson: Record "Salesperson/Purchaser";
        lRecItem: Record Item;
        lRecServItem: Record "Service Item";
    begin

        RetVal := '';

        case pCodeSoort of
            'RELATIE':
                begin
                    if lRecContact.GET(pCodeCode) then
                        RetVal := lRecContact.Name
                end;
            'MEDEWERKER':
                begin
                    if lRecEmployee.GET(pCodeCode) then
                        RetVal := lRecEmployee.FullName
                end;
            'IN-VERKOPER':
                begin
                    if lRecSalesPurchPerson.GET(pCodeCode) then
                        RetVal := lRecSalesPurchPerson.Name
                end;
            'ARTIKEL':
                begin
                    if lRecItem.GET(pCodeCode) then
                        RetVal := lRecItem.Description;
                end;
            'SERVICEARTIKEL':
                begin
                    if lRecServItem.GET(pCodeCode) then
                        RetVal := lRecServItem.Description;
                end;
        end;
    end;

    procedure fGetStatusOmschrijving(pRecKlacht: Record "XSS Complaint Header"): Text[30];
    var
        lRecKlachtregels: Record "XSS Complaint Line";
    begin
        /* fGetStatusOmschrijving */

        exit(fGetStamgegevensOmschrijving('KLACHTSTATUS', pRecKlacht.Status));

    end;

    procedure fGetContactName(pCodContact: Code[20]): Text[50];
    var
        lRecContact: Record Contact;
    begin
        /* fGetContactName */

        if not lRecContact.GET(pCodContact) then
            lRecContact.INIT;

        exit(lRecContact.Name);

    end;

    procedure fFunctionPrintKlachtDetail(pRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecKlachtkop: Record "XSS Complaint Header";
        lRecXsensSetup: Record "XSENS Setup";
    begin

        lRecKlachtkop := pRecKlachtkop;
        lRecKlachtkop.SETRECFILTER;
        //UPGRADE REPORDT VIA setup

        //DELETED UPGRADE REPORT.RUN(REPORT::Klacht,TRUE,FALSE,lRecKlachtkop);
        //20190916 JVW Adde code for Setup.
        lRecXsensSetup.GET;
        lRecXsensSetup.TESTFIELD("Report No. Complains");
        REPORT.RUN(lRecXsensSetup."Report No. Complains", true, false, lRecKlachtkop);
    end;

    procedure fOpenKlachtKeuzescherm(pCodeKlachtrelatie: Code[20]; pCodeStuknummer: Code[20]; pIntRegelnr: Integer);
    var
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
        lPgeKoppelKeuze: Page "XSS Complaint Documents";
    begin

        CLEAR(lPgeKoppelKeuze);
        lRecKlachtkoppelingen.RESET;
        lRecKlachtkoppelingen.SETRANGE(Documentsoort, pCodeKlachtrelatie);
        lRecKlachtkoppelingen.SETRANGE("Documentnr.", pCodeStuknummer);
        if pIntRegelnr <> 0 then
            lRecKlachtkoppelingen.SETRANGE("Documentregelnr.", pIntRegelnr);
        if lRecKlachtkoppelingen.FINDFIRST then begin
            lPgeKoppelKeuze.SETTABLEVIEW(lRecKlachtkoppelingen);
            lPgeKoppelKeuze.RUNMODAL;
        end else
            MESSAGE('Geen klachten gevonden!');
    end;

    procedure fSetupStamgegeven(pCodCodesoort: Code[20]);
    var
        lRecKlachtstamgegeven: Record "XSS Complaint Type";
    begin
        /* fSetupStamgegeven */

        lRecKlachtstamgegeven.RESET;
        lRecKlachtstamgegeven.SETRANGE(Codesoort, pCodCodesoort);
        if lRecKlachtstamgegeven.FINDSET(false, false) then;

        PAGE.RUNMODAL(0, lRecKlachtstamgegeven);

    end;

    procedure fKKOOnNewRecord(var pvRecKlachtkop: Record "XSS Complaint Header");
    begin

        pvRecKlachtkop.Datum := WORKDATE;
    end;

    procedure fKKOOnDelete(pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecKlachtregels: Record "XSS Complaint Line";
        lRecKlachtopmerkingsregels: Record "XSS Complaint Comment";
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
    begin

        lRecKlachtkoppelingen.RESET;
        lRecKlachtkoppelingen.SETRANGE(Stuknummer, pvRecKlachtkop."Nr.");
        if lRecKlachtkoppelingen.FIND('-') then
            ERROR(Text901802, pvRecKlachtkop."Nr.");

        lRecKlachtregels.RESET;
        lRecKlachtregels.SETRANGE(Stuknummer, pvRecKlachtkop."Nr.");
        if lRecKlachtregels.FINDFIRST then
            lRecKlachtregels.DELETEALL;

        lRecKlachtopmerkingsregels.RESET;
        lRecKlachtopmerkingsregels.SETRANGE(Stuknummer, pvRecKlachtkop."Nr.");
        if lRecKlachtopmerkingsregels.FINDFIRST then
            lRecKlachtopmerkingsregels.DELETEALL;
    end;

    procedure fKKOOnInsert(pxRecKlachtkop: Record "XSS Complaint Header"; var pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lCuNoSeriesMgt: Codeunit NoSeriesManagement;
        lRecXsensSetup: Record "XSENS Setup";
    begin

        if pvRecKlachtkop."Nr." = '' then begin
            lRecXsensSetup.GET;
            lRecXsensSetup.TESTFIELD("Klachtnrs.");
            lCuNoSeriesMgt.InitSeries(lRecXsensSetup."Klachtnrs.",
                                      pxRecKlachtkop."No. Series", 0D,
                                      pvRecKlachtkop."Nr.",
                                      pvRecKlachtkop."No. Series");
        end;
    end;

    procedure fKKONrOnValidate(pxRecKlachtkop: Record "XSS Complaint Header"; var pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lCuNoSeriesMgt: Codeunit NoSeriesManagement;
        lRecXsensSetup: Record "XSENS Setup";
    begin

        if pvRecKlachtkop."Nr." <> pxRecKlachtkop."Nr." then begin
            lRecXsensSetup.GET;
            lCuNoSeriesMgt.TestManual(lRecXsensSetup."Klachtnrs.");
            pvRecKlachtkop."No. Series" := '';
        end;
    end;

    procedure fKKONrAssistEdit(pRecKlachtkop: Record "XSS Complaint Header"; pxRecKlachtkop: Record "XSS Complaint Header"): Boolean;
    var
        lCduNoSeriesMgt: Codeunit NoSeriesManagement;
        lRecXsensSetup: Record "XSENS Setup";
    begin
        /* fKKONrAssistEdit */

        if lRecXsensSetup.GET then;
        lRecXsensSetup.TESTFIELD("Klachtnrs.");
        if lCduNoSeriesMgt.SelectSeries(lRecXsensSetup."Klachtnrs.", pxRecKlachtkop."No. Series", pRecKlachtkop."No. Series") then begin
            lCduNoSeriesMgt.SetSeries(pRecKlachtkop."Nr.");
            exit(true);
        end;

    end;

    procedure fKKOBronnrOnvalidate(pxRecKlachtkop: Record "XSS Complaint Header"; var pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecServItem: Record "Service Item";
    begin
        /* fKKOBronnrOnvalidate */

        if (pvRecKlachtkop."Relatienr." = '') or (pxRecKlachtkop."Relatienr." <> pvRecKlachtkop."Relatienr.") then
            pvRecKlachtkop.VALIDATE("Artikelnr.", '');

    end;

    procedure fKKOAangemeldTypeOnvalidate(pxRecKlachtkop: Record "XSS Complaint Header"; var pvRecKlachtkop: Record "XSS Complaint Header");
    begin

        if pxRecKlachtkop."Aangemeld door Soort" <> pvRecKlachtkop."Aangemeld door Soort" then
            pvRecKlachtkop.VALIDATE("Aangemeld door Nr.", '');
    end;

    procedure fKKOServItemOnLookup(pxRecKlachtkop: Record "XSS Complaint Header"; var pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecServItem: Record "Service Item";
        lCodBronnr: Code[20];
    begin
        /* fKKOServItemOnLookup */

        if (pvRecKlachtkop."Relatienr." = '') then begin
            lRecServItem.RESET;
            if (pvRecKlachtkop."Artikelnr." <> '') then begin
                lRecServItem.SETCURRENTKEY("Item No.", "Serial No.");
                lRecServItem.SETRANGE("Item No.", pvRecKlachtkop."Artikelnr.");
            end;
            if lRecServItem.FINDSET(false, false) then;
        end;

        lCodBronnr := fRelatieReturnCustomerOrVendor(pvRecKlachtkop."Relatienr.", 'K');
        if (lCodBronnr <> '') then begin
            lRecServItem.RESET;
            lRecServItem.SETCURRENTKEY("Customer No.", "Ship-to Code", "Item No.", "Serial No.");
            lRecServItem.SETRANGE("Customer No.", lCodBronnr);
            if (pvRecKlachtkop."Artikelnr." <> '') then
                lRecServItem.SETRANGE("Item No.", pvRecKlachtkop."Artikelnr.");
            if lRecServItem.FINDSET(false, false) then;
        end else begin
            lCodBronnr := fRelatieReturnCustomerOrVendor(pvRecKlachtkop."Relatienr.", 'L');
            lRecServItem.RESET;
            lRecServItem.SETCURRENTKEY("Vendor No.", "Item No.");
            lRecServItem.SETRANGE("Vendor No.", lCodBronnr);
            if (pvRecKlachtkop."Artikelnr." <> '') then
                lRecServItem.SETRANGE("Item No.", pvRecKlachtkop."Artikelnr.");
            if lRecServItem.FINDSET(false, false) then;
        end;

        if PAGE.RUNMODAL(0, lRecServItem) = ACTION::LookupOK then
            pvRecKlachtkop.VALIDATE("Serviceartikelnr.", lRecServItem."No.");

    end;

    procedure fKKOServItemOnValidate(pxRecKlachtkop: Record "XSS Complaint Header"; var pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecServItem: Record "Service Item";
    begin
        /* fKKOServItemOnValidate */

        if (pvRecKlachtkop."Serviceartikelnr." <> '') then begin
            lRecServItem.GET(pvRecKlachtkop."Serviceartikelnr.");
            pvRecKlachtkop.VALIDATE("Artikelnr.", lRecServItem."Item No.");
        end;

    end;

    procedure fKKOItemOnValidate(pxRecKlachtkop: Record "XSS Complaint Header"; var pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecServItem: Record "Service Item";
    begin
        /* fKKOSItemOnValidate */

        if (pvRecKlachtkop."Serviceartikelnr." <> '') then begin
            if lRecServItem.GET(pvRecKlachtkop."Serviceartikelnr.") then begin
                if (pvRecKlachtkop."Artikelnr." <> lRecServItem."Item No.") then
                    pvRecKlachtkop.VALIDATE("Serviceartikelnr.", '');
            end;
        end else
            pvRecKlachtkop.VALIDATE("Serviceartikelnr.", '');

    end;

    procedure fKRGOnValidateStatus(pxRecKlachtregel: Record "XSS Complaint Line"; var pvRecKlachtregel: Record "XSS Complaint Line");
    var
        lRecKlachtregel: Record "XSS Complaint Line";
        lRecKlachtkop: Record "XSS Complaint Header";
        lRecStamgegevens: Record "XSS Complaint Type";
        lCodStatus: Code[20];
        lBoolChange: Boolean;
        lTxtDescription: Text[30];
    begin
        /* fKRGOnValidateStatus */

        // ****************************************************************************************
        // Het systeem zoekt naar de laatste klachtregel om de status van de klacht bij te werken.
        // Indien wel/niet gevonden zal het systeem de klachtregel welke gemuteerd is door de
        // gebruiker vergelijken met de gevonden regel en zo de juiste klachtstatus bepalen.
        // ****************************************************************************************

        if (pvRecKlachtregel.Stuksoort <> pvRecKlachtregel.Stuksoort::"Status historie") then
            exit;  //20100118 GFR 21839
        if (pxRecKlachtregel.Status <> '') and (pvRecKlachtregel.Status = '') then
            ERROR(Text901806);

        if not lRecStamgegevens.GET('KLACHTSTATUS', pxRecKlachtregel.Status) then
            lRecStamgegevens.INIT;

        lTxtDescription := fGetStamgegevensOmschrijving('KLACHTSTATUS', lRecStamgegevens.Code);
        lBoolChange := pxRecKlachtregel.Omschrijving = lTxtDescription;

        if (lBoolChange) then begin
            if not lRecStamgegevens.GET('KLACHTSTATUS', pvRecKlachtregel.Status) then
                lRecStamgegevens.INIT;

            pvRecKlachtregel.Omschrijving := fGetStamgegevensOmschrijving('KLACHTSTATUS', pvRecKlachtregel.Status);
        end;

        lRecKlachtregel.RESET;
        lRecKlachtregel.SETCURRENTKEY(Stuknummer, Stuksoort, Datum, "Regelnr.");
        lRecKlachtregel.SETRANGE(Stuksoort, lRecKlachtregel.Stuksoort::"Status historie");  //20100118 GFR 21839
        lRecKlachtregel.SETRANGE(Stuknummer, pvRecKlachtregel.Stuknummer);
        if not lRecKlachtregel.FINDLAST then
            lRecKlachtregel.INIT;

        lCodStatus := lRecKlachtregel.Status;
        if (pvRecKlachtregel.Datum >= lRecKlachtregel.Datum) and (pvRecKlachtregel."Regelnr." >= lRecKlachtregel."Regelnr.") then
            lCodStatus := pvRecKlachtregel.Status;

        lRecKlachtkop.GET(pvRecKlachtregel.Stuknummer);
        lRecKlachtkop.VALIDATE(Status, lCodStatus);
        lRecKlachtkop.MODIFY(true);

    end;

    procedure fKKPOnNewRecord(var pvRecKlachtkoppeling: Record "Klacht koppelingen");
    var
        lRecKlachtkoppeling: Record "Klacht koppelingen";
        lRecKlachtkop: Record "XSS Complaint Header";
    begin

        //IF lRecKlachtkop.GET(pvRecKlachtkoppeling.Stuknummer) THEN BEGIN
        //  lRecKlachtkoppeling.RESET;
        //  lRecKlachtkoppeling.SETRANGE(Stuknummer,pvRecKlachtkoppeling.Stuknummer);
        //  IF NOT lRecKlachtkoppeling.FINDFIRST THEN BEGIN
        //    pvRecKlachtkoppeling.Bronsoort := lRecKlachtkop."Betrekking op Soort";
        //    pvRecKlachtkoppeling."Bronnr." := lRecKlachtkop."Betrekking op Nr.";
        //  END;
        //END;
    end;

    procedure fKKPOnInsert(pRecKlachtKoppeling: Record "Klacht koppelingen");
    begin

        fKKPCRUDAllowed(pRecKlachtKoppeling);
    end;

    procedure fKKPOnModify(pRecKlachtKoppeling: Record "Klacht koppelingen");
    begin

        fKKPCRUDAllowed(pRecKlachtKoppeling);
    end;

    procedure fKKPOnRename(pRecKlachtKoppeling: Record "Klacht koppelingen");
    begin

        fKKPCRUDAllowed(pRecKlachtKoppeling);
    end;

    procedure fKKPCRUDAllowed(pRecKlachtKoppeling: Record "Klacht koppelingen");
    begin

        if (pRecKlachtKoppeling.Documentsoort <> '') and
           (pRecKlachtKoppeling."Documentnr." = '') then
            ERROR(Text901803)
    end;

    procedure fKKPLookupDocument(var pvRecKlachtKoppeling: Record "Klacht koppelingen"; pBoolHeader: Boolean);
    var
        lRecKlacht: Record "XSS Complaint Header";
    begin
        /* fKKPLookupDocument */

        lRecKlacht.GET(pvRecKlachtKoppeling.Stuknummer);
        case pvRecKlachtKoppeling.Documentsoort of
            'VERKOOPOFFERTE':
                fKKPLookupSalesQuote(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'VERKOOPORDER':
                fKKPLookupSalesOrder(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'VERKOOPLEVERING':
                fKKPLookupSalesShipment(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'VERKOOPFACTUURGB':
                fKKPLookupSalesInvoiceGB(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'VERKOOPCREDITNOTA':
                fKKPLookupSalesCreditMemo(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'VERKOOPCREDITNOTAGB':
                fKKPLookupSalesCreditMemoGB(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'VERKOOPFACTUUR':
                fKKPLookupSalesInvoice(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'INKOOPORDER':
                fKKPLookupPurchaseOrder(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'INKOOPONTVANGST':
                fKKPLookupPurchaseReceipt(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'INKOOPFACTUURGB':
                fKKPLookupPurchaseInvoiceGB(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'INKOOPCREDITNOTA':
                fKKPLookupPurchaseCreditMemo(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'INKOOPCREDITNOTAGB':
                fKKPLookupPurchaseCreditMemoGB(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
            'INKOOPFACTUUR':
                fKKPLookupPurchaseInvoice(pvRecKlachtKoppeling, lRecKlacht, pBoolHeader);
        end;

    end;

    procedure fKKPLookupSalesQuote(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecSalesHeader: Record "Sales Header";
        lRecSalesHeader2: Record "Sales Header";
        lRecSalesLine: Record "Sales Line";
        lCodBronnr: Code[20];
    begin
        /* fKKPLookupSalesQuote */

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'K');

        if pBoolHeader then begin
            lRecSalesHeader.RESET;
            lRecSalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.", "No.");
            lRecSalesHeader.SETRANGE("Document Type", lRecSalesHeader."Document Type"::Quote);
            lRecSalesHeader.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(45, lRecSalesHeader) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecSalesHeader."No.";
        end else begin
            lRecSalesLine.RESET;
            lRecSalesLine.SETRANGE("Document Type", lRecSalesLine."Document Type"::Quote);
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecSalesLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecSalesLine.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(516, lRecSalesLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecSalesLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecSalesLine."Line No.";
            end;
        end;

    end;

    procedure fKKPLookupSalesOrder(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecSalesHeader: Record "Sales Header";
        lRecSalesLine: Record "Sales Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'K');

        if pBoolHeader then begin
            lRecSalesHeader.RESET;
            lRecSalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.", "No.");
            lRecSalesHeader.SETRANGE("Document Type", lRecSalesHeader."Document Type"::Order);
            lRecSalesHeader.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(45, lRecSalesHeader) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecSalesHeader."No.";
        end else begin
            lRecSalesLine.RESET;
            lRecSalesLine.SETRANGE("Document Type", lRecSalesLine."Document Type"::Order);
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecSalesLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecSalesLine.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(516, lRecSalesLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecSalesLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecSalesLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupSalesShipment(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecSalesShipment: Record "Sales Shipment Header";
        lRecSalesShipmentLine: Record "Sales Shipment Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'K');

        if pBoolHeader then begin
            lRecSalesShipment.RESET;
            lRecSalesShipment.SETCURRENTKEY("Sell-to Customer No.", "No.");
            lRecSalesShipment.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(142, lRecSalesShipment) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecSalesShipment."No.";
        end else begin
            lRecSalesShipmentLine.RESET;
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecSalesShipmentLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecSalesShipmentLine.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(525, lRecSalesShipmentLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecSalesShipmentLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecSalesShipmentLine."Line No.";
            end;

        end;
    end;

    procedure fKKPLookupSalesInvoiceGB(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecSalesInvoice: Record "Sales Invoice Header";
        lRecSalesInvoiceLine: Record "Sales Invoice Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'K');

        if pBoolHeader then begin
            lRecSalesInvoice.RESET;
            lRecSalesInvoice.SETCURRENTKEY("Sell-to Customer No.", "No.");
            lRecSalesInvoice.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(143, lRecSalesInvoice) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecSalesInvoice."No.";
        end else begin
            lRecSalesInvoiceLine.RESET;
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecSalesInvoiceLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecSalesInvoiceLine.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(526, lRecSalesInvoiceLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecSalesInvoiceLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecSalesInvoiceLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupSalesCreditMemo(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecSalesHeader: Record "Sales Header";
        lRecSalesLine: Record "Sales Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'K');

        if pBoolHeader then begin
            lRecSalesHeader.RESET;
            lRecSalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.", "No.");
            lRecSalesHeader.SETRANGE("Document Type", lRecSalesHeader."Document Type"::"Credit Memo");
            lRecSalesHeader.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(45, lRecSalesHeader) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecSalesHeader."No.";
        end else begin
            lRecSalesLine.RESET;
            lRecSalesLine.SETRANGE("Document Type", lRecSalesLine."Document Type"::"Credit Memo");
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecSalesLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecSalesLine.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(516, lRecSalesLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecSalesLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecSalesLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupSalesCreditMemoGB(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecSalesCreditMemo: Record "Sales Cr.Memo Header";
        lRecSalesCreditMemoLine: Record "Sales Cr.Memo Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'K');

        if pBoolHeader then begin
            lRecSalesCreditMemo.RESET;
            lRecSalesCreditMemo.SETCURRENTKEY("Sell-to Customer No.", "No.");
            lRecSalesCreditMemo.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(144, lRecSalesCreditMemo) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecSalesCreditMemo."No.";
        end else begin
            lRecSalesCreditMemoLine.RESET;
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecSalesCreditMemoLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecSalesCreditMemoLine.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(527, lRecSalesCreditMemoLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecSalesCreditMemoLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecSalesCreditMemoLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupSalesInvoice(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecSalesHeader: Record "Sales Header";
        lRecSalesLine: Record "Sales Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'K');

        if pBoolHeader then begin
            lRecSalesHeader.RESET;
            lRecSalesHeader.SETCURRENTKEY("Document Type", "Sell-to Customer No.", "No.");
            lRecSalesHeader.SETRANGE("Document Type", lRecSalesHeader."Document Type"::Invoice);
            lRecSalesHeader.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(45, lRecSalesHeader) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecSalesHeader."No.";
        end else begin
            lRecSalesLine.RESET;
            lRecSalesLine.SETRANGE("Document Type", lRecSalesLine."Document Type"::Invoice);
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecSalesLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecSalesLine.SETFILTER("Sell-to Customer No.", lCodBronnr);
            if PAGE.RUNMODAL(516, lRecSalesLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecSalesLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecSalesLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupPurchaseOrder(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecPurchaseHeader: Record "Purchase Header";
        lRecPurchaseLine: Record "Purchase Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'L');

        if pBoolHeader then begin
            lRecPurchaseHeader.RESET;
            lRecPurchaseHeader.SETRANGE("Document Type", lRecPurchaseHeader."Document Type"::Order);
            lRecPurchaseHeader.SETCURRENTKEY("Document Type", "Buy-from Vendor No.", "No.");
            lRecPurchaseHeader.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(53, lRecPurchaseHeader) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseHeader."No.";
        end else begin
            lRecPurchaseLine.RESET;
            lRecPurchaseLine.SETRANGE("Document Type", lRecPurchaseLine."Document Type"::Order);
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecPurchaseLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecPurchaseLine.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(518, lRecPurchaseLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecPurchaseLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupPurchaseReceipt(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecPurchaseReceipt: Record "Purch. Rcpt. Header";
        lRecPurchaseReceiptLine: Record "Purch. Rcpt. Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'L');

        if pBoolHeader then begin
            lRecPurchaseReceipt.RESET;
            lRecPurchaseReceipt.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(145, lRecPurchaseReceipt) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseReceipt."No.";
        end else begin
            lRecPurchaseReceiptLine.RESET;
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecPurchaseReceiptLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecPurchaseReceiptLine.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(528, lRecPurchaseReceiptLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseReceiptLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecPurchaseReceiptLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupPurchaseInvoiceGB(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecPurchaseInvoice: Record "Purch. Inv. Header";
        lRecPurchaseInvoiceLine: Record "Purch. Inv. Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'L');

        if pBoolHeader then begin
            lRecPurchaseInvoice.RESET;
            lRecPurchaseInvoice.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(146, lRecPurchaseInvoice) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseInvoice."No.";
        end else begin
            lRecPurchaseInvoiceLine.RESET;
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecPurchaseInvoiceLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecPurchaseInvoiceLine.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(529, lRecPurchaseInvoiceLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseInvoiceLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecPurchaseInvoiceLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupPurchaseCreditMemo(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecPurchaseHeader: Record "Purchase Header";
        lRecPurchaseLine: Record "Purchase Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'L');

        if pBoolHeader then begin
            lRecPurchaseHeader.RESET;
            lRecPurchaseHeader.SETRANGE("Document Type", lRecPurchaseHeader."Document Type"::"Credit Memo");
            lRecPurchaseHeader.SETCURRENTKEY("Document Type", "Buy-from Vendor No.", "No.");
            lRecPurchaseHeader.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(53, lRecPurchaseHeader) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseHeader."No.";
        end else begin
            lRecPurchaseLine.RESET;
            lRecPurchaseLine.SETRANGE("Document Type", lRecPurchaseLine."Document Type"::"Credit Memo");
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecPurchaseLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecPurchaseLine.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(518, lRecPurchaseLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecPurchaseLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupPurchaseCreditMemoGB(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecPurchaseCreditMemo: Record "Purch. Cr. Memo Hdr.";
        lRecPurchaseCreditMemoLine: Record "Purch. Cr. Memo Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'L');

        if pBoolHeader then begin
            lRecPurchaseCreditMemo.RESET;
            lRecPurchaseCreditMemo.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(147, lRecPurchaseCreditMemo) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseCreditMemo."No.";
        end else begin
            lRecPurchaseCreditMemoLine.RESET;
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecPurchaseCreditMemoLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecPurchaseCreditMemoLine.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(530, lRecPurchaseCreditMemoLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseCreditMemoLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecPurchaseCreditMemoLine."Line No.";
            end;
        end;
    end;

    procedure fKKPLookupPurchaseInvoice(var pvRecKlachtkoppeling: Record "Klacht koppelingen"; pRecKlacht: Record "XSS Complaint Header"; pBoolHeader: Boolean);
    var
        lRecPurchaseHeader: Record "Purchase Header";
        lRecPurchaseLine: Record "Purchase Line";
        lCodBronnr: Code[20];
    begin

        lCodBronnr := fRelatieReturnCustomerOrVendor(pRecKlacht."Relatienr.", 'L');

        if pBoolHeader then begin
            lRecPurchaseHeader.RESET;
            lRecPurchaseHeader.SETRANGE("Document Type", lRecPurchaseHeader."Document Type"::Invoice);
            lRecPurchaseHeader.SETCURRENTKEY("Document Type", "Buy-from Vendor No.", "No.");
            lRecPurchaseHeader.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(53, lRecPurchaseHeader) = ACTION::LookupOK then
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseHeader."No.";
        end else begin
            lRecPurchaseLine.RESET;
            lRecPurchaseLine.SETRANGE("Document Type", lRecPurchaseLine."Document Type"::Invoice);
            if pvRecKlachtkoppeling."Documentnr." <> '' then
                lRecPurchaseLine.SETRANGE("Document No.", pvRecKlachtkoppeling."Documentnr.");
            lRecPurchaseLine.SETFILTER("Buy-from Vendor No.", lCodBronnr);
            if PAGE.RUNMODAL(518, lRecPurchaseLine) = ACTION::LookupOK then begin
                pvRecKlachtkoppeling."Documentnr." := lRecPurchaseLine."Document No.";
                pvRecKlachtkoppeling."Documentregelnr." := lRecPurchaseLine."Line No.";
            end;
        end;
    end;

    procedure fKKPDocumentsoortOnvalidate(pxRecKlachtkoppeling: Record "Klacht koppelingen"; var pvRecKlachtkoppeling: Record "Klacht koppelingen");
    begin

        if pxRecKlachtkoppeling.Documentsoort <> pvRecKlachtkoppeling.Documentsoort then begin
            pvRecKlachtkoppeling."Documentnr." := '';
            pvRecKlachtkoppeling."Documentregelnr." := 0;
        end;
    end;

    procedure fKKPDocumentnrOnvalidate(pxRecKlachtkoppeling: Record "Klacht koppelingen"; var pvRecKlachtkoppeling: Record "Klacht koppelingen");
    begin

        if pxRecKlachtkoppeling."Documentnr." <> pvRecKlachtkoppeling."Documentnr." then begin
            pvRecKlachtkoppeling."Documentregelnr." := 0;
        end;
    end;

    procedure fKSGOnInsert(pRecKlachtstamgegevens: Record "XSS Complaint Type");
    begin

        fKSGCRUDAllowed(pRecKlachtstamgegevens);
    end;

    procedure fKSGOnModify(pxRecKlachtstamgegevens: Record "XSS Complaint Type"; pRecKlachtstamgegevens: Record "XSS Complaint Type");
    begin

        if (pxRecKlachtstamgegevens.Codesoort <> pRecKlachtstamgegevens.Codesoort) or
           (pxRecKlachtstamgegevens.Code <> pRecKlachtstamgegevens.Code) or
           (pxRecKlachtstamgegevens.Omschrijving <> pRecKlachtstamgegevens.Omschrijving) or
           (pxRecKlachtstamgegevens.Subtype <> pRecKlachtstamgegevens.Subtype) then
            fKSGCRUDAllowed(pRecKlachtstamgegevens);
    end;

    procedure fKSGOnDelete(pRecKlachtstamgegevens: Record "XSS Complaint Type");
    begin

        fKSGCRUDAllowed(pRecKlachtstamgegevens);
    end;

    procedure fKSGOnRename(pRecKlachtstamgegevens: Record "XSS Complaint Type");
    begin

        fKSGCRUDAllowed(pRecKlachtstamgegevens);
    end;

    procedure fKSGCRUDAllowed(pRecKlachtstamgegevens: Record "XSS Complaint Type");
    begin

        if pRecKlachtstamgegevens.Codesoort in ['AANGEMELDDOOR', 'BETREKKINGOP', 'KLACHTRELATIE'] then
            ERROR(Text901801)
    end;

    procedure fKORInsert(var pvRecKlachtopmerkingsregel: Record "XSS Complaint Comment");
    begin

        pvRecKlachtopmerkingsregel.Datum := WORKDATE;
    end;

    procedure fPostKlachtFromTo(pCodeFromDocumentsoort: Code[20]; pCodeFfromDocumentNo: Code[20]; pCodeFromLineNo: Integer; pCodeToDocumentsoort: Code[20]; pCodeToDocumentNo: Code[20]; pCodeToLineNo: Integer);
    var
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
        lTmpRecKlachtkoppelingen: Record "Klacht koppelingen" temporary;
    begin
        /* fPostKlachtFromTo */

        fPostKlachtVulTijdelijkeTabel(lTmpRecKlachtkoppelingen, pCodeFromDocumentsoort, pCodeFfromDocumentNo, pCodeFromLineNo);

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

    procedure fPostKlachtVulTijdelijkeTabel(var pvTmpRecKlachtkoppelingen: Record "Klacht koppelingen" temporary; pCodeDocumentsoort: Code[20]; pCodeDocumentNo: Code[20]; pIntLineNo: Integer);
    var
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
    begin
        /* fPostKlachtVulTijdelijkeTabel */

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

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterDeleteEvent', '', false, false)]
    procedure fSalesHeaderDeleteComplaint(var Rec: Record "Sales Header"; RunTrigger: Boolean);
    var
        lTmpCode: Code[20];
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
    begin
        case Rec."Document Type" of
            Rec."Document Type"::Quote:
                lTmpCode := 'VERKOOPOFFERTE';
            Rec."Document Type"::Order:
                lTmpCode := 'VERKOOPORDER';
            Rec."Document Type"::Invoice:
                lTmpCode := 'VERKOOPFACTUUR';
            Rec."Document Type"::"Credit Memo":
                lTmpCode := 'VERKOOPCREDITNOTA';
        end;

        lRecKlachtkoppelingen.RESET;
        lRecKlachtkoppelingen.SETRANGE(Documentsoort, lTmpCode);
        lRecKlachtkoppelingen.SETRANGE("Documentnr.", Rec."No.");
        lRecKlachtkoppelingen.DELETEALL(true);
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterDeleteEvent', '', false, false)]
    procedure fSalesLineDeleteComplaint(var Rec: Record "Sales Line"; RunTrigger: Boolean);
    var
        lTmpCode: Code[20];
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
    begin
        case Rec."Document Type" of
            Rec."Document Type"::Quote:
                lTmpCode := 'VERKOOPOFFERTE';
            Rec."Document Type"::Order:
                lTmpCode := 'VERKOOPORDER';
            Rec."Document Type"::Invoice:
                lTmpCode := 'VERKOOPFACTUUR';
            Rec."Document Type"::"Credit Memo":
                lTmpCode := 'VERKOOPCREDITNOTA';
        end;

        lRecKlachtkoppelingen.SETRANGE(Documentsoort, lTmpCode);
        lRecKlachtkoppelingen.SETRANGE("Documentnr.", Rec."Document No.");
        lRecKlachtkoppelingen.SETRANGE("Documentregelnr.", Rec."Line No.");
        lRecKlachtkoppelingen.DELETEALL(true)
    end;

    [EventSubscriber(ObjectType::Table, 38, 'OnAfterDeleteEvent', '', false, false)]
    procedure fPurchHeaderDeleteComplaint(var Rec: Record "Purchase Header"; RunTrigger: Boolean);
    var
        lTmpCode: Code[20];
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
    begin
        case Rec."Document Type" of
            Rec."Document Type"::Order:
                lTmpCode := 'INKOOPORDER';
            Rec."Document Type"::Invoice:
                lTmpCode := 'INKOOPFACTUUR';
            Rec."Document Type"::"Credit Memo":
                lTmpCode := 'INKOOPCREDITNOTA';
        end;

        lRecKlachtkoppelingen.SETRANGE(Documentsoort, lTmpCode);
        lRecKlachtkoppelingen.SETRANGE("Documentnr.", Rec."No.");
        lRecKlachtkoppelingen.DELETEALL(true);
    end;

    [EventSubscriber(ObjectType::Table, 39, 'OnAfterDeleteEvent', '', false, false)]
    procedure fPurchLineDeleteComplaint(var Rec: Record "Purchase Line"; RunTrigger: Boolean);
    var
        lTmpCode: Code[20];
        lRecKlachtkoppelingen: Record "Klacht koppelingen";
    begin
        case Rec."Document Type" of
            Rec."Document Type"::Order:
                lTmpCode := 'INKOOPORDER';
            Rec."Document Type"::Invoice:
                lTmpCode := 'INKOOPFACTUUR';
            Rec."Document Type"::"Credit Memo":
                lTmpCode := 'INKOOPCREDITNOTA';
        end;

        lRecKlachtkoppelingen.SETRANGE(Documentsoort, lTmpCode);
        lRecKlachtkoppelingen.SETRANGE("Documentnr.", Rec."Document No.");
        lRecKlachtkoppelingen.SETRANGE("Documentregelnr.", Rec."Line No.");
        lRecKlachtkoppelingen.DELETEALL(true);
    end;

    procedure fRelatieReturnCustomerOrVendor(pCodContactNo: Code[20]; pCodType: Code[1]): Code[20];
    var
        lRecContact: Record Contact;
        lRecContBusRel: Record "Contact Business Relation";
    begin
        /* fRelatieReturnCustomerOrVendor */

        if not lRecContact.GET(pCodContactNo) then
            exit('');

        lRecContBusRel.RESET;
        lRecContBusRel.SETRANGE("Contact No.", lRecContact."Company No.");
        lRecContBusRel.SETFILTER("No.", '<>''''');
        case pCodType of
            'K':
                lRecContBusRel.SETRANGE("Link to Table", lRecContBusRel."Link to Table"::Customer);
            'L':
                lRecContBusRel.SETRANGE("Link to Table", lRecContBusRel."Link to Table"::Vendor);
        end;
        if lRecContBusRel.FINDFIRST then
            exit(lRecContBusRel."No.")
        else
            exit('');

    end;

    procedure fCustomerOrVendorReturnContact(pCodNo: Code[20]; pCodType: Code[1]): Code[20];
    var
        lRecContBusRel: Record "Contact Business Relation";
        lRecContact: Record Contact;
    begin
        /* fCustomerOrVendorReturnContact */

        // Geef de functie een Klant of Leveranciernr mee.
        // Indien pCodType  = 'K', dan zoekt het systeem de relatie bij een klant.
        // Indien pCodeType = 'L', dan zoekt het systeem de relatie bij de leverancier.

        lRecContBusRel.RESET;
        lRecContBusRel.SETCURRENTKEY("Link to Table", "No.");
        case pCodType of
            'K':
                lRecContBusRel.SETRANGE("Link to Table", lRecContBusRel."Link to Table"::Customer);
            'L':
                lRecContBusRel.SETRANGE("Link to Table", lRecContBusRel."Link to Table"::Vendor);
        end;
        lRecContBusRel.SETRANGE("No.", pCodNo);
        if lRecContBusRel.FINDFIRST then
            exit(lRecContBusRel."Contact No.")
        else
            exit('');

    end;

    procedure fKlantToonKlachten(pRecCustomer: Record Customer);
    var
        lCodContact: Code[20];
        lRecKlacht: Record "XSS Complaint Header";
    begin
        /* fKlantToonKlachten */

        lCodContact := fCustomerOrVendorReturnContact(pRecCustomer."No.", 'K');

        lRecKlacht.RESET;
        lRecKlacht.SETCURRENTKEY("Relatienr.");
        lRecKlacht.SETRANGE("Relatienr.", lCodContact);
        if lRecKlacht.FINDSET(false, false) then;

        PAGE.RUNMODAL(0, lRecKlacht);

    end;

    procedure fLeverancierToonKlachten(pRecVendor: Record Vendor);
    var
        lCodContact: Code[20];
        lRecKlacht: Record "XSS Complaint Header";
    begin
        /* fLeverancierToonKlachten */

        lCodContact := fCustomerOrVendorReturnContact(pRecVendor."No.", 'L');

        lRecKlacht.RESET;
        lRecKlacht.SETCURRENTKEY("Relatienr.");
        lRecKlacht.SETRANGE("Relatienr.", lCodContact);
        if lRecKlacht.FINDSET(false, false) then;

        PAGE.RUNMODAL(0, lRecKlacht);

    end;

    procedure fZoekGekoppeldeRelatie(var pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecContactBusinessRelation: Record "Contact Business Relation";
        lRecContact: Record Contact;
        lRecVendor: Record Vendor;
        lRecCustomer: Record Customer;
    begin
        /* fZoekGekoppeldeRelatie */

        if not (lRecContact.GET(pvRecKlachtkop."Aangemeld door Nr.")) then begin
            pvRecKlachtkop.Zakenrelatie := '';
            pvRecKlachtkop.Bedrijfsnaam := '';
            exit;
        end;
        lRecContactBusinessRelation.RESET;
        lRecContactBusinessRelation.SETCURRENTKEY("Contact No.", "Business Relation Code");
        lRecContactBusinessRelation.SETRANGE("Contact No.", lRecContact."Company No.");
        if lRecContactBusinessRelation.FINDFIRST then begin
            pvRecKlachtkop.Zakenrelatie := lRecContactBusinessRelation."Business Relation Code";
            if lRecCustomer.GET(lRecContactBusinessRelation."No.") then
                pvRecKlachtkop.Bedrijfsnaam := lRecCustomer.Name;
            if lRecVendor.GET(lRecContactBusinessRelation."No.") then
                pvRecKlachtkop.Bedrijfsnaam := lRecVendor.Name;
        end else begin
            pvRecKlachtkop.Zakenrelatie := '';
            pvRecKlachtkop.Bedrijfsnaam := '';
            exit;
        end;

    end;

    procedure fShowContInteractLogLastDate(pRecKlachtkop: Record "XSS Complaint Header"): Date;
    var
        lRecInteractionLogEntry: Record "Interaction Log Entry";
        lRecContact: Record Contact;
    begin
        /* fShowContInteractLogLastDate */

        lRecInteractionLogEntry.RESET;
        lRecInteractionLogEntry.SETCURRENTKEY("Contact Company No.", "Contact No.", Date, Postponed);
        if lRecContact.GET(pRecKlachtkop."Aangemeld door Nr.") then
            lRecInteractionLogEntry.SETRANGE("Contact Company No.", lRecContact."Company No.");
        lRecInteractionLogEntry.SETRANGE("Contact No.", pRecKlachtkop."Aangemeld door Nr.");
        if lRecInteractionLogEntry.FINDLAST then
            exit(lRecInteractionLogEntry.Date);

    end;

    procedure fShowContactInteractionLog(pRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecInteractionLogEntry: Record "Interaction Log Entry";
        lRecContact: Record Contact;
        lFrmInteractionLogEntries: Page "Interaction Log Entries";
    begin
        /* fShowContactInteractionLog */

        lRecInteractionLogEntry.RESET;
        lRecInteractionLogEntry.SETCURRENTKEY("Contact Company No.", "Contact No.", Date, Postponed);
        if lRecContact.GET(pRecKlachtkop."Aangemeld door Nr.") then
            lRecInteractionLogEntry.SETRANGE("Contact Company No.", lRecContact."Company No.");
        lRecInteractionLogEntry.SETRANGE("Contact No.", pRecKlachtkop."Aangemeld door Nr.");
        if lRecInteractionLogEntry.FINDFIRST then begin
            CLEAR(lFrmInteractionLogEntries);
            lFrmInteractionLogEntries.SETRECORD(lRecInteractionLogEntry);
            lFrmInteractionLogEntries.SETTABLEVIEW(lRecInteractionLogEntry);
            lFrmInteractionLogEntries.RUNMODAL;
        end else
            MESSAGE(Text50000);

    end;

    procedure fRetunFaultCodeNaam(pCodeFault: Code[20]): Text[80];
    var
        lRecFaultCode: Record "Fault Code";
    begin
        /* fRetunFaultCodeNaam */

        lRecFaultCode.RESET;
        lRecFaultCode.SETCURRENTKEY("Fault Area Code", "Symptom Code", Code);
        lRecFaultCode.SETRANGE(Code, pCodeFault);
        if lRecFaultCode.FINDFIRST then
            exit(lRecFaultCode.Description);

    end;

    procedure fReturnResolutionNaam(pCodeResolution: Code[20]): Text[80];
    var
        lRecResolutionCode: Record "Resolution Code";
    begin
        /* fReturnResolutionNaam */

        if lRecResolutionCode.GET(pCodeResolution) then
            exit(lRecResolutionCode.Description);

    end;

    procedure fPrintKlachtRMAQualityReport(pRecKlachtkop: Record "XSS Complaint Header"; pCodSoort: Code[20]);
    var
        lRecXsensSetup: Record "XSENS Setup";
    begin
        /* fPrintKlachtRMAQualityReport */

        lRecXsensSetup.GET;
        lRecXsensSetup.TESTFIELD("Report No. Complaint RMA/Qua.");
        pRecKlachtkop.SETRECFILTER;
        //lRepRMAQualityReport.SETTABLEVIEW(pRecKlachtkop);
        //IF pCodSoort <> '' THEN
        //  lRepRMAQualityReport.fPrintSoortReport(pCodSoort);
        REPORT.RUN(lRecXsensSetup."Report No. Complaint RMA/Qua.", true, false, pRecKlachtkop);
        //lRepRMAQualityReport.RUNMODAL;

    end;

    procedure fChangeAssignedToByTreatmentBy(pRecKlachtregels: Record "XSS Complaint Line"; pXRecKlachtregels: Record "XSS Complaint Line");
    var
        lRecKlachkop: Record "XSS Complaint Header";
    begin
        /* fChangeAssignedToByTreatmentBy */

        if not (lRecKlachkop.GET(pRecKlachtregels.Stuknummer)) then exit;
        if (pRecKlachtregels.Stuksoort = pRecKlachtregels.Stuksoort::"Status historie") then begin
            //AND (NOT(pRecKlachtregels.ChangedTreatment)) THEN BEGIN //20100118 GFR 21839
            lRecKlachkop."Behandeling door" := pRecKlachtregels."Behandeld door";
            lRecKlachkop.MODIFY(false);
        end;

    end;

    procedure fCreateOrder(pvRecKlachtkop: Record "XSS Complaint Header");
    var
        lRecVerkoopkop: Record "Sales Header";
        lfrmVerkoopkop: Page "Sales Order";
        lRecContactBusinessRelation: Record "Contact Business Relation";
        lRecContact: Record Contact;
        lRecVendor: Record Vendor;
        lRecCustomer: Record Customer;
        lBoolKlant: Boolean;
    begin
        /* fCreateOrder */

        lBoolKlant := false;
        if not (lRecContact.GET(pvRecKlachtkop."Aangemeld door Nr.")) then
            ERROR(Text50002);
        lRecContactBusinessRelation.RESET;
        lRecContactBusinessRelation.SETCURRENTKEY("Contact No.", "Business Relation Code");
        lRecContactBusinessRelation.SETRANGE("Contact No.", lRecContact."Company No.");
        if lRecContactBusinessRelation.FINDFIRST then begin
            pvRecKlachtkop.Zakenrelatie := lRecContactBusinessRelation."Business Relation Code";
            if lRecCustomer.GET(lRecContactBusinessRelation."No.") then
                lBoolKlant := true;
            if lRecVendor.GET(lRecContactBusinessRelation."No.") then
                ERROR(Text50001);
        end else
            ERROR(Text50002);

        if not (lBoolKlant) then exit;
        lRecVerkoopkop.INIT;
        lRecVerkoopkop."Document Type" := lRecVerkoopkop."Document Type"::Order;
        lRecVerkoopkop."No." := '';
        lRecVerkoopkop.INSERT(true);
        lRecVerkoopkop.VALIDATE("Sell-to Customer No.", lRecCustomer."No.");
        lRecVerkoopkop.MODIFY(true);
        lRecVerkoopkop.SETRECFILTER;
        CLEAR(lfrmVerkoopkop);
        lfrmVerkoopkop.SETRECORD(lRecVerkoopkop);
        lfrmVerkoopkop.SETTABLEVIEW(lRecVerkoopkop);
        lfrmVerkoopkop.RUN;

    end;

    procedure fDataRecoveryCommentLines();
    var
        lRecXSSComplaintComment: Record "XSS Complaint Comment";
        lRecXSSComplaintHeader: Record "XSS Complaint Header";
        lBigText: BigText;
        lIntcount: Integer;
        lInstream: InStream;
        //TempBlob: Record TempBlob;
        Blob: Codeunit "Temp Blob";
        lTxtTotaalText: Text;
        TypeHelper: Codeunit "Type Helper";
        OStreamL: OutStream;
    begin

        //Data recovery , create blob field from commentLine tabel.
        lRecXSSComplaintHeader.RESET;
        if lRecXSSComplaintHeader.FINDSET(false, false) then begin
            repeat
                lRecXSSComplaintComment.RESET;
                lRecXSSComplaintComment.SETRANGE(Stuknummer, lRecXSSComplaintHeader."Nr.");
                if lRecXSSComplaintComment.FINDSET(false, false) then begin
                    CLEAR(lTxtTotaalText);
                    lIntcount := 0;
                    //lRecXSSComplaintHeader."Complaint Description".CREATEINSTREAM(llnStream);
                    repeat
                        lIntcount := lIntcount + 1;
                        //lRecXSSComplaintHeader."Complaint Description".CREATEINSTREAM(lInstream);
                        //lInstream.READ(lRecXSSComplaintComment.Commentaar);
                        //lRecXSSComplaintHeader.MODIFY(FALSE);
                        lTxtTotaalText := lTxtTotaalText + lRecXSSComplaintComment.Commentaar;
                    until lRecXSSComplaintComment.NEXT = 0;
                    if lTxtTotaalText <> '' then begin
                        CLEAR(lRecXSSComplaintHeader."Complaint Description");
                        // TempBlob.Blob := lRecXSSComplaintHeader."Complaint Description";
                        // TempBlob.WriteAsText(lTxtTotaalText, TEXTENCODING::Windows);
                        // lRecXSSComplaintHeader."Complaint Description" := TempBlob.Blob;
                        lRecXSSComplaintHeader."Complaint Description".CreateOutStream(OStreamL, TextEncoding::Windows);
                        lRecXSSComplaintHeader.CALCFIELDS("Complaint Description");
                        lRecXSSComplaintHeader."Complaint Description".CreateInStream(lInstream, TextEncoding::Windows);
                        if not TypeHelper.TryReadAsTextWithSeparator(lInstream, TypeHelper.LFSeparator(), lTxtTotaalText) then;
                        lRecXSSComplaintHeader.MODIFY;
                    end;
                end;
            until lRecXSSComplaintHeader.NEXT = 0;
        end;
    end;
}

