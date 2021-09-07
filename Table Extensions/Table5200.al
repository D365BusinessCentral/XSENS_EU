tableextension 50063 Employee extends Employee
{
    fields
    {
        modify(County)
        {
            TableRelation = County.County;
        }
    }
}
