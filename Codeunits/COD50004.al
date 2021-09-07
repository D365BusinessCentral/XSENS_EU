codeunit 50004 Sales
{
    // version XSS5.066

    // 20190110 KBG NMSD-293: Functie fInitQuantity added
    // 20190110 KBG NMSD-284: Functie fValidateLineDiscount added
    // 20190110 KBG NMSD-284: Functie fValidateDirectUnitCost added


    trigger OnRun();
    begin
    end;

    procedure fInitQuantity(var pRecTrackingSpecification: Record "Tracking Specification");
    begin
        pRecTrackingSpecification."Quantity (Base)" := 1;
        pRecTrackingSpecification."Qty. to Handle (Base)" := 1;
        pRecTrackingSpecification."Qty. to Invoice (Base)" := 1;
    end;

    procedure fValidateLineDiscount(var pvRecReqLine: Record "Requisition Line"; pRecSalesLine: Record "Sales Line");
    begin
        pvRecReqLine.VALIDATE("Line Discount %", pRecSalesLine."Line Discount %");
    end;

    procedure fValidateDirectUnitCost(var pvRecReqLine: Record "Requisition Line"; pRecSalesLine: Record "Sales Line");
    var
        lRecXsensSetup: Record "XSENS Setup";
        lDecBestDirectUnitCost: Decimal;
        lDecVerkoopBedrag: Decimal;
    begin
        lRecXsensSetup.GET;
        lDecVerkoopBedrag := pRecSalesLine."Unit Price";
        if lRecXsensSetup."IC Inkooppercentage" <> 0 then
            lDecBestDirectUnitCost := (lDecVerkoopBedrag * (100 + lRecXsensSetup."IC Inkooppercentage")) / 100;
        pvRecReqLine.VALIDATE("Direct Unit Cost", lDecBestDirectUnitCost);
    end;
}

