unit ufMovObleasVTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, globals, uStockClasses, uStockEstacion, uLogs, ucDialgs,
  StdCtrls, Buttons, RxLookup, ToolEdit, RXDBCtrl, Mask, DBCtrls, DB,
  ExtCtrls, sqlExpr, FMTBcd, Provider, DBClient;

type
  TfrmMovObleasVTV = class(TForm)
    btnSalir: TBitBtn;
    srcOrigen: TDataSource;
    srcPlanta: TDataSource;
    srcMovimiento: TDataSource;
    edObleaInicial: TDBEdit;
    edAno: TDBEdit;
    edCantidad: TDBEdit;
    edObleaFinal: TDBEdit;
    edFecha: TDBDateEdit;
    lcbOrigen: TRxDBLookupCombo;
    lcbDestino: TRxDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Bevel1: TBevel;
    Label9: TLabel;
    edFechsoli: TDBDateEdit;
    edMotivo: TDBEdit;
    Label10: TLabel;
    srcPrepara: TDataSource;
    srcAutoriza: TDataSource;
    Label11: TLabel;
    lcbPrepara: TRxDBLookupCombo;
    Label12: TLabel;
    lcbAutoriza: TRxDBLookupCombo;
    edCantCertif: TDBEdit;
    edCantBolsi: TDBEdit;
    Label13: TLabel;
    Label15: TLabel;
    Label8: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label14: TLabel;
    edCertIni: TDBEdit;
    Label19: TLabel;
    edCertFin: TDBEdit;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    SQLDataSet1: TSQLDataSet;
    ClientDataSet2: TClientDataSet;
    DataSetProvider2: TDataSetProvider;
    SQLDataSet2: TSQLDataSet;
    ClientDataSet3: TClientDataSet;
    DataSetProvider3: TDataSetProvider;
    SQLDataSet3: TSQLDataSet;
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edCantidadExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure lcbOrigenCloseUp(Sender: TObject);
    procedure lcbDestinoCloseUp(Sender: TObject);
    procedure lcbPreparaCloseUp(Sender: TObject);
    procedure lcbAutorizaCloseUp(Sender: TObject);
    procedure edCantCertifEnter(Sender: TObject);
    procedure edCantBolsiEnter(Sender: TObject);
    procedure edCertIniExit(Sender: TObject);

  private
    { Private declarations }
    //fMovimiento: tMovimientos_VTV;
    fMovimiento : TClientDataSet;
    fPlanta, fOrigen: tPlantas;
    //fPrepara, fAutoriza: tPersonal;
    fPrepara, fAutoriza: TClientDataSet;
  public
    { Public declarations }
    planta,MOVIMIENTO,anio,
    ObleaIni,ObleaFin,plantaOri,
    plantadest:integer;
    procedure ActualizarObleas;
    function ValidatePost:boolean;
    function CantidadIgualObleas:boolean;
    function ExisteCertificados: boolean ;
    procedure ActualizarCertificados;
  end;
  procedure DoMovObleasVTV;

var
  frmMovObleasVTV: TfrmMovObleasVTV;

resourcestring
  FILE_NAME = 'ufMovObleasVTV';
  CAPTION = 'Movimiento de Obleas';

implementation

uses Math, urMovObleasVTV;

{$R *.dfm}

procedure DoMovObleasVTV;
begin
  with TfrmMovObleasVTV.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;


procedure TfrmMovObleasVTV.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  close;
end;

