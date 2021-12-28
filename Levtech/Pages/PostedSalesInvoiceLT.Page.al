page 50098 "Posted Sales Invoice_LT"
{
    // //Chinese Localization Pack
    // //CH-20210507-01: Add Group - Chinese Localization

    Caption = 'Posted Sales Invoice';
    InsertAllowed = false;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Invoice,Correct,Print/Send,Navigate';
    RefreshOnActivate = true;
    SourceTable = "Sales Invoice Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the posted invoice number.';
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Editable = false;
                    Importance = Promoted;
                    TableRelation = Customer.Name;
                    ToolTip = 'Specifies the name of the customer that you shipped the items on the invoice to.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Customer: Record Customer;
                    begin
                        if Rec."Sell-to Customer No." <> '' then
                            Customer.Get(Rec."Sell-to Customer No.");

                        //Customer.LookupCustomer(Customer);
                    end;
                }
                field("Sell-to Customer Name 2"; Rec."Sell-to Customer Name 2")
                {
                    ApplicationArea = All;
                }
                group("Sell-to")
                {
                    Caption = 'Sell-to';
                    field("Sell-to Address"; Rec."Sell-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the customer that the items on the invoice were shipped to.';
                    }
                    field("Sell-to Address 2"; Rec."Sell-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Sell-to City"; Rec."Sell-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    group(Control88)
                    {
                        ShowCaption = false;
                        Visible = IsSellToCountyVisible;
                        field("Sell-to County"; Rec."Sell-to County")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'County';
                            Editable = false;
                            Importance = Additional;
                            ToolTip = 'Specifies the state, province or county as a part of the address.';
                        }
                    }
                    field("Sell-to Post Code"; Rec."Sell-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Sell-to Country/Region Code"; Rec."Sell-to Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Country/Region';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the country or region of the address.';
                    }
                    field("Sell-to Contact No."; Rec."Sell-to Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact that the invoice was sent to.';
                    }
                    field("Sell-to IC Customer No."; Rec."Sell-to IC Customer No.")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Sell-to Contact"; Rec."Sell-to Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contact';
                    Editable = false;
                    ToolTip = 'Specifies the name of the person to contact when you communicate with the customer who you shipped the items to.';
                }
                field("Sell-to Contact E-mail"; Rec."Sell-to Contact E-mail")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Contact Phone"; Rec."Sell-to Contact Phone")
                {
                    ApplicationArea = All;
                }
                field("Your Reference"; Rec."Your Reference")
                {
                    ApplicationArea = All;
                }
                field("Application area"; Rec."Application area")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which you created the sales document.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the date on which the invoice was posted.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date on which the invoice is due for payment.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                group(Control3)
                {
                    ShowCaption = false;
                    Visible = DocExcStatusVisible;
                    field("Document Exchange Status"; Rec."Document Exchange Status")
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                        Importance = Additional;
                        StyleExpr = DocExchStatusStyle;
                        ToolTip = 'Specifies the status of the document if you are using a document exchange service to send it as an electronic document. The status values are reported by the document exchange service.';

                        trigger OnDrillDown()
                        var
                            DocExchServDocStatus: Codeunit "Doc. Exch. Serv.- Doc. Status";
                        begin
                            DocExchServDocStatus.DocExchStatusDrillDown(Rec);
                        end;
                    }
                }
                field("Quote No."; Rec."Quote No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the number of the sales quote document if a quote was used to start the sales process.';
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the number of the sales order that this invoice was posted from.';
                }
                field("Pre-Assigned No."; Rec."Pre-Assigned No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the number of the sales document that the posted invoice was created for.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the external document number that is entered on the sales header that this line was posted from.';
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies which salesperson is associated with the invoice.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    AccessByPermission = TableData "Responsibility Center" = R;
                    ApplicationArea = Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the code of the responsibility center associated with the user who created the invoice, your company, or the customer in the sales invoice.';
                }
                field("No. Printed"; Rec."No. Printed")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies how many times the document has been printed.';
                }
                field(Cancelled; Rec.Cancelled)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = Rec.Cancelled;
                    ToolTip = 'Specifies if the posted sales invoice has been either corrected or canceled.';
                    Visible = IsFoundationEnabled;

                    trigger OnDrillDown()
                    begin
                        Rec.ShowCorrectiveCreditMemo;
                    end;
                }
                field(Corrective; Rec.Corrective)
                {
                    ApplicationArea = Basic, Suite;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = Rec.Corrective;
                    ToolTip = 'Specifies if the posted sales invoice is a corrective document.';

                    trigger OnDrillDown()
                    begin
                        Rec.ShowCancelledCreditMemo;
                    end;
                }
                field(ExternalID; Rec.ExternalID)
                {
                    ApplicationArea = All;
                }
                field("SalesForce Comment"; Rec."SalesForce Comment")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies if the posted invoice is paid. The check box will also be selected if a credit memo for the remaining amount has been applied.';
                }
                group("Work Description")
                {
                    Caption = 'Work Description';
                    field(GetWorkDescription; Rec.GetWorkDescription)
                    {
                        ApplicationArea = Basic, Suite;
                        Editable = false;
                        Importance = Additional;
                        MultiLine = true;
                        ShowCaption = false;
                    }
                }
                group(SalesForce)
                {
                    CaptionML = ENU = 'SalesForce',
                                  NLD = 'SalesForce';
                    field("Comment 2"; Rec."Comment 2")
                    {
                        ApplicationArea = All;
                    }
                    field("IC Payment Terms"; Rec."US Payment Terms")
                    {
                        ApplicationArea = All;
                        Caption = 'IC Payment Terms';
                    }
                    field("IC Sales Order No."; Rec."US Sales Order No.")
                    {
                        ApplicationArea = All;
                        Caption = 'IC Sales Order No.';
                    }
                }
            }
            part(SalesInvLines; "Posted Sales Invoice Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group("Invoice Details")
            {
                Caption = 'Invoice Details';
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the currency code of the invoice.';

                    trigger OnAssistEdit()
                    var
                        UpdateCurrencyFactor: Codeunit "Update Currency Factor";
                    begin
                        ChangeExchangeRate.SetParameter(Rec."Currency Code", Rec."Currency Factor", Rec."Posting Date");
                        ChangeExchangeRate.Editable(false);
                        if ChangeExchangeRate.RunModal = ACTION::OK then begin
                            Rec."Currency Factor" := ChangeExchangeRate.GetParameter;
                            UpdateCurrencyFactor.ModifyPostedSalesInvoice(Rec);
                        end;
                        Clear(ChangeExchangeRate);
                    end;
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; Rec."Shipment Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies when items on the document are shipped or were shipped. A shipment date is usually calculated from a requested delivery date plus lead time.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies a formula that calculates the payment due date, payment discount date, and payment discount amount on the sales document.';
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies how the customer must pay for products on the sales document.';
                }
                group(Control15)
                {
                    ShowCaption = false;
                    Visible = PaymentServiceVisible;
                    field(SelectedPayments; Rec.GetSelectedPaymentsText)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Service';
                        Editable = false;
                        Enabled = PaymentServiceEnabled;
                        MultiLine = true;
                        ToolTip = 'Specifies the payment service, such as PayPal, that the sales invoice can be paid with.';

                        trigger OnAssistEdit()
                        var
                            PaymentServiceSetup: Record "Payment Service Setup";
                        begin
                            PaymentServiceSetup.ChangePaymentServicePostedInvoice(Rec);
                            CurrPage.Update(false);
                        end;
                    }
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = Dimensions;
                }
                field("Payment Discount %"; Rec."Payment Discount %")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the payment discount percent granted if payment is made on or before the date in the Pmt. Discount Date field.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Direct Debit Mandate ID"; Rec."Direct Debit Mandate ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the direct-debit mandate that the customer has signed to allow direct debit collection of payments.';
                }
                field("Language Code"; Rec."Language Code")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Editable = false;
                    Importance = Additional;
                    ToolTip = 'Specifies the code for the location from which the items were shipped.';
                }
            }
            group("Shipping and Billing")
            {
                Caption = 'Shipping and Billing';
                group("Shipping Details")
                {
                    Caption = 'Shipping Details';
                    field("Shipment Method Code"; Rec."Shipment Method Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Method';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the code that represents the shipment method for the invoice.';
                    }
                    field("Shipping Agent Code"; Rec."Shipping Agent Code")
                    {
                        ApplicationArea = Suite;
                        Caption = 'Agent';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies which shipping agent is used to transport the items on the sales document to the customer.';
                    }
                    field("Package Tracking No."; Rec."Package Tracking No.")
                    {
                        ApplicationArea = Suite;
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the shipping agent''s package number.';
                    }
                }
                group("Ship-to")
                {
                    Caption = 'Ship-to';
                    field("Ship-to Code"; Rec."Ship-to Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address Code';
                        Editable = false;
                        Importance = Promoted;
                        ToolTip = 'Specifies the address on purchase orders shipped with a drop shipment directly from the vendor to a customer.';
                    }
                    field("Ship-to Name"; Rec."Ship-to Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        Editable = false;
                        ToolTip = 'Specifies the name of the customer that the items were shipped to.';
                    }
                    field("Ship-to Name 2"; Rec."Ship-to Name 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Ship-to Address"; Rec."Ship-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Editable = false;
                        ToolTip = 'Specifies the address that the items on the invoice were shipped to.';
                    }
                    field("Ship-to Address 2"; Rec."Ship-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Editable = false;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Ship-to City"; Rec."Ship-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Editable = false;
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    group(Control93)
                    {
                        ShowCaption = false;
                        Visible = IsShipToCountyVisible;
                    }
                    field("Ship-to County"; Rec."Ship-to County")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'County';
                        Editable = false;
                        ToolTip = 'Specifies the state, province or county as a part of the address.';
                    }
                    field("Ship-to Post Code"; Rec."Ship-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Editable = false;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Ship-to Country/Region Code"; Rec."Ship-to Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Country/Region';
                        Editable = false;
                        ToolTip = 'Specifies the country or region of the address.';
                    }
                    field("Ship-to Contact"; Rec."Ship-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        Editable = false;
                        ToolTip = 'Specifies the name of the person you regularly contact at the address that the items were shipped to.';
                    }
                }
                group("Bill-to")
                {
                    Caption = 'Bill-to';
                    field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to Name"; Rec."Bill-to Name")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Name';
                        Editable = false;
                        Importance = Promoted;
                        ToolTip = 'Specifies the name of the customer that the invoice was sent to.';
                    }
                    field("Bill-to Name 2"; Rec."Bill-to Name 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Bill-to Address"; Rec."Bill-to Address")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the address of the customer that the invoice was sent to.';
                    }
                    field("Bill-to Address 2"; Rec."Bill-to Address 2")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Address 2';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field("Bill-to City"; Rec."Bill-to City")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'City';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the city of the customer on the sales document.';
                    }
                    group(Control95)
                    {
                        ShowCaption = false;
                        Visible = IsBillToCountyVisible;
                        field("Bill-to County"; Rec."Bill-to County")
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'County';
                            Editable = false;
                            Importance = Additional;
                            ToolTip = 'Specifies the state, province or county as a part of the address.';
                        }
                    }
                    field("Bill-to Post Code"; Rec."Bill-to Post Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Post Code';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Bill-to Country/Region Code"; Rec."Bill-to Country/Region Code")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Country/Region';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the country or region of the address.';
                    }
                    field("Bill-to Contact No."; Rec."Bill-to Contact No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact No.';
                        Editable = false;
                        Importance = Additional;
                        ToolTip = 'Specifies the number of the contact the invoice was sent to.';
                    }
                    field("Bill-to Contact"; Rec."Bill-to Contact")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Contact';
                        Editable = false;
                    }
                }
            }
            group("Foreign Trade")
            {
                Caption = 'Foreign Trade';
                field("EU 3-Party Trade"; Rec."EU 3-Party Trade")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies whether the invoice was part of an EU 3-party trade transaction.';
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the transaction specification that was used in the invoice.';
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the transport method of the sales header that this line was posted from.';
                }
                field("Exit Point"; Rec."Exit Point")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the point of exit through which you ship the items out of your country/region, for reporting to Intrastat.';
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the area code used in the invoice.';
                }
            }
            group("Chinese Localization")
            {
                Caption = 'Chinese Localization';
                field("VAT Customer Name"; Rec."VAT Customer Name")
                {
                    Editable = false;
                    Importance = Promoted;
                    ApplicationArea = All;
                }
                field("VAT Address & Telephone"; Rec."VAT Address & Telephone")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("VAT Bank Name & Account"; Rec."VAT Bank Name & Account")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("VAT Invoice Mail Address"; Rec."VAT Invoice Mail Address")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("VAT Contact Information"; Rec."VAT Contact Information")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(112),
                              "No." = FIELD("No.");
            }
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(Statistics)
                {
                    ApplicationArea = Suite;
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = Page "Sales Invoice Statistics";
                    RunPageLink = "No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ToolTip = 'View statistical information, such as the value of posted entries, for the record.';
                }
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Sales Comment Sheet";
                    RunPageLink = "Document Type" = CONST("Posted Invoice"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Posted Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ShowPostedApprovalEntries(Rec.RecordId);
                    end;
                }
                action(DocAttach)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
                separator(Action171)
                {
                }
                action(ChangePaymentService)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Change Payment Service';
                    Image = ElectronicPayment;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Change or add the payment service, such as PayPal Standard, that will be included on the sales document so the customer can quickly access the payment site.';
                    Visible = PaymentServiceVisible;

                    trigger OnAction()
                    var
                        PaymentServiceSetup: Record "Payment Service Setup";
                    begin
                        PaymentServiceSetup.ChangePaymentServicePostedInvoice(Rec);
                    end;
                }
            }
            group(ActionGroupCRM)
            {
                Caption = 'Dynamics 365 for Sales';
                Visible = CRMIntegrationEnabled;
                action(CRMGotoInvoice)
                {
                    ApplicationArea = Suite;
                    Caption = 'Invoice';
                    Enabled = CRMIsCoupledToRecord;
                    Image = CoupledSalesInvoice;
                    ToolTip = 'Open the coupled Dynamics 365 for Sales invoice.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowCRMEntityFromRecordID(Rec.RecordId);
                    end;
                }
                action(CreateInCRM)
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Invoice in Dynamics 365 for Sales';
                    Enabled = NOT CRMIsCoupledToRecord;
                    Image = NewSalesInvoice;
                    ToolTip = 'Create a sales invoice in Dynamics 365 for Sales that is connected to this posted sales invoice.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.CreateNewRecordsInCRM(Rec.RecordId);
                    end;
                }
                action(ShowLog)
                {
                    ApplicationArea = Suite;
                    Caption = 'Synchronization Log';
                    Image = Log;
                    ToolTip = 'View integration synchronization jobs for the posted sales invoice table.';

                    trigger OnAction()
                    var
                        CRMIntegrationManagement: Codeunit "CRM Integration Management";
                    begin
                        CRMIntegrationManagement.ShowLog(Rec.RecordId);
                    end;
                }
            }
        }
        area(processing)
        {
            action(SendCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send';
                Ellipsis = true;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Prepare to send the document according to the customer''s sending profile, such as attached to an email. The Send document to window opens first so you can confirm or select a sending profile.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.SendRecords;
                end;
            }
            action(Print)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                Visible = NOT IsOfficeAddin;

                trigger OnAction()
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.PrintRecords(true);
                end;
            }
            action(Email)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Email';
                Image = Email;
                Promoted = true;
                PromotedCategory = Category6;
                ToolTip = 'Prepare to email the document. The Send Email window opens prefilled with the customer''s email address so you can add or edit information.';

                trigger OnAction()
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    SalesInvHeader.EmailRecords(true);
                end;
            }
            action("&Navigate")
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                Visible = NOT IsOfficeAddin;

                trigger OnAction()
                begin
                    Rec.Navigate;
                end;
            }
            action(ActivityLog)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Activity Log';
                Image = Log;
                ToolTip = 'View the status and any errors if the document was sent as an electronic document or OCR file through the document exchange service.';

                trigger OnAction()
                begin
                    Rec.ShowActivityLog;
                end;
            }
            group(IncomingDocument)
            {
                Caption = 'Incoming Document';
                Image = Documents;
                action(IncomingDocCard)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'View Incoming Document';
                    Enabled = HasIncomingDocument;
                    Image = ViewOrder;
                    ToolTip = 'View any incoming document records and file attachments that exist for the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.ShowCard(Rec."No.", Rec."Posting Date");
                    end;
                }
                action(SelectIncomingDoc)
                {
                    AccessByPermission = TableData "Incoming Document" = R;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Select Incoming Document';
                    Enabled = NOT HasIncomingDocument;
                    Image = SelectLineToApply;
                    ToolTip = 'Select an incoming document record and file attachment that you want to link to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocument: Record "Incoming Document";
                    begin
                        IncomingDocument.SelectIncomingDocumentForPostedDocument(Rec."No.", Rec."Posting Date", Rec.RecordId);
                    end;
                }
                action(IncomingDocAttachFile)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Incoming Document from File';
                    Ellipsis = true;
                    Enabled = NOT HasIncomingDocument;
                    Image = Attach;
                    ToolTip = 'Create an incoming document record by selecting a file to attach, and then link the incoming document record to the entry or document.';

                    trigger OnAction()
                    var
                        IncomingDocumentAttachment: Record "Incoming Document Attachment";
                    begin
                        IncomingDocumentAttachment.NewAttachmentFromPostedDocument(Rec."No.", Rec."Posting Date");
                    end;
                }
            }
            group(Correct)
            {
                Caption = 'Correct';
                action(CorrectInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Correct';
                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Reverse this posted invoice and automatically create a new invoice with the same information that you can correct before posting. This posted invoice will automatically be canceled.';
                    Visible = IsFoundationEnabled;

                    trigger OnAction()
                    var
                        CorrectPstdSalesInvYesNo: Codeunit "Correct PstdSalesInv (Yes/No)";
                    begin
                        //  if CorrectPstdSalesInvYesNo.CorrectInvoice(Rec) then
                        //     CurrPage.Close;
                    end;
                }
                action(CancelInvoice)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    Visible = IsFoundationEnabled;

                    trigger OnAction()
                    var
                        CancelPstdSalesInvYesNo: Codeunit "Cancel PstdSalesInv (Yes/No)";
                    begin
                        if CancelPstdSalesInvYesNo.CancelInvoice(Rec) then
                            CurrPage.Close;
                    end;
                }
                action(CreateCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Create Corrective Credit Memo';
                    Image = CreateCreditMemo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;
                    ToolTip = 'Create a credit memo for this posted invoice that you complete and post manually to reverse the posted invoice.';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        CorrectPostedSalesInvoice: Codeunit "Correct Posted Sales Invoice";
                    begin
                        if CorrectPostedSalesInvoice.CreateCreditMemoCopyDocument(Rec, SalesHeader) then begin
                            PAGE.Run(PAGE::"Sales Credit Memo", SalesHeader);
                            CurrPage.Close;
                        end;
                    end;
                }
                action(ShowCreditMemo)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Show Canceled/Corrective Credit Memo';
                    Enabled = Rec.Cancelled OR Rec.Corrective;
                    Image = CreditMemo;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Open the posted sales credit memo that was created when you canceled the posted sales invoice. If the posted sales invoice is the result of a canceled sales credit memo, then the canceled sales credit memo will open.';

                    trigger OnAction()
                    begin
                        Rec.ShowCanceledOrCorrCrMemo;
                    end;
                }
            }
            group(Invoice)
            {
                Caption = 'Invoice';
                Image = Invoice;
                action(Customer)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer';
                    Image = Customer;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    RunObject = Page "Customer Card";
                    RunPageLink = "No." = FIELD("Sell-to Customer No.");
                    ShortCutKey = 'Shift+F7';
                    ToolTip = 'View or edit detailed information about the customer.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record "Incoming Document";
        CRMCouplingManagement: Codeunit "CRM Coupling Management";
    begin
        HasIncomingDocument := IncomingDocument.PostedDocExists(Rec."No.", Rec."Posting Date");
        DocExchStatusStyle := Rec.GetDocExchStatusStyle;
        CurrPage.IncomingDocAttachFactBox.PAGE.LoadDataFromRecord(Rec);
        if CRMIntegrationEnabled then begin
            CRMIsCoupledToRecord := CRMCouplingManagement.IsRecordCoupledToCRM(Rec.RecordId);
            if Rec."No." <> xRec."No." then
                CRMIntegrationManagement.SendResultNotification(Rec);
        end;
        UpdatePaymentService;
        DocExcStatusVisible := Rec.DocExchangeStatusIsSent;
    end;

    trigger OnAfterGetRecord()
    begin
        DocExchStatusStyle := Rec.GetDocExchStatusStyle;
    end;

    trigger OnInit()
    begin
        DocExcStatusVisible := true;
    end;

    trigger OnOpenPage()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
        OfficeMgt: Codeunit "Office Management";
    begin
        Rec.SetSecurityFilterOnRespCenter;
        CRMIntegrationEnabled := CRMIntegrationManagement.IsCRMIntegrationEnabled;

        IsOfficeAddin := OfficeMgt.IsAvailable;
        IsFoundationEnabled := ApplicationAreaMgmtFacade.IsFoundationEnabled;

        ActivateFields;
        PaymentServiceVisible := PaymentServiceSetup.IsPaymentServiceVisible;
    end;

    var
        SalesInvHeader: Record "Sales Invoice Header";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        CRMIntegrationManagement: Codeunit "CRM Integration Management";
        FormatAddress: Codeunit "Format Address";
        ChangeExchangeRate: Page "Change Exchange Rate";
        HasIncomingDocument: Boolean;
        DocExchStatusStyle: Text;
        CRMIntegrationEnabled: Boolean;
        CRMIsCoupledToRecord: Boolean;
        PaymentServiceVisible: Boolean;
        PaymentServiceEnabled: Boolean;
        DocExcStatusVisible: Boolean;
        IsOfficeAddin: Boolean;
        IsFoundationEnabled: Boolean;
        IsBillToCountyVisible: Boolean;
        IsSellToCountyVisible: Boolean;
        IsShipToCountyVisible: Boolean;

    local procedure ActivateFields()
    begin
        IsBillToCountyVisible := FormatAddress.UseCounty(Rec."Bill-to Country/Region Code");
        IsSellToCountyVisible := FormatAddress.UseCounty(Rec."Sell-to Country/Region Code");
        IsShipToCountyVisible := FormatAddress.UseCounty(Rec."Ship-to Country/Region Code");
    end;

    local procedure UpdatePaymentService()
    var
        PaymentServiceSetup: Record "Payment Service Setup";
    begin
        PaymentServiceEnabled := PaymentServiceSetup.CanChangePaymentService(Rec);
    end;
}

