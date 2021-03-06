unit UFCambioFechaVencimiento;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Db, ToolEdit, RXDBCtrl, Mask, DBCtrls, usagclasses, usagestacion,
  ucdialgs, USAGVARIOS, globals, uUtils, RxLookup,ugacceso, ExtCtrls, Acceso, SQLExpr;

type
  TfrmCambioFechaVencimiento = class(TForm)
    dbeNroNota: TDBEdit;
    lblNroInspeccion: TLabel;
    dbefecvencold: TDBDateEdit;
    dbefecvencnew: TDBDateEdit;
    dscambios: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    dsmotivos: TDataSource;
    cbmotivo: TRxDBLookupCombo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label6: TLabel;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNroNotaChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbeNroNotaKeyPress(Sender: TObject; var Key: Char);
    procedure dbefecvencnewExit(Sender: TObject);
    procedure dbeNroNotaExit(Sender: TObject);
  private
    { Private declarations }
    fCambiosFecha: tCambiosFecha;
    fMotivos: tMotivos_cambios;
    procedure InicializoTablas;
    procedure ActualizoFrecuencia(aCodMotivo: string);
  public
    { Public declarations }
  end;
  procedure DoCambioFechaVencimiento;
var
  frmCambioFechaVencimiento: TfrmCambioFechaVencimiento;
  Ejercicio,CodigoInspeccion, usuarioant: integer;
  FechaVencimiento, claveant:string;
  GestorSegAnt: TGestorSeg;

implementation

uses
  uSeleccionaNroInforme,
  ufUsuarioCambios,
  uLogs, UFTMP, USAGDATA;

resourcestring
  file_name = 'ufCambioFechaVencimiento';
{$R *.DFM}


procedure DoCambioFechaVencimiento;
begin
  with TfrmCambioFechaVencimiento.Create(Application) do
    try
      UsuarioAnt:=applicationuser;
      ClaveAnt:=PasswordUser;
      GestorSegAnt:=GestorSeg;
      //if not PermitidoAccesoCambios(applicationuser,PasswordUser,GestorSeg) then exit;
      if not PermitidoAcceso(applicationuser,PasswordUser,GestorSeg,'Acceso a Cambios de Fecha',FALSE,'CAMBIO') then
        exit;

      if not seleccinforme(StrToInt(fVarios.ValueByName[FIELD_ZONA]),StrToInt(fVarios.ValueByName[FIELD_ESTACION]),ejercicio,codigoInspeccion,fechaVencimiento) then exit;
      lblNroInspeccion.caption:=copy(inttostr(ejercicio),3,2)+'-'+formatoceros(strtoint(fVarios.ValueByName[FIELD_ZONA]),4)+formatoceros(strtoint(fVarios.ValueByName[FIELD_ESTACION]),4)+formatoceros(codigoInspeccion,6);
      InicializoTablas;
      if not mybd.InTransaction then
        mybd.StartTransaction(TD);
      showmodal;
    finally
      if UsuarioAnt <> applicationuser then applicationUser := UsuarioAnt;
      if ClaveAnt <> PasswordUser then PasswordUser := ClaveAnt;
      if GestorSegAnt <> GestorSeg then GestorSeg := GestorSegAnt;
      free;
    end;
end;

procedure TfrmCambioFechaVencimiento.InicializoTablas;
begin
      fMotivos:=nil;
      fMotivos:=tmotivos_cambios.Create(mybd);
      fmotivos.open;
      dsmotivos.DataSet:=fmotivos.dataset;
      fCambiosFecha:=nil;
      fCambiosFecha:=tCambiosFecha.CreateByRowID(mybd,'');
      fCambiosFecha.open;
      fCambiosFecha.ValueByName[FIELD_EJERCICI]:=inttostr(ejercicio);
      fCambiosFecha.ValueByName[FIELD_CODINSPE]:=inttostr(codigoInspeccion);
      fCambiosFecha.ValueByName[FIELD_FECHA_V_OLD]:=fechaVencimiento;
      dsCambios.DataSet:=fCambiosFecha.DataSet;
