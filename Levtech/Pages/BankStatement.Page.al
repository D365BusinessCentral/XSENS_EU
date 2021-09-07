page 50010 "Bank Statement Reports"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bank Statement Report";
    SourceTableView = sorting("Entry No.") order(descending);
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("Statement No."; Rec."Statement No.")
                {
                    ApplicationArea = All;
                }
                field("Statement Date"; Rec."Statement Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Download Bank Statement")
            {
                ApplicationArea = All;
                Image = MoveDown;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                trigger OnAction()
                var
                    RecBankStatementReport: Record "Bank Statement Report";
                    Instream: InStream;
                    Filename: Text;
                    FileExtension: Label 'Pdf,Excel';
                    SelectedFormat: Integer;
                begin
                    SelectedFormat := StrMenu(FileExtension, 1, 'Save As');
                    Clear(Instream);
                    if SelectedFormat = 1 then begin
                        if Rec."PDF Report Data".HasValue then begin
                            Rec.CalcFields("PDF Report Data");
                            Rec."PDF Report Data".CreateInStream(Instream);
                            Filename := StrSubstNo('%1_%2.pdf', Rec."Bank Account No.", Rec."Statement No.");
                            DownloadFromStream(Instream, 'Export', '', 'All Files (*.*)|*.*', Filename);
                        end else
                            Error('The field Report Data must have a value.');
                    end else
                        if SelectedFormat = 2 then begin
                            if Rec."Excel Report Data".HasValue then begin
                                Rec.CalcFields("Excel Report Data");
                                Rec."Excel Report Data".CreateInStream(Instream);
                                Filename := StrSubstNo('%1_%2.xlsx', Rec."Bank Account No.", Rec."Statement No.");
                                DownloadFromStream(Instream, 'Export', '', 'All Files (*.*)|*.*', Filename);
                            end else
                                Error('The field Report Data must have a value.');
                        end;
                end;
            }
        }
    }

    var
        myInt: Integer;
}