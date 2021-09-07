tableextension 50091 "Bank Rec. Line" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        modify("Account Type")
        {
            trigger OnAfterValidate()
            begin
                ChangePaymentMethod();
            end;
        }
        modify("Account No.")
        {
            trigger OnAfterValidate()
            begin
                ChangePaymentMethod();
            end;
        }
        field(50000; "Payment Method Code"; Code[20])
        {
            Caption = 'Payment Method Code';
            DataClassification = ToBeClassified;
            TableRelation = "Payment Method";
        }
    }

    local procedure ChangePaymentMethod()
    var
        RecVendor: Record Vendor;
        RecCustomer: Record Customer;
    begin
        if "Account No." <> '' then begin
            case "Account Type" of
                "Account Type"::Vendor:
                    begin
                        RecVendor.GET("Account No.");
                        "Payment Method Code" := RecVendor."Payment Method Code";
                    end;
                "Account Type"::Customer:
                    begin
                        RecCustomer.GET("Account No.");
                        "Payment Method Code" := RecCustomer."Payment Method Code";
                    end;
                else
                    "Payment Method Code" := '';
            end;
        end else
            "Payment Method Code" := '';
    end;
}
