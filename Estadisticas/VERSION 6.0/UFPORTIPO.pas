unit UFPorTipo;

interface

uses                           
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Db, RxLookup, StdCtrls, Buttons, uflistadodescuentos, uSagEstacion,
  UUtils, DBTables, globals, usagclasses;

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
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    fDescuentos : TDescuento;
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
                  aTipoCliente:=fDescuentos.ValueByName[FIELD_CODDESCU];
//                  if chktodas.Checked then
//                    aTipoCliente:=''
//                  else
//                end;
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
    self.Caption:='Listado de Facturas con Descuento';
    try
      mybd.open
    except
    end;
    fDescuentos := Tdescuento.CreateConFechas(Mybd, DateIni, DateFin);
    fDescuentos.open;
    cbTarjeta.LookupDisplay:=FIELD_CODDESCU+';'+FIELD_CONCEPTO;
    cbTarjeta.LookupField:=FIELD_CODDESCU;
    dsTarjeta.DataSet:=fDescuentos.dataset;
    cbTarjeta.Value:=fDescuentos.ValueByName[FIELD_CODDESCU];
    lblseleccione.Caption:='Seleccione el Descuento';

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

procedure TFrmPorTipo.FormDestroy(Sender: TObject);
begin
  if assigned(fDescuentos) then
    fDescuentos.free;
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
