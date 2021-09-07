report 50098 "Item Tracing code MTI-600S"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports\P2\Item Tracing code MTI-600S.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING("No.") WHERE("No." = FILTER('MTI-670'));

            trigger OnAfterGetRecord();
            begin
                if Item."Item Tracking Code" = 'MTI-600' then begin
                    Item."Item Tracking Code" := 'MTI-600S';
                    Item.MODIFY(true);
                end;
            end;

            trigger OnPreDataItem();
            begin
                if Item.COUNT <> 1 then ERROR('fout');
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

