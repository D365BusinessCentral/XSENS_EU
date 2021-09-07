tableextension 50056 "Item Tracking Code" extends "Item Tracking Code"
{
    fields
    {
        field(50000; "Partnummer Tracking"; Boolean)
        {
            CaptionML = ENU = 'Tracking part number required',
                        NLD = 'Tracking partnummer verplicht';
            Description = 'No longer used';

            trigger OnValidate();
            begin
                if "Lot Specific Tracking" = xRec."Lot Specific Tracking" then
                    exit;

                if "Lot Specific Tracking" then begin
                    TestSetSpecific(FIELDCAPTION("Lot Specific Tracking"));

                    "Lot Purchase Inbound Tracking" := true;
                    "Lot Purchase Outbound Tracking" := true;
                    "Lot Sales Inbound Tracking" := true;
                    "Lot Sales Outbound Tracking" := true;
                    "Lot Pos. Adjmt. Inb. Tracking" := true;
                    "Lot Pos. Adjmt. Outb. Tracking" := true;
                    "Lot Neg. Adjmt. Inb. Tracking" := true;
                    "Lot Neg. Adjmt. Outb. Tracking" := true;
                    "Lot Transfer Tracking" := true;
                    "Lot Manuf. Inbound Tracking" := true;
                    "Lot Manuf. Outbound Tracking" := true;
                end else begin
                    TestRemoveSpecific(FIELDCAPTION("Lot Specific Tracking"));
                    "Lot Warehouse Tracking" := false;
                end;
            end;
        }
    }
}
