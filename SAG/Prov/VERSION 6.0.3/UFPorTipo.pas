unit UFPorTipo;

interface

uses                           
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, RxLookup, StdCtrls, Buttons, UARQUEOCAJAEXTENDED, uSagEstacion,
  UUtils, globals, usagclasses;

type
  TFrmPorTipo = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    chktodas: TCheckBox;
    CBTarjeta: TRxDBLookupCombo;
    dsTarjeta: TDataSource;
    Bevel7: TBevel;
    lblseleccione: TLabel;
    Bevel1: TBevel;
    procedure chktodasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fTiposCliente : TTiposCliente;
    fDescuentos : TDescuento;
    fTarjeta : TTarjeta;
    fUsuario : TUsuarios;
    procedure MuestraSegunTipo(const TipoListado: string);
  public
    { Public declarations }
  end;

  function PorTipo(const TipoListado: string; var aTipoCliente: string; const aDateIni, aDateFin: string): boolean;

var
  FrmPorTipo: TFrmPorTipo;
  dateini,datefin:string;

implementation

{$R *.DFM}

const
  TIPO_TARJETA = 'T';
  TIPO_CLIENTES = 'L';
  TIPO_DESCUENTOS = 'D';
  TIPO_SOCIOS = 'S';
  TIPO_CAJEROS = 'C';

Function PorTipo(const TipoListado: string; var aTipoCliente: string; const aDateIni, aDateFin: string): Boolean;
begin
    Result:=FalsE;
    try
        dateini := adateini;
        datefin := adatefin;
        with TFrmPorTipo.Create(Application) do
        try
            MuestraSegunTipo(TipoListado);
            if ShowModal = mrOk
            then begin
                if TipoListado = TIPO_CLIENTES then
                  aTipoCliente:=fTiposCliente.ValueByName[FIELD_TIPOCLIENTE_ID]
                else if (TipoListado = TIPO_DESCUENTOS) or (TipoListado = TIPO_SOCIOS) then
                  aTipoCliente:=fDescuentos.ValueByName[FIELD_CODDESCU]
                else if (TipoListado = TIPO_TARJETA) then
                begin
                  if chktodas.Checked then
                    aTipoCliente:=''
                  else
                    aTipoCliente:=fTarjeta.ValueByName[FIELD_CODTARJET];
                end
                else if (TipoListado = TIPO_CAJEROS) then
                  aTipoCliente:=fUsuario.ValueByName[FIELD_IDUSUARIO];
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;


procedure TFrmPorTipo.MuestraSegunTipo(const TipoListado: string);
begin
  if TipoListado = TIPO_TARJETA then
  begin
    self.Caption:='Listado por Tarjetas';
    mostrarComponentes(true,self,[2]);
    mostrarComponentes(false,self,[1]);
    fTarjeta := TTarjeta.Create(MyBD);
    fTarjeta.open;
    cbTarjeta.LookupDisplay:=FIELD_CODTARJET+';'+FIELD_ABREVIA;
    cbTarjeta.LookupField:=FIELD_CODTARJET;
    dsTarjeta.DataSet:=fTarjeta.dataset;
    cbTarjeta.Value:=fTarjeta.ValueByName[FIELD_CODTARJET];
    lblseleccione.Caption:='Seleccione la Tarjeta';
  end
  else if TipoListado = TIPO_CLIENTES then
  begin
    self.Caption:='Listado por Tipo de Clientes';
    fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,'WHERE VIGENTE = ''S''');
    fTiposCliente.open;
    cbTarjeta.LookupDisplay:=FIELD_TIPOCLIENTE_ID+';'+FIELD_DESCRIPCION;
    cbTarjeta.LookupField:=FIELD_TIPOCLIENTE_ID;
    dsTarjeta.DataSet:=fTiposCliente.dataset;
    cbTarjeta.Value:=fTiposCliente.ValueByName[FIELD_TIPOCLIENTE_ID];
    lblseleccione.Caption:='Seleccione el Tipo de Cliente';
  end
  else if (TipoListado = TIPO_DESCUENTOS) or (TipoListado = TIPO_SOCIOS) then
  begin
    if TipoListado = TIPO_DESCUENTOS then
        self.Caption:='Listado de Facturas con Descuento'
    else
        self.Caption:='Listado de Socios';
    fDescuentos := Tdescuento.CreateConFechas(Mybd, DateIni, DateFin);
    fDescuentos.open;
    cbTarjeta.LookupDisplay:=FIELD_CODDESCU+';'+FIELD_CONCEPTO;
    cbTarjeta.LookupField:=FIELD_CODDESCU;
    dsTarjeta.DataSet:=fDescuentos.dataset;
    cbTarjeta.Value:=fDescuentos.ValueByName[FIELD_CODDESCU];
    lblseleccione.Caption:='Seleccione el Descuento';
  end
  else if (TipoListado = TIPO_CAJEROS) then
  begin
    self.Caption:='Listado por Usuarios del Sistema';
    fUsuario := TUsuarios.CreateFromDataBase(mybd,DATOS_USUARIO,'');
    fUsuario.open;
    cbTarjeta.LookupDisplay:=FIELD_NOMBRE+';'+FIELD_ADICIONAL;
    cbTarjeta.LookupField:=FIELD_IDUSUARIO;
    cbTarjeta.LookupDisplayIndex := 0;
    dsTarjeta.DataSet:=fUsuario.dataset;
    cbTarjeta.Value:=fUsuario.ValueByName[FIELD_IDUSUARIO];
    lblseleccione.Caption:='Seleccione el Nombre del Usuario';
  end
end;

procedure TFrmPorTipo.chktodasClick(Sender: TObject);
begin
  if ChkTodas.checked then
  begin
    mostrarComponentes(false,self,[1]);
  end
  else
  begin
    mostrarComponentes(true,self,[1]);
  end;
end;

procedure TFrmPorTipo.FormCreate(Sender: TObject);
begin
  fTiposCliente:=(nil);
end;

procedure TFrmPorTipo.FormDestroy(Sender: TObject);
begin
  if assigned(fTiposCliente) then
    fTiposCliente.free;
  if assigned(fDescuentos) then
    fDescuentos.free;
  if assigned(fTarjeta) then
    fTarjeta.free;
  if assigned(fUsuario) then
    fUsuario.free;
end;

procedure TFrmPorTipo.FormKeyPress(Sender: TObject; var Key: Char);
begin
     if key = #13
     then begin
         Perform(WM_NEXTDLGCTL,0,0);
         Key := #0
     end;
end;


end.
