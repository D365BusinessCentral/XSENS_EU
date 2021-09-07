tableextension 50040 "Issued Fin. Charge Memo Header" extends "Issued Fin. Charge Memo Header"
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}
