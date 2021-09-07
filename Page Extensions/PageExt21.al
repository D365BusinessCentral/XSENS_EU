pageextension 50002 "Customer Card" extends "Customer Card"
{
    // version NAVW111.00.00.21836,NAVNL11.00.00.21836,CDO2.20.02,XSS5.030

    // 20181025 ELN 14652: Bill-to Email added
    // 20181106 GW  XXXXX: fields "Name 2" and County added.
    // 20181114 JS 14905: Field Outstanding Orders (LCY) added.

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
        addlast(General)
        {


            field("Outstanding Orders (LCY)"; Rec."Outstanding Orders (LCY)")
            {
                CaptionML = ENU = 'Open Order Amount (LCY)',
                                NLD = 'Openstaande orders (LV)';
                ApplicationArea = All;
            }

            field("Application area"; Rec."Application area")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field(ExternalID; Rec.ExternalID)
            {
                ApplicationArea = All;
            }
        }

        addlast(Invoicing)
        {
            field("Bill-to Email"; Rec."Bill-to Email")
            {
                ApplicationArea = All;
            }
        }
        addafter("Name 2")
        {
            field("Name 3"; Rec."Name 3")
            {
                ApplicationArea = All;
            }
        }
    }
}

