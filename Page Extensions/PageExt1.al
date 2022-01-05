pageextension 50001 "Company Information" extends "Company Information"
{
    // version NAVW111.00.00.19846,NAVNL11.00.00.19846,XSS5.088

    // 20181001 TWI: Fields for Intercompany added.
    // 20191007 KBG NMSD-2422: Velden "Bank Name USD", "IBAN USD", "SWIFT Code USD" en "Payment Note" toegevoegd.

    CaptionML = ENU = 'Company Information',
                NLD = 'Bedrijfsgegevens';
    PromotedActionCategoriesML = ENU = 'New,Process,Report,Application Settings,System Settings,Currencies,Codes,Regional Settings',
                                 NLD = 'Nieuw,Verwerken,Rapporteren,Applicatie-instellingen,Systeeminstellingen,Valuta''s,Codes,Landinstellingen';

    layout
    {
        addlast(content)
        {
            /*field("Sync with O365 Bus. profile"; Rec."Sync with O365 Bus. profile")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Synchronize with Office 365 Business Profile',
                                NLD = 'Synchroniseren met Office 365 Business-profiel';
                Importance = Additional;
                ToolTipML = ENU = 'Specifies that the profile will be synchronized with the one in Office 365.',
                                NLD = 'Hiermee wordt opgegeven dat het profiel wordt gesynchroniseerd met het profiel in Office 365.';
            }*/
        }
        addlast(Payments)
        {
            field("Bank Name USD"; Rec."Bank Name USD")
            {
                CaptionML = ENU = 'Bank Name USD',
                                NLD = 'Banknaam USD';
                ApplicationArea = All;
            }
            field("IBAN USD"; Rec."IBAN USD")
            {
                CaptionML = ENU = 'IBAN USD',
                                NLD = 'IBAN USD';
                ApplicationArea = All;
            }
            field("SWIFT Code USD"; Rec."SWIFT Code USD")
            {
                CaptionML = ENU = 'SWIFT Code USD',
                                NLD = 'SWIFT-code USD';
                ApplicationArea = All;
            }
            field("Payment Note"; Rec."Payment Note")
            {
                ApplicationArea = All;
            }
        }

        addlast(content)
        {
            Group(Intercompany)
            {
                field("Use US Tax System"; Rec."Use US Tax System")
                {
                    ApplicationArea = All;
                }
                field("Std. Purchasing Code"; Rec."Std. Purchasing Code")
                {
                    ApplicationArea = All;
                }
                field("Std. Purchasing Company"; Rec."Std. Purchasing Company")
                {
                    ApplicationArea = All;
                }
                field(Lockbox; Rec.Lockbox)
                {
                    ApplicationArea = All;
                }
                field("Tax Area Los Angeles"; Rec."Tax Area Los Angeles")
                {
                    ApplicationArea = All;
                }
                field("Company Location"; Rec."Company Location")
                {
                    ApplicationArea = All;
                }
                field("Company Name for Intercompany"; Rec."Company Name for Intercompany")
                {
                    ApplicationArea = All;
                }
            }
        }

    }
}

