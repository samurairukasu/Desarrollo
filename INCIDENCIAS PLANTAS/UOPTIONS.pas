unit UOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  StdCtrls, Buttons, ExtCtrls, ULogs;

type

  tFiltro = record
    bActivo : boolean;
    sFiltro : string;
  end;

  TFrmControlPrinters = class(TForm)
    BtnImpresion: TBitBtn;
    GrupoOpciones: TGroupBox;
    CheckFactB: TCheckBox;
    CheckInforme: TCheckBox;
    CheckFicha: TCheckBox;
    CheckFactA: TCheckBox;
    BtnAll: TSpeedButton;
    procedure CheckClick(Sender: Tobject);
    procedure BtnImpresionClick(Sender: TObject);
    procedure BtnAllClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  FICHERO_ACTUAL = 'UOptions.pas';

var
  FrmControlPrinters: TFrmControlPrinters;


implementation

{$R *.DFM}

uses
  UModDat, UTiposPr, UPrinter, DBClient;

  const
    PAPELES_DISTINTOS = 4;

  var

{  UN_CERTIFICADO = '1';
   UN_INFORME     = '2';
   UNA_FACTURA_A  = '3';
   UNA_FACTURA_B  = '4';
   UNA_NOTA_A     = '5';
   UNA_NOTA_B     = '6'
}

  aLiteralFiltro : array [1..PAPELES_DISTINTOS] of string =
    ( 'TIPOTRAB=''3'' OR TIPOTRAB=''5'' OR ' , { FACTURAS DE TIPO A Y NOTAS A }
      'TIPOTRAB=''4'' OR TIPOTRAB=''6'' OR ',  { FACTURAS DE TIPO B Y NOTAS B }
      'TIPOTRAB=''2'' OR ',                    { INFORMES }
      'TIPOTRAB=''1'' OR ');                   { CERTIFICADOS }





function AlgunoSeleccionado : boolean;
var
  i : integer;
begin
 with VarGlobs do
 begin
   result := False;
   for i:=low(aFiltroSeleccionado) to high(aFiltroSeleccionado) do
    if aFiltroSeleccionado[i] then begin
      result := True;
      break;
    end;
 end;
end;

function TodosSeleccionados : boolean;
var
  i : integer;
begin
  with VarGlobs do
  begin
    result := True;
    for i:=low(aFiltroSeleccionado) to high(aFiltroSeleccionado) do
      result := result and aFiltroSeleccionado[i]
  end;
end;


procedure TFrmControlPrinters.CheckClick(Sender: Tobject);
//var
//  i: integer;
//  bActivo : boolean;
begin

 if Sender is TCheckBox then
   VarGlobs.aFiltroSeleccionado[TCheckBox(Sender).Tag] := TCheckBox(Sender).Checked;

 BtnImpresion.Enabled := AlgunoSeleccionado;

end;



function ObtenerFiltro : string;
var
  i : integer;
  s : string;
begin
  with VarGlobs do
  begin
    s := '';
    for i := low(aFiltroSeleccionado) to high(aFiltroSeleccionado) do
    begin
      if aFiltroSeleccionado[i] then s := s + aLiteralFiltro[i];
    end;
    result := copy(s, 1, length(s)-4)
  end;
end;

procedure TFrmControlPrinters.BtnImpresionClick(Sender: TObject);
begin
  { El estado 5 es Terminado }
{$IFDEF TRAZAS}
  fTrazas.PonComponente(TRAZA_FORM,0,FICHERO_ACTUAL,self);
{$ENDIF}
  try
    with DatosImpresio.QrySolicitudesEnTTRABAIMPRE do
    begin
      Close;
      CommandText :=
                'SELECT CODTRABA, PATENTE, ESTADO, TIPOTRAB, TO_CHAR(FECHALTA, ''HH24:MI:SS'') ' +
                'FROM TTRABAIMPRE WHERE (' + ObtenerFiltro + ') AND ' +
                'ESTADO <> 5 ORDER BY PATENTE, FECHALTA';
      SetProvider(DatosImpresio.dspQrySolicitudesEnTTRABAIMPRE);


      {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,DatosImpresio.QrySolicitudesEnTTRABAIMPRE);
      {$ENDIF}

      Open;
      Application.ProcessMessages;

      FrmPrinters.HabilitarBotones;
      FrmPrinters.Show;
    end;
  except
    on E:Exception do
    begin
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'No se puede filtrar con la opcion deseada en TTRABAIMPRE por: ' + E.message);
      MessageDlg('CONTROL DE IMPRESION', 'Se ha producido un error grave con la BD, y no podrá ver los trabajos de impresión', mtWarning, [mbOk], mbOk, 0);
    end;
  end;
end;


procedure TFrmControlPrinters.BtnAllClick(Sender: TObject);
var
  bTodos : Boolean;
  i : integer;
begin
  bTodos := not TodosSeleccionados;

  for i:=0 to ComponentCount - 1 do
   if (Components[i] is TCheckBox)  then
     TCheckBox(Components[i]).Checked := bTodos;

end;

procedure TFrmControlPrinters.FormActivate(Sender: TObject);
var
  i : integer;
begin

  for i:=0 to ComponentCount - 1 do
   if (Components[i] is TCheckBox)  then
     TCheckBox(Components[i]).Checked := VarGlobs.aFiltroSeleccionado[TCheckBox(Components[i]).Tag];

  BtnImpresion.Enabled := AlgunoSeleccionado;
end;

procedure TFrmControlPrinters.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if not BtnImpresion.Enabled then
  begin
    Showmessage('Opciones de Visualización', 'Debe escojer al menos una opción');
    CanClose := False;
  end
  else begin
    try
      with DatosImpresio.QrySolicitudesEnTTRABAIMPRE do
      begin
        Close;
        CommandText:=
                  'SELECT CODTRABA, PATENTE, ESTADO, TIPOTRAB, TO_CHAR(FECHALTA, ''HH24:MI:SS'') ' +
                  'FROM TTRABAIMPRE WHERE (' + ObtenerFiltro + ') AND ' +
                  'ESTADO <> 5 ORDER BY FECHALTA';
        SetProvider(DatosImpresio.dspQrySolicitudesEnTTRABAIMPRE);

      {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL,1,FICHERO_ACTUAL,DatosImpresio.QrySolicitudesEnTTRABAIMPRE);
      {$ENDIF}

        Open;
        Application.ProcessMessages;
      end;
    except
      on E : Exception do
      begin
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'No se puede filtrar con la opcion deseada en TTRABAIMPRE por: ' + E.message);
        MessageDlg('CONTROL DE IMPRESION', 'Se ha producido un error grave con la BD, y no podrá ver los trabajos de impresión', mtWarning, [mbOk], mbOk, 0);
      end;
    end;
    CanClose := True;
  end
end;

procedure TFrmControlPrinters.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then PostMessage(HANDLE,WM_NEXTDLGCTL,0,0);
end;

end.
