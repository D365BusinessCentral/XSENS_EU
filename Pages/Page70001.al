page 70001 Dialog
{
    // version XSS5.006

    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            field(Input; Input)
            {
                ApplicationArea = All;
                Caption = 'Input';
            }
        }
    }

    actions
    {
    }

    var
        Input: Text[1024];

    procedure fInput(pTxtDefaultValue: Text[200]): Text[200];
    begin
        if pTxtDefaultValue <> '' then
            Input := pTxtDefaultValue;
        exit(Input);
    end;
}

