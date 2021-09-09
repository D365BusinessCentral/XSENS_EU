pageextension 50006 "Sales Order" extends "Sales Order"
{
    // version NAVW111.00.00.21836,NAVNL11.00.00.21836,CDO2.20.02,XSS5.076

    // 20181025 ELN 14652: Bill-to Email added
    // 20181106 GW  XXXXX: fields "Sell-to Customer Name 2", "Sell-to County", "Sell-to Contact E-mail", "Sell-to Contact Phone", "Date Order confimation", "Your Reference", "US Sales Order No.", "Payment Method Code",
    //                     "Tax Liable", "Tax Area Code", "Ship-to County", "Ready to Ship", "Bill-to County", "Bill-to Country/Region Code" and "VAT Registration No." added.
    // 20181115 JVW XXXXX: UpdateShipToBillToGroupVisibility adjusted - Customization for SF. New option fields on Tab Ship-To Adress
    // 20190123 KBG NMSD-287: Field "Boekingsdatum akkoord" added.
    // 20190403 KBG NMSD-859: Field "Bill-to Customer" editable

    layout
    {
        addlast(General)
        {
            field("Comment Internal"; Rec."Comment Internal")
            {
                ApplicationArea = All;
            }
            field("Comment External"; Rec."Comment External")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shipment Method Code")
        {
            field("Shipment Method Description"; Rec."Shipment Method Description")
            {
                ApplicationArea = All;
            }
        }
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
        addlast(Control85)
        {
            field("Bill-to Email"; Rec."Bill-to Email")
            {
                ApplicationArea = All;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Sell-to Customer Name 2',
                                NLD = 'Klantnaam 2';
            }
        }
        addlast("Sell-to")
        {
            field("Sell-to Contact E-mail"; Rec."Sell-to Contact E-mail")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Contact E-mail',
                                NLD = 'Contact E-mail';
                ToolTipML = ENU = 'Specifies the E-mail of the person to contact at the customer.',
                                NLD = 'Hiermee wordt de e-mail opgegeven van de persoon met wie bij de klant contact moet worden opgenomen.';
            }
            field("Sell-to Contact Phone"; Rec."Sell-to Contact Phone")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Contact Phone',
                                NLD = 'Contact telefoon';
            }
        }
        addbefore("Document Date")
        {
            field("Boekingsdatum akkoord"; Rec."Boekingsdatum akkoord")
            {
                ApplicationArea = All;
            }
            field("Date Order confimation"; Rec."Date Order confimation")
            {
                ApplicationArea = Basic, Suite;
            }
        }
        addlast(content)
        {
            group(SalesForce)
            {
                CaptionML = ENU = 'SalesForce',
                                  NLD = 'SalesForce';
                field("SalesForce Comment"; Rec."SalesForce Comment")
                {
                    CaptionML = ENU = 'Comment',
                                      NLD = 'Opmerking';
                    ApplicationArea = All;
                }
                field("Comment 2"; Rec."Comment 2")
                {
                    ApplicationArea = All;
                }
                field("US Payment Terms"; Rec."US Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("US Sales Order No."; Rec."US Sales Order No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Ship-to Contact")
        {
            field("Sell-to IC Customer No."; Rec."Sell-to IC Customer No.")
            {
                ApplicationArea = All;
            }
            field("Sell-to IC Name"; Rec."Sell-to IC Name")
            {
                ApplicationArea = All;
            }
        }
        addlast("Shipment Method")
        {
            field("Ready to Ship"; Rec."Ready to Ship")
            {
                ApplicationArea = Suite;
                Importance = Additional;
            }
        }

    }
}
