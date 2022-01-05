report 50013 "Klacht Initialisatie"
{
    // version XSS5.032

    // 20181114 JS 14900: Added complaint initialization.

    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord();
            begin

                fDelete('AANGEMELDDOOR');
                fCreateKlachtstamgegeven('AANGEMELDDOOR', 'RELATIE', 'Relatie', 'CONTACT', 'Contact', '', true, 1);
                fCreateKlachtstamgegeven('AANGEMELDDOOR', 'MEDEWERKER', 'Medewerker', 'EMPLOYEE', 'Employee', '', true, 2);
                fCreateKlachtstamgegeven('AANGEMELDDOOR', 'IN-VERKOPER', 'Verkoper', 'SALESPERSON', 'Sales Person', '', true, 3);

                fDelete('BETREKKINGOP');

                fDelete('KLACHTRELATIE');

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'INKOOPORDER', 'Inkooporder', 'PURCH. ORDER',
                                         'Purchase Order', 'LEVERANCIER', true, 1);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'INKOOPFACTUUR', 'Inkoopfactuur', 'PURCH. INVOICE', 'Purchase Invoice',
                                         'LEVERANCIER', true, 2);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'INKOOPCREDITNOTA', 'Inkoopcreditnota', 'PURCH. CREDIT MEMO',
                                         'Purchase Credit Memo', 'LEVERANCIER', true, 3);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'INKOOPONTVANGST', 'Inkoopontvangst (Geb.)', 'PURCH. RECEIPT',
                                         'Purchase Receipt', 'LEVERANCIER', true, 4);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'INKOOPFACTUURGB', 'Inkoopfactuur (Geb.)', 'PURCH. INVOICE+',
                                         'Purchase Invoice+', 'LEVERANCIER', true, 5);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'INKOOPCREDITNOTAGB', 'Inkoopcreditnota (Geb.)', 'PURCH. CREDIT MEMO+',
                                         'Purchase Credit Memo+', 'LEVERANCIER', true, 6);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'VERKOOPORDER', 'Verkooporder', 'SALES ORDER',
                                         'Sales Order', 'KLANT', true, 1);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'VERKOOPFACTUUR', 'Verkoopfactuur', 'SALES INVOICE',
                                         'Sales Invoice', 'KLANT', true, 2);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'VERKOOPCREDITNOTA', 'Verkoopcreditnota', 'SALES CREDIT MEMO',
                                         'Sales Credit Memo', 'KLANT', true, 3);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'VERKOOPLEVERING', 'Verkoopverzending (Geb.)', 'SALES SHIPMENT',
                                         'Sales Shipment', 'KLANT', true, 4);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'VERKOOPFACTUURGB', 'Verkoopfactuur (Geb.)', 'SALES INVOICE+',
                                         'Sales Invoice+', 'KLANT', true, 5);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'VERKOOPCREDITNOTAGB', 'Verkoopcreditnota (Geb.)', 'SALES CREDIT MEMO+',
                                         'Sales Credit Memo+', 'KLANT', true, 6);

                fCreateKlachtstamgegeven('KLACHTRELATIE', 'VERKOOPOFFERTE', 'Verkoopofferte', 'SALES QUOTE',
                                         'Sales Quote', 'RELATIE', true, 1);
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

    local procedure fCreateKlachtstamgegeven(pCodeSoort: Code[20]; pCodeCode: Code[20]; pTxtOmschrijving: Text[30]; pCodCodeENU: Code[20]; pTxtOmschrijvingENU: Text[30]; pCodeSubType: Code[20]; pBoolActief: Boolean; pIntVolgorde: Integer);
    var
        lRecComplaintStamgegevens: Record "XSS Complaint Type";
        lBoolModify: Boolean;
    begin

        lBoolModify := lRecComplaintStamgegevens.GET(pCodeSoort, pCodeCode);

        if not lBoolModify then
            lRecComplaintStamgegevens.INIT;

        lRecComplaintStamgegevens.Codesoort := pCodeSoort;
        lRecComplaintStamgegevens.Code := pCodeCode;
        lRecComplaintStamgegevens.Omschrijving := pTxtOmschrijving;
        lRecComplaintStamgegevens."Code ENU" := pCodCodeENU;
        lRecComplaintStamgegevens."Omschrijving ENU" := pTxtOmschrijvingENU;
        lRecComplaintStamgegevens.Subtype := pCodeSubType;
        lRecComplaintStamgegevens.Actief := pBoolActief;
        lRecComplaintStamgegevens.Volgorde := pIntVolgorde;

        if not lBoolModify then
            lRecComplaintStamgegevens.INSERT
        else
            lRecComplaintStamgegevens.MODIFY;
    end;

    local procedure fDelete(pCodesoort: Code[20]);
    var
        lRecComplaintStamgegevens: Record "XSS Complaint Type";
    begin

        lRecComplaintStamgegevens.RESET;
        lRecComplaintStamgegevens.SETRANGE(Codesoort, pCodesoort);
        if lRecComplaintStamgegevens.FINDFIRST then
            lRecComplaintStamgegevens.DELETEALL(false);
    end;
}

