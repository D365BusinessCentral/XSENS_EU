table 50009 "Sales Tax Amount Difference LT"
{
    //Already declared by Base extension
    // version NAVNA5.00,XSS5.006

    // 20100720 GFR 23181: Sales Tax Setup voor US company, nieuwe tabel

    CaptionML = ENU = 'Sales Tax Amount Difference',
                ESM = 'Diferencia imp. impto. vtas.',
                FRC = 'Différence de montant de taxe de vente',
                ENC = 'Sales Tax Amount Difference';

    fields
    {
        /*field(1; "Document Type"; Option)
        {
            CaptionML = ENU = 'Document Type',
                        ESM = 'Tipo documento',
                        FRC = 'Type de document',
                        ENC = 'Document Type';
            OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order',
                              ESM = 'Cotización,Pedido,Factura,Crédito,Pedido abierto,Devolución',
                              FRC = 'Devis,Commande,Facture,Note de crédit,Commande permanente,Retour',
                              ENC = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }*/
        field(1; "Document Type"; Enum "Sales Document Type")
        {
            CaptionML = ENU = 'Document Type',
                        ESM = 'Tipo documento',
                        FRC = 'Type de document',
                        ENC = 'Document Type';
        }
        field(2; "Document Product Area"; Option)
        {
            CaptionML = ENU = 'Document Product Area',
                        ESM = '…rea prod. documento',
                        FRC = 'Zone de produit du document',
                        ENC = 'Document Product Area';
            OptionCaptionML = ENU = 'Sales,Purchase,Service,,,,Posted Sale,Posted Purchase,Posted Service',
                              ESM = 'Ventas,Compras,Servicio,,,,Venta regis.,Compra regis.,Servicio regis.',
                              FRC = 'Ventes,Achat,Service,,,,Vente reportée,Achat reporté,Service reporté',
                              ENC = 'Sales,Purchase,Service,,,,Posted Sale,Posted Purchase,Posted Service';
            OptionMembers = Sales,Purchase,Service,,,,"Posted Sale","Posted Purchase","Posted Service";
        }
        field(3; "Document No."; Code[20])
        {
            CaptionML = ENU = 'Document No.',
                        ESM = 'Nº documento',
                        FRC = 'N° de document',
                        ENC = 'Document No.';
            TableRelation = IF ("Document Product Area" = CONST(Sales)) "Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"))
            ELSE
            IF ("Document Product Area" = CONST(Purchase)) "Purchase Header"."No." WHERE("Document Type" = FIELD("Document Type"))
            ELSE
            IF ("Document Product Area" = CONST(Service)) "Service Header"."No." WHERE("Document Type" = FIELD("Document Type"))
            ELSE
            IF ("Document Type" = CONST(Invoice),
                                     "Document Product Area" = CONST("Posted Sale")) "Sales Invoice Header"
            ELSE
            IF ("Document Type" = CONST("Credit Memo"),
                                              "Document Product Area" = CONST("Posted Sale")) "Sales Cr.Memo Header"
            ELSE
            IF ("Document Type" = CONST(Invoice),
                                                       "Document Product Area" = CONST("Posted Purchase")) "Purch. Inv. Header"
            ELSE
            IF ("Document Type" = CONST("Credit Memo"),
                                                                "Document Product Area" = CONST("Posted Purchase")) "Purch. Cr. Memo Hdr."
            ELSE
            IF ("Document Type" = CONST(Invoice),
                                                                         "Document Product Area" = CONST("Posted Service")) "Service Invoice Header"
            ELSE
            IF ("Document Type" = CONST("Credit Memo"),
                                                                                  "Document Product Area" = CONST("Posted Service")) "Service Cr.Memo Header";
        }
        field(5; "Tax Area Code"; Code[20])
        {
            CaptionML = ENU = 'Tax Area Code',
                        ESM = 'Cód. área impuesto',
                        FRC = 'Code de région fiscale',
                        ENC = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(6; "Tax Jurisdiction Code"; Code[10])
        {
            CaptionML = ENU = 'Tax Jurisdiction Code',
                        ESM = 'Cód. jurisdicción impuesto',
                        FRC = 'Code de juridiction fiscale',
                        ENC = 'Tax Jurisdiction Code';
            TableRelation = "Tax Jurisdiction";
        }
        field(7; "Tax Group Code"; Code[10])
        {
            CaptionML = ENU = 'Tax Group Code',
                        ESM = 'Cód. grupo impuesto',
                        FRC = 'Code de groupe fiscal',
                        ENC = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(8; "Tax %"; Decimal)
        {
            CaptionML = ENU = 'Tax %',
                        ESM = '% Impto.',
                        FRC = '% taxe',
                        ENC = 'Tax %';
        }
        field(9; "Expense/Capitalize"; Boolean)
        {
            CaptionML = ENU = 'Expense/Capitalize',
                        ESM = 'Gastar/Capitalizar',
                        FRC = 'Dépense/Capitaliser',
                        ENC = 'Expense/Capitalize';
        }
        field(10; "Tax Type"; Option)
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
        field(11; "Use Tax"; Boolean)
        {
            CaptionML = ENU = 'Use Tax',
                        ESM = 'Impto. sobre servicios',
                        FRC = 'Taxe de service',
                        ENC = 'Use Tax';
        }
        field(15; "Tax Difference"; Decimal)
        {
            AutoFormatType = 1;
            CaptionML = ENU = 'Tax Difference',
                        ESM = 'Impto. anticip.',
                        FRC = 'Différence de taxe',
                        ENC = 'Tax Difference';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document Product Area", "Document Type", "Document No.", "Tax Area Code", "Tax Jurisdiction Code", "Tax %", "Tax Group Code", "Expense/Capitalize", "Tax Type", "Use Tax")
        {
        }
    }

    fieldgroups
    {
    }

    procedure ClearDocDifference(ProductArea: Option Sales,Purchase; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]);
    var
        TaxAmountDifference: Record 50009;
    begin
        TaxAmountDifference.RESET;
        TaxAmountDifference.SETRANGE("Document Product Area", ProductArea);
        TaxAmountDifference.SETRANGE("Document Type", DocType);
        TaxAmountDifference.SETRANGE("Document No.", DocNo);
        IF TaxAmountDifference.FIND('-') THEN
            TaxAmountDifference.DELETEALL;
    end;

    procedure AnyTaxDifferenceRecords(ProductArea: Option Sales,Purchase; DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; DocNo: Code[20]): Boolean;
    var
        TaxAmountDifference: Record 50009;
    begin
        TaxAmountDifference.RESET;
        TaxAmountDifference.SETRANGE("Document Product Area", ProductArea);
        TaxAmountDifference.SETRANGE("Document Type", DocType);
        TaxAmountDifference.SETRANGE("Document No.", DocNo);
        EXIT(TaxAmountDifference.FIND('-'));
    end;

    //    procedure CopyTaxDifferenceRecords(FromProductArea: Option Sales,Purchase; FromDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; FromDocNo: Code[20]; ToProductArea: Option "Posted Sale","Posted Purchase"; ToDocType: Option Invoice,"Credit Memo"; ToDocNo: Code[20]);
    procedure CopyTaxDifferenceRecords(FromProductArea: Option Sales,Purchase; FromDocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order"; FromDocNo: Code[20]; ToProductArea: Option "Posted Sale","Posted Purchase"; ToDocType: Enum "Sales Document Type"; ToDocNo: Code[20]);
    var
        FromTaxAmountDifference: Record 50009;
        ToTaxAmountDifference: Record 50009;
    begin
        FromTaxAmountDifference.RESET;
        FromTaxAmountDifference.SETRANGE("Document Product Area", FromProductArea);
        FromTaxAmountDifference.SETRANGE("Document Type", FromDocType);
        FromTaxAmountDifference.SETRANGE("Document No.", FromDocNo);
        IF FromTaxAmountDifference.FIND('-') THEN BEGIN
            ToTaxAmountDifference.INIT;
            ToTaxAmountDifference."Document Product Area" := ToProductArea;
            ToTaxAmountDifference."Document Type" := ToDocType;
            ToTaxAmountDifference."Document No." := ToDocNo;
            REPEAT
                ToTaxAmountDifference."Tax Area Code" := FromTaxAmountDifference."Tax Area Code";
                ToTaxAmountDifference."Tax Jurisdiction Code" := FromTaxAmountDifference."Tax Jurisdiction Code";
                ToTaxAmountDifference."Tax %" := FromTaxAmountDifference."Tax %";
                ToTaxAmountDifference."Tax Group Code" := FromTaxAmountDifference."Tax Group Code";
                ToTaxAmountDifference."Expense/Capitalize" := FromTaxAmountDifference."Expense/Capitalize";
                ToTaxAmountDifference."Tax Type" := FromTaxAmountDifference."Tax Type";
                ToTaxAmountDifference."Use Tax" := FromTaxAmountDifference."Use Tax";
                ToTaxAmountDifference."Tax Difference" := FromTaxAmountDifference."Tax Difference";
                ToTaxAmountDifference.INSERT;
            UNTIL FromTaxAmountDifference.NEXT = 0;
        END;
    end;
}

