pageextension 50007 "Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addlast(content)
        {
            group("Chinese Localization")
            {
                Caption = 'Chinese Localization';
                field("VAT Customer Name"; Rec."VAT Customer Name")
                {
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("VAT Address & Telephone"; Rec."VAT Address & Telephone")
                {
                    ApplicationArea = All;
                }
                field("VAT Bank Name & Account"; Rec."VAT Bank Name & Account")
                {
                    ApplicationArea = All;
                }
                field("VAT Invoice Mail Address"; Rec."VAT Invoice Mail Address")
                {
                    ApplicationArea = All;
                }
                field("VAT Contact Information"; Rec."VAT Contact Information")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Shipment Method Code")
        {
            field("Shipment Method Description"; Rec."Shipment Method Description")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control205)
        {
            field("Bill-to Email"; Rec."Bill-to Email")
            {
                ApplicationArea = All;
            }
        }
        modify("Shipment Method Code")
        {
            trigger OnAfterValidate()
            var
                ShipmentMethod: Record "Shipment Method";
            begin
                if Rec.Status <> Rec.Status::Open then
                    Error('The document status must be open');

                if ShipmentMethod.Get(Rec."Shipment Method Code") then
                    Rec."Shipment Method Description" := ShipmentMethod."Description 2";
                // case Rec."Shipment Method Code" of
                //     'CPT':
                //         Rec."Shipment Method Description" := 'Carriage Paid To address (excl. import cost) (Incoterms 2010)';
                //     'DDP':
                //         Rec."Shipment Method Description" := 'Delivered Duty Paid address (Incoterms 2010)';
                //     'EXW':
                //         Rec."Shipment Method Description" := 'EX-Works Enschede (Incoterms 2010)';
                // end;
            end;
        }
    }
}