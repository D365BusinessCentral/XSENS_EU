codeunit 50006 Persistant
{
    // version XSS5.001

    SingleInstance = true;

    trigger OnRun();
    begin
    end;

    var
        gRecPurchaseHeaderIC: Record "Purchase Header";
        gBoolConsolidation: Boolean;

    procedure fSetICPurchaseHeader(pRecPurchaseHeader: Record "Purchase Header");
    begin
        /* fSetICPurchaseHeader */

        gRecPurchaseHeaderIC := pRecPurchaseHeader;

    end;

    procedure fGetICPurchaseHeader(var pRecPurchaseHeader: Record "Purchase Header");
    begin
        /* fGetICPurchaseHeader */

        pRecPurchaseHeader := gRecPurchaseHeaderIC;

    end;

    procedure fSetConsolidation(pBoolConsolidation: Boolean);
    begin
        /* fSetConsolidation */

        gBoolConsolidation := pBoolConsolidation;

    end;

    procedure fGetConsolidation(): Boolean;
    begin
        /* fGetConsolidation */

        exit(gBoolConsolidation);

    end;
}

