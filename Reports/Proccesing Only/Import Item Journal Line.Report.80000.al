report 80000 "Import JournaalEntry"
{
    Caption = 'Import Journal Entries';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    UseRequestPage = false;
    AdditionalSearchTerms = 'Import Journal Entries,Import Item Journal Line, Import General Journal, Action0,Import JournaalEntry,Import Journaalposten';
    trigger OnPostReport()
    begin
        Xmlport.Run(Xmlport::"Import Journaalposten");
    end;
}