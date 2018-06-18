unit UFinVeri;

interface

uses
  Windows, Messages, SysUtils, Classes,Winspool, Graphics, Controls, Forms, sqlExpr, UFRMSCANEOCERTIFICADO,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Grids, DBGrids, DB, Mask,  ufrmscanearnrooblea, class_impresion,
  USAGCLASSES,UtilOracle,USAGVARIOS, uUtils, Provider, DBClient,UnitfrmsMOTIVO_CANCELAMIENTO, ADODB, uinforme,usuperregistry,uversion;

type

  tResultado = (APTO, CONDICIONAL, RECHAZADO);

  tIZonas = (tPasa, tNopasa, tNoSe);

  tRegZonas = record
    z1, z2, z3 : tIzonas;
  end;

  tRegMediciones = record
    efs, efe, da1, da2, de1, co2, kme, fx1, fx2 : tIzonas;
  end;

  TFrmFinal = class(TForm)
    LabelTMatricula: TLabel;
    CheckBaja: TCheckBox;
    LabelTInspector: TLabel;
    Bevel2: TBevel;
    LabelDeficiencias: TLabel;
    BtnCancelar: TBitBtn;
    MemoDeficiencias: TMemo;
    LabelMatricula: TLabel;
    LabelInspector: TLabel;
    LabelApta: TLabel;
    LabelCondicional: TLabel;
    LabelRechazada: TLabel;
    BtnAceptar: TBitBtn;
    Label1: TLabel;
    BtnReiniciar: TBitBtn;
    LabelVencimiento: TLabel;
    Bevel3: TBevel;
    Panel1: TPanel;
    Panel3: TPanel;
    PZ3: TPanel;
    PZ1: TPanel;
    PZ2: TPanel;
    bStandBy: TBitBtn;
    InspeccionesSource: TDataSource;
    Bevel4: TBevel;
    Bevel5: TBevel;
    bPagar: TBitBtn;
    ObleaPanel: TPanel;
    PMeses: TPanel;
    P12: TPanel;
    P11: TPanel;
    P10: TPanel;
    P9: TPanel;
    P8: TPanel;
    P7: TPanel;
    P6: TPanel;
    P5: TPanel;
    P4: TPanel;
    P3: TPanel;
    P2: TPanel;
    P1: TPanel;
    LColor: TLabel;
    BEdtObleaold: TMaskEdit;
    LabelTOblea: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    pda1: TPanel;
    pkme: TPanel;
    pde1: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    pefs: TPanel;
    pefe: TPanel;
    pda2: TPanel;
    pco2: TPanel;
    dsDatinspecc: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBText4: TDBText;
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    LblMarcaModelo: TLabel;
    Bevel6: TBevel;
    Label2: TLabel;
    lblFabricado: TLabel;
    Bevel7: TBevel;
    pfx1: TPanel;
    pfx2: TPanel;
    Panel15: TPanel;
    Panel20: TPanel;
    Label23: TLabel;
    Bevel1: TBevel;
    LabelTipo: TLabel;
    Bevel8: TBevel;
    InpePanel: TPanel;
    lblNroInspe: TLabel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    I1: TPanel;
    I2: TPanel;
    I3: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    BEdtOblea: TEdit;
    Label6: TLabel;
    Label8: TLabel;
    Panel7: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    DBText8: TDBText;
    Panel24: TPanel;
    DBText10: TDBText;
    Panel30: TPanel;
    DBText13: TDBText;
    Label5: TLabel;
    procedure BtnReiniciClick(Sender: TObject);
    procedure CheckBajaClick(Sender: TObject);
    procedure BEdtObleaoldKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAceptaClick(Sender: TObject);
    procedure bStandByClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bPagarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BEdtObleaoldChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Timer1Timer(Sender: TObject);
  private
    iObleaEnVarios : integer;
    TipoGas: string;
    FDataBase: TSQLConnection;
    FInspeccion : TInspeccion;
    FInspecciones: TEstadoInspeccion;
    FDatInspecc : TDatinspecc; //
    procedure ObtenerDatosFinales (var aResultado : tResultado);
    procedure ActualizacionNumeroOblea(const iNumero : Integer);
    function FinalizarInspeccion : boolean;
    function GetColor (const aId: integer) : string;
    Function GetDeficienaciasCount: Integer;
    Procedure InspeccionSinOblea;
    Function GetStandByEnabled:Boolean;
    function PasaPorZonas : tRegZonas;
    Function FormatNumOblea(Cad:Integer):String;
    function getFactura_POR_PAGOID(PAGOID:LONGINT):string;
    Procedure LlenarDatosVehiculo;
    Function ValoresMedicion : tRegMediciones;
    procedure PintaPanelesMedicion(aMediciones: tRegMediciones);
    function CALCULA_CANTIDAD_HOJA(CODINSPE,EJERCI:LONGINT):LONGINT;
    function imprimir_certificado_caba(codinspe,ejercicio:longint):boolean;
    function IsPrinterAvailable: boolean;
  public
    { Public declarations }
    NROBLEASCANEADA,aniooblea:STRING;
    VARIABLE_COLOR:LONGINT;
    CLASEVEHIVULO:LONGINT;
    function imprime_certificado:boolean ;
    function entrega_oblea_a_condicionales:boolean;
    function Tiene_Alerta (const dominio: string) : string;
    Constructor CreateFromInspeccion(aInspeccion:TEstadoInspeccion);
    procedure RellenarDatosFinales;
    function ObtenerReenvio(Cod_Inspeccion: String):Boolean; //Lucho
    Procedure InsertarReenvio(Cod_Inspeccion: String);       //Lucho
    Function Encontrar_Auditoria(sInspeccion, sEjercicio: String): Boolean; // Lucho
    function  CALCULAR_DIGITO_VERIFICADOR(PATENTE:STRING):LONGINT;
     FUNCTION MOTIVO_CANCELAMIENTO:STRING;
  end;

var
    FrmFinal: TFrmFinal;
    vObleas, vAnioVenci: Integer;
    vObleaAsig,vobleass: String;
    Imprimio: Boolean = false;

const
    DEFICIENCIAS = 'DEFICIENCIAS OBSERVADAS: ';
    CADENA_VACIA = '';
    CAD_OK = ' Ok: ';
    NUMERO_COLORES = 6;
    MSJ_PAGAR_PREVERIFICACION = '� Desea Pagar La Preverificaci�n Para Obtener Validez Oficial ?';


implementation

uses
    UFTmp,
    UCDialgs,
    ULOGS,
    UDATEVEN,
    UCTIMPRESION,
    UCLIENTE,
    USAGESTACION,
    UCTEVERIFICACIONES,
    Globals,
    ufMedicionesAutomaticas,
    ucomunic, Ufrmturnos, UcertificadoCABA, UMENSAJEIMPRESION,
  UnitINGREAR_CODTURNO_MANUAL, Unitmensaje;

    {$R *.DFM}

const
    FICHERO_ACTUAL = 'UFinVeri.pas';
    COMBUSTIBLE_NAFTA = 'N';
    COMBUSTIBLE_GASOIL = 'L';
    COMBUSTIBLE_GNC = 'G';
    COMBUSTIBLE_MEZCLA = 'M';
    COMBUSTIBLE_NULL = '';


type
    EDatosMalEnTDATOSINSPECC = class (Exception);


 FUNCTION TFrmFinal.MOTIVO_CANCELAMIENTO:STRING;
 BEGIN
       with tfrmsMOTIVO_CANCELAMIENTO.create(nil) do
        begin
            showmodal;

            MOTIVO_CANCELAMIENTO:=trim(combobox1.text);
        END;
 END;

function TFrmFinal.ObtenerReenvio(Cod_Inspeccion: String):Boolean;
var
TraeDatos:TSQLQuery;
begin
TraeDatos:=TSQLQuery.Create(nil);
  with TraeDatos do
    begin
    SQLConnection:=mybd;
    SQL.Add('SELECT COUNT (*) FROM TREENVIOLINEA WHERE CODINSPE = :COD_INSPECCION AND ESTADO IS NULL ORDER BY FECHALTA');
    ParamByName('COD_INSPECCION').Value:=Cod_Inspeccion;
      try
        Open;
        if (Fields[0].Value <> 0) then
        Result:=true;
      finally
        Close;
        Free;
      end;
    end;
end;


function TFrmFinal.imprimir_certificado_caba(codinspe,ejercicio:longint):boolean;

var aq: TSQLQuery;
    codpro:longint;
    codcon:longint;
    fechalta:string;
    numoblea:string;
    fechavenci:string;
    resultad:string;
    observa:string;
    CODVEHIC:LONGINT;
    NRO_INFORME:STRING;
    {TITULAR}
    TITULARNOMBRE:STRING;
    TITULARAPELLID1:STRING;
    TITULARAPELLID2:STRING;
    TITULARDOCUMENT:STRING;
    TIPODOCU:LONGINT;
    TITULARDOCUMENTODESCRIPCION:STRING;

    {CONDUCTOR}
    CONDUCTORDOCUMENTODESCRIPCION:STRING;
    CONDUCTORNOMBRE:STRING;
    CONDUCTORPELLID1:STRING;
    CONDUCTORPELLID2:STRING;
    CONDUCTORDOCUMENT:STRING;

    {VEHICULO}
    tipodest:LONGINT;
    tipoESPE:LONGINT;
    codmodelo:LONGINT;
    codmarca:LONGINT;
    DOMINIO:STRING;
    ANIOFABR:STRING;
    CHASIS:STRING;
    MARCAVEHICULO:STRING;
    cantidadhojas:LONgint;
    MODELOVEHICULO:sTRING;
    HORENTZ1,HORSALZ1,HORENTZ2 ,HORSALZ2,HORENTZ3,HORSALZ3:STRING;
    LblXHoraIngreso, LblXHegr,LblXHTTE,LblXHTTL,HORFINAL:STRING;
    {PLANTA}
    PLANTA:STRING;
begin
  cantidadhojas:=CALCULA_CANTIDAD_HOJA(codinspe,ejercicio);


aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('select NRO_INFORME from certificadoinspeccion WHERE CODINSPE=:CODINSPE ');
              ParamByName('CODINSPE').Value:=codinspe;
                try
                  Open;
                    NRO_INFORME:=trim(aq.fieldbyname('NRO_INFORME').asstring);

                  finally
                    Close;
                    Free;
                end;
            end;


aQ:=TSQLQuery.Create(nil);



     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('select CODVEHIC, codclpro,codclcon,fechalta,numoblea,fecvenci,resultad,observac, HORFINAL, '+
              ' HORENTZ1,HORSALZ1,HORENTZ2 ,HORSALZ2,HORENTZ3,HORSALZ3 from tinspeccion ');
              sql.adD('where EJERCICI = :EJERCICI AND CODINSPE = :CODINSPE ');
              ParamByName('CODINSPE').Value:=codinspe;
              ParamByName('EJERCICI').Value:=ejercicio;
                try
                  Open;
                    CODVEHIC:=aq.fieldbyname('CODVEHIC').asinteger;
                    codpro:=aq.fieldbyname('codclpro').asinteger;
                    codcon:=aq.fieldbyname('codclcon').asinteger;
                    fechalta:=trim(aq.fieldbyname('fechalta').asstring);
                    numoblea:=trim(aq.fieldbyname('numoblea').asstring);
                    fechavenci:=trim(aq.fieldbyname('fecvenci').asstring);
                    resultad:=trim(aq.fieldbyname('resultad').asstring);
                    observa:=trim(aq.fieldbyname('observac').asstring);
                    HORFINAL:=trim(aq.fieldbyname('HORFINAL').asstring);
                    LblXHoraIngreso := FormatDateTime('hh:nn:ss',StrToDateTime(trim(aq.fieldbyname('fechalta').asstring)));
                    LblXHegr := FormatDateTime('hh:nn:ss',StrToDateTime(trim(aq.fieldbyname('HORFINAL').asstring)));
                    HORENTZ1:=trim(aq.fieldbyname('HORENTZ1').asstring);
                    HORSALZ1:=trim(aq.fieldbyname('HORSALZ1').asstring);
                    HORENTZ2:=trim(aq.fieldbyname('HORENTZ2').asstring);
                    HORSALZ2:=trim(aq.fieldbyname('HORSALZ2').asstring);
                    HORENTZ3:=trim(aq.fieldbyname('HORENTZ3').asstring);
                    HORSALZ3:=trim(aq.fieldbyname('HORSALZ3').asstring);










                     if trim(resultad)='A' then
                        resultad:='APROBADO';

                     if trim(resultad)='C' then
                        resultad:='CONDICIONAL';

                     if trim(resultad)='R' then
                        resultad:='RECHAZADO';


                  finally
                    Close;
                    Free;
                end;
            end;

     {TIEMPOS}

     aq:=tsqlquery.create(self);

               try
                 aq.SQLConnection := MyBD;
                 aq.sql.add('alter session set nls_date_format = ''dd/mm/yyyy hh24:mi:ss''');
                 aq.ExecSQL;
                 aq.SQL.Clear;
                 aq.sql.add(format('select mayorfecha(''%s'',''%s'',''%s'',''%s''), menorfecha(''%s'',''%s'',''%s'',''%s'') from dual',[HORSALZ1,HORSALZ2,HORSALZ3,HORFINAL,HORENTZ1,HORENTZ2,HORENTZ3,fechalta]));
                 aq.open;
                 LblXHTTL := FormatDateTime('hh:nn:ss',
                    (
                     aq.Fields[0].asdatetime - aq.Fields[1].asdatetime
                    )
                 );




        except
            on E:Exception do
               LblXHTTL := '';
        end;
        aq.CLOSE;
         aq.free;
        try
           LblXHTTE := FormatDateTime('hh:nn:ss', (StrToDateTime(HORFINAL) -  StrToDateTime(fechalta)));
        except
            on E:Exception do
               LblXHTTE := '';
        end;

     {FIN TIEMPOS}

   {DATOS DEL TITULAR}
    aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT NOMBRE, APELLID1,APELLID2,DOCUMENT,TIPODOCU FROM TCLIENTES WHERE CODCLIEN=:CODINSPE ');
              ParamByName('CODCLIEN').Value:=codpro;

                try
                  Open;
                    TIPODOCU:=aq.fieldbyname('TIPODOCU').asinteger;
                    TITULARNOMBRE:=trim(aq.fieldbyname('NOMBRE').asstring);
                    TITULARAPELLID1:=trim(aq.fieldbyname('APELLID1').asstring);
                    TITULARAPELLID2:=trim(aq.fieldbyname('APELLID2').asstring);
                    TITULARDOCUMENT:=trim(aq.fieldbyname('DOCUMENT').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;



       aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT DESCRIPCION FROM TTIPO_DOCUMENTO WHERE CODDOCU=:CODDOCU ');
              ParamByName('CODDOCU').Value:=TIPODOCU;

                try
                  Open;
                    TITULARDOCUMENTODESCRIPCION:=trim(aq.fieldbyname('DESCRIPCION').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;


   {FIN DATOS TITULAR}


   {DATOS CONDUCTOR}
    aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT NOMBRE, APELLID1,APELLID2,DOCUMENT,TIPODOCU FROM TCLIENTES WHERE CODCLIEN=:CODINSPE ');
              ParamByName('CODCLIEN').Value:=codcon;

                try
                  Open;
                    TIPODOCU:=aq.fieldbyname('TIPODOCU').asinteger;
                    CONDUCTORNOMBRE:=trim(aq.fieldbyname('NOMBRE').asstring);
                    CONDUCTORPELLID1:=trim(aq.fieldbyname('APELLID1').asstring);
                    CONDUCTORPELLID2:=trim(aq.fieldbyname('APELLID2').asstring);
                    CONDUCTORDOCUMENT:=trim(aq.fieldbyname('DOCUMENT').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;



       aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT DESCRIPCION FROM TTIPO_DOCUMENTO WHERE CODDOCU=:CODDOCU ');
              ParamByName('CODDOCU').Value:=TIPODOCU;

                try
                  Open;
                    CONDUCTORDOCUMENTODESCRIPCION:=trim(aq.fieldbyname('DESCRIPCION').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;
   {FIN DATOS CONDUCTOR}




   {DATOS VEHICULO}
    aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT patenten,aniofabr,codmarca, codmodelo,nummotor,tipodest,tipoespe from tvehiculo where codvehic=:codvehic');
              ParamByName('codvehic').Value:=CODVEHIC;

                try
                  Open;
                    tipodest:=aq.fieldbyname('tipodest').asinteger;
                    tipodest:=aq.fieldbyname('tipoespe').asinteger;
                    codmodelo:=aq.fieldbyname('codmodelo').asinteger;
                    codmarca:=aq.fieldbyname('codmarca').asinteger;
                    DOMINIO:=trim(aq.fieldbyname('patenten').asstring);
                    ANIOFABR:=trim(aq.fieldbyname('aniofabr').asstring);
                    CHASIS:=trim(aq.fieldbyname('nummotor').asstring);

                    finally
                    Close;
                    Free;
                end;
            end;



       aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT NOMMARCA FROM TMARCAS WHERE CODMARCA=:CODMARCA ');
              ParamByName('CODMARCA').Value:=codmarca;

                try
                  Open;
                    MARCAVEHICULO:=trim(aq.fieldbyname('NOMMARCA').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;


          with aQ do
            begin
              SQLConnection:=mybd;
              sql.add('SELECT NOMMODELO FROM TMODELOS WHERE CODMODELO=:CODMODELO ');
              ParamByName('CODMODELO').Value:=codmodelo;

                try
                  Open;
                    MODELOVEHICULO:=trim(aq.fieldbyname('NOMMODELO').asstring) ;

                    finally
                    Close;
                    Free;
                end;
            end;


   {FIN DATOS VEHICULO}



//CERTIFICADOCABA.QuickRep1.PrinterSettings.PrinterIndex:=
with TCERTIFICADOCABA.create(self) do
   begin


    QRLABEL57.Caption:=TRIM(fechalta);
    QRLABEL44.Caption:=TRIM(numoblea);
    QRLABEL45.Caption:=TRIM(fechavenci);
    QRLABEL56.Caption:=TRIM(resultad);



    QRLABEL43.Caption:=TRIM(NRO_INFORME);
    QRLABEL64.Caption:=TRIM(NRO_INFORME);

    QRLABEL73.Caption:=TRIM(fechalta);
    QRLABEL65.Caption:=TRIM(numoblea);
    QRLABEL66.Caption:=TRIM(fechavenci);
    QRLABEL72.Caption:=TRIM(resultad);
   // observa:string;


    {TITULAR}
    QRLABEL47.Caption:=TRIM(TITULARNOMBRE)+' '+TRIM(TITULARAPELLID1)+' '+TRIM(TITULARAPELLID2);
    QRLABEL49.Caption:=TRIM(TITULARDOCUMENTODESCRIPCION)+' '+TRIM(TITULARDOCUMENT);
    QRLABEL68.Caption:=TRIM(TITULARNOMBRE)+' '+TRIM(TITULARAPELLID1)+' '+TRIM(TITULARAPELLID2);
    QRLABEL69.Caption:=TRIM(TITULARDOCUMENTODESCRIPCION)+' '+TRIM(TITULARDOCUMENT);



    {CONDUCTOR}
     QRLABEL70.Caption:=TRIM(CONDUCTORNOMBRE)+' '+TRIM(CONDUCTORPELLID1)+' '+TRIM(CONDUCTORPELLID2);
     QRLABEL71.Caption:=TRIM(CONDUCTORDOCUMENTODESCRIPCION)+' '+TRIM(CONDUCTORDOCUMENT);



    {VEHICULO}
    QRLABEL50.Caption:=TRIM(DOMINIO);
    QRLABEL51.Caption:=TRIM(ANIOFABR);
    QRLABEL55.Caption:=TRIM(CHASIS);
    QRLABEL52.Caption:=TRIM(MARCAVEHICULO);
    QRLABEL53.Caption:=TRIM(MODELOVEHICULO);

    {PLANTA}
    QRLABEL40.Caption:=TRIM(PLANTA);
    QRLABEL38.Caption:=TRIM(PLANTA);


    {TIEMPOS}
  //  QRLABEL58.Caption:=TRIM(LblXHoraIngreso);
   // QRLABEL59.Caption:=TRIM(LblXHegr);
   // QRLABEL61.Caption:=TRIM(LblXHTTE);
   // QRLABEL60.Caption:=TRIM(LblXHTTL);

    QRLABEL62.Caption:=TRIM(DATETOSTR(DATE));
    QRLABEL46.Caption:=INTTOSTR(cantidadhojas);
    QRLABEL63.Caption:=' de '+INTTOSTR(cantidadhojas);
    
   QuickRep1.Prepare;
   QuickRep1.Preview;
   free;
end;

end;


Procedure TFrmFinal.InsertarReenvio(Cod_Inspeccion: String);
var
TraeDatos:TSQLQuery;
begin
TraeDatos:=TSQLQuery.Create(nil);
  with TraeDatos do
  try
    begin
    SQLConnection:=mybd;
    SQL.Clear;
    SQL.Add('INSERT INTO TREENVIOLINEA (CODINSPE, FECHALTA) VALUES (:Cod_Inspeccion, SYSDATE)');
    ParamByName('COD_INSPECCION').Value:=Cod_Inspeccion;
    ExecSQL;
    {$IFDEF TRAZAS}
    FTrazas.PonAnotacion(TRAZA_SIEMPRE,300,FICHERO_ACTUAL,'**********************************************************************************************');
    FTrazas.PonAnotacion(TRAZA_USUARIO,300,FICHERO_ACTUAL,'***  Se inserto el valor "104" en la campo 10002 para la inspeccion N� '+Cod_Inspeccion+'    ***');
    FTrazas.PonAnotacion(TRAZA_SIEMPRE,300,FICHERO_ACTUAL,'**********************************************************************************************');
    {$ENDIF}
    end;
  finally

    Free;
  end;
end;



//**********************
//26.11.2013 para que de obleas a condicionales.
function TFrmFinal.entrega_oblea_a_condicionales:boolean;
begin
    with tsqlQuery.Create(nil) do
    try

        SQLConnection:= fDataBase;
        SQL.Add('SELECT ena_oblc FROM tvarios');
        Open;
        if trim(Fields[0].AsString)='S' then
             result:=true
             else
             result:=false;


    finally
        Close;
        Free;
    end
end;


function TFrmFinal.imprime_certificado:boolean ;
begin
    with tsqlQuery.Create(nil) do
    try

        SQLConnection:= fDataBase;
        SQL.Add('SELECT ena_certi FROM tvarios');
        Open;
        if trim(Fields[0].AsString)='S' then
             result:=true
             else
             result:=false;


    finally
        Close;
        Free;
    end
end;
//**********************


Function TFrmFinal.Encontrar_Auditoria(sInspeccion, sEjercicio: String): Boolean;
var
Total: Integer;
Begin
Result:=false;
With TsqlQuery.Create(nil) do
  Begin
  SQLConnection:=mybd;
  SQL.Add('SELECT COUNT(CODINSPE) AS TOTAL FROM TAUDITORIAINSPECCIONES WHERE CODINSPE = :CODINSPE AND EJERCICI = :EJERCICI');
  Params[0].Value:=sInspeccion;
  Params[1].Value:=sEjercicio;
  Open;
  Total:=Fields[0].Value;
    try
      If (Total>=1) then
      Result:=true;
    finally
      Free;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////


function LineaCon ( const sCod, sDes, sOk, sDl, sDg : string) : string;
const
  CADENA_VACIA = '';
begin
  result := sCod;
  If sOK <>  CADENA_VACIA
  then begin
    result := result + CAD_OK ;
  end
  else begin
        if (sDl = CADENA_VACIA) and (sDg = CADENA_VACIA) then result := result + ' OBS: '
        else if sDl <> CADENA_VACIA then result := result + ' DL: '
            else result := result + ' DG: ';
  end;
  result := result + sDes;
end;

function  TFrmFinal.CALCULAR_DIGITO_VERIFICADOR(PATENTE:STRING):LONGINT;
VAR ULTIMO:string;
  valor:string;
BEGIN
ultimo:=copy(trim(PATENTE),length(trim(PATENTE)),1);
  if (trim(ultimo)='0')  or (trim(ultimo)='1') or (trim(ultimo)='2')
      or (trim(ultimo)='3') or (trim(ultimo)='4') or (trim(ultimo)='5') or (trim(ultimo)='6')
      or (trim(ultimo)='7')  or (trim(ultimo)='8')     or (trim(ultimo)='9')   then
      begin
         valor:=ULTIMO;
       end else begin
            ultimo:=copy(trim(PATENTE),length(trim(PATENTE))-2,1);
               if (trim(ultimo)='0')  or (trim(ultimo)='1') or (trim(ultimo)='2')
                   or (trim(ultimo)='3') or (trim(ultimo)='4') or (trim(ultimo)='5') or (trim(ultimo)='6')
                   or (trim(ultimo)='7')  or (trim(ultimo)='8')     or (trim(ultimo)='9')   then
                   begin
                     valor:=ULTIMO;
                   end else begin
                            ultimo:=copy(trim(PATENTE),length(trim(PATENTE))-3,1);
                            if (trim(ultimo)='0')  or (trim(ultimo)='1') or (trim(ultimo)='2')
                               or (trim(ultimo)='3') or (trim(ultimo)='4') or (trim(ultimo)='5') or (trim(ultimo)='6')
                               or (trim(ultimo)='7')  or (trim(ultimo)='8')     or (trim(ultimo)='9')   then
                               begin
                                     valor:=ULTIMO;
                              end;


                        end;


end;
if trim(valor)<>'' then
CALCULAR_DIGITO_VERIFICADOR:=strtoint(valor);
 {
valor:=TRIM(COPY(TRIM(PATENTE),LENGTH(TRIM(PATENTE)),1));
 if (valor='0') or (valor='1') or (valor='2') or (valor='3') or (valor='4')
  or (valor='5') or (valor='6') or (valor='7') or (valor='8') or (valor='9') then
  begin
    ULTIMO:=STRTOINT(TRIM(COPY(TRIM(PATENTE),LENGTH(TRIM(PATENTE)),1)));

  end else
  begin

     ULTIMO:=STRTOINT(TRIM(COPY(TRIM(PATENTE),5,1)));
  end;
     CALCULAR_DIGITO_VERIFICADOR:=ULTIMO;
     }



END;


Constructor TFrmFinal.CreateFromInspeccion(aInspeccion: TEstadoInspeccion);
begin
    //Crera el forma a partir de los datos de un ESTADOINSPECCION seleccionado previamente
    Screen.Cursor:=crHourGlass;
    FTmp.Temporizar(True,True,'Verificaci�n','Iniciando Inspecci�n en Linea.'+#13#10+'Aguarde un momento por favor...');
    try
        Inherited Create(nil);
        FDataBase:=aInspeccion.DataBase;
        FInspecciones:=aInspeccion;
        FInspeccion := TInspeccion.CreateFromEstadoInspeccion(fInspecciones);
        FInspeccion.Open;
        FInspeccion.First;
        InspeccionesSource.DataSet:=FInspecciones.DataSet;
        LabelMatricula.Caption := FInspecciones.ValueByName[FIELD_MATRICUL];
        LabelInspector.Caption := FVarios.ValueByName[FIELD_NOMRESPO];
        LlenarDatosVehiculo;
        RellenarDatosFinales;
    Finally
        FTmp.Temporizar(False,True,'','');
        Screen.Cursor:=crDefault;
    end;
end;


procedure TFrmFinal.BtnReiniciClick(Sender: TObject);
const
FACTURADO = 'A';
var
sMensaje: string;
cont_reenvio, nuevo_reenvio:LONGINT;
begin
  IMPRIME_LEYENDA_ENTE_COMBI:=FALSE;
//Reinicia la inspeccion
If ExisteEnMAHA(FInspecciones.ValueByName[FIELD_MATRICUL]) then
  Exit;

If FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_PENDIENTE_FACTURAR]) then
  begin
    Messagedlg(Application.Title,'No se puede reinicar este tipo de verificaciones',mtInformation,[mbok],mbok,0);
    Exit;
  end;







With FInspecciones do
  Begin
    try
      if MessageDlg('PLANTA DE VERIFICACION', 'ESTA VIENDO EL INFORME DEL VEHICULO '+ValueByName[FIELD_MATRICUL] + '.'+#13#10+
                    '�SEGURO QUE DESEA CONTINUAR CON LA TAREA DE REINICO?', mtInformation,[mbIgnore, mbCancel], mbIgnore,0) = mrIgnore then
        Begin

          InsertarReenvio(ValueByName[FIELD_CODINSPE]);

           With TSQLQuery.Create(nil) do
              try
                Close;
                SQL.Clear;
                SQLConnection:=mybd;
                SQL.Add('delete from tinspdefect WHERE CODINSPE = :CODINSPE AND EJERCICI = :EJERCICI');
                Params[0].Value:=ValueByName[FIELD_CODINSPE];
                Params[1].Value:=ValueByName[FIELD_EJERCICI];
                ExecSQL;

              finally
                 free;
              end;


      {borra tdatinpsevi}
      if Application.MessageBox( '�Desea Eliminar los Defectos Visuales?', 'Reiniciar Inspecci�n',
       MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
       begin
           With TSQLQuery.Create(nil) do
              try
                Close;
                SQL.Clear;
                SQLConnection:=mybd;
                SQL.Add('delete from tdatinspevi WHERE CODINSPE = :CODINSPE AND EJERCICI = :EJERCICI');
                Params[0].Value:=ValueByName[FIELD_CODINSPE];
                Params[1].Value:=ValueByName[FIELD_EJERCICI];
                ExecSQL;

              finally
                 free;
              end;

     end;

        InspeccionSinOblea;
        ModalResult := MrOk;

        If Encontrar_Auditoria(ValueByName[FIELD_CODINSPE], ValueByName[FIELD_EJERCICI]) then
          Begin
          //  InsertarReenvio(ValueByName[FIELD_CODINSPE]);
            With TSQLQuery.Create(nil) do
              try
                Close;
                SQL.Clear;
                SQLConnection:=mybd;
                SQL.Add('UPDATE TESTADOINSP SET ESTADO = ''A'', USUARIO=null WHERE CODINSPE = :CODINSPE AND EJERCICI = :EJERCICI');
                Params[0].Value:=ValueByName[FIELD_CODINSPE];
                Params[1].Value:=ValueByName[FIELD_EJERCICI];
                ExecSQL;

                /// contador de reniciadas

                       Close;
                       SQL.Clear;
                       SQLConnection:=mybd;
                       SQL.Add('SELECT CODINSPE   FROM tcantreenviolinea  WHERE CODINSPE = :CODINSPE');
                       Params[0].Value:=ValueByName[FIELD_CODINSPE];
                       OPEN;



                       IF  trim(FieldByName('CODINSPE').AsString)='' then
                       BEGIN
                               cont_reenvio:=1;
                               Close;
                               SQL.Clear;
                               SQLConnection:=mybd;
                               SQL.Add('insert into tcantreenviolinea  (codinspe, reenvios) values (:CODINSPE,:reenvios)');
                               Params[0].Value:=ValueByName[FIELD_CODINSPE];
                               Params[1].Value:=cont_reenvio;
                               ExecSQL

                       END else
                        begin
                               Close;
                               SQL.Clear;
                               SQLConnection:=mybd;
                               SQL.Add('update tcantreenviolinea  set reenvios=reenvios  + 1  where CODINSPE = :CODINSPE');
                              // Params[0].Value:=nuevo_reenvio;
                               Params[0].Value:=ValueByName[FIELD_CODINSPE];
                               ExecSQL


                        end;
                     

                //***
              finally
                free;
              end;
          end
        else
          if Reiniciar then
          begin



                With TSQLQuery.Create(nil) do
                    try
                      Close;
                      SQL.Clear;
                      SQLConnection:=mybd;
                      SQL.Add('UPDATE TESTADOINSP SET ESTADO = ''A'' WHERE CODINSPE = :CODINSPE AND EJERCICI = :EJERCICI');
                      Params[0].Value:=ValueByName[FIELD_CODINSPE];
                      Params[1].Value:=ValueByName[FIELD_EJERCICI];
                      ExecSQL;

                    finally
                      free;
                    end;


                
             /// contador de reniciadas
                  With TSQLQuery.Create(nil) do
                    try
                       Close;
                       SQL.Clear;
                       SQLConnection:=mybd;
                       SQL.Add('SELECT CODINSPE, reenvios   FROM tcantreenviolinea  WHERE CODINSPE = :CODINSPE');
                       Params[0].Value:=ValueByName[FIELD_CODINSPE];
                       OPEN;

                     IF  trim(FieldByName('CODINSPE').AsString)='' then
                       BEGIN

                               cont_reenvio:=1;
                               Close;
                               SQL.Clear;
                               SQLConnection:=mybd;
                               SQL.Add('insert into tcantreenviolinea  (codinspe, reenvios) values (:CODINSPE,:reenvios)');
                               Params[0].Value:=ValueByName[FIELD_CODINSPE];
                               Params[1].Value:=cont_reenvio;
                               ExecSQL

                       END else
                        begin
                           // nuevo_reenvio:= FieldByName('reenvios').asinteger + 1;
                               Close;
                               SQL.Clear;
                               SQLConnection:=mybd;
                               SQL.Add('update tcantreenviolinea  set reenvios=reenvios  + 1  where CODINSPE = :CODINSPE');
                              // Params[0].Value:=nuevo_reenvio;
                               Params[0].Value:=ValueByName[FIELD_CODINSPE];
                               ExecSQL

                        end;
                 finally
                  free;
                 end;
          end
          else
            MessageDlg('PLANTA DE VERIFICACION','EN ESTE MOMENTO NO SE PUEDE EFECTUAR DICHA OPERACI�N, ESPERE UNOS SEGUNDOS E INT�NTELO DE NUEVO, SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIBUIDOR', mtWarning,[mbOk], mbOk,0);
      end;
////////////////////////////////////////////////////////////////////////////////////////////////////
    except
      on E: Exception do
        begin
          fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'NO SE PUEDE REINICIAR LA VERIFICACION POR: ' + E.message);
        end;
    end;
  end;
end;


procedure TFrmFinal.ActualizacionNumeroOblea(const iNumero : Integer);
var
iObleaParaVarios : integer;
begin
if iNumero = iObleaEnVarios then
  iObleaParaVarios := iObleaEnVarios + 1
else
  iObleaParaVarios := iObleaEnVarios;

fVarios.Edit;
if Copy(LabelVencimiento.Caption,7,4) = Copy(DateBD(FDataBase),7,4) then
  fVarios.ValueByName[FIELD_NUMOBLEA] := IntToStr(iObleaParaVarios)
else
  fVarios.ValueByName[FIELD_NUMOBLEAB] := IntToStr(iObleaParaVarios);
fVarios.Post(true);
end;

function TFrmFinal.CALCULA_CANTIDAD_HOJA(CODINSPE,EJERCI:LONGINT):LONGINT;
VAR SQLS:STRING;
aQ:TSQLQuery ;
cantidad:longint;
BEGIN

sqls:='select count(*) from TMPDATODEFECIM where CODINSPE = :UnCodigo ';


     aQ:=TSQLQuery.Create(nil);

     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd ;
              SQL.Add(SQLS);


              ParamByName('UnCodigo').Value:=CODINSPE;//FINspecciones.ValueByName[FIELD_CODINSPE]
                try
                  Open;


                   cantidad:=fields[0].asinteger ;
                   if cantidad > 10 then
                     cantidad:=cantidad div 10
                   else
                   cantidad:=1;

                   CALCULA_CANTIDAD_HOJA:=CANTIDAD;
                  finally
                    Close;
                    Free;
                end;
            end;

END;

procedure TFrmFinal.CheckBajaClick(Sender: TObject);
begin
  {$B-}
  if (CheckBaja.Checked ) and ( MessageDlg('BAJA DE VEHICULOS', 'EL VEH�CULO ' +Finspecciones.ValueByName[FIELD_MATRICUL] +' VA HA SER DADO DE BAJA. � DESEA CONTINUAR ?',
     mtInformation, [mbCancel, mbIgnore], mbCancel, 0) = mrIgnore ) then
     CheckBaja.Checked := True
  else
    CheckBaja.Checked := False;
end;


procedure TFrmFinal.BEdtObleaoldKeyPress(Sender: TObject; var Key: Char);
begin
if key = chr(Vk_Return) then
  begin
    key := #0;
    perform(WM_NEXTDLGCTL,0,0);
  end;
end;

  {SE USA PARA BUSCAR EL CDOFACTU DE  TFACTURA PASANDO UN IDPAGO}
  function TFrmFinal.getFactura_POR_PAGOID(PAGOID:LONGINT):string;
  BEGIN
       CODTURNOID:=-1;
        with TSQLQuery.Create(application) do
         try
            SQLConnection:=MYBD;
            SQL.Add('SELECT CODFACTU FROM TFACTURAS WHERE IDPAGO = '+INTTOSTR(PAGOID));
            Open;
            if not IsEmpty   then
            begin
               getFactura_POR_PAGOID:=FIELDS[0].ASSTRING;
           end
             else
               getFactura_POR_PAGOID:='0';
         finally
            Close;
            Free;
        end;

  END;



function TFrmFinal.IsPrinterAvailable: boolean;
	var
	  dwStatus: DWORD;
	  Needed: DWORD;
	  hPrinter: THandle;
    aQ:TSQLQuery;
    nombreimpresora:string;
    NRO:longint;
begin

with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(II_) then
      begin
      Application.MessageBox( 'No se encontraron los par�metros NROPC de la Estaci�n de Trabajo.',
  'Acceso denegado', MB_ICONSTOP );
        //  Messagedlg('ERROR','No se encontraron los par�metros de la Estaci�n de Trabajo', mtInformation, [mbOk],mbOk,0);

       EXIT;
      end
      else
      begin
        NRO :=strtoint(ReadString('NROPC'));

      end;


      FINALLY
       FREE;
      END;



aQ:=TSQLQuery.Create(nil);

////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              SQL.Add ('SELECT nombreimpresora FROM configuracionimpresora WHERE impresion=''II'' and nropc='+inttostr(NRO));
               Open;
              nombreimpresora:=trim(fieldbyname('nombreimpresora').asstring);

            end;

	  Result:= false;
	  if OpenPrinter(PCHAR(nombreimpresora), hPrinter, 0) then
	    if GetPrinter(hPrinter, 6, PBYTE(@dwStatus), sizeof(DWORD), @Needed) then
      Result:= not(dwStatus = PRINTER_STATUS_NOT_AVAILABLE);
end;

procedure TFrmFinal.BtnAceptaClick(Sender: TObject);
var
UnaCabecera : tCabecera;  NRO_INFORME,DOMINIO,patente,motivo_cancelar_certif:STRING;
vObleaAsig,NROCERTIFICADO,cod_fact_guarda: String;           aqin,aqi:TSQLQuery;
aQ: TSQLQuery;    I,anio,CLASE,cantidadhojasS,PAGOIDVERIFICACION_PARA_FACT:LONGINT;    TIMPRE:TIMPRESIONCABA;
imprimirMed: boolean;  cantidadhojas,hojasinforme,codinspein:longint;
codigoinpeccionseleccionado,icodturnoid,autorizo:longint;
continuar:boolean;   aQim,aqcancel:TSQLQuery;
aqcodfac:TSQLQuery;
begin

  {control de estado de impresora}
 { if IsPrinterAvailable= TRUE then
    begin
       Application.MessageBox( 'LA IMPRESORA TIENE PROBLEMAS. POR FAVOR REVISAR LA IMPRESORA.',
    'IMPRESION', MB_ICONSTOP );
    exit;

    end;   }
      codinspein:=strtoint(FINspecciones.ValueByName[FIELD_CODINSPE]);

       aQ:=TSQLQuery.Create(nil);
       with aQ do
            begin
              SQLConnection:=mybd;
              SQL.Add ('SELECT turnoid, PAGOIDVERIFICACION FROM tdatosturno WHERE anio = :EJERCICI AND ');
              SQL.Add (' CODINSPE = :CODINSPE '); // and turnoid=:CODTURNOID');

              ParamByName('CODINSPE').Value:=FINspecciones.ValueByName[FIELD_CODINSPE];
              ParamByName('EJERCICI').Value:=FINspecciones.ValueByName[FIELD_EJERCICI];


                try
                  Open;
                  if not isempty then
                   begin
                    icodturnoid:=Fields[0].Value;
                    PAGOIDVERIFICACION_PARA_FACT:=Fields[1].Value;
                    end else begin
                      icodturnoid:=0;
                    end;
                    
                  except
                   icodturnoid:=0;
                  end;
                    Close;
                    Free;

            end;




TIMPRE:=TIMPRESIONCABA.Create;
 continuar:=true;
hojasinforme:=1;
aniooblea:='0';
 if ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible))) then
 // if not LabelRechazada.Visible then
   begin
//pide oblea
while trim(aniooblea)='0' do
begin
    with tfrmscanearnrooblea.create(self) do
       begin
       LABEL2.CAPTION:='';
         sale:=true;
         edit1.clear;
         edit2.Text:='0';
         showmodal();
          if sale=true then
          begin
            if    TRIM(EDIT1.Text)<>'' then
              begin
                 aniooblea:=TRIM(EDIT2.Text);
                 
                 NROBLEASCANEADA:=inttostr(strtoint(TRIM(EDIT1.Text)));
                 RestoreOblea(strtoint(NROBLEASCANEADA), strtoint(aniooblea) ,MyBD);
             end;

           continuar:=false;
          exit;
          end;
          aniooblea:=TRIM(EDIT2.Text);
         NROBLEASCANEADA:=TRIM(EDIT1.Text);
         self.BEdtOblea.Text:=NROBLEASCANEADA;

        free;

      end;

      if trim(aniooblea)='0' then
       begin
          showmessage('SCANEO DE OBLEA', 'La oblea no se ha scaneado correctamente. Revise el a�o de la oblea si es correcto.');


       end;


  end //while


 end;

//------------------------- fin oblea


   if continuar=false then
   begin
    exit;
   end;



try
BtnAceptar.Enabled:=false;
  Begin
    if FinalizarInspeccion then
      begin

      mybd.StartTransaction(td);
      try
      aqin:=TSQLQuery.Create(nil) ;
   aqin.SQLConnection:=mybd;
   aqin.Close;
   aqin.SQL.Clear;
   aqin.SQL.Add ('update tinspeccion set numoblea='+#39+TRIM(NROBLEASCANEADA)+#39+' where codinspe=:CODINSPE and EJERCICI=:EJERCICI ');
   aqin.ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
   aqin.ParamByName('EJERCICI').Value:=anio;
   aqin.EXECSQL;
   if mybd.InTransaction then
      mybd.Commit(td);
    except
     mybd.Rollback(td);
    end;

   aqin.CLOSE;
   aqin.Free;

      {obtengo idturno}
     { aQ:=TSQLQuery.Create(nil);
        imprimirMed:=false;

          with aQ do
            begin
              SQLConnection:=mybd;
              SQL.Add ('SELECT turnoid FROM tdatosturno WHERE anio = :EJERCICI AND ');
              SQL.Add (' CODINSPE = :CODINSPE ');// and turnoid=:CODTURNOID');

              ParamByName('CODINSPE').Value:=FINspecciones.ValueByName[FIELD_CODINSPE];
              ParamByName('EJERCICI').Value:=FINspecciones.ValueByName[FIELD_EJERCICI];
             // ParamByName('CODTURNOID').Value:=CODTURNOID;
                try
                  Open;
                  icodturnoid:=Fields[0].Value;

                  except
                   icodturnoid:=0;
                  end;
                    Close;
                    Free;

            end;   }

       {---------------------------------------------------------------}

        aQ:=TSQLQuery.Create(nil);
        imprimirMed:=false;
     ////armar consulta
          with aQ do
            begin
              SQLConnection:=mybd;
              SQL.Add ('SELECT COUNT(*) FROM TEMP_DATINSPECC WHERE EJERCICI = :EJERCICI AND ');
              SQL.Add (' CODINSPE = :CODINSPE  ');
              SQL.Add ('AND (   EFFRESTA IS NULL   ');
              SQL.Add ('OR EFFRSERV IS NULL  ');
              SQL.Add ('OR EFAMRUD1 IS NULL  ');
              SQL.Add ('OR EFAMRUD2 IS NULL  ');
              SQL.Add ('OR DESL1EJE IS NULL) ');

              ParamByName('CODINSPE').Value:=FINspecciones.ValueByName[FIELD_CODINSPE];
              ParamByName('EJERCICI').Value:=FINspecciones.ValueByName[FIELD_EJERCICI];
                try
                  Open;
                  if (Fields[0].Value = 0) then
                    imprimirMed:=true;
                  finally
                    Close;
                    Free;
                end;
            end;
      ///fin consulta
         codigoinpeccionseleccionado:=StrToInt(FInspecciones.ValueByName[FIELD_CODINSPE]);
         UnaCabecera.iEjercicio := StrToInt(Finspecciones.ValueByName[FIELD_EJERCICI]);
         UnaCabecera.iCodigoInspeccion := StrToInt(FInspecciones.ValueByName[FIELD_CODINSPE]);
         UnaCabecera.sMatricula := FInspecciones.ValueByName[FIELD_MATRICUL];
         DOMINIO:=FInspecciones.ValueByName[FIELD_MATRICUL];
         Imprimio:= true;

         NRO_INFORME:=fInspeccion.Informe;
          anio:=STRTOINT(FINspecciones.ValueByName[FIELD_EJERCICI]);

            {--------------------------------------------------------}


        if fInspeccion.ValueByName[FIELD_TIPO][1] in [T_NORMAL, T_REVERIFICACION, T_VOLUNTARIA, T_VOLUNTARIAREVERIFICACION] then
          begin
            {LIMPIO CERTIFICADOREVISION Y GUARDO EL NRO_CERTIFICADO}
            With TSQLQuery.Create(nil) do
                try
                mybd.StartTransaction(td);
                  try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('DELETE from certificadoinspeccion    WHERE CODINSPE=:CODINSPE');
                    ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                    EXECSQL;
                    if mybd.InTransaction then
                      mybd.Commit(td);
                    except

                    mybd.Rollback(td);
                    end;

                      finally
                        Close;
                        Free;
                     end;




           {IMPRSION}
           IF (TRIM(COPY(DOMINIO,0,1))='0') OR (TRIM(COPY(DOMINIO,0,1))='1') OR (TRIM(COPY(DOMINIO,0,1))='2')
           OR (TRIM(COPY(DOMINIO,0,1))='3') OR (TRIM(COPY(DOMINIO,0,1))='4') OR (TRIM(COPY(DOMINIO,0,1))='5')
           OR (TRIM(COPY(DOMINIO,0,1))='6') OR (TRIM(COPY(DOMINIO,0,1))='7') OR (TRIM(COPY(DOMINIO,0,1))='8')
           OR (TRIM(COPY(DOMINIO,0,1))='9')THEN
               CLASE:=1
               ELSE
               CLASE:=2;






          {------------------impresion----------------------}

             try
            APPLICATION.ProcessMessages;

              IF TIMPRE.imprimir_certificado_caba(codigoinpeccionseleccionado,anio,cantidadhojas,false,NRO_INFORME)= false THEN
                BEGIN
                    With TSQLQuery.Create(nil) do
                    try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;
                    mybd.StartTransaction(td);
                    try
                    SQL.Add ('delete from  certificadoinspeccion   where CODINSPE=:CODINSPE and NROCERTIFICADO=:NROCERTI and NRO_INFORME=:NRO_INFORME');
                    ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                    ParamByName('NROCERTI').Value:='0';
                    ParamByName('NRO_INFORME').Value:=TRIM(NRO_INFORME);
                    EXECSQL;
                    if mybd.InTransaction then
                       mybd.Commit(td);
                     except
                      mybd.Rollback(td);

                     end;

                      finally
                        Close;
                        Free;
                     end;



                    if ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible))) then
                        RestoreOblea(strtoint(NROBLEASCANEADA), strtoint(aniooblea) ,MyBD);


                    BtnAceptar.Enabled:=true;
                  //  TIMPRE.Free;
                    EXIT;
                END ELSE
                BEGIN
                hojasinforme:=TIMPRE.VER_CANTIDAD;
               { showmessage('IMPRESION DE INFORMES',inttostr(hojasinforme));  }



                Imprimio:=true;

               // TIMPRE.Free;
                END;

               aQim:=TSQLQuery.Create(nil);
               aQim.SQLConnection:=mybd;
               mybd.StartTransaction(td);
               try
               aQim.SQL.Clear;
               aQim.sql.add('delete from tmp_imprsion WHERE CODINSPE=:CODINSPE ');
               aQim.ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
               aQim.ExecSQL;
               if mybd.InTransaction then
                 mybd.Commit(td);
                except
                  mybd.Rollback(td);
                end;


               aQim.close;
               aQim.free;


           except
              showmessage('IMPRESION DE INFORMES', 'Los Informes enviados a impresora, no se han impreso. Vu�lvalo a intentar con el men� de Reimpresiones');

                aQim:=TSQLQuery.Create(nil);
               aQim.SQLConnection:=mybd;
               aQim.SQL.Clear;
               aQim.sql.add('delete from tmp_imprsion WHERE CODINSPE=:CODINSPE ');
               aQim.ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
               aQim.ExecSQL;
               aQim.close;
               aQim.free;


               if ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible))) then
               RestoreOblea(strtoint(NROBLEASCANEADA), strtoint(aniooblea) ,MyBD);


               BtnAceptar.Enabled:=true;
                With TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('delete from  certificadoinspeccion   where CODINSPE=:CODINSPE and NROCERTIFICADO=:NROCERTI and NRO_INFORME=:NRO_INFORME)');
                    ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                    ParamByName('NROCERTI').Value:='0';
                    ParamByName('NRO_INFORME').Value:=TRIM(NRO_INFORME);
                    EXECSQL;

                      finally
                        Close;
                        Free;
                     end;
           end;
          {fin impresion}







      //se agegaron los dos end
      end;

      end;



      //pide nro certificado segun hojas


      // llena tabla temporal TMPDATODEFECIM


      //   hojasinforme:=TIMPRE.VER_CANTIDAD;

      with TFRMSCANEOCERTIFICADO.create(nil) do
        begin
        cantidadhojas:=0;
        sale:=true;
            edit1.cleAR;
           rxmemorydata1.close;
           rxmemorydata1.open;
         { cantidadhojas:=CALCULA_CANTIDAD_HOJA(codigoinpeccionseleccionado,anio);

           if cantidadhojas=0 then
              cantidadhojas:=1;    }

           cantidadhojas:=hojasinforme;
           cantscaneeo:=1;
          label2.Caption:='CANTIDAD: '+inttostr(cantscaneeo)+' de '+inttostr(hojasinforme);

            sale:=true;
           showmodal();
           if sale=true then
           begin
            BtnAceptar.Enabled:=true;
            if ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible))) then
             RestoreOblea(strtoint(NROBLEASCANEADA), strtoint(aniooblea) ,MyBD);

             if anular_certificado=true then
               BEGIN

                  motivo_cancelar_certif:=MOTIVO_CANCELAMIENTO;
                  autorizo:= GLOBALS.ID_USUARIO_LOGEO_SAG;
                     With TSQLQuery.Create(nil) do
                     try
                       SQLConnection:=mybd;
                       Close;
                       SQL.Clear;

                       SQL.Add ('DELETE FROM certificadoinspeccion    WHERE CODINSPE=:CODINSPE');
                       ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                       EXECSQL;

                       finally
                         Close;
                         Free;
                       end;


                        aqcancel:=TSQLQuery.Create(nil);
                        aqcancel.SQLConnection:=mybd;

                    RXMEMORYDATA1.Open;
                    RXMEMORYDATA1.First;
                     while not  RXMEMORYDATA1.Eof DO
                     BEGIN
                        aqi:=TSQLQuery.Create(nil);
                        aqi.SQLConnection:=mybd;
                        aqi.Close;
                        aqi.SQL.Clear;
                        aqi.SQL.Add ('update tcertificados set estado=''A'' '+
                             ', codinspe='+inttostr(codigoinpeccionseleccionado)+' where  numcertif='+#39+trim(RxMemoryData1certificado.Value)+#39);

                        aqi.EXECSQL;
                        aqi.Close;
                        aqi.Free;


                        //registrar cancelados

                        aqcancel.Close;
                        aqcancel.SQL.Clear;
                        aqcancel.SQL.Add ('insert into  tcertificados_anulados (CODANULAC,FECHA,NUMCERTIF,MOTIVO,AUTORIZO) '+
                                         'values (sq_tcertificados_anulados.nextval,sysdate,'+#39+trim(RxMemoryData1certificado.Value)+#39+
                                         ','+#39+trim(motivo_cancelar_certif)+#39+','+inttostr(autorizo)+') ');

                        aqcancel.EXECSQL;




                      RXMEMORYDATA1.Next;

                     END;

                        aqcancel.Close;
                        aqcancel.Free;



                END else begin


                end;//mensaje de cancelar certif




             exit;

           end;


          //guarda en la tabla  certificadoinspeccion

          With TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('DELETE FROM certificadoinspeccion    WHERE CODINSPE=:CODINSPE');
                    ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                    EXECSQL;

                      finally
                        Close;
                        Free;
                     end;





          aqi:=TSQLQuery.Create(nil);
          aqi.SQLConnection:=mybd;


           RXMEMORYDATA1.Open;
           RXMEMORYDATA1.First;
          while not  RXMEMORYDATA1.Eof DO
          BEGIN
              With TSQLQuery.Create(nil) do

                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('insert into certificadoinspeccion   (CODINSPE,NROCERTIFICADO,NRO_INFORME) VALUES (:CODINSPE,to_number(:NROCERTI),:NRO_INFORME)');
                    ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                    ParamByName('NROCERTI').Value:=TRIM(RxMemoryData1certificado.Value);
                    ParamByName('NRO_INFORME').Value:=TRIM(NRO_INFORME);


                    EXECSQL;
                  finally
                        Close;
                        Free;
                     end;


                  aqi.Close;
                  aqi.SQL.Clear;
                  aqi.SQL.Add ('update tcertificados set estado=''C'', fecha_consumido=sysdate'+
                             ', codinspe='+inttostr(codigoinpeccionseleccionado)+' where  numcertif='+#39+trim(RxMemoryData1certificado.Value)+#39);

                  aqi.EXECSQL;



            RXMEMORYDATA1.Next;

         END;

         aqi.Close;
         aqi.Free;




       end;

     // fin oblea


           with TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;

                    SQL.Clear;

                    SQL.Add ('update tdatosturno set reviso=''S'' where turnoid=:codturnoid');
                    ParamByName('codturnoid').Value:=icodturnoid;
                    EXECSQL;

                finally
                    Close;
                    Free;
                 end;






             with TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('update tobleas set estado=''C'',  fecha_consumida=sysdate , codinspe=:CODINSPE,  EJERCICI=:EJERCICI where numoblea=:NROBLEASCANEADA');
                      ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                      ParamByName('EJERCICI').Value:=anio;
                      ParamByName('NROBLEASCANEADA').Value:=TRIM(NROBLEASCANEADA);
                    EXECSQL;

                 finally
                    Close;
                    Free;
                 end;





                

   {pregunta si codfactu de tinspeccion is null para actualizar}
   {


     WITH  TSQLQuery.Create(Self) do
       try
          Close;
          SQL.Clear;
          SQLConnection:=mybd;
          SQL.Add('select codfactu from tinspeccion where codfactu is null  and tipo=''A'' '+
                  ' and  codinspe='+inttostr(codigoinpeccionseleccionado));
          ExecSQL;
          open;
            while not eof do
              begin
                try
                   cod_fact_guarda:=getFactura_POR_PAGOID(PAGOIDVERIFICACION_PARA_FACT);

                       if cod_fact_guarda='0' then
                         begin
                         

                        end else
                        begin
                          aqcodfac:=TSQLQuery.create(Self);
                          aqcodfac.close;
                          aqcodfac.SQL.Clear;
                          aqcodfac.SQLConnection:=mybd;
                          aqcodfac.SQL.Add('update tinspeccion set codfactu='+cod_fact_guarda+
                                          ' where codinspe='+inttostr(codigoinpeccionseleccionado));
                         aqcodfac.ExecSQL;
                         aqcodfac.close;
                         aqcodfac.free;
                       end;
                     
            


                finally

                end;
            next;
          end;
         finally
          close;
          free;
       end;

          }
{-----------------------------------------------------------------------------------------------------------------}



                  {informa al webserveces la inspe}
                 try
                     MENSAJEIMPRESION.Label1.Caption:='INFORMANDO VERIFICACION A SUVTV...';
                     MENSAJEIMPRESION.SHOW;
                     frmturnos.INFORMA_INSPECCION_AL_WEBSERVICES(icodturnoid,
                                                              codigoinpeccionseleccionado
                                                            ,anio);

                     MENSAJEIMPRESION.close;
                    except
                     MENSAJEIMPRESION.close ;
                     End;  



                 {-------------------------------}

                   with TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('delete from  testadoinsp  where codinspe=:CODINSPE and EJERCICI=:EJERCICI ');
                      ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                      ParamByName('EJERCICI').Value:=anio;
                    EXECSQL;

                finally
                    Close;
                    Free;
                 end;








          TIMPRE.Free;



        with TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('UPDATE TOBLEAS SET ESTADO=''S'' WHERE ESTADO=''T'' ');

                    EXECSQL;

                finally
                    Close;
                    Free;
                 end;



      ModalResult := mrOk
    end //if isnpeccion
  except
      on E : Exception do
      begin

          MessageDlg('ACEPTAR INSPECCION','SE HA PRODUCIDO UN ERROR GRAVE CONTACTE CON SU DISTRIBUIDOR SI EL PROBLEMA PERSISTE', mtError, [mbOK], mbOk,0);
          fIncidencias.PonAnotacion(TRAZA_SIEMPRE,12, FICHERO_ACTUAL,'ERROR MUY RARO AL ACEPTAR LA INSPECCION DEL VEHICULO ' +
                                    FInspecciones.ValueByName[FIELD_MATRICUL] + ' POR:' + E.message);


          With TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                    SQL.Add ('update tinspeccion set inspfina=''N'' where CODINSPE=:CODINSPE');
                    ParamByName('CODINSPE').Value:=codigoinpeccionseleccionado;
                    EXECSQL;

                finally
                Close;
                 Free;
                end;


//********************************** VERSION SAG 4.00 **********************************************
FInspecciones.UnBlockInsp;
{$IFDEF TRAZAS}
FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE DESBLOQUEO LA INSPECCION: '+fInspeccion.ValueByName[FIELD_CODINSPE]);
{$ENDIF}
If (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_NORMAL,T_REVERIFICACION,T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION])) and not (FInspecciones.ValueByName[FIELD_ESTADO][1] in [E_PENDIENTE_FACTURAR])then

if ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible)))  then

    //  if not LabelRechazada.Visible then    26.11.2013  martin
  begin

  if trim(vObleaAsig)='' then
    vObleaAsig:='0';

    If (StrToInt(vObleaAsig) <> vObleas)  then
      Begin
     // RestoreOblea(StrToInt(vObleaAsig), vAnioVenci ,MyBD);
       RestoreOblea(vObleas, vAnioVenci ,MyBD);
      {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE VOLVIO AL ESTADO DISPONIBLE LA OBLEA: '+vObleaAsig);
      {$ENDIF}
      end
    else
      Begin
      RestoreOblea(vObleas, vAnioVenci ,MyBD);
      {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE VOLVIO AL ESTADO DISPONIBLE LA OBLEA: '+IntToStr(vObleas));
      {$ENDIF}
      end;
//**************************************************************************************************
  end;





   end;
   end;

end;


function TFrmFinal.FinalizarInspeccion : boolean;

    function TrimDust(const s: string) : string;
    var
        i: integer;
    begin
        result := '';
        for i:=1 to length(s) do
            if s[i] in ['0'..'9']
            then result := result + s[i];
    end;

var
    AntiguoDateSeparator : char;
    aQ: TSQLQuery;
    aResultado, sNumeroOblea : string;
begin




aQ:=TSQLQuery.Create(self);
aQ.SQLConnection:=FInspeccion.Database;
AntiguoDateSeparator := DateSeparator;
result := True;
  try
    DateSeparator := '/';
    
        if ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible))) then
      begin
        try
          FInspeccion.START;
        //  sNumeroOblea:= (Trim(Copy(BEdtOblea.Text,1,2)+Copy(BEdtOblea.Text,3,7)));

           sNumeroOblea:=NROBLEASCANEADA ;

          if ((not (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_GRATUITA,T_PREVERIFICACION,T_VOLUNTARIA, T_VOLUNTARIAREVERIFICACION])))
              and not(LabelRechazada.Visible)) then
             ActualizacionNumeroOblea(StrToInt(sNumeroOblea));

          if LabelApta.Visible then
            aResultado := INSPECCION_APTA
          else
            aResultado := INSPECCION_CONDICIONAL;

          fInspeccion.Edit;
          fInspeccion.ValueByName[FIELD_RESULTAD] := aResultado;
          fInspeccion.ValueByName[FIELD_INSPFINA] := INSPECCION_FINALIZADA;
          fInspeccion.ValueByName[FIELD_HORFINAL] := DateTimeBD(FInspeccion.DataBase);
          fInspeccion.ValueByName[FIELD_FECVENCI] := LabelVencimiento.Caption;

          If ObleaPanel.Visible then
            Begin
              FInspeccion.ValueByName[FIELD_NUMOBLEA] := sNumeroOblea;
              CommitOblea(sNumeroOblea,IntToStr(vAnioVenci),Finspecciones.ValueByName[FIELD_EJERCICI],FInspecciones.ValueByName[FIELD_CODINSPE], MyBD);
              {$IFDEF TRAZAS}
              FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE CONSUMIO LA OBLEA : '+Copy(BEdtOblea.Text,1,2)+Copy(BEdtOblea.Text,3,7));
              {$ENDIF}
            end;
          fInspeccion.Post(true);
          fInspeccion.Refresh;

        //  with aQ do
         //   begin
          //    SQL.Add (Format('DELETE TESTADOINSP WHERE EJERCICI = %S AND CODINSPE =%S', [FINspecciones.ValueByName[FIELD_EJERCICI], FINspecciones.ValueByName[FIELD_CODINSPE]]));
           //   {$IFDEF TRAZAS}

            //  fTrazas.PonComponente(TRAZA_SQL,98,FICHERO_ACTUAL,aQ);
             // {$ENDIF}
             // ExecSql;
           // end;

          fInspeccion.COMMIT;
        except
          on E : Exception do
            begin
              fInspeccion.ROLLBACK;
              Result := FALSE;
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,13,FICHERO_ACTUAL,'ERROR AL FINALIZAR LA INSPECCION DEL VEHICULO: ' +
                                        FInspecciones.ValueByName[FIELD_MATRICUL] + ' POR: ' +E.message);
              MessageDlg('FINALIZACION DE INSPECCION', 'NO PUEDE REALIZAR DICHA OPERACION EN ESTOS MOMENTOS, ' +
                         'SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIBUIDOR', mtInformation, [mbOk], mbOk,0);
            end;
        end;
      end
    else
      begin
        try
          FInspeccion.START;
            if CheckBaja.Checked then
              aResultado := INSPECCION_BAJA
            else
              aResultado := INSPECCION_RECHAZADO;

             //MARTIN 26.11.2013
            if labelcondicional.Visible then
                aResultado := INSPECCION_CONDICIONAL;

          fInspeccion.Edit;
          fInspeccion.ValueByName[FIELD_RESULTAD] := aResultado;
          fInspeccion.ValueByName[FIELD_INSPFINA] := INSPECCION_FINALIZADA;

          //****
          //26.11.2013
            IF   aResultado = INSPECCION_CONDICIONAL THEN
                    fInspeccion.ValueByName[FIELD_HORFINAL] := DateTimeBD(FInspeccion.DataBase)
                ELSE
                   fInspeccion.ValueByName[FIELD_HORFINAL] := datetimetostr(GetDateTimePure(MyBD));
         //**************************************
         
          fInspeccion.ValueByName[FIELD_FECVENCI] := LabelVencimiento.Caption;
          fInspeccion.Post(true);

         { with aQ do
            begin
              SQL.Add (Format('DELETE TESTADOINSP WHERE EJERCICI = %S AND CODINSPE =%S', [FINspecciones.ValueByName[FIELD_EJERCICI], FINspecciones.ValueByName[FIELD_CODINSPE]]));
              {$IFDEF TRAZAS}
             // fTrazas.PonComponente(TRAZA_SQL,98,FICHERO_ACTUAL,aQ);
           //   {$ENDIF}
             // ExecSql;
           // end;  }

          fInspeccion.COMMIT;

        except
          on E : Exception do
            begin
              fInspeccion.ROLLBACK;
              result := FALSE;
              fIncidencias.PonAnotacion(TRAZA_SIEMPRE,14,FICHERO_ACTUAL,'ERROR AL FINALIZAR LA INSPECCION DEL VEHICULO: ' +
              Finspecciones.ValueByName[FIELD_MATRICUL] + ' POR: ' +E.message);
              MessageDlg('FINALIZACION DE INSPECCION', 'NO PUEDE REALIZAR DICHA OPERACION EN ESTOS MOMENTOS, ' +
                         'SI EL PROBLEMA PERSISTE CONTACTE CON SU DISTRIBUDIOR', mtError, [mbOk], mbOk,0);
            end;
        end;
      end;
  finally
    DateSeparator := AntiguoDateSeparator;
    aQ.Close;
    aQ.Free;
  end;
end;


procedure TFrmFinal.RellenarDatosFinales;
var
  Resultado : tResultado;
  Tipo: Char;
  ULTIMO_DIGITO:LONGINT;
  fecha_venci:tdate;
  PRIMERCAMPO:STRING;
begin
    try
        Try
            Tipo:=FInspecciones.ValueByName[FIELD_TIPO][1];
        Except
            on E: Exception do
            begin
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'El tipo de la inspeccion es desconocido: %S',[E.message]);
                Tipo:=E_RECIBIDO_NOK;
            end;
        end;
            {// Sobreescritura del numero de oblea si la inspeccion ya tiene uno.
            if aInspect.Recordcount=0
            then raise Exception.Create('No existe el registro')
            else if not aInspect.DataSet.FieldByName(FIELD_NUMOBLEA).IsNull
                 then BEdtOblea.Text := aInspect.ValueByName[FIELD_NUMOBLEA];
            }

        with tsqlstoredproc.create(application) do
          try
            sqlconnection:=MyBD;
            Storedprocname:= 'caba.completar_TEMP_DATINSPECC';
            parambyname('pinspe').value:=FInspeccion.ValueByName[FIELD_CODINSPE];
            parambyname('pejercici').value:=FInspeccion.ValueByName[FIELD_EJERCICI];
            parambyname('tipo').value:=fInspeccion.ValueByName[FIELD_TIPO];
            parambyname('vehiculo').value:=fInspeccion.ValueByName[FIELD_CODVEHIC];
            execproc;
          finally
          free;
        end;

        fDatInspecc := nil;
        fDatInspecc := tdatinspecc.CreatebyCodEjer(finspecciones);
        fDatInspecc.open;
        fDatInspecc.GetInspectoresLineasByCodigo;
        dsDatinspecc.DataSet:=fDatInspecc.DataSet;

        PRIMERCAMPO:=TRIM(COPY(FInspecciones.ValueByName[FIELD_MATRICUL],0,1));

         IF   (TRIM(PRIMERCAMPO)='0') OR (TRIM(PRIMERCAMPO)='1') OR (TRIM(PRIMERCAMPO)='2')  OR (TRIM(PRIMERCAMPO)='3')  OR (TRIM(PRIMERCAMPO)='4')
         OR (TRIM(PRIMERCAMPO)='5')  OR (TRIM(PRIMERCAMPO)='6')  OR (TRIM(PRIMERCAMPO)='7')  OR (TRIM(PRIMERCAMPO)='8') OR (TRIM(PRIMERCAMPO)='9')  THEN
              CLASEVEHIVULO:=1
              ELSE
               CLASEVEHIVULO:=2;


          ObtenerDatosFinales (Resultado);



        //CALCULAR_DIGITO_VERIFICADOR
        ULTIMO_DIGITO:=CALCULAR_DIGITO_VERIFICADOR( FInspecciones.ValueByName[FIELD_MATRICUL]);

       with tsqlstoredproc.create(application) do
          try
            sqlconnection:=MyBD;
            Storedprocname:= 'VENCIMIENTOS_INSPECCION.PR_VENCIMIENTO_DIGITO';
            parambyname('PI_NDIGITOPATENTE').value:=ULTIMO_DIGITO;
            parambyname('PI_CODVEHIC').value:=FInspeccion.ValueByName[FIELD_CODVEHIC];
             case Resultado of
            APTO:
            begin
                parambyname('PI_RESULTADO').value:='APTO';

            end;

            CONDICIONAL:
            begin
                parambyname('PI_RESULTADO').value:='CONDICIONAL';
            end;

            RECHAZADO:
            begin
                parambyname('PI_RESULTADO').value:='RECHAZADO';

            end;
        end;


            parambyname('PI_CODINSPE').value:=FINspecciones.ValueByName[FIELD_CODINSPE];
            execproc;
            fecha_venci:=parambyname('PO_DVENCIMIENTO').Value;
            close;
          finally
            free;
          end;






        case Resultado of
            APTO:
            begin
                LabelApta.Visible := True;
               // LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy', dNuevaFechaDeVencimiento  (StrToInt(FInspeccion.ValueByName[FIELD_CODVEHIC]), FDataBase, INSPECCION_APTA,Tipo));
                LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy',fecha_venci);

            end;

            CONDICIONAL:
            begin
                LabelCondicional.Visible := True;
               // LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy', dNuevaFechaDeVencimiento (StrToInt(FInspeccion.ValueByName[FIELD_CODVEHIC]), FDataBase, INSPECCION_RECHAZADO,Tipo ));
                LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy',fecha_venci);
            end;

            RECHAZADO:
            begin
                LabelRechazada.Visible := True;
                CheckBaja.Visible := True;
               // LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy',dNuevaFechaDeVencimiento (StrToInt(FInspeccion.ValueByName[FIELD_CODVEHIC]), FDataBase, INSPECCION_RECHAZADO,Tipo ));
               LabelVencimiento.Caption := FormatDateTime('dd/mm/yyyy',fecha_venci );

            end;
        end;


        LColor.Caption := GetColor(StrToInt(Copy(LabelVencimiento.Caption,7,4)) mod NUMERO_COLORES);

        case StrToInt(Copy(LabelVencimiento.Caption,4,2)) of
            1: P1.Color := clAqua;
            2: P2.Color := clAqua;
            3: P3.Color := clAqua;
            4: P4.Color := clAqua;
            5: P5.Color := clAqua;
            6: P6.Color := clAqua;
            7: P7.Color := clAqua;
            8: P8.Color := clAqua;
            9: P9.Color := clAqua;
            10: P10.Color := clAqua;
            11: P11.Color := clAqua;
            12: P12.Color := clAqua
        end;

        LabelDeficiencias.Caption :=  DEFICIENCIAS + IntToStr(GetDeficienaciasCount);

    except
        on E : Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,11, FICHERO_ACTUAL, 'Error finalizando la inspeccion de %d, %d por: %s',
                                     [FInspeccion.ValueByName[FIELD_EJERCICI], FInspeccion.ValueByName[FIELD_CODINSPE], E.message]);
            raise;
        end;
    end;
