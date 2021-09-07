tableextension 50065 Union extends Union
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}
