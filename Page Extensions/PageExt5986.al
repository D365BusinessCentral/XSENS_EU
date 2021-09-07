pageextension 50022 "Service Item Component List" extends "Service Item Component List"
{
    layout
    {
        addlast(Control1)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = All;
            }
            field("Quantity Per"; Rec."Quantity Per")
            {
                ApplicationArea = All;
            }
            field("Unit of Measure Code"; Rec."Unit of Measure Code")
            {
                ApplicationArea = All;
            }
            field("Scrap %"; Rec."Scrap %")
            {
                ApplicationArea = All;
            }
            field("Routing Link Code"; Rec."Routing Link Code")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addafter("&Copy from BOM")
        {
            action("Copy From Prduction BOM")
            {
                Caption = 'Copy From Prduction BOM', comment = 'NLB="Copy From Prduction BOM"';
                ApplicationArea = Service;
                Image = CopyBOM;
                trigger OnAction()
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
                begin
                    Clear(ServItem);
                    ServItem.Get(Rec."Parent Service Item No.");
                    Clear(RecItem);
                    ServItem.TestField("Item No.");
                    RecItem.GET(ServItem."Item No.");
                    RecItem.TestField("Copy Production BOM");
                    RecItem.TestField("Production BOM No.");
                    Clear(RecProductionBOM);
                    RecProductionBOM.GET(RecItem."Production BOM No.");
                    ActiveVersionCode := VersionMgt.GetBOMVersion(RecProductionBOM."No.", WorkDate, true);
                    LastLineNo := GetLastLineNumber;
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
                end;
            }
        }
    }

    local procedure GetLastLineNumber(): Integer
    var
        RecServiceItemComponent: Record "Service Item Component";
    begin
        Clear(RecServiceItemComponent);
        RecServiceItemComponent.SetCurrentKey("Parent Service Item No.", "Line No.");
        RecServiceItemComponent.SetRange("Parent Service Item No.", Rec."Parent Service Item No.");
        if RecServiceItemComponent.FindLast() then
            exit(RecServiceItemComponent."Line No.")
        else
            exit(0);
    end;
}
