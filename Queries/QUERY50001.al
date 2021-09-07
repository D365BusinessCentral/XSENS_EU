query 50001 "Revenue recognition"
{
    // version XSS5.080


    elements
    {
        dataitem(Sales_Invoice_Header; "Sales Invoice Header")
        {
            //DataItemTableFilter = "Posting Date" = FILTER(> 20180101D);
            DataItemTableFilter = "Posting Date" = FILTER('>2018-01-01');
            column(No; "No.")
            {
            }
            column(Order_No; "Order No.")
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
            column(Posting_Date; "Posting Date")
            {

            }
            column(Sell_to_Customer_No; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }


            column(Sell_to_Country_Region_Code; "Sell-to Country/Region Code")
            {
            }
            column(Customer_Posting_Group; "Customer Posting Group")
            {
            }
            column(Due_Date; "Due Date")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            {
            }
            dataitem(Sales_Invoice_Line; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = Sales_Invoice_Header."No.";
                DataItemTableFilter = Type = FILTER("G/L Account" | Resource | Item);
                column(Document_No; "Document No.")
                {
                }
                column(Type; Type)
                {

                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Quantity__Base_; "Quantity (Base)")
                {

                }

                // column(Product_Group_Code;"Product Group Code")
                // {
                // }
                column(Unit_Cost_LCY; "Unit Cost (LCY)")
                {
                }
                column(Unit_Cost; "Unit Cost")
                {
                }
                column(Amount; Amount)
                {
                }

                column(Line_Amount; "Line Amount")
                {

                }

                column(Amount_LCY; "Amount LCY")
                {

                }
                column(Unit_Cost__LCY_; "Unit Cost (LCY)")
                {

                }
                column(Line_Discount_Amount; "Line Discount Amount")
                {

                }
                column(Gen__Bus__Posting_Group; "Gen. Bus. Posting Group")
                {

                }

                column(Unit_Price; "Unit Price")
                {
                }
                column(Gross_Weight; "Gross Weight")
                {
                }
                column(Item_Category_Code; "Item Category Code")
                {
                }
                column(Shipment_Date; "Shipment Date")
                {
                }
                column(Year_Shipment_Date; "Shipment Date")
                {
                    Method = Year;
                }
                column(Month_Shipment_Date; "Shipment Date")
                {
                    Method = Month;
                }
                column(Day_Shipment_Date; "Shipment Date")
                {
                    Method = Day;
                }
                column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
                {
                }
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = Sales_Invoice_Header."Sell-to Customer No.";
                    column(No_; "No.")
                    {
                    }
                    column(Name; Name)
                    {
                    }
                    column(Search_Name; "Search Name")
                    {
                    }
                    column(Application_area; "Application area")
                    {
                    }

                    dataitem(Item; Item)
                    {
                        DataItemLink = "No." = Sales_Invoice_Line."No.";
                        column(Item_Code; "Item Code")
                        {
                        }
                        column(Search_Description; "Search Description")
                        {
                        }
                        column(Item_Disc__Group; "Item Disc. Group")
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