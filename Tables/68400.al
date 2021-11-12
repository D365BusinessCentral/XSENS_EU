table 68400 "XSS Complaint Header"
{
    // version KLA1.00,XSS5.036

    // 20090918 GFR 20799: Velden 15 t/m 19 toegevoegd.
    // 20091014 GFR 21074: Veld 20: Valid toegevoegd.
    // 20091119 GFR 21424: Handmatige invoer klachtnrs toestaan
    // 20160718 KBG 06458: Veld 21 "Customer contact name" toegevoegd.

    CaptionML = ENU = 'Complaint Header',
                NLD = 'Klachtkop';
    DrillDownPageID = 68403;
    LookupPageID = 68403;

    fields
    {
        field(1; "Nr."; Code[20])
        {
            CaptionML = ENU = 'No.',
                        NLD = 'Nr.';
            Editable = true;

            trigger OnValidate();
            begin
                gCduKlacht.fKKONrOnValidate(xRec, Rec);
            end;
        }
        field(2; Datum; Date)
        {
            CaptionML = ENU = 'Date',
                        NLD = 'Datum';
        }
        field(3; Soort; Code[20])
        {
            CaptionML = ENU = 'Type',
                        NLD = 'Soort';
            TableRelation = "XSS Complaint Type".Code WHERE(Codesoort = CONST('KLACHTSOORT'),
                                                             Actief = CONST(true));
        }
        field(4; "Geregistreerd door"; Code[10])
        {
            CaptionML = ENU = 'Registered by',
                        NLD = 'Geregistreerd door';
            TableRelation = Employee."No.";
        }
        field(5; "Behandeling door"; Code[10])
        {
            CaptionML = ENU = 'Assigned to',
                        NLD = 'Behandeling door';
            TableRelation = Employee."No.";
        }
        field(6; "Aangemeld door Soort"; Code[20])
        {
            CaptionML = ENU = 'Registered by Type',
                        NLD = 'Aangemeld door Soort';
            TableRelation = "XSS Complaint Type".Code WHERE(Codesoort = CONST('AANGEMELDDOOR'),
                                                             Actief = CONST(true));

            trigger OnValidate();
            begin
                gCduKlacht.fKKOAangemeldTypeOnvalidate(xRec, Rec);
            end;
        }
        field(7; "Aangemeld door Nr."; Code[20])
        {
            CaptionML = ENU = 'Registered by No.',
                        NLD = 'Aangemeld door Nr.';
            TableRelation = IF ("Aangemeld door Soort" = CONST('RELATIE')) Contact."No."
            ELSE
            IF ("Aangemeld door Soort" = CONST('MEDEWERKER')) Employee."No."
            ELSE
            IF ("Aangemeld door Soort" = CONST('IN-VERKOPER')) "Salesperson/Purchaser".Code;

            trigger OnValidate();
            begin
                gCduKlacht.fZoekGekoppeldeRelatie(Rec); //20090918 GFR 20799
            end;
        }
        field(9; "Relatienr."; Code[20])
        {
            CaptionML = ENU = 'Contact No.',
                        NLD = 'Relatienr.';
            TableRelation = Contact;

            trigger OnValidate();
            begin
                gCduKlacht.fKKOBronnrOnvalidate(xRec, Rec);
            end;
        }
        field(10; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "Artikelnr."; Code[20])
        {
            CaptionML = ENU = 'Item No.',
                        NLD = 'Artikelnr.';
            TableRelation = Item."No.";

            trigger OnValidate();
            begin
                gCduKlacht.fKKOItemOnValidate(xRec, Rec);
            end;
        }
        field(12; "Serviceartikelnr."; Code[20])
        {
            CaptionML = ENU = 'Service Item No.',
                        NLD = 'Serviceartikelnr.';

            trigger OnLookup();
            begin
                gCduKlacht.fKKOServItemOnLookup(xRec, Rec);
            end;

            trigger OnValidate();
            begin
                gCduKlacht.fKKOServItemOnValidate(xRec, Rec);
            end;
        }
        field(13; "Klacht over Medewerker"; Code[20])
        {
            CaptionML = ENU = 'Complaint on Employee',
                        NLD = 'Klacht over medewerker';
            TableRelation = Employee;
        }
        field(14; Status; Code[20])
        {
            CaptionML = ENU = 'Status',
                        NLD = 'Status';
            Editable = false;
        }
        field(15; Zakenrelatie; Code[20])
        {
            CaptionML = ENU = 'Business relation',
                        NLD = 'Zakenrelatie';
        }
        field(16; Bedrijfsnaam; Text[50])
        {
            CaptionML = ENU = 'Company',
                        NLD = 'Bedrijfsnaam';
        }
        field(17; RMA; Option)
        {
            BlankZero = true;
            CaptionML = ENU = 'RMA',
                        NLD = 'RMA';
            OptionCaptionML = ENU = ' ,Yes,No',
                              NLD = ',Ja,Nee';
            OptionMembers = " ",Yes,No;
        }
        field(18; Garantie; Option)
        {
            BlankZero = true;
            CaptionML = ENU = 'Warranty',
                        NLD = 'Garantie';
            OptionCaptionML = ENU = ' ,Yes,No',
                              NLD = ',Ja,Nee';
            OptionMembers = " ",Yes,No;
        }
        field(19; "Serie nr."; Code[30])
        {
            CaptionML = ENU = 'Serial no.',
                        NLD = 'Serie nr.';
        }
        field(20; Geldigheid; Option)
        {
            CaptionML = ENU = 'Valid',
                        NLD = 'Geldigheid';
            OptionCaptionML = ENU = ' ,Yes,No',
                              NLD = ',Ja,Nee';
            OptionMembers = " ",Yes,No;
        }
        field(21; "Customer contact name"; Text[50])
        {
            CaptionML = ENU = 'Customer Contact Name',
                        NLD = 'Klant contactnaam';
        }
        field(200; "Complaint Description"; BLOB)
        {
            CaptionML = ENU = 'Complaint Description',
                        NLD = 'Omschrijving van klacht';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Nr.")
        {
        }
        key(Key2; "Relatienr.")
        {
        }
        key(Key3; "Relatienr.", "Serviceartikelnr.", "Artikelnr.")
        {
        }
        key(Key4; "Artikelnr.")
        {
        }
        key(Key5; "Serviceartikelnr.")
        {
        }
        key(Key6; "Klacht over Medewerker")
        {
        }
        key(Key7; "Geregistreerd door")
        {
        }
        key(Key8; "Behandeling door")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        gCduKlacht.fKKOOnDelete(Rec);
    end;

    trigger OnInsert();
    begin
        gCduKlacht.fKKOOnInsert(xRec, Rec)
    end;

    var
        gCduKlacht: Codeunit 68400;
        NoSeriesMgt: Codeunit 396;

    procedure SetComplaintDescription(NewComplaintDescription: Text);
    var
        //TempBlob: Record TempBlob temporary;
        OStream: OutStream;
    begin
        CLEAR("Complaint Description");
        "Complaint Description".CreateOutStream(OStream, TextEncoding::Windows);
        Modify();
        // IF NewComplaintDescription = '' THEN
        //     EXIT;
        // TempBlob.Blob := "Complaint Description";
        // TempBlob.WriteAsText(NewComplaintDescription, TEXTENCODING::Windows);
        // "Complaint Description" := TempBlob.Blob;
        // MODIFY;
    end;

    procedure GetComplaintDescription() ComplaintDescription: Text;
    var
        //TempBlob: Record TempBlob temporary;
        CR: Text[1];
        IStream: InStream;
        TypeHelper: Codeunit "Type Helper";
    begin
        CALCFIELDS("Complaint Description");
        "Complaint Description".CreateInStream(IStream, TextEncoding::Windows);
        if not TypeHelper.TryReadAsTextWithSeparator(IStream, TypeHelper.LFSeparator(), ComplaintDescription) then;
        // IF NOT "Complaint Description".HASVALUE THEN
        //     EXIT('');
        // CR[1] := 10;
        // TempBlob.Blob := "Complaint Description";
        // EXIT(TempBlob.ReadAsText(CR, TEXTENCODING::Windows));
    end;
}

