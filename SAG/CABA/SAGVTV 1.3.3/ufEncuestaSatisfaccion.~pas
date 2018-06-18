unit ufEncuestaSatisfaccion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs, USagClasses, GLobals,
  ExtCtrls, ToolEdit, RXDBCtrl, StdCtrls, Mask, DBCtrls, SpeedBar, Db, UUtils,
  Buttons, uSagEstacion, DBCGrids, SQLExpr, Provider, DBClient;

type
  TfrmEncuestaSatisfaccion = class(TForm)
    dsEncuesta: TDataSource;
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    btnbuscar: TSpeedItem;
    btnsalir: TSpeedItem;
    btnnueva: TSpeedItem;
    dbep1ms: TDBEdit;
    dbep2ms: TDBEdit;
    dbep3ms: TDBEdit;
    dbep4ms: TDBEdit;
    dbep5ms: TDBEdit;
    dbep6ms: TDBEdit;
    dbep7ms: TDBEdit;
    dbep1sa: TDBEdit;
    dbep2sa: TDBEdit;
    dbep3sa: TDBEdit;
    dbep4sa: TDBEdit;
    dbep5sa: TDBEdit;
    dbep6sa: TDBEdit;
    dbep7sa: TDBEdit;
    dbep1ai: TDBEdit;
    dbep2ai: TDBEdit;
    dbep3ai: TDBEdit;
    dbep4ai: TDBEdit;
    dbep5ai: TDBEdit;
    dbep6ai: TDBEdit;
    dbep7ai: TDBEdit;
    dbep1in: TDBEdit;
    dbep2in: TDBEdit;
    dbep3in: TDBEdit;
    dbep4in: TDBEdit;
    dbep5in: TDBEdit;
    dbep6in: TDBEdit;
    dbep7in: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbefecha: TDBDateEdit;
    Label13: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    btnaceptar: TBitBtn;
    btncancelar: TBitBtn;
    Panel1: TPanel;
    Label14: TLabel;
    deFecha: TDateEdit;
    BitBtn3: TBitBtn;
    DBNavigator1: TDBNavigator;
    Panel19: TPanel;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    dbeTotencu: TDBEdit;
    Label15: TLabel;
    DBCtrlGrid1: TDBCtrlGrid;
    dsPreguntas: TDataSource;
    DBText1: TDBText;
    Panel2: TPanel;
    Label5: TLabel;
    lblatentel: TLabel;
    lblletind: TLabel;
    lblvertec: TLabel;
    lblatenper: TLabel;
    lblrapser: TLabel;
    lblsergen: TLabel;
    lblactant: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnsalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnnuevaClick(Sender: TObject);
    procedure btnbuscarClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnaceptarClick(Sender: TObject);
    procedure btncancelarClick(Sender: TObject);
    procedure dbefechaExit(Sender: TObject);
    procedure deFechaExit(Sender: TObject);
  private
    { Private declarations }
    fEncuesta: TEncuestaSatisfaccion;
    fSerie: TSeries_Encuestas;
    fPreguntas: TPreguntas_Encuestas;
    function validatepost:boolean;
    function sumabien(val1,val2,val3,val4,total: string):boolean;
    Function CampoNull: Boolean;
    Function VerificarDatos: Boolean;
    Procedure PonerValores;
  public
    { Public declarations }
  end;
  procedure DoEncuestaSatisfaccion;

var
  frmEncuestaSatisfaccion: TfrmEncuestaSatisfaccion;

implementation



{$R *.DFM}

const
  msg_suma = 'La suma de las encuestas de ';
  msg_mayor = ' es mayor a la cantidad de encuestas';


Procedure TfrmEncuestaSatisfaccion.PonerValores;
var
i: Integer;
Begin
for I:=0 To ComponentCount-1 do
 if (Components[I] is TDBEdit) and (TDBEDit(Components[I]).Text = '') then
 TDBEDit(Components[I]).Text:=IntToStr(0);
end;

Function TfrmEncuestaSatisfaccion.VerificarDatos: boolean;
var
i: Integer;
Begin
Result:=false;
  for I:=0 To ComponentCount-1 do
  if (Components[I] is TDBEdit) then
    Begin
    if ValidatePost and (TDBEDit(Components[I]).Text = '')  then
      begin
      Result:=true;
      Break;
      end
    else
    Result:=false;
    end;
end;



Function TfrmEncuestaSatisfaccion.CampoNull: Boolean;
var
i: Integer;
Begin
Result:=false;
  for I:=0 To ComponentCount-1 do
  if  (Components[I] is TDBEdit) then
    Begin
    if TDBEDit(Components[I]).Text = '' then
      begin
      Result:=false;
      Break;
      end
    else
    Result:=true;
    end;
end;


procedure DoEncuestaSatisfaccion;
begin
    With TfrmEncuestaSatisfaccion.Create(Application) do
    Try
        Showmodal;
    Finally
        Free;
    end;
end;

