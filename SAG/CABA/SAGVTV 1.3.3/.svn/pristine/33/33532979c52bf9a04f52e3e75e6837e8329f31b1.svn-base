unit EPSON_Impresora_Fiscal_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : $Revision:   1.88.1.0.1.0  $
// File generated on 02/09/2005 05:21:12 p.m. from Type Library described below.

// ************************************************************************ //
// Type Lib: C:\Archivos de programa\Borland\Delphi5\Componentes\Epson\IFEpson.ocx (1)
// IID\LCID: {2C418C3E-54A3-11D3-BC02-00C0F010C82A}\0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\system32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  EPSON_Impresora_FiscalMajorVersion = 1;
  EPSON_Impresora_FiscalMinorVersion = 0;

  LIBID_EPSON_Impresora_Fiscal: TGUID = '{2C418C3E-54A3-11D3-BC02-00C0F010C82A}';

  IID__PrinterFiscal: TGUID = '{2C418C3F-54A3-11D3-BC02-00C0F010C82A}';
  DIID___PrinterFiscal: TGUID = '{2C418C41-54A3-11D3-BC02-00C0F010C82A}';
  CLASS_PrinterFiscal: TGUID = '{2C418C40-54A3-11D3-BC02-00C0F010C82A}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _PrinterFiscal = interface;
  _PrinterFiscalDisp = dispinterface;
  __PrinterFiscal = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  PrinterFiscal = _PrinterFiscal;


