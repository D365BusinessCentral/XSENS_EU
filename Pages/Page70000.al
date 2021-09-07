/*page 70000 "XSENS VERSION"
{
    // version XSS5.006

    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    ShowFilter = false;
    SourceTable = Object;//Cannot be defined as sourcetable

    layout
    {
        area(content)
        {
            group(Algemeen)
            {
                field(NMModified; gBoolModified)
                {
                    Caption = 'Gewijzigd';

                    trigger OnValidate();
                    begin
                        fSetFilters;
                    end;
                }
                field(Filters; gTxtGetFilters)
                {
                    Editable = false;
                    Enabled = false;
                    Width = 200;
                }
                field(ObjectIDFilters; gTxtObjectIDFilters)
                {
                    Caption = 'ObjectID Filters';
                    Editable = false;
                    Enabled = false;
                }
                field(NMCount; COUNT)
                {
                    Caption = 'Aantal objecten';
                }
            }
            grid(Control1100510011)
            {
                field("gCduManagement.fReturnHoogsteVersie(gCduManagement.fProjectAlias,true)"; gCduManagement.fReturnHoogsteVersie(gCduManagement.fProjectAlias, true))
                {
                    Caption = 'Hoogste versie';
                }
                field(TableTekst; TableTekst)
                {
                    Caption = 'Tables';
                }
                field(PageTekst; PageTekst)
                {
                    Caption = 'Pages';
                }
                field(ReportTekst; ReportTekst)
                {
                    Caption = 'Reports';
                }
                field(CodeunitTekst; CodeunitTekst)
                {
                    Caption = 'Codeunits';
                }
                field(QueryTekst; QueryTekst)
                {
                    Caption = 'Queries';
                }
                field(XMLportTekst; XMLportTekst)
                {
                    Caption = 'XMLPorts';
                }
                field(MenuSuiteTekst; MenuSuiteTekst)
                {
                    Caption = 'Menusuites';
                }
            }
            repeater(Group)
            {
                field(Type; Type)
                {
                }
                field(ID; ID)
                {
                }
                field(Name; Name)
                {
                }
                field(Modified; Modified)
                {
                }
                field(Compiled; Compiled)
                {
                }
                field(Date; Date)
                {
                }
                field(Time; Time)
                {
                }
                field("Version List"; "Version List")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Nieuwe versie")
            {
                Image = NewSerialNoProperties;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction();
                begin

                    gCduManagement.fVersienummerOphogen(Rec);
                    CurrPage.UPDATE(false);
                end;
            }
            action("Vinkjes uitzetten")
            {
                Image = Clear;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin

                    gCduManagement.fModified2False(Rec);
                end;
            }
            action("Vinkjes aanzetten")
            {
                Image = Completed;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    gCduManagement.fModified2True(Rec);
                end;
            }
            action("1 bestand per object")
            {
                Image = Split;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    gCduManagement.fCreateOneFilePerObject;
                end;
            }
            action(Bepaalobjectnrs)
            {
                Image = Refresh;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    gCduManagement.BepaalObjectnrs(Rec, TableTekst, QueryTekst, ReportTekst, CodeunitTekst, XMLportTekst, MenuSuiteTekst, PageTekst);
                end;
            }
            action("Gewijzigde objecten")
            {
                Image = Refresh;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    gBoolModified := true;
                    gTxtObjectIDFilters := '';
                    fSetFilters;
                end;
            }
            action("Std. NAV objecten met maatwerk")
            {
                Image = Refresh;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    gBoolModified := false;
                    gTxtObjectIDFilters := '1..49999|99000000..';
                    fSetFilters;
                end;
            }
            separator(Separator1100510017)
            {
            }
            action("Nieuwe Release")
            {
                Enabled = false;

                trigger OnAction();
                begin

                    gCduManagement.fVersienummerInkorten;
                    CurrPage.UPDATE(false);
                end;
            }
            action("Delete application data")
            {

                trigger OnAction();
                begin
                    gCduManagement.fRunDeleteAppData;
                end;
            }
            action("Check TRANSFERFIELDS")
            {

                trigger OnAction();
                begin
                    REPORT.RUNMODAL(70000);
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        fOnOpenForm;
        gCodHoogsteversie := 'XSS';
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        exit(fOnQueryCloseForm);
    end;

    var
        gCodHoogsteversie: Code[20];
        gCduManagement: Codeunit DatabaseMgt;
        gBoolSchermSluiten: Boolean;
        gOptModified: Option Modified,Unmodified,All;
        gCodObject: Code[1];
        gBoolExternal: Boolean;
        TableTekst: Text;
        QueryTekst: Text;
        ReportTekst: Text;
        DataportTekst: Text;
        CodeunitTekst: Text;
        XMLportTekst: Text;
        MenuSuiteTekst: Text;
        PageTekst: Text;
        Text99010: Label 'Er zijn nog gewijzigde objecten. Scherm toch sluiten?';
        gBoolModified: Boolean;
        gTxtObjectIDFilters: Text[1024];
        gTxtGetFilters: Text[1024];

    procedure fOnQueryCloseForm(): Boolean;
    begin
        // fOnQueryCloseForm 

        gBoolSchermSluiten := gCduManagement.fObjectenOK(Rec);

        if (not gBoolSchermSluiten) then
            gBoolSchermSluiten := CONFIRM(Text99010, false);

        CurrPage.UPDATE(false);
        exit(gBoolSchermSluiten);

    end;

    procedure fSetOptions();
    begin
    end;

    procedure fSetFilters();
    begin
        // fSetFilters 

        gTxtGetFilters := '';
        gCduManagement.fObjectenSetFilters(Rec, gCodObject, gCodHoogsteversie, gTxtObjectIDFilters, gBoolModified);
        gCduManagement.BepaalObjectnrs(Rec, TableTekst, QueryTekst, ReportTekst, CodeunitTekst, XMLportTekst, MenuSuiteTekst, PageTekst);
        gTxtGetFilters := GETFILTERS;
        CurrPage.UPDATE(false);

    end;

    procedure fSetObject(pCodObject: Code[1]);
    begin
        // fSetObject 

        gCodObject := pCodObject;
        fSetFilters;

    end;

    procedure fOnOpenForm();
    begin
        // fOnOpenForm 

        gBoolModified := true;
        gOptModified := 0;
        //gCodObject   := 'A';
        fSetFilters;

    end;
}

*/