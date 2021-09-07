query 50003 "BI Lines"
{
    // version XSS5.080

    CaptionML = ENU = 'BI Lines',
                NLD = 'BI-regels';

    elements
    {
        dataitem(BI_Line; "BI Line")
        {
            DataItemTableFilter = "Posting Date" = FILTER('2018-01-01..');
            column(Year_Posting_Date; "Posting Date")
            {
                Method = Year;
            }
            column(Month_Posting_Date; "Posting Date")
            {
                Method = Month;
            }
            column(Day_Posting_Date; "Posting Date")
            {
                Method = Day;
            }
            column(Posting_Date; "Posting Date")
            {
            }
            column(Type; Type)
            {
            }
            column(Document_Type; "Document Type")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Quantity_Base; "Quantity (Base)")
            {
            }
            column(Total_Gross_Weight; "Total Gross Weight")
            {
            }
            column(Line_Amount; "Line Amount")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Amount_LCY; "Amount LCY")
            {
            }
            column(Item_Category_Code; "Item Category Code")
            {
            }
            column(No; "No.")
            {
            }
            column(Unit_Price_Direct_Unit_Cost; "Unit Price / Direct Unit Cost")
            {
            }
            column(Unit_Cost_LCY; "Unit Cost (LCY)")
            {
            }
            column(Line_Discount_Amount; "Line Discount Amount")
            {
            }
            column(Gen_Bus_Posting_Group; "Gen. Bus. Posting Group")
            {
            }
            column(Document_No; "Document No.")
            {
            }
            column(Sell_to_Cust_Buy_From_Vend; "Sell-to Cust. / Buy From Vend.")
            {
            }
            column(Salesperson_Purchaser_Code; "Salesperson / Purchaser Code")
            {
            }
            column(Shipment_Date; "Shipment Date")
            {
            }
            column(Product_Group_Code; "Product Group Code")
            {
            }
            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {
            }
            column(Gross_Weight; "Gross Weight")
            {
            }
            column(Sell_to_Buy_from_Country; "Sell-to/Buy-from Country")
            {
            }
            column(Description; Description)
            {
            }
            dataitem(Item_Category; "Item Category")
            {
                DataItemLink = Code = BI_Line."Item Category Code";
                column("Code"; "Code")
                {
                }
                dataitem(Vendor; Vendor)
                {
                    DataItemLink = "No." = BI_Line."Sell-to Cust. / Buy From Vend.";
                    column(Search_Name; "Search Name")
                    {
                    }
                    dataitem(Customer; Customer)
                    {
                        DataItemLink = "No." = BI_Line."Sell-to Cust. / Buy From Vend.";
                        column(Name; Name)
                        {
                        }
                        column(Application_area; "Application area")
                        {
                        }
                        dataitem(Item; Item)
                        {
                            DataItemLink = "No." = BI_Line."No.";
                            column(Item_Disc_Group; "Item Disc. Group")
                            {
                            }
                            column(Item_Code; "Item Code")
                            {
                            }
                            dataitem(County; County)
                            {
                                DataItemLink = County = BI_Line."Sell-to/Buy-from Country";
                                column(Omschrijving; Omschrijving)
                                {
                                }
                                dataitem(Sales_Invoice_Header; "Sales Invoice Header")
                                {
                                    DataItemLink = "No." = BI_Line."Document No.";
                                    column(Order_No; "Order No.")
                                    {
                                    }
                                    column(Due_Date; "Due Date")
                                    {
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

