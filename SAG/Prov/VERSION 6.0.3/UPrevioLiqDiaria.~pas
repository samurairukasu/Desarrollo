unit UPrevioLiqDiaria;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Mask, DBCtrls, ExtCtrls, StdCtrls, RXSpin, RXLookup,
  Buttons, USAGCLASSES, USAGESTACION, UCDBEdit, Grids, DBGrids, RXDBCtrl,
  ucdialgs, Utiloracle, ToolEdit, uutils, sqlexpr, Provider, DBClient;

type
  TFrmPrevioLiqDiaria = class(TForm)
    btnAceptargral: TBitBtn;
    brncancelar: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RxDBGrid1: TRxDBGrid;
    Label4: TLabel;
    Label12: TLabel;
    Bevel1: TBevel;
    btnAgregar: TBitBtn;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    eTransporteold: TColorDBEdit;
    eCambio: TColorDBEdit;
    eCtaCte: TColorDBEdit;
    eTotalDep: TColorDBEdit;
    srcDepositos: TDataSource;
    srcLiquida: TDataSource;
    srcbanco: TDataSource;
    srcmoneda: TDataSource;
    srcqdepositos: TDataSource;
    eTotalxarqche: TColorDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    eTOTALXARQ: TColorDBEdit;
    pdepo: TPanel;
    Label8: TLabel;
    edNroComp: TColorDBEdit;
    Label9: TLabel;
    cbmoneda: TRxDBLookupCombo;
    Label10: TLabel;
    cbbanco: TRxDBLookupCombo;
    Label11: TLabel;
    eImporte: TColorDBEdit;
    btnAceptar: TBitBtn;
    btnModificar: TBitBtn;
    btnEliminar: TBitBtn;
    edfechreca: TDBDateEdit;
    cbrecaud: TDBComboBox;
    Label7: TLabel;
    eTransporte: TEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAceptargralClick(Sender: TObject);
    procedure eTotalDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnAgregarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure cbmonedaCloseUp(Sender: TObject);
    procedure cbbancoCloseUp(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure cbrecaudChange(Sender: TObject);
    procedure cbrecaudKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fSumaryLD : tSumaryLD;
    fechini, fechfin,
    aUsuario  : string;
    fBancos : TBancos_Deposito;
    fDepositos : TDepositos_liq;
    fMoneda : TMonedas;
    qdepositos, qtotaldepositos: TClientDataSet;
    sdsqdepositos, sdsqtotaldepositos : TSQLDataSet;
    dspqdepositos, dspqtotaldepositos : TDataSetProvider;
    procedure CargaDatos;
    function ValidatePost:boolean;
    function ValidateTotal:boolean;
  public
    { Public declarations }
    fLiquidacion : tliquidacion;
    constructor CreateByFecha(AOwner : TComponent; dateini,datefin, usuario:string );
    property SumaryLD : tSumaryLD read fSumaryLD;
  end;

var
  FrmPrevioLiqDiaria: TFrmPrevioLiqDiaria;

implementation

{$R *.DFM}

uses
        GLOBALS;

constructor TFrmPrevioLiqDiaria.CreateByFecha(AOwner : TComponent; dateini,datefin, usuario:string );
begin
  inherited create(AOwner);
  fechini := dateini;
  fechfin := datefin;
  aUsuario := usuario;
 with TSQLQuery.create(application) do
    try
      SQLConnection := mybd;
      sql.add(format('SELECT COUNT(*) FROM TSERVUSR WHERE IDSERVICIO = 111 and idusuario =%S',[inttostr(GLOBALS.ID_USUARIO_LOGEO_SAG)]));

      open;
      if ((fields[0].asinteger) > 0)then
             eTransporte.Enabled:=True
        else
             eTransporte.Enabled:=False;

    finally
      free;
    end;


  CargaDatos;
end;

procedure TFrmPrevioLiqDiaria.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0;
        end;

end;

procedure TFrmPrevioLiqDiaria.FormCreate(Sender: TObject);
begin

        with fSumaryLD do
        begin
            iTransporte := '0';
            iCambioRec := '0';
            iCobranzasCtaCte := '0';
            iTotalDep := '0';
            iTotalCaja := '0';
            iTotalXArqueo := '0';
            iTotalXArqueoChe := '0';
            iDiferencia := '0';
        end;

    fBancos := nil;
    fDepositos := nil;
    fLiquidacion := nil;
    fMoneda := nil;
    qdepositos := nil;

end;

procedure TFrmPrevioLiqDiaria.FormDestroy(Sender: TObject);
begin
        fBancos.Free;
        fDepositos.free;
        fLiquidacion.free;
        fMoneda.free;
end;

procedure TFrmPrevioLiqDiaria.btnAceptargralClick(Sender: TObject);
begin
    if ValidateTotal then
    begin
      with fSumaryLD do
      begin

            iTransporte := eTransporte.Text;
            iCambioRec:= eCambio.Text;
            iCobranzasCtaCte:= eCtaCte.Text;
            iTotalDep := eTotalDep.Text;
            iTotalXArqueo:= eTOTALXARQ.Text;
            iTotalXArqueoChe:= eTotalxarqche.Text;

      end;
      if fLiquidacion.DataSet.State in  [dsinsert, dsedit] then
      begin
        if fLiquidacion.DataSet.State in [dsinsert] then
        begin
            fliquidacion.ValueByName[FIELD_IDUSUARIO] := ausuario;
            fLiquidacion.ValueByName[FIELD_FECHA] := fechini;
        end;
        if fLiquidacion.DataSet.State in [dsedit] then
        begin
            fLiquidacion.ValueByName[FIELD_FECHMODI] := DateTimeBD(MyBD);
        end;
        fliquidacion.ValueByName[FIELD_TRANSPORTE]   := eTransporte.Text;
        fLiquidacion.Post(true);
      end;
    end;

end;

procedure TFrmPrevioLiqDiaria.eTotalDepKeyPress(Sender: TObject;
  var Key: Char);
begin
    if not (Key in ['0','1','2','3','4','5','6','7','8','9',#37,#39,#46,#8,','])
    then key := #0
end;

procedure TFrmPrevioLiqDiaria.CargaDatos;
var
  aRowid : string;
  fSQL : TStringList;
begin
        fLiquidacion := Tliquidacion.createbyfechaMax(mybd,aUsuario,fechini);
        fLiquidacion.Open;
        if  (fLiquidacion.RecordCount > 0)
          then  etransporte.Text :=  floattostrf((strtofloat(fLiquidacion.ValueByName[FIELD_TOTALXARQ])+strtofloat(fLiquidacion.ValueByName[FIELD_TOTALXARQCHE])),fffixed,8,2)
          ELSE etransporte.Text :='0';
          //floattostrf(strtofloat(fLiquidacion.ValueByName[FIELD_TOTALXARQ]),fffixed,8,2);

        fLiquidacion.close;

        fLiquidacion := Tliquidacion.createbyfecha(mybd,fechini,fechfin,aUsuario);
        fLiquidacion.Open;
        if not (fLiquidacion.RecordCount > 0) then
        begin
          fLiquidacion.Close;
          fLiquidacion := TLiquidacion.CreateByRowId(mybd,'');
          fLiquidacion.Open;
          fLiquidacion.Append;
        end
        else
        begin
          etransporte.Text :=fLiquidacion.ValueByName[FIELD_TRANSPORTE];
          aRowid := fLiquidacion.ValueByName[FIELD_ROWID];
          fLiquidacion.Close;
          fLiquidacion := TLiquidacion.CreateByRowId(mybd,arowid);
          fLiquidacion.Open;
          fLiquidacion.Edit;
        end;

        if fLiquidacion.DataSet.State = dsinsert then
          with fSumaryLD do
          begin
              if  etransporte.Text ='' then
               fLiquidacion.ValueByName[FIELD_TRANSPORTE] := iTransporte
              else

               fLiquidacion.ValueByName[FIELD_TRANSPORTE]:=etransporte.Text ;
              fLiquidacion.ValueByName[FIELD_CAMBIO]:=iCambioRec;
              fLiquidacion.ValueByName[FIELD_COBCTACTE]:=iCobranzasCtaCte;
              fLiquidacion.ValueByName[FIELD_TOTALXARQ]:=iTotalXArqueo;
              fLiquidacion.ValueByName[FIELD_TOTALXARQCHE]:=iTotalXArqueoChe;
          end;

        fDepositos := TDepositos_liq.CreateByLiquidacion(mybd,fLiquidacion.ValueByName[FIELD_CODLIQUIDACION]);
        fBancos := TBancos_Deposito.Create(mybd);
        fBancos.Open;
        fMoneda := TMonedas.Create(mybd);
        fMoneda.Open;


        sdsqdepositos := TSQLDataSet.Create(self);
        sdsqdepositos.SQLConnection := MyBD;
        sdsqdepositos.CommandType := ctQuery;
        sdsqdepositos.GetMetadata := false;
        sdsqdepositos.NoMetadata := true;
        sdsqdepositos.ParamCheck := false;

        dspqdepositos := TDataSetProvider.Create(self);
        dspqdepositos.DataSet := sdsqdepositos;
        dspqdepositos.Options := [poIncFieldProps,poAllowCommandText];
        qdepositos := TClientDataSet.Create(self);

        fSQL:= TStringList.Create;

        with qdepositos do
        begin
             SetProvider(dspqdepositos);
             fsql.Add('select d.ROWID, CODLIQUIDACION, nrocomprob, m.nombre moneda, b.nombre banco, imponeto, DEPORECA, FECHRECA from depositos_liq d, ');
             fSQL.ADD('tmonedas m, bancos_deposito b ');
             fsql.add('WHERE D.CODBANCO = B.CODBANCO AND D.CODMONEDA = M.CODMONEDA ');
             fsql.add(format('and (FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS''))',[fechini,fechfin]));
             fsql.add(format('and idusuario = %s',[aUsuario]));
             CommandText := fSQL.Text;
             open;
        end;

        sdsqtotaldepositos := TSQLDataSet.Create(self);
        sdsqtotaldepositos.SQLConnection := MyBD;
        sdsqtotaldepositos.CommandType := ctQuery;
        sdsqtotaldepositos.GetMetadata := false;
        sdsqtotaldepositos.NoMetadata := true;
        sdsqtotaldepositos.ParamCheck := false;

        dspqtotaldepositos := TDataSetProvider.Create(self);
        dspqtotaldepositos.DataSet := sdsqtotaldepositos;
        dspqtotaldepositos.Options := [poIncFieldProps,poAllowCommandText];
        qtotaldepositos := TClientDataSet.Create(self);
        with qtotaldepositos do
        begin
             SetProvider(dspqtotaldepositos);
             fSQL.Clear;
             fsql.Add('select sum(imponeto) from depositos_liq  ');
             fsql.add(format('where (FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) AND (FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS''))',[fechini,fechfin]));
             fsql.add(format('and idusuario = %s',[aUsuario]));
             CommandText := fSQL.Text;
             open;
             eTotalDep.Text := fields[0].asstring;
        end;

        srcqdepositos.DataSet := qdepositos;
        srcDepositos.DataSet := fDepositos.DataSet;
        srcLiquida.DataSet := fLiquidacion.DataSet;
        srcbanco.DataSet := fBancos.DataSet;
        srcmoneda.DataSet := fMoneda.dataset;

end;


procedure TFrmPrevioLiqDiaria.btnAgregarClick(Sender: TObject);
begin
  if fDepositos.DataSet.State in [dsinsert,dsedit] then fDepositos.cancel;
  fDepositos.Close;
  fDepositos := TDepositos_liq.CreateByRowId(MyBD,'');
  fDepositos.Open;
  srcDepositos.DataSet := fDepositos.DataSet;

  pdepo.Visible := true;
  fDepositos.Append;
  edNroComp.SetFocus;
//  fDepositos.Close;
end;

procedure TFrmPrevioLiqDiaria.btnAceptarClick(Sender: TObject);
var aCodliq : string;
begin
  if fLiquidacion.DataSet.State in [dsinsert,dsedit] then
  begin
    if fLiquidacion.DataSet.State = dsedit then
       fLiquidacion.valuebyname[FIELD_FECHMODI] := DateTimeBD(mybd);
    if fLiquidacion.DataSet.State = dsinsert then
    begin
      fliquidacion.ValueByName[FIELD_IDUSUARIO] := ausuario;
      fLiquidacion.ValueByName[FIELD_FECHA] := fechini;
    end;


    fLiquidacion.Post(true);
    aCodliq := fLiquidacion.ValueByName[FIELD_CODLIQUIDACION];

    fLiquidacion.Close;
    fLiquidacion := TLiquidacion.CreateByCodigo(mybd,aCodliq);
    fLiquidacion.Open;
    srcLiquida.DataSet := fLiquidacion.DataSet;

    fLiquidacion.Edit;
  end;
  if ValidatePost then
  begin
    fDepositos.ValueByName[FIELD_FECHA] := fechini;
    fDepositos.ValueByName[FIELD_IDUSUARIO] := ausuario;
    fDepositos.ValueByName[FIELD_CODLIQUIDACION] := fLiquidacion.ValueByName[FIELD_CODLIQUIDACION];
    if fDepositos.DataSet.State = dsedit then
      fDepositos.ValueByName[FIELD_FECHMODI] := DateTimeBD(mybd);
    fDepositos.Post(true);
    qdepositos.close;
    qdepositos.SetProvider(dspqdepositos);
    qdepositos.open;
    pdepo.Visible := false;
    qtotaldepositos.close;
    qtotaldepositos.SetProvider(dspqtotaldepositos);
    qtotaldepositos.Open;
    eTotalDep.Text := qtotaldepositos.Fields[0].asstring;
  end;

end;

function TFrmPrevioLiqDiaria.ValidatePost:boolean;
begin
  result := false;
  if edNroComp.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el Nº de Comprobante', mtInformation, [mbOk],mbOk,0);
       edNroComp.SetFocus;
       exit;
  end;
  if cbmoneda.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el Tipo de Moneda', mtInformation, [mbOk],mbOk,0);
       cbmoneda.SetFocus;
       exit;
  end;
  if cbbanco.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el Banco', mtInformation, [mbOk],mbOk,0);
       cbbanco.SetFocus;
       exit;
  end;
  if cbrecaud.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese si el depósito fue retirado por la Recaudadora', mtInformation, [mbOk],mbOk,0);
       cbrecaud.SetFocus;
       exit;
  end;
  if (edfechreca.visible) and (edfechreca.Date = 0) then
  begin
       MessageDlg (Application.Title, 'Ingrese la fecha que el depósito fue retirado por la Recaudadora', mtInformation, [mbOk],mbOk,0);
       edfechreca.SetFocus;
       exit;
  end;


  if eImporte.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el Importe del depósito', mtInformation, [mbOk],mbOk,0);
       eImporte.SetFocus;
       exit;
  end;
  if (qdepositos.Locate(FIELD_NROCOMPROB,strtoint(edNroComp.text),[])) and ((fDepositos.valuebyname[FIELD_NROCOMPROB] = qdepositos.FieldByName(FIELD_NROCOMPROB).asstring) AND (fDepositos.valuebyname[FIELD_ROWID] <> qdepositos.FieldByName(FIELD_ROWID).asstring) ) then
  begin
       MessageDlg (Application.Title, 'El Nº de comprobante ya existe', mtInformation, [mbOk],mbOk,0);
       edNroComp.SetFocus;
       exit;
  end;

  result := true;
end;

function TFrmPrevioLiqDiaria.ValidateTotal:boolean;
begin
  result := false;
  if eTransporte.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el importe del transporte', mtInformation, [mbOk],mbOk,0);
       eTransporte.SetFocus;
       exit;
  end;
  if eCambio.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el importe del cambio', mtInformation, [mbOk],mbOk,0);
       eCambio.SetFocus;
       exit;
  end;
  if eCtaCte.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el importe de cobranzas de cta. cte.', mtInformation, [mbOk],mbOk,0);
       eCtaCte.SetFocus;
       exit;
  end;
  if eTOTALXARQ.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el importe del total del arqueo Contado', mtInformation, [mbOk],mbOk,0);
       eTOTALXARQ.SetFocus;
       exit;
  end;
  if eTotalxarqche.Text = '' then
  begin
       MessageDlg (Application.Title, 'Ingrese el importe del total del arqueo Cheques', mtInformation, [mbOk],mbOk,0);
       eTotalxarqche.SetFocus;
       exit;
  end;

  result := true;
end;

procedure TFrmPrevioLiqDiaria.cbmonedaCloseUp(Sender: TObject);
begin
        cbmoneda.Value := fMoneda.ValueByName[cbmoneda.LookUpField];
end;

procedure TFrmPrevioLiqDiaria.cbbancoCloseUp(Sender: TObject);
begin
        cbbanco.Value := fBancos.ValueByName[cbbanco.LookUpField];
end;

procedure TFrmPrevioLiqDiaria.btnModificarClick(Sender: TObject);
begin
  if fDepositos.DataSet.State in [dsinsert,dsedit] then fDepositos.cancel;
  fDepositos.close;

  fDepositos := TDepositos_liq.CreateByLiquidacionNro(mybd,qdepositos.fieldbyname(FIELD_CODLIQUIDACION).asstring,qdepositos.fieldbyname(FIELD_NROCOMPROB).asstring);
  fDepositos.Open;
  srcDepositos.DataSet := fDepositos.DataSet;
  if fDepositos.recordcount > 0 then
  begin
    pdepo.Visible := true;
    fDepositos.edit;
    edNroComp.SetFocus;
  end;
end;

procedure TFrmPrevioLiqDiaria.btnEliminarClick(Sender: TObject);
begin
  if fDepositos.DataSet.State in [dsinsert,dsedit] then fDepositos.cancel;
  fDepositos.close;

  fDepositos := TDepositos_liq.CreateByLiquidacionNro(mybd,qdepositos.fieldbyname(FIELD_CODLIQUIDACION).asstring,qdepositos.fieldbyname(FIELD_NROCOMPROB).asstring);
  fDepositos.Open;
  srcDepositos.DataSet := fDepositos.DataSet;
  if fDepositos.recordcount > 0 then
  begin
    fDepositos.dataset.delete;
    fDepositos.DataSet.ApplyUpdates(0);
    qdepositos.close;
    qdepositos.SetProvider(dspqdepositos);
    qdepositos.open;
    qtotaldepositos.close;
    qtotaldepositos.SetProvider(dspqtotaldepositos);
    qtotaldepositos.Open;
    eTotalDep.Text := qtotaldepositos.Fields[0].asstring;    
  end;
end;

procedure TFrmPrevioLiqDiaria.cbrecaudChange(Sender: TObject);
begin
  (sender as tdbcombobox).TEXT:=UPPERCASE((sender as tdbcombobox).TEXT);
  mostrarcomponentes(copy(cbrecaud.Text,1,1) = 'S',self,[9]);
end;

procedure TFrmPrevioLiqDiaria.cbrecaudKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['S','N','s','n'])
        then key := #0
end;

end.


