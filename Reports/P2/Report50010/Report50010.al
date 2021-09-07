report 50010 "XSS - Complaint RMA/Quality"
{
    // version XSS5.010

    // DefaultLayout = RDLC;
    // RDLCLayout = 'Reports\P2\XSS - Complaint RMAQuality.rdlc';
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Report50010\Report50010.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Klachtkop; "XSS Complaint Header")
        {
            DataItemTableView = SORTING("Nr.");
            RequestFilterFields = "Nr.";
            column(lblRMA; Trl('RMA'))
            {
            }
            column(lblRegisteredBy; Trl('RegisteredBy'))
            {
            }
            column(lblContactNr; Trl('ContactNr'))
            {
            }
            column(lblContactName; Trl('ContactName'))
            {
            }
            column(lblCompany; Trl('Company'))
            {
            }
            column(lblHandler; Trl('Handler'))
            {
            }
            column(lblDate; Trl('Date'))
            {
            }
            column(lblComplaintType; Trl('ComplaintType'))
            {
            }
            column(lblArticleNo; Trl('ArticleNo'))
            {
            }
            column(lblSerieNo; Trl('SerieNo'))
            {
            }
            column(lblGuarantee; Trl('Guarantee'))
            {
            }
            column(lblState; Trl('Status'))
            {
            }
            column(lbDescrTitle; Trl('DescrTitle'))
            {
            }
            column(lbCorrectiveActionTitle; Trl('CorrectiveActionTitle'))
            {
            }
            column(lbRootCauseTitle; Trl('RootCauseTitle'))
            {
            }
            column(lbPreventionTitle; Trl('PreventionTitle'))
            {
            }
            column(lbDiagnoseTitle; Trl('DiagnoseTitle'))
            {
            }
            column(lbFaultTitle; Trl('FaultTitle'))
            {
            }
            column(lbFaultDescTitle; Trl('FaultDescTitle'))
            {
            }
            column(lbHandlerTitle; Trl('HandlerTitle'))
            {
            }
            column(lbReperationTitle; Trl('ReparationTitle'))
            {
            }
            column(lbSolutionTitle; Trl('SolutionTitle'))
            {
            }
            column(lbSolutionDescTitle; Trl('SolutionDescTitle'))
            {
            }
            column(lbRepairTimeTitle; Trl('RepairTimeTitle'))
            {
            }
            column(lbRepairValueTitle; Trl('RepairValueTitle'))
            {
            }
            column(lbStateViewTitle; Trl('StateViewTitle'))
            {
            }
            column(lbComplaintDesc; Trl('ComplaintDesc'))
            {
            }
            column(gTxtNaamReport; gTxtNaamReport)
            {
            }
            column(TypeReport; gOptSoortRepAfdrukken)
            {
            }
            column(CompanyPicture; gRecCompanyInfo.Picture)
            {
            }
            column(CompanyName; gRecCompanyInfo.Name)
            {
            }
            column(HeadRMANo; "Nr.")
            {
            }
            column(HeadRegBy; "Geregistreerd door")
            {
            }
            column(HeadContactNo; "Aangemeld door Nr.")
            {
            }
            column(HeadContName; XSSComplaintsMgt.fGetNamen("Aangemeld door Soort", "Aangemeld door Nr."))
            {
            }
            column(HeadCompName; Bedrijfsnaam)
            {
            }
            column(HeadHandler; "Behandeling door")
            {
            }
            column(HeadDate; Datum)
            {
            }
            column(HeadType; Soort)
            {
            }
            column(HeadArticleNo; "Artikelnr.")
            {
            }
            column(HeadSerialNo; "Serie nr.")
            {
            }
            column(HeadWarranty; Garantie)
            {
            }
            column(HeadStatus; Status)
            {
            }
            dataitem(KlachtOpmComplaint; "XSS Complaint Comment")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemTableView = SORTING(Stuknummer, Stuksoort, "Regelnr.") ORDER(Ascending) WHERE(Stuksoort = CONST(Klacht));
                column(DateOpCom; KlachtOpmComplaint.Datum)
                {
                }
                column(Commentaar; Commentaar)
                {
                }
            }
            dataitem(KlachtOpmCorrectiveAction; "XSS Complaint Line")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemLinkReference = Klachtkop;
                DataItemTableView = SORTING(Stuknummer, Stuksoort, Datum, "Regelnr.") ORDER(Ascending) WHERE(Stuksoort = CONST(Corrigeren));
                column(DateCorAc; KlachtOpmCorrectiveAction.Datum)
                {
                }
                column(OmsCorAc; KlachtOpmCorrectiveAction.Omschrijving)
                {
                }
            }
            dataitem(KlachtOpmRootCause; "XSS Complaint Line")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemLinkReference = Klachtkop;
                DataItemTableView = SORTING(Stuknummer, Stuksoort, Datum, "Regelnr.") ORDER(Ascending) WHERE(Stuksoort = CONST("Root Cause"));
                column(DateRootCause; KlachtOpmRootCause.Datum)
                {
                }
                column(OmsRootCause; KlachtOpmRootCause.Omschrijving)
                {
                }
            }
            dataitem(KlachtOpmPreventiveAction; "XSS Complaint Line")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemLinkReference = Klachtkop;
                DataItemTableView = SORTING(Stuknummer, Stuksoort, Datum, "Regelnr.") ORDER(Ascending) WHERE(Stuksoort = CONST(Preventief));
                column(DatePreventiveAction; KlachtOpmPreventiveAction.Datum)
                {
                }
                column(OmsPreventiveAction; KlachtOpmPreventiveAction.Omschrijving)
                {
                }
            }
            dataitem(KlachtregelsDiagnoseOverz; "XSS Complaint Line")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemLinkReference = Klachtkop;
                DataItemTableView = SORTING(Stuknummer, Stuksoort, Datum, "Regelnr.") ORDER(Ascending) WHERE(Stuksoort = CONST("Diagnose overzicht"));
                column(DateDiag; KlachtregelsDiagnoseOverz.Datum)
                {
                }
                column(FaultCodeDiag; KlachtregelsDiagnoseOverz."Fout Code")
                {
                }
                column(CodeNameDiag; XSSComplaintsMgt.fRetunFaultCodeNaam("Fout Code"))
                {
                }
                column(HandledNameDiag; XSSComplaintsMgt.fGetNamen('MEDEWERKER', "Behandeld door"))
                {
                }
                column(OmsDiag; KlachtregelsDiagnoseOverz.Omschrijving)
                {
                }
            }
            dataitem(KlachtregelsReparatieOverz; "XSS Complaint Line")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemLinkReference = Klachtkop;
                DataItemTableView = SORTING(Stuknummer, Stuksoort, Datum, "Regelnr.") ORDER(Ascending) WHERE(Stuksoort = CONST("Reparatie overzicht"));
                column(DateRep; KlachtregelsReparatieOverz.Datum)
                {
                }
                column(SolvedCodeRep; KlachtregelsReparatieOverz."Oplossing code")
                {
                }
                column(SolvedCodeFuncRep; XSSComplaintsMgt.fReturnResolutionNaam("Oplossing code"))
                {
                }
                column(HandledRep; XSSComplaintsMgt.fGetNamen('MEDEWERKER', "Behandeld door"))
                {
                }
                column(RepValueRep; KlachtregelsReparatieOverz."Repair value")
                {
                }
                column(RepTimeRep; KlachtregelsReparatieOverz."Repair time")
                {
                }
                column(OmsRep; KlachtregelsReparatieOverz.Omschrijving)
                {
                }
            }
            dataitem(KlachtregelsStatusOverz; "XSS Complaint Line")
            {
                DataItemLink = Stuknummer = FIELD("Nr.");
                DataItemLinkReference = Klachtkop;
                DataItemTableView = SORTING(Stuknummer, Stuksoort, Datum, "Regelnr.") ORDER(Ascending) WHERE(Stuksoort = CONST("Status historie"));
                column(DateStat; KlachtregelsStatusOverz.Datum)
                {
                }
                column(StateStat; KlachtregelsStatusOverz.Status)
                {
                }
                column(ComplaintOmsStat; XSSComplaintsMgt.fGetStamgegevensOmschrijving('KLACHTSTATUS', Status))
                {
                }
                column(HandledStat; XSSComplaintsMgt.fGetNamen('MEDEWERKER', "Behandeld door"))
                {
                }
                column(OmsStat; KlachtregelsStatusOverz.Omschrijving)
                {
                }
            }

            trigger OnPreDataItem();
            begin

                if gOptSoortRepAfdrukken = gOptSoortRepAfdrukken::"Quality report" then
                    gTxtNaamReport := Text50000;
                if gOptSoortRepAfdrukken = gOptSoortRepAfdrukken::"RMA report" then
                    gTxtNaamReport := Text50001;
                gRecCompanyInfo.GET;
                gRecCompanyInfo.CALCFIELDS(Picture);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(gOptSoortRepAfdrukken; gOptSoortRepAfdrukken)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        //wgCduDocCreatorTransLationMgt: Codeunit wDocCreatorTranslationMgt;//Krishna
        wgReportId: Integer;
        XSSComplaintsMgt: Codeunit "XSS Complaints Mgt.";
        gTxtNaamReport: Text[30];
        gOptSoortRepAfdrukken: Option "RMA report","Quality report";
        gRecCompanyInfo: Record "Company Information";
        Text50000: TextConst ENU = 'Quality report', NLD = 'Kwaliteitsrapport';
        Text50001: TextConst ENU = 'RMA report', NLD = 'RMA rapport';

    local procedure Trl(pLblName: Text): Text;
    begin
        /*if wgReportId = 0 then begin
            EVALUATE(wgReportId, DELCHR(CurrReport.OBJECTID(false), '=', DELCHR(CurrReport.OBJECTID(false), '=', '1234567890')));
            //wgCduDocCreatorTransLationMgt.wgSetReportId(wgReportId);//Krishna
        end;
        exit(wgCduDocCreatorTransLationMgt.wgFncTranslate(pLblName));*/
        exit(pLblName);
    end;

    procedure fReturnComplaintType(pCodComplaint: Code[20]): Text[30];
    var
        lRecKlachtStamgegevens: Record "XSS Complaint Type";
    begin
        if lRecKlachtStamgegevens.GET('KLACHTSOORT', pCodComplaint) then
            exit(lRecKlachtStamgegevens."Omschrijving ENU");
    end;

    procedure fPrintSoortReport(pCodeSoort: Code[20]);
    begin
        if pCodeSoort = 'RMA' then
            gOptSoortRepAfdrukken := gOptSoortRepAfdrukken::"RMA report";
        if pCodeSoort = 'QUALITY' then
            gOptSoortRepAfdrukken := gOptSoortRepAfdrukken::"Quality report";
    end;
}

