page 50022 ChargebeeSetupLines
{
    // version XSSCB1.3

    PageType = ListPart;
    SourceTable = ChargebeeSetupLine;
    UsageCategory = Lists;
    //Caption = 'Connections';

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("LineNo."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Connectie; Rec.Connectie)
                {
                    ApplicationArea = All;
                }
                field("Base url"; Rec."Base url")
                {
                    ApplicationArea = All;
                }
                field(APIKey; Rec.APIKey)
                {
                    ApplicationArea = All;
                }
                field("Last updated"; Rec."Last updated")
                {
                    ApplicationArea = All;
                }
                field(InstantBooking; Rec.InstantBooking)
                {
                    ApplicationArea = All;
                }
                field("Invoice prefix"; Rec."Invoice prefix")
                {
                    ApplicationArea = All;
                }
                // field("GL Account"; Rec."GL Account")
                // {
                //     CaptionML = ENU = 'Accounts receivable',
                //                 NLD = 'Debiteurenrekening';
                //     TableRelation = "G/L Account"."No.";
                //     ToolTip = 'Vul hier het grootboeknummer van de debiteuren rekening Chargebee facturen in';
                //     ApplicationArea = All;
                // }
                // field("Segment Code"; Rec."Segment Code")
                // {
                //     ApplicationArea = All;
                // }
                // field("Product Lines"; Rec."Product Lines")
                // {
                //     ApplicationArea = All;
                // }
                // field("Use Sales Tax"; Rec."Use Sales Tax")
                // {
                //     ApplicationArea = All;

                //     trigger OnValidate();
                //     begin
                //         if Rec."Use Sales Tax" then EnableSalesTax := true else EnableSalesTax := false;
                //     end;
                // }
                // field("Sales Tax account"; Rec."Sales Tax account")
                // {
                //     Enabled = EnableSalesTax;
                //     ApplicationArea = All;
                // }
                // field("Full VAT"; Rec."Full VAT")
                // {
                //     Enabled = EnableSalesTax;
                //     ApplicationArea = All;
                // }
                // field("No VAT"; Rec."No VAT")
                // {
                //     Enabled = EnableSalesTax;
                //     ApplicationArea = All;
                // }
            }
        }
    }

    trigger OnOpenPage();
    var
        SetupHeader: Record ChargebeeSetup;
    begin
        if Rec.Count = 0 then begin
            SetupHeader.Get();
            Rec.INIT;
            Rec.APIKey := SetupHeader.APIKey;
            Rec."Base url" := SetupHeader."Base url";
            Rec."Last updated" := SetupHeader."Last updated";
            Rec.InstantBooking := SetupHeader.InstantBooking;
            Rec."Invoice prefix" := SetupHeader."Invoice prefix";
            Rec.INSERT;
        end;
        //        if Rec."Use Sales Tax" then EnableSalesTax := true else EnableSalesTax := false;
    end;

    var
        EnableSalesTax: Boolean;
}