procedure TfrmMovObleasVTV.FormCreate(Sender: TObject);
begin
    fOrigen := nil;
    fMovimiento := nil;
    fPlanta := nil;
    fPrepara := nil;
    fAutoriza := nil;

    SQLDataSet1.SQLConnection := mybd;
    SQLDataSet1.CommandType := ctQuery;
    SQLDataSet1.GetMetadata := false;
    SQLDataSet1.NoMetadata := true;
    SQLDataSet1.ParamCheck := false;
    DataSetProvider1.DataSet := SQLDataSet1;
    DataSetProvider1.Options := [poIncFieldProps,poAllowCommandText];

    SQLDataSet2.SQLConnection := mybd;
    SQLDataSet2.CommandType := ctQuery;
    SQLDataSet2.GetMetadata := false;
    SQLDataSet2.NoMetadata := true;
    SQLDataSet2.ParamCheck := false;
    DataSetProvider2.DataSet := SQLDataSet1;
    DataSetProvider2.Options := [poIncFieldProps,poAllowCommandText];

    SQLDataSet3.SQLConnection := mybd;
    SQLDataSet3.CommandType := ctQuery;
    SQLDataSet3.GetMetadata := false;
    SQLDataSet3.NoMetadata := true;
    SQLDataSet3.ParamCheck := false;
    DataSetProvider3.DataSet := SQLDataSet1;
    DataSetProvider3.Options := [poIncFieldProps,poAllowCommandText];

    fOrigen := tPlantas.Create(MYBD);
    fPlanta := tPlantas.CreatePlantasVTV(MYBD);
    //fMovimiento := tMovimientos_VTV.CreateByRowId(mybd,'');
    //fPrepara := tPersonal.Create(mybd);
    //fAutoriza := tPersonal.Create(MyBD); 
    fMovimiento := ClientDataSet1;
    fPrepara := ClientDataSet2;
    fAutoriza := ClientDataSet3;

    With fMovimiento do
        Try
            close;
            SetProvider(DataSetProvider1);
            commandtext:='SELECT A.IDMOVIMIENTO,A.FECHA,A.CANTIDAD,A.OBLEAINICIAL,A.ANO,A.OBLEAFINAL,'+
                         'A.IDORIGEN,A.IDDESTINO,A.TIPO,A.ANULADO,A.NROCOMPROBANTE,A.MOTIVO,A.FECHALTA,A.FECHSOLI,'+
                         'A.IDPREPARA,A.IDAUTORIZA,A.CANTCERTIF,A.CANTBOLSI,A.CERTINICIAL,A.CERTFINAL  '+
                         'FROM VTV_MOVIMIENTO A';
    Finally
    end;

    With fPrepara do
        Try
            close;
            SetProvider(DataSetProvider2);
            commandtext:='SELECT A.IDPERSONAL,A.NOMBRE,A.APELLIDO,A.IDPLANTA,A.EMAIL,'+
                         'A.IDPUESTO,A.IDEMPRESA,A.CLAVE,A.FECHALTA,A.ABREVIATURA '+
                         'FROM PERSONAL A';
    Finally
    end;

    With fAutoriza do
        Try
            close;
            SetProvider(DataSetProvider3);
            commandtext:='SELECT A.IDPERSONAL,A.NOMBRE,A.APELLIDO,A.IDPLANTA,A.EMAIL,'+
                         'A.IDPUESTO,A.IDEMPRESA,A.CLAVE,A.FECHALTA,A.ABREVIATURA '+
                         'FROM PERSONAL A';
    Finally
    end;

    fOrigen.Open;
    fPlanta.Open;
    fMovimiento.Open;
    fPrepara.Open;
    fAutoriza.Open;
    //fMovimiento.Append;

    srcOrigen.DataSet := fOrigen.DataSet;
    srcPlanta.DataSet := fPlanta.DataSet;
    //srcMovimiento.DataSet := fMovimiento.DataSet;
    //srcPrepara.DataSet := fPrepara.DataSet;
    //srcAutoriza.DataSet := fAutoriza.DataSet;
    srcMovimiento.DataSet:=fMovimiento;
    srcPrepara.DataSet := fPrepara;
    srcAutoriza.DataSet := fAutoriza;

    MyBD.StartTransaction(td);

end;

procedure TfrmMovObleasVTV.FormDestroy(Sender: TObject);
begin
    fOrigen.free;
    fMovimiento.free;
    fPlanta.free;
    fPrepara.free;
    fAutoriza.free;
end;