end;


function TFrmFinal.PasaPorZonas: tRegZonas;
const
    F_NULA = '01/01/1901';
begin
    result.z1 := tNoSe;
    result.z2 := tNose;
    result.z3 := tNose;
    with TSQLQuery.Create(nil) do
    try
        try
            SQLconnection := FInspecciones.DataBase;

            Sql.Add(Format('SELECT TO_CHAR(HORENTZ1,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORSALZ1,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORENTZ2,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORSALZ2,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORENTZ3,''DD/MM/YYYY''), ' +
                           '       TO_CHAR(HORSALZ3,''DD/MM/YYYY'') , ' +
                           '       HORENTZ1,HORENTZ2,HORENTZ3,GREATEST(HORENTZ1,HORENTZ2,HORENTZ3) '+
                           '   FROM TINSPECCION ' +
                           '   WHERE EJERCICI = %S AND CODINSPE = %S', [FInspecciones.ValueByName[FIELD_EJERCICI],FInspecciones.ValueByName[FIELD_CODINSPE]]));
            Open;

            if ((Fields[0].AsString = '') or (Fields[0].AsString = F_NULA)) and ((Fields[1].AsString = '') or (Fields[1].AsString = F_NULA))
                then result.z1 := tNoPasa
                else if (Not (Fields[0].AsString = '')) and (Not (Fields[0].AsString = F_NULA)) and (Not (Fields[1].AsString = '')) and (Not (Fields[1].AsString = F_NULA)) then result.z1 := tPasa
                    else result.z1 := tNoSe;

            if ((Fields[2].AsString = '') or (Fields[2].AsString = F_NULA)) and ((Fields[3].AsString = '') or (Fields[3].AsString = F_NULA))
                then result.z2 := tNoPasa
                else if (Not (Fields[2].AsString = '')) and (Not (Fields[2].AsString = F_NULA)) and (Not (Fields[3].AsString = '')) and (Not (Fields[3].AsString = F_NULA)) then result.z2 := tPasa
                    else result.z2 := tNoSe;

            if ((Fields[4].AsString = '') or (Fields[4].AsString = F_NULA)) and ((Fields[5].AsString = '') or (Fields[5].AsString = F_NULA))
                then result.z3 := tNoPasa
                else if (Not (Fields[4].AsString = '')) and (Not (Fields[4].AsString = F_NULA)) and (Not (Fields[5].AsString = '')) and (Not (Fields[5].AsString = F_NULA)) then result.z3 := tPasa
                    else result.z3 := tNoSe;

             if   Fields[6].AsString =Fields[9].AsString  then
              I1.Color:=clRed;

             if   Fields[7].AsString =Fields[9].AsString  then
              I2.Color:=clRed;

             if   Fields[8].AsString =Fields[9].AsString  then
              I3.Color:=clRed;




        except
            On E : Exception do
            begin
                fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1, FICHERO_ACTUAL,'NO SE PUEDEN CALCULAR LOS PASOS POR ZONA: %s',[E.Message]);
                raise;
            end;
        end;
    finally
        Close;
        Free;
    end;
