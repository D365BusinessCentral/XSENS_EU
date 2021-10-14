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
        with CompanyInfo do
            FormatAddressCUL.FormatAddr(
             AddrArray, Name, "Name 2", '', Address, "Address 2",
             City, "Post Code", County, "Country/Region Code");
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertShipmentLine', '', false, false)]
    local procedure OnAfterActionEvent(PreviewMode: Boolean; var SalesHeader: Record "Sales Header";
    var SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line";
    xSalesLine: Record "Sales Line")
    var
        RecItem: Record Item;
        RecProductionBOM: Record "Production BOM Header";
        RecProductionBOMLine: Record "Production BOM Line";
        RecProductionBOMVersion: Record "Production BOM Version";
        ServItem: Record "Service Item";
        RecServiceItemComponent: Record "Service Item Component";
        VersionMgt: Codeunit VersionManagement;
        ActiveVersionCode: Code[20];
        LastLineNo: Integer;
        ServiceItemComponentL: Record "Service Item Component";
    begin
        if SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order] then begin
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            if SalesLine.FindSet() then begin
                repeat
                    Clear(ServItem);
                    ServItem.SetRange("Item No.", SalesLine."No.");
                    if ServItem.FindSet() then begin
                        repeat
                            //ServiceItemComponentL.SetRange("Parent Service Item No.", ServItem."No.");
                            //ServiceItemComponentL.FindFirst();
                            Clear(RecItem);
                            RecItem.GET(ServItem."Item No.");
                            RecItem.TestField("Copy Production BOM");
                            RecItem.TestField("Production BOM No.");
                            Clear(RecProductionBOM);
                            RecProductionBOM.GET(RecItem."Production BOM No.");
                            ActiveVersionCode := VersionMgt.GetBOMVersion(RecProductionBOM."No.", WorkDate, true);
                            //LastLineNo := GetLastLineNumber(ServiceItemComponentL);
                            Clear(RecProductionBOMLine);
                            RecProductionBOMLine.SetRange("Production BOM No.", RecProductionBOM."No.");
                            if ActiveVersionCode = '' then
                                RecProductionBOMLine.SetRange("Version Code", ActiveVersionCode);
                            RecProductionBOMLine.SetRange(Type, RecProductionBOMLine.Type::Item);
                            if RecProductionBOMLine.FindSet() then begin
                                repeat
                                    LastLineNo += 10000;
                                    RecServiceItemComponent.Init();
                                    RecServiceItemComponent.Validate("Parent Service Item No.", ServItem."No.");
                                    RecServiceItemComponent.Validate("Line No.", LastLineNo);
                                    RecServiceItemComponent.Validate(Active, true);
                                    RecServiceItemComponent.Validate(Type, RecServiceItemComponent.Type::Item);
                                    RecServiceItemComponent.Validate("No.", RecProductionBOMLine."No.");
                                    RecServiceItemComponent.Validate("Variant Code", RecProductionBOMLine."Variant Code");
                                    RecServiceItemComponent.Validate("Quantity (Base)", RecProductionBOMLine.Quantity);
                                    RecServiceItemComponent.Validate("Scrap %", RecProductionBOMLine."Scrap %");
                                    RecServiceItemComponent.Validate("Quantity Per", RecProductionBOMLine."Quantity per");
                                    RecServiceItemComponent.Validate("Unit of Measure Code", RecProductionBOMLine."Unit of Measure Code");
                                    RecServiceItemComponent.Validate("Routing Link Code", RecProductionBOMLine."Routing Link Code");
                                    RecServiceItemComponent.Insert(true);
                                until RecProductionBOMLine.Next() = 0;
                            end
                        until ServItem.Next() = 0;
                    end;
                until SalesLine.Next() = 0;
            end;
        end;
    end;

    local procedure GetLastLineNumber(ServiceItemComponentP: Record "Service Item Component"): Integer
    var
        RecServiceItemComponent: Record "Service Item Component";
    begin
        Clear(RecServiceItemComponent);
        RecServiceItemComponent.SetCurrentKey("Parent Service Item No.", "Line No.");
        RecServiceItemComponent.SetRange("Parent Service Item No.", ServiceItemComponentP."Parent Service Item No.");
        if RecServiceItemComponent.FindLast() then
            exit(RecServiceItemComponent."Line No.")
        else
            exit(0);
    end;
}