unit UModDat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, ExtCtrls, UTiposIN, FMTBcd, Provider, DBClient, SqlExpr;

const
       PRIMERA_DEPENDENCIA = 1;
       ULTIMA_DEPENDENCIA = 11;

    { TIPOS DE VEHICULOS }
      REMOLQUE_PESADO = 5;  // CODIGO PARA EL TIPO DE VEHICULO REMOLQUE PESADO
      REMOLQUE_LIGERO = 4;
      REMOLQUE = REMOLQUE_LIGERO;  // VALOR DEPENDENCIA  1 PARA UN REMOLQUE PESADO COINCIDE CON UN REMOLQUE LIGERO }

  { UMBRALES PARA LAS DEPENDENCIAS POR ANTIGUEDAD }
    MCMXCII = '1992';
    MCMXCIV = '1994';
    MCMXCV  = '1995';

  { VALORES DE LA DEPENDENCIA 2 SEGUN EL TIPO DE ANTIGUEDAD}
    ANTIGUEDAD_1 = 7;  // (00, 92)
    ANTIGUEDAD_2 = 8;  // [92, 94)
    ANTIGUEDAD_3 = 9;  // [94, 95)

  { VALORES DE LA DEPENDENCIAS 2 SEGUN EL TIPO DE ANTIGUEDAD}
    ANTIGUEDAD_4 = 10; // [00, 95)
    ANTIGUEDAD_5 = 11; // [95, 00)

type

  tDependencia = PRIMERA_DEPENDENCIA..ULTIMA_DEPENDENCIA;

  tRDependencias = record
    D1, D2, D3 : tDependencia;
  end;

const
  FICHERO_ACTUAL = 'UModDat.pas';

type
  TDataDiccionario = class(TDataModule)
    sdsQryConsultas: TSQLDataSet;
    sdsTESTADOINSP: TSQLDataSet;
    QryConsultas: TClientDataSet;
    TESTADOINSP: TClientDataSet;
    DSPQryConsultas: TDataSetProvider;
    dspTESTADOINSP: TDataSetProvider;
    procedure DataDiccionarioDestroy(Sender: TObject);
    function ObtenerDependenciasOk (const iEjercicio, iCodigoInspeccion : integer;
                                  var rDependencias : tRDependencias) : boolean;


  private
    { Private declarations }
  public
    { Public declarations }   
    function ConexionABDOk : boolean;
  end;

var
  DataDiccionario: TDataDiccionario;

implementation

uses
  ULogs,
  UInicio,
  Globals;

{$R *.DFM}

function Desencripta  (const s : string) : string;
begin
  result := s;
end;

function TDataDiccionario.ConexionABDOk : boolean;
var
    I : integer;
begin
    try
        for I := 0 to ComponentCount - 1 do
            if Components[I] is TSQLDataSet then
            begin
                TSQLDataSet(Components[I]).SQLConnection := MyBd;
                If Components[I] is TClientDataSet then TClientDataSet(Components[I]).Open;
            end;

        {$IFDEF TRAZAS}
        fTrazas.PonAnotacion (TRAZA_FLUJO,0, FICHERO_ACTUAL,'CONEXION CORRECTA A LA BASE DE DATOS CON LA SESION ITV');
        {$ENDIF}

    except
        on E : Exception do
        begin
            result := False;
            fAnomalias.PonAnotacion (TRAZA_SIEMPRE,0, FICHERO_ACTUAL,'CONEXION INCORRECTA A LA BASE DE DATOS CON LA SESION ITV' + E.message );
        end;
    end;
end;


procedure TDataDiccionario.DataDiccionarioDestroy(Sender: TObject);
begin
  try
    {$IFDEF TRAZAS}
       fTrazas.PonAnotacion (TRAZA_FLUJO,1, FICHERO_ACTUAL,'DESCONEXION CORRECTA DE LA SESION ITV');
    {$ENDIF}
  except
    on E : Exception do
    begin
      fAnomalias.PonAnotacion (TRAZA_SIEMPRE,1, FICHERO_ACTUAL,'DESCONEXION INCORRECTA DE LA SESION ITV: ' + E.message );
    end;
  end;
end;



function TDataDiccionario.ObtenerDependenciasOk
         (const iEjercicio, iCodigoInspeccion : integer;
          var rDependencias : tRDependencias) : boolean;

var
 sAnio, sClave : string;
begin

  sClave := IntToStr(iEjercicio) + ',' + IntToStr(iCodigoInspeccion);

  try
    with QryConsultas do
    begin
      Close;
      CommandText := 'SELECT T.TIPOVEHI, V.FECMATRI ' +
              'FROM TVEHICULOS V,  TINSPECCION I, TTIPOESPVEH T ' +
              'WHERE V.CODVEHIC = I.CODVEHIC ' +
                    'AND V.TIPOESPE = T.TIPOESPE '+
                    'AND I.EJERCICI =:UnEjercicio ' +
                    'AND I.CODINSPE =:UnCodigo';
      //Prepare;
      params.ParamByName('UnEjercicio').Value := iEjercicio;
      params.ParamByName('UnCodigo').Value  := iCodigoInspeccion;

      {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL, 0,FICHERO_ACTUAL,QryConsultas);
      {$ENDIF}

      Open;
      Application.ProcessMessages;

      if RecordCount = 1 then
      begin
      {$IFDEF TRAZAS}
        fTrazas.PonRegistro(TRAZA_REGISTRO, 0,FICHERO_ACTUAL,QryConsultas);
      {$ENDIF}

        if FieldByName('TIPOVEHI').AsInteger = REMOLQUE_PESADO then rDependencias.D1 := REMOLQUE
        else rDependencias.D1 := FieldByName('TIPOVEHI').AsInteger;

        sAnio := FormatDateTime('yyyy',FieldByName('FECMATRI').AsDateTime);
        if sAnio < MCMXCII  
        then begin                   // (-oo, 1992)
            rDependencias.D2 := ANTIGUEDAD_1;
            rDependencias.D3 := ANTIGUEDAD_4;
        end
        else if sAnio < MCMXCV
             then begin              // [1992, 1995)
                 rDependencias.D2 := ANTIGUEDAD_2;
                 rDependencias.D3 := ANTIGUEDAD_4;
             end
             else begin              // [1995, +oo)
                rDependencias.D2 := ANTIGUEDAD_3;
                rDependencias.D3 := ANTIGUEDAD_5;
             end;

        {$IFDEF TRAZAS}
           fTrazas.PonAnotacion(TRAZA_FLUJO,2,FICHERO_ACTUAL,'OBTENIDAS LAS DEPENDECIAS PARA EL VEHICULO (Ejercicio, Codigo): ' + sClave);
        {$ENDIF}

        result := True;
      end
      else begin
        result := False;
        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'ERROR, NO HAY DEPENDENCIAS PARA EL VEHICULO (Ejercicio, Codigo): ' + sClave + ' PORQUE NO EXISTE EL REGISTRO');
      end;
      Close;
    end;
  except
    on E:Exception do
    begin
      result := False;
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'ERROR, NO HAY DEPENDENCIAS PARA EL VEHCIULO (Ejercicio, Código): ' + sClave + ' POR: ' + E.message);
    end;
  end;
end;

Initialization
    DataDiccionario:=TDataDiccionario.Create(Application);


end.//Final de la unidad
