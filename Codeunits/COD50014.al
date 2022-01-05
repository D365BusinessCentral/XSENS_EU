codeunit 50014 "Sales Order Customization"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnAfterValidateEvent(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        CustomerL: Record Customer;
    begin
        if Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Invoice] then begin
            if CustomerL.Get(Rec."Sell-to Customer No.") then begin
                case CustomerL."Shipment Method Code" of
                    'CPT':
                        Rec."Shipment Method Description" := 'Carriage Paid To address (excl. import cost) (Incoterms 2010)';
                    'DDP':
                        Rec."Shipment Method Description" := 'Delivered Duty Paid address (Incoterms 2010)';
                    'EXW':
                        Rec."Shipment Method Description" := 'EX-Works Enschede (Incoterms 2010)';
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeCompany', '', false, false)]
    local procedure OnBeforeCompany(var AddrArray: array[8] of Text[100];
    var CompanyInfo: Record "Company Information"; var IsHandled: Boolean)
    var
        FormatAddressCUL: Codeunit "Format Address";
    begin
        FormatAddressCUL.FormatAddr(
 AddrArray, CompanyInfo.Name, CompanyInfo."Name 2", '', CompanyInfo.Address, CompanyInfo."Address 2",
 CompanyInfo.City, CompanyInfo."Post Code", CompanyInfo.County, CompanyInfo."Country/Region Code");
        IsHandled := true;
    end;
}