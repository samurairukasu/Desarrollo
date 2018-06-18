unit UModDat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, ExtCtrls, ULogs, FMTBcd, SqlExpr, Provider, DBClient, DBXpress;

const
  FICHERO_ACTUAL = 'UModDat.pas';
type
  TDataDiccionario = class(TDataModule)
    TESTADOINSP: TClientDataSet;
    TDATINSPEVI: TClientDataSet;
    dspTESTADOINSP: TDataSetProvider;
    dspTDATINSPEVI: TDataSetProvider;
    sdsTESTADOINSP: TSQLDataSet;
    sdsTDATINSPEVI: TSQLDataSet;
    QryGeneral: TClientDataSet;
    dspQryGeneral: TDataSetProvider;
    sdsQryGeneral: TSQLDataSet;
    QryUpdateInspeccion: TClientDataSet;
    dspQryUpdateInspeccion: TDataSetProvider;
    sdsQryUpdateInspeccion: TSQLDataSet;
    TDATA_REGLOSCOPIO: TClientDataSet;
    DSPTDATA_REGLOSCOPIO: TDataSetProvider;
    SDSTDATA_REGLOSCOPIO: TSQLDataSet;
    TDATRESULTREV: TClientDataSet;
    dspTDATRESULTREV: TDataSetProvider;
    sdsTDATIRESULREV: TSQLDataSet;
    procedure DataDiccionarioDestroy(Sender: TObject);
    function CambiarEstadoInspeccionOk (const iUnEjercicio, iUnCod_Inspeccion : integer; const sNuevoEstado, sMatricula : string) : boolean;
    procedure LimpiarTESTADOINSP;   
    function ConexionABDOk : boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataDiccionario: TDataDiccionario;

implementation

uses Globals;

{$R *.DFM}

function TDataDiccionario.ConexionABDOk : boolean;
var
  I : integer;
begin
  Try
    for I := 0 to ComponentCount - 1 do
    begin
            if Components[I] is TSQLDataSet
            then begin
                With (TSQLDataSet(Components[I])) do
                begin
                    SQLConnection:=MyBd;
                    if CommandText <> ''
                    then open;
                end;
            end;
    end;

    TDATA_REGLOSCOPIO.open;
    TDATINSPEVI.open;
    TESTADOINSP.Open;
    TDATRESULTREV.Open;

    TESTADOINSP.IndexFieldNames := 'EJERCICI;CODINSPE';

    MyBD.ExecuteDirect('ALTER SESSION SET  NLS_DATE_FORMAT = ''dd/mm/yy hh24:mi:ss''');
    Application.ProcessMessages;

    result := True;

    {$IFDEF TRAZAS}
      fTrazas.PonAnotacion (TRAZA_FLUJO,1, FICHERO_ACTUAL,'CONEXION CORRECTA A LA BASE DE DATOS CON LA SESION ITV');
    {$ENDIF}

  except
    on E : Exception do
    begin
      result := False;
      fAnomalias.PonAnotacion (1,1, FICHERO_ACTUAL,'CONEXION INCORRECTA A LA BASE DE DATOS CON LA SESION ITV' + E.message );
    end;
  end;
end; 

procedure TDataDiccionario.DataDiccionarioDestroy(Sender: TObject);
begin
  try
    {$IFDEF TRAZAS}
       if Assigned(fTrazas)
       then fTrazas.PonAnotacion (TRAZA_FLUJO,2, FICHERO_ACTUAL,'DESCONEXION CORRECTA DE LA SESION ITV');
    {$ENDIF}
  except
    on E : Exception do
    begin
      if Assigned(fAnomalias)
      then fAnomalias.PonAnotacion (TRAZA_SIEMPRE,2, FICHERO_ACTUAL,'DESCONEXION INCORRECTA DE LA SESION ITV: ' + E.message );
    end;
  end;
end;

