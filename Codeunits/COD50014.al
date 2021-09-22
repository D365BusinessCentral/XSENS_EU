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
}