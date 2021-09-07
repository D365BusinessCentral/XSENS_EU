table 50002 "Wijzigingslog documenten"
{
    // version XSS5.068

    CaptionML = ENU = 'Modificationlog documents',
                NLD = 'Wijzigingslog documenten';

    fields
    {
        field(1; "Document Soort"; Option)
        {
            OptionCaptionML = ENU = 'Sales,Purchase',
                              NLD = 'Verkoop,Inkoop';
            OptionMembers = Verkoop,Inkoop;
        }
        field(2; "Document Type"; Option)
        {
            OptionCaptionML = ENU = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,B.Invoice SO,B.Invoice PO,B.Creditmemo SO,B.Creditmemo PO,B.Shipment,B.receipt',
                              NLD = 'Offerte,Order,Factuur,Creditnota,Raamcontract,Retourorder,Geb.Factuur verk,Geb.Factuur ink,Geb.Creditnota verk,Geb.Creditnota ink,Geb.Levering,Geb.Ontvangst';
            OptionMembers = Offerte,"Order",Factuur,Creditnota,Raamcontract,Retourorder,"Geb.Factuur verk","Geb.Factuur ink","Geb.Creditnota verk","Geb.Creditnota ink","Geb.Levering","Geb.Ontvangst";
        }
        field(3; "Document Nummer"; Code[20])
        {
        }
        field(4; "Document Regel"; Integer)
        {
        }
        field(5; Gebruiker; Code[50])
        {
        }
        field(6; Datum; Date)
        {
        }
        field(7; Tijd; Time)
        {
        }
        field(20; "Boekingsdatum akkoord"; Boolean)
        {
            CaptionML = ENU = 'Posting date agreed',
                        NLD = 'Boekingsdatum akkoord';
        }
        field(21; "Boekingsdatum document"; Date)
        {
        }
        field(22; "Document geboekt"; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Document Soort", "Document Type", "Document Nummer", "Document Regel", Datum, Tijd)
        {
        }
    }

    fieldgroups
    {
    }
}

