tableextension 50046 "Transfer Line" extends "Transfer Line"
{
    fields
    {
        modify(Description)
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                ReturnValue: Text[50];
                ItemDescriptionIsNo: Boolean;
                lRecXSENSSetup: Record "XSENS Setup";
                AnotherItemWithSameDescrQst: TextConst Comment = '%1=Item no., %2=item description', ENU = 'We found an item with the description "%2" (No. %1).\Did you mean to change the current item to %1?', NLD = 'Er is een artikel gevonden met de beschrijving %2 (nr. %1).\Wilt u het huidige artikel wijzigen in %1?';
            begin
                lRecXSENSSetup.GET;
                if lRecXSENSSetup."Check Item No. in Description" then begin
                    if (STRLEN(Description) <= MAXSTRLEN(Item."No.")) and ("Item No." <> '') then
                        ItemDescriptionIsNo := Item.GET(Description);

                    if ("Item No." <> '') and (not ItemDescriptionIsNo) and (Description <> '') then begin
                        Item.SETFILTER(Description, '''@' + CONVERTSTR(Description, '''', '?') + '*''');
                        if not Item.FINDFIRST then
                            exit;
                        if Item."No." = "Item No." then
                            exit;
                        if CONFIRM(AnotherItemWithSameDescrQst, false, Item."No.", Item.Description) then
                            VALIDATE("Item No.", Item."No.");
                        exit;
                    end;

                    if Item.TryGetItemNoOpenCard(ReturnValue, Description, false, true, true) then
                        case ReturnValue of
                            '':
                                Description := xRec.Description;
                            "Item No.":
                                Description := xRec.Description;
                            else begin
                                    CurrFieldNo := FIELDNO("Item No.");
                                    VALIDATE("Item No.", COPYSTR(ReturnValue, 1, MAXSTRLEN(Item."No.")));
                                end;
                        end;
                end;
            end;
        }

    }
}
