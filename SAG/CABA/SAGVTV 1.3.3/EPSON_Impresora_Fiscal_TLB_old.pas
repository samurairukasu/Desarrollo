unit EPSON_Impresora_Fiscal_TLB;

{ This file contains pascal declarations imported from a type library.
  This file will be written during each import or refresh of the type
  library editor.  Changes to this file will be discarded during the
  refresh process. }

{ EPSON_Impresora_Fiscal }
{ Version 1.0 }

interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, StdVCL;

const
  LIBID_EPSON_Impresora_Fiscal: TGUID = '{2C418C3E-54A3-11D3-BC02-00C0F010C82A}';

const

{ Component class GUIDs }
  Class_PrinterFiscal: TGUID = '{2C418C40-54A3-11D3-BC02-00C0F010C82A}';

type

{ Forward declarations: Interfaces }
  _PrinterFiscal = interface;
  _PrinterFiscalDisp = dispinterface;
  __PrinterFiscal = dispinterface;

{ Forward declarations: CoClasses }
  PrinterFiscal = _PrinterFiscal;

  _PrinterFiscal = interface(IDispatch)
    ['{2C418C3F-54A3-11D3-BC02-00C0F010C82A}']
    function CloseJournal(var CloseType, Impresion: WideString): WordBool; safecall;
    function FeedPaper(var Station, Lines: WideString): WordBool; safecall;
    function CutPaper: WordBool; safecall;
    function SetGetHeaderTrailer(var Action, Number, Text: WideString): WordBool; safecall;
    function SetGetDateTime(var Action, DateYYMMDD, TimeHHMMSS: WideString): WordBool; safecall;
    function Status(var StatusType: WideString): WordBool; safecall;
    function OpenCashDrawer(var Number: WideString): WordBool; safecall;
    function Audit(var AuditType, AuditMode, Start, Finish: WideString): WordBool; safecall;
    function OpenNoFiscal: WordBool; safecall;
    function SendNoFiscalText(var Text: WideString): WordBool; safecall;
    function CloseNoFiscal: WordBool; safecall;
    function OpenTicket(var StorageDataType: WideString): WordBool; safecall;
    function SendTicketItem(var Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, FixesInternalTaxes: WideString): WordBool; safecall;
    function SendExtraDescription(var Text: WideString): WordBool; safecall;
    function GetTicketSubtotal(var Impresion, Text: WideString): WordBool; safecall;
    function SendTicketPayment(var Text, Amount, PaymentType: WideString): WordBool; safecall;
    function CloseTicket: WordBool; safecall;
    function OpenInvoice(var InvoiceType, PaperType, InvoiceLetter, Copies, FormType, FontType, IVA_Seller, IVA_Buyer, BuyerName1, BuyerName2, BuyerDocumentType, BuyerDocumentNumber, FixedAssest, BuyerAddress1, BuyerAddress2, BuyerAddress3, Remit1, Remit2, StorageDataType: WideString): WordBool; safecall;
    function SendInvoiceItem(var Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, ExtraLine1, ExtraLine2, ExtraLine3, IncreaseTax, FixesInternalTaxes: WideString): WordBool; safecall;
    function GetInvoiceSubtotal(var Impresion, Text: WideString): WordBool; safecall;
    function SendInvoicePerception(var Description, Qualifier, Amount: WideString): WordBool; safecall;
    function SendInvoicePayment(var Text, Amount, PaymentType: WideString): WordBool; safecall;
    function CloseInvoice(var InvoiceType, InvoiceLetter, Text: WideString): WordBool; safecall;
    function DNFHCreditCard(var CardName, CardNumber, UserName, ExpireDate, CompanyNumber, VoucherNumber, InternalNumber, AutorizationCode, OperationType, Amount, QuotaAmount, CurrencyType, TerminalNumber, LotNumber, ETerminalNumber, BranchNumber, OperatorNumber, FiscalDocumentNumber, SignPrint, ExplanationPrint, PhonePrint: WideString): WordBool; safecall;
    function DNFHDrugstore(var HealthCompanyName, CosecureLine1, CosecureLine2, CosecureLine3, MemberNumber, MemberName, ExpireDate, AddressLine1, AddressLine2, CompanyNameOrNumber, InternalNumber, DescriptionLine1, DescriptionLine2, AddressPrint, DocumentNumberPrint, SignPrint, ExplanationPrint, PhonePrint: WideString): WordBool; safecall;
    function Get_PortNumber: OleVariant; safecall;
    procedure Set_PortNumber(Value: OleVariant); safecall;
    function Get_BaudRate: OleVariant; safecall;
    procedure Set_BaudRate(Value: OleVariant); safecall;
    function Get_FiscalStatus: OleVariant; safecall;
    function Get_PrinterStatus: OleVariant; safecall;
    procedure Set_FiscalStatus(Value: OleVariant); safecall;
    procedure Set_PrinterStatus(Value: OleVariant); safecall;
    function Get_AnswerField_3: OleVariant; safecall;
    procedure Set_AnswerField_3(Value: OleVariant); safecall;
    function Get_AnswerField_4: OleVariant; safecall;
    procedure Set_AnswerField_4(Value: OleVariant); safecall;
    function Get_AnswerField_5: OleVariant; safecall;
    procedure Set_AnswerField_5(Value: OleVariant); safecall;
    function Get_AnswerField_6: OleVariant; safecall;
    procedure Set_AnswerField_6(Value: OleVariant); safecall;
    function Get_AnswerField_7: OleVariant; safecall;
    procedure Set_AnswerField_7(Value: OleVariant); safecall;
    function Get_AnswerField_8: OleVariant; safecall;
    procedure Set_AnswerField_8(Value: OleVariant); safecall;
    function Get_AnswerField_9: OleVariant; safecall;
    procedure Set_AnswerField_9(Value: OleVariant); safecall;
    function Get_AnswerField_10: OleVariant; safecall;
    procedure Set_AnswerField_10(Value: OleVariant); safecall;
    function Get_AnswerField_11: OleVariant; safecall;
    procedure Set_AnswerField_11(Value: OleVariant); safecall;
    function Get_AnswerField_12: OleVariant; safecall;
    procedure Set_AnswerField_12(Value: OleVariant); safecall;
    function Get_AnswerField_13: OleVariant; safecall;
    procedure Set_AnswerField_13(Value: OleVariant); safecall;
    function Get_AnswerField_14: OleVariant; safecall;
    procedure Set_AnswerField_14(Value: OleVariant); safecall;
    function Get_AnswerField_15: OleVariant; safecall;
    procedure Set_AnswerField_15(Value: OleVariant); safecall;
    function Get_AnswerField_16: OleVariant; safecall;
    procedure Set_AnswerField_16(Value: OleVariant); safecall;
    function Get_AnswerField_17: OleVariant; safecall;
    procedure Set_AnswerField_17(Value: OleVariant); safecall;
    function Get_AnswerField_18: OleVariant; safecall;
    procedure Set_AnswerField_18(Value: OleVariant); safecall;
    function Get_AnswerField_19: OleVariant; safecall;
    procedure Set_AnswerField_19(Value: OleVariant); safecall;
    function Get_MessagesOn: WordBool; safecall;
    procedure Set_MessagesOn(Value: WordBool); safecall;
    property PortNumber: OleVariant read Get_PortNumber write Set_PortNumber;
    property BaudRate: OleVariant read Get_BaudRate write Set_BaudRate;
    property FiscalStatus: OleVariant read Get_FiscalStatus write Set_FiscalStatus;
    property PrinterStatus: OleVariant read Get_PrinterStatus write Set_PrinterStatus;
    property AnswerField_3: OleVariant read Get_AnswerField_3 write Set_AnswerField_3;
    property AnswerField_4: OleVariant read Get_AnswerField_4 write Set_AnswerField_4;
    property AnswerField_5: OleVariant read Get_AnswerField_5 write Set_AnswerField_5;
    property AnswerField_6: OleVariant read Get_AnswerField_6 write Set_AnswerField_6;
    property AnswerField_7: OleVariant read Get_AnswerField_7 write Set_AnswerField_7;
    property AnswerField_8: OleVariant read Get_AnswerField_8 write Set_AnswerField_8;
    property AnswerField_9: OleVariant read Get_AnswerField_9 write Set_AnswerField_9;
    property AnswerField_10: OleVariant read Get_AnswerField_10 write Set_AnswerField_10;
    property AnswerField_11: OleVariant read Get_AnswerField_11 write Set_AnswerField_11;
    property AnswerField_12: OleVariant read Get_AnswerField_12 write Set_AnswerField_12;
    property AnswerField_13: OleVariant read Get_AnswerField_13 write Set_AnswerField_13;
    property AnswerField_14: OleVariant read Get_AnswerField_14 write Set_AnswerField_14;
    property AnswerField_15: OleVariant read Get_AnswerField_15 write Set_AnswerField_15;
    property AnswerField_16: OleVariant read Get_AnswerField_16 write Set_AnswerField_16;
    property AnswerField_17: OleVariant read Get_AnswerField_17 write Set_AnswerField_17;
    property AnswerField_18: OleVariant read Get_AnswerField_18 write Set_AnswerField_18;
    property AnswerField_19: OleVariant read Get_AnswerField_19 write Set_AnswerField_19;
    property MessagesOn: WordBool read Get_MessagesOn write Set_MessagesOn;
  end;