end;


procedure TFrmFinal.ObtenerDatosFinales (var aResultado : tResultado);
const
  DEFECTO_LEVE = '2';
  DEFECTO_GRAVE = '3';
  SALTADA = '� SALTADA !';
  INCOMPLETA = 'INCOMPLETA';
  COMPLETA = 'COMPLETA';
var
  ColoresZona : tRegZonas;
  ColoresMediciones : TRegMediciones;
  i : integer;
  iDefectosLeves, iDefectosGraves : integer;
  sCodigo, sDescripcion,
  sOk, sDL, sDG : string;
  aq: TSQLDataSet;
  dsp : tDatasetprovider;
  cds : tClientDataSet;
  valores_defecto:string;
  valor_d1,valor_d2,valor_d3,cadena:string ;
  CONT,j:LONGINT;
  SALTA:BOOLEAN;
begin

    MemoDeficiencias.Lines.Clear;

    iDefectosLeves := 0;
    iDefectosGraves := 0;

    ColoresZona := PasaPorZonas;
    ColoresMediciones := ValoresMedicion;

    with FDatInspecc do
      Begin
        I1.Caption:= InspectorLinea[1];
        I1.Hint:= NomyAppInspectorLinea[1];
        I2.Caption:= InspectorLinea[2];
        I2.Hint:= NomyAppInspectorLinea[2];
        I3.Caption:= InspectorLinea[3];
        I3.Hint:= NomyAppInspectorLinea[3];
      end;

    case ColoresZona.Z1 of
        tPasa:
        begin
            PZ1.Color :=  clLime;
            PZ1.Caption := COMPLETA;
        end;

        tNoPasa:
        begin
            PZ1.Color :=  clRed;
            PZ1.Caption := SALTADA;
        end;

        tNose:
        begin
            PZ1.Color :=  clYellow;
            PZ1.Caption := INCOMPLETA;
        end;
    end;

    case ColoresZona.Z2 of
        tPasa:
        begin
            PZ2.Color :=  clLime;
            PZ2.Caption := COMPLETA;
        end;

        tNoPasa:
        begin
            PZ2.Color :=  clRed;
            PZ2.Caption := SALTADA;
        end;

        tNose:
        begin
            PZ2.Color :=  clYellow;
            PZ2.Caption := INCOMPLETA;
        end;
    end;

    case ColoresZona.Z3 of
        tPasa:
        begin
            PZ3.Color :=  clLime;
            PZ3.Caption := COMPLETA;
        end;

        tNoPasa:
        begin
            PZ3.Color :=  clRed;
            PZ3.Caption := SALTADA;
        end;

        tNose:
        begin
            PZ3.Color :=  clYellow;
            PZ3.Caption := INCOMPLETA;
        end;
    end;


      with tsqlQuery.Create(nil) do
               try
                SQLConnection:= fDataBase;
                SQL.Add('delete from TMPDATODEFECIM  where codinspe=:codinspe');
               ParamByName('codinspe').AsString:=FINspecciones.ValueByName[FIELD_CODINSPE];

                execsql;

              finally
               Close;
               Free;
              end;



      aQ := TSQLDataSet.Create(nil);
      aQ.SQLConnection := fInspecciones.DataBase;
      aQ.CommandType := ctQuery;
      aq.GetMetadata := false;
      aq.NoMetadata := true;
      aq.ParamCheck := false;

      dsp := TDataSetProvider.Create(nil);
      dsp.DataSet := aQ;
      dsp.Options := [poIncFieldProps,poAllowCommandText];

      cds:=TClientDataSet.Create(nil);
    with cds do
    try
        setprovider(dsp);
        Close;
        CommandText:=(Format(' SELECT D.EJERCICI EJERCICI, D.CODINSPE CODINSPE, D.CADDEFEC CADDEFEC,          ' +
                       '       D.CALIFDEF CALIFDEF, D.SECDEFEC SECDEFEC,                                ' +
                       '       ABRCAPIT || '' - '' || A.ABRAPART || '' : '' || T.LITDEFEC LITDEFEC,    ' +
                       '       D.LOCALIZA LOCALIZA                                                     ' +
                       ' FROM                                                                           ' +
                       '   TINSPDEFECT D, TDEFECTOS  T, TCAPITULOS C, TAPARTADOS A                      ' +
                       ' WHERE                                                                          ' +
                       '   D.CADDEFEC = T.CADDEFEC   AND                                                ' +
                       '   C.CODCAPIT = T.CODCAPIT   AND                                                ' +
                       '   A.CODAPART = T.CODAPART   AND                                                ' +
                       '   A.CODCAPIT = T.CODCAPIT   AND                                                ' +
                       '   D.EJERCICI = %S AND                                                          ' +
                       '   D.CODINSPE = %S  AND                                                            ' +
                       '   T.CODCLASE= %S                                                              '+
                       ' UNION                                                                          ' +
                       ' SELECT D.EJERCICI EJERCICI, D.CODINSPE CODINSPE, D.CADDEFEC CADDEFEC,          ' +
                       '        D.CALIFDEF CALIFDEF, D.SECUDEFE SECDEFEC,                               ' +
                       '        DECODE                                                                  ' +
                       '        ( SUBSTR (T.CADDEFEC,LENGTH(T.CADDEFEC)-1),  ''01'',                    ' +
                       '                    C.ABRCAPIT || '' - '' || A.ABRAPART || '' : '' || T.LITDEFEC ||'' ''|| D.OTROSDEF || D.UBICADEF || ''-'' ||  D.OBSERVAC, ' +
                       '                    C.ABRCAPIT || '' - '' || A.ABRAPART || '' : '' || T.LITDEFEC ||'' ''|| D.UBICADEF ||'' ''|| D.OTROSDEF || ''-'' ||  D.OBSERVAC  ' +
                       '        )  LITDEFEC,                                                            ' +
                       '       NULL LOCALIZA                                                            ' +
                       ' FROM TDATINSPEVI D, TDEFECTOS  T, TCAPITULOS C, TAPARTADOS A                   ' +
                       ' WHERE                                                                          ' +
                       '   D.CADDEFEC = T.CADDEFEC AND                                                  ' +
                       '   C.CODCAPIT = T.CODCAPIT AND                                                  ' +
                       '   A.CODAPART = T.CODAPART AND                                                  ' +
                       '   A.CODCAPIT = T.CODCAPIT AND                                                  ' +
                       '   D.EJERCICI = %S AND                                                          ' +
                       '   D.CODINSPE = %S  AND  D.CALIFDEF <>''0'' AND                                   '+
                       '   T.CODCLASE= %S                                                              ',
                       [ fInspeccion.ValueByName[FIELD_EJERCICI],fInspeccion.ValueByName[FIELD_CODINSPE],inttostr(CLASEVEHIVULO),
                         fInspeccion.ValueByName[FIELD_EJERCICI],fInspeccion.ValueByName[FIELD_CODINSPE],inttostr(CLASEVEHIVULO)]));

        {$IFDEF TRAZAS}
        fTrazas.PonComponente(TRAZA_SQL,90,FICHERO_ACTUAL,aQ);
        {$ENDIF}

        Open;

        while not eof do
       // for i := 1 to RecordCount do
        begin
            {$IFDEF TRAZAS}
            fTrazas.PonRegistro(TRAZA_REGISTRO,91,FICHERO_ACTUAL,aQ);
            {$ENDIF}


          //04.01.2013 cambio para la nueva leyenda en el informe de inspeccion. El vehiculo cuenta con... plazas y ...ventanas
          // segun resolucion ente.
          //FIX: viene como un defecto y lo mandamos a imprimir al campo leyenda del informe de inspeccion si es 09.13.014
           // IF  cds.FieldByName(FIELD_CADDEFEC).AsString <> '09.13.014' THEN
           //  BEGIN


            if FieldByName(FIELD_CALIFDEF).AsString = DEFECTO_GRAVE
            then inc(iDefectosGraves, 1)
            else if FieldByName(FIELD_CALIFDEF).AsString = DEFECTO_LEVE
                 then inc(iDefectosLeves, 1);

//            ObtenerLiteralCalificativo( FINspecciones.Database, StrToInt(FINspecciones.ValueByName[FIELD_EJERCICI]), StrToInt(FINspecciones.ValueByName[FIELD_CODINSPE]),
//                                        FieldByName(FIELD_CADDEFEC).AsString, FieldByName(FIELD_CALIFDEF).AsString,
//                                        GetLiteralDefecto(FieldByName(FIELD_CADDEFEC).AsString), FieldByName(FIELD_UBICADEF).AsString, sCodigo, sDescripcion, sOk, sDL ,sDG);

            ObtenerLiteralCalificativo (fVarios.Database, StrToInt(FINspecciones.ValueByName[FIELD_EJERCICI]), StrToInt(FINspecciones.ValueByName[FIELD_CODINSPE]),
                                        cds.FieldByName(FIELD_CADDEFEC).AsString,
                                        cds.FieldByName(FIELD_CALIFDEF).AsString,
                                        cds.FieldByName(FIELD_LITDEFEC).AsString,
                                        cds.FieldByName(FIELD_LOCALIZA).AsString,
                                        sCodigo, sDescripcion, sOk, sDL, sDG);

            MemoDeficiencias.Lines.Add(LineaCon(sCodigo, sDescripcion, sOk, sDL, sDG));//%%%


             with tsqlQuery.Create(nil) do
               try
                SQLConnection:= fDataBase;
                SQL.Add('insert into TMPDATODEFECIM (codinspe,caddefec,litdefec,calif) values(:codinspe,:caddefec,:litdefec,:calif)' );
                ParamByName('codinspe').AsString:=FINspecciones.ValueByName[FIELD_CODINSPE];
                ParamByName('caddefec').AsString:=TRIM(sCodigo);
                ParamByName('litdefec').AsString:=TRIM(sDescripcion);

                if  trim(sDL)='X' then
                ParamByName('calif').AsString:='Leve'
                else
                if  trim(sDG)='X' then
                ParamByName('calif').AsString:='Grave'
                else   if  trim(sOk)='X' then
                    ParamByName('calif').AsString:=''
                    else if  trim(sOk)='' then
                           ParamByName('calif').AsString:='';


                execsql;

              finally
               Close;
               Free;
              end;

            //MemoDeficiencias.Lines.Add(sCodigo+sDescripcion+sOk+sDL+sDG);


     //      end;
          
            Next;
        end;
    finally
          Free;
          dsp.Free;
          aQ.close;
          aQ.free;
    end;

    if iDefectosGraves <> 0 then
      aResultado := RECHAZADO
    else
    if iDefectosLeves <> 0 then
      aResultado := CONDICIONAL
    else
      aResultado := APTO;

    PintaPanelesMedicion(ColoresMediciones);
end;


procedure TFrmFinal.bStandByClick(Sender: TObject);
const
  FACTURADO = 'A';
begin
  try
    if MessageDlg('PLANTA DE VERIFICACION', 'ESTA VIENDO EL INFORME DEL VEHICULO ' +
                  fInspecciones.ValueByName[FIELD_MATRICUL] + '. SEGURO QUE DESEA DEJARLO EN STANDBY ',
                  mtInformation,[mbIgnore, mbNo], mbIgnore,0) = mrIgnore then
    begin
    //Poner el valor de estado en StandBy Me !!!!!
    if FINspecciones.StandBy then
      begin
        InspeccionSinOblea;
        ModalResult:=mrok;
      end;
    end;
  except
    on E: Exception do
    begin
      fAnomalias.PonAnotacion(TRAZA_SIEMPRE,4,FICHERO_ACTUAL,'NO SE PUEDE REINICIAR LA VERIFICACION POR: ' + E.message);
    end;
  end;
end;


function TFrmFinal.GetColor (const aId: integer) : string;
begin
    with tsqlQuery.Create(nil) do
    try
        SQLConnection:= fDataBase;
        SQL.Add(Format('SELECT NOMCOLOR FROM TCOLORES WHERE CODCOLOR# = %d', [aId]));
        Open;
        Result := Fields[0].AsString;
    finally
        Close;
        Free;
    end
