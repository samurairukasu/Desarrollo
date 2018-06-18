unit ufpagoSociosAca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, RXDBCtrl, StdCtrls, Buttons, globals, usagestacion,
  Db, usagclasses, ExtCtrls, Mask, DBCtrls, UCDBEdit, ucdialgs,sqlexpr, Provider, DBClient;

type
  TfrmPagoSociosAca = class(TForm)
    RxDBGrid1: TRxDBGrid;
    btnSalir: TBitBtn;
    srcFacturas: TDataSource;
    btnModificar: TBitBtn;
    Panel1: TPanel;
    ColorDBEdit1: TColorDBEdit;
    edImporte: TColorDBEdit;
    CBEsDeCredito: TComboBox;
    Label1: TLabel;
    Importe: TLabel;
    Label2: TLabel;
    btnAceptar: TBitBtn;
    srcSocios: TDataSource;
    btnGrabar: TBitBtn;
    btncancelar: TBitBtn;
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btncancelarClick(Sender: TObject);
  private
    { Private declarations }
    qFacturasACA: TClientDataSet;
    sdsqFacturasACA : TSQLDataSet;
    dspqFacturasACA : TDataSetProvider;
    fSocios : TSocios_Acavtv;
    Procedure DoSociosAca;
  public
    { Public declarations }
    dateini,datefin, aTipoCliente: string;
  end;

  Procedure GenerateSociosAca;


var
  frmPagoSociosAca: TfrmPagoSociosAca;

implementation

{$R *.DFM}
uses
  ugetdates, UFPorTipo, uftmp, ulogs, uutils;

resourcestring
   FICHERO_ACTUAL = 'ufPagoSociosAca';
   TIPO_ARQUEO_CAJEROS = 'C';

