unit UFDatosProvSeguros;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Mask, DBCtrls, Db, globals,
  FMTBcd, SqlExpr;

type
  TfrmDatosProvSeguros = class(TForm)
    btnSalir: TBitBtn;
    rgBuscar: TRadioGroup;
    ppoliza: TPanel;
    edPoliza: TEdit;
    edCertificado: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    pDocumento: TPanel;
    Label4: TLabel;
    edDocumento: TEdit;
    CBTipoDoc: TComboBox;
    Label3: TLabel;
    pDominio: TPanel;
    Label5: TLabel;
    edDominio: TEdit;
    btnBuscarPoliza: TBitBtn;
    btnBuscarDocumento: TBitBtn;
    btnBuscarDominio: TBitBtn;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Bevel1: TBevel;
    qProvSegu: TSQLQuery;
    procedure btnSalirClick(Sender: TObject);
    procedure rgBuscarClick(Sender: TObject);
    procedure edDominioKeyPress(Sender: TObject; var Key: Char);
    procedure edDocumentoKeyPress(Sender: TObject; var Key: Char);
    procedure edPolizaKeyPress(Sender: TObject; var Key: Char);
    procedure btnBuscarDominioClick(Sender: TObject);
    procedure btnBuscarDocumentoClick(Sender: TObject);
    procedure btnBuscarPolizaClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure CBTipoDocChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function DevuelveTipoDoc : string;
  public
    { Public declarations }
  end;

  procedure DoDatosProvSeguros;

var
  frmDatosProvSeguros: TfrmDatosProvSeguros;


resourcestring
        FILE_NAME = 'UFDatosProvSeguros';

implementation

{$R *.DFM}

uses
  uUtils;

procedure DoDatosProvSeguros;
begin
  with TfrmDatosProvSeguros.Create(application) do
    try
      showmodal;
    finally
      free;
    end;
end;

procedure TfrmDatosProvSeguros.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmDatosProvSeguros.rgBuscarClick(Sender: TObject);
begin
  case rgBuscar.ItemIndex of
    0:begin
       MostrarComponentes(true,self,[1]);
       MostrarComponentes(false,self,[2,3]);
       edPoliza.SetFocus;
    end;
    1:begin
       MostrarComponentes(true,self,[2]);
       MostrarComponentes(false,self,[1,3]);
       edDominio.SetFocus;
    end;
    2:begin
       MostrarComponentes(true,self,[3]);
       MostrarComponentes(false,self,[2,1]);
       CBTipoDoc.SetFocus;
    end;
  end;
end;

procedure TfrmDatosProvSeguros.edDominioKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = Char(VK_SPACE)
        then Key := #0
end;

procedure TfrmDatosProvSeguros.edDocumentoKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in [Char(VK_SPACE),'0','1','2','3','4','5','6','7','8','9',#8])
        then key := #0
end;

procedure TfrmDatosProvSeguros.edPolizaKeyPress(Sender: TObject;
  var Key: Char);
begin
        if Key = Char(VK_SPACE)
        then Key := #0
end;

procedure TfrmDatosProvSeguros.btnBuscarDominioClick(Sender: TObject);
begin
  if length(edDominio.Text) > 6 then
  begin
    application.MessageBox('Ingrese un Dominio correcto','Datos Provincia Seguros',mb_ok+mb_iconerror+mb_applmodal);
    edDominio.SetFocus;
  end
  else
    with qProvSegu do
    begin
      close;
      sql.Clear;
      sql.add(format('SELECT * FROM DATOS_PROVINCIA WHERE RTRIM(PATENTE) = RTRIM(''%S'')',[edDominio.text]));
      open;
      if not (recordcount > 0) then
      begin
        application.MessageBox('No se encontraron datos para el dominio solicitado','Datos Provincia Seguros',mb_ok+mb_iconerror+mb_applmodal);
        edDominio.SetFocus;
      end;
    end;
end;

procedure TfrmDatosProvSeguros.btnBuscarDocumentoClick(Sender: TObject);
var stipodoc: string;
begin
  if (CBTipoDoc.Text = '') or (edDocumento.Text = '') then
  begin
    application.MessageBox('Ingrese un Documento correcto','Datos Provincia Seguros',mb_ok+mb_iconerror+mb_applmodal);
    CBTipoDoc.SetFocus;
  end
  else
    sTipoDoc := DevuelveTipoDoc;
    with qProvSegu do
    begin
      close;
      sql.Clear;
      sql.add(format('SELECT * FROM DATOS_PROVINCIA WHERE TIPODOC = ''%S'' AND NRODOC = %S',[sTipoDoc,edDocumento.text]));
      open;
      if not (recordcount > 0) then
      begin
        application.MessageBox('No se encontraron datos para el documento solicitado','Datos Provincia Seguros',mb_ok+mb_iconerror+mb_applmodal);
        CBTipoDoc.SetFocus;
      end;
    end;
end;

procedure TfrmDatosProvSeguros.btnBuscarPolizaClick(Sender: TObject);
begin
  if (edPoliza.Text = '') or (edCertificado.Text = '') then
  begin
    application.MessageBox('Ingrese una póliza correcta','Datos Provincia Seguros',mb_ok+mb_iconerror+mb_applmodal);
    edPoliza.SetFocus;
  end
  else
    with qProvSegu do
    begin
      close;
      sql.Clear;
      sql.add(format('SELECT * FROM DATOS_PROVINCIA WHERE NROPOLIZA = %S AND CERTIFICADO = %S',[edPoliza.text,edCertificado.text]));
      open;
      if not (recordcount > 0) then
      begin
        application.MessageBox('No se encontraron datos para la póliza solicitada','Datos Provincia Seguros',mb_ok+mb_iconerror+mb_applmodal);
        edPoliza.SetFocus;        
      end;
    end;
end;

procedure TfrmDatosProvSeguros.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

function TfrmDatosProvSeguros.DevuelveTipoDoc : string;
begin
  if CBTipoDoc.text = 'OTROS'
  then result := 'G'
  else result := copy(CBTipoDoc.text,1,3);
end;

procedure TfrmDatosProvSeguros.CBTipoDocChange(Sender: TObject);
begin
  edDocumento.Clear;
end;

procedure TfrmDatosProvSeguros.FormActivate(Sender: TObject);
begin
      edPoliza.SetFocus;
end;

procedure TfrmDatosProvSeguros.FormCreate(Sender: TObject);
begin
  qProvSegu.SQLConnection := MYBD;
end;

end.