{ DispInterface declaration for Dual Interface _PrinterFiscal }

  _PrinterFiscalDisp = dispinterface
    ['{2C418C3F-54A3-11D3-BC02-00C0F010C82A}']
    function CloseJournal(var CloseType, Impresion: WideString): WordBool; dispid 1610809366;
    function FeedPaper(var Station, Lines: WideString): WordBool; dispid 1610809367;
    function CutPaper: WordBool; dispid 1610809368;
    function SetGetHeaderTrailer(var Action, Number, Text: WideString): WordBool; dispid 1610809369;
    function SetGetDateTime(var Action, DateYYMMDD, TimeHHMMSS: WideString): WordBool; dispid 1610809370;
    function Status(var StatusType: WideString): WordBool; dispid 1610809371;
    function OpenCashDrawer(var Number: WideString): WordBool; dispid 1610809372;
    function Audit(var AuditType, AuditMode, Start, Finish: WideString): WordBool; dispid 1610809373;
    function OpenNoFiscal: WordBool; dispid 1610809374;
    function SendNoFiscalText(var Text: WideString): WordBool; dispid 1610809375;
    function CloseNoFiscal: WordBool; dispid 1610809376;
    function OpenTicket(var StorageDataType: WideString): WordBool; dispid 1610809377;
    function SendTicketItem(var Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, FixesInternalTaxes: WideString): WordBool; dispid 1610809378;
    function SendExtraDescription(var Text: WideString): WordBool; dispid 1610809379;
    function GetTicketSubtotal(var Impresion, Text: WideString): WordBool; dispid 1610809380;
    function SendTicketPayment(var Text, Amount, PaymentType: WideString): WordBool; dispid 1610809381;
    function CloseTicket: WordBool; dispid 1610809382;
    function OpenInvoice(var InvoiceType, PaperType, InvoiceLetter, Copies, FormType, FontType, IVA_Seller, IVA_Buyer, BuyerName1, BuyerName2, BuyerDocumentType, BuyerDocumentNumber, FixedAssest, BuyerAddress1, BuyerAddress2, BuyerAddress3, Remit1, Remit2, StorageDataType: WideString): WordBool; dispid 1610809383;
    function SendInvoiceItem(var Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, ExtraLine1, ExtraLine2, ExtraLine3, IncreaseTax, FixesInternalTaxes: WideString): WordBool; dispid 1610809384;
    function GetInvoiceSubtotal(var Impresion, Text: WideString): WordBool; dispid 1610809385;
    function SendInvoicePerception(var Description, Qualifier, Amount: WideString): WordBool; dispid 1610809386;
    function SendInvoicePayment(var Text, Amount, PaymentType: WideString): WordBool; dispid 1610809387;
    function CloseInvoice(var InvoiceType, InvoiceLetter, Text: WideString): WordBool; dispid 1610809388;
    function DNFHCreditCard(var CardName, CardNumber, UserName, ExpireDate, CompanyNumber, VoucherNumber, InternalNumber, AutorizationCode, OperationType, Amount, QuotaAmount, CurrencyType, TerminalNumber, LotNumber, ETerminalNumber, BranchNumber, OperatorNumber, FiscalDocumentNumber, SignPrint, ExplanationPrint, PhonePrint: WideString): WordBool; dispid 1610809389;
    function DNFHDrugstore(var HealthCompanyName, CosecureLine1, CosecureLine2, CosecureLine3, MemberNumber, MemberName, ExpireDate, AddressLine1, AddressLine2, CompanyNameOrNumber, InternalNumber, DescriptionLine1, DescriptionLine2, AddressPrint, DocumentNumberPrint, SignPrint, ExplanationPrint, PhonePrint: WideString): WordBool; dispid 1610809390;
    property PortNumber: OleVariant dispid 1745027093;
    property BaudRate: OleVariant dispid 1745027092;
    property FiscalStatus: OleVariant dispid 1745027091;
    property PrinterStatus: OleVariant dispid 1745027090;
    property AnswerField_3: OleVariant dispid 1745027089;
    property AnswerField_4: OleVariant dispid 1745027088;
    property AnswerField_5: OleVariant dispid 1745027087;
    property AnswerField_6: OleVariant dispid 1745027086;
    property AnswerField_7: OleVariant dispid 1745027085;
    property AnswerField_8: OleVariant dispid 1745027084;
    property AnswerField_9: OleVariant dispid 1745027083;
    property AnswerField_10: OleVariant dispid 1745027082;
    property AnswerField_11: OleVariant dispid 1745027081;
    property AnswerField_12: OleVariant dispid 1745027080;
    property AnswerField_13: OleVariant dispid 1745027079;
    property AnswerField_14: OleVariant dispid 1745027078;
    property AnswerField_15: OleVariant dispid 1745027077;
    property AnswerField_16: OleVariant dispid 1745027076;
    property AnswerField_17: OleVariant dispid 1745027075;
    property AnswerField_18: OleVariant dispid 1745027074;
    property AnswerField_19: OleVariant dispid 1745027073;
    property MessagesOn: WordBool dispid 1745027072;
  end;

  __PrinterFiscal = dispinterface
    ['{2C418C41-54A3-11D3-BC02-00C0F010C82A}']
  end;

  TPrinterFiscal = class(TOleControl)
  private
    FIntf: _PrinterFiscal;
  protected
    procedure InitControlData; override;
    procedure InitControlInterface(const Obj: IUnknown); override;
  public
    function CloseJournal(var CloseType, Impresion: WideString): WordBool;
    function FeedPaper(var Station, Lines: WideString): WordBool;
    function CutPaper: WordBool;
    function SetGetHeaderTrailer(var Action, Number, Text: WideString): WordBool;
    function SetGetDateTime(var Action, DateYYMMDD, TimeHHMMSS: WideString): WordBool;
    function Status(var StatusType: WideString): WordBool;
    function OpenCashDrawer(var Number: WideString): WordBool;
    function Audit(var AuditType, AuditMode, Start, Finish: WideString): WordBool;
    function OpenNoFiscal: WordBool;
    function SendNoFiscalText(var Text: WideString): WordBool;
    function CloseNoFiscal: WordBool;
    function OpenTicket(var StorageDataType: WideString): WordBool;
    function SendTicketItem(var Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, FixesInternalTaxes: WideString): WordBool;
    function SendExtraDescription(var Text: WideString): WordBool;
    function GetTicketSubtotal(var Impresion, Text: WideString): WordBool;
    function SendTicketPayment(var Text, Amount, PaymentType: WideString): WordBool;
    function CloseTicket: WordBool;
    function OpenInvoice(var InvoiceType, PaperType, InvoiceLetter, Copies, FormType, FontType, IVA_Seller, IVA_Buyer, BuyerName1, BuyerName2, BuyerDocumentType, BuyerDocumentNumber, FixedAssest, BuyerAddress1, BuyerAddress2, BuyerAddress3, Remit1, Remit2, StorageDataType: WideString): WordBool;
    function SendInvoiceItem(var Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, ExtraLine1, ExtraLine2, ExtraLine3, IncreaseTax, FixesInternalTaxes: WideString): WordBool;
    function GetInvoiceSubtotal(var Impresion, Text: WideString): WordBool;
    function SendInvoicePerception(var Description, Qualifier, Amount: WideString): WordBool;
    function SendInvoicePayment(var Text, Amount, PaymentType: WideString): WordBool;
    function CloseInvoice(var InvoiceType, InvoiceLetter, Text: WideString): WordBool;
    function DNFHCreditCard(var CardName, CardNumber, UserName, ExpireDate, CompanyNumber, VoucherNumber, InternalNumber, AutorizationCode, OperationType, Amount, QuotaAmount, CurrencyType, TerminalNumber, LotNumber, ETerminalNumber, BranchNumber, OperatorNumber, FiscalDocumentNumber, SignPrint, ExplanationPrint, PhonePrint: WideString): WordBool;
    function DNFHDrugstore(var HealthCompanyName, CosecureLine1, CosecureLine2, CosecureLine3, MemberNumber, MemberName, ExpireDate, AddressLine1, AddressLine2, CompanyNameOrNumber, InternalNumber, DescriptionLine1, DescriptionLine2, AddressPrint, DocumentNumberPrint, SignPrint, ExplanationPrint, PhonePrint: WideString): WordBool;
    property ControlInterface: _PrinterFiscal read FIntf;
  published
    property PortNumber: OleVariant index 1745027093 read GetOleVariantProp write SetOleVariantProp stored False;
    property BaudRate: OleVariant index 1745027092 read GetOleVariantProp write SetOleVariantProp stored False;
    property FiscalStatus: OleVariant index 1745027091 read GetOleVariantProp write SetOleVariantProp stored False;
    property PrinterStatus: OleVariant index 1745027090 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_3: OleVariant index 1745027089 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_4: OleVariant index 1745027088 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_5: OleVariant index 1745027087 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_6: OleVariant index 1745027086 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_7: OleVariant index 1745027085 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_8: OleVariant index 1745027084 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_9: OleVariant index 1745027083 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_10: OleVariant index 1745027082 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_11: OleVariant index 1745027081 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_12: OleVariant index 1745027080 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_13: OleVariant index 1745027079 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_14: OleVariant index 1745027078 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_15: OleVariant index 1745027077 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_16: OleVariant index 1745027076 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_17: OleVariant index 1745027075 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_18: OleVariant index 1745027074 read GetOleVariantProp write SetOleVariantProp stored False;
    property AnswerField_19: OleVariant index 1745027073 read GetOleVariantProp write SetOleVariantProp stored False;
    property MessagesOn: WordBool index 1745027072 read GetWordBoolProp write SetWordBoolProp stored False;
  end;

