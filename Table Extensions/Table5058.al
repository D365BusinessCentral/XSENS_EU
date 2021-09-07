tableextension 50080 "Contact Industry Group" extends "Contact Industry Group"
{
    fields
    {
        modify("Contact No.")
        {
            TableRelation = Contact WHERE(Type = FILTER(Company | Person));
        }
    }
}
