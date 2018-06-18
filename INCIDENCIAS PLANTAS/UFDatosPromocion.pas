unit ufdatosPromocion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCdialgs,
  StdCtrls, Mask, DBCtrls, Db, Buttons, uSagClasses, Globals, uSagEstacion,
  ExtCtrls, sqlexpr, provider, dbclient;

type
  TfrmDatosPromocion = class(TForm)
    ceNroCupon: TDBEdit;
    BContinuar: TBitBtn;
    BCancelar: TBitBtn;
    Label1: TLabel;
    dsDatosCupon: TDataSource;
    Bevel1: TBevel;
    Image1: TImage;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BContinuarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
  private
    { Private declarations }
    fPromocion: TDatospromocion;
    aTipoDescuento: string;
    aDescuento: string;
    aFactura: string;
    function ValidatePost:boolean;
    function ExistePoliza:boolean;
  public
    { Public declarations }
  end;

  procedure doDatosPromocion(const aCODFACTU, aCODCLIEN, aCODDESCU, aTipoDesc: string);

var
  frmDatosPromocion: TfrmDatosPromocion;

const
  DESCUENTO_PROVINCIA = '7';

implementation

{$R *.DFM}

procedure DoDatosPromocion(const aCODFACTU, aCODCLIEN, aCODDESCU, aTipoDesc: string);
begin
    with TfrmDatosPromocion.Create(Application) do
    begin
      try
        fPromocion.Open;
        fPromocion.Append;
        fPromocion.ValueByName[FIELD_CODFACTU]:=acodfactu;
        fPromocion.ValueByName[FIELD_CODCLIEN]:=aCODCLIEN;
        fPromocion.ValueByName[FIELD_CODDESCU]:=aCODDESCU;
        aTipoDescuento := atipodesc;
        aDescuento := aCodDescu;
        aFactura := aCODFACTU;
        showmodal;
      finally
        free
      end;
    end;
end;

procedure TfrmDatosPromocion.FormKeyPress(Sender: TObject; var Key: Char);
begin
     if key = #13
     then begin
         Perform(WM_NEXTDLGCTL,0,0);
         Key := #0
     end;
end;

procedure TfrmDatosPromocion.FormCreate(Sender: TObject);
begin
        fPromocion := nil;
        fPromocion:= TDatosPromocion.create(MyBD);
        dsDatosCupon.dataset:=fPromocion.DataSet;
end;

procedure TfrmDatosPromocion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fPromocion.Free;
  action:=cafree;
end;

procedure TfrmDatosPromocion.BContinuarClick(Sender: TObject);
begin
  if ValidatePost then
  begin
    fPromocion.Post(true);
    modalresult:=mrok;
  end;
end;

procedure TfrmDatosPromocion.BCancelarClick(Sender: TObject);
begin
  fPromocion.Cancel;
  modalresult:=mrCancel;
end;

function TfrmDatosPromocion.validatepost:boolean;
begin
  Result := False;
  if ceNroCupon.Text = '' then
  begin
     MessageDlg (Application.Title, 'Debe Ingresar los Datos del Cupón', mtError, [mbOk],mbOk,0);
     ceNroCupon.SetFocus;
     exit;
  end;
  if (aTipoDescuento = TIPO_VTV) and (aDescuento = DESCUENTO_PROVINCIA) then
  begin
    if not ExistePoliza then
    begin
      MessageDlg (Application.Title, 'No se ha encontrado un registro para esta póliza/certificado', mtError, [mbOk],mbOk,0);
      ceNroCupon.SetFocus;
      exit;
    end;
  end;
  Result := True;
end;

function TfrmDatosPromocion.ExistePoliza:boolean;
var
  nropoliza, nrocertificado: string;
  BarraSeparadora: integer;
  aq: TSQLDataSet;
  dsp : tDatasetprovider;
begin
  result := false;
  BarraSeparadora := pos('/',ceNroCupon.text);
  if not (BarraSeparadora > 0) then exit;
  nropoliza := copy(ceNroCupon.text,1,BarraSeparadora-1);
  nrocertificado := copy(ceNroCupon.text,BarraSeparadora+1,length(ceNroCupon.text)-BarraSeparadora+1);
  if (nropoliza = '') or (nrocertificado = '') then exit;

  aQ := TSQLDataSet.Create(self);
  aQ.SQLConnection := mybd;
  aQ.CommandType := ctQuery;
  aQ.GetMetadata := false;
  aQ.NoMetadata := true;
  aQ.ParamCheck := false;

  dsp := TDataSetProvider.Create(self);
  dsp.DataSet := aQ;
  dsp.Options := [poIncFieldProps,poAllowCommandText];

  with tClientDataSet.Create(self) do
    try
      SetProvider(dsp);
      commandtext := format('SELECT * FROM DATOS_PROVINCIA WHERE NROPOLIZA = %S AND CERTIFICADO = %S ',[nropoliza, nrocertificado]);
      open;
      if recordcount > 0 then
      begin
       try
        with TProvSeguros.createbyrowid(mybd,'') do
          try
            try
              open;
              Append;
              valuebyName[FIELD_CODFACTU] := aFactura;
              valueByName[FIELD_PATENTE] := fieldByName(FIELD_PATENTE).asstring;
              valueByName[FIELD_MOTOR] := fieldByName(FIELD_MOTOR).asstring;
              valueByName[FIELD_CHASIS] := fieldByName(FIELD_CHASIS).asstring;
              valueByName[FIELD_ANO] := fieldByName(FIELD_ANO).asstring;
              valueByName[FIELD_MARCA] := fieldByName(FIELD_MARCA).asstring;
              valueByName[FIELD_MODELO] := fieldByName(FIELD_MODELO).asstring;
              valueByName[FIELD_POLIZA] := fieldByName(FIELD_NROPOLIZA).asstring;
              valueByName[FIELD_CERTIFICADO] := fieldByName(FIELD_CERTIFICADO).asstring;
              valueByName[FIELD_ASEGURADO] := fieldByName(FIELD_ASEGURADO).asstring;
              valueByName[FIELD_TIPODOC] := fieldByName(FIELD_TIPODOC).asstring;
              valueByName[FIELD_NRODOC] := fieldByName(FIELD_NRODOC).asstring;
              valueByName[FIELD_TIPOVENTA] := fieldByName(FIELD_TIPOVENTA).asstring;
              valueByName[FIELD_FECHA_ARCHIVO] := fieldByName(FIELD_FECHA).asstring;
              post(true);
            except
              on E: Exception do
              begin
                application.MessageBox(pchar('Error al guardar los datos del descuento: '+e.message),pchar(caption),mb_ok+mb_iconerror+mb_applmodal);
                exit;
              end;
            end;
          finally
            free;
          end;
        except
          exit
        end;
      end
      else
        exit;
    finally
      free;
      dsp.Free;
      aq.free;
    end;
  result := true;
end;


end.