function TDataDiccionario.CambiarEstadoInspeccionOk (const iUnEjercicio, iUnCod_Inspeccion : integer; const sNuevoEstado, sMatricula : string) : boolean;
const
  ANULADO = 'E';
begin
  result := True;
  try
    with TESTADOINSP do
    begin
      Cancel;
      refresh;
      if not Findkey([iUnEjercicio, iUnCod_Inspeccion]) then
        begin
          result := False;
          fAnomalias.PonAnotacion(1,3,FICHERO_ACTUAL, 'ERROR GRAVE, NO SE ENCUENTRA EL REGISTRO : '
                                 + IntToStr(iUnEjercicio) + ',' + IntToStr(iUnCod_Inspeccion)  + ' EN TESTADOINSP Y NO SE PUEDE ACTUALIZAR');
        end
      else
        begin
          { por si acaso, aunque no se dará el caso }
          if FieldByName('ESTADO').AsString = ANULADO then
            begin
              result := False;
              fAnomalias.PonAnotacion(1,4,FICHERO_ACTUAL, 'ERROR GRAVE, NO SE COMPLETARA EL PROCESO PARA EL REGISTRO : '
                                      + IntToStr(iUnEjercicio) + ',' + IntToStr(iUnCod_Inspeccion)  + ' PORQUE ESTA ANULADO EN TESTADOINSP Y NO SE PUEDE ACTUALIZAR');
            end
          else
            begin
              if UpperCase(FieldByName('MATRICUL').AsString) <> UpperCase(ChangeFileExt(sMatricula,'')) then
                begin
                  result := False;
                  fAnomalias.PonAnotacion(1,5,FICHERO_ACTUAL, 'ERROR GRAVE, NO SE COMPLETARA EL PROCESO PARA EL REGISTRO : '
                                          + IntToStr(iUnEjercicio) + ',' + IntToStr(iUnCod_Inspeccion)  + ' PORQUE LAS MATRICULAS NO COINCIDEN Y NO SE PUEDE ACTUALIZAR');
                end
              else
                begin
                  Edit;
                  FieldByName('ESTADO').AsString := sNuevoEstado;
                  FieldByName('HORAFINA').AsDateTime := Now;
                  Post;
                  applyupdates(0);
                  {$IFDEF TRAZAS}
                  fTrazas.PonAnotacion(TRAZA_FLUJO,3,FICHERO_ACTUAL,'EL REGISTRO DE LA TABLA TESTADOINSP: '
                                      + IntToStr(iUnEjercicio) + ',' + IntToStr(iUnCod_Inspeccion) + ' HA PASADO DE MOMENTO AL ESTADO: ' + sNuevoEstado);
                  {$ENDIF}
                end;
            end;
        end;
    end;
  except
    on E : Exception do begin
      fAnomalias.PonAnotacion(1,6,FICHERO_ACTUAL, 'ERROR MUY GRAVE Y EXTRAÑO, AL INTENTAR CAMBIAR EL ESTADO DE: ' + IntToStr(iUnEjercicio) + ',' + IntToStr(iUnCod_Inspeccion) + ' POR:' + E.message);
      result := False;
    end;
  end;
end;


procedure TDataDiccionario.LimpiarTESTADOINSP;
begin
  try
    MyBD.ExecuteDirect('DELETE FROM TESTADOINSP WHERE ESTADO = ''E'''); // E = Anulado;
      {$IFDEF TRAZAS}
        fTrazas.PonAnotacion(TRAZA_SQL,0, FICHERO_ACTUAL,'DELETE FROM TESTADOINSP WHERE ESTADO = ''E''');
      {$ENDIF}
      Application.ProcessMessages;
  except
    on E : Exception do
    begin
      fAnomalias.PonAnotacion(1,7,FICHERO_ACTUAL,'NO SE PUEDEN BORRAR LOS REGISTROS ANULADOS DE TESTADOINSPE POR: ' + E.message);
    end;
  end;
end;


Initialization

        DataDiccionario:=TDataDiccionario.Create(Application);

end.  //Final de la unidad
