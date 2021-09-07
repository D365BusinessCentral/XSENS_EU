pageextension 50017 "Payment Journal" extends "Payment Journal"
{

    layout
    {
        addafter("Bal. VAT Bus. Posting Group")
        {

            field("ShortcutDimCode[3]"; ShortcutDimCode[3])
            {
                ApplicationArea = Suite;
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                Visible = false;

                trigger OnValidate();
                begin
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field("ShortcutDimCode[4]"; ShortcutDimCode[4])
            {
                ApplicationArea = Suite;
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                Visible = false;

                trigger OnValidate();
                begin
                    Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field("ShortcutDimCode[5]"; ShortcutDimCode[5])
            {
                ApplicationArea = Suite;
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                Visible = false;

                trigger OnValidate();
                begin
                    Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field("ShortcutDimCode[6]"; ShortcutDimCode[6])
            {
                ApplicationArea = Suite;
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                Visible = false;

                trigger OnValidate();
                begin
                    Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field("ShortcutDimCode[7]"; ShortcutDimCode[7])
            {
                ApplicationArea = Suite;
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                Visible = false;

                trigger OnValidate();
                begin
                    Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field("ShortcutDimCode[8]"; ShortcutDimCode[8])
            {
                ApplicationArea = Suite;
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));
                Visible = false;

                trigger OnValidate();
                begin
                    Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
        }
    }

    actions
    {
        addafter(PrintCheck)
        {
            action(XsenseCheckPrint)
            {
                ApplicationArea = All;
                Caption = 'mCube Check Print';
                Image = PrintCheck;
                trigger OnAction()
                var
                    GenJnL: Record "Gen. Journal Line";
                    CheckPrint: Report CheckPrint;
                begin
                    GenJnL.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJnL.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    GenJnL.SetRange("Document No.", Rec."Document No.");
                    GenJnL.SetRange("Bal. Account No.", Rec."Bal. Account No.");
                    if GenJnL.FindFirst() then
                        Report.Run(50007, true, false, GenJnL);
                end;
            }
        }
    }
}
