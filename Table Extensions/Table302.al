tableextension 50039 "Finance Charge Memo Header" extends "Finance Charge Memo Header"
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}
