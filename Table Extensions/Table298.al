tableextension 50038 "Issued Reminder Line" extends "Issued Reminder Line"
{
    fields
    {
        field(51234; "Line Type Old"; Option)
        {
            OptionCaption = 'Aanmaningsregel,Niet vervallen,Begintekst,Eindtekst,Afronding';
            OptionMembers = ReminderLine,"Not Due","Beginning Text","Ending Text",Rounding;
        }
    }
}