procedure TfrmEncuestaSatisfaccion.FormCreate(Sender: TObject);
begin
  fEncuesta := nil;
  fSerie := nil;
  fPreguntas := nil;
  fEncuesta := TEncuestaSatisfaccion.Create(MyBD);
  dsEncuesta.DataSet:=fEncuesta.DataSet;
  activarcomponentes(false,self,[3]);
  fSerie := tSeries_encuestas.CreateByFecha(mybd,datetostr(date));
  fSerie.Open;
  fPreguntas := tPreguntas_encuestas.CreateBySerie(mybd,fSerie.serie);
  fPreguntas.Open;
  dsPreguntas.dataset := fPreguntas.dataset;
end;

procedure TfrmEncuestaSatisfaccion.btnsalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmEncuestaSatisfaccion.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fEncuesta.close;
  fEncuesta.free;
  fSerie.close;
  fSerie.Free;
  fPreguntas.close;
  fPreguntas.free;
end;

procedure TfrmEncuestaSatisfaccion.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key = #13) and not (activeControl is Tbutton) then
  begin
    Perform(WM_Nextdlgctl, 0, 0);
//    key := #0;
  end;
end;

procedure TfrmEncuestaSatisfaccion.btnnuevaClick(Sender: TObject);
begin
  fEncuesta.Open;
  fEncuesta.Append;
  MostrarComponentes(false,self,[1]);
  activarComponentes(false,self,[2]);
  activarComponentes(true,self,[3]);
  dbefecha.SetFocus;
end;

procedure TfrmEncuestaSatisfaccion.btnbuscarClick(Sender: TObject);
begin
  MostrarComponentes(true,self,[1]);
  activarComponentes(false,self,[2,3]);
  fencuesta.Close;
end;

procedure TfrmEncuestaSatisfaccion.BitBtn3Click(Sender: TObject);
begin
  fencuesta.Open;
  if fencuesta.Locate(FIELD_FECHA,deFecha.text,[]) then
  begin
    activarcomponentes(true,self,[2,3]);
    dbefecha.setfocus;
    fencuesta.Edit;
  end
  else
  begin
     fencuesta.close;
     MessageDlg (Application.Title,format('No se han encontrado encuestas guardadas para la fecha %S',[defecha.text]), mtInformation, [mbOk],mbOk,0);
     defecha.setfocus;
  end;
end;

procedure TfrmEncuestaSatisfaccion.BitBtn4Click(Sender: TObject);
begin
  fEncuesta.dataset.Edit;
end;

