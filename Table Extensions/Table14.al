tableextension 50008 Location extends Location
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}