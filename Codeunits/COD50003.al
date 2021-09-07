codeunit 50003 Service
{
    // version XSS5.006

    // 20110415 GFR 25468: functie fServiceArtAanmakenFromOrder toegevoegd.


    trigger OnRun();
    begin
    end;

    procedure fWarrantyServiceItemLine(pRecServiceItemLine: Record "Service Item Line"; var pRecGarantieFormule: DateFormula): Text[30];
    var
        ServMgtSetup: Record "Service Mgt. Setup";
        lRecServiceItemGroup: Record "Service Item Group";
        lDatFrmlEmpty: DateFormula;
    begin
        /* fWarrantyServiceItemLine */

        CLEAR(pRecGarantieFormule);
        CLEAR(lDatFrmlEmpty);

        ServMgtSetup.GET;
        pRecGarantieFormule := ServMgtSetup."Default Warranty Duration";

        if pRecServiceItemLine."Service Item Group Code" <> '' then begin
            if lRecServiceItemGroup.GET(pRecServiceItemLine."Service Item Group Code") then begin
                if lRecServiceItemGroup."Default Warranty Duration" <> lDatFrmlEmpty then begin
                    pRecGarantieFormule := lRecServiceItemGroup."Default Warranty Duration";
                end;
            end;
        end;

    end;

    procedure fWarrantyServiceItem(pRecServiceItem: Record "Service Item"; var pRecGarantieFormule: DateFormula): Text[30];
    var
        ServMgtSetup: Record "Service Mgt. Setup";
        lRecServiceItemGroup: Record "Service Item Group";
        lDatFrmlEmpty: DateFormula;
    begin
        /* fWarrantyServiceItem */

        CLEAR(pRecGarantieFormule);
        CLEAR(lDatFrmlEmpty);

        ServMgtSetup.GET;
        pRecGarantieFormule := ServMgtSetup."Default Warranty Duration";

        if pRecServiceItem."Service Item Group Code" <> '' then begin
            if lRecServiceItemGroup.GET(pRecServiceItem."Service Item Group Code") then begin
                if lRecServiceItemGroup."Default Warranty Duration" <> lDatFrmlEmpty then begin
                    pRecGarantieFormule := lRecServiceItemGroup."Default Warranty Duration";
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServItemManagement, 'OnCreateServItemOnSalesLineShpt', '', false, false)]
    local procedure OnCreateServItemOnSalesLineShpt(var ServiceItem: Record "Service Item"; SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line");
    begin
        ServiceItem."Sell-to IC Customer No." := SalesHeader."Sell-to IC Customer No.";
        ServiceItem."Sell-to IC Name" := SalesHeader."Sell-to IC Name";
        ServiceItem."Int Ship-to Name" := SalesHeader."Ship-to Name";
        ServiceItem."Int Ship-to Address" := SalesHeader."Ship-to Address";
        ServiceItem."Int Ship-to Address 2" := SalesHeader."Ship-to Address 2";
        ServiceItem."Int Ship-to Post Code" := SalesHeader."Ship-to Post Code";
        ServiceItem."Int Ship-to City" := SalesHeader."Ship-to City";
        ServiceItem."Int Ship-to Contact" := SalesHeader."Ship-to Contact";
        ServiceItem."Int Ship-to Phone No." := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ServItemManagement, 'OnCreateServItemOnServItemLineOnBeforeServItemModify', '', false, false)]
    local procedure OnCreateServItemOnServItemLineOnBeforeServItemModify(var ServiceItem: Record "Service Item"; ServiceHeader: Record "Service Header"; ServiceItemLine: Record "Service Item Line");
    begin
        ServiceItem."Int Ship-to Name" := ServiceHeader."Ship-to Name";
        ServiceItem."Int Ship-to Address" := ServiceHeader."Ship-to Address";
        ServiceItem."Int Ship-to Address 2" := ServiceHeader."Ship-to Address 2";
        ServiceItem."Int Ship-to Post Code" := ServiceHeader."Ship-to Post Code";
        ServiceItem."Int Ship-to City" := ServiceHeader."Ship-to City";
        ServiceItem."Int Ship-to Contact" := ServiceHeader."Ship-to Contact";
        ServiceItem."Int Ship-to Phone No." := '';
    end;


    procedure fServiceArtAanmakenFromOrder(var pvRecServiceItem: Record "Service Item"; pCodSoort: Code[20]; pRecSalesHeader: Record "Sales Header"; pRecServiceHeader: Record "Service Header");
    var
        lRecShiptoAddress: Record "Ship-to Address";
    begin
        /* fServiceArtAanmakenFromOrder */

        if (pCodSoort = 'SALESORDER') then begin
            pvRecServiceItem."Sell-to IC Customer No." := pRecSalesHeader."Sell-to IC Customer No.";
            pvRecServiceItem."Sell-to IC Name" := pRecSalesHeader."Sell-to IC Name";
            pvRecServiceItem."Int Ship-to Name" := pRecSalesHeader."Ship-to Name";
            pvRecServiceItem."Int Ship-to Address" := pRecSalesHeader."Ship-to Address";
            pvRecServiceItem."Int Ship-to Address 2" := pRecSalesHeader."Ship-to Address 2";
            pvRecServiceItem."Int Ship-to Post Code" := pRecSalesHeader."Ship-to Post Code";
            pvRecServiceItem."Int Ship-to City" := pRecSalesHeader."Ship-to City";
            pvRecServiceItem."Int Ship-to Contact" := pRecSalesHeader."Ship-to Contact";
            pvRecServiceItem."Int Ship-to Phone No." := '';
        end;
        if (pCodSoort = 'SERVICEORDER') then begin
            pvRecServiceItem."Int Ship-to Name" := pRecServiceHeader."Ship-to Name";
            pvRecServiceItem."Int Ship-to Address" := pRecServiceHeader."Ship-to Address";
            pvRecServiceItem."Int Ship-to Address 2" := pRecServiceHeader."Ship-to Address 2";
            pvRecServiceItem."Int Ship-to Post Code" := pRecServiceHeader."Ship-to Post Code";
            pvRecServiceItem."Int Ship-to City" := pRecServiceHeader."Ship-to City";
            pvRecServiceItem."Int Ship-to Contact" := pRecServiceHeader."Ship-to Contact";
            pvRecServiceItem."Int Ship-to Phone No." := '';
        end;

    end;

    var
        r: Report "Prod. Order - Job Card";
}

