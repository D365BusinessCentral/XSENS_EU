table 50001 "XSENS Cue"
{
    // version NAVW111.00,XSS5.017

    CaptionML = ENU = 'Sales Cue',
                NLD = 'Indicatiestapel Verkoop';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            CaptionML = ENU = 'Primary Key',
                        NLD = 'Primaire sleutel';
        }
        field(2; "Sales Quotes - Open"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Quote),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter")));
            CaptionML = ENU = 'Sales Quotes - Open',
                        NLD = 'Verkoopoffertes - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(3; "Sales Orders - Open"; Integer)
        {
            AccessByPermission = TableData 110 = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter")));
            CaptionML = ENU = 'Sales Orders - Open',
                        NLD = 'Verkooporders - Open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(4; "Ready to Ship"; Integer)
        {
            AccessByPermission = TableData 110 = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Released),
                                                      "Completely Shipped" = CONST(false),
                                                      "Shipment Date" = FIELD("Date Filter2"),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter")));
            CaptionML = ENU = 'Ready to Ship',
                        NLD = 'Gereed voor verzending';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; Delayed; Integer)
        {
            AccessByPermission = TableData 110 = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Released),
                                                      "Completely Shipped" = CONST(false),
                                                      "Shipment Date" = FIELD("Date Filter"),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter"),
                                                      "Late Order Shipping" = FILTER(true)));
            CaptionML = ENU = 'Delayed',
                        NLD = 'Vertraagd';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Sales Return Orders - Open"; Integer)
        {
            AccessByPermission = TableData 6660 = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Return Order"),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter")));
            CaptionML = ENU = 'Sales Return Orders - Open',
                        NLD = 'Verkoopretourorders: open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Sales Credit Memos - Open"; Integer)
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER("Credit Memo"),
                                                      Status = FILTER(Open),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter")));
            CaptionML = ENU = 'Sales Credit Memos - Open',
                        NLD = 'Verkoopcreditnota''s: open';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Partially Shipped"; Integer)
        {
            AccessByPermission = TableData 110 = R;
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                      Status = FILTER(Released),
                                                      Shipped = FILTER(true),
                                                      "Completely Shipped" = FILTER(false),
                                                      "Shipment Date" = FIELD("Date Filter2"),
                                                      "Responsibility Center" = FIELD("Responsibility Center Filter")));
            CaptionML = ENU = 'Partially Shipped',
                        NLD = 'Gedeeltelijk verzonden';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Average Days Delayed"; Decimal)
        {
            AccessByPermission = TableData 110 = R;
            CaptionML = ENU = 'Average Days Delayed',
                        NLD = 'Gemiddeld aantal dagen vertraging';
            DecimalPlaces = 1 : 1;
            Editable = false;
        }
        field(10; "Sales Inv. - Pending Doc.Exch."; Integer)
        {
            CalcFormula = Count("Sales Invoice Header" WHERE("Document Exchange Status" = FILTER('Sent to Document Exchange Service|Delivery Failed')));
            CaptionML = ENU = 'Sales Invoices - Pending Document Exchange',
                        NLD = 'Verkoopfacturen - wachtend op documentuitwisseling';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Sales CrM. - Pending Doc.Exch."; Integer)
        {
            CalcFormula = Count("Sales Cr.Memo Header" WHERE("Document Exchange Status" = FILTER('Sent to Document Exchange Service|Delivery Failed')));
            CaptionML = ENU = 'Sales Credit Memos - Pending Document Exchange',
                        NLD = 'Verkoopcreditnota''s - wachtend op documentuitwisseling';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Date Filter"; Date)
        {
            CaptionML = ENU = 'Date Filter',
                        NLD = 'Datumfilter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Date Filter2"; Date)
        {
            CaptionML = ENU = 'Date Filter 2',
                        NLD = 'Datumfilter 2';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(22; "Responsibility Center Filter"; Code[10])
        {
            CaptionML = ENU = 'Responsibility Center Filter',
                        NLD = 'Filter divisie';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(23; "User ID Filter"; Code[50])
        {
            CaptionML = ENU = 'User ID Filter',
                        NLD = 'Gebruikers-id-filter';
            FieldClass = FlowFilter;
        }
        field(24; "Pending Tasks"; Integer)
        {
            CalcFormula = Count("User Task" WHERE("Assigned To User Name" = FIELD("User ID Filter"),
                                                   "Percent Complete" = FILTER('<>100')));
            CaptionML = ENU = 'Pending Tasks',
                        NLD = 'Wachtende taken';
            FieldClass = FlowField;
        }
        field(100; Complaints; Integer)
        {
            CalcFormula = Count("XSS Complaint Header" WHERE(RMA = CONST(No),
                                                              Status = FILTER('<>CLOSED')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(101; "RMA's"; Integer)
        {
            CalcFormula = Count("XSS Complaint Header" WHERE(RMA = CONST(Yes),
                                                              Status = FILTER('<>CLOSED')));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    procedure SetRespCenterFilter();
    var
        UserSetupMgt: Codeunit "User Setup Management";
        RespCenterCode: Code[10];
    begin
        RespCenterCode := UserSetupMgt.GetSalesFilter;
        IF RespCenterCode <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center Filter", RespCenterCode);
            FILTERGROUP(0);
        END;
    end;

    procedure CalculateAverageDaysDelayed() AverageDays: Decimal;
    var
        SalesHeader: Record "Sales Header";
        SumDelayDays: Integer;
        CountDelayedInvoices: Integer;
    begin
        FilterOrders(SalesHeader, FIELDNO(Delayed));
        IF SalesHeader.FINDSET THEN BEGIN
            REPEAT
                SumDelayDays += MaximumDelayAmongLines(SalesHeader);
                CountDelayedInvoices += 1;
            UNTIL SalesHeader.NEXT = 0;
            AverageDays := SumDelayDays / CountDelayedInvoices;
        END;
    end;

    local procedure MaximumDelayAmongLines(SalesHeader: Record "Sales Header") MaxDelay: Integer;
    var
        SalesLine: Record "Sales Line";
    begin
        MaxDelay := 0;
        SalesLine.SETRANGE("Document Type", SalesHeader."Document Type");
        SalesLine.SETRANGE("Document No.", SalesHeader."No.");
        SalesLine.SETFILTER("Shipment Date", '<%1&<>%2', WORKDATE, 0D);
        IF SalesLine.FINDSET THEN
            REPEAT
                IF WORKDATE - SalesLine."Shipment Date" > MaxDelay THEN
                    MaxDelay := WORKDATE - SalesLine."Shipment Date";
            UNTIL SalesLine.NEXT = 0;
    end;

    procedure CountOrders(FieldNumber: Integer): Integer;
    var
        CountSalesOrders: Query "Count Sales Orders";
    begin
        CountSalesOrders.SETRANGE(Status, CountSalesOrders.Status::Released);
        CountSalesOrders.SETRANGE(Completely_Shipped, FALSE);
        FILTERGROUP(2);
        CountSalesOrders.SETFILTER(Responsibility_Center, GETFILTER("Responsibility Center Filter"));
        FILTERGROUP(0);

        CASE FieldNumber OF
            FIELDNO("Ready to Ship"):
                BEGIN
                    CountSalesOrders.SETRANGE(Ship);
                    CountSalesOrders.SETFILTER(Shipment_Date, GETFILTER("Date Filter2"));
                END;
            FIELDNO("Partially Shipped"):
                BEGIN
                    CountSalesOrders.SETRANGE(Shipped, TRUE);
                    CountSalesOrders.SETFILTER(Shipment_Date, GETFILTER("Date Filter2"));
                END;
            FIELDNO(Delayed):
                BEGIN
                    CountSalesOrders.SETRANGE(Ship);
                    CountSalesOrders.SETFILTER(Date_Filter, GETFILTER("Date Filter"));
                    CountSalesOrders.SETRANGE(Late_Order_Shipping, TRUE);
                END;
        END;
        CountSalesOrders.OPEN;
        CountSalesOrders.READ;
        EXIT(CountSalesOrders.Count_Orders);
    end;

    local procedure FilterOrders(var SalesHeader: Record "Sales Header"; FieldNumber: Integer);
    begin
        SalesHeader.SETRANGE("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SETRANGE(Status, SalesHeader.Status::Released);
        SalesHeader.SETRANGE("Completely Shipped", FALSE);
        CASE FieldNumber OF
            FIELDNO("Ready to Ship"):
                BEGIN
                    SalesHeader.SETRANGE(Ship);
                    SalesHeader.SETFILTER("Shipment Date", GETFILTER("Date Filter2"));
                END;
            FIELDNO("Partially Shipped"):
                BEGIN
                    SalesHeader.SETRANGE(Shipped, TRUE);
                    SalesHeader.SETFILTER("Shipment Date", GETFILTER("Date Filter2"));
                END;
            FIELDNO(Delayed):
                BEGIN
                    SalesHeader.SETRANGE(Ship);
                    SalesHeader.SETFILTER("Date Filter", GETFILTER("Date Filter"));
                    SalesHeader.SETRANGE("Late Order Shipping", TRUE);
                END;
        END;
        FILTERGROUP(2);
        SalesHeader.SETFILTER("Responsibility Center", GETFILTER("Responsibility Center Filter"));
        FILTERGROUP(0);
    end;

    procedure ShowOrders(FieldNumber: Integer);
    var
        SalesHeader: Record "Sales Header";
    begin
        FilterOrders(SalesHeader, FieldNumber);
        PAGE.RUN(PAGE::"Sales Order List", SalesHeader);
    end;
}

