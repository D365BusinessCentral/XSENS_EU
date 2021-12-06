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
                Visible = false;
            }
            field("Comment External"; Rec."Comment External")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field(ExternalID; Rec.ExternalID)
            {
                ApplicationArea = All;
            }
            field("Declaration Statement"; Rec."Declaration Statement")
            {
                ApplicationArea = All;
            }
            group(SalesForce)
            {
                CaptionML = ENU = 'SalesForce',
                                  NLD = 'SalesForce';
                field("SalesForce Comment"; Rec."SalesForce Comment")
                {
                    CaptionML = ENU = 'Comment 1',
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
                    Caption = 'IC Payment Terms';
                }
                field("US Sales Order No."; Rec."US Sales Order No.")
                {
                    ApplicationArea = All;
                    Caption = 'IC Sales Order No.';
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
        // addlast(content)
        // {
        //     group(SalesForce)
        //     {
        //         CaptionML = ENU = 'SalesForce',
        //                           NLD = 'SalesForce';
        //         field("SalesForce Comment"; Rec."SalesForce Comment")
        //         {
        //             CaptionML = ENU = 'Comment',
        //                               NLD = 'Opmerking';
        //             ApplicationArea = All;
        //         }
        //         field("Comment 2"; Rec."Comment 2")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("US Payment Terms"; Rec."US Payment Terms")
        //         {
        //             ApplicationArea = All;
        //         }
        //         field("US Sales Order No."; Rec."US Sales Order No.")
        //         {
        //             ApplicationArea = All;
        //         }
        //     }
        // }
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
        addbefore("Direct Debit Mandate ID")
        {
            field("Tax Area Code"; Rec."Tax Area Code")
            {
                Editable = true;
                Enabled = true;
                ApplicationArea = All;
            }
            field("Tax Liable"; Rec."Tax Liable")
            {
                Editable = true;
                Enabled = true;
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
        modify("Sell-to Contact")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to Name")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to Address")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to Address 2")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to City")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to County")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to Post Code")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to Country/Region Code")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to Contact No.")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Bill-to Contact")
        {
            Editable = true;
            Enabled = true;
        }
        modify(BillToContactPhoneNo)
        {
            Editable = true;
            Enabled = true;
        }
        modify(BillToContactMobilePhoneNo)
        {
            Editable = true;
            Enabled = true;
        }
        modify(BillToContactEmail)
        {
            Editable = true;
            Enabled = true;
        }
        modify("Ship-to Name")
        {
            Editable = true;
        }
        modify("Ship-to Address")
        {
            Editable = true;
        }
        modify("Ship-to Address 2")
        {
            Editable = true;
        }
        modify("Ship-to City")
        {
            Editable = true;
        }
        modify("Ship-to County")
        {
            Editable = true;
        }
        modify("Ship-to Post Code")
        {
            Editable = true;
        }
        modify("Ship-to Country/Region Code")
        {
            Editable = true;
        }
        modify("Ship-to Contact")
        {
            Editable = true;
        }
        modify(Control82)
        {
            Visible = true;
        }
        modify(Control4)
        {
            Visible = true;
        }
        addlast("Invoice Details")
        {
            field("VAT Registration No."; Rec."VAT Registration No.")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if (Rec."Created By Rapidi") AND (Rec."Rapidi Fields Updated" = false) then begin
            Rec.PopulateCustomFields();
            Rec."Rapidi Fields Updated" := true;
            Rec.Modify();
            Commit();// used commit as it was throwing error while opening other Runmodal pages on SO card like Dimensions
        end;
    end;

}
