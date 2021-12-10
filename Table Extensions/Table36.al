tableextension 50011 "Sales Header" extends "Sales Header"
{
    fields
    {
        field(50004; "Application area"; Text[30])
        {
        }
        field(50005; Application; Text[30])
        {
        }
        field(50010; ExternalID; Text[30])
        {
            Enabled = true;
            Editable = true;
        }
        field(50012; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Blocked" = CONST(false));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(50015; "Sell-to Customer Name 3"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Comment Internal"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'Internal Comment';
        }
        field(50017; "Comment External"; Text[250])
        {
            DataClassification = ToBeClassified;
            Description = 'External Comment';
        }
        field(50018; "Shipment Method Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        //rapidi modification fields-start
        field(50022; "Payment Terms Code IT"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Payment Method Code IT"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50024; "Salesperson Code IT"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Shipment Date IT"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Currency Code IT"; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Created By Rapidi"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Rapidi Fields Updated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //-end
        field(50100; "VAT Customer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50101; "VAT Address & Telephone"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50102; "VAT Bank Name & Account"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50103; "VAT Invoice Mail Address"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50104; "VAT Contact Information"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50300; "Sales Date"; Date)
        {
        }
        field(50301; "Archive option"; Option)
        {
            Caption = 'Archief optie';
            Editable = false;
            OptionMembers = " ",Deleted,Archived;
        }
        field(50302; "Sell-to Contact E-mail"; Text[80])
        {
            CaptionML = ENU = 'Sell-to Contact E-mail',
                        NLD = 'Contact E-mail';
        }
        field(50303; "Sell-to Contact Phone"; Text[20])
        {
            CaptionML = ENU = 'Sell-to Contact Phone',
                        NLD = 'Telefoon';
            //This property is currently not supported
            //TestTableRelation = false;
            //ValidateTableRelation = false;
        }
        field(50304; "SalesForce Comment"; Text[250])
        {
            CaptionML = ENU = 'SalesForce Comment',
                        NLD = 'Opmerking SalesForce';
            Description = 'Used';
        }
        field(50305; "Boekingsdatum akkoord"; Boolean)
        {
            CaptionML = ENU = 'Posting date agreed',
                        NLD = 'Boekingsdatum akkoord';

            trigger OnValidate();
            var
                lRecDummyPurchaseHeader: Record "Purchase Header";
            begin
                if "Boekingsdatum akkoord" then
                    gCduAlgemeen.fInsertModificationLogSalesPurch(Rec, lRecDummyPurchaseHeader, true, 0); //20180123 KBG NMSD_287
            end;
        }
        field(50360; "Sell-to IC Customer No."; Code[20])
        {
            CaptionML = ENU = 'Sell-to IC Customer No.',
                        NLD = 'IC Orderklantnr.';
            // Editable = false;
            TableRelation = Customer;
            ValidateTableRelation = false;
        }
        field(50361; "Sell-to IC Name"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Name',
                        NLD = 'IC Ordernaam';
            // Editable = false;
        }
        field(50362; "Sell-to IC Name 2"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Name 2',
                        NLD = 'IC Ordernaam 2';
            //Editable = false;
        }
        field(50363; "Sell-to IC Address"; Text[100])
        {
            CaptionML = ENU = 'Sell-to IC Address',
                        NLD = 'IC Orderadres';
            //Editable = false;

            trigger OnValidate();
            var
                PhoneNo: Text[30];
                FaxNo: Text[30];
            begin
            end;
        }
        field(50364; "Sell-to IC Address 2"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Address 2',
                        NLD = 'IC Orderadres 2';
            // Editable = false;
        }
        field(50365; "Sell-to IC City"; Text[30])
        {
            CaptionML = ENU = 'Sell-to IC City',
                        NLD = 'IC Orderplaats';
            //  Editable = false;
        }
        field(50366; "Sell-to IC Contact"; Text[50])
        {
            CaptionML = ENU = 'Sell-to IC Contact',
                        NLD = 'IC Ordercontact';
            // Editable = false;
        }
        field(50367; "Sell-to IC Post Code"; Code[20])
        {
            CaptionML = ENU = 'Sell-to IC Post Code',
                        NLD = 'IC Postcode';
            //   Editable = false;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50450; "Bill-to Email"; Text[80])
        {
            CaptionML = ENU = 'Bill-to Email',
                        NLD = 'Factuur naar Email';
        }
        field(50500; "IC Purchase order created"; Boolean)
        {
            CaptionML = ENU = 'IC Purchase order created',
                        NLD = 'IC Inkooporder aangemaakt';
        }
        field(50501; "IC Purchase order send"; Boolean)
        {
            CaptionML = ENU = 'IC Purchase order send',
                        NLD = 'IC Inkooporder verstuurd';
        }
        field(50502; "IC Purchase order"; Code[20])
        {
        }
        field(50503; "Date Order confimation"; Date)
        {
            CaptionML = ENU = 'Date Order confimation',
                        NLD = 'Datum orderbevestiging';
        }
        field(50504; "Comment 2"; Text[255])
        {
            CaptionML = ENU = 'Comment 2',
                        NLD = 'Opmerking 2';
            Description = 'Used';
        }
        field(50505; "US Payment Terms"; Code[10])
        {
            CaptionML = ENU = 'US Payment terms',
                        NLD = 'US Betalingscondities';
            Description = 'Used';
            TableRelation = "Payment Terms";
            ValidateTableRelation = false;
        }
        field(50506; "US Sales Order No."; Code[20])
        {
            CaptionML = ENU = 'US Sales Order No.',
                        NLD = 'US Verkoopordernr.';
            Description = 'Used';
        }
        field(50507; "Ready to Ship"; Boolean)
        {
            CaptionML = ENU = 'Ready to Ship',
                        NLD = 'Gereed voor verzending';
        }
        field(50508; Segment; Text[50])
        {
            CaptionML = ENU = 'Segment',
                        NLD = 'Segment';
        }
        field(50509; "Declaration Statement"; Boolean)
        {
            CaptionML = ENU = 'Declaration Statement',
                        NLD = 'Factuurverklaring';
            Description = 'Used';
        }
    }
    keys
    {
        /*key(Key10; "Document Type", "Sales Date", "Sell-to Customer No.", "No.")
        {
        }*/
        key(Key10; "Sales Date")
        {
        }
    }

    procedure PopulateCustomFields()
    var
        UpdateCurrencyExchangeRates: Codeunit "Update Currency Exchange Rates";
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyDate: Date;
    begin
        Rec."Currency Code" := Rec."Currency Code IT";
        if "Posting Date" <> 0D then
            CurrencyDate := "Posting Date"
        else
            CurrencyDate := WorkDate;
        if UpdateCurrencyExchangeRates.ExchangeRatesForCurrencyExist(CurrencyDate, "Currency Code") then begin
            Rec."Currency Factor" := CurrExchRate.ExchangeRate(CurrencyDate, "Currency Code");
        end;

        Rec."Shipment Date" := Rec."Shipment Date IT";
        Rec.Validate("Payment Terms Code", Rec."Payment Terms Code IT");
        Rec.Validate("Payment Method Code", Rec."Payment Method Code IT");
        Rec.validate("Salesperson Code", Rec."Salesperson Code IT");
    end;

    var
        gCduAlgemeen: Codeunit Algemeen;
}