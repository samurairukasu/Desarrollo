unit UFCambioFechaVencGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, ToolEdit, RXDBCtrl, Mask, DBCtrls, usagclasses, usagestacion,
  ucdialgs, USAGVARIOS, globals, uUtils, RxLookup,ugacceso, ExtCtrls, Acceso;

type
  TfrmCambioFechaVencGNC = class(TForm)
    lblNroInspeccion: TLabel;
    dbefecvencold: TDBDateEdit;
    dbefecvencnew: TDBDateEdit;
    dscambios: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    dsmotivos: TDataSource;
    cbmotivo: TRxDBLookupCombo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNroNotaChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbefecvencnewExit(Sender: TObject);
  private
    { Private declarations }
    fCambiosFecha: tCambiosFecha_gnc;
    fMotivos: tMotivos_cambios_gnc;
    procedure InicializoTablas;
  public
    { Public declarations }
  end;
  procedure DoCambioFechaVencGNC;

var
  frmCambioFechaVencGNC: TfrmCambioFechaVencGNC;
  Ejercicio,CodigoInspeccion, usuarioant: integer;
  FechaVencimiento, claveant:string;
  GestorSegAnt: TGestorSeg;

implementation

uses
  uSeleccionaNroInfGNC,
  ufUsuarioCambios,
  uLogs, UFTMP;

resourcestring
  file_name = 'ufCambioFechaVencGNC';
{$R *.DFM}


procedure DoCambioFechaVencGNC;
begin
  with TfrmCambioFechaVencGNC.Create(Application) do
    try
      UsuarioAnt:=applicationuser;
      ClaveAnt:=PasswordUser;
      GestorSegAnt:=GestorSeg;
      //if not PermitidoAccesoCambios(applicationuser,PasswordUser,GestorSeg) then
      if not PermitidoAcceso(applicationuser,PasswordUser,GestorSeg,'Acceso a Cambios de Fecha',FALSE,'CAMBIO') then
        exit;
      if not seleccinformeGNC(StrToInt(fVarios.ValueByName[FIELD_ZONA]),StrToInt(fVarios.ValueByName[FIELD_ESTACION]),ejercicio,codigoInspeccion,fechaVencimiento) then exit;
      lblNroInspeccion.caption:=copy(inttostr(ejercicio),3,2)+'-'+formatoceros(strtoint(fVarios.ValueByName[FIELD_ZONA]),4)+formatoceros(strtoint(fVarios.ValueByName[FIELD_ESTACION]),4)+formatoceros(codigoInspeccion,7);
      InicializoTablas;
      if not mybd.InTransaction then mybd.StartTransaction(td);
      showmodal;
    finally
      if UsuarioAnt <> applicationuser then applicationUser := UsuarioAnt;
      if ClaveAnt <> PasswordUser then PasswordUser := ClaveAnt;
      if GestorSegAnt <> GestorSeg then GestorSeg := GestorSegAnt;
      free;
    end;
end;

procedure TfrmCambioFechaVencGNC.InicializoTablas;
begin
      fMotivos:=nil;
      fMotivos:=tmotivos_cambios_gnc.Create(mybd);
      fmotivos.open;
      dsmotivos.DataSet:=fmotivos.dataset;
      fCambiosFecha:=nil;
      fCambiosFecha:=tCambiosFecha_gnc.CreateByRowID(mybd,'');
      fCambiosFecha.open;
      fCambiosFecha.ValueByName[FIELD_EJERCICI]:=inttostr(ejercicio);
      fCambiosFecha.ValueByName[FIELD_CODINSPE]:=inttostr(codigoInspeccion);
      fCambiosFecha.ValueByName[FIELD_FECHA_V_OLD]:=fechaVencimiento;
      dsCambios.DataSet:=fCambiosFecha.DataSet;
end;

procedure TfrmCambioFechaVencGNC.btnAceptarClick(Sender: TObject);
var FBusqueda: TFTmp;
begin
  try
    fbusqueda:= TFTmp.create(application);
    fbusqueda.muestraclock('Cambio de Fecha','Guardando los datos del cambio de fecha...');
    try
      with tinspgnc.CreateFromDataBase(mybd,DATOS_INSPGNC,format('WHERE CODINSPGNC = %s AND EJERCICI = %s',[fCambiosFecha.valuebyname[FIELD_CODINSPE],fCambiosFecha.valuebyname[FIELD_EJERCICI]])) do
       try
         open;
         valuebyName[FIELD_FECHVENCI]:=fCambiosFecha.valuebyname[FIELD_FECHA_V_NEW];
         post(true);
       finally
         close;
         free;
       end;
      fcambiosfecha.ValueByName[FIELD_IDUSUARIO]:=inttostr(applicationuser);
      fcambiosfecha.Post(true);
      if mybd.InTransaction then mybd.Commit(td);
      close;
    except
      on E: Exception do
      begin
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al intentar guardar el cambio de fecha por :%s',[E.Message]);
          MessageDlg(Caption,Format('Error al intentar guardar el cambio de fecha: %s. Si el error persiste indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
      end
    end;
  finally
    fbusqueda.close;
    fbusqueda.free;
  end;
end;

procedure TfrmCambioFechaVencGNC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmotivos.free;
  fCambiosFecha.free;
end;

procedure TfrmCambioFechaVencGNC.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmCambioFechaVencGNC.dbeNroNotaChange(Sender: TObject);
begin
   activarcomponentes((cbmotivo.text <> '') and (dbefecvencnew.text <> '  /  /    '),self,[3]);
   activarComponentes(cbmotivo.text <> '',self,[1,2]);
end;

procedure TfrmCambioFechaVencGNC.btnCancelarClick(Sender: TObject);
begin
  if mybd.intransaction then mybd.Rollback(td);
end;


procedure TfrmCambioFechaVencGNC.dbefecvencnewExit(Sender: TObject);
begin
  if not btnCancelar.focused then
    try
      strtodate(dbefecvencnew.text)
    except
      MessageDlg (Caption, 'Ingrese una fecha correcta', mtInformation, [mbOk],mbOk,0);
      dbefecvencnew.SetFocus;
    end;
end;

end.
