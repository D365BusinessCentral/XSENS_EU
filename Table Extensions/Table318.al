tableextension 50041 "Tax Area" extends "Tax Area"
{
    fields
    {
        field(50000; Country; Option)
        {
            BlankZero = false;
            CaptionML = ENU = 'Country',
                        ESM = 'País',
                        FRC = 'Pays',
                        ENC = 'Country';
            OptionCaptionML = ENU = 'US,CA',
                              ESM = 'EE.UU.,CA',
                              FRC = 'ÉU,CA',
                              ENC = 'US,CA';
            OptionMembers = US,CA;

            trigger OnValidate();
            begin
                TaxAreaLine.SETRANGE("Tax Area", Code);
                if TaxAreaLine.FIND('-') then begin
                    repeat
                        TaxJurisdiction.GET(TaxAreaLine."Tax Jurisdiction Code");
                        TESTFIELD(Country, TaxJurisdiction.Country);
                    until TaxAreaLine.NEXT = 0;
                end;
            end;
        }

    }

    var
        TaxAreaLine: Record "Tax Area Line";
        TaxJurisdiction: Record "Tax Jurisdiction";
        TaxAreaInUseErr: TextConst ENU = 'You cannot delete this tax rate because it is used on one or more existing documents.', NLD = 'U kunt dit btw-tarief niet verwijderen omdat het in een of meer bestaande documenten wordt gebruikt.';


}

