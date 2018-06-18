unit UFPeriodicityTypesTas;
{ Mantenimiento de Tipos, Tarifas y Periodicidad }

{
  Ultima Traza: 31
  Ultima Incidencia: 15
  Ultima Anomalia: 11
}


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, Grids, DBGrids, ComCtrls, StdCtrls, Buttons, UCTTITAPER, 
  UFMAXIMUMTIMESTAS, UFPERIODICITY, UFDESTINYSPECIES, FMTBcd, DBClient,
  Provider, SqlExpr;

type
  TfrmTiposTarifasPeriodicidad = class(TForm)
    PgCtrlTiposTarifasPeriodicidad: TPageControl;
    TSheetTarifas: TTabSheet;
    TSheetPeriodicidad: TTabSheet;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    TSheetEspecie: TTabSheet;
    TSheetDServicio: TTabSheet;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    DSourceTTIPOVEHICU: TDataSource;
    DSourceTFRECUENCIA: TDataSource;
    DSourceTTIPOESPVEH: TDataSource;
    DSourceTTIPODESVEH: TDataSource;
    btnModificar: TBitBtn;
    btnImprimir: TBitBtn;
    btnSalir: TBitBtn;
    sdsqryConsultas: TSQLDataSet;
    sdsTTIPOVEHICU: TSQLDataSet;
    sdsTFRECUENCIA: TSQLDataSet;
    sdsqryConsultasTTIPOESPVEH: TSQLDataSet;
    sdsqryConsultasTTIPODESVEH: TSQLDataSet;
    dspqryConsultas: TDataSetProvider;
    dspTTIPOVEHICU: TDataSetProvider;
    dspTFRECUENCIA: TDataSetProvider;
    dspqryConsultasTTIPOESPVEH: TDataSetProvider;
    dspqryConsultasTTIPODESVEH: TDataSetProvider;
    qryConsultas: TClientDataSet;
    TTIPOVEHICU: TClientDataSet;
    TFRECUENCIA: TClientDataSet;
    qryConsultasTTIPOESPVEH: TClientDataSet;
    qryConsultasTTIPODESVEH: TClientDataSet;
    procedure btnModificarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure DBGrid4DblClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSalirClick(Sender: TObject);
    procedure PgCtrlTiposTarifasPeriodicidadChange(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure Inicializar_MantenimientoTiposTarifasPeriodicidad;
    function Modificar_TablaTTIPOVEHICU (CodigoVeh: integer; DatFrmTariTMax: tDatos_FormTarifasTMaximos): boolean;
    function Modificar_TablaTFRECUENCIA (CodigoFrecuencia: integer; DatFrmFrecuencia: tDatos_FormPeriodicidad): boolean;
    procedure Refrescar_Form_Tarifas_TMaximos;
    procedure Refrescar_Form_Frecuencias;
    procedure Refrescar_Form_Especie;
    procedure Refrescar_Form_Destino;
    function Modificar_TablaTTIPOESP (CodigoEspecie: integer; DatFrmEspDest: tDatos_FormEspDest): boolean;
    function Modificar_TablaTTIPODES (CodigoDestino: integer; DatFrmEspDest: tDatos_FormEspDest): boolean;
    function Modificar_TablaTGRUPOTIPOS (CodigoGrupo: integer; DatFrmEspDest: tDatos_FormEspDest): boolean;
    procedure InicializarHints_TiposTarifasPeriodicidad;

  public
    { Public declarations }
  end;


  procedure Mantenimiento_TiposTarifasPeriodicidad (aForm: TForm);


var
  frmTiposTarifasPeriodicidad: TfrmTiposTarifasPeriodicidad;

implementation

uses
    ULOGS,
    UFPRINTMAXIMUMTIMES, UFPRINTPERIODICITY, UFPRINTSPECIES, UFPRINTDESTINY,
    UCDIALGS,
    GLOBALS,
    UUTILS,
    UFTMP,
    USAGESTACION;

{$R *.DFM}


resourcestring
      FICHERO_ACTUAL = 'UFPeriodicityTipesTas';
      CABECERA_MENSAJES_TIPOSTAR = 'Tipos, Tarifas y Periodicidad';

      { Hints enviados desde el form MTarTMax }
      HNT_TTM_PORCENTARIFA = 'Porcentaje de Tarifa Básica| % de Tarifa Básica a aplicar a un vehículo';
      HNT_TTM_PORCENTMAX = 'Máximo nº minutos| Máximo número de minutos que un vehículo puede tardar en pasar la inspección';
      HNT_TTM_NOMVEH = 'Tipo del vehículo|Nombre de vehículo a aplicar dicha tarifa y tiempo máximo';
      HNT_TTM_ACEPTAR = 'Modificar la tarifa y tiempo máximo|Modificar los datos que se muestran';
      HNT_TTM_CANCELAR = 'NO modificar nada|Cancelar la operación de modificar los datos que se muestran';

      { Mensajes enviados desde el form MTarTMax }
      MSJ_TTM_TARNOVAL = 'La tarifa introducida no es válida';
      MSJ_TTM_TIEMNOVAL = 'El tiempo máximo introducido no es válido';
      MSJ_TTM_NOMVAC = 'Es obligatorio introducir el nombre del vehículo';
      MSJ_SISTEMA_INESTABLE = 'Ha ocurrido un error grave en la base de datos. El sistema está inestable, con lo que deberá reiniciarlo de nuevo';

      { Hints enviados al usuario desde el form MTiTaPer }
      HNT_MTITAPER_TARIF = 'Tarifas y Tiempos Máximos permitidos|Tarifas y Tiempos Máximos de vehículos permitidos';
      HNT_MTITAPER_PER = 'Antigüedades, Periodicidades y Clasificaciones permitidas|Antigüedades, Periodicidades y Clasificaciones de vehículos permitidas';
      HNT_MTITAPER_ESP = 'Descripción y Tipo del Vehículo por especie|Descripción y Tipo del vehículo permitido en cuanto a su especie';
      HNT_MTITAPER_DES = 'Descripción y Tipo del Vehículo por destino de servicio|Descripción y Tipo del vehículo permitido en cuanto a su destino servicio';
      HNT_MTITAPER_MODIF_TARIF = 'Modificar tarifas y tiempos máximos|Modificar la tarifa, tiempo máximo y/o nombre del vehículo señalado ';
      HNT_MTITAPER_IMPR_TARIF = 'Imprimir tarifas y tiempos máximos|Imprimir las tarifa, tiempos máximos y nombres de vehículos';
      HNT_MTITAPER_MODIF_PER = 'Modificar antigüedades, periodicidades de vehículos|Modificar la antigüedad, periodicidad y/o clasificación del vehículo señalado ';
      HNT_MTITAPER_IMPR_PER = 'Imprimir antigüedades, periodicidades|Imprimir las antigüedades, periodicidades y clasificaciones de vehículos';
      HNT_MTITAPER_MODIF_ESP = 'Modificar descripción y clasificación del vehículo por su especie|Modificar la descripción y/o clasificación del vehículo señalado según su especie';
      HNT_MTITAPER_IMPR_ESP = 'Imprimir descripción y tipos de vehículos según su especie|Imprimir las descripciones y tipos de vehículos según su especie';
      HNT_MTITAPER_MODIF_DES = 'Modificar descripción y clasificación del vehículo por su especie|Modificar la descripción y/o clasificación del vehículo señalado según su destino servicio';
      HNT_MTITAPER_IMPR_DES = 'Imprimir descripción y tipos de vehículos según su destino servicio|Imprimir las descripciones y tipos de vehículos según su destino servicio';
      HNT_MTITAPER_TERMINAR = 'Salir del mantenimiento|Salir del mantenimiento de Tipos, Tarifas y Periodicidad';

      { Mensajes enviados al usuario desde MTiTaPer }
      MSJ_MTITAPER_HAYCAMB = 'Para que este cambio tenga efecto deberá reinicializar la aplicación';


procedure Mantenimiento_TiposTarifasPeriodicidad (aForm: TForm);
var
  frmTiposTarifasPeriodicidad_Auxi: TfrmTiposTarifasPeriodicidad;

begin
    aForm.Enabled := False;
    try
      FTmp.Temporizar(True,True,'Mantenimiento Tipos, Tarifas y Periodicidad','Iniciando Mantenimiento Tipos, Tarifas y Periodicidad');
      frmTiposTarifasPeriodicidad_Auxi := TfrmTiposTarifasPeriodicidad.Create(Application);
      try
         frmTiposTarifasPeriodicidad_Auxi.ShowModal;
      finally
           frmTiposTarifasPeriodicidad_Auxi.Free
      end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;
end;


var
  bTiposModificados: boolean; { Devuelve true si se ha produdido algún cambio
                                en Tarifas, Especie y Destino Servicio }


procedure TfrmTiposTarifasPeriodicidad.btnModificarClick(Sender: TObject);
var
  CodigoVehiculo: integer; { Código del vehículo necesario para poder modificar
                             datos en la tabla TTIPOVEHICU }
  CodigoFrecuencia: integer; { Código de frecuencia necesario para poder modificar
                             datos en la tabla TFRECUENCIA }
  CodigoEspecie, CodigoGrupo, CodigoDestino: integer;
  DatFrmTariTMax: tDatos_FormTarifasTMaximos; { Para leer los datos de MTarTMax}
  DatFrmFrecuencia : tDatos_FormPeriodicidad; { Para leer los datos de MPeriod}
  DatFrmEspDest: tDatos_FormEspDest;
  frmModificarTarifa_Auxi: TfrmModificarTarifa;
  frmModificarPeriodicidad_Auxi: TfrmModificarPeriodicidad;
  frmModificarEspDest_Auxi: TfrmModificarEspDest;

begin
  frmModificarTarifa_Auxi := nil;
  frmModificarPeriodicidad_Auxi := nil;
  frmModificarEspDest_Auxi := nil;
  try
    with PgCtrlTiposTarifasPeriodicidad do
    begin
        if ActivePage = TSheetTarifas then
        begin
            {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (TRAZA_FLUJO,1, FICHERO_ACTUAL,'Se va a intentar modificar TTIPOVEHICU');
            {$ENDIF}
            frmModificarTarifa_Auxi := TfrmModificarTarifa.CreateByTarifa
                  (TTipoVehicu.FieldByName (FIELD_TARIFAVE).AsInteger,
                   TTipoVehicu.FieldByName (FIELD_TIEMPMAX).AsInteger,
                   TTipoVehicu.FieldByName (FIELD_NOMTIPVE).AsString);

            if frmModificarTarifa_Auxi.ShowModal = mrOk then
            begin
                CodigoVehiculo := TTIPOVEHICU.FieldByName (FIELD_TIPOVEHI).AsInteger;
                // Hay que modificar una tupla de la tabla TTIPOVEHICU
                frmModificarTarifa_Auxi.LeerForm_TarifasTMaximos (DatFrmTariTMax);
                if Modificar_TablaTTIPOVEHICU (CodigoVehiculo, DatFrmTariTMax) then
                begin
                    bTiposModificados := True;
                    Refrescar_Form_Tarifas_TMaximos;
                end;
            end;
        end
        else if ActivePage = TSheetPeriodicidad then
        begin
            {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (TRAZA_FLUJO,2, FICHERO_ACTUAL,'Se va a intentar modificar TFRECUENCIAS');
            {$ENDIF}
            frmModificarPeriodicidad_Auxi := TfrmModificarPeriodicidad.CreateFromPeriodicity
                (TFRECUENCIA.FieldByName (FIELD_L1).AsInteger, TFRECUENCIA.FieldByName (FIELD_L2).AsInteger,
                 TFRECUENCIA.FieldByName (FIELD_P1).AsInteger, TFRECUENCIA.FieldByName (FIELD_P2).AsInteger,
                 TFRECUENCIA.FieldByName (FIELD_CLASIFIC).AsString);

            if frmModificarPeriodicidad_Auxi.ShowModal = mrOk then
            begin
                CodigoFrecuencia := TFRECUENCIA.FieldByName (FIELD_CODFRECU).AsInteger;
                // Hay que modificar una tupla de la tabla TFRECUENCIA
                frmModificarPeriodicidad_Auxi.LeerForm_Frecuencia (DatFrmFrecuencia);
                if Modificar_TablaTFRECUENCIA (CodigoFrecuencia, DatFrmFrecuencia) then
                   Refrescar_Form_Frecuencias;
            end;
        end
        else if ActivePage = TSheetEspecie then
        begin
            {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (TRAZA_FLUJO,3, FICHERO_ACTUAL,'Se va a intentar modificar TFRECUENCIA');
            {$ENDIF}
            frmModificarEspDest_Auxi := TfrmModificarEspDest.CreateFromEspDest (
               CAPTION_ESPECIE,
               qryConsultasTTIPOESPVEH.FieldByName (FIELD_TIPOVEHI).AsString,
               qryConsultasTTIPOESPVEH.FieldByName (FIELD_CODFRECU).AsString,
               qryConsultasTTIPOESPVEH.FieldByName (FIELD_DESCRIPC).AsString,
               qryConsultasTTIPOESPVEH.FieldByName (FIELD_NOMESPEC).AsString);

            if frmModificarEspDest_Auxi.ShowModal = mrOk then
            begin
                CodigoEspecie := qryConsultasTTipoEspVeh.FieldByName(FIELD_TIPOESPE).AsInteger;

                frmModificarEspDest.LeerForm_EspDest (DatFrmEspDest);
                if Modificar_TablaTTIPOESP (CodigoEspecie, DatFrmEspDest) then
                begin
                    CodigoGrupo := qryConsultasTTipoEspVeh.FieldByName(FIELD_GRUPOTIP).AsInteger;

                    if Modificar_TablaTGRUPOTIPOS (CodigoGrupo, DatFrmEspDest) then
                    begin
                        bTiposModificados := True;
                        Refrescar_Form_Especie;
                    end;
                end;
            end;
        end
        else if ActivePage = TSheetDServicio then
        begin
            {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (TRAZA_FLUJO,4, FICHERO_ACTUAL,'Se va a intentar modificar TTIPODESVEH');
            {$ENDIF}
            frmModificarEspDest_Auxi := TfrmModificarEspDest.CreateFromEspDest(CAPTION_DESTSERV,'',
               qryConsultasTTIPODesVEH.FieldByName (FIELD_CODFRECU).AsString,
               qryConsultasTTIPODesVEH.FieldByName (FIELD_DESCRIPC).AsString,
               qryConsultasTTIPODesVEH.FieldByName (FIELD_NOMDESTI).AsString);

            if frmModificarEspDest_Auxi.ShowModal = mrOk then
            begin
                CodigoDestino := qryConsultasTTipoDesVeh.FieldByName(FIELD_TIPODEST).AsInteger;

                frmModificarEspDest.LeerForm_EspDest (DatFrmEspDest);
                if Modificar_TablaTTIPODES (CodigoDestino, DatFrmEspDest) then
                begin
                    CodigoGrupo := qryConsultasTTipoDesVeh.FieldByName(FIELD_GRUPOTIP).AsInteger;

                    if Modificar_TablaTGRUPOTIPOS (CodigoGrupo, DatFrmEspDest) then
                    begin
                        bTiposModificados := True;
                        Refrescar_Form_Destino;
                    end;
                end;
            end;
        end
    end;
  finally
       frmModificarTarifa_Auxi.Free;
       frmModificarPeriodicidad_Auxi.Free;
       frmModificarEspDest_Auxi.Free
  end;
end;


function TFrmTiposTarifasPeriodicidad.Modificar_TablaTTIPOESP (CodigoEspecie: integer; DatFrmEspDest: tDatos_FormEspDest): boolean;
{ Devuelve False si no se han modificado los datos de la tabla TTIPOESP }
var
  fsql : TStringList;
begin
    try
       if (not MyBD.InTransaction) then
          MyBD.StartTransaction(td);

       try
         with qryConsultas do
         begin
             Close;

             fsql := TStringList.Create;
             fSql.Add ('UPDATE TTIPOESPVEH SET NOMESPEC=:Nombre, TIPOVEHI=:TipoVeh');
             if (DatFrmEspDest.iFrecuencia <> -1) then
                fSql.Add (',      CODFRECU=:CodFrec');
             fSql.Add ('  WHERE TIPOESPE=:CodigoEspecie');
             CommandText := fsql.Text;
             Params.ParamByName('Nombre').AsString := DatFrmEspDest.TipoVeh;
             params.ParamByName('TipoVeh').AsInteger := DatFrmEspDest.iTarifa;

             if (DatFrmEspDest.iFrecuencia <> -1) then
                Params.ParamByName('CodFrec').AsInteger := DatFrmEspDest.iFrecuencia;

             Params.ParamByName('CodigoEspecie').AsInteger := CodigoEspecie;

             {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL,27, FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             Execute;
             Application.ProcessMessages;
         end;
         Result := True;
       except
         on E:Exception do
         begin
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'No se han modificado los datos de TTIPOESPVEH: ' + E.Message);
             Result := False;
         end
       end
    finally
       if MyBD.InTransaction then
       begin
           MyBD.Commit(td);
           Result := True;
       end;
     end
end;

// Devuelve False si no se han modificado los datos de la tabla TTIPODESVEH
function TFrmTiposTarifasPeriodicidad.Modificar_TablaTTIPODES (CodigoDestino: integer; DatFrmEspDest: tDatos_FormEspDest): boolean;
var
  fsql : TStringList;
begin
    try
       if (not MyBD.InTransaction) then
          MyBD.StartTransaction(td);

       try
         with qryConsultas do
         begin
             Close;
             fsql := TStringList.Create;
             fSql.Add ('UPDATE TTIPODESVEH SET NOMDESTI=:Nombre');
             if (DatFrmEspDest.iFrecuencia <> -1) then
                fSql.Add (',      CODFRECU=:CodFrec')
             else
                fSql.Add (',      CODFRECU=''''');
             fSql.Add ('  WHERE TIPODEST=:CodigoDestino');
             CommandText := fsql.Text;

             Params.ParamByName('Nombre').AsString := DatFrmEspDest.TipoVeh;

             if (DatFrmEspDest.iFrecuencia <> -1) then
                Params.ParamByName('CodFrec').AsInteger := DatFrmEspDest.iFrecuencia;

             Params.ParamByName('CodigoDestino').AsInteger := CodigoDestino;
             {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL,28, FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             Execute;
             Application.ProcessMessages;
         end;
         Result := True;
         {$IFDEF TRAZAS}
           FTrazas.PonAnotacion (TRAZA_FLUJO,7,FICHERO_ACTUAL,'No se han modificado los datos de TTIPODESVEH');
         {$ENDIF}
       except
         on E:Exception do
         begin
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,2,FICHERO_ACTUAL,'No se han modificado los datos de TTIPODESVEH: ' + E.Message);
             Result := False;
         end
       end
    finally
        if MyBD.InTransaction then
        begin
            MyBd.Commit(td);
            Result := True;
        end;
     end
end;

// Devuelve False si no se han modificado los datos de la tabla TGRUPOTIPOS
function TFrmTiposTarifasPeriodicidad.Modificar_TablaTGRUPOTIPOS (CodigoGrupo: integer; DatFrmEspDest: tDatos_FormEspDest): boolean;
begin
   try
       if (not MyBd.InTransaction) then
          MyBd.StartTransaction(td);

       try
         with qryConsultas do
         begin
             Close;
             CommandText :='UPDATE TGRUPOTIPOS SET DESCRIPC=:DatFrmEspDest.Descrip WHERE GRUPOTIP=:CodigoGrupo';
             Params[0].AsString := DatFrmEspDest.Descrip;
             Params[1].AsInteger := CodigoGrupo;
             {$IFDEF TRAZAS}
               FTrazas.PonComponente (TRAZA_SQL,29, FICHERO_ACTUAL,qryConsultas);
             {$ENDIF}
             Execute;
             Application.ProcessMessages;
         end;
         Result := True;
       except
         on E:Exception do
         begin
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL,'No se han modificado los datos de TGRUPOTIPOS: ' + E.Message);
             Result := False;
         end
       end;
    finally
         if MyBd.InTransaction then
         begin
             MyBd.Commit(td);
             Result := True;
         end;
     end
end;


{ Modifica una tupla de la tabla TTIPOVEHICU donde el código del vehículo es
  CodigoVeh. Devuelve True si se ha podido modificar dicha tabla y false en caso contrario }
function TfrmTiposTarifasPeriodicidad.Modificar_TablaTTIPOVEHICU (CodigoVeh: integer; DatFrmTariTMax: tDatos_FormTarifasTMaximos): boolean;
begin
    try
        try
           if (not MyBd.InTransaction) then
              MyBd.StartTransaction(td);

           with qryConsultas do
           begin
               Close;
               CommandText := Format('UPDATE TTIPOVEHICU SET TARIFAVE=%d,TIEMPMAX=%d,NOMTIPVE=''%s'' WHERE TIPOVEHI=%d',
                 [DatFrmTariTMax.PorcenTarifa, DatFrmTariTMax.TiempoMax,
                  DatFrmTariTMax.NomVehic,CodigoVeh]);

               {$IFDEF TRAZAS}
                 //FTrazas.PonComponente (TRAZA_SQL,30, FICHERO_ACTUAL,DataDiccionario.qryConsultas);
                 FTrazas.PonComponente (TRAZA_SQL,30, FICHERO_ACTUAL,qryConsultas);
               {$ENDIF}
               Execute;
               Application.ProcessMessages;
               Result := True;
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,11,FICHERO_ACTUAL, 'Los datos de la tabla TTIPOVEHICU se ha modificado correctamente');
               {$ENDIF}
           end;
        except
           on E:Exception do
           begin
               Result := False;
               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'Los datos de la tabla TTIPOVEHICU NO se ha modificado correctamente' + E.Message);
           end;
        end;
    finally
         if MyBd.InTransaction then
         begin
             MyBd.Commit(td);
             Result := True;
         end;
    end;
end;

{ Modifica una tupla de la tabla TFRECUENCIA donde el código de frecuencia es
  CodigoFrecuencia. Devuelve True si se ha podido modificar dicha tabla y false en caso contrario }
function TfrmTiposTarifasPeriodicidad.Modificar_TablaTFRECUENCIA (CodigoFrecuencia: integer; DatFrmFrecuencia: tDatos_FormPeriodicidad): boolean;
var
  fsql : TStringList;
begin
    try
        try
           if (not MyBD.InTransaction) then
              MyBD.StartTransaction(td);

           with qryConsultas do
           begin
               Close;
               fsql := TStringList.Create;
               fSql.Add ('UPDATE TFRECUENCIA');
               fSql.Add ('  SET L1=:DatFrmFrecuencia.L1,L2=:DatFrmFrecuencia.L2,P1=:DatFrmFrecuencia.P1,P2=:DatFrmFrecuencia.P2,CLASIFIC=:DatFrmFrecuencia.Clasificacion');
               fSql.Add ('  WHERE CODFRECU=:CodigoFrecuencia');
               CommandText := fsql.text;
               Params[0].AsInteger := DatFrmFrecuencia.L1;
               Params[1].AsInteger := DatFrmFrecuencia.L2;
               Params[2].AsInteger := DatFrmFrecuencia.P1;
               Params[3].AsInteger := DatFrmFrecuencia.P2;
               Params[4].AsString := DatFrmFrecuencia.Clasificacion;
               Params[5].AsInteger := CodigoFrecuencia;
               {$IFDEF TRAZAS}
                 FTrazas.PonComponente (TRAZA_SQL,31, FICHERO_ACTUAL,qryConsultas);
               {$ENDIF}
               Execute;
               Application.ProcessMessages;
               Result := True;
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,13,FICHERO_ACTUAL, 'Los datos de la tabla TFRECUENCIA se ha modificado correctamente');
               {$ENDIF}
           end;
        except
           on E:Exception do
           begin
               Result := False;
               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'Los datos de la tabla TFRECUENCIA NO se ha modificado correctamente: ' + E.Message);
           end;
        end;
    finally
         if MyBd.InTransaction then
         begin
             MyBd.Commit(td);
             Result := True;
         end;
    end;
end;


procedure TfrmTiposTarifasPeriodicidad.Refrescar_Form_Tarifas_TMaximos;
begin
    try
      TTIPOVEHICU.Refresh;
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,6,FICHERO_ACTUAL, 'Error al refrescar TTIPOVEHICU: ' + E.Message);
        end;
    end;
end;


procedure TfrmTiposTarifasPeriodicidad.Refrescar_Form_Frecuencias;
begin
    try
       TFRECUENCIA.Refresh;
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,7,FICHERO_ACTUAL, 'Error al refrescar TFRECUENCIA: ' + E.Message);
        end;
    end;
end;


procedure TfrmTiposTarifasPeriodicidad.Refrescar_Form_Especie;
begin
    try
      qryConsultasTTipoEspVeh.Close;
      {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL,25, FICHERO_ACTUAL,qryConsultasTTipoEspVeh);
      {$ENDIF}
      qryConsultasTTipoEspVeh.Open;
      Application.ProcessMessages;
      {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (TRAZA_FLUJO,15,FICHERO_ACTUAL, 'Refresco de TTIPOESPVEH correcta');
      {$ENDIF}
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,8,FICHERO_ACTUAL,'Error al refrescar qryConsultasTTIPOESPVEH: ' + E.Message);
        end;
    end;
end;


procedure TfrmTiposTarifasPeriodicidad.Refrescar_Form_Destino;
begin
    try
       qryConsultasTTipoDesVeh.Close;
      {$IFDEF TRAZAS}
        FTrazas.PonComponente (TRAZA_SQL,26, FICHERO_ACTUAL,qryConsultasTTipoDesVeh);
      {$ENDIF}
       qryConsultasTTipoDesVeh.Open;
       Application.ProcessMessages;
      {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (TRAZA_FLUJO,16,FICHERO_ACTUAL, 'Refresco de TTIPODESVEH correcta');
      {$ENDIF}
    except
        on E:Exception do
        begin
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,9,FICHERO_ACTUAL,'Error al refrescar qryConsultasTTipoDesVeh: ' + E.Message);
        end;
    end;
end;


procedure TfrmTiposTarifasPeriodicidad.FormCreate(Sender: TObject);
begin
   bTiposModificados := False;
   try
      with qryConsultasTTipoEspVeh do
      begin
          Close;
          sdsqryConsultasTTipoEspVeh.SQLConnection := MyBD;
          Open;
          Application.ProcessMessages;
      end;


      with qryConsultasTTipoDesVeh do
      begin
          Close;
          sdsqryConsultasTTIPODESVEH.SQLConnection := MyBD;
          Open;
          Application.ProcessMessages;
      end;

      with TTIPOVEHICU do
      begin
          Close;
          sdsTTIPOVEHICU.SQLConnection := MyBD;
          Open;
          Application.ProcessMessages;
      end;

      with TFRECUENCIA do
      begin
          Close;
          sdsTFRECUENCIA.SQLConnection := MyBD;
          Open;
          Application.ProcessMessages;
      end;

      sdsqryConsultas.SQLConnection := MyBD;
      Application.ProcessMessages;
      
      InicializarHints_TiposTarifasPeriodicidad;
   except
       on E:Exception do
       begin
           FAnomalias.PonAnotacion (TRAZA_SIEMPRE,10,FICHERO_ACTUAL,'Error en el OnCreate de MTiTaPer: ' + E.Message);
       end;
   end;
end;


procedure TfrmTiposTarifasPeriodicidad.InicializarHints_TiposTarifasPeriodicidad;
begin
    DBGrid1.Hint := HNT_MTITAPER_TARIF;
    DBGrid2.Hint := HNT_MTITAPER_PER;
    DBGrid3.Hint := HNT_MTITAPER_ESP;
    DBGrid4.Hint := HNT_MTITAPER_DES;
    btnModificar.Hint := HNT_MTITAPER_MODIF_TARIF;
    btnImprimir.Hint := HNT_MTITAPER_IMPR_TARIF;
    btnSalir.Hint := HNT_MTITAPER_TERMINAR;
end;


procedure TfrmTiposTarifasPeriodicidad.FormActivate(Sender: TObject);
begin
    Inicializar_MantenimientoTiposTarifasPeriodicidad;
    FTmp.Temporizar(False,True,'','');
end;


procedure TfrmTiposTarifasPeriodicidad.Inicializar_MantenimientoTiposTarifasPeriodicidad;
begin
    PgCtrlTiposTarifasPeriodicidad.ActivePage := TSheetTarifas;
    DBGrid1.setfocus;
end;


procedure TfrmTiposTarifasPeriodicidad.DBGrid1DblClick(Sender: TObject);
begin
    btnModificarClick(Sender);
end;

procedure TfrmTiposTarifasPeriodicidad.DBGrid2DblClick(Sender: TObject);
begin
    btnModificarClick(Sender);
end;

procedure TfrmTiposTarifasPeriodicidad.DBGrid3DblClick(Sender: TObject);
begin
    btnModificarClick(Sender);
end;

procedure TfrmTiposTarifasPeriodicidad.DBGrid4DblClick(Sender: TObject);
begin
    btnModificarClick(Sender);
end;

procedure TfrmTiposTarifasPeriodicidad.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TfrmTiposTarifasPeriodicidad.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    { Si se pulsa Alr+F4 => se asocia dicha combinación de teclas a CANCELAR }
    if Ha_Pulsado_AltF4 (Shift, Key) then
       btnSalirClick(Sender);
end;

procedure TfrmTiposTarifasPeriodicidad.btnSalirClick(Sender: TObject);
begin
    if bTiposModificados then
       MessageDlg (CABECERA_MENSAJES_TIPOSTAR, MSJ_MTITAPER_HAYCAMB, mtInformation, [mbOk], mbOk, 0);
end;

procedure TfrmTiposTarifasPeriodicidad.PgCtrlTiposTarifasPeriodicidadChange(
  Sender: TObject);
begin
    with PgCtrlTiposTarifasPeriodicidad do
    begin
        if ActivePage = TSheetTarifas then
        begin
            btnModificar.Hint := HNT_MTITAPER_MODIF_TARIF;
            btnImprimir.Hint := HNT_MTITAPER_IMPR_TARIF;
        end
        else if ActivePage = TSheetPeriodicidad then
        begin
            btnModificar.Hint := HNT_MTITAPER_MODIF_PER;
            btnImprimir.Hint := HNT_MTITAPER_IMPR_PER;
        end
        else if ActivePage = TSheetEspecie then
        begin
            btnModificar.Hint := HNT_MTITAPER_MODIF_ESP;
            btnImprimir.Hint := HNT_MTITAPER_IMPR_ESP;
        end
        else if ActivePage = TSheetDServicio then
        begin
            btnModificar.Hint := HNT_MTITAPER_MODIF_DES;
            btnImprimir.Hint := HNT_MTITAPER_IMPR_DES;
        end
    end;
end;

procedure TfrmTiposTarifasPeriodicidad.btnImprimirClick(Sender: TObject);
var
  frmImprimirTiTaPer_Auxi: TfrmImprimirTiTaPer;
  frmPeriodicidad_Auxi: TfrmPeriodicidad;
  frmEspecie_Auxi: TfrmEspecie;
  frmDServicio_Auxi: TfrmDServicio;
  aFTmp: TFTmp;

begin
    frmImprimirTiTaPer_Auxi := nil;
    frmPeriodicidad_Auxi := nil;
    frmEspecie_Auxi := nil;
    frmDServicio_Auxi := nil;
    aFTmp := nil;
    try
       aFTmp := TFTmp.Create (Application);
       aFTmp.MuestraClock('Impresión','Imprimiendo Listado...');

       with PgCtrlTiposTarifasPeriodicidad do
       begin
           if ActivePage = TSheetTarifas then
           begin
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,17, FICHERO_ACTUAL,'Se va a intentar imprimir TTIPOVEHICU');
               {$ENDIF}
               frmImprimirTiTaPer_Auxi := TfrmImprimirTiTaPer.Create (Application);

               if ImpresoraPreparada_ImprimirInformes then
               begin
                   frmImprimirTiTaPer_Auxi.QRTarifasTM.Print;
               end
               else
               begin
                   aFTmp.Hide;
                   Lanzar_ErrorImpresion_Mantenimiento;
               end;
           end
           else if ActivePage = TSheetPeriodicidad then
           begin
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,18, FICHERO_ACTUAL,'Se va a intentar imprimir TFRECUENCIAS');
               {$ENDIF}
               frmPeriodicidad_Auxi := TfrmPeriodicidad.Create (Application);

               if ImpresoraPreparada_ImprimirInformes then
               begin
                   frmPeriodicidad_Auxi.QRFrecuencia.Print;
               end
               else
               begin
                   aFTmp.Hide;
                   Lanzar_ErrorImpresion_Mantenimiento;
               end
           end
           else if ActivePage = TSheetEspecie then
           begin
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,19, FICHERO_ACTUAL,'Se van a intentar imprimir las Especies');
               {$ENDIF}
               frmEspecie_Auxi := TfrmEspecie.Create (Application);

               if ImpresoraPreparada_ImprimirInformes then
               begin
                   frmEspecie_Auxi.SeleccionarEspecie;
                   frmEspecie_Auxi.QREspecie.Print;
               end
               else
               begin
                   aFTmp.Hide;
                   Lanzar_ErrorImpresion_Mantenimiento;
               end
           end
           else if ActivePage = TSheetDServicio then
           begin
               {$IFDEF TRAZAS}
                 FTrazas.PonAnotacion (TRAZA_FLUJO,21, FICHERO_ACTUAL,'Se van a intentar imprimir los destinos de servicio');
               {$ENDIF}
               frmDServicio_Auxi := TfrmDServicio.Create (Application);

               if ImpresoraPreparada_ImprimirInformes then
               begin
                  frmDServicio_Auxi.SeleccionarDServicio;
                  frmDServicio_Auxi.QRDServicio.Print;
               end
               else
               begin
                   aFTmp.Hide;
                   Lanzar_ErrorImpresion_Mantenimiento;
               end
           end
       end;
    finally
         frmImprimirTiTaPer_Auxi.Free;
         frmPeriodicidad_Auxi.Free;
         frmEspecie_Auxi.Free;
         frmDServicio_Auxi.Free;
         aFTmp.Free;
    end;
end;

procedure TfrmTiposTarifasPeriodicidad.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    qryConsultasTTipoEspVeh.Close;
    qryConsultasTTipoDesVeh.Close;
    qryConsultas.Close;
    TTIPOVEHICU.Close;
    TFRECUENCIA.Close;
end;






end.
