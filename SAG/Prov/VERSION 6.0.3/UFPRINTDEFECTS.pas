unit UFPrintDefects;
{ Impresión de defectos }

{
  Ultima Traza: 3
  Ultima Incidencia: 
  Ultima Anomalia: 3
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, quickrpt, Qrctrls, FMTBcd, DBClient,
  Provider, SqlExpr, DBXpress;

type
  TfrmImprimirDefectos = class(TForm)
    dscapitulos: TDataSource;
    dsapartados: TDataSource;
    dsdefectos: TDataSource;
    sdsCapitulos: TSQLDataSet;
    sdsApartados: TSQLDataSet;
    sdsdefectos: TSQLDataSet;
    dspCapitulos: TDataSetProvider;
    dspApartados: TDataSetProvider;
    dspDefectos: TDataSetProvider;
    TablaCapitulos: TClientDataSet;
    TablaApartados: TClientDataSet;
    TablaDefectos: TClientDataSet;
    QRDefectos: TQuickRep;
    QRBand1: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText7: TQRDBText;
    QRLabel1: TQRLabel;
    QRBand4: TQRBand;
    QRLabel6: TQRLabel;
    QRSysData1: TQRSysData;
    QRBand5: TQRBand;
    QRLabel3: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    QRDBText11: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText12: TQRDBText;
    QRLabel9: TQRLabel;
    QRDBText13: TQRDBText;
    QRDBText14: TQRDBText;
    QRSubDetail2: TQRSubDetail;
    QRLabel10: TQRLabel;
    QRDBText15: TQRDBText;
    QRDBText16: TQRDBText;
    QRDBText17: TQRDBText;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure QRDetailLink2Filter(var PrintRecord: Boolean);
  private
    { Private declarations }
    function Activar_Tablas_IMPRDEF: boolean;
  public
    { Public declarations }
    function SeleccionarDefectos: boolean;
  end;

var
  frmImprimirDefectos: TfrmImprimirDefectos;

implementation

{$R *.DFM}

uses
    ULOGS,
    GLOBALS,
    UUTILS,
    UCTDEFECTOS;

const
   FICHERO_ACTUAL = 'ImprDef';



function TfrmImprimirDefectos.SeleccionarDefectos: boolean;
{ Devuelve False si ha habido algún error }
var
   iContador: integer; { var. auxi. que actúa a modo de índice }

begin
    try
       TablaCAPITULOS.Close;
       TablaAPARTADOS.Close;
       TablaDEFECTOS.Close;

       for iContador := 0 to ComponentCount - 1 do
         if Components[iContador] is TClientDataSet then AbrirTabla(TClientDataSet(Components[iContador]));

       Result := True;
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Error en SeleccionarDefectos: ' + E.Message);
         end;
    end;
end;


function TfrmImprimirDefectos.Activar_Tablas_IMPRDEF: boolean;
var
   iContador: integer; { var. auxi. que actúa a modo de índice }

begin
    try
       for iContador := 0 to ComponentCount - 1 do
         {if Components[iContador] is TDataBase then
         begin
             TDataBase(Components[iContador]).DataBaseName := MyBd.DataBaseName;
         end
         else} if Components[iContador] is TSQLDataSet then begin
             TSQLDataSet(Components[iContador]).SQLConnection := MyBD;

         end;

       {with BDImprimirDefectos do
       begin
         AliasName := DBAlias;
         Params.Add('USER NAME=' + DataDiccionario.Desencripta(DBUserName));
         Params.Add('PASSWORD=' + DataDiccionario.Desencripta(DBPassword));

         LoginPrompt := False;
         Connected := True;
       end;}

       for iContador := 0 to ComponentCount - 1 do
         if Components[iContador] is TClientDataSet then
           AbrirTabla(TClientDataSet(Components[iContador]));

       Result := True;
    except
        on E:Exception do
        begin
            Result := False;
            //FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL, 'Error en Activar_Tablas_IMPRDEF: ' + E.Message);
        end;
    end;
end;

procedure TfrmImprimirDefectos.FormDestroy(Sender: TObject);
begin
(*
   try
      if BDImprimirDefectos.Connected then
         BDImprimirDefectos.Connected := False
      else
      begin
          {$IFDEF TRAZAS}
            FTrazas.PonAnotacion (TRAZA_FLUJO,1,FICHERO_ACTUAL, 'NO hubo conexión a BDImprimirDefectos');
          {$ENDIF}
      end;
   except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'Error en FormDestroy: ' + E.Message);
        end;
   end;
*)
end;

procedure TfrmImprimirDefectos.FormCreate(Sender: TObject);
begin
    Activar_Tablas_IMPRDEF;
end;

procedure TfrmImprimirDefectos.QRDetailLink2Filter(var PrintRecord: Boolean);
begin
    if (TablaDefectos.FieldByName('ACTIVO').AsString = DEFECTO_NOACTIVO) then
       PrintRecord := False
    else
       PrintRecord := True;
end;



end.