procedure Register;

implementation

uses ComObj;

procedure TPrinterFiscal.InitControlData;
const
  CControlData: TControlData = (
    ClassID: '{2C418C40-54A3-11D3-BC02-00C0F010C82A}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: nil;
    Flags: $00000000;
    Version: 300);
begin
  ControlData := @CControlData;
end;

procedure TPrinterFiscal.InitControlInterface(const Obj: IUnknown);
begin
  FIntf := Obj as _PrinterFiscal;
end;

function TPrinterFiscal.CloseJournal(var CloseType, Impresion: WideString): WordBool;
begin
  Result := ControlInterface.CloseJournal(CloseType, Impresion);
end;

function TPrinterFiscal.FeedPaper(var Station, Lines: WideString): WordBool;
begin
  Result := ControlInterface.FeedPaper(Station, Lines);
end;

function TPrinterFiscal.CutPaper: WordBool;
begin
  Result := ControlInterface.CutPaper;
end;

function TPrinterFiscal.SetGetHeaderTrailer(var Action, Number, Text: WideString): WordBool;
begin
  Result := ControlInterface.SetGetHeaderTrailer(Action, Number, Text);
end;

function TPrinterFiscal.SetGetDateTime(var Action, DateYYMMDD, TimeHHMMSS: WideString): WordBool;
begin
  Result := ControlInterface.SetGetDateTime(Action, DateYYMMDD, TimeHHMMSS);
