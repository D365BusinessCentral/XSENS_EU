report 50009 "Prod. Order - Mat. Req.XSS DCR"
{
    // version XSS5.083

    // 20181017 GW         : New report based on R99000765.
    // 20190715 MDO NMSD-59: Nieuwe oplossing voor EAN128 barcode geimplementeerd. Download van Mibuso die er in NAV een Bitmap van maakt in een Blob.
    // DefaultLayout = RDLC;
    // RDLCLayout = 'Reports\P2\Prod. Order - Mat. Req.XSS DCR.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Report50009\Report50009.rdl';

    CaptionML = ENU = 'Prod. Order - Mat. Requisition',
                NLD = 'PO - Mat.-behoefte';

    dataset
    {
        dataitem("Production Order"; "Production Order")
        {
            DataItemTableView = SORTING(Status, "No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = Status, "No.", "Source Type", "Source No.";
            column(lblProdOrder; Trl('Production Order'))
            {
            }
            column(lblSalesOrder; Trl('Sales Order'))
            {
            }
            column(lblSourceNo; Trl('Source No.'))
            {
            }
            column(lblQuantityHeader; Trl('Quantity'))
            {
            }
            column(lblOperator; Trl('Operator'))
            {
            }
            column(lblDescription; Trl('Description'))
            {
            }
            column(lblDate; Trl('Date'))
            {
            }
            column(lblDueDate; Trl('DueDate'))
            {
            }
            column(lblQuantity; Trl('Quantity'))
            {
            }
            column(lblPage; Trl('Page'))
            {
            }
            column(lblUser; Trl('User'))
            {
            }
            column(lblCompletionDT; CompletionDTLbl)
            {
            }
            column(lblUoM; UoMLbl)
            {
            }
            column(lblScrap; ScrapLbl)
            {
            }
            column(CompanyPicture; gRecCompanyInformation.Picture)
            {
            }
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(No; "No.")
            {
            }
            column(SourceNo; "Source No.")
            {
                IncludeCaption = true;
            }
            column(ProdOrderQuantity; "Production Order".Quantity)
            {
            }
            column(BC_PO_No_Formatted; gTxtBarcodeProdOrder)
            {
                //OptionCaptionML = ENU = 'BC_PO_No_Formatted',   NLD = 'BC_PO_No_Formatted';//Krishna
            }
            column(BC_PO_SourceNo_Formatted; gTxtBarcodeSourceNo)
            {
                //OptionCaptionML = ENU = 'BC_PO_SourceNo_Formatted', NLD = 'BC_PO_SourceNo_Formatted';//Krishna
            }
            column(BC_PO_Quantity; gTxtBarcodeQuantity)
            {
                //OptionCaptionML = ENU = 'BC_PO_Quantity', NLD = 'BC_PO_Quantity';//Krishna
            }
            column(ProdOrderNoEAN8; gTxtBarcodeProdOrderEAN82)
            {
            }
            column(BarcodeProdOrderNo; gRecTMPBlob.Blob1)
            {
            }
            column(BarcodeSourceNo; gRecTMPBlob2.Blob2)
            {
            }
            column(BarcodeQuantity; gRecTMPBlob3.Blob3)
            {
            }
            column(UserID; UserId)
            {
            }
            dataitem("Prod. Order Line"; "Prod. Order Line")
            {
                DataItemLink = "Prod. Order No." = FIELD("No."), Status = FIELD(Status);
                DataItemTableView = SORTING("Prod. Order No.", "Line No.", Status);
                PrintOnlyIfDetail = true;
                column(Qty; Quantity)
                {
                    IncludeCaption = true;
                }
                column(DueDate; FORMAT("Due Date", 0, 4))
                {
                }
                column(SalesOrder; gCduReservationEngineMgt.CreateForText(gRecReservEntry))
                {
                }
                dataitem("Prod. Order Component"; "Prod. Order Component")
                {
                    DataItemLink = Status = FIELD(Status), "Prod. Order No." = FIELD("Prod. Order No.");
                    DataItemTableView = SORTING(Status, "Prod. Order No.", "Prod. Order Line No.", "Line No.");
                    column(ItemNo; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(Qtyper; "Quantity per")
                    {
                        IncludeCaption = true;
                    }
                    column(UOMCode; "Unit of Measure Code")
                    {
                        IncludeCaption = true;
                    }
                    column(RemainingQty; "Remaining Quantity")
                    {
                        IncludeCaption = true;
                    }
                    column(Scrap; "Scrap %")
                    {
                        IncludeCaption = true;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype");
                        ReservationEntry.SETRANGE("Source Type", DATABASE::"Prod. Order Component");
                        ReservationEntry.SETRANGE("Source ID", "Production Order"."No.");
                        ReservationEntry.SETRANGE("Source Ref. No.", "Line No.");
                        ReservationEntry.SETRANGE("Source Subtype", Status);
                        ReservationEntry.SETRANGE("Source Batch Name", '');
                        ReservationEntry.SETRANGE("Source Prod. Order Line", "Prod. Order Line No.");
                        if ReservationEntry.FINDSET then begin
                            RemainingQtyReserved := 0;
                            repeat
                                if ReservationEntry2.GET(ReservationEntry."Entry No.", not ReservationEntry.Positive) then
                                    if (ReservationEntry2."Source Type" = DATABASE::"Prod. Order Line") and
                                       (ReservationEntry2."Source ID" = "Prod. Order Component"."Prod. Order No.")
                                    then
                                        RemainingQtyReserved += ReservationEntry2."Quantity (Base)";
                            until ReservationEntry.NEXT = 0;
                            if "Prod. Order Component"."Remaining Qty. (Base)" = RemainingQtyReserved then
                                CurrReport.SKIP;
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETFILTER("Remaining Quantity", '<>0');
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if "Item No." <> '' then begin
                        CLEAR(gRecReservEntry);
                        gCduReservationEngineMgt.InitFilterAndSortingLookupFor(gRecReservEntry, true);
                        //gCduReserveProdOrderLine.FilterReservFor(gRecReservEntry, "Prod. Order Line");
                        "Prod. Order Line".SetReservationEntry(gRecReservEntry);
                        if gRecReservEntry.FINDFIRST then;
                    end;
                end;
            }

            trigger OnAfterGetRecord();
            var
                lTxtProdOrder: Text[20];
                EntryNoL: Integer;
            begin
                //NM_BEGIN 20190715 MDO NMSD-59
                //Bestaande code voor Barcode uitgeschakeld. Dit kregen we zo snel niet werkend en daarom
                //een andere oplossing geimplementeerd waarmee een barcode als Bitmap wordt gemaakt.

                gTxtBarcodeProdOrder := fCode128("Production Order"."No.");
                gTxtBarcodeSourceNo := fCode128("Production Order"."Source No.");
                gTxtBarcodeQuantity := fCode128(STRSUBSTNO('%1', FORMAT("Production Order".Quantity)));     //20160919 KBG 07475

                // ------------------------------------------------------------------------------------------------
                // Hieronder roept het systeem functies aan om Barcodes EAN128 te genereren. De functies maken
                // hiervan een Bitmap in TempBlob wordt ingelezen en als afbeelding wordt afgedrukt op het rapport.
                // ------------------------------------------------------------------------------------------------
                gRecTMPBlob.Reset();
                gRecTMPBlob2.Reset();
                gRecTMPBlob3.Reset();
                EntryNoL := gRecTMPBlob.GetEntryNo();
                Clear(gRecTMPBlob);
                gRecTMPBlob.Init();
                gRecTMPBlob."Entry No." := EntryNoL;
                gCduGeneral.fBarcodeCreatorV15EncodeCode128("Production Order"."No.", 2, false, gRecTMPBlob, 1);
                gCduGeneral.fBarcodeCreatorV15EncodeCode128("Production Order"."Source No.", 2, false, gRecTMPBlob, 2);
                gCduGeneral.fBarcodeCreatorV15EncodeCode128(STRSUBSTNO('%1', FORMAT("Production Order".Quantity)), 2, false, gRecTMPBlob, 3);
                //NM_END 20190715 MDO NMSD-59

                // Barcode.DoGenerateBarcode("No.", 2, TempBlob);
                // Barcode.DoGenerateBarcode("Source No.", 2, gRecTMPBlob2);
            end;

            trigger OnPreDataItem();
            begin
                ProdOrderFilter := GETFILTERS;
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

    trigger OnInitReport();
    begin
        gRecCompanyInformation.GET;
        gRecCompanyInformation.CALCFIELDS(Picture);
    end;

    trigger OnPreReport();
    begin
        //CurrReport.LANGUAGE := gRecLanguage.GetLanguageID('ENU');//krishna
        //wgCduDocCreatorTransLationMgt.wgSetLanguageCode('ENU');//Krishna
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        BlobMag.DeleteAll();
    end;

    var
        BlobMag: Record "Blob Management";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        ProdOrderFilter: Text;
        RemainingQtyReserved: Decimal;
        //wgCduDocCreatorTransLationMgt: Codeunit wDocCreatorTranslationMgt;
        wgReportId: Integer;
        gRecCompanyInformation: Record "Company Information";
        ProdOrderMaterialRqstnCaptLbl: TextConst ENU = 'Prod. Order - Material Requisition', NLD = 'Productieorder - Materiaalbehoefte';
        gRecLanguage: Record Language;
        gCduReserveProdOrderLine: Codeunit "Prod. Order Line-Reserve";
        gRecReservEntry: Record "Reservation Entry";
        gCduReservationEngineMgt: Codeunit "Reservation Engine Mgt.";
        CompletionDTLbl: TextConst ENU = 'Completion Date and Time', NLD = 'Completion Date and Time';
        ScrapLbl: TextConst ENU = 'S%', NLD = 'U%';
        UoMLbl: TextConst ENU = 'UoM', NLD = 'Eenheid';
        gTxtBarcodeProdOrder: Text[100];
        gTxtBarcodeSourceNo: Text[100];
        gTxtBarcodeQuantity: Text[100];
        Checksum: Integer;
        gTxtBarcodeProdOrderEAN8: Text[20];
        gTxtBarcodeProdOrderEAN82: Text[20];
        gCduGeneral: Codeunit Algemeen;
        gRecTMPBlob: Record "Blob Management" temporary; //TempBlob temporary;
        gRecTMPBlob2: Record "Blob Management" temporary;//TempBlob temporary;
        gRecTMPBlob3: Record "Blob Management" temporary;//TempBlob temporary;
                                                         //TempBlob: Record TempBlob temporary;

    procedure "fEncodeBarcode128-1"(pText: Text[250]) RetVal: Text[250];
    var
        Checksum: Integer;
        i: Integer;
        currentchar: Char;
        StartChar: Char;
        StopChar: Char;
        ChecksumChar: Char;
    begin
        // How to encode a 128 barcode:
        //
        // Each character has a value ranging from 0 to 105. This value is used to calculate the check
        // character for each symbol.
        //
        // The check character is a Modulus 103 Checksum that is calculated by summing the start code
        // value plus the product of each character position (most significant character position equals 1)
        // and the character value of the character at that position. This sum is divided by 103. The
        // remainder of the answer is the value of the Check Character (which can be looked up from the
        // table). Every encoded character is included except the Stop and Check Character.
        //
        //
        // Example: BarCode 1
        // Message : Start B   B   a   r   C   o   d   e      1
        // Value      104      34  65  82  35  79  68  69  0  17
        // Position:   -       1   2   3   4   5   6   7   8  9
        // Calculate Total: 104 + (34x1) + (65x2) + (82x3) + (35x4) + (79x5) +
        //                  (68x6) + (69x7) + (0x8) + (17x9) = 2093
        // 2093/103 = 20 remainder 33
        // 33 = A
        // Final message: (Start B)BarCode 1(A)(STOP)

        StartChar := 'À';
        StopChar := 'Â';
        Checksum := 104;

        for i := 1 to STRLEN(pText) do begin
            currentchar := pText[i];
            Checksum := Checksum + (i * (currentchar - 32));
        end;
        ChecksumChar := Checksum mod 103;

        //ChecksumChar:= ChecksumChar+32;    //20160617 KBG 03027
        case ChecksumChar of
            0:
                ChecksumChar := 176;//B0h
            1 .. 94:
                ChecksumChar := ChecksumChar + 32;
            95 .. 101:
                ChecksumChar := ChecksumChar + 105;
            102:
                ChecksumChar := 213; //D5h
        end;


        // convert SPACE to ALT+0128
        pText := CONVERTSTR(pText, ' ', '');

        RetVal := STRSUBSTNO('%1%2%3%4', StartChar, pText, ChecksumChar, StopChar);
        exit(RetVal);
    end;

    procedure "fEncodeBarcode128-2"(pText: Text[250]) RetVal: Text[250];
    var
        Checksum: Integer;
        i: Integer;
        currentchar: Char;
        StartChar: Char;
        StopChar: Char;
        ChecksumChar: Char;
    begin
        /* fEncodeBarcode128 */

        // NM_BEGIN 20071011 GFR 14567
        // Nederland:
        // Hoe wordt de codering van de 129 barcode gebruikt. How to encode a 128 barcode:

        // Elk karakter heeft een waarde van 0 tot en met 105. Deze waarde is nodig om de berekening te
        // maken voor elk symbool

        // De berekening is een Nodules 103 chechsum dat wordt berekent door de ("start code"
        // waarde plus) de (uitkomst van elke karakter zijn waarde maal de positie van het karakter).

        // Het resultaat van de berekening is de waarde van de check karakter, de uitkomst wordt dan gedeeld
        // door 103

        // The check character is a Modulus 103 Checksum that is calculated by summing the start code
        // value plus the product of each character position (most significant character position equals 1)
        // and the character value of the character at that position. This sum is divided by 103. The
        // remainder of the answer is the value of the Check Character (which can be looked up from the
        // table). Every encoded character is included except the Stop and Check Character.

        // NM_END 20071011 GFR 14567

        // Example: BarCode 1
        // Message : Start B   B   a   r   C   o   d   e      1
        // Value      104      34  65  82  35  79  68  69  0  17
        // Position:   -       1   2   3   4   5   6   7   8  9
        // Calculate Total: 104 + (34x1) + (65x2) + (82x3) + (35x4) + (79x5) +
        //                  (68x6) + (69x7) + (0x8) + (17x9) = 2093
        // 2093/103 = 20 remainder 33
        // 33 = A
        // Final message: (Start B)BarCode 1(A)(STOP)

        StartChar := 'À';
        StopChar := 'Â';
        //NM_BEGIN 20080109 GFR 15386
        //Checksum:=104;
        case ChecksumChar of
            0:
                ChecksumChar := 176;//B0h
            1 .. 94:
                ChecksumChar := ChecksumChar + 32;
            95 .. 101:
                ChecksumChar := ChecksumChar + 105;
            102:
                ChecksumChar := 213; //D5h
        end;
        //NM_END 20080109 GFR 15386

        for i := 1 to STRLEN(pText) do begin
            currentchar := pText[i];
            Checksum := Checksum + (i * (currentchar - 32));
        end;
        ChecksumChar := Checksum mod 103;
        ChecksumChar := ChecksumChar + 32;

        // convert SPACE to ALT+0128
        pText := CONVERTSTR(pText, ' ', '');

        RetVal := STRSUBSTNO('%1%2%3%4', StartChar, pText, ChecksumChar, StopChar);
        exit(RetVal);

    end;

    procedure "fEncodeBarcode128bWin-1"(BarcodeIn: Text[250]) BarcodeRet: Text[250];
    var
        i: Integer;
        StartChar: Char;
        StopChar: Char;
        ChecksumChar: Char;
        Checksum: Integer;
    begin
        StartChar := 'š'; // ASCII 154
        StopChar := 'œ'; // ASCII 156

        //Checksum := 104;
        case ChecksumChar of
            0:
                ChecksumChar := 176;//B0h
            1 .. 94:
                ChecksumChar := ChecksumChar + 32;
            95 .. 101:
                ChecksumChar := ChecksumChar + 105;
            102:
                ChecksumChar := 213; //D5h
        end;

        for i := 1 to STRLEN(BarcodeIn) do
            Checksum := Checksum + (i * fTextToInt(COPYSTR(BarcodeIn, i, 1)));

        Checksum := Checksum mod 103;
        ChecksumChar := fIntToChar(Checksum);

        BarcodeIn := CONVERTSTR(BarcodeIn, ' ', '€'); // To convert Spaces to ASCII128 (=Euro sign)
        BarcodeRet := STRSUBSTNO('%1%2%3%4', StartChar, BarcodeIn, ChecksumChar, StopChar);

        exit(BarcodeRet);
    end;

    procedure "fEncodeBarcode128bWin-2"(BarcodeIn: Text[250]) BarcodeRet: Text[250];
    var
        i: Integer;
        StartChar: Char;
        StopChar: Char;
        ChecksumChar: Char;
    begin
        StartChar := 'š'; // ASCII 154
        StopChar := 'œ'; // ASCII 156

        Checksum := 104;

        for i := 1 to STRLEN(BarcodeIn) do
            Checksum := Checksum + (i * fTextToInt(COPYSTR(BarcodeIn, i, 1)));

        Checksum := Checksum mod 103;
        //IF Checksum > 64 THEN
        //  Checksum := Checksum - 64;
        ChecksumChar := fIntToChar(Checksum);

        BarcodeIn := CONVERTSTR(BarcodeIn, ' ', ''); // To convert Spaces to ASCII128 (=Euro sign)
        BarcodeRet := STRSUBSTNO('%1%2%3%4', StartChar, BarcodeIn, ChecksumChar, StopChar);

        exit(BarcodeRet);
    end;

    local procedure fTextToInt(TextIn: Text[30]) IntRet: Integer;
    begin
        // These characters can be used in a text string to print in a barcode font!
        case TextIn of
            'SPACE':
                exit(0);
            ' ':
                exit(0); // ASCII 32
            '!':
                exit(1); // ASCII 33
            '"':
                exit(2); // ASCII 33
            '#':
                exit(3); // etc
            '$':
                exit(4);
            '%':
                exit(5);
            '&':
                exit(6);
            '''':
                exit(7);
            '(':
                exit(8);
            ')':
                exit(9);
            '*':
                exit(10);
            '+':
                exit(11);
            ',':
                exit(12);
            '-':
                exit(13);
            '.':
                exit(14);
            '/':
                exit(15);
            '0':
                exit(16);
            '1':
                exit(17);
            '2':
                exit(18);
            '3':
                exit(19);
            '4':
                exit(20);
            '5':
                exit(21);
            '6':
                exit(22);
            '7':
                exit(23);
            '8':
                exit(24);
            '9':
                exit(25);
            ':':
                exit(26);
            ';':
                exit(27);
            '<':
                exit(28);
            '=':
                exit(29);
            '>':
                exit(30);
            '?':
                exit(31);
            '@':
                exit(32);
            'A':
                exit(33);
            'B':
                exit(34);
            'C':
                exit(35);
            'D':
                exit(36);
            'E':
                exit(37);
            'F':
                exit(38);
            'G':
                exit(39);
            'H':
                exit(40);
            'I':
                exit(41);
            'J':
                exit(42);
            'K':
                exit(43);
            'L':
                exit(44);
            'M':
                exit(45);
            'N':
                exit(46);
            'O':
                exit(47);
            'P':
                exit(48);
            'Q':
                exit(49);
            'R':
                exit(50);
            'S':
                exit(51);
            'T':
                exit(52);
            'U':
                exit(53);
            'V':
                exit(54);
            'W':
                exit(55);
            'X':
                exit(56);
            'Y':
                exit(57);
            'Z':
                exit(58);
            '[':
                exit(59);
            '\':
                exit(60);
            ']':
                exit(61);
            '^':
                exit(62);
            '_':
                exit(63);
            '`':
                exit(64);
            'a':
                exit(65);
            'b':
                exit(66);
            'c':
                exit(67);
            'd':
                exit(68);
            'e':
                exit(69);
            'f':
                exit(70);
            'g':
                exit(71);
            'h':
                exit(72);
            'i':
                exit(73);
            'j':
                exit(74);
            'k':
                exit(75);
            'l':
                exit(76);
            'm':
                exit(77);
            'n':
                exit(78);
            'o':
                exit(79);
            'p':
                exit(80);
            'q':
                exit(81);
            'r':
                exit(82);
            's':
                exit(83);
            't':
                exit(84);
            'u':
                exit(85);
            'v':
                exit(86);
            'w':
                exit(87);
            'x':
                exit(88);
            'y':
                exit(89);
            'z':
                exit(90);
            '{':
                exit(91);
            '|':
                exit(92);
            '}':
                exit(93);
            '~':
                exit(94);
        end;
    end;

    local procedure fIntToChar(IntIn: Integer) CharRet: Char;
    begin
        // To convert the Checksum integer to a character:
        // Code128bWin: 1-94 => ASCII 33-125
        // Code128bWin: 0 => ASCII 128
        // Code128bWin: 95-102 => ASCII 144-152
        // Eg. ASCII 49 = Code128bWin 17, ASCII 147 = Code128bWin 97
        // To get the characters in Navision, use a Text Editer (eg. UltraEdit) to
        // insert the ASCII character, and copy it to here

        exit;//JVW
        case IntIn of
            //  0:EXIT('€'); // ASCII 128
            0:
                exit(''); // ASCII 128
            1:
                exit('!'); // ASCII 33
            2:
                exit('"'); // ASCII 34
            3:
                exit('#'); // etc..
            4:
                exit('$');
            5:
                exit('%');
            6:
                exit('&');
            7:
                exit(''''); // insert this character twice!
            8:
                exit('(');
            9:
                exit(')');
            10:
                exit('*');
            11:
                exit('+');
            12:
                exit(',');
            13:
                exit('-');
            14:
                exit('.');
            15:
                exit('/');
            16:
                exit('0');
            17:
                exit('1');
            18:
                exit('2');
            19:
                exit('3');
            20:
                exit('4');
            21:
                exit('5');
            22:
                exit('6');
            23:
                exit('7');
            24:
                exit('8');
            25:
                exit('9');
            26:
                exit(':');
            27:
                exit(';');
            28:
                exit('<');
            29:
                exit('=');
            30:
                exit('>');
            31:
                exit('?');
            32:
                exit('@');
            33:
                exit('A');
            34:
                exit('B');
            35:
                exit('C');
            36:
                exit('D');
            37:
                exit('E');
            38:
                exit('F');
            39:
                exit('G');
            40:
                exit('H');
            41:
                exit('I');
            42:
                exit('J');
            43:
                exit('K');
            44:
                exit('L');
            45:
                exit('M');
            46:
                exit('N');
            47:
                exit('O');
            48:
                exit('P');
            49:
                exit('Q');
            50:
                exit('R');
            51:
                exit('S');
            52:
                exit('T');
            53:
                exit('U');
            54:
                exit('V');
            55:
                exit('W');
            56:
                exit('X');
            57:
                exit('Y');
            58:
                exit('Z');
            59:
                exit('[');
            60:
                exit('\');
            61:
                exit(']');
            62:
                exit('^');
            63:
                exit('_');
            64:
                exit('`');
            65:
                exit('a');
            66:
                exit('b');
            67:
                exit('c');
            68:
                exit('d');
            69:
                exit('e');
            70:
                exit('f');
            71:
                exit('g');
            72:
                exit('h');
            73:
                exit('i');
            74:
                exit('j');
            75:
                exit('k');
            76:
                exit('l');
            77:
                exit('m');
            78:
                exit('n');
            79:
                exit('o');
            80:
                exit('p');
            81:
                exit('q');
            82:
                exit('r');
            83:
                exit('s');
            84:
                exit('t');
            85:
                exit('u');
            86:
                exit('v');
            87:
                exit('w');
            88:
                exit('x');
            89:
                exit('y');
            90:
                exit('z');
            91:
                exit('{');
            92:
                exit('|');
            93:
                exit('}');
            94:
                exit('~');
            95:
                exit('‘'); // ASCII 145
            96:
                exit('’'); // ASCII 146
            97:
                exit('“'); // ASCII 147
            98:
                exit('”'); // ASCII 148
            99:
                exit('•'); // ASCII 149
            100:
                exit('–'); // ASCII 150
            101:
                exit('—'); // ASCII 151
            102:
                exit('˜'); // ASCII 152
        end;
    end;

    procedure "----"();
    begin
    end;

    procedure GenerateBarCode(InString: Text[15]) BarCodeString: Text[15];
    var
        i: Integer;
        checksum: Char;
        first: Char;
        barcode: Char;
        "Table": Integer;
        WorkString: Text[14];
    begin
        for i := 1 to 12 do
            if CharToInt(InString[i]) > -1 then begin
                WorkString[i] := InString[i];
            end;
        for i := 2 to 12 do begin
            checksum := checksum + (CharToInt(InString[i]));
            i := i + 1;
        end;
        checksum := checksum * 3;
        for i := 1 to 11 do begin
            checksum := checksum + (CharToInt(InString[i]));
            i := i + 1;
        end;
        WorkString[13] := IntToChar((10 - checksum mod 10) mod 10);
        first := CharToInt(InString[1]);
        BarCodeString[1] := IntToChar(first);
        BarCodeString[2] := (65 + CharToInt(WorkString[2]));
        for i := 3 to 7 do begin
            Table := 0;
            case i of
                3:
                    begin
                        if (first < 4) and (first > 1) then
                            Table := 1;
                    end;
                4:
                    begin
                        if (first = 0) or (first = 4) or (first = 7) or (first = 8) then
                            Table := 1;
                    end;
                5:
                    begin
                        if (first = 0) or (first = 1) or (first = 4) or (first = 5) or (first = 9) then
                            Table := 1;
                    end;
                6:
                    begin
                        if (first = 0) or (first = 2) or (first = 5) or (first = 6) or (first = 7) then
                            Table := 1;
                    end;
                7:
                    begin
                        if (first = 0) or (first = 3) or (first = 6) or (first = 8) or (first = 9) then
                            Table := 1;
                    end;
            end;
            if Table = 1 then
                BarCodeString[i] := (65 + CharToInt(WorkString[i]))
            else
                BarCodeString[i] := (75 + CharToInt(WorkString[i]));
        end;
        BarCodeString[8] := '*';
        for i := 8 to 13 do
            BarCodeString[i + 1] := (97 + CharToInt(WorkString[i]));
        BarCodeString[15] := '+';
        //Testmessage
        //MESSAGE(BarCodeString);
    end;

    procedure CharToInt(c: Char) n: Integer;
    begin
        case c of
            '0':
                begin
                    n := 0;
                    exit;
                end;
            '1':
                begin
                    n := 1;
                    exit;
                end;

            '2':
                begin
                    n := 2;
                    exit;
                end;

            '3':
                begin
                    n := 3;
                    exit;
                end;

            '4':
                begin
                    n := 4;
                    exit;
                end;

            '5':
                begin
                    n := 5;
                    exit;
                end;

            '6':
                begin
                    n := 6;
                    exit;
                end;

            '7':
                begin
                    n := 7;
                    exit;
                end;
            '8':
                begin
                    n := 8;
                    exit;
                end;

            '9':
                begin
                    n := 9;
                    exit;
                end;
            else begin
                    n := -1;
                    exit;
                end;
        end;
    end;

    procedure IntToChar(n: Integer) c: Char;
    begin
        case n of
            0:
                begin
                    c := '0';
                    exit;
                end;
            1:
                begin
                    c := '1';
                    exit;
                end;

            2:
                begin
                    c := '2';
                    exit;
                end;

            3:
                begin
                    c := '3';
                    exit;
                end;

            4:
                begin
                    c := '4';
                    exit;
                end;

            5:
                begin
                    c := '5';
                    exit;
                end;

            6:
                begin
                    c := '6';
                    exit;
                end;

            7:
                begin
                    c := '7';
                    exit;
                end;
            8:
                begin
                    c := '8';
                    exit;
                end;

            9:
                begin
                    c := '9';
                    exit;
                end;
            else begin
                    c := 'X';
                    exit;
                end;
        end;
    end;

    procedure fCode128(pTxtCode: Text[250]) lTxtCode128Barcode: Text[250];
    begin
        // Gegeven: pTxtCode
        // Levert: Code128 gecodeerde string voor gebruik icm Code128bWin.ttf font
        IF flIsNumeric(pTxtCode) THEN        //20160919 KBG 07475
            EXIT(flCode128c(pTxtCode))
        ELSE
            exit(flCode128b(pTxtCode));
    end;

    local procedure flCode128b(pTxtCode: Text[250]) lTxtCode128Barcode: Text[250];
    var
        lIntEncoded128Array: array[250] of Integer;
        i: Integer;
        j: Integer;
    begin
        lIntEncoded128Array[1] := 104; // STARTCHAR B
        for i := 1 to STRLEN(pTxtCode) do
            lIntEncoded128Array[i + 1] := flTextToInt(COPYSTR(pTxtCode, i, 1));
        lIntEncoded128Array[i + 2] := flChecksum(lIntEncoded128Array, i + 1);
        lIntEncoded128Array[i + 3] := 106; // STOPCHAR
        for j := 1 to i + 3 do
            lTxtCode128Barcode := lTxtCode128Barcode + FORMAT(flIntToChar(lIntEncoded128Array[j]));

        exit(lTxtCode128Barcode);
    end;

    local procedure flCode128c(pTxtCode: Text[250]) lTxtCode128Barcode: Text[250];
    var
        lIntEncoded128Array: array[250] of Integer;
        i: Integer;
        j: Integer;
    begin
        if flIsOddLength(pTxtCode) then
            pTxtCode := '0' + pTxtCode;
        lIntEncoded128Array[1] := 105; // STARTCHAR C
        for i := 1 to (STRLEN(pTxtCode) div 2) do
            EVALUATE(lIntEncoded128Array[i + 1], COPYSTR(pTxtCode, (2 * (i - 1)) + 1, 2));
        lIntEncoded128Array[i + 2] := flChecksum(lIntEncoded128Array, i + 1);
        lIntEncoded128Array[i + 3] := 106; // STOPCHAR
        for j := 1 to i + 3 do
            lTxtCode128Barcode := lTxtCode128Barcode + FORMAT(flIntToChar(lIntEncoded128Array[j]));
        exit(lTxtCode128Barcode);
    end;

    local procedure flIsNumeric(pText: Text[250]): Boolean;
    var
        lInt: Integer;
    begin
        exit(EVALUATE(lInt, pText));
    end;

    local procedure flIsOddLength(pText: Text[250]): Boolean;
    begin
        exit(STRLEN(pText) mod 2 = 1);
    end;

    local procedure flChecksum(pIntArray: array[250] of Integer; pLength: Integer): Char;
    var
        i: Integer;
        lIntChecksum: Integer;
    begin
        lIntChecksum := pIntArray[1];
        for i := 2 to pLength do
            lIntChecksum := lIntChecksum + (i - 1) * pIntArray[i];
        lIntChecksum := lIntChecksum mod 103;
        exit(lIntChecksum);
    end;

    local procedure flTextToInt(TextIn: Text[30]) IntRet: Integer;
    begin
        // These characters can be used in a text string to print in a barcode font!
        case TextIn of
            ' ':
                exit(0); // ASCII 32
            '!':
                exit(1); // ASCII 33
            '"':
                exit(2); // ASCII 33
            '#':
                exit(3); // etc
            '$':
                exit(4);
            '%':
                exit(5);
            '&':
                exit(6);
            '''':
                exit(7);
            '(':
                exit(8);
            ')':
                exit(9);
            '*':
                exit(10);
            '+':
                exit(11);
            ',':
                exit(12);
            '-':
                exit(13);
            '.':
                exit(14);
            '/':
                exit(15);
            '0':
                exit(16);
            '1':
                exit(17);
            '2':
                exit(18);
            '3':
                exit(19);
            '4':
                exit(20);
            '5':
                exit(21);
            '6':
                exit(22);
            '7':
                exit(23);
            '8':
                exit(24);
            '9':
                exit(25);
            ':':
                exit(26);
            ';':
                exit(27);
            '<':
                exit(28);
            '=':
                exit(29);
            '>':
                exit(30);
            '?':
                exit(31);
            '@':
                exit(32);
            'A':
                exit(33);
            'B':
                exit(34);
            'C':
                exit(35);
            'D':
                exit(36);
            'E':
                exit(37);
            'F':
                exit(38);
            'G':
                exit(39);
            'H':
                exit(40);
            'I':
                exit(41);
            'J':
                exit(42);
            'K':
                exit(43);
            'L':
                exit(44);
            'M':
                exit(45);
            'N':
                exit(46);
            'O':
                exit(47);
            'P':
                exit(48);
            'Q':
                exit(49);
            'R':
                exit(50);
            'S':
                exit(51);
            'T':
                exit(52);
            'U':
                exit(53);
            'V':
                exit(54);
            'W':
                exit(55);
            'X':
                exit(56);
            'Y':
                exit(57);
            'Z':
                exit(58);
            '[':
                exit(59);
            '\':
                exit(60);
            ']':
                exit(61);
            '^':
                exit(62);
            '_':
                exit(63);
            '`':
                exit(64);
            'a':
                exit(65);
            'b':
                exit(66);
            'c':
                exit(67);
            'd':
                exit(68);
            'e':
                exit(69);
            'f':
                exit(70);
            'g':
                exit(71);
            'h':
                exit(72);
            'i':
                exit(73);
            'j':
                exit(74);
            'k':
                exit(75);
            'l':
                exit(76);
            'm':
                exit(77);
            'n':
                exit(78);
            'o':
                exit(79);
            'p':
                exit(80);
            'q':
                exit(81);
            'r':
                exit(82);
            's':
                exit(83);
            't':
                exit(84);
            'u':
                exit(85);
            'v':
                exit(86);
            'w':
                exit(87);
            'x':
                exit(88);
            'y':
                exit(89);
            'z':
                exit(90);
            '{':
                exit(91);
            '|':
                exit(92);
            '}':
                exit(93);
            '~':
                exit(94);
            '˜':
                exit(95); //  Chr(145) A:US     B: DEL    C: 95
            '™':
                exit(96); //  Chr(146) A:FNC3   B: FNC3   C: 96
            'š':
                exit(97); //  Chr(147) A:FNC2   B: FNC2   C: 97
            '›':
                exit(98); //  Chr(148) A:SHIFT  B: SHIFT  C: 98
            'œ':
                exit(99); //  Chr(149) A:CodeC  B: CodeC  C: 99
            '':
                exit(100); // Chr(150) A:CodeB  B: FNC4   C: CODEB
            'ž':
                exit(101); // Chr(151) A:FNC4   B: CODEA  C: CODEA
            '³':
                exit(102); // Chr(152) FNC1
            '¾':
                exit(103); // Chr(153) Start A
            'À':
                exit(104); // Chr(154) Start B
            'Á':
                exit(105); // Chr(155) Start C
            'Â':
                exit(106); // Chr(156) STOP
            '':
                exit(0);   // Chr(128)
        end;
    end;

    local procedure flIntToChar(IntIn: Integer) CharRet: Char;
    begin
        // Convert a Code 128 value to a '128 Code.ttf' character
        case IntIn of
            0:
                exit(''); // ASCII 32
            1:
                exit('!'); // ASCII 33
            2:
                exit('"'); // ASCII 34
            3:
                exit('#'); // etc..
            4:
                exit('$');
            5:
                exit('%');
            6:
                exit('&');
            7:
                exit(''''); // insert this character twice!
            8:
                exit('(');
            9:
                exit(')');
            10:
                exit('*');
            11:
                exit('+');
            12:
                exit(',');
            13:
                exit('-');
            14:
                exit('.');
            15:
                exit('/');
            16:
                exit('0');
            17:
                exit('1');
            18:
                exit('2');
            19:
                exit('3');
            20:
                exit('4');
            21:
                exit('5');
            22:
                exit('6');
            23:
                exit('7');
            24:
                exit('8');
            25:
                exit('9');
            26:
                exit(':');
            27:
                exit(';');
            28:
                exit('<');
            29:
                exit('=');
            30:
                exit('>');
            31:
                exit('?');
            32:
                exit('@');
            33:
                exit('A');
            34:
                exit('B');
            35:
                exit('C');
            36:
                exit('D');
            37:
                exit('E');
            38:
                exit('F');
            39:
                exit('G');
            40:
                exit('H');
            41:
                exit('I');
            42:
                exit('J');
            43:
                exit('K');
            44:
                exit('L');
            45:
                exit('M');
            46:
                exit('N');
            47:
                exit('O');
            48:
                exit('P');
            49:
                exit('Q');
            50:
                exit('R');
            51:
                exit('S');
            52:
                exit('T');
            53:
                exit('U');
            54:
                exit('V');
            55:
                exit('W');
            56:
                exit('X');
            57:
                exit('Y');
            58:
                exit('Z');
            59:
                exit('[');
            60:
                exit('\');
            61:
                exit(']');
            62:
                exit('^');
            63:
                exit('_');
            64:
                exit('`');
            65:
                exit('a');
            66:
                exit('b');
            67:
                exit('c');
            68:
                exit('d');
            69:
                exit('e');
            70:
                exit('f');
            71:
                exit('g');
            72:
                exit('h');
            73:
                exit('i');
            74:
                exit('j');
            75:
                exit('k');
            76:
                exit('l');
            77:
                exit('m');
            78:
                exit('n');
            79:
                exit('o');
            80:
                exit('p');
            81:
                exit('q');
            82:
                exit('r');
            83:
                exit('s');
            84:
                exit('t');
            85:
                exit('u');
            86:
                exit('v');
            87:
                exit('w');
            88:
                exit('x');
            89:
                exit('y');
            90:
                exit('z');
            91:
                exit('{');
            92:
                exit('|');
            93:
                exit('}');
            94:
                exit('~');
            95:
                exit('˜'); //  Chr(0145) A:US     B: DEL    C: 95
            96:
                exit('™'); //  Chr(0146) A:FNC3   B: FNC3   C: 96
            97:
                exit('š'); //  Chr(0147) A:FNC2   B: FNC2   C: 97
            98:
                exit('›'); //  Chr(0148) A:SHIFT  B: SHIFT  C: 98
            99:
                exit('œ'); //  Chr(0149) A:CodeC  B: CodeC  C: 99
            100:
                exit(''); // Chr(0150) A:CodeB  B: FNC4   C: CODEB
            101:
                exit('ž'); // Chr(0151) A:FNC4   B: CODEA  C: CODEA
            102:
                exit('³'); // Chr(0152) FNC1
            103:
                exit('¾'); // Chr(0153) Start A
            104:
                exit('À'); // Chr(0154) Start B
            105:
                exit('Á'); // Chr(0155) Start C
            106:
                exit('Â'); // Chr(0156) STOP
        end;
    end;

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

