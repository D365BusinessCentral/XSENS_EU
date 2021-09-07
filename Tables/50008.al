table 50008 "Sales Tax Amount Line LT"
{
    // version NAVNA5.00.01,XSS5.006

    // 20100720 GFR 23181: Sales Tax Setup voor US company, nieuwe tabel

    CaptionML = ENU = 'Sales Tax Amount Line',
                ESM = 'Lín. imp. impto. ventas',
                FRC = 'Ligne de montant de taxe de vente',
                ENC = 'Sales Tax Amount Line';

    fields
    {
        field(1; "Tax Area Code"; Code[20])
        {
            CaptionML = ENU = 'Tax Area Code',
                        ESM = 'Cód. área impuesto',
                        FRC = 'Code de région fiscale',
                        ENC = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(2; "Tax Jurisdiction Code"; Code[10])
        {
            CaptionML = ENU = 'Tax Jurisdiction Code',
                        ESM = 'Cód. jurisdicción impuesto',
                        FRC = 'Code de juridiction fiscale',
                        ENC = 'Tax Jurisdiction Code';
            TableRelation = "Tax Jurisdiction";
        }
        field(3; "Tax %"; Decimal)
        {
            CaptionML = ENU = 'Tax %',
                        ESM = '% Impto.',
                        FRC = '% taxe',
                        ENC = 'Tax %';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(4; "Tax Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Tax Base Amount',
                        ESM = 'Imp. base impos.',
                        FRC = 'Montant de base de la taxe',
                        ENC = 'Tax Base Amount';
            Editable = false;
        }
        field(5; "Tax Amount"; Decimal)
        {
            CaptionML = ENU = 'Tax Amount',
                        ESM = 'Imp. impto.',
                        FRC = 'Montant de la taxe',
                        ENC = 'Tax Amount';

            trigger OnValidate();
            begin
                TESTFIELD("Tax %");
                TESTFIELD("Tax Base Amount");
                IF "Tax Amount" / "Tax Base Amount" < 0 THEN
                    ERROR(Text002, FIELDCAPTION("Tax Amount"));
                "Tax Difference" := "Tax Difference" + "Tax Amount" - xRec."Tax Amount";
            end;
        }
        field(6; "Amount Including Tax"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Amount Including Tax',
                        ESM = 'Imp. incluido impto.',
                        FRC = 'Montant incluant les taxes',
                        ENC = 'Amount Including Tax';
            Editable = false;
        }
        field(7; "Line Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Line Amount',
                        ESM = 'Importe línea',
                        FRC = 'Montant de la ligne',
                        ENC = 'Line Amount';
            Editable = false;
        }
        field(10; "Tax Group Code"; Code[10])
        {
            CaptionML = ENU = 'Tax Group Code',
                        ESM = 'Cód. grupo impuesto',
                        FRC = 'Code de groupe fiscal',
                        ENC = 'Tax Group Code';
            Editable = false;
            TableRelation = "Tax Group";
        }
        field(11; Quantity; Decimal)
        {
            CaptionML = ENU = 'Quantity',
                        ESM = 'Cantidad',
                        FRC = 'Quantité',
                        ENC = 'Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(12; Modified; Boolean)
        {
            CaptionML = ENU = 'Modified',
                        ESM = 'Modificado',
                        FRC = 'Modifié',
                        ENC = 'Modified';
        }
        field(13; "Use Tax"; Boolean)
        {
            CaptionML = ENU = 'Use Tax',
                        ESM = 'Impto. sobre servicios',
                        FRC = 'Taxe de service',
                        ENC = 'Use Tax';
        }
        field(14; "Calculated Tax Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Calculated Tax Amount',
                        ESM = 'Imp. impto. calculado',
                        FRC = 'Montant de taxe calculé',
                        ENC = 'Calculated Tax Amount';
            Editable = false;
        }
        field(15; "Tax Difference"; Decimal)
        {
            CaptionML = ENU = 'Tax Difference',
                        ESM = 'Impto. anticip.',
                        FRC = 'Différence de taxe',
                        ENC = 'Tax Difference';
            Editable = false;
        }
        field(16; "Tax Type"; Option)
        {
            CaptionML = ENU = 'Tax Type',
                        ESM = 'Tipo impto.',
                        FRC = 'Type de taxe',
                        ENC = 'Tax Type';
            OptionCaptionML = ENU = 'Sales Tax,Excise Tax',
                              ESM = 'Impto. venta,Impto. consumo',
                              FRC = 'Taxe de vente,Taxe d''accise',
                              ENC = 'Sales Tax,Excise Tax';
            OptionMembers = "Sales Tax","Excise Tax";
        }
        field(17; "Tax Liable"; Boolean)
        {
            CaptionML = ENU = 'Tax Liable',
                        ESM = 'Sujeto a impuesto',
                        FRC = 'Taxable',
                        ENC = 'Tax Liable';
        }
        field(20; "Tax Area Code for Key"; Code[20])
        {
            CaptionML = ENU = 'Tax Area Code for Key',
                        ESM = 'Cód. área impto. para clave',
                        FRC = 'Code de zone d''imposition pour la clé',
                        ENC = 'Tax Area Code for Key';
            TableRelation = "Tax Area";
        }
        field(25; "Invoice Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Invoice Discount Amount',
                        ESM = 'Importe descuento factura',
                        FRC = 'Montant d''escompte de la facture',
                        ENC = 'Invoice Discount Amount';
            Editable = false;
        }
        field(26; "Inv. Disc. Base Amount"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Inv. Disc. Base Amount',
                        ESM = 'Base descuento factura',
                        FRC = 'Montant de base d''escompte de facture',
                        ENC = 'Inv. Disc. Base Amount';
            Editable = false;
        }
        field(10010; "Expense/Capitalize"; Boolean)
        {
            CaptionML = ENU = 'Expense/Capitalize',
                        ESM = 'Gastar/Capitalizar',
                        FRC = 'Dépense/Capitaliser',
                        ENC = 'Expense/Capitalize';
        }
        field(10020; "Print Order"; Integer)
        {
            CaptionML = ENU = 'Print Order',
                        ESM = 'Impr. pedido',
                        FRC = 'Imprimer commande',
                        ENC = 'Print Order';
        }
        field(10030; "Print Description"; Text[30])
        {
            CaptionML = ENU = 'Print Description',
                        ESM = 'Impr. descripción',
                        FRC = 'Imprimer description',
                        ENC = 'Print Description';
        }
        field(10040; "Calculation Order"; Integer)
        {
            CaptionML = ENU = 'Calculation Order',
                        ESM = 'Orden cálculo',
                        FRC = 'Ordre de calcul',
                        ENC = 'Calculation Order';
        }
        field(10041; "Round Tax"; Option)
        {
            CaptionML = ENU = 'Round Tax',
                        ESM = 'Redondear impuesto',
                        FRC = 'Arrondi de taxe',
                        ENC = 'Round Tax';
            Editable = false;
            OptionCaptionML = ENU = 'To Nearest,Up,Down',
                              ESM = 'Más cercano,Superior,Inferior',
                              FRC = 'Plus près,Haut,Bas',
                              ENC = 'To Nearest,Up,Down';
            OptionMembers = "To Nearest",Up,Down;
        }
        field(10042; "Is Report-to Jurisdiction"; Boolean)
        {
            CaptionML = ENU = 'Is Report-to Jurisdiction',
                        ESM = 'Es Informe jurisdicción',
                        FRC = 'Est une juridiction fiscale',
                        ENC = 'Is Report-to Jurisdiction';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Tax Area Code for Key", "Tax Jurisdiction Code", "Tax %", "Tax Group Code", "Expense/Capitalize", "Tax Type", "Use Tax")
        {
        }
        key(Key2; "Print Order", "Tax Area Code for Key", "Tax Jurisdiction Code")
        {
        }
        key(Key3; "Tax Area Code for Key", "Tax Group Code", "Tax Type", "Calculation Order")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Currency: Record 4;
        AllowTaxDifference: Boolean;
        PricesIncludingTax: Boolean;
        GlobalsInitialized: Boolean;
        Text000: TextConst ENU = '%1% Tax', ESM = '%1% Impto.', FRC = '%1% Taxe', ENC = '%1% Tax';
        Text001: TextConst ENU = 'Tax Amount', ESM = 'Imp. impto.', FRC = 'Montant de la taxe', ENC = 'Tax Amount';
        Text002: TextConst ENU = '%1 must not be negative.', ESM = '%1 no debe ser negativo.', FRC = '%1 ne doit pas être négatif.', ENC = '%1 must not be negative.';
        Text003: TextConst ENU = '%1 must not be greater than %2.', ESM = '%1 no debe ser más grande que %2.', FRC = '%1 ne doit pas être supérieur(e) à %2.', ENC = '%1 must not be greater than %2.';
        Text004: TextConst ENU = '%1 for %2 must not exceed %3 = %4.', ESM = '%1 para %2 no debe exceder %3 = %4.', FRC = 'La %1 du %2 ne doit pas dépasser la %3 = %4.', ENC = '%1 for %2 must not exceed %3 = %4.';

    procedure CheckTaxDifference(NewCurrencyCode: Code[10]; NewAllowTaxDifference: Boolean; NewPricesIncludingTax: Boolean);
    begin
        InitGlobals(NewCurrencyCode, NewAllowTaxDifference, NewPricesIncludingTax);
        IF NOT AllowTaxDifference THEN
            TESTFIELD("Tax Difference", 0);
        IF ABS("Tax Difference") > Currency."Max. VAT Difference Allowed" THEN
            ERROR(
              Text004, FIELDCAPTION("Tax Difference"), Currency.Code,
              Currency.FIELDCAPTION("Max. VAT Difference Allowed"), Currency."Max. VAT Difference Allowed");
    end;

    local procedure InitGlobals(NewCurrencyCode: Code[10]; NewAllowTaxDifference: Boolean; NewPricesIncludingTax: Boolean);
    begin
        SetCurrency(NewCurrencyCode);
        AllowTaxDifference := NewAllowTaxDifference;
        PricesIncludingTax := NewPricesIncludingTax;
        GlobalsInitialized := TRUE;
    end;

    local procedure SetCurrency(CurrencyCode: Code[10]);
    begin
        IF CurrencyCode = '' THEN
            Currency.InitRoundingPrecision
        ELSE
            Currency.GET(CurrencyCode);
    end;

    procedure TaxAmountText(): Text[30];
    var
        TaxAmountLine2: Record 50008;
        TaxAreaCount: Integer;
        TaxPercent: Decimal;
    begin
        IF FINDFIRST THEN BEGIN
            TaxAmountLine2 := Rec;
            TaxAreaCount := 1;
            REPEAT
                IF "Tax Area Code" <> TaxAmountLine2."Tax Area Code" THEN BEGIN
                    TaxAreaCount := TaxAreaCount + 1;
                    TaxAmountLine2 := Rec;
                END;
                TaxPercent := TaxPercent + "Tax %";
            UNTIL NEXT = 0;
        END;
        IF TaxPercent <> 0 THEN
            EXIT(STRSUBSTNO(Text000, TaxPercent / TaxAreaCount));
        EXIT(Text001);
    end;

    procedure GetTotalLineAmount(SubtractTax: Boolean; CurrencyCode: Code[10]): Decimal;
    var
        LineAmount: Decimal;
    begin
        IF SubtractTax THEN
            SetCurrency(CurrencyCode);

        LineAmount := 0;

        IF FIND('-') THEN
            REPEAT
                IF SubtractTax THEN
                    LineAmount :=
                      LineAmount + ROUND("Line Amount" / (1 + "Tax %" / 100), Currency."Amount Rounding Precision")
                ELSE
                    LineAmount := LineAmount + "Line Amount";
            UNTIL NEXT = 0;

        EXIT(LineAmount);
    end;

    procedure GetTotalTaxAmount(): Decimal;
    var
        TaxAmount: Decimal;
        PrevJurisdiction: Code[10];
    begin
        TaxAmount := 0;
        IF FIND('-') THEN
            REPEAT
                IF PrevJurisdiction <> "Tax Jurisdiction Code" THEN BEGIN
                    IF "Tax Area Code for Key" = '' THEN     // indicates Canada
                        TaxAmount := ROUND(TaxAmount);
                    PrevJurisdiction := "Tax Jurisdiction Code";
                END;
                TaxAmount := TaxAmount + "Tax Amount";
            UNTIL NEXT = 0;
        EXIT(TaxAmount);
    end;

    procedure GetTotalTaxBase(): Decimal;
    var
        TaxBase: Decimal;
    begin
        TaxBase := 0;

        IF FIND('-') THEN
            REPEAT
                TaxBase := TaxBase + "Tax Base Amount";
            UNTIL NEXT = 0;
        EXIT(TaxBase);
    end;

    procedure GetTotalAmountInclTax(): Decimal;
    var
        AmountInclTax: Decimal;
    begin
        AmountInclTax := 0;

        IF FIND('-') THEN
            REPEAT
                AmountInclTax := AmountInclTax + "Amount Including Tax";
            UNTIL NEXT = 0;
        EXIT(AmountInclTax);
    end;

    procedure GetAnyLineModified(): Boolean;
    begin
        IF FIND('-') THEN
            REPEAT
                IF Modified THEN
                    EXIT(TRUE);
            UNTIL NEXT = 0;
        EXIT(FALSE);
    end;

    procedure GetTotalInvDiscAmount(): Decimal;
    var
        InvDiscAmount: Decimal;
    begin
        InvDiscAmount := 0;
        IF FIND('-') THEN
            InvDiscAmount := "Invoice Discount Amount";
        EXIT(InvDiscAmount);
    end;

    procedure SetInvoiceDiscountPercent(NewInvoiceDiscountPct: Decimal; NewCurrencyCode: Code[10]; NewPricesIncludingVAT: Boolean; CalcInvDiscPerVATID: Boolean; NewVATBaseDiscPct: Decimal);
    var
        NewRemainder: Decimal;
    begin
        InitGlobals(NewCurrencyCode, FALSE, NewPricesIncludingVAT);
        IF FIND('-') THEN
            REPEAT
                IF "Inv. Disc. Base Amount" <> 0 THEN BEGIN
                    NewRemainder :=
                      NewRemainder + NewInvoiceDiscountPct * "Inv. Disc. Base Amount" / 100;
                    VALIDATE(
                      "Invoice Discount Amount", ROUND(NewRemainder, Currency."Amount Rounding Precision"));
                    IF CalcInvDiscPerVATID THEN
                        NewRemainder := 0
                    ELSE
                        NewRemainder := NewRemainder - "Invoice Discount Amount";
                    Modified := TRUE;
                    MODIFY;
                END;
            UNTIL NEXT = 0;
    end;

    procedure GetTotalInvDiscBaseAmount(SubtractVAT: Boolean; CurrencyCode: Code[10]): Decimal;
    var
        InvDiscBaseAmount: Decimal;
    begin
        IF SubtractVAT THEN
            SetCurrency(CurrencyCode);

        InvDiscBaseAmount := 0;

        IF FIND('-') THEN
            REPEAT
                IF SubtractVAT THEN
                    InvDiscBaseAmount :=
                      InvDiscBaseAmount +
                      ROUND("Inv. Disc. Base Amount" / (1 + "Tax %" / 100), Currency."Amount Rounding Precision")
                ELSE
                    InvDiscBaseAmount := InvDiscBaseAmount + "Inv. Disc. Base Amount";
            UNTIL NEXT = 0;
        EXIT(InvDiscBaseAmount);
    end;

    procedure SetInvoiceDiscountAmount(NewInvoiceDiscount: Decimal; NewCurrencyCode: Code[10]; NewPricesIncludingVAT: Boolean; NewVATBaseDiscPct: Decimal);
    var
        TotalInvDiscBaseAmount: Decimal;
        NewRemainder: Decimal;
    begin
        InitGlobals(NewCurrencyCode, FALSE, NewPricesIncludingVAT);
        TotalInvDiscBaseAmount := GetTotalInvDiscBaseAmount(FALSE, Currency.Code);
        IF TotalInvDiscBaseAmount = 0 THEN
            EXIT;
        FIND('-');
        REPEAT
            IF "Inv. Disc. Base Amount" <> 0 THEN BEGIN
                IF TotalInvDiscBaseAmount = 0 THEN
                    NewRemainder := 0
                ELSE
                    NewRemainder :=
                      NewRemainder + NewInvoiceDiscount * "Inv. Disc. Base Amount" / TotalInvDiscBaseAmount;
                VALIDATE(
                  "Invoice Discount Amount", ROUND(NewRemainder, Currency."Amount Rounding Precision"));
                NewRemainder := NewRemainder - "Invoice Discount Amount";
                MODIFY;
            END;
        UNTIL NEXT = 0;
    end;
}

