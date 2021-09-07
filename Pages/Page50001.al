page 50001 "XSS Complaint/RMA Activities"
{
    // version NAVW111.00,XSS5.017

    CaptionML = ENU = 'Activities',
                NLD = 'Activiteiten';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "XSENS Cue";

    layout
    {
        area(content)
        {
            cuegroup("RMA/Complaints")
            {
                CaptionML = ENU = 'RMA/Complaints',
                            NLD = 'RMA/Klachten';
                field(Complaints; Rec.Complaints)
                {
                    ApplicationArea = All;
                    Caption = 'Complaints';

                }
                field("RMA's"; Rec."RMA's")
                {
                    ApplicationArea = All;
                    Caption = 'RMA''s';
                }

                actions
                {
                    action("New Complaint")
                    {
                        ApplicationArea = Basic, Suite;
                        CaptionML = ENU = 'New Complaint',
                                    NLD = 'Nieuwe klacht';
                        RunObject = Page "XSS Complaint";
                        RunPageMode = Create;
                        ToolTipML = ENU = 'Create a new complaint for a customer or vendor.',
                                    NLD = 'Een nieuwe klacht maken voor een klant of leverancier.';
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Set Up Cues")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Set Up Cues',
                            NLD = 'Indicatiestapels instellen';
                Image = Setup;
                ToolTipML = ENU = 'Set up the cues (status tiles) related to the role.',
                            NLD = 'De indicatiestapels instellen (statustegels) die zijn gekoppeld aan de rol.';

                trigger OnAction();
                var
                    CueRecordRef: RecordRef;
                begin
                    CueRecordRef.GETTABLE(Rec);
                    //CueSetup.OpenCustomizePageForCurrentUser(CueRecordRef.NUMBER);//Krishna
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
    begin
        RoleCenterNotificationMgt.HideEvaluationNotificationAfterStartingTrial;
    end;

    trigger OnAfterGetRecord();
    var
        DocExchServiceSetup: Record "Doc. Exch. Service Setup";
    begin
        CalculateCueFieldValues;
        ShowDocumentsPendingDodExchService := false;
        if DocExchServiceSetup.GET then
            ShowDocumentsPendingDodExchService := DocExchServiceSetup.Enabled;
    end;

    trigger OnOpenPage();
    var
        RoleCenterNotificationMgt: Codeunit "Role Center Notification Mgt.";
    begin
        Rec.RESET;
        if not Rec.GET then begin
            Rec.INIT;
            Rec.INSERT;
        end;

        Rec.SetRespCenterFilter;
        Rec.SETRANGE("Date Filter", 0D, WORKDATE - 1);
        Rec.SETFILTER("Date Filter2", '>=%1', WORKDATE);
        Rec.SETFILTER("User ID Filter", USERID);

        RoleCenterNotificationMgt.ShowNotifications;

        /*if PageNotifier.IsAvailable then begin//Krishna
            PageNotifier := PageNotifier.Create;
            PageNotifier.NotifyPageReady;
        end;*/
    end;

    var
        //CueSetup: Codeunit "Cue Setup";//Krishna
        //PageNotifier: DotNet "'Microsoft.Dynamics.Nav.ClientExtensions, Version=11.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'.Microsoft.Dynamics.Nav.Client.PageNotifier" RUNONCLIENT WITHEVENTS;//Krishna
        ShowDocumentsPendingDodExchService: Boolean;

    local procedure CalculateCueFieldValues();
    begin
        if Rec.FIELDACTIVE("Average Days Delayed") then
            Rec."Average Days Delayed" := Rec.CalculateAverageDaysDelayed;

        if Rec.FIELDACTIVE("Ready to Ship") then
            Rec."Ready to Ship" := Rec.CountOrders(Rec.FIELDNO("Ready to Ship"));

        if Rec.FIELDACTIVE("Partially Shipped") then
            Rec."Partially Shipped" := Rec.CountOrders(Rec.FIELDNO("Partially Shipped"));

        if Rec.FIELDACTIVE(Delayed) then
            Rec.Delayed := Rec.CountOrders(Rec.FIELDNO(Delayed));
    end;

    //event PageNotifier();
    var
    //NetPromoterScoreMgt: Codeunit "Net Promoter Score Mgt.";//Krishna
    //begin
    /*
    NetPromoterScoreMgt.ShowNpsDialog;
    */
    //end;
}