end;

procedure TfrmCambioFechaVencimiento.btnAceptarClick(Sender: TObject);
var FBusqueda: TFTmp;
begin
  try
    fbusqueda:= TFTmp.create(application);
    fbusqueda.muestraclock('Cambio de Fecha','Guardando los datos del cambio de fecha...');
    try
      with tinspeccion.CreateFromDataBase(mybd,DATOS_INSPECCIONES,format('WHERE CODINSPE = %s AND EJERCICI = %s',[fCambiosFecha.valuebyname[FIELD_CODINSPE],fCambiosFecha.valuebyname[FIELD_EJERCICI]])) do
       try
         open;
         valuebyName[FIELD_FECVENCI]:=fCambiosFecha.valuebyname[FIELD_FECHA_V_NEW];
         post(true);
       finally
         close;
         free;
       end;
      fcambiosfecha.ValueByName[FIELD_IDUSUARIO]:=inttostr(applicationuser);
      fcambiosfecha.Post(true);
      ActualizoFrecuencia(fCambiosFecha.valuebyname[FIELD_CODMOTIVO]);
      if mybd.InTransaction then mybd.Commit(td);
      close;
    except
      on E: Exception do
      begin
          fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FILE_NAME,'Error al intentar guardar el cambio de fecha por :%s',[E.Message]);
          MessageDlg(Caption,Format('Error al intentar guardar el cambio de fecha: %s. Si el error persiste ind�quelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
      end
    end;
  finally
    fbusqueda.close;
    fbusqueda.free;
  end;
end;

procedure TfrmCambioFechaVencimiento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fmotivos.free;
  fCambiosFecha.free;
end;

procedure TfrmCambioFechaVencimiento.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmCambioFechaVencimiento.dbeNroNotaChange(Sender: TObject);
begin
   activarcomponentes((dbenronota.text <> '') and (cbmotivo.text <> '') and (dbefecvencnew.text <> '  /  /    '),self,[3]);
   activarComponentes(dbenronota.text <> '',self,[1,2]);
end;

procedure TfrmCambioFechaVencimiento.btnCancelarClick(Sender: TObject);
begin
  if mybd.intransaction then mybd.Rollback(td);
end;


procedure TfrmCambioFechaVencimiento.dbeNroNotaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (key in ['0'..'9','-',char(VK_BACK)]) then
    key := #0
end;

procedure TfrmCambioFechaVencimiento.dbefecvencnewExit(Sender: TObject);
begin
  if not btnCancelar.focused then
    try
      strtodate(dbefecvencnew.text)
    except
      MessageDlg (Caption, 'Ingrese una fecha correcta', mtInformation, [mbOk],mbOk,0);
      dbefecvencnew.SetFocus;
    end;
end;

procedure TfrmCambioFechaVencimiento.dbeNroNotaExit(Sender: TObject);
begin
  if not btncancelar.focused then
  if (length(dbeNroNota.text)<11) or (pos('-',dbeNroNota.text)<>5) then
  begin
          MessageDlg (Caption, 'Ingrese el nro de nota con formato ZPAA-NNNNNN', mtError, [mbOk],mbOk,0);
          dbeNroNota.setfocus;
  end;
end;

procedure TfrmCambioFechaVencimiento.ActualizoFrecuencia(aCodMotivo: string);
begin
  if aCodMotivo = '2' then
  begin
    with tsqlquery.create(self) do
      try
        SQLConnection := Mybd;
        sql.Add('UPDATE TINSPECCION SET CODFRECU=3 ');
        sql.Add(format('WHERE CODINSPE = %S AND EJERCICI = %S',[fcambiosfecha.ValueByName[FIELD_CODINSPE], fcambiosfecha.valuebyname[FIELD_EJERCICI]]));
        execsql;
      finally
        free;
      end;
  end;
end;

end.
