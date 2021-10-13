report 50008 "MRP Input"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\MRPInput.rdl';

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            CalcFields = Inventory;
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(CompanyName; CompanyInfo.Name) { }
            column(No_; "No.") { }
            column(Inventory; Inventory) { }
            column(Qty__on_Purch__Order; "Qty. on Purch. Order") { }
            column(Qty__on_Sales_Order; "Qty. on Sales Order") { }
            column(Shipmenthistory; QtyG) { }
            column(Unit_Cost; "Unit Cost") { }
            column(Item_Category_Code; "Item Category Code") { }
            column(Inventory_Posting_Group; "Inventory Posting Group") { }

            trigger OnAfterGetRecord()
            begin
                Clear(SalesshipmentLineG);
                Clear(QtyG);
                SalesshipmentLineG.SetRange("No.", "No.");
                if SalesshipmentLineG.FindSet() then
                    repeat
                        QtyG += SalesshipmentLineG.Quantity;
                    until SalesshipmentLineG.Next() = 0;
            end;
        }
    }
    trigger OnInitReport();
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        SalesshipmentLineG: Record "Sales Shipment Line";
        QtyG: Integer;
}