page 68403 "XSS Complaints"
{
    // version XSS5.017

    CaptionML = ENU = 'Complaints',
                NLD = 'Klachten';
    CardPageID = "XSS Complaint";
    Editable = false;
    PageType = List;
    SourceTable = "XSS Complaint Header";
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field(Soort; Rec.Soort)
                {
                    ApplicationArea = All;
                    Caption = 'Soort';
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
                field("Relatienr."; Rec."Relatienr.")
                {
                    ApplicationArea = All;
                    Caption = 'Relatienr.';
                }
                field("Artikelnr."; Rec."Artikelnr.")
                {
                    ApplicationArea = All;
                    Caption = 'Artikelnr.';
                }
                field("Serviceartikelnr."; Rec."Serviceartikelnr.")
                {
                    ApplicationArea = All;
                    Caption = 'Serviceartikelnr.';
                }
                field("Klacht over Medewerker"; Rec."Klacht over Medewerker")
                {
                    ApplicationArea = All;
                    Caption = 'Klacht over Medewerker';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                }
                field(Zakenrelatie; Rec.Zakenrelatie)
                {
                    ApplicationArea = All;
                    Caption = 'Zakenrelatie';
                }
                field(Bedrijfsnaam; Rec.Bedrijfsnaam)
                {
                    ApplicationArea = All;
                    Caption = 'Bedrijfsnaam';
                }
                field(RMA; Rec.RMA)
                {
                    ApplicationArea = All;
                    Caption = 'RMA';
                }
                field(Garantie; Rec.Garantie)
                {
                    ApplicationArea = All;
                    Caption = 'Garantie';
                }
                field("Serie nr."; Rec."Serie nr.")
                {
                    ApplicationArea = All;
                    Caption = 'Serie nr.';
                }
                field(Geldigheid; Rec.Geldigheid)
                {
                    ApplicationArea = All;
                    Caption = 'Geldigheid';
                }
                field("Customer contact name"; Rec."Customer contact name")
                {
                    ApplicationArea = All;
                    Caption = 'Customer contact name';
                }
            }
        }
        area(factboxes)
        {
            part(Control1100510028; "XSS Complaint Document Factbox")
            {
                SubPageLink = Stuknummer = FIELD("Nr.");
                ApplicationArea = All;
            }
            systempart(Control1100510023; Links)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            systempart(Control1100510022; Notes)
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
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
        }
    }

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

