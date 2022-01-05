#pragma warning disable AL0432 // TODO - Will Remove in Next Update
tableextension 50015 "Invoice Post. Buffer" extends "Invoice Post. Buffer"
#pragma warning restore AL0432 // TODO - Will Remove in Next Update
{
    fields
    {
        field(50000; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        NLD = 'Omschrijving';
            DataClassification = ToBeClassified;
            Description = 'GBTxt';
        }
        field(50001; "Description 2"; Text[50])
        {
            CaptionML = ENU = 'Description 2',
                        NLD = 'Omschrijving 2';
            DataClassification = ToBeClassified;
            Description = 'GBTxt';
        }
        field(50300; "Reason Code"; Code[10])
        {
            CaptionML = ENU = 'Reason Code',
                        NLD = 'Redencode';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
    }
}
