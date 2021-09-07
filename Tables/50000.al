table 50000 "XSENS Setup"
{
    // version XSS5.020

    // 20090529 GFR 20120: Nieuw object-this is the setup table for the session killer
    // 20181025 ELN 14652: Field 50010 added

    Caption = 'Session Killer Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(50001; Alias; Option)
        {
            Description = 'Version Management Per Company';
            OptionMembers = " ","North America";
        }
        field(50010; "Check Item No. in Description"; Boolean)
        {
            CaptionML = ENU = 'Check Item No. in Description',
                        NLD = 'Controleer artikelnr. in omschrijving';
            DataClassification = ToBeClassified;
        }
        field(60000; "Permanence Journal Template"; Code[20])
        {
            CaptionML = ENU = 'Journal Template',
                        NLD = 'Dagboek sjabloon';
            Description = 'Permance Posting';
            TableRelation = "Gen. Journal Template";
        }
        field(60001; "Permanence Journal batch"; Code[20])
        {
            CaptionML = ENU = 'Journal batch',
                        NLD = 'Dagboek batch';
            Description = 'Permance Posting';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Permanence Journal Template"));
        }
        field(60002; "Omzet spreiding (Permanence)"; Code[20])
        {
            CaptionML = ENU = 'Revenue diversification',
                        NLD = 'Omzet spreiding';
            Description = 'Permance Posting';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(60003; "Tussenrekening (Permanence)"; Code[20])
        {
            CaptionML = ENU = 'Suspense Account',
                        NLD = 'Tussenrekening';
            Description = 'Permance Posting';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(60004; "Omzet periodiek (Permanence)"; Code[20])
        {
            CaptionML = ENU = 'Sales Periodically',
                        NLD = 'Omzet periodiek';
            Description = 'Permance Posting';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting));
        }
        field(70000; "Report No. Complains"; Integer)
        {
            CaptionML = ENU = 'Report No. Complains',
                        NLD = 'Raportnr. klachten';
            Description = 'Complaiins';
        }
        field(70001; "Report No. Init"; Integer)
        {
            CaptionML = ENU = 'Report No. Init',
                        NLD = 'Raportnr. Initialisatie';
            Description = 'Complaiins';
        }
        field(70002; "Klachtnrs."; Code[10])
        {
            CaptionML = ENU = 'Complaint Nos',
                        NLD = '&Klachtnrs.';
            Description = 'Marketing Setup , Complains';
            TableRelation = "No. Series";
        }
        field(70003; "Report No. Complaint RMA/Qua."; Integer)
        {
            CaptionML = ENU = 'Report No. Complaint RMA/Quality',
                        NLD = 'Raportnr. klachten RMA/Kwaliteit';
            Description = 'Complaiins XSS - Complaint RMA/Quality';
        }
        field(80000; "IC Inkooppercentage"; Decimal)
        {
            Description = 'Purchase Setup';
        }
        field(90001; "Reference to terms"; Text[250])
        {
            Description = 'Sales & Receivables Setup';
        }
        field(90002; "Reference to terms 2"; Text[250])
        {
            Description = 'Sales & Receivables Setup';
        }
        field(90003; "Reference to terms 3"; Text[250])
        {
            Description = 'Sales & Receivables Setup';
        }
        field(90004; "Reference to terms 4"; Text[250])
        {
            Description = 'Sales & Receivables Setup';
        }
        field(90005; "Verkooprijzen mogen nul zijn"; Boolean)
        {
            CaptionML = ENU = 'Prices may be null',
                        NLD = 'Verkooprijzen mogen nul zijn';
            Description = 'Sales & Receivables Setup';
        }
        field(90006; "Routing number"; Code[20])
        {
            Description = 'Sales & Receivables Setup';
        }
        field(100001; "Wijzig inclusief prijs"; Boolean)
        {
            Description = 'VAT Rate Change Setup';
        }
        field(100002; "Voltooid op datum"; Date)
        {
            Description = 'VAT Rate Change Setup';
        }
        field(100003; "Voltooid op tijd"; Time)
        {
            Description = 'VAT Rate Change Setup';
        }
        field(110001; "Default Rep. Depr. Book"; Code[10])
        {
            CaptionML = ENU = 'Default Depr. Book',
                        NLD = 'Std. Rap. afschr.-boek';
            Description = 'FA Setup';
            TableRelation = "Depreciation Book";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
}