end;

function TPrinterFiscal.Status(var StatusType: WideString): WordBool;
begin
  Result := ControlInterface.Status(StatusType);
end;

function TPrinterFiscal.OpenCashDrawer(var Number: WideString): WordBool;
begin
  Result := ControlInterface.OpenCashDrawer(Number);
end;

function TPrinterFiscal.Audit(var AuditType, AuditMode, Start, Finish: WideString): WordBool;
begin
  Result := ControlInterface.Audit(AuditType, AuditMode, Start, Finish);
end;

function TPrinterFiscal.OpenNoFiscal: WordBool;
begin
  Result := ControlInterface.OpenNoFiscal;
end;

function TPrinterFiscal.SendNoFiscalText(var Text: WideString): WordBool;
begin
  Result := ControlInterface.SendNoFiscalText(Text);
end;

function TPrinterFiscal.CloseNoFiscal: WordBool;
begin
  Result := ControlInterface.CloseNoFiscal;
end;

function TPrinterFiscal.OpenTicket(var StorageDataType: WideString): WordBool;
begin
  Result := ControlInterface.OpenTicket(StorageDataType);
end;

function TPrinterFiscal.SendTicketItem(var Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, FixesInternalTaxes: WideString): WordBool;
begin
  Result := ControlInterface.SendTicketItem(Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, FixesInternalTaxes);