// *********************************************************************//
// Interface: _PrinterFiscal
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C418C3F-54A3-11D3-BC02-00C0F010C82A}
// *********************************************************************//
  _PrinterFiscal = interface(IDispatch)
    ['{2C418C3F-54A3-11D3-BC02-00C0F010C82A}']
    function  CloseJournal(var CloseType: WideString; var Impresion: WideString): WordBool; safecall;
    function  FeedPaper(var Station: WideString; var Lines: WideString): WordBool; safecall;
    function  CutPaper: WordBool; safecall;
    function  SetGetHeaderTrailer(var Action: WideString; var Number: WideString; 
                                  var Text: WideString): WordBool; safecall;
    function  SetGetDateTime(var Action: WideString; var DateYYMMDD: WideString; 
                             var TimeHHMMSS: WideString): WordBool; safecall;
    function  Status(var StatusType: WideString): WordBool; safecall;
    function  OpenCashDrawer(var Number: WideString): WordBool; safecall;
    function  Audit(var AuditType: WideString; var AuditMode: WideString; var Start: WideString; 
                    var Finish: WideString): WordBool; safecall;
    function  OpenNoFiscal: WordBool; safecall;
    function  SendNoFiscalText(var Text: WideString): WordBool; safecall;
    function  CloseNoFiscal: WordBool; safecall;
    function  OpenTicket(var StorageDataType: WideString): WordBool; safecall;
    function  SendTicketItem(var Description: WideString; var Quantity: WideString; 
                             var UnitPrice: WideString; var IVA_Tax: WideString; 
                             var Qualifier: WideString; var Bundle: WideString; 
                             var PorcentualInternalTaxes: WideString; 
                             var FixesInternalTaxes: WideString): WordBool; safecall;
    function  SendExtraDescription(var Text: WideString): WordBool; safecall;
    function  GetTicketSubtotal(var Impresion: WideString; var Text: WideString): WordBool; safecall;
    function  SendTicketPayment(var Text: WideString; var Amount: WideString; 
                                var PaymentType: WideString): WordBool; safecall;
    function  CloseTicket: WordBool; safecall;
    function  OpenInvoice(var InvoiceType: WideString; var PaperType: WideString; 
                          var InvoiceLetter: WideString; var Copies: WideString; 
                          var FormType: WideString; var FontType: WideString; 
                          var IVA_Seller: WideString; var IVA_Buyer: WideString; 
                          var BuyerName1: WideString; var BuyerName2: WideString; 
                          var BuyerDocumentType: WideString; var BuyerDocumentNumber: WideString; 
                          var FixedAssest: WideString; var BuyerAddress1: WideString; 
                          var BuyerAddress2: WideString; var BuyerAddress3: WideString; 
                          var Remit1: WideString; var Remit2: WideString; 
                          var StorageDataType: WideString): WordBool; safecall;
    function  SendInvoiceItem(var Description: WideString; var Quantity: WideString; 
                              var UnitPrice: WideString; var IVA_Tax: WideString; 
                              var Qualifier: WideString; var Bundle: WideString; 
                              var PorcentualInternalTaxes: WideString; var ExtraLine1: WideString; 
                              var ExtraLine2: WideString; var ExtraLine3: WideString; 
                              var IncreaseTax: WideString; var FixesInternalTaxes: WideString): WordBool; safecall;
    function  GetInvoiceSubtotal(var Impresion: WideString; var Text: WideString): WordBool; safecall;
    function  SendInvoicePerception(var Description: WideString; var Qualifier: WideString; 
                                    var Amount: WideString): WordBool; safecall;
    function  SendInvoicePayment(var Text: WideString; var Amount: WideString; 
                                 var PaymentType: WideString): WordBool; safecall;
    function  CloseInvoice(var InvoiceType: WideString; var InvoiceLetter: WideString; 
                           var Text: WideString): WordBool; safecall;
    function  DNFHCreditCard(var CardName: WideString; var CardNumber: WideString; 
                             var UserName: WideString; var ExpireDate: WideString; 
                             var CompanyNumber: WideString; var VoucherNumber: WideString; 
                             var InternalNumber: WideString; var AutorizationCode: WideString; 
                             var OperationType: WideString; var Amount: WideString; 
                             var QuotaAmount: WideString; var CurrencyType: WideString; 
                             var TerminalNumber: WideString; var LotNumber: WideString; 
                             var ETerminalNumber: WideString; var BranchNumber: WideString; 
                             var OperatorNumber: WideString; var FiscalDocumentNumber: WideString; 
                             var SignPrint: WideString; var ExplanationPrint: WideString; 
                             var PhonePrint: WideString): WordBool; safecall;
    function  DNFHDrugstore(var HealthCompanyName: WideString; var CosecureLine1: WideString; 
                            var CosecureLine2: WideString; var CosecureLine3: WideString; 
                            var MemberNumber: WideString; var MemberName: WideString; 
                            var ExpireDate: WideString; var AddressLine1: WideString; 
                            var AddressLine2: WideString; var CompanyNameOrNumber: WideString; 
                            var InternalNumber: WideString; var DescriptionLine1: WideString; 
                            var DescriptionLine2: WideString; var AddressPrint: WideString; 
                            var DocumentNumberPrint: WideString; var SignPrint: WideString; 
                            var ExplanationPrint: WideString; var PhonePrint: WideString): WordBool; safecall;
    function  Get_PortNumber: OleVariant; safecall;
    procedure Set_PortNumber(Param1: OleVariant); safecall;
    function  Get_BaudRate: OleVariant; safecall;
    procedure Set_BaudRate(Param1: OleVariant); safecall;
    function  Get_FiscalStatus: OleVariant; safecall;
    function  Get_PrinterStatus: OleVariant; safecall;
    procedure Set_FiscalStatus(Param1: OleVariant); safecall;
    procedure Set_PrinterStatus(Param1: OleVariant); safecall;
    function  Get_AnswerField_3: OleVariant; safecall;
    procedure Set_AnswerField_3(Param1: OleVariant); safecall;
    function  Get_AnswerField_4: OleVariant; safecall;
    procedure Set_AnswerField_4(Param1: OleVariant); safecall;
    function  Get_AnswerField_5: OleVariant; safecall;
    procedure Set_AnswerField_5(Param1: OleVariant); safecall;
    function  Get_AnswerField_6: OleVariant; safecall;
    procedure Set_AnswerField_6(Param1: OleVariant); safecall;
    function  Get_AnswerField_7: OleVariant; safecall;
    procedure Set_AnswerField_7(Param1: OleVariant); safecall;
    function  Get_AnswerField_8: OleVariant; safecall;
    procedure Set_AnswerField_8(Param1: OleVariant); safecall;
    function  Get_AnswerField_9: OleVariant; safecall;
    procedure Set_AnswerField_9(Param1: OleVariant); safecall;
    function  Get_AnswerField_10: OleVariant; safecall;
    procedure Set_AnswerField_10(Param1: OleVariant); safecall;
    function  Get_AnswerField_11: OleVariant; safecall;
    procedure Set_AnswerField_11(Param1: OleVariant); safecall;
    function  Get_AnswerField_12: OleVariant; safecall;
    procedure Set_AnswerField_12(Param1: OleVariant); safecall;
    function  Get_AnswerField_13: OleVariant; safecall;
    procedure Set_AnswerField_13(Param1: OleVariant); safecall;
    function  Get_AnswerField_14: OleVariant; safecall;
    procedure Set_AnswerField_14(Param1: OleVariant); safecall;
    function  Get_AnswerField_15: OleVariant; safecall;
    procedure Set_AnswerField_15(Param1: OleVariant); safecall;
    function  Get_AnswerField_16: OleVariant; safecall;
    procedure Set_AnswerField_16(Param1: OleVariant); safecall;
    function  Get_AnswerField_17: OleVariant; safecall;
    procedure Set_AnswerField_17(Param1: OleVariant); safecall;
    function  Get_AnswerField_18: OleVariant; safecall;
    procedure Set_AnswerField_18(Param1: OleVariant); safecall;
    function  Get_AnswerField_19: OleVariant; safecall;
    procedure Set_AnswerField_19(Param1: OleVariant); safecall;
    function  Get_MessagesOn: WordBool; safecall;
    procedure Set_MessagesOn(Param1: WordBool); safecall;
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

