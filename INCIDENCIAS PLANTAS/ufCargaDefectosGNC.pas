unit ufCargaDefectosGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, USagClasses,
  Globals, StdCtrls, Buttons, Db, RXLookup, uSagEstacion, ucDialgs, SQLExpr,
  Grids, DBGrids, ExtCtrls, variants, provider, dbclient;

type
  TfrmCargaDefectosGNC = class(TForm)
    btnAceptar: TBitBtn;
    dbcbDefectos: TRxDBLookupCombo;
    srcDefectos: TDataSource;
    srcInspDef: TDataSource;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    btnEliminar: TBitBtn;
    btnAgregar: TBitBtn;
    Label2: TLabel;
    Bevel1: TBevel;
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
  private
    { Private declarations }
    finspGNC : TinspGNC;
    fInspgncDefectos : TInspGNC_Defectos;
    fDefectos : TDefectosGNC;
    fInspecciones : TEstadoInspGNC;
    aq: TSQLDataSet;
    dsp : tDatasetprovider;
    qDefectosInsp : tClientDataSet;
  public
    { Public declarations }
    constructor CreateFromBD (const aInspGNC: TInspGNC; var aEstadoInsp : TEstadoInspGNC);
    function SoloCargar: boolean;
    function ExisteDefecto : boolean;
  end;

var
  frmCargaDefectosGNC: TfrmCargaDefectosGNC;

implementation

uses
  uLogs;

{$R *.DFM}

resourcestring
    FICHERO_ACTUAL = 'ufRechazarGNC.pas';

constructor TfrmCargaDefectosGNC.CreateFromBD (const aInspGNC: TInspGNC; var aEstadoInsp : TEstadoInspGNC);
begin
    inherited Create(Application);
    fInspgncDefectos := nil;
    fInspGNC := aInspGNC;
    fInspGNC.open;
    fInspgncDefectos := TInspGNC_Defectos.CreateFromInspeccion(MyBD,fInspGNC.ValueByName[FIELD_EJERCICI],fInspGNC.ValueByName[FIELD_CODINSPGNC]);
    fInspgncDefectos.Open;
    srcInspDef.DataSet := fInspgncDefectos.DataSet;
    fDefectos := TDefectosGNC.CreateSAG(MyBD);
    fDefectos.Open;
    srcDefectos.DataSet := fDefectos.DataSet;
    fInspecciones := aEstadoInsp;
    fInspecciones.Open;

    try


    aQ := TSQLDataSet.Create(self);
    aQ.SQLConnection := MyBD;
    aQ.CommandType := ctQuery;
    aQ.GetMetadata := false;
    aQ.NoMetadata := true;
    aQ.ParamCheck := false;


    dsp := TDataSetProvider.Create(self);
    dsp.DataSet := aQ;
    dsp.Options := [poIncFieldProps,poAllowCommandText];

    qDefectosInsp:=TClientDataSet.Create(self);

    with qDefectosInsp do
    begin
      SetProvider(dsp);
      CommandText:='SELECT EJERCICI, CODINSPGNC, I.CODDEFEC, DESCRIPCION FROM INSPGNC_DEFECTOS I, DEFECTOSGNC D '+
      format('WHERE I.EJERCICI = %s AND I.CODINSPGNC = %s',[fInspGNC.ValueByName[FIELD_EJERCICI],fInspGNC.ValueByName[FIELD_CODINSPGNC] ])+
      'AND I.CODDEFEC = D.CODDEFEC AND DEFLINEA = ''N''';
      open;
    end;
    except
                on E: Exception do
                begin
                     fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Error al intentar rechazar una Inspeccion GNC por: ' + E.message);
                end;
    end;
    DataSource1.DataSet := qDefectosInsp;

end;

