report 50012 "XSS Import Gen. Journal"
{
    // version XSS5.021

    CaptionML = ENU = 'XSS Import Gen. Journal',
                NLD = 'XSS Import Journaal Posten';
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number) ORDER(Ascending) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord();
            begin
                XMLPORT.RUN(50005);  // handmatige import
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
}