procedure TfrmMovObleasVTV.btnAceptarClick(Sender: TObject);
begin
  try
    if CantidadIgualObleas then
    begin
      if ValidatePost then
      begin
        //fMovimiento.ValueByName[FIELD_TIPO] := MOV_TIPO_MOVIMIENTO;
        fMovimiento.FieldValues[FIELD_TIPO] := MOV_TIPO_MOVIMIENTO;
        //fMovimiento.Post(true);
        ActualizarObleas;
       // ActualizarCertificados;
        MyBD.Commit(td);
        //DoRepMovObleasVTV(fMovimiento.ValueByName[FIELD_IDMOVIMIENTO],strtoint(fOrigen.valuebyname[FIELD_IDEMPRESA]));
        //DoRepMovObleasVTV(fMovimiento.FieldValues[FIELD_IDMOVIMIENTO],strtoint(fOrigen.valuebyname[FIELD_IDEMPRESA]));
        DoRepMovObleasVTV(IntToSTR(MOVIMIENTO),strtoint(fOrigen.valuebyname[FIELD_IDEMPRESA]));
        MessageDlg(CAPTION,'Movimiento registrado con �xito',mtInformation,[mbOK],mbOK,0);
        fMovimiento.Append;
        MyBD.StartTransaction(td);
      end;
    end
    else
        MessageDlg(CAPTION,'El lote de obleas no se encuentra en la planta de origen',mtError,[mbOK],mbOK,0);

  except
   on E: Exception do
   begin
      MessageDlg(CAPTION,Format('No se ha podido registrar el movimiento por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
      MyBD.Rollback(td);
   end;
  end;
end;

procedure TfrmMovObleasVTV.ActualizarObleas;
var sqloracle,MOTIVO,FECHASOL:string;
PREPARA,AUTORIZA:longint;

begin

planta:=0;  MOVIMIENTO:=0;
ObleaIni:=0;  ObleaFin:=0;
plantaOri:=0; plantadest:=0;
anio:=0;

planta:=strtoint(fPlanta.ValueByName[FIELD_IDPLANTA]);
plantaOri:=strtoint(fOrigen.valuebyname[FIELD_IDPLANTA]);
plantadest:=strtoint(fPlanta.ValueByName[FIELD_IDPLANTA]);
PREPARA:=strtoint(fPrepara.FieldValues[FIELD_IDPERSONAL]);
AUTORIZA:=strtoint(fAutoriza.FieldValues[FIELD_IDPERSONAL]);
FECHASOL:=TRIM(edFechsoli.Text);
MOTIVO:=TRIM(edMotivo.Text);
anio:=strtoint(edano.text);
ObleaIni:=strtoint(edObleaInicial.Text);
ObleaFin:=strtoint(edObleaFinal.Text);

   try
   with tsqlquery.create(nil) do
       try
         SqlConnection := MyBD;
           sql.Clear;
           //sql.Add(format('UPDATE VTV_OBLEAS SET IDPLANTA = %S, IDMOVIMIENTO = %S WHERE ANO = %S AND NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.ValueByName[FIELD_IDMOVIMIENTO], edano.text,edObleaInicial.Text,edObleaFinal.Text]));
           //sql.Add(format('UPDATE VTV_OBLEAS SET IDPLANTA = %S, IDMOVIMIENTO = %S WHERE ANO = %S AND NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.FieldValues[FIELD_IDMOVIMIENTO], edano.text,edObleaInicial.Text,edObleaFinal.Text]));

           sqloracle := 'SELECT IDMOVIMIENTO FROM VTV_MOVIMIENTO'+
                        ' WHERE ANO ='+IntToSTR(anio)+
                        '   AND OBLEAINICIAL = '+IntToSTR(ObleaIni);
           SQL.Add(sqloracle);
           ExecSQL;
           Open;
           MOVIMIENTO:=FIELDBYNAME('IDMOVIMIENTO').ASInteger;
       finally
          close;
          free;
       end;


      with tsqlquery.create(nil) do
       try
         SqlConnection := MyBD;
           sql.Clear;
           //sql.Add(format('UPDATE VTV_OBLEAS SET IDPLANTA = %S, IDMOVIMIENTO = %S WHERE ANO = %S AND NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.ValueByName[FIELD_IDMOVIMIENTO], edano.text,edObleaInicial.Text,edObleaFinal.Text]));
           //sql.Add(format('UPDATE VTV_OBLEAS SET IDPLANTA = %S, IDMOVIMIENTO = %S WHERE ANO = %S AND NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.FieldValues[FIELD_IDMOVIMIENTO], edano.text,edObleaInicial.Text,edObleaFinal.Text]));

           sqloracle := 'UPDATE VTV_OBLEAS SET '+
                        ' IDPLANTA ='+IntToSTR(planta)+
                        ',IDMOVIMIENTO ='+IntToSTR(MOVIMIENTO)+
                        ' WHERE ANO ='+IntToSTR(anio)+
                        '   AND NUMERO BETWEEN '+IntToSTR(ObleaIni)+
                        '   AND '+IntToSTR(ObleaFin)+
                        '   AND ESTADO = ''S''';
           SQL.Add(sqloracle);
           ExecSQL;
       finally
          close;
          free;
       end;

       with tSqlquery.Create(nil) do
       try
         SQLConnection:= MyBD;
           sql.Clear;
           sqloracle := 'UPDATE VTV_MOVIMIENTO SET '+
                        ' IDDESTINO ='+IntToSTR(plantadest)+
                        ',TIPO = ''M'' '+
                        ',MOTIVO = '+#39+TRIM(MOTIVO)+#39+
                        ',IDPREPARA = '+IntToSTR(PREPARA)+
                        ',IDAUTORIZA = '+IntToSTR(AUTORIZA)+
                        ',FECHSOLI = to_date('+#39+TRIM(FECHASOL)+#39+',''dd/mm/yyyy'')'+
                        ' WHERE IDMOVIMIENTO ='+IntToSTR(MOVIMIENTO);
           SQL.Add(sqloracle);
           ExecSQL;
       finally
         close;
         free;
       end;

    except
      on E: Exception do
      begin
        MessageDlg(CAPTION,Format('No se ha podido registrar el mov por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
        MyBD.Rollback(td);
      end;
    end;
end;

procedure TfrmMovObleasVTV.ActualizarCertificados;
begin
    try
     if (edCertIni.text <> '')  and (edCertFin.text <> '')  then
       begin
          with tSqlquery.create(nil) do
          try
            SqlConnection := MyBD;
            sql.Clear;
            //sql.Add(format('UPDATE INFOR_CERTIF SET IDPLANTA = %S, IDMOVIMIENTO = %S , ESTADO =''C'' WHERE ID=''C'' AND  NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.ValueByName[FIELD_IDMOVIMIENTO], edCertIni.Text,edCertFin.Text]));
            sql.Add(format('UPDATE INFOR_CERTIF SET IDPLANTA = %S, IDMOVIMIENTO = %S , ESTADO =''C'' WHERE ID=''C'' AND  NUMERO BETWEEN %S AND %S',[fPlanta.ValueByName[FIELD_IDPLANTA],fMovimiento.FieldValues[FIELD_IDMOVIMIENTO], edCertIni.Text,edCertFin.Text]));
            ExecSQL;
            close;
          finally
            free;
          end;
       end;
     except
      on E: Exception do
      begin
        MessageDlg(CAPTION,Format('No se ha podido registrar  el mov por: %s. ',[E.message]), mtError, [mbOk], mbOk, 0);
        MyBD.Rollback(td);
      end;
    end;
end;
function TfrmMovObleasVTV.ValidatePost: boolean;
begin
  result := false;

  if edFechsoli.Date = 0  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la fecha de solicitud',mtError,[mbOK],mbOK,0);
        edFechsoli.SetFocus;
        exit;
  end;

  if edFecha.Date = 0  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la fecha de entrega',mtError,[mbOK],mbOK,0);
        edFecha.SetFocus;
        exit;
  end;
  if edAno.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el a�o de las obleas',mtError,[mbOK],mbOK,0);
        edAno.SetFocus;
        exit;
  end;
  if edObleaInicial.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el N� de oblea inicial',mtError,[mbOK],mbOK,0);
        edObleaInicial.SetFocus;
        exit;
  end;
  if edCantidad.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la cantidad de obleas',mtError,[mbOK],mbOK,0);
        edCantidad.SetFocus;
        exit;
  end;
  if lcbOrigen.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el proveedor de obleas',mtError,[mbOK],mbOK,0);
        lcbOrigen.SetFocus;
        exit;
  end;
  if lcbDestino.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar el dep�sito al que ingresaron las obleas',mtError,[mbOK],mbOK,0);
        lcbDestino.SetFocus;
        exit;
  end;
  if lcbPrepara.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la persona que prepar� la entrega',mtError,[mbOK],mbOK,0);
        lcbPrepara.SetFocus;
        exit;
  end;
  if lcbAutoriza.Text = ''  then
  begin
        MessageDlg(CAPTION,'Se debe ingresar la persona que autoriz� la entrega',mtError,[mbOK],mbOK,0);
        lcbAutoriza.SetFocus;
        exit;
  end;

  if not CantidadIgualObleas then
  begin
        MessageDlg(CAPTION,'El lote de obleas no se encuentra en la planta de origen',mtError,[mbOK],mbOK,0);
        exit;
  end;
   // Controlar que los certificados EXISTAN dados de alta y uqe esten en stock (RANGO)
  //    if not ExisteCertificados then
 // begin
     //   MessageDlg(CAPTION,'El lote de Certificados no se encuentra dado de alta o bien ya fue consumido',mtError,[mbOK],mbOK,0);
       // exit;
//  end;

  result := true;
end;

procedure TfrmMovObleasVTV.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmMovObleasVTV.edCantidadExit(Sender: TObject);
begin
  if (edObleaInicial.text <> '') AND (edCantidad.Text <> '') then
  begin
    //fMovimiento.ValueByName[FIELD_OBLEAFINAL] := inttostr(strtoInt(edObleaInicial.Text)+strToInt(edCantidad.Text)-1);
    fMovimiento.FieldValues[FIELD_OBLEAFINAL] := inttostr(strtoInt(edObleaInicial.Text)+strToInt(edCantidad.Text)-1);
  end;
end;

procedure TfrmMovObleasVTV.btnCancelarClick(Sender: TObject);
begin
  fMovimiento.Cancel;
  fMovimiento.Append;
end;

procedure TfrmMovObleasVTV.lcbOrigenCloseUp(Sender: TObject);
begin
  lcbOrigen.Value := fOrigen.ValueByName[lcbOrigen.LookUpField];
end;

procedure TfrmMovObleasVTV.lcbDestinoCloseUp(Sender: TObject);
begin
  lcbDestino.Value := fPlanta.ValueByName[lcbDestino.LookUpField];
end;

procedure TfrmMovObleasVTV.lcbPreparaCloseUp(Sender: TObject);
begin
  //lcbPrepara.Value := fPrepara.ValueByName[lcbPrepara.LookupField];
  lcbPrepara.Value := fPrepara.FieldValues[lcbPrepara.LookupField];
end;

procedure TfrmMovObleasVTV.lcbAutorizaCloseUp(Sender: TObject);
begin
  //lcbAutoriza.Value := fAutoriza.ValueByName[lcbAutoriza.LookupField];
  lcbAutoriza.Value := fAutoriza.FieldValues[lcbAutoriza.LookupField];
end;

procedure TfrmMovObleasVTV.edCantCertifEnter(Sender: TObject);
begin
  //fMovimiento.ValueByName[FIELD_CANTCERTIF] := edCantidad.Text;
  fMovimiento.FieldValues[FIELD_CANTCERTIF] := edCantidad.Text;
end;

procedure TfrmMovObleasVTV.edCantBolsiEnter(Sender: TObject);
begin
  //fMovimiento.ValueByName[FIELD_CANTBOLSI] := edCantidad.Text;
  fMovimiento.FieldValues[FIELD_CANTBOLSI] := edCantidad.Text;
end;

function TfrmMovObleasVTV.CantidadIgualObleas: boolean;
begin
  result := false;
  with tSQLquery.Create(nil) do
    try
      SqlConnection:=mybd;
      sql.Add(format('SELECT COUNT(IDOBLEA) FROM VTV_OBLEAS WHERE ANO = %S AND NUMERO BETWEEN %S AND %S AND IDPLANTA = %S AND ESTADO = ''S''',[edAno.Text,edObleaInicial.Text,edObleaFinal.Text, fOrigen.ValueByName[FIELD_IDPLANTA]]));
      open;
      if Fields[0].AsInteger <> strtoint(edCantidad.text) then
      begin
        exit;
      end;
    finally
      free;
    end;
  result := true;
end;

procedure TfrmMovObleasVTV.edCertIniExit(Sender: TObject);
begin
  if (edCantCertif.text <> '') AND (edCertIni.Text <> '') then
  begin
    //fMovimiento.ValueByName[FIELD_CERTFINAL] := inttostr(strtoInt(edCertIni.Text)+strToInt(edCantCertif.Text)-1);
    fMovimiento.FieldValues[FIELD_CERTFINAL] := inttostr(strtoInt(edCertIni.Text)+strToInt(edCantCertif.Text)-1);
  end;
end;


function TfrmMovObleasVTV.ExisteCertificados: boolean;
begin
  result := false;
  with tSQLquery.Create(nil) do
    try
      SqlConnection := mybd;
      //sql.Add('SELECT count(*) FROM vtv_movimiento m  WHERE m.tipo = ''M''   AND cantcertif > 0 ');
      //sql.Add(format( 'AND ((certinicial BETWEEN %S AND %S ) OR (certfinal BETWEEN %S AND %S))',[edCertIni.Text,edCertFin.Text,edCertIni.Text,edCertFin.Text]));
      sql.Add('SELECT count(*) FROM infor_certif WHERE id = ''C''    ');
      sql.Add(format( 'AND NUMERO between %S AND %S ',[edCertIni.Text,edCertFin.Text]));
      open;
      if Fields[0].AsInteger <> strtoint(edCantidad.text) then
      begin
        exit;
      end;
    finally
      free;
    end;
  result := true;
end;


end.