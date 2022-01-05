tableextension 50037 "Requisition Line" extends "Requisition Line"
{
    fields
    {
        field(50300; "Shipment date order"; Date)
        {
            CaptionML = ENU = 'Shipment date order',
                        NLD = 'Verzenddatum order';
        }
        field(50301; "IC Partner Ref. Type"; Option)
        {
            CaptionML = ENU = 'IC Partner Ref. Type',
                        NLD = 'IC-partnerreferentiesoort';
            OptionCaptionML = ENU = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.',
                              NLD = ' ,Grootboekrekening,Artikel,,,Toeslag (Artikel),Kruisverwijzing,Gemeenschappelijk artikelnr.';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.";
        }
        field(50302; "IC Partner Reference"; Code[20])
        {
            CaptionML = ENU = 'IC Partner Reference',
                        NLD = 'IC-partnerreferentie';

            trigger OnLookup();
            var
                ICGLAccount: Record "IC G/L Account";
                ItemCrossReference: Record "Item Reference";
                Item: Record Item;
            begin
                if "No." <> '' then
                    case "IC Partner Ref. Type" of
                        "IC Partner Ref. Type"::"G/L Account":
                            begin
                                if ICGLAccount.GET("IC Partner Reference") then;
                                if PAGE.RUNMODAL(PAGE::"IC G/L Account List", ICGLAccount) = ACTION::LookupOK then
                                    VALIDATE("IC Partner Reference", ICGLAccount."No.");
                            end;
                        "IC Partner Ref. Type"::Item:
                            begin
                                if Item.GET("IC Partner Reference") then;
                                if PAGE.RUNMODAL(PAGE::"Item List", Item) = ACTION::LookupOK then
                                    VALIDATE("IC Partner Reference", Item."No.");
                            end;
                        "IC Partner Ref. Type"::"Cross Reference":
                            begin
                                ItemCrossReference.RESET;
                                ItemCrossReference.SETCURRENTKEY("Reference Type", "Reference Type No.");
                                ItemCrossReference.SETFILTER(
                                  "Reference Type", '%1|%2',
                                  ItemCrossReference."Reference Type"::Customer,
                                  ItemCrossReference."Reference Type"::" ");
                                ItemCrossReference.SETFILTER("Reference Type No.", '%1|%2', "Sell-to Customer No.", '');
                                if PAGE.RUNMODAL(PAGE::"Item Reference List", ItemCrossReference) = ACTION::LookupOK then
                                    VALIDATE("IC Partner Reference", ItemCrossReference."Reference No.");
                            end;
                    end;
            end;
        }
        field(50303; "Salesperson Code"; Code[10])
        {
            CaptionML = ENU = 'Salesperson Code',
                        NLD = 'Verkoper';
            Editable = true;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate();
            var
                ApprovalEntry: Record "Approval Entry";
            begin
            end;
        }
        field(50304; "Sales Your Reference"; Text[30])
        {
            CaptionML = ENU = 'Your Reference',
                        NLD = 'Uw referentie';
            Editable = true;
        }
        field(50305; "Sales Quote No."; Code[20])
        {
            CaptionML = ENU = 'Quote No.',
                        NLD = 'Offertenr.';
            Editable = true;
        }
        field(50306; "Shortcut Dimension 1 VO"; Code[20])
        {
            CaptionClass = '1,2,1';
            CaptionML = ENU = 'Shortcut Dimension 1 Code',
                        NLD = 'Shortcutdimensie 1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50307; "Shortcut Dimension 2 VO"; Code[20])
        {
            CaptionClass = '1,2,2';
            CaptionML = ENU = 'Shortcut Dimension 2 Code',
                        NLD = 'Shortcutdimensie 2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50308; "Shipment Date"; Date)
        {
            CaptionML = ENU = 'Shipment Date',
                        NLD = 'Verzenddatum';

            trigger OnValidate();
            var
                CheckDateConflict: Codeunit "Reservation-Check Date Confl.";
            begin
            end;
        }
        field(50309; Sorting; Integer)
        {
            CaptionML = ENU = 'Sorting',
                        NLD = 'Sortering';
        }
    }
}