end;

function TFrmFinal.Tiene_Alerta (const dominio: string) : string;
begin
    with tsqlQuery.Create(nil) do
    try
        SQLConnection:= fDataBase;
        SQL.Add('SELECT MOTIVO FROM PATENTE_EN_ALERTA WHERE PATENTEN =:PATENTE AND FECHABAJA IS NULL' );
        ParamByName('PATENTE').AsString:=TRIM(dominio);
        Open;
        Result := Fields[0].AsString;
    finally
        Close;
        Free;
    end
end;



Function TFrmFinal.GetDeficienaciasCount: Integer;
var
    ii: Integer;
begin
    //Cuenta el numero de deficiencias encontradas
    Result:=0;
    for ii := 0 to MemoDeficiencias.Lines.Count-1 do
    begin
        If pos(CAD_OK,MemoDeficiencias.Lines[ii])=0 then Inc(Result);
    end;
end;


procedure TFrmFinal.bPagarClick(Sender: TObject);
var
    aQ: TSQLQuery;
    aTipo: String;
begin
//Paga uns Preverificacion
If Messagedlg(Caption,MSJ_PAGAR_PREVERIFICACION,mtConfirmation,[mbyes,mbno],mbno,0)=mrYes then
  begin
    try
      try
        fInspeccion.START;
        FInspeccion.Edit;
        If FInspeccion.IsReverification(FInspeccion,fvReverificacion)then
          begin
            FInspeccion.ValueByName[FIELD_TIPO]:=T_REVERIFICACION;
            aTipo:=T_REVERIFICACION;
          end
        else
          begin
            FInspeccion.ValueByName[FIELD_TIPO]:=T_NORMAL;
            aTipo:=T_NORMAL;
          end;
        FInspeccion.ValueByName[FIELD_WASPRE]:=INSPECCION_FUE_PREVERIFICACION;
        FInspeccion.Post(true);

        aQ:=TSQLQuery.Create(nil);
        with aQ do
          Try
            SQL.Clear;
            SQLConnection:=FInspeccion.DataBase;

            SQL.Add (Format('UPDATE TESTADOINSP SET ESTADO = ''%S'', TIPO = ''%S'' WHERE EJERCICI = %S AND CODINSPE = %S',
                             [E_PENDIENTE_FACTURAR,aTipo, FInspecciones.ValueByName[FIELD_EJERCICI], FInspecciones.ValueByName[FIELD_CODINSPE]]));
            ExecSql;
            {$IFDEF TRAZAS}
            fTrazas.PonAnotacion(TRAZA_FLUJO,0,FICHERO_ACTUAL,'Actualizaci�n del estado de inspecci�n');
            fTrazas.PonComponente(TRAZA_SQL,0,FICHERO_ACTUAL,aQ);
            {$ENDIF}
          finally
            Free
          end;
        fInspeccion.COMMIT;
      except
        on E: Exception do
          begin
            fInspeccion.ROLLBACK;
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'No se pudo poner la preverificacion a facturar por: %S',[E.message]);
            MessageDlg('Facturaci�n de Preverificaciones.','Ocurri� un error mientras se intent� enviar a facturar la preverificacion. Intentelo de nuevo y si persiste el error, ind�quelo al jefe de planta.', mtInformation,[mbOk],mbOk,0);
          end;
      end;
    finally
      FInspecciones.UnBlockInsp;
      FInspecciones.Refresh;
      ModalResult:=mrCancel;
    end;
  end;
end;


Procedure TFrmFinal.InspeccionSinOblea;
begin
//elimina el numero de oblea
FInspeccion.Edit;
FInspeccion.ValueByName[FIELD_NUMOBLEA]:='';
FInspeccion.Post(true);
end;


procedure TFrmFinal.FormActivate(Sender: TObject);
var
  sOblea, Fecha: String;
  nOblea: TOblea;
begin
Imprimio:=true;
vObleas:=0;
vAnioVenci:=0;
 
Application.ProcessMessages;

Fecha:=DateBd(FDataBase);
vAnioVenci:=StrToInt(Copy(LabelVencimiento.Caption,7,4));





if (FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_STANDBY])) then
  bStandBy.Enabled:=false;


  Begin
  // ml mb
  // se saco t_voluntaria, T_VOLUNTARIAREVERIFICACION 19/12/2010

  {if ((Not (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_GRATUITA,T_PREVERIFICACION]))) and
     (not(LabelRechazada.Visible)))   then   }

  if (((Not (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_GRATUITA,T_PREVERIFICACION]))))
     and     ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible))))     then

  
    begin

  {  With TSQLQuery.Create(nil) do
    try
    SQLConnection:=FInspeccion.DataBase;;
    Close;
    SQL.Clear;
    SQL.Add('update TOBLEAS  estdo=''S'' WHERE ESTADO=''T'' ');
     ExecSQL;
     finally
    close;
     free;
    end; }
      If ObleasEnStock(vAnioVenci,MyBd) then
        Begin
       vObleas:=StrToInt(GetOblea(vAnioVenci,MyBD));
      // vobleass:=trim(GetOblea(vAnioVenci,MyBD));
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE ASIGNO POR DEFECTO LA OBLEA: '+IntToStr(vObleas));
        {$ENDIF}
        //sOblea:=Copy(IntToStr(vObleas),1,2)+'-'+Copy(IntToStr(vObleas),3,6);    <- Cero Izq.
       // sOblea:=FormatFloat('00000000',vObleas);
        sOblea:=inttostr(vobleas);
       if not (sOblea='') then
        //  BEdtOblea.Text :=IntToStr(vObleas)                                    <- Cero Izq.
          BEdtOblea.Text := sOblea
        else
          begin
            BEdtOblea.Text := sOblea;
            BEdtOblea.Text :=FormatNumOblea(vObleas);
            Application.ProcessMessages;
            FInspeccion.Edit;
            FInspeccion.ValueByName[FIELD_NUMOBLEA]:=Trim(Copy(BEdtOblea.Text,1,2)+Trim(Copy(BEdtOblea.Text,4,length(BEdtOblea.Text))));
            FInspeccion.Post(true);
            FInspecciones.Refresh;
          end;
        end
    else
      Begin
        BEdtOblea.Text:='00000000';
        BtnAceptar.Enabled:=false;
        DialogsFont.Size:=15;
        MessageDlg ('ERROR EN EL STOCK DE OBLEAS','ATENCION!!! NO HAY MAS OBLEAS DISPONIBLES!'#13#10+'POR FAVOR, INGRESE NUEVAS OBLEAS', mtERROR, [mbOk],mbOk, 0);
        DialogsFont.Size:=8;
      end;
    end;
  if LabelApta.Visible then
    bStandBy.Enabled:=False;
  If FInspecciones.ValueByName[FIELD_TIPO] = T_PREVERIFICACION Then
    bPagar.Enabled:=True;
    //T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION  martin  20.12.2010
  If (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_GRATUITA,T_PREVERIFICACION])) Then
    begin
      ObleaPanel.Visible:=False;
      if FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_PREVERIFICACION]) then
        begin
          InpePanel.visible := true;
          lblNroInspe.Caption := ' NRO. DE INSPECCION: '+FInspeccion.informe;
        end;
    end
  else
    begin
     if ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible))) then
    //  if not LabelRechazada.Visible then    26.11.2013  martin
        begin
        ObleaPanel.Visible:=True;
        end;
    end;
  IF bStandBy.Enabled then
    bStandBy.Enabled:=GetStandByEnabled;
  end
