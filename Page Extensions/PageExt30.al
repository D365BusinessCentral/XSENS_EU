pageextension 50003 "Item Card" extends "Item Card"
{
    // version NAVW111.00.00.21836,XSS5.081

    layout
    {
        addafter(Description)
        {
            field("Description 2"; Rec."Description 2")
            {
                ApplicationArea = All;
            }
        }
        addlast(Item)
        {
            field("Not synchronize to SF"; Rec."Not synchronize to SF")
            {
                ApplicationArea = All;

            }

            /*field("Inverted Unit Price"; Rec."Inverted Unit Price")
            {
                ApplicationArea = All;
                Visible = false;//As per Amit's Request
                //
            }*/

            field("Print Item Description 2"; Rec."Print Item Description 2")
            {
                ApplicationArea = All;
                //
            }
            field("Item Code"; Rec."Item Code")
            {
                ApplicationArea = All;
                //
            }

        }
        addafter("Production BOM No.")
        {
            field("Copy Serive Item Components"; Rec."Copy Serive Item Components")
            {
                ApplicationArea = All;
                Caption = 'Copy Serive Item Components';
                ToolTip = 'Copy Serive Item Components to Service Item while posting sales document';
            }
        }
        /* addlast(InventoryGrp)
         {
             field("On Hold"; Rec."On Hold")
             {
                 ApplicationArea = All;
                 //
             }
         }*/
        addafter(Inventory)
        {
            field("In Isolation"; Rec."In Isolation")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Net. on Hand"; Rec.Inventory - Rec."In Isolation")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
