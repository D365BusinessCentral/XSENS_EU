report 50014 Complaint
{
    // version XSS5.033

    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Complaint.rdlc';

    dataset
    {
        dataitem("Complaint Header"; "XSS Complaint Header")
        {
            DataItemTableView = SORTING("Nr.");
            RequestFilterFields = "Nr.", "Behandeling door", "Relatienr.", Status;
            column(lblPage; Trl('Page'))
            {
            }
            column(lblNo; Trl('No'))
            {
            }
            column(lblComplaintDate; Trl('ComplaintDate'))
            {
            }
            column(lblComplaintType; Trl('ComplaintType'))
            {
            }
            column(lblAnnouncedBy; Trl('AnnouncedBy'))
            {
            }
            column(lblAppliesTo; Trl('AppliesTo'))
            {
            }
            column(lblRegisteredBy; Trl('RegisteredBy'))
            {
            }
            column(lblTreatmentBy; Trl('TreatmentBy'))
            {
            }
            column(lblComplaintDescription; Trl('ComplaintDescription'))
            {
            }
            column(lblComplaintActivities; Trl('ComplaintActivities'))
            {
            }
            column(lblStatus; Trl('Status'))
            {
            }
            column(lblComplaintAttachedTo; Trl('ComplaintAttachedTo'))
            {
            }
            column(lblDocumentType; Trl('DocumentType'))
            {
            }
            column(lblDocumentNo; Trl('DocumentNo'))
            {
            }
            column(lblLineNo; Trl('LineNo'))
            {
            }
            column(HeaderText1; gTxtHeaderText1)
            {
            }
            column(CompanyName; "Complaint Header".Bedrijfsnaam)
            {
            }
            column(WorkdateTime; FORMAT(STRSUBSTNO(Text901801, USERID, WORKDATE, TIME)))
            {
            }
            column(ComplaintTypeDescription; gTxtComplaintTypeDescription)
            {
            }
            column(AnnouncedBy; gTxtAnnouncedBy)
            {
            }
            column(SubAnnouncedBy; gTxtSubAnnouncedBy)
            {
            }
            column(AppliesTo; gTxtAppliesTo)
            {
            }
            column(ComplaintType; gTxtComplaintType)
            {
            }
            column(RegisteredBy; gTxtRegisteredBy)
            {
            }
            column(TreatmentBy; gTxtTreatmentBy)
            {
            }
            column(No; "Complaint Header"."Nr.")
            {
            }
            column(DateHeader; "Complaint Header".Datum)
            {
            }
            dataitem("Complaint Comments"; "XSS Complaint Comment")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemTableView = SORTING(Stuknummer, Stuksoort, "Regelnr.");
                column(DateComments; "Complaint Comments".Datum)
                {
                }
                column(Comment; "Complaint Comments".Commentaar)
                {
                }
            }
            dataitem("Complaint Line"; "XSS Complaint Line")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemTableView = SORTING(Stuknummer, Stuksoort, Datum, "Regelnr.");
                column(DateLine; "Complaint Line".Datum)
                {
                }
                column(Description; "Complaint Line".Omschrijving)
                {
                }
                column(ComplaintStatus; gTxtComplaintStatus)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    gTxtComplaintStatus := gCduKlacht.fGetStamgegevensOmschrijving('KLACHTSTATUS', Status);
                end;
            }
            dataitem("Complaint Koppelingen"; "Klacht koppelingen")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemTableView = SORTING(Stuknummer, Documentsoort, "Documentnr.", "Documentregelnr.");
                column(ComplaintRelation; gTxtComplaintRelation)
                {
                }
                column(DocumentNo; "Complaint Koppelingen"."Documentnr.")
                {
                }
                column(DocumentLineNo; "Complaint Koppelingen"."Documentregelnr.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    gTxtComplaintRelation := gCduKlacht.fGetStamgegevensOmschrijving('KLACHTRELATIE', Documentsoort);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                gTxtHeaderText1 := STRSUBSTNO(Text901802, "Nr.");
                gTxtComplaintTypeDescription := gCduKlacht.fGetStamgegevensOmschrijving('KLACHTSOORT', Soort);
                gTxtAnnouncedBy := gCduKlacht.fGetStamgegevensOmschrijving('AANGEMELDDOOR', "Aangemeld door Soort");
                gTxtSubAnnouncedBy := STRSUBSTNO('%1 - %2', "Aangemeld door Nr.", gCduKlacht.fGetNamen("Aangemeld door Soort", "Aangemeld door Nr."));
                gTxtAppliesTo := gCduKlacht.fGetContactName("Relatienr.");
                gTxtComplaintType := gCduKlacht.fGetStatusOmschrijving("Complaint Header");
                gTxtRegisteredBy := gCduKlacht.fGetNamen('MEDEWERKER', "Geregistreerd door");
                gTxtTreatmentBy := gCduKlacht.fGetNamen('MEDEWERKER', "Behandeling door");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        gTxtHeaderText1: Text;
        gTxtComplaintTypeDescription: Text;
        gTxtAnnouncedBy: Text;
        gTxtSubAnnouncedBy: Text;
        gTxtAppliesTo: Text;
        gTxtComplaintType: Text;
        gTxtRegisteredBy: Text;
        gTxtTreatmentBy: Text;
        gTxtComplaintStatus: Text;
        gTxtComplaintRelation: Text;
        gCduKlacht: Codeunit "XSS Complaints Mgt.";
        //wgCduDocCreatorTransLationMgt: Codeunit wDocCreatorTranslationMgt;//Krishna
        wgReportId: Integer;
        Text901800: TextConst ENU = 'Page: %1', NLD = 'Pagina: %1';
        Text901801: TextConst ENU = 'Printed by: %1 on %2 - %3', NLD = 'Afgedrukt door: %1 op %2 - %3';
        Text901802: TextConst ENU = 'Complaint: %1', NLD = 'Klacht: %1';

    local procedure Trl(pLblName: Text): Text;
    begin
        /*if wgReportId = 0 then begin
            EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(false), '=', DELCHR(CurrReport.OBJECTID(false), '=', '1234567890')));
            //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        end;
        exit(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));*/
        exit(pLblName);
    end;
}

