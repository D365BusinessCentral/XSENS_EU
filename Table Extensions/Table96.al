tableextension 50018 "G/L Budget Entry" extends "G/L Budget Entry"
{
    fields
    {
        field(50003; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionML = ENU = 'Projects Dimension 3',
                        NLD = 'Projects Dimension 3';

            trigger OnLookup();
            var
                lCduDimensionXsensMgt: Codeunit "Dimension Xsens  Mgt";
            begin
                //lCduDimensionXsensMgt.fLookUpDimensionvalues(3,"Shortcut Dimension 3 Code");
                VALIDATE("Shortcut Dimension 3 Code");
            end;

            trigger OnValidate();
            var
                lCduDimensionXsensMgt: Codeunit "Dimension Xsens  Mgt";
            begin
                //lCduDimensionXsensMgt.ffillBudgetlLinedimensie(Rec,"Shortcut Dimension 3 Code");
                if "Shortcut Dimension 3 Code" = xRec."Shortcut Dimension 3 Code" then
                    exit;
                GetGLSetup;
                ValidateDimValue(GLSetup."Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
                UpdateDimensionSetId(GLSetup."Shortcut Dimension 3 Code", "Shortcut Dimension 3 Code");
            end;
        }
    }

    local procedure GetGLSetup();
    begin
        if not GLSetupRetrieved then begin
            GLSetup.GET;
            GLSetupRetrieved := true;
        end;
    end;

    local procedure ValidateDimValue(DimCode: Code[20]; var DimValueCode: Code[20]);
    var
        DimValue: Record "Dimension Value";
    begin
        if DimValueCode = '' then
            exit;

        DimValue."Dimension Code" := DimCode;
        DimValue.Code := DimValueCode;
        DimValue.FIND('=><');
        if DimValueCode <> COPYSTR(DimValue.Code, 1, STRLEN(DimValueCode)) then
            ERROR(Text000, DimValueCode, DimCode);
        DimValueCode := DimValue.Code;
    end;

    local procedure UpdateDimensionSetId(DimCode: Code[20]; DimValueCode: Code[20]);
    var
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        DimMgt.GetDimensionSet(TempDimSetEntry, "Dimension Set ID");
        UpdateDimSet(TempDimSetEntry, DimCode, DimValueCode);
        "Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
    end;

    var
        Text000: TextConst ENU = 'The dimension value %1 has not been set up for dimension %2.', NLD = 'De dimensiewaarde %1 is niet ingesteld voor dimensie %2.';
        GLBudgetName: Record "G/L Budget Name";
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        GLSetupRetrieved: Boolean;
}
