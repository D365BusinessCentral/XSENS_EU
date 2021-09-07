page 68400 "XSS Complaint"
{
    // version XSS5.037

    CaptionML = ENU = 'Complaint',
                NLD = 'Klacht';
    PageType = Card;
    SourceTable = "XSS Complaint Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Nr."; Rec."Nr.")
                {
                    ApplicationArea = All;
                    Caption = 'Nr.';
                }
                field(Datum; Rec.Datum)
                {
                    ApplicationArea = All;
                    Caption = 'Datum';
                }
                field("Aangemeld door Soort"; Rec."Aangemeld door Soort")
                {
                    ApplicationArea = All;
                    Caption = 'Aangemeld door Soort';
                }
                field("Aangemeld door Nr."; Rec."Aangemeld door Nr.")
                {
                    ApplicationArea = All;
                    Caption = 'Aangemeld door Nr.';
                }
                field(Bedrijfsnaam; Rec.Bedrijfsnaam)
                {
                    ApplicationArea = All;
                    Caption = 'Bedrijfsnaam';
                }
                field("Relatienr."; Rec."Relatienr.")
                {
                    ApplicationArea = All;
                    Caption = 'Relatienr.';
                }
                field(Zakenrelatie; Rec.Zakenrelatie)
                {
                    ApplicationArea = All;
                    Caption = 'Zakenrelatie';
                }
                field("Customer contact name"; Rec."Customer contact name")
                {
                    ApplicationArea = All;
                    Caption = 'Customer contact name';
                }
                group(Status)
                {
                    CaptionML = ENU = 'Status',
                                NLD = 'Status';
                    field(Control1100510014; Rec.Status)
                    {
                        ApplicationArea = All;
                        Caption = 'Status';
                    }
                    field("Geregistreerd door"; Rec."Geregistreerd door")
                    {
                        ApplicationArea = All;
                        Caption = 'Geregistreerd door';
                    }
                    field("Behandeling door"; Rec."Behandeling door")
                    {
                        ApplicationArea = All;
                        Caption = 'Behandeling door';
                    }
                }
                group(Subject)
                {
                    CaptionML = ENU = 'Subject',
                                NLD = 'Onderwerp';
                    field(Soort; Rec.Soort)
                    {
                        ApplicationArea = All;
                        Caption = 'Soort';
                    }
                    field("Artikelnr."; Rec."Artikelnr.")
                    {
                        ApplicationArea = All;
                        Caption = 'Artikelnr.';
                    }
                    field("Serie nr."; Rec."Serie nr.")
                    {
                        ApplicationArea = All;
                        Caption = 'Serie nr.';
                    }
                    field(RMA; Rec.RMA)
                    {
                        ApplicationArea = All;
                        Caption = 'RMA';
                    }
                    field(Geldigheid; Rec.Geldigheid)
                    {
                        ApplicationArea = All;
                        Caption = 'Geldigheid';
                    }
                    field(Garantie; Rec.Garantie)
                    {
                        ApplicationArea = All;
                        Caption = 'Garantie';
                    }
                }
                group("Complaint Description")
                {
                    CaptionML = ENU = 'Complaint Description',
                                NLD = 'Klachtomschrijving';
                    field(ComplaintDescription; ComplaintDescription)
                    {
                        ApplicationArea = Advanced;
                        CaptionML = ENU = 'Complaint Description', NLD = 'Klachtomschrijving';
                        MultiLine = true;
                        ShowCaption = false;
                        ToolTipML = ENU = 'Specifies the complaint',
                                    NLD = 'Hiermee worden de opgeven klacht beschreven';

                        trigger OnValidate();
                        begin
                            Rec.SetComplaintDescription(ComplaintDescription);
                        end;
                    }
                }
            }
            part(Lines; "XSS Complaint Subform")
            {
                CaptionML = ENU = 'Lines',
                            NLD = 'Regels';
                SubPageLink = Stuknummer = FIELD("Nr.");
                SubPageView = SORTING(Stuknummer, Stuksoort, Datum, "Regelnr.")
                              ORDER(Ascending);
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part(Control1100510010; "XSS Complaint Document Factbox")
            {
                SubPageLink = Stuknummer = FIELD("Nr.");
                ApplicationArea = All;
            }
            systempart(Control1100510026; Links)
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1100510025; Notes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action(InteractionLog)
            {
                CaptionML = ENU = 'Interaction Log Entries',
                            NLD = 'Interactielogposten';
                Image = InteractionLog;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ShowInteractions;
                end;
            }
            action(Documents)
            {
                CaptionML = ENU = 'Documents',
                            NLD = 'Documenten';
                Ellipsis = true;
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
            }
            action(Comments)
            {
                CaptionML = ENU = 'Comments',
                            NLD = 'Opmerkingen';
                Ellipsis = true;
                Image = Comment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "XSS Complaint Comments";
                RunPageLink = Stuknummer = FIELD("Nr.");
                ApplicationArea = All;
            }
            action("Print RMA")
            {
                CaptionML = ENU = 'Print Complaint / RMA',
                            NLD = 'Klacht / RMA afdrukken';
                Image = Print;
                Promoted = true;
                ApplicationArea = All;

                trigger OnAction();
                var
                    lRepXSSComplaintRMAQuality: Report "XSS - Complaint RMA/Quality";
                begin
                    Rec.SETRECFILTER;
                    lRepXSSComplaintRMAQuality.SETTABLEVIEW(Rec);
                    lRepXSSComplaintRMAQuality.RUN;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ComplaintDescription := Rec.GetComplaintDescription;
    end;

    var
        ComplaintDescription: Text;

    local procedure ShowInteractions();
    var
        lRecContact: Record Contact;
        lRecInteractionLogEntry: Record "Interaction Log Entry";
        lPagInteractionLogEntries: Page "Interaction Log Entries";
    begin
        if lRecContact.GET(Rec."Aangemeld door Nr.") then begin
            lRecInteractionLogEntry.SETRANGE("Contact No.", Rec."Aangemeld door Nr.");
            if lRecInteractionLogEntry.FINDFIRST then begin
                lPagInteractionLogEntries.SETTABLEVIEW(lRecInteractionLogEntry);
                lPagInteractionLogEntries.RUNMODAL;
            end;
        end;
    end;
}

