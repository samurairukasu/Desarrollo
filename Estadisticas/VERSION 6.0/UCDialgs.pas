unit UCDialgs;
{$R-}

interface

uses Windows, Messages, SysUtils, CommDlg, Classes, Graphics, Controls,
  Forms, Buttons;

{ Message dialog }

type
  TMsgDlgType = (mtWarning, mtError, mtInformation, mtConfirmation, mtCustom);

  TMsgDlgBtn = (mbYes, mbNo, mbOK, mbIgnore, mbAbort, mbRetry, mbCancel, mbAll, mbHelp);

  TMsgDlgButtons = set of TMsgDlgBtn;

const
  mbYesNoCancel = [mbYes, mbNo, mbCancel];

  mbOKCancel = [mbOK, mbCancel];

  mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];

  {$IFDEF CENTRAL}
  mrNone   = Controls.mrNone;
  mrOk     = Controls.mrOk;
  mrCancel = Controls.mrCancel;
  mrAbort  = Controls.mrAbort;
  mrRetry  = Controls.mrRetry;
  mrIgnore = Controls.mrIgnore;
  mrYes    = Controls.mrYes;
  mrNo     = Controls.mrNo;
  mrAll    = Controls.mrNo + 1;
  {$ENDIF}


function CreateMessageDialog(const Cptn, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; const BotonDefecto : TMsgDlgBtn): TForm;

function MessageDlg(const Cptn, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; const BotonDefecto : TMsgDlgBtn; HelpCtx: Longint): Integer;

function MessageDlgPos(const Cptn, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; const BotonDefecto : TMsgDlgBtn;
  HelpCtx: Longint; X, Y: Integer): Integer;

procedure ShowMessage(const Cptn, Msg: string);

procedure ShowMessagePos(const Cptn, Msg: string; X, Y: Integer);

function InputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;

var
    DialogsFont : TFont;

implementation

uses StdCtrls, ExtCtrls, {Consts,} Printers;

{const}
 { SMsgDlgWarning = 61560;
  SMsgDlgError = 61561;
  SMsgDlgInformation = 61562;
  SMsgDlgConfirm = 61563;
  SMsgDlgYes = 61564;
  SMsgDlgNo = 61565;
  SMsgDlgOK = 61566;
  SMsgDlgCancel = 61567;
  SMsgDlgHelp = 61568;
  SMsgDlgHelpNone = 61569;
  SMsgDlgHelpHelp = 61570;
  SMsgDlgAbort = 61571;
  SMsgDlgRetry = 61572;
  SMsgDlgIgnore = 61573;
  SMsgDlgAll = 61574;}

{ TODAVIA NO SE LO QUE HACE }


{ Message dialog }

function Max(I, J: Integer): Integer;
begin
  if I > J then Result := I else Result := J;
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));

  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  { Es una funcion del api que calcula la extension del texto }

  Result.X := Result.X div 52;
end;


type
  TMessageForm = class(TForm)
  private
    procedure HelpButtonClick(Sender: TObject);
  end;

procedure TMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
  { llama a la ayuda de windows con e indice HelpContext }
end;


function CreateMessageDialog(const Cptn, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; const BotonDefecto : TMsgDlgBtn): TForm;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50; {50}
  mcButtonHeight = 16; {14}
  mcButtonSpacing = 4;
const
  {Estos valores son direcciones del fichero const.res
  Captions: array[TMsgDlgType] of Word = (SMsgDlgWarning, SMsgDlgError,
    SMsgDlgInformation, SMsgDlgConfirm, 0);

  { Constantes en la Unidad Windows }
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);

  {ButtonNames: array[TMsgDlgBtn] of string = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'Help');}

  ButtonNames: array[TMsgDlgBtn] of string = (
    'Si', 'No', 'OK', 'Ignorar' , 'Terminar', 'Reintentar', 'Cancelar', 'Todo',
    'Ayuda');

  { Esto lo he de cambiar por stirngs }
{  ButtonCaptions: array[TMsgDlgBtn] of Word = (
    SMsgDlgYes, SMsgDlgNo, SMsgDlgOK, SMsgDlgCancel, SMsgDlgAbort,
    SMsgDlgRetry, SMsgDlgIgnore, SMsgDlgAll, SMsgDlgHelp); }

  ButtonCaptions: array[TMsgDlgBtn] of string = (
    'Si', 'No', 'OK', 'Continuar' , 'Terminar', 'Reintentar', 'Cancelar'
    ,'Todo', 'Ayuda');
{  TMsgDlgBtn = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbHelp);}

  ButtonKinds : array[TMsgDlgBtn] of TBitBtnKind = ( bkYes, bkNo, bkOk, bkIgnore , bkAbort, bkRetry, bkCancel, bkAll, bkHelp);

  ModalResults: array[TMsgDlgBtn] of Integer = (
    mrYes, mrNo, mrOk, mrIgnore , mrAbort, mrRetry, mrCancel, mrAll, 0);