end;

function TPrinterFiscal.SendExtraDescription(var Text: WideString): WordBool;
begin
  Result := ControlInterface.SendExtraDescription(Text);
end;

function TPrinterFiscal.GetTicketSubtotal(var Impresion, Text: WideString): WordBool;
begin
  Result := ControlInterface.GetTicketSubtotal(Impresion, Text);
end;

function TPrinterFiscal.SendTicketPayment(var Text, Amount, PaymentType: WideString): WordBool;
begin
  Result := ControlInterface.SendTicketPayment(Text, Amount, PaymentType);
end;

function TPrinterFiscal.CloseTicket: WordBool;
begin
  Result := ControlInterface.CloseTicket;
end;

function TPrinterFiscal.OpenInvoice(var InvoiceType, PaperType, InvoiceLetter, Copies, FormType, FontType, IVA_Seller, IVA_Buyer, BuyerName1, BuyerName2, BuyerDocumentType, BuyerDocumentNumber, FixedAssest, BuyerAddress1, BuyerAddress2, BuyerAddress3, Remit1, Remit2, StorageDataType: WideString): WordBool;
begin
  Result := ControlInterface.OpenInvoice(InvoiceType, PaperType, InvoiceLetter, Copies, FormType, FontType, IVA_Seller, IVA_Buyer, BuyerName1, BuyerName2, BuyerDocumentType, BuyerDocumentNumber, FixedAssest, BuyerAddress1, BuyerAddress2, BuyerAddress3, Remit1, Remit2, StorageDataType);
