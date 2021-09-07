tableextension 50079 "Contact Alt. Address" extends "Contact Alt. Address"
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}
