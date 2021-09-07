query 50000 "Customer Item Sales"
{
    // version XSS5.033


    elements
    {
        dataitem(Sales_Invoice_Header; "Sales Invoice Header")
        {
            //DataItemTableFilter = "Posting Date" = FILTER(> 20170101D);
            DataItemTableFilter = "Posting Date" = FILTER('>2017-01-01');
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(No; "No.")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }
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
            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {
            }
            column(Customer_Posting_Group; "Customer Posting Group")
            {
            }
            dataitem(Sales_Invoice_Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                column(ItemNo; "No.")
                {
                }
                column(Document_No; "Document No.")
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                // column(Product_Group_Code;"Product Group Code")
                // {
                // }
                column(Unit_Cost_LCY; "Unit Cost (LCY)")
                {
                }
                column(Amount; Amount)
                {
                }
                column(Unit_Price; "Unit Price")
                {
                }
                column(Item_Category_Code; "Item Category Code")
                {
                }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                {
                }
                dataitem(Item; Item)
                {
                    DataItemLink = "No." = Sales_Invoice_Line."No.";
                    column(Item_Code; "Item Code")
                    {
                    }
                    dataitem(Customer; Customer)
                    {
                        DataItemLink = "No." = Sales_Invoice_Header."Sell-to Customer No.";
                        column(Application_area; "Application area")
                        {
                        }
                        dataitem(County; County)
                        {
                            DataItemLink = County = Customer.County;
                            column(Omschrijving; Omschrijving)
                            {
                            }
                        }
                    }
                }
            }
        }
    }
}

