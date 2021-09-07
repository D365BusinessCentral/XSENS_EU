page 50000 "XSENS SETUP"
{
    // version XSS5.037

    // 20181025 ELN 14652: Field 50010 added

    PageType = Card;
    SourceTable = "XSENS Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Alias; Rec.Alias)
                {
                    ApplicationArea = All;
                    Caption = 'Alias';
                }
                field(o; Rec."Permanence Journal Template")
                {
                    ApplicationArea = All;
                    Caption = 'Permanence Journal Template';
                }
                field("Permanence Journal batch"; Rec."Permanence Journal batch")
                {
                    ApplicationArea = All;
                    Caption = 'Permanence Journal batch';
                }
                field("Omzet spreiding (Permanence)"; Rec."Omzet spreiding (Permanence)")
                {
                    ApplicationArea = All;
                    Caption = 'Omzet spreiding (Permanence)';
                }
                field("Tussenrekening (Permanence)"; Rec."Tussenrekening (Permanence)")
                {
                    ApplicationArea = All;
                    Caption = 'Tussenrekening (Permanence)';
                }
                field("Omzet periodiek (Permanence)"; Rec."Omzet periodiek (Permanence)")
                {
                    ApplicationArea = All;
                    Caption = 'Omzet periodiek (Permanence)';
                }
                field("Report No. Complains"; Rec."Report No. Complains")
                {
                    ApplicationArea = All;
                    Caption = 'Report No. Complains';
                }
                field("Report No. Init"; Rec."Report No. Init")
                {
                    ApplicationArea = All;
                    Caption = 'Report No. Init';
                }
                field("Klachtnrs."; Rec."Klachtnrs.")
                {
                    ApplicationArea = All;
                    Caption = 'Klachtnrs.';
                }
                field("Report No. Complaint RMA/Qua."; Rec."Report No. Complaint RMA/Qua.")
                {
                    ApplicationArea = All;
                    Caption = 'Report No. Complaint RMA/Qua.';
                }
                field("IC Inkooppercentage"; Rec."IC Inkooppercentage")
                {
                    ApplicationArea = All;
                    Caption = 'IC Inkooppercentage';
                }
                field("Reference to terms"; Rec."Reference to terms")
                {
                    ApplicationArea = All;
                    Caption = 'Reference to terms';
                }
                field("Reference to terms 2"; Rec."Reference to terms 2")
                {
                    ApplicationArea = All;
                    Caption = 'Reference to terms 2';
                }
                field("Reference to terms 3"; Rec."Reference to terms 3")
                {
                    ApplicationArea = All;
                    Caption = 'Reference to terms 3';
                }
                field("Reference to terms 4"; Rec."Reference to terms 4")
                {
                    ApplicationArea = All;
                    Caption = 'Reference to terms 4';
                }
                field("Verkooprijzen mogen nul zijn"; Rec."Verkooprijzen mogen nul zijn")
                {
                    ApplicationArea = All;
                    Caption = 'Verkooprijzen mogen nul zijn';
                }
                field("Routing number"; Rec."Routing number")
                {
                    ApplicationArea = All;
                    Caption = 'Routing number';
                }
                field("Wijzig inclusief prijs"; Rec."Wijzig inclusief prijs")
                {
                    ApplicationArea = All;
                    Caption = 'Wijzig inclusief prijs';
                }
                field("Voltooid op datum"; Rec."Voltooid op datum")
                {
                    ApplicationArea = All;
                    Caption = 'Voltooid op datum';
                }
                field("Voltooid op tijd"; Rec."Voltooid op tijd")
                {
                    ApplicationArea = All;
                    Caption = 'Voltooid op tijd';
                }
                field("Default Rep. Depr. Book"; Rec."Default Rep. Depr. Book")
                {
                    ApplicationArea = All;
                    Caption = 'Default Rep. Depr. Book';
                }
                field("Check Item No. in Description"; Rec."Check Item No. in Description")
                {
                    ApplicationArea = All;
                    Caption = 'Check Item No. in Description';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(DataRecoveryBLOB)
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Data Recovery Complaints (Blob) ',
                            NLD = 'Data Recovery Complaints (Blob) ';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTipML = ENU = 'Set up the cues (status tiles) related to the role.',
                            NLD = 'De indicatiestapels instellen (statustegels) die zijn gekoppeld aan de rol.';

                trigger OnAction();
                var
                    CueRecordRef: RecordRef;
                    lCduXSSComplaintsMgt: Codeunit "XSS Complaints Mgt.";
                begin
                    lCduXSSComplaintsMgt.fDataRecoveryCommentLines;
                end;
            }
        }
    }
}