function TfrmCargaDefectosGNC.SoloCargar: boolean;
begin
    try
        result := FALSE;
        if ShowModal = mrOk
        then begin
            try
              if (fInspgncDefectos.DataSet.State in [dsinsert, dsedit]) then
                fInspgncDefectos.post(true);
              MyBD.Commit(td);
              result := TRUE;
            except
                on E: Exception do
                begin
                     fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Error al intentar rechazar una Inspeccion GNC por: ' + E.message);
                end;
            end;
        end
        else
        begin
              fInspgncDefectos.cancel;
        end;
    except
        result := FALSE;
    end;
end;

procedure TfrmCargaDefectosGNC.FormDestroy(Sender: TObject);
begin
     fInspgncDefectos.free;
     fDefectos.free;
end;

procedure TfrmCargaDefectosGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(Vk_Return) then begin
     key := #0;
     perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TfrmCargaDefectosGNC.btnAceptarClick(Sender: TObject);
begin
  if (fInspgncDefectos.DataSet.State in [dsinsert,dsedit]) then
    if dbcbDefectos.Text = '' then
    begin
      MessageDlg (Application.Title, 'Se debe ingresar el motivo del rechazo', mtInformation, [mbOk],mbOk,0);
      dbcbDefectos.SetFocus;
      exit;
    end;
      ModalResult := mrOK;
end;

procedure TfrmCargaDefectosGNC.btnEliminarClick(Sender: TObject);
begin
   if fInspgncDefectos.DataSet.State in [dsinsert,dsedit] then
     fInspgncDefectos.cancel;
   if fInspgncDefectos.Locate('EJERCICI;CODINSPGNC;CODDEFEC',VarArrayOf([qDefectosInsp.fieldbyname(FIELD_EJERCICI).value,qDefectosInsp.fieldbyname(FIELD_CODINSPGNC).value,qDefectosInsp.fieldbyname(FIELD_CODDEFEC).value]),[]) then
   begin
     fInspgncDefectos.DataSet.Delete;
     fInspgncDefectos.DataSet.ApplyUpdates(-1);
     qDefectosInsp.close;
     qDefectosInsp.SetProvider(dsp);
     qDefectosInsp.open;
   end;
end;

procedure TfrmCargaDefectosGNC.btnAgregarClick(Sender: TObject);
begin
  if not ExisteDefecto  then
  begin
    fInspgncDefectos.Append;
    fInspgncDefectos.ValueByName[FIELD_EJERCICI] := fInspGNC.ValueByName[FIELD_EJERCICI];
    fInspgncDefectos.ValueByName[FIELD_CODINSPGNC] := fInspGNC.ValueByName[FIELD_CODINSPGNC];
    fInspgncDefectos.ValueByName[FIELD_CODDEFEC] := fDefectos.ValueByName[FIELD_CODDEFEC];
    fInspgncDefectos.Post(true);
    qDefectosInsp.close;
    qDefectosInsp.SetProvider(dsp);
    qDefectosInsp.open;
  end;
end;

function TfrmCargaDefectosGNC.ExisteDefecto : boolean;
var
    aq: TSQLDataSet;
    dsp : tDatasetprovider;
begin
  result := false;
  aQ := TSQLDataSet.Create(self);
  aQ.SQLConnection := MyBD;
  aQ.CommandType := ctQuery;
  aQ.GetMetadata := false;
  aQ.NoMetadata := true;
  aQ.ParamCheck := false;

  dsp := TDataSetProvider.Create(self);
  dsp.DataSet := aQ;
  dsp.Options := [poIncFieldProps,poAllowCommandText];

  with TClientDataSet.create(self) do
    try
      SetProvider(dsp);

      CommandText:=(format('SELECT * FROM INSPGNC_DEFECTOS WHERE EJERCICI = %S AND CODINSPGNC = %S AND CODDEFEC = %S',[fInspGNC.ValueByName[FIELD_EJERCICI],fInspGNC.ValueByName[FIELD_CODINSPGNC],fDefectos.ValueByName[FIELD_CODDEFEC]]));
      open;
      if recordcount > 0 then
        result := true;
    finally
      free;
      dsp.Free;
      aq.Free;
    end;
end;

end.
