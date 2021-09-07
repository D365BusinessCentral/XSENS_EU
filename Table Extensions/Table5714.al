tableextension 50066 "Responsibility Center" extends "Responsibility Center"
{

    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}
