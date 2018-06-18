unit ufOblInutilizad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, SqlExpr, StdCtrls, Buttons, Mask, ToolEdit, globals, ucDialgs,
  ExtCtrls, usagclasses, usagdata, usagestacion, DBClient, Provider, FMTBcd, UCertifi;

const
  WM_SEGUIRINUTIL=WM_USER+1;
  FICHERO_ACTUAL = 'ufOblInutilizad';

type
  TfmOblInutiliz = class(TForm)
    btnok: TBitBtn;
    btnEliminar: TBitBtn;
    btnSalir: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ednromatricula: TEdit;
    ednroinspec: TEdit;
    edano: TEdit;
    edobleanueva: TEdit;
    edobleavieja: TEdit;
    edmotivo: TEdit;
    defecha: TDateEdit;
    sdsquery1: TSQLDataSet;
    dspquery1: TDataSetProvider;
    query1: TClientDataSet;
    Bevel2: TBevel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    EdInspec: TEdit;
    Label8: TLabel;
    procedure btnokClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ednroinspecKeyPress(Sender: TObject; var Key: Char);
    procedure edanoChange(Sender: TObject);
    procedure edobleanuevaChange(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
     ID:integer;
     procedure IngresObleaDeVehiculoDesconocido(var Msge:TMessage); message WM_SEGUIRINUTIL;
     procedure ImprimeConstancia;
     Procedure ObtenerDatos;
     procedure LimpiarDatos;
     Function EstaAsignada(Oblea, Ejercici: String): boolean;
//     Function EstaAnulada(Oblea: String): boolean;

  public
    { Public declarations }
  end;

  function StripNol(s:string):string;
  procedure DoObleaInutilizada;

var
  fmOblInutiliz: TfmOblInutiliz;
  vAnioVenci: Integer;
  vObleaOri, vObleaAsig: String;
  Imprimio: Boolean = false;
  fInspeccion, AuxInspeccion: TInspeccion;
  aInspeccion, aEjercici: String;
  fOblea: TOblea;
  fCertificado: TFrmCertificado;

const
  VACIO = '';

implementation


{$R *.DFM}

uses
  uftmp,
  ufReemplazoObleaToPrint,
  UUtils,
  UReimpresion,
  uLogs;


Function TfmOblInutiliz.EstaAsignada(Oblea, Ejercici: String): Boolean;
Begin
Result:= false;
  try
    with TSQLQuery.Create(Self) do
      begin
        screen.Cursor:=crHourGlass;
        SQLConnection:=mybd;
        SQL.Clear;
        Close;
        SQL.Add('SELECT * FROM TINSPECCION WHERE NUMOBLEA=:OBLEA');
        ParamByName('OBLEA').AsString:=Oblea;
        Open;
        if not IsEmpty then
          Result:=true
        else
          Begin
            SQL.Clear;
            Close;
            SQL.Add('SELECT NUMOBLEA FROM T_ERVTV_ANULAC WHERE NUMOBLEA=:OBLEA');
            ParamByName('OBLEA').AsString:=Oblea;
            Open;
            if not IsEmpty then
              Result:=true;
          end;
      end;
  finally
    screen.Cursor:=crDefault;
  end;
end;



Procedure TfmOblInutiliz.LimpiarDatos;
var
I: Integer;
Begin
For I:=0 To ComponentCount-1 do
  if Components[I] is TEdit then
    TEdit(Components[I]).Text:='';
ednroinspec.SetFocus;
Imprimio:= false;
end;


Procedure TfmOblInutiliz.ObtenerDatos;
var
QInspeccion: TSQLQuery;
fVehiculo: TVEHICULO;
begin
aInspeccion:=edNroInspec.Text;
aEjercici:=edAno.Text;
  try
    fInspeccion:=TInspeccion.CreateFromDataBase(MyBd,DATOS_INSPECCIONES,format(' WHERE CODINSPE = %S and EJERCICI = %S',[aInspeccion, aEjercici]) );
    fInspeccion.Open;
    if (FInspeccion.ValueByName[FIELD_CODINSPE] <> VACIO) and (fInspeccion.GetNumOblea <> VACIO)then
        Begin
          fVehiculo := finspeccion.GetVehiculo;
          fVehiculo.open;
          vAnioVenci:=StrToInt(Copy(fInspeccion.ValueByName[FIELD_FECVENCI],7,4));
          EdObleaVieja.Text:=Copy(fInspeccion.GetNumOblea,1,2)+Copy(fInspeccion.GetNumOblea,4,8);
          EdInspec.Text:=fInspeccion.Informe;
          EdNroMatricula.Text:= fVehiculo.GetPatente;
////////////////////////////////////////////////////////////////////////////////////////////////////////////
          try
            vObleaAsig:=FormatFloat('00000000',StrToInt(GetOblea(vAnioVenci,MyBD)));
            {$IFDEF TRAZAS}
            FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO ASIGNO POR DEFECTO LA OBLEA: '+vObleaAsig);
            {$ENDIF}
///////////////////////////////////////////////////////////////////////////////////////////////////////////
            vObleaOri:=vObleaAsig;
            //EdObleaNueva.Text:=vObleaAsig;    <- Cero Izq.
            EdObleaNueva.Text:=vObleaAsig;
          except
            Begin
              Messagedlg('ERROR DE OBLEAS','No se encontraron obleas disponibles',mtWarning,[mbOK],mbOK,0);
              LimpiarDatos;
            end;
          end;
      end
    else
      Begin
        messagedlg('ERROR DE DATOS','No se encontraron datos para esa inspección'+#13#10+'y número de ejercicio. Por favor, revise los datos.',mtERROR,[mbOK],mbOK,0);
        LimpiarDatos;
      end;
  Except
    on E: Exception do
      messagedlg(caption,E.Message,mtInformation,[mbOK],mbOK,0);
  end;
end;


procedure TfmOblInutiliz.edobleanuevaChange(Sender: TObject);
begin
vObleaAsig:=EdObleaNueva.Text;
If (vObleaAsig) <> (vObleaOri) then
  If length(EdObleaNueva.Text)=8 then
    If ObleaDisponible(StrToInt(vObleaAsig),vAnioVenci,MyBd) then
      Begin
        GetNewOblea(StrToInt(vObleaAsig),vAnioVenci, MyBd);
        RestoreOblea(StrToInt(vObleaOri), vAnioVenci ,MyBD);
        vObleaOri:= vObleaAsig;
      end
    else
     EdObleaNueva.Text:=FormatFloat('00000000',StrToInt(vObleaOri));
end;


procedure DoObleaInutilizada;
begin
   with TfmOblInutiliz.Create(Application) do
   try
      ShowModal;
   finally
      Free;
   end;
end;


function StripNol(s:string):string;
var ok:boolean;
    s1:string;
begin
   ok:=true;
   s1:=s;
   repeat
      ok:=true;
      if Length(s1)>0 then
        if s1[1]='0' then
           begin
              ok:=false;
              s1:=Copy(s1,2,Length(s1)-1);
           end;
   until ok;
   Result:=s1;
end;

procedure TfmOblInutiliz.IngresObleaDeVehiculoDesconocido(var Msge:TMessage);
begin
   {escribimos solamente matricula, sin codvehic}
   if Msge.WParam=1 then begin
   //PROVERIT"
      with TSQLQuery.Create(Self) do begin
         SQLConnection:=mybd;
         SQL.Add('SELECT CODINUTIL FROM T_ERVTV_INUTILIZ WHERE CODINSPE=:CODINSPE AND MATRICULA=:MATRICULA AND OBLEAANT=:OBLEAANT AND OBLEANUEV=:OBLEANUEV');
         ParamByName('CODINSPE').AsInteger:=StrToInt(ednroinspec.Text);
         ParamByName('MATRICULA').AsString:=ednromatricula.Text;
         ParamByName('OBLEAANT').AsString:=edobleavieja.Text;
         ParamByName('OBLEANUEV').AsString:=edobleanueva.Text;
         try
            Open;
            if IsEmpty then begin
               Close;
               SQL.Clear;
               SQL.Add('INSERT INTO T_ERVTV_INUTILIZ(CODINUTIL,FECHA,MATRICULA,OBLEAANT,OBLEANUEV,MOTIVO,CODINSPE) VALUES(:ID,:FECHA,:MATRIC,:OBLANT,:OBLNUE,:MOTIVO,:CODINSP)');
               ParamByName('ID').AsInteger:=ID;
               ParamByName('FECHA').AsString:=defecha.Text;
               ParamByName('MATRIC').AsString:=ednromatricula.Text;
               ParamByName('OBLANT').AsString:=edobleavieja.Text;
               ParamByName('OBLNUE').AsString:=edobleanueva.Text;
               ParamByName('MOTIVO').AsString:=edmotivo.Text;
               ParamByName('CODINSP').AsInteger:=StrToInt(ednroinspec.Text);
               ExecSQL;
               Close;
               SQL.Clear;
               SQL.Add('UPDATE T_ERVTV_CURRENTNUM SET INUTILIZ=INUTILIZ+1');
               ExecSQL;
               ednromatricula.SetFocus;
               messagedlg(caption,'Proceso Realizado con Exito',mtInformation,[mbOK],mbOK,0);
            end
          else
               messagedlg(caption,'Oblea Ya Registrada',mtInformation,[mbOK],mbOK,0);
        finally
           Close;
           Free;
        end;
      end;
   end;
end;



procedure TfmOblInutiliz.btnokClick(Sender: TObject);
var
aQ: TSQLDataset;
dsp : TDataSetProvider;
cds : TClientDataSet;

numinsp,ejerc,codveh:integer;
numobl,s:string;
ok,ok1,ok2:boolean;
InsertaDatos, QInspeccion:TSQLQuery;
FBusqueda: TFTmp;
Error, sEjercici, sCodInsp, sMatricula: String;

ObleaInut, ObleaNew: TOblea;

begin
Error:='';
if ednromatricula.text = '' then
  Error:=Error+'- Matrícula para el vehículo.'+#13#10;
if ednroinspec.text = '' then
  Error:=Error+'- Número de inspección.'+#13#10;
if edano.text = '' then
  Error:=Error+'- Año de inspección.'+#13#10;
if edobleanueva.text = '' then
  Error:=Error+'- Número de oblea nueva.'+#13#10;
if edmotivo.text = '' then
  Error:= Error+'- Debe ingresar un motivo.'+#13#10;
if defecha.text = '  /  /    ' then
  Error:= Error+'- Fecha de Inutilización.'+#13#10;
fbusqueda:= TFTmp.create(application);
if EstaAsignada(edobleanueva.Text, edano.Text) then
  Error:= Error+'- La Oblea nueva ya esta asignada a una inpección,'+#13#10+'o se encuentra anulada.'+#13#10;

  with fbusqueda do
    try
     fbusqueda.Temporizar(True,True,'Inutilizando Oblea','Espere por favor.');
      if (Error = '') then
        Begin
        with TSQLQuery.Create(self) do
          try
            Screen.Cursor:=crHourGlass;
            Query1.Close;
            sdsQuery1.ParamByName('CODINS').AsInteger:=StrToInt(ednroinspec.Text);
            sdsQuery1.ParamByName('EJERC').AsInteger:=StrToInt(edano.Text);
            sdsQuery1.ParamByName('PATENT').AsString:=ednromatricula.Text;
            Query1.Open;
            codveh:=Query1.Fields[0].AsInteger;

            SQLConnection:= mybd;
            SQL.Add('SELECT INUTILIZ FROM T_ERVTV_CURRENTNUM');
            Open;
            ID:=Fields[0].AsInteger;

            Close;
            SQL.Clear;
            SQL.Add('INSERT INTO T_ERVTV_INUTILIZ(CODINUTIL,FECHA,CODVEHIC,MATRICULA,OBLEAANT,OBLEANUEV,MOTIVO,CODINSPE) VALUES(:ID,:FECHA,:CODVEH,:MATRIC,:OBLANT,:OBLNUE,:MOTIVO,:CODINSP)');
            ParamByName('ID').AsInteger:=ID;
            ParamByName('FECHA').value:=defecha.date;
            ParamByName('CODVEH').AsInteger:=codveh;
            ParamByName('MATRIC').AsString:=ednromatricula.Text;
            ParamByName('OBLANT').AsString:=edobleavieja.Text;
            ParamByName('OBLNUE').AsString:=edobleanueva.Text;
            ParamByName('MOTIVO').AsString:=edmotivo.Text;
            ParamByName('CODINSP').AsInteger:=StrToInt(ednroinspec.Text);
            ExecSQL;

            Close;
            SQL.Clear;
            SQL.Add('UPDATE T_ERVTV_CURRENTNUM SET INUTILIZ=INUTILIZ+1');
            ExecSQL;

//********************************** VERSION SAG 4.00 **********************************************
            sEjercici:= edAno.Text;
            sCodInsp:= ednroinspec.Text;
            sMatricula:= ednromatricula.Text;

            ObleaInut:=TOblea.CreateByOblea(MyBD,edobleavieja.Text);
            ObleaInut.Open;
            ObleaInut.InutilizarOblea(DateToStr(Now));
            ObleaInut.Free;
            {$IFDEF TRAZAS}
            FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO A ESTADO INUTILIZADO LA OBLEA: '+edobleavieja.Text);
            {$ENDIF}

            ObleaNew:=TOblea.CreateByOblea(MyBD,edobleaNueva.Text);
            ObleaNew.Open;
            ObleaNew.ConsumirObleaFromInu(DateToStr(Now),sEjercici, sCodInsp);
            ObleaNew.Free;
            {$IFDEF TRAZAS}
            FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO A ESTADO CONSUMIDO K LA OBLEA: '+edobleaNueva.Text);
            {$ENDIF}

            fInspeccion.Edit;
            fInspeccion.ValueByName[FIELD_NUMOBLEA]:=EdObleaNueva.Text;
            fInspeccion.Post(true);
            Application.ProcessMessages;
            Temporizar(True,True,'Inutilizando Oblea','Reimprimiendo Certificado de Inspeccion');
            UReimpresion.ImprimirCertificado(sEjercici,sCodInsp,sMatricula);
            Imprimio:= true;
//**************************************************************************************************

            Application.ProcessMessages;
            Temporizar(True,True,'Inutilizando Oblea','Imprimiendo Constancia de Inutilización');
            ImprimeConstancia;

          Except
            on E : Exception do
              Begin
                Screen.Cursor:=crDefault;
                Temporizar(false,false,'','');
                ShowMessage('ERROR',E.Message);
              end;
          end;
        Screen.Cursor:=crDefault;
        Temporizar(false,false,'','');
        LimpiarDatos;
        end
      else
        MessageDlg('ERROR EN LOS DATOS','Se han encontrado errores en los siguientes campos:'+#13+#10+#13+#10+Error, mtError,[mbOK],mbOK, 0);
    finally
      Close;
      Free;
    end;
end;


procedure TfmOblInutiliz.btnEliminarClick(Sender: TObject);
var
vOblea: TOblea;

begin
btnok.Enabled:=false;
btnSalir.Enabled:=false;
  if MessageDlg(caption,'¿Esta seguro que desea eliminar la Inutilizacion?',mtConfirmation,[mbYes,mbNo],mbYes,0)=mrYes then
    with TSQLQuery.Create(self) do
      try

//******************************* VERSION SAG 4.04.21 **********************************************
        SQLConnection:=mybd;
        Close;
        SQL.Clear;
        SQL.Add('SELECT OBLEAANT FROM T_ERVTV_INUTILIZ WHERE CODINSPE=:CODINSPE AND MATRICULA=:MATRICULA');
        ParamByName('CODINSPE').AsInteger:=StrToInt(ednroinspec.Text);
        ParamByName('MATRICULA').AsString:=ednromatricula.Text;
        Open;

        fInspeccion.Edit;
        fInspeccion.ValueByName[FIELD_NUMOBLEA]:=Fields[0].Value;
        fInspeccion.Post(true);
        Application.ProcessMessages;
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE LE COLOCO EL NUMERO DE OBLEA ANTERIOR A LA INSPECICON: '+ ednroinspec.Text +' POR ELIMINACION DE INUTILIZACION');
        {$ENDIF}

        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM T_ERVTV_INUTILIZ WHERE CODINSPE=:CODINSPE AND MATRICULA=:MATRICULA AND ');
        SQL.Add('OBLEAANT=:OBLEAANT AND OBLEANUEV=:OBLEANUEV');
        ParamByName('CODINSPE').AsInteger:=StrToInt(ednroinspec.Text);
        ParamByName('MATRICULA').AsString:=ednromatricula.Text;
        ParamByName('OBLEAANT').AsString:=edobleavieja.Text;
        ParamByName('OBLEANUEV').AsString:=edobleanueva.Text;
        ExecSQL;
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'BORRO EL RESITRO CUYO NUMERO DE INSPECCION ES '+ ednroinspec.Text +' DE LA TABLA T_ERVTV_INUTILIZ');
        {$ENDIF}

        Close;
        SQL.Clear;
        SQL.Add('UPDATE TOBLEAS SET ESTADO=:ESTADO, FECHA_INUTILIZADA = null WHERE NUMOBLEA =:OBLEA');
        ParamByName('ESTADO').AsString:=DISPONIBLE;
        ParamByName('OBLEA').AsString:=edobleavieja.Text;;
        ExecSQL;
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO A ESTADO DISPONIBLE LA OBLEA: '+edobleavieja.Text);
        {$ENDIF}

        ShowMessage(caption,'Se ha ELIMINADO la Inutilizacion de oblea con exito!!!');
//**************************************************************************************************

        ednromatricula.Clear;
        edobleanueva.Clear;
        edobleavieja.Clear;
        ednroinspec.Clear;
        edmotivo.Clear;
        edano.Clear;
        Edinspec.Clear;
        defecha.Date:=Date;
      finally
        Close;
        Free;
      end;
btnok.Enabled:=true;
btnSalir.Enabled:=true;
end;


procedure TfmOblInutiliz.FormCreate(Sender: TObject);
begin
sdsquery1.sqlconnection:=mybd;
defecha.Date:=Date;
end;


procedure TfmOblInutiliz.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key = Chr(VK_RETURN) then
  begin
    Perform (WM_NEXTDLGCTL, 0, 0);
    Key := #0;
  end;
end;


procedure TfmOblInutiliz.ednroinspecKeyPress(Sender: TObject;
  var Key: Char);
begin
if not (Key in ['0'..'9',#8]) then
 key:=#0;
end;


procedure tfmOblInutiliz.ImprimeConstancia;
var
avehiculo: tvehiculo;
acliente: tclientes;
ainspe: tinspeccion;
aModelo: tsagdata;
begin
  try
    avehiculo := nil;
    acliente := nil;
    ainspe := nil;
    aModelo := nil;
    ainspe := tinspeccion.create(mybd,FORMAT('WHERE CODINSPE = %S AND EJERCICI = %S',[ednroinspec.text,edano.text]));
    ainspe.open;
    avehiculo := ainspe.GetVehiculo;
    avehiculo.open;
    acliente := ainspe.GetPropietario;
    acliente.open;
    aModelo := aVehiculo.getmodelo;
    aModelo.open;
    Application.ProcessMessages;
    with tfrmReemplazoObleaToPrint.Create(application) do
      try
        qrlzona.Caption := inttostr(fvarios.zona);
        qrlPlanta.caption := inttostr(fvarios.CodeEstacion);

        with tsqlquery.create(self) do
          try
            SQLConnection:=mybd;
            sql.Add(FORMAT('SELECT NOMMARCA FROM TMARCAS WHERE CODMARCA = %S',[aVehiculo.valuebyname[FIELD_CODMARCA]]));
            open;
            qrlVehiculo.caption := fields[0].asstring +' '+aModelo.valuebyName[FIELD_NOMMODEL];
            close;
          finally
            free;
          end;

        qrlPatente.caption := aVehiculo.getpatente;
        qrlAnterior.caption := edobleavieja.text;
        qrlEntregada.caption := edobleanueva.text;
        qrltitular.caption := acliente.valuebyname[FIELD_APELLIDOS_Y_NOMBRE];
        qrldocumento.caption := acliente.valuebyname[FIELD_TIPODOCU]+' '+acliente.ValueByName[FIELD_DOCUMENT];
        qrlinforme.Caption := ainspe.Informe;
        qrlfecha.caption := defecha.Text;
        repReemplazo.prepare;
        repReemplazo.PrinterSetup;
        Application.ProcessMessages;
        repReemplazo.print;
      finally
        free;
      end;
  finally
    avehiculo.free;
    acliente.free;
    ainspe.free;
    aModelo.Free;
  end;
end;


procedure TfmOblInutiliz.edanoChange(Sender: TObject);
begin
if Length(edAno.Text) = 4 then
  ObtenerDatos;
end;


procedure TfmOblInutiliz.btnSalirClick(Sender: TObject);
begin
Close;
end;


procedure TfmOblInutiliz.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if not Imprimio then
  if (vObleaAsig <> '') then
  Begin
    If (vObleaAsig) <> (vObleaOri) then
      RestoreOblea(StrToInt(vObleaAsig), vAnioVenci ,MyBD)
    else
      RestoreOblea(StrToInt(vObleaOri), vAnioVenci ,MyBD);
  end;
end;

procedure TfmOblInutiliz.FormDestroy(Sender: TObject);
begin
fInspeccion.Free;
end;

end.