end;


Function TFrmFinal.GetStandByEnabled:Boolean;
begin
//Determina si esta activo el servicio de StandBy
Result:=(FVarios.PermitirStandBy <> OP_INACTIVA)
end;



Function TFrmFinal.FormatNumOblea(Cad:Integer):String;
VAR
    Cabo,Rabo: String;
begin
    if (Cad <= 999999) then
        Result := Format ('%1.2d-%1.6d',[0,Cad])
    else begin
       {********Codigo original de IVAN DIAZ SOLE ************
        Cabo:=Copy(IntToStr(Cad),1,2);
        Rabo:=Trim(Copy(IntToStr(Cad),3,Length(IntToStr(Cad))));
        **********aqui termina
                  y empieza codigo cambiado por Vicky*******
        Revisado por VAZ SLS para instalar con modificaci�n
        construcci�n secuenciadores (26-12-2000)
        Solo funciona bajo condiciones actuales de n�mero de oblea:
        pa-dddddd}
        if Length(IntToStr(Cad))>7 then begin
           Cabo:=Copy(IntToStr(Cad),1,2);
           Rabo:=Trim(Copy(IntToStr(Cad),3,Length(IntToStr(Cad))));
        end else begin
           Cabo:=Copy(IntToStr(Cad),1,1);
           Rabo:=Trim(Copy(IntToStr(Cad),2,Length(IntToStr(Cad))));
        end;
        {**** fin de cambios, sigue codigo original ******}
        Result:=Format('%1.2d-%1.6d', [StrToInt(Cabo),StrToInt(Rabo)]);
    end;
end;


procedure TFrmFinal.LlenarDatosVehiculo;
var fVehiculo: tvehiculo;
begin
  fVehiculo := nil;
  try
    fVehiculo := finspeccion.GetVehiculo;
    fVehiculo.open;
    TipoGas := fVehiculo.Valuebyname[FIELD_TIPOGAS];
    lblFabricado.Caption := fVehiculo.ValueByName[FIELD_ANIOFABR];
    with tSQLquery.create(nil) do
      try
        SQLConnection:=mybd;
        SQL.Clear;
        Close;
        SQL.Add('SELECT MA.NOMMARCA, MO.NOMMODEL, DE.NOMDESTI FROM TMARCAS MA, TMODELOS MO, TTIPODESVEH DE ');
        SQL.Add('WHERE MA.CODMARCA = MO.CODMARCA AND MA.CODMARCA = :MARCA AND MO.CODMODEL = :MODELO AND DE.TIPODEST = :TIPO');
        Params[0].Value:= fVehiculo.valuebyname[FIELD_CODMARCA];
        Params[1].Value:= fVehiculo.valuebyname[FIELD_CODMODEL];
        Params[2].Value:= fVehiculo.valuebyname['TIPODEST'];
        Open;
        LblMarcaModelo.caption := copy(Fields[0].asstring,1,12);
        LblMarcaModelo.caption :=LblMarcaModelo.caption + ' - ' + copy(fields[1].asstring,1,12)+' ('+fVehiculo.valuebyname[FIELD_TIPOGAS]+')';
        LabelTipo.Caption:=Fields[2].AsString;
        Close;
      finally
        free;
      end;
  finally
    fVehiculo.close;
    fVehiculo.Free;
    Application.ProcessMessages;
  end;
end;


function TFrmFinal.ValoresMedicion : tRegMediciones;
var
fxd1, fxd2, fxi1, fxi2 : string;  {Variables para que si los valores de alguna de las fuerzas de frenado vienen vacios, no tire error al realizar la conversion
                                    de string a numerico}
begin
result.efs := tNoSe;
result.efe := tNose;
result.da1 := tNose;
result.da2 := tNose;
result.de1 := tNose;
result.co2 := tNose;
result.kme := tNose;
result.fx1 := tNose;
result.fx2 := tNose;
  try
      if fDatInspecc.ValueByName[FIELD_EFFRSERV] = '' then
        result.efs := tNoPasa
      else
        result.efs := tPasa;

      if fDatInspecc.ValueByName[FIELD_EFFRESTA] = '' then
        result.efe := tNoPasa
      else
        result.efe := tPasa;

      if fDatInspecc.ValueByName[FIELD_DESE1EJE] = '' then
        result.da1 := tNoPasa
      else
        result.da1 := tPasa;

      if fDatInspecc.ValueByName[FIELD_DESE2EJE] = '' then
        result.da2 := tNoPasa
      else
        result.da2 := tPasa;

      if fDatInspecc.ValueByName[FIELD_DESL1EJE] = '' then
        result.de1 := tNoPasa
      else
        result.de1 := tPasa;

      if (TipoGas = COMBUSTIBLE_NAFTA) then
      begin
         if (fDatInspecc.ValueByName[FIELD_PORCECO2] = '') then
           result.co2 := tNoPasa
         else
           result.co2 := tPasa;

         if (fDatInspecc.ValueByName[FIELD_VALORKME] = '') then
           result.kme := tPasa
         else
           result.kme := tNoPasa;
      end
      else
        if (TipoGas = COMBUSTIBLE_GASOIL) then
        begin
           if (fDatInspecc.ValueByName[FIELD_VALORKME] = '') then
             result.kme := tNoPasa
           else
             result.kme := tPasa;

           if (fDatInspecc.ValueByName[FIELD_PORCECO2] = '') then
             result.co2 := tPasa
           else
             result.co2 := tNoPasa;
        end
        else
          if (TipoGas = COMBUSTIBLE_GNC) or (TipoGas = COMBUSTIBLE_MEZCLA) or (TipoGas = COMBUSTIBLE_NULL) then
          begin
           if (fDatInspecc.ValueByName[FIELD_VALORKME] = '') then
             result.kme := tPasa
           else
             result.kme := tNoPasa;

           if (fDatInspecc.ValueByName[FIELD_PORCECO2] = '') then
             result.co2 := tPasa
           else
             result.co2 := tNoPasa;
          end;


      fxd1:= fDatInspecc.ValueByName[FIELD_FMXFSRD1];
      fxd2:= fDatInspecc.ValueByName[FIELD_FMXFSRD2];
      fxi1:= fDatInspecc.ValueByName[FIELD_FMXFSRI1];
      fxi2:= fDatInspecc.ValueByName[FIELD_FMXFSRI2];

      if fxd1 = '' then fxd1 := '0';
      if fxd2 = '' then fxd2 := '0';
      if fxi1 = '' then fxi1 := '0';
      if fxi2 = '' then fxi2 := '0';

      if fDatInspecc.ValueByName['DEFR1EJE'] = '' then
      begin
        result.fx1 := tNoPasa;
        pfx1.Caption := '';
      end
      else
      begin
        result.fx1 := tPasa;
        pfx1.Caption := fDatInspecc.ValueByName['DEFR1EJE'] ;
      end;

      if fDatInspecc.ValueByName['DEFR2EJE'] = '' then
      begin
        result.fx2 := tNoPasa;
        pfx2.Caption := '';
      end
      else
      begin
        result.fx2 := tPasa;
        pfx2.Caption := fDatInspecc.ValueByName['DEFR2EJE'] ;
      end;

    except
        On E : Exception do
        begin
            fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1, FICHERO_ACTUAL,'NO SE PUEDEN CALCULAR LOS VALORES AUTOMATICOS POR: %s',[E.Message]);  //********* VER TODO
            raise;
        end;
    end;
    Application.ProcessMessages;
end;


procedure TFrmFinal.PintaPanelesMedicion(aMediciones: tRegMediciones);
begin
    case aMediciones.efs of
        tPasa:
        begin
            Pefs.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pefs.Color :=  clRed;
        end;
        tNose:
        begin
            Pefs.Color :=  clYellow;
        end;
    end;
    case aMediciones.efe of
        tPasa:
        begin
            Pefe.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pefe.Color :=  clRed;
        end;
        tNose:
        begin
            Pefe.Color :=  clYellow;
        end;
    end;
    case aMediciones.da1 of
        tPasa:
        begin
            Pda1.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pda1.Color :=  clRed;
        end;
        tNose:
        begin
            Pda1.Color :=  clYellow;
        end;
    end;
    case aMediciones.da2 of
        tPasa:
        begin
            Pda2.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pda2.Color :=  clRed;
        end;
        tNose:
        begin
            Pda2.Color :=  clYellow;
        end;
    end;
    case aMediciones.de1 of
        tPasa:
        begin
            Pde1.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pde1.Color :=  clRed;
        end;
        tNose:
        begin
            Pde1.Color :=  clYellow;
        end;
    end;

    case aMediciones.co2 of
        tPasa:
        begin
            Pco2.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pco2.Color :=  clRed;
        end;
        tNose:
        begin
            Pco2.Color :=  clYellow;
        end;
    end;

    case aMediciones.kme of
        tPasa:
        begin
            Pkme.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pkme.Color :=  clRed;
        end;
        tNose:
        begin
            Pkme.Color :=  clYellow;
        end;
    end;
    case aMediciones.fx1 of
        tPasa:
        begin
            Pfx1.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pfx1.Color :=  clRed;
        end;
        tNose:
        begin
            Pfx1.Color :=  clYellow;
        end;
    end;
    case aMediciones.fx2 of
        tPasa:
        begin
            Pfx2.Color :=  clLime;
        end;
        tNoPasa:
        begin
            Pfx2.Color :=  clRed;
        end;
        tNose:
        begin
            Pfx2.Color :=  clYellow;
        end;
    end;
Application.ProcessMessages;
end;


procedure TFrmFinal.FormDestroy(Sender: TObject);
begin
fDatInspecc.Free;
FInspeccion.Free;
end;


procedure TFrmFinal.BtnCancelarClick(Sender: TObject);
begin
  IMPRIME_LEYENDA_ENTE_COMBI:=FALSE;
if not (FInspecciones.ValueByName[FIELD_ESTADO][1] in ([E_STANDBY])) then
  InspeccionSinOblea;


//********************************** VERSION SAG 4.00 **********************************************
FInspecciones.UnBlockInsp;
{$IFDEF TRAZAS}
FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE DESBLOQUEO LA INSPECCION: '+fInspeccion.ValueByName[FIELD_CODINSPE]);
{$ENDIF}
If (FInspecciones.ValueByName[FIELD_TIPO][1] in ([T_NORMAL,T_REVERIFICACION,T_VOLUNTARIA,T_VOLUNTARIAREVERIFICACION])) and not (FInspecciones.ValueByName[FIELD_ESTADO][1] in [E_PENDIENTE_FACTURAR])then

if ((LabelApta.Visible) or  ((entrega_oblea_a_condicionales=TRUE)and (LabelCondicional.Visible)))  then

    //  if not LabelRechazada.Visible then    26.11.2013  martin
  begin

  if trim(vObleaAsig)='' then
    vObleaAsig:='0';

    If (StrToInt(vObleaAsig) <> vObleas)  then
      Begin
     // RestoreOblea(StrToInt(vObleaAsig), vAnioVenci ,MyBD);
       RestoreOblea(vObleas, vAnioVenci ,MyBD);
      {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE VOLVIO AL ESTADO DISPONIBLE LA OBLEA: '+vObleaAsig);
      {$ENDIF}
      end
    else
      Begin
      RestoreOblea(vObleas, vAnioVenci ,MyBD);
      {$IFDEF TRAZAS}
      FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE VOLVIO AL ESTADO DISPONIBLE LA OBLEA: '+IntToStr(vObleas));
      {$ENDIF}
      end;
//**************************************************************************************************
  end;


  ModalResult:=mrCancel;
  
end;


procedure TFrmFinal.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 // BEdtOblea.ValidateEdit;
end;


procedure TFrmFinal.BEdtObleaoldChange(Sender: TObject);
begin

//vObleaAsig:=Copy(BEdtOblea.Text,1,2)+Copy(BEdtOblea.Text,3,7);
vObleaAsig:=trim(BEdtOblea.Text);
If (StrToInt(vObleaAsig) <> vObleas) then
  If length(BEdtOblea.Text)=8 then
    If ObleaDisponible(StrToInt(vObleaAsig),vAnioVenci,MyBd) then
      Begin
        GetNewOblea(StrToInt(vObleaAsig),vAnioVenci, MyBd);
        RestoreOblea(vObleas, vAnioVenci ,MyBD);
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO A ESTADO DISPONIBLE LA OBLEA: '+IntToStr(vObleas));
        {$ENDIF}
        vObleas:= StrToInt(vObleaAsig);
        {$IFDEF TRAZAS}
        FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, 'SE PASO A ESTADO TOMADO LA OBLEA: '+IntToStr(vObleas));
        {$ENDIF}
      end
    else
      BEdtOblea.Text:=IntToStr(vObleas);
end;

procedure TFrmFinal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{ if not Imprimio then }
 
LiberarMemoria;
end;

procedure TFrmFinal.Timer1Timer(Sender: TObject);
begin
IF VARIABLE_COLOR=1 THEN
BEGIN
   LABEL3.Font.Color:=CLRED;
   APPLICATION.ProcessMessages;
   VARIABLE_COLOR:=2;
   timer1.Enabled:=false;
END;

 IF VARIABLE_COLOR=2 THEN
BEGIN
   LABEL3.Font.Color:=CLYELLOW;
   APPLICATION.ProcessMessages;
   VARIABLE_COLOR:=1;
END;
timer1.Enabled:=true;
end;

end.//Final de la unidad