procedure GenerateSociosAca;
begin
  with TfrmPagoSociosAca.Create(application) do
    try
      try
        if not getdates(dateini,datefin) then exit;
        If not PorTipo(TIPO_ARQUEO_CAJEROS, aTipoCliente,'','') then Exit;

        MyBD.StartTransaction(td);

        with tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,format('WHERE IDUSUARIO = %S',[aTipoCliente])) do
             try
                open;
                Caption := Format('Inscripciones al ACA.  (%S - %S) - Cajero: %S ', [copy(DateIni,1,10), Copy(DateFin,1,10),ValueByName[FIELD_NOMBRE]]);
                close;
             finally
                free
             end;

        FTmp.Temporizar(TRUE,FALSE,'Inscripciones al ACA', 'Generando el informe Inscripciones al ACA.');
        Application.ProcessMessages;

        application.ProcessMessages;
        DoSociosAca;
        FTmp.Temporizar(FALSE,FALSE,'', '');
        showmodal;
      except
         on E: Exception do
         begin
            FTmp.Temporizar(FALSE,FALSE,'', '');
            Application.ProcessMessages;
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Informe Cancelado por: %s', [E.message]);
            MessageDlg('Generación de Informes.', 'El informe no puede generarse en este instante: ' + E.message + #10 + #13 + 'Espere unos minutos, e intentelo de nuevo', mtError, [mbOk], mbOk, 0)
         end
      end;

    finally
      free;
      application.ProcessMessages;
    end;
end;

Procedure TfrmPagoSociosAca.DoSociosAca;
var
  fFacAca_aux : tSocios_acavtv;
  fSQL : TStringList;
begin
  fSQL := TStringList.Create;
  with qfacturasaca do
  begin
    fsql.Add('SELECT NROCUPON, F.CODFACTU, F.FECHALTA ');
    fSQL.ADD('FROM TFACTURAS F, TDATOS_PROMOCIONES D, TFACT_ADICION A WHERE ');
    fsql.add(format('(F.FECHALTA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) ',[dateini]));
    fsql.add(format('AND (F.FECHALTA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) ',[datefin]));
    fsql.add('AND F.CODFACTU = D.CODFACTU AND TIPOFAC = ''F'' AND A.CODFACT = F.CODFACTU ');
    fsql.add(format('AND F.ERROR = ''N'' AND F.IMPRESA = ''S'' AND CODCOFAC IS NULL AND A.IDUSUARI = %s AND A.CODDESCU = 4 ',[aTipoCliente]));
    CommandText := fSQL.Text;
    open;
    if recordcount > 0 then
    begin
      first;
      while not eof do
      begin
        try
          ffacAca_aux := TSocios_Acavtv.CreateByFactura_u(mybd,fieldbyname(FIELD_CODFACTU).asstring,aTipoCliente);
          fFacAca_aux.Open;
          if fFacAca_aux.RecordCount > 0 then
          begin
          end
          else
          begin
            fFacAca_aux.Append;
            fFacAca_aux.ValueByName[FIELD_FECHA] := fieldbyname(FIELD_FECHALTA).ASSTRING;
            fFacAca_aux.ValueByName[FIELD_CODFACTU] := fieldbyname(FIELD_CODFACTU).ASSTRING;
            fFacAca_aux.ValueByName[FIELD_NROCUPON ] := fieldbyname(FIELD_NROCUPON).ASSTRING;
            fFacAca_aux.ValueByName[FIELD_IDUSUARIO] := aTipoCliente;
            fFacAca_aux.Post(true);
          end;
        finally
           fFacAca_aux.close;
           fFacAca_aux.free;
        end;
        next;
      end;
    end;
    close;
    SetProvider(dspqFacturasACA);
    fsql.Clear;
    fsql.Add('SELECT U.TIPFACTU||'' ''|| LTRIM(PtoVent) || ''-'' || LTRIM(TO_CHAR(NUMFACTU,''00000000'')) NROFAC, ');
    fsql.add('substr(NombreYApellidos(CODCLPRO),1,110) nombre, NROCUPON, F.CODFACTU, substr(Devuelve_Patente(CODINSPE, EJERCICI),1,10) PATENTE, ');
    fsql.add('TOTALACA, DECODE(F.FORMPAGO,''M'',''CONTADO'',''H'',''CHEQUE'','''') FORMPAGO');
    fSQL.ADD('FROM SOCIOS_ACAVTV F, TFACT_ADICION A, TINSPECCION I, TFACTURAS U WHERE ');
    fsql.add(format('(F.FECHA >= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) ',[dateini]));
    fsql.add(format('AND (F.FECHA <= TO_DATE(''%s'', ''DD/MM/YYYY HH24:MI:SS'')) ',[datefin]));
    fsql.add(format('AND F.CODFACTU = A.CODFACT AND TIPOFAC = ''F'' AND F.IDUSUARIO = %S ',[aTipoCliente]));
    fsql.add('AND I.CODFACTU = F.CODFACTU AND F.CODFACTU = U.CODFACTU AND CODCOFAC IS NULL');
    CommandText := fSQL.Text;
    open;
  end;
  srcFacturas.DataSet := qFacturasACA;
end;

procedure TfrmPagoSociosAca.btnSalirClick(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  close;
end;

procedure TfrmPagoSociosAca.FormCreate(Sender: TObject);
begin
  fSocios := nil;

  sdsqFacturasACA := TSQLDataSet.Create(self);
  sdsqFacturasACA.SQLConnection := MyBD;
  sdsqFacturasACA.CommandType := ctQuery;
  sdsqFacturasACA.GetMetadata := false;
  sdsqFacturasACA.NoMetadata := true;
  sdsqFacturasACA.ParamCheck := false;

  dspqFacturasACA := TDataSetProvider.Create(self);
  dspqFacturasACA.DataSet := sdsqFacturasACA;
  dspqFacturasACA.Options := [poIncFieldProps,poAllowCommandText];
  qFacturasACA := TClientDataSet.Create(self);
  with qFacturasACA do
  begin
    SetProvider(dspqFacturasACA);
  end;
  with tSQLquery.Create(self) do
    try
      SQLConnection := MyBD;
      sql.add('ALTER SESSION SET NLS_DATE_FORMAT = ''DD/MM/YYYY HH24:MI:SS''');
      ExecSQL;
    finally
      free;
    end;


end;

procedure TfrmPagoSociosAca.FormDestroy(Sender: TObject);
begin
  if mybd.InTransaction then MyBD.Rollback(TD);
  qFacturasACA.free;
  dspqFacturasACA.Free;
  sdsqFacturasACA.Free;
  fSocios.free;
end;

procedure TfrmPagoSociosAca.btnModificarClick(Sender: TObject);
begin
  if Assigned(fsocios) then fsocios.Close;
  if qFacturasACA.RecordCount > 0 then
  begin
    fSocios := TSocios_Acavtv.CreateByFactura_u(mybd,qfacturasaca.fieldbyname(FIELD_CODFACTU).asstring,aTipoCliente);
    fSocios.Open;
    fSocios.Edit;
    srcSocios.DataSet := fSocios.DataSet;
    if (fSocios.ValueByName[FIELD_FORMPAGO] = 'M') then
    begin
            CBEsDeCredito.ItemIndex := 0;
    end
    else if (fSocios.ValueByName[FIELD_FORMPAGO] = 'H') then
    begin
            CBEsDeCredito.ItemIndex := 1;
    end
    else
            CBEsDeCredito.ItemIndex := -1;
    panel1.Visible := true;
    edImporte.SetFocus;
    ActivarComponentes(false,self,[1]);
  end;
end;

procedure TfrmPagoSociosAca.btnAceptarClick(Sender: TObject);
begin
  try
        case CBEsDeCredito.ItemIndex of
             0:begin
                    fSocios.ValueByName[FIELD_FORMPAGO] := FORMA_PAGO_METALICO;
             end;
             1:begin
                    fSocios.ValueByName[FIELD_FORMPAGO] := FORMA_PAGO_CHEQUE;
             end;
        end;
        fsocios.Post(true);
      panel1.Visible := false;
      qfacturasaca.close;
      qFacturasACA.SetProvider(dspqFacturasACA);
      qFacturasACA.open;
      ActivarComponentes(true,self,[1]);
  except
         on E: Exception do
         begin
            FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Error al intentar grabar socios_acavtv por: %s', [E.message]);
            MessageDlg(caption, 'Error al intentar grabar socios_acavtv por: ' + E.message , mtError, [mbOk], mbOk, 0)
         end
  end;
end;

procedure TfrmPagoSociosAca.btnGrabarClick(Sender: TObject);
var
  isnotok:boolean;
begin
  isnotok:= false;
  with TSocios_Acavtv.CreateByFechaCompleto_u(mybd,dateini,datefin,aTipoCliente) do
    try
      open;
      if recordcount > 0 then
      begin
         MessageDlg(caption, 'Existen inscripciones con datos incompletos ', mtInformation, [mbOk], mbOk, 0);
         isnotok := true;
         exit;
      end;
      if MyBD.InTransaction then MyBD.Commit(TD);
    finally
      free;
    end;
    if not isnotok then close;
end;

procedure TfrmPagoSociosAca.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;


procedure TfrmPagoSociosAca.btncancelarClick(Sender: TObject);
begin
    fsocios.cancel;
    panel1.Visible := false;
    ActivarComponentes(true,self,[1]);    
end;

end.