var

  DialogUnits: TPoint;

  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X: Integer;

  B, DefaultButton, CancelButton: TMsgDlgBtn;

  IconID: PChar;
  TextRect: TRect;

begin
  Result := TMessageForm.CreateNew(Application);
  { Crea un nuevo form en blanco sin tener que leer de un dfm }

  with Result do
  begin
    { Estilo del form }
    Font := DialogsFont;
    BorderStyle := bsDialog;
    Canvas.Font := Font;
    DialogUnits := GetAveCharSize(Canvas);
    { Multiplicacion de numeros de 32 bits, llamada a las API }
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);

    SetRect(TextRect, 0, 0, Screen.Width div 2, 0);  { Coordenadas de la ventana }

    DrawText(Canvas.Handle, PChar(Msg), -1, TextRect,
      DT_CALCRECT or DT_WORDBREAK);

    IconID := IconIDs[DlgType]; { Assign el icono }
    IconTextWidth := TextRect.Right;
    IconTextHeight := TextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;
    ButtonCount := 0;

    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then Inc(ButtonCount); { Cardinal del numero de botones }

    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
      VertMargin * 2;
    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);
    { Al caption del form se la voy a dar como parametro y punto }

    Caption := Cptn;

{    if DlgType <> mtCustom then
      Caption := LoadStr(Captions[DlgType]) else
      Caption := Application.Title;  }

    if IconID <> nil then
      with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        SetBounds(HorzMargin, VertMargin, 32, 32);
      end;
    { Creacion de la etiqueta que contiene el mensaje, es propiedad de Result }

    with TLabel.Create(Result) do
    begin
      Name := 'Message';
      Parent := Result;
      WordWrap := True;
      Caption := Msg;
      BoundsRect := TextRect;
      SetBounds(IconTextWidth - TextRect.Right + HorzMargin, VertMargin,
        TextRect.Right, TextRect.Bottom);
    end;

    { Asignacion de botones con caracteristicas similares y botones por
      defecto }

    if mbOk in Buttons then DefaultButton := mbOk else
      if mbYes in Buttons then DefaultButton := mbYes else
        if mbIgnore in Buttons then DefaultButton := mbIgnore else
          DefaultButton := mbRetry;
    if mbCancel in Buttons then CancelButton := mbCancel else
      if mbNo in Buttons then CancelButton := mbNo else
        CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;

    { Creacion de los botones de forma dinamica }
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
        with TBitBtn.Create(Result) do
        begin
          Name := ButtonNames[B];
          Parent := Result;
          Kind := ButtonKinds[B];
          Caption := {LoadStr}(ButtonCaptions[B]);
          ModalResult := ModalResults[B];
          if B = DefaultButton then Default := True;
          if B = CancelButton then Cancel := True;
          SetBounds(X, IconTextHeight + VertMargin + VertSpacing,
            ButtonWidth, ButtonHeight);
          Inc(X, ButtonWidth + ButtonSpacing);
          if B = mbHelp then
            OnClick := TMessageForm(Result).HelpButtonClick;
          if B = BotonDefecto then TabOrder := 0;
        end;
  end;
end;

function MessageDlg(const Cptn, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons;
  const BotonDefecto : TMsgDlgBtn; HelpCtx: Longint): Integer;
begin
  Result := MessageDlgPos(Cptn, Msg, DlgType, Buttons, BotonDefecto,  HelpCtx, -1, -1);
end;

function MessageDlgPos(const Cptn, Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons;
  const BotonDefecto :TMsgDlgBtn; HelpCtx: Longint; X, Y: Integer): Integer;
begin
  with CreateMessageDialog(Cptn, Msg, DlgType, Buttons, BotonDefecto) do
    try
      HelpContext := HelpCtx;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      Result := ShowModal;
    finally
      Free;
    end;
end;

procedure ShowMessage(const Cptn, Msg: string);
begin
  ShowMessagePos(Cptn, Msg, -1, -1);
end;

procedure ShowMessagePos(const Cptn, Msg: string; X, Y: Integer);
begin
  MessageDlgPos(Cptn, Msg, mtCustom, [mbOK], mbOk, 0,  X, Y);
end;

function InputQuery(const ACaption, APrompt: string;
  var Value: string): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(63, DialogUnits.Y, 8);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        AutoSize := True;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Caption := APrompt;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := MulDiv(19, DialogUnits.Y, 8);
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := MulDiv(41, DialogUnits.Y, 8);
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'Aceptar';
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := 'Cancelar';
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

initialization
    DialogsFont := TFont.Create;

finalization

    if Assigned(DialogsFont)
    then DialogsFont.Free;

end.