procedure TfrmEncuestaSatisfaccion.BitBtn5Click(Sender: TObject);
begin
  if application.MessageBox(pchar(format('¿Desea Eliminar las encuestas del %S?',[dbefecha.text])),pchar(application.title),mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = 6 then
  begin
    fEncuesta.DataSet.Delete;
    dbefecha.setfocus;
  end;
end;

procedure TfrmEncuestaSatisfaccion.btnaceptarClick(Sender: TObject);
begin
  if validatepost then
    if fEncuesta.DataSet.State in [dsInsert,dsEdit] then
     if application.MessageBox('¿Desea guardar los cambios realizados?',pchar(application.title),mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = 6 then
      begin
        if fEncuesta.DataSet.State in [dsInsert] then
          begin
          fEncuesta.ValueByName[FIELD_SERIE]:=fEncuesta.serie;
          PonerValores;
          fEncuesta.Post(true);
          fEncuesta.Append;
          end
        else
          begin
          fEncuesta.Post(true);
          end;
        dbefecha.setfocus;
        MessageDlg('Encuestas de Satisfacción','Los datos han sido guradados con extios!!', mtInformation,[mbOK], MbOk, 0);
      end
end;

function TfrmEncuestaSatisfaccion.validatepost:boolean;
var aq: TSQLDataSet;
    cds : TClientDataSet;
    dsp : TDataSetProvider;
begin
  result := false;
  aQ := TSQLDataSet.Create(application);
  aQ.SQLConnection := MyBD;
  aQ.CommandType := ctQuery;
  aQ.GetMetadata := false;
  aQ.NoMetadata := true;
  aQ.ParamCheck := false;
  dsp := TDataSetProvider.Create(application);
  dsp.DataSet := aQ;
  dsp.Options := [poIncFieldProps,poAllowCommandText];
  cds:=TClientDataSet.Create(application);
  if fEncuesta.DataSet.State in [dsinsert,dsedit] then
  begin
    with cds do
    begin
      try
        SetProvider(dsp);
        CommandText := format('select rowid from TENCUESTAS_SATISFACCION where to_char(fecha,''dd/mm/yyyy'') = ''%S''',[dbefecha.text]);
        open;
        if (recordcount > 0) and (fields[0].asstring <> fencuesta.valuebyname[FIELD_ROWID]) then
        begin
          MessageDlg (Application.Title, format('Ya existen datos para la fecha %S',[dbefecha.text]), mtInformation, [mbOk],mbOk,0);
          dbefecha.setfocus;
          exit;
        end;
      finally
        free;
        dsp.Free;
        aq.Free;
      end;
    end;

    Try
     StrToDate(dbefecha.Text);
    Except
     Messagedlg(Caption,'Ingrese una fecha correcta',mtError,[mbok],mbok,0);
     dbefecha.SetFocus;
     exit;
    end;

    if dbeTotencu.text = '' then
    begin
      MessageDlg (Application.Title, 'Debe ingresar la cantidad de Encuestas realizadas' , mtInformation, [mbOk],mbOk,0);
      dbeTotencu.setfocus;
      exit;
    end;
    if not sumabien(dbep1ms.text,dbep1sa.text,dbep1ai.text,dbep1in.text,dbeTotencu.text) then
    begin
      MessageDlg (Application.Title, msg_suma+lblatentel.Caption+msg_mayor, mtInformation, [mbOk],mbOk,0);
      dbep1ms.setfocus;
      exit;
    end;
    if not sumabien(dbep2ms.text,dbep2sa.text,dbep2ai.text,dbep2in.text,dbeTotencu.text) then
    begin
      MessageDlg (Application.Title, msg_suma+lblletind.Caption+msg_mayor, mtInformation, [mbOk],mbOk,0);
      dbep2ms.setfocus;
      exit;
    end;
    if not sumabien(dbep3ms.text,dbep3sa.text,dbep3ai.text,dbep3in.text,dbeTotencu.text) then
    begin
      MessageDlg (Application.Title, msg_suma+lblvertec.Caption+msg_mayor, mtInformation, [mbOk],mbOk,0);
      dbep3ms.setfocus;
      exit;
    end;
    if not sumabien(dbep4ms.text,dbep4sa.text,dbep4ai.text,dbep4in.text,dbeTotencu.text) then
    begin
      MessageDlg (Application.Title, msg_suma+lblatenper.Caption+msg_mayor, mtInformation, [mbOk],mbOk,0);
      dbep4ms.setfocus;
      exit;
    end;
    if not sumabien(dbep5ms.text,dbep5sa.text,dbep5ai.text,dbep5in.text,dbeTotencu.text) then
    begin
      MessageDlg (Application.Title, msg_suma+lblrapser.Caption+msg_mayor, mtInformation, [mbOk],mbOk,0);
      dbep5ms.setfocus;
      exit;
    end;
    if not sumabien(dbep6ms.text,dbep6sa.text,dbep6ai.text,dbep6in.text,dbeTotencu.text) then
    begin
      MessageDlg (Application.Title, msg_suma+lblsergen.Caption+msg_mayor, mtInformation, [mbOk],mbOk,0);
      dbep6ms.setfocus;
      exit;
    end;
    if not sumabien(dbep7ms.text,dbep7sa.text,dbep7ai.text,dbep7in.text,dbeTotencu.text) then
    begin
      MessageDlg (Application.Title, msg_suma+lblactant.Caption+msg_mayor, mtInformation, [mbOk],mbOk,0);
      dbep7ms.setfocus;
      exit;
    end;
  end;
  result := true;
end;

function TfrmEncuestaSatisfaccion.sumabien(val1,val2,val3,val4,total: string):boolean;
begin
  result := true;
  if val1 = '' then
    val1:='0';
  if val2 = '' then
    val2:='0';
  if val3 = '' then
    val3:='0';
  if val4 = '' then
    val4:='0';
  if total = '' then
    total:='0';
  if strtoint(val1) + strtoint(val2) + strtoint(val3) + strtoint(val4) > strtoint(total) then
    result := false;
    
end;
procedure TfrmEncuestaSatisfaccion.btncancelarClick(Sender: TObject);
begin
  if fencuesta.DataSet.state in [dsedit, dsInsert] then
  if application.MessageBox('¿Desea Cancelar los cambios realizados?',pchar(application.title),mb_yesno+mb_iconquestion+mb_defbutton1+mb_applmodal) = 6 then
  begin
    if fencuesta.dataset.state in [dsedit]then
      fEncuesta.Cancel
    else
    begin
      fEncuesta.Cancel;
      fEncuesta.Append;
    end;
    dbefecha.setfocus;
  end;
end;

procedure TfrmEncuestaSatisfaccion.dbefechaExit(Sender: TObject);
begin
  if dbefecha.Date <> 0 then
  begin
  if assigned(fserie) then fserie.free;
  if assigned(fPreguntas) then fPreguntas.free;
  fSerie := tSeries_encuestas.CreateByFecha(mybd,dbefecha.text);
  fSerie.Open;
  fPreguntas := tPreguntas_encuestas.CreateBySerie(mybd,fSerie.serie);
  fPreguntas.Open;
  dsPreguntas.dataset := fPreguntas.dataset;
  end;
end;

procedure TfrmEncuestaSatisfaccion.deFechaExit(Sender: TObject);
begin
  if assigned(fserie) then fserie.free;
  if assigned(fPreguntas) then fPreguntas.free;
  fSerie := tSeries_encuestas.CreateByFecha(mybd,deFecha.text);
  fSerie.Open;
  fPreguntas := tPreguntas_encuestas.CreateBySerie(mybd,fSerie.serie);
  fPreguntas.Open;
  dsPreguntas.dataset := fPreguntas.dataset;
end;

end.
