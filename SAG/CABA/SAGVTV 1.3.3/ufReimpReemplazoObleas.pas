unit ufReimpReemplazoObleas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, usagclasses, Buttons, usagdata, globals, SqlExpr, usagestacion,
  ExtCtrls, ucdialgs, UCEdit;

type
  TfrmReimpReemplazoObleas = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Imprimir: TBitBtn;
    Salir: TBitBtn;
    edAno: TColorEdit;
    edNroinspec: TColorEdit;
    procedure SalirClick(Sender: TObject);
    procedure ImprimirClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edanoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    tipo : char;
    function DatosCompletos : boolean;
    procedure DoReimpReemplazoObleas;
    procedure DoReimpDecJuradas;
  public
    { Public declarations }
  end;
  procedure DoReimpresiones(aTipo: char);

var
  frmReimpReemplazoObleas: TfrmReimpReemplazoObleas;

implementation

{$R *.DFM}

uses
  ufReemplazoObleaToPrint, ufDeclaracionJurada;


procedure DoReimpresiones(aTipo: char);
begin
  with TfrmReimpReemplazoObleas.Create(application) do
    try
      tipo := atipo;
      if tipo = REIMP_REEMP_OBLEAS then
        caption := 'Reimpresión de Reemplazo de Obleas'
      else
        caption := 'Reimpresión de Declaraciones Juradas';
      showmodal;
    finally
      free;
    end;
end;

procedure TfrmReimpReemplazoObleas.SalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmReimpReemplazoObleas.ImprimirClick(Sender: TObject);
begin
  if DatosCompletos then
    if tipo = REIMP_REEMP_OBLEAS then
      DoReimpReemplazoObleas
    else
      DoReimpDecJuradas;
end;

procedure TfrmReimpReemplazoObleas.DoReimpReemplazoObleas;
var avehiculo: tvehiculo;
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
    if ainspe.RecordCount <> 1 then
    begin
      messagedlg(caption,'No existe un reemplazo de obleas para esta inspección',mtError,[mbOK],mbOK,0);
      exit;
    end;

    avehiculo := ainspe.GetVehiculo;
    avehiculo.open;
    acliente := ainspe.GetPropietario;
    acliente.open;
    aModelo := aVehiculo.getmodelo;
    aModelo.open;
    with tfrmReemplazoObleaToPrint.Create(application) do
      try
        qrlzona.Caption := inttostr(fvarios.zona);
        qrlPlanta.caption := inttostr(fvarios.CodeEstacion);

        with tSqlquery.create(self) do
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

        with tSqlquery.create(self) do
          try
            SQLConnection:=mybd;
            sql.Add(FORMAT('SELECT OBLEAANT, OBLEANUEV, TO_CHAR(FECHA,''DD/MM/YYYY'') FROM T_ERVTV_INUTILIZ WHERE CODINSPE = %S AND TO_CHAR(FECHA,''YYYY'') = ''%S''',[edNroinspec.text,edano.TEXT]));
            open;
            qrlAnterior.caption := fields[0].asstring;
            qrlEntregada.caption := fields[1].asstring;
            qrlfecha.caption := fields[2].asstring;
            close;
          finally
            free;
          end;
        qrltitular.caption := acliente.valuebyname[FIELD_APELLIDOS_Y_NOMBRE];
        qrldocumento.caption := acliente.valuebyname[FIELD_TIPODOCU]+' '+acliente.ValueByName[FIELD_DOCUMENT];
        qrlinforme.Caption := ainspe.Informe;

        repReemplazo.prepare;
        repReemplazo.preview;
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

procedure TfrmReimpReemplazoObleas.DoReimpDecJuradas;
begin
          with TDecJurada.CreateByCodigo(MyBD,edAno.text,edNroinspec.text) do
          try
            open;
            if recordcount <= 0 then
            begin
              messagedlg(caption,'No existe una Declaración Jurada para esta inspección',mtError,[mbOK],mbOK,0);
              exit;
            end;
          finally
            free;
          end;

  DoDeclaracionJurada(edano.text,ednroinspec.text,DJ_REIMPRESION);
end;

procedure TfrmReimpReemplazoObleas.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmReimpReemplazoObleas.edanoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',char(VK_BACK)])
        then key := #0
end;

function TfrmReimpReemplazoObleas.DatosCompletos : boolean;
begin
  result := false;
  if edano.text = '' then
  begin
      messagedlg(caption,'Ingrese el año de la inspección',mtError,[mbOK],mbOK,0);
      edano.setfocus;
      exit;
  end;
  result := false;
  if edNroinspec.text = '' then
  begin
      messagedlg(caption,'Ingrese el número de la inspección',mtError,[mbOK],mbOK,0);
      edNroinspec.setfocus;
      exit;
  end;
  result := true;
end;

end.