end;

function TPrinterFiscal.SendInvoiceItem(var Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, ExtraLine1, ExtraLine2, ExtraLine3, IncreaseTax, FixesInternalTaxes: WideString): WordBool;
begin
  Result := ControlInterface.SendInvoiceItem(Description, Quantity, UnitPrice, IVA_Tax, Qualifier, Bundle, PorcentualInternalTaxes, ExtraLine1, ExtraLine2, ExtraLine3, IncreaseTax, FixesInternalTaxes);
end;

function TPrinterFiscal.GetInvoiceSubtotal(var Impresion, Text: WideString): WordBool;
begin
  Result := ControlInterface.GetInvoiceSubtotal(Impresion, Text);
end;

function TPrinterFiscal.SendInvoicePerception(var Description, Qualifier, Amount: WideString): WordBool;
begin
  Result := ControlInterface.SendInvoicePerception(Description, Qualifier, Amount);
end;

function TPrinterFiscal.SendInvoicePayment(var Text, Amount, PaymentType: WideString): WordBool;
begin
  Result := ControlInterface.SendInvoicePayment(Text, Amount, PaymentType);
end;

function TPrinterFiscal.CloseInvoice(var InvoiceType, InvoiceLetter, Text: WideString): WordBool;
begin
  Result := ControlInterface.CloseInvoice(InvoiceType, InvoiceLetter, Text);
end;

function TPrinterFiscal.DNFHCreditCard(var CardName, CardNumber, UserName, ExpireDate, CompanyNumber, VoucherNumber, InternalNumber, AutorizationCode, OperationType, Amount, QuotaAmount, CurrencyType, TerminalNumber, LotNumber, ETerminalNumber, BranchNumber, OperatorNumber, FiscalDocumentNumber, SignPrint, ExplanationPrint, PhonePrint: WideString): WordBool;
begin
  Result := ControlInterface.DNFHCreditCard(CardName, CardNumber, UserName, ExpireDate, CompanyNumber, VoucherNumber, InternalNumber, AutorizationCode, OperationType, Amount, QuotaAmount, CurrencyType, TerminalNumber, LotNumber, ETerminalNumber, BranchNumber, OperatorNumber, FiscalDocumentNumber, SignPrint, ExplanationPrint, PhonePrint);
end;

function TPrinterFiscal.DNFHDrugstore(var HealthCompanyName, CosecureLine1, CosecureLine2, CosecureLine3, MemberNumber, MemberName, ExpireDate, AddressLine1, AddressLine2, CompanyNameOrNumber, InternalNumber, DescriptionLine1, DescriptionLine2, AddressPrint, DocumentNumberPrint, SignPrint, ExplanationPrint, PhonePrint: WideString): WordBool;
begin
  Result := ControlInterface.DNFHDrugstore(HealthCompanyName, CosecureLine1, CosecureLine2, CosecureLine3, MemberNumber, MemberName, ExpireDate, AddressLine1, AddressLine2, CompanyNameOrNumber, InternalNumber, DescriptionLine1, DescriptionLine2, AddressPrint, DocumentNumberPrint, SignPrint, ExplanationPrint, PhonePrint);
end;


procedure Register;
begin
  RegisterComponents('ActiveX', [TPrinterFiscal]);
end;

end.