// *********************************************************************//
// DispIntf:  _PrinterFiscalDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C418C3F-54A3-11D3-BC02-00C0F010C82A}
// *********************************************************************//
  _PrinterFiscalDisp = dispinterface
    ['{2C418C3F-54A3-11D3-BC02-00C0F010C82A}']
    function  CloseJournal(var CloseType: WideString; var Impresion: WideString): WordBool; dispid 1610809366;
    function  FeedPaper(var Station: WideString; var Lines: WideString): WordBool; dispid 1610809367;
    function  CutPaper: WordBool; dispid 1610809368;
    function  SetGetHeaderTrailer(var Action: WideString; var Number: WideString; 
                                  var Text: WideString): WordBool; dispid 1610809369;
    function  SetGetDateTime(var Action: WideString; var DateYYMMDD: WideString; 
                             var TimeHHMMSS: WideString): WordBool; dispid 1610809370;
    function  Status(var StatusType: WideString): WordBool; dispid 1610809371;
    function  OpenCashDrawer(var Number: WideString): WordBool; dispid 1610809372;
    function  Audit(var AuditType: WideString; var AuditMode: WideString; var Start: WideString; 
                    var Finish: WideString): WordBool; dispid 1610809373;
    function  OpenNoFiscal: WordBool; dispid 1610809374;
    function  SendNoFiscalText(var Text: WideString): WordBool; dispid 1610809375;
    function  CloseNoFiscal: WordBool; dispid 1610809376;
    function  OpenTicket(var StorageDataType: WideString): WordBool; dispid 1610809377;
    function  SendTicketItem(var Description: WideString; var Quantity: WideString; 
                             var UnitPrice: WideString; var IVA_Tax: WideString; 
                             var Qualifier: WideString; var Bundle: WideString; 
                             var PorcentualInternalTaxes: WideString; 
                             var FixesInternalTaxes: WideString): WordBool; dispid 1610809378;
    function  SendExtraDescription(var Text: WideString): WordBool; dispid 1610809379;
    function  GetTicketSubtotal(var Impresion: WideString; var Text: WideString): WordBool; dispid 1610809380;
    function  SendTicketPayment(var Text: WideString; var Amount: WideString; 
                                var PaymentType: WideString): WordBool; dispid 1610809381;
    function  CloseTicket: WordBool; dispid 1610809382;
    function  OpenInvoice(var InvoiceType: WideString; var PaperType: WideString; 
                          var InvoiceLetter: WideString; var Copies: WideString; 
                          var FormType: WideString; var FontType: WideString; 
                          var IVA_Seller: WideString; var IVA_Buyer: WideString; 
                          var BuyerName1: WideString; var BuyerName2: WideString; 
                          var BuyerDocumentType: WideString; var BuyerDocumentNumber: WideString; 
                          var FixedAssest: WideString; var BuyerAddress1: WideString; 
                          var BuyerAddress2: WideString; var BuyerAddress3: WideString; 
                          var Remit1: WideString; var Remit2: WideString; 
                          var StorageDataType: WideString): WordBool; dispid 1610809383;
    function  SendInvoiceItem(var Description: WideString; var Quantity: WideString; 
                              var UnitPrice: WideString; var IVA_Tax: WideString; 
                              var Qualifier: WideString; var Bundle: WideString; 
                              var PorcentualInternalTaxes: WideString; var ExtraLine1: WideString; 
                              var ExtraLine2: WideString; var ExtraLine3: WideString; 
                              var IncreaseTax: WideString; var FixesInternalTaxes: WideString): WordBool; dispid 1610809384;
    function  GetInvoiceSubtotal(var Impresion: WideString; var Text: WideString): WordBool; dispid 1610809385;
    function  SendInvoicePerception(var Description: WideString; var Qualifier: WideString; 
                                    var Amount: WideString): WordBool; dispid 1610809386;
    function  SendInvoicePayment(var Text: WideString; var Amount: WideString; 
                                 var PaymentType: WideString): WordBool; dispid 1610809387;
    function  CloseInvoice(var InvoiceType: WideString; var InvoiceLetter: WideString; 
                           var Text: WideString): WordBool; dispid 1610809388;
    function  DNFHCreditCard(var CardName: WideString; var CardNumber: WideString; 
                             var UserName: WideString; var ExpireDate: WideString; 
                             var CompanyNumber: WideString; var VoucherNumber: WideString; 
                             var InternalNumber: WideString; var AutorizationCode: WideString; 
                             var OperationType: WideString; var Amount: WideString; 
                             var QuotaAmount: WideString; var CurrencyType: WideString; 
                             var TerminalNumber: WideString; var LotNumber: WideString; 
                             var ETerminalNumber: WideString; var BranchNumber: WideString; 
                             var OperatorNumber: WideString; var FiscalDocumentNumber: WideString; 
                             var SignPrint: WideString; var ExplanationPrint: WideString; 
                             var PhonePrint: WideString): WordBool; dispid 1610809389;
    function  DNFHDrugstore(var HealthCompanyName: WideString; var CosecureLine1: WideString; 
                            var CosecureLine2: WideString; var CosecureLine3: WideString; 
                            var MemberNumber: WideString; var MemberName: WideString; 
                            var ExpireDate: WideString; var AddressLine1: WideString; 
                            var AddressLine2: WideString; var CompanyNameOrNumber: WideString; 
                            var InternalNumber: WideString; var DescriptionLine1: WideString; 
                            var DescriptionLine2: WideString; var AddressPrint: WideString; 
                            var DocumentNumberPrint: WideString; var SignPrint: WideString; 
                            var ExplanationPrint: WideString; var PhonePrint: WideString): WordBool; dispid 1610809390;
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

// *********************************************************************//
// DispIntf:  __PrinterFiscal
// Flags:     (4240) Hidden NonExtensible Dispatchable
// GUID:      {2C418C41-54A3-11D3-BC02-00C0F010C82A}
// *********************************************************************//
  __PrinterFiscal = dispinterface
    ['{2C418C41-54A3-11D3-BC02-00C0F010C82A}']
  end;

implementation

uses ComObj;

end.
