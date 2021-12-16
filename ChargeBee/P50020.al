page 50020 ChargebeeSetup
{
    // version XSSCB1.3

    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = ChargebeeSetup;
    UsageCategory = Documents;
    ApplicationArea = All;
    Caption = 'Chargebee Setup';

    layout
    {
        area(Content)
        {
            group(Setup)
            {
                // field("Base url"; Rec."Base url")
                // {
                //     ToolTip = 'Vul volledige url naar Chargebee-omgeving in (incl. /api/v2)';
                //     ApplicationArea = All;
                // }
                // field(APIKey; Rec.APIKey)
                // {
                //     ApplicationArea = All;
                // }
                // field("Last updated"; Rec."Last updated")
                // {
                //     ApplicationArea = All;
                // }
                // field(InstantBooking; Rec.InstantBooking)
                // {
                //     ApplicationArea = All;
                // }
                // field("Invoice prefix"; Rec."Invoice prefix")
                // {
                //     ApplicationArea = All;
                // }
                field("GL Account"; Rec."GL Account")
                {
                    Caption = 'Accounts receivable';
                    TableRelation = "G/L Account"."No.";
                    ToolTip = 'Vul hier het grootboeknummer van de debiteuren rekening Chargebee facturen in';
                    ApplicationArea = All;
                }
                field("Segment Code"; Rec."Segment Code")
                {
                    ApplicationArea = All;
                }
                field("Product Lines"; Rec."Product Lines")
                {
                    ApplicationArea = All;
                }
                field(Dummy; '')
                {
                    Editable = false;
                    Caption = '';
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Use Sales Tax"; Rec."Use Sales Tax")
                {
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        if Rec."Use Sales Tax" then EnableSalesTax := true else EnableSalesTax := false;
                    end;
                }
                field("Sales Tax account"; Rec."Sales Tax account")
                {
                    Enabled = EnableSalesTax;
                    ApplicationArea = All;
                }
                field("Full VAT"; Rec."Full VAT")
                {
                    Enabled = EnableSalesTax;
                    ApplicationArea = All;
                }
                field("No VAT"; Rec."No VAT")
                {
                    Enabled = EnableSalesTax;
                    ApplicationArea = All;
                }
            }
            part(Lines; ChargebeeSetupLines)
            {
                Caption = 'Connections';
                ApplicationArea = All;
            }


        }
    }

    actions
    {
        area(processing)
        {
            action("Start Processing Chargebee")
            {
                Image = AddWatch;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit ProcessChargebee;
                ApplicationArea = All;
            }
            action("Transaction Logging")
            {
                Image = TransferOrder;
                Promoted = true;
                PromotedCategory = Report;
                ApplicationArea = All;
                RunObject = Page "Chargebee Transaction Logging";  //Krishna The page is not available
                                                                   //PdV: Echt wel
            }
            // action("DO NOT USE - Delete transaction logging")
            // {
            //     Image = Delete;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         SalesHeader: Record "Sales Header";
            //         SalesLine: Record "Sales Line";
            //         CBTrans: Record "Chargebee Transactions";
            //     begin
            //         SalesLine.DeleteAll();
            //         SalesHeader.DeleteAll();
            //         CBTrans.DeleteAll();
            //         Commit();
            //     end;
            // }
        }
    }
    trigger OnOpenPage();
    begin
        if not Rec.GET then begin
            Rec.INIT;
            Rec.INSERT;
        end;
        if Rec."Use Sales Tax" then EnableSalesTax := true else EnableSalesTax := false;
    end;

    var
        EnableSalesTax: Boolean;
}

