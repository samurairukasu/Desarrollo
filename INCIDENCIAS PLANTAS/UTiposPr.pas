unit UTiposPr;

interface

uses
  USAGPRINTERS,
  Classes,
  SysUtils,
  Windows;

const

  REGISTROS_X_PAGINA = 16;


type


  tFiltrosSeleccionados = array [1..MAXIMO_NUMERO_IMPRESORAS_EN_PAMPA] of boolean;



  tDatosAImprimirInforme = record

    iCodigoVehiculo : integer;

    sEjemplarPara,
    sNumeroInspeccion,
    sZona,
    sEstacion,
    sConductor,
    sDocumentoConductor,
    sMarca,
    sTipo,
    sModelo,
    sGnc,
    sAnioFabricacion,
    sTitular,
    sDocumentoTitular,
    sDominio,
    sMotor,
    sChasis,
    sVencimiento,
    sApto,
    sCondicional,
    sRechazado,
    sBaja,
    sMotocicleta,
    sAgricola,
    sVial,
    sEscuela,
    sAlquiler,
    sPrivadoHastaNueve,
    sPublicoHataNueve,
    sMasDeNueve,
    sCarga,
    sAmbulancia,
    sHIngreso,
    sHEgreso,
    sHTiempoZonas,
    sTiempoEspera,
    sFecha,
    sPagina,
    sResponsable,
    sNombreEstacion : string;

    TSDefectosLeves, TSDefectosGraves,
    TSObservaciones, TSDescripciones,
    TSCadena : tStringList;


  end;


  tDatosAImprimirCert = record


    iCodigoVehiculo : integer;

    sNumero,
    sNombreApellido,
    sDominio,
    sClasificacion,
    sFecha,
    sVencimiento,
    sEstacion,
    sZona,
    sObleaNumero : string;
  end;

  tDatosAImprimirAB = record

    sNumeroFactura,

    sCabecera,
    sFecha,
    sDPNombre,
    sDPDireccion,
    sDPLocalidad,
    sTipoDeIva,
    sNumero_CUIT,
    sFormaDePago,
    sCantidad,
    sLiteral1,
    sLiteral2,
    sLiteral3,
    sPrecioUnitario,
    sSubTotal_1,
    sSubTotal_2,
    sIvaInscripto,
    sIvaNoInscripto,
    sTOTAL : string;
  end;


  tVarGlobs = record

    IndiceColetilla : integer;

    iUltimaDeficiencia : integer;
    iUltimaLinea : integer;
    iUltimaPagina : integer;

    bTerminadoInforme : boolean;
    bTerminadaPagina : boolean;

    bPararProceso : Boolean;
    bMostrarMensajeConfiguracion : Boolean;
    bConfiguracionTemporal : boolean; //Configuracion Temporal de impresoras.

    aFiltroSeleccionado : tFiltrosSeleccionados;

    DatosDeFacturaA    : tDatosAImprimirAB;
    DatosDeFacturaB    : tDatosAImprimirAB;
    DatosDeCertificado : tDatosAImprimirCert;
    DatosDeInforme     : tDatosAImprimirInforme;

  end;

var

  VarGlobs : tVarGlobs;


//function TestDeImpresionOk : boolean;
//function ResetRegTAB : tDatosAImprimirAB;

implementation


{******************************************************************************}


{function TestDeImpresionOk : boolean;
var
 bErrores: Boolean;
begin
  bErrores := False;
  if bErrores and (FrmPrinters <> nil) then FrmPrinters.BtnPararClick(nil);
  result := not bErrores;
end;
}

{function ResetRegTAB : tDatosAImprimirAB;
begin
  with result do
  begin
    sCabecera := '';
    sFecha := '';
    sDPNombre := '';
    sDPDireccion:='';
    sDPLocalidad:='';
    sTipoDeIva := '';
    sNumero_CUIT := '';
    sFormaDePago := '';
    sCantidad := '';
    sLiteral1 := '';
    sLiteral2 := '';
    sLiteral3 := '';
    sPrecioUnitario := '';
    sSubTotal_1 := '';
    sSubTotal_2 := '';
    sIvaInscripto := '';
    sIvaNoInscripto := '';
    sTOTAL := '';
  end;
end;
}
end.


