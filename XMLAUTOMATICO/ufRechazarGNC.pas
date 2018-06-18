unit ufRechazarGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, USagClasses,
  Globals, StdCtrls, Buttons, Db, RXLookup, uSagEstacion, ucDialgs;

type
  TfrmRechazarGNC = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    dbcbDefectos: TRxDBLookupCombo;
    srcDefectos: TDataSource;
    srcInspDef: TDataSource;
    Label1: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
    finspGNC : TinspGNC;
    fInspgncDefectos : TInspGNC_Defectos;
    fDefectos : TDefectosGNC;
    fInspecciones : TEstadoInspGNC;
  public
    { Public declarations }
    constructor CreateFromBD (const aInspGNC: TInspGNC; var aEstadoInsp : TEstadoInspGNC);
    function Execute: boolean;
  end;

var
  frmRechazarGNC: TfrmRechazarGNC;

implementation

uses
  uLogs;

{$R *.DFM}

resourcestring
    FICHERO_ACTUAL = 'ufRechazarGNC.pas';

constructor TfrmRechazarGNC.CreateFromBD (const aInspGNC: TInspGNC; var aEstadoInsp : TEstadoInspGNC);
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
    fInspgncDefectos.Append;
    fInspgncDefectos.ValueByName[FIELD_EJERCICI] := fInspGNC.ValueByName[FIELD_EJERCICI];
    fInspgncDefectos.ValueByName[FIELD_CODINSPGNC] := fInspGNC.ValueByName[FIELD_CODINSPGNC];
    fInspecciones := aEstadoInsp;
    fInspecciones.Open;
end;

function TfrmRechazarGNC.Execute: boolean;
begin
    try
        result := FALSE;
        if ShowModal = mrOk
        then begin
            try
              fInspgncDefectos.post(true);

                if Not fInspecciones.Rechazar
                then begin
                    MessageDlg('PLANTA DE VERIFICACION',
                      'EN ESTE MOMENTO NO SE PUEDE EFECTUAR DICHA OPERACIÓN, ESPERE UNOS SEGUNDOS E INTÉNTELO DE NUEVO, SI EL PROBLEMA PERSISTE CONTACTE CON EL DEPTO DE SISTEMAS',
                      mtWarning,[mbOk], mbOk,0);
                end
                else
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

procedure TfrmRechazarGNC.FormDestroy(Sender: TObject);
begin
     fInspgncDefectos.free;
     fDefectos.free;
end;

procedure TfrmRechazarGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = chr(Vk_Return) then begin
     key := #0;
     perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TfrmRechazarGNC.btnAceptarClick(Sender: TObject);
begin
  if dbcbDefectos.Text = '' then
  begin
    MessageDlg (Application.Title, 'Se debe ingresar el motivo del rechazo', mtInformation, [mbOk],mbOk,0);
    dbcbDefectos.SetFocus;
    exit;
  end
  else
    ModalResult := mrOK;
end;

end.
