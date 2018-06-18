spool c:\argentin\envio\MODIF_112010.txt
/
ALTER TABLE TTMP_LIQDIARIA_CLIENTCTACTE
MODIFY (CODCLIEN  VARCHAR2(100) )
ADD IDUSUARI NUMBER(3)
/
CREATE TABLE TDISCAPACITADOS
(
  CODDISCAP  NUMBER(4),
  CODCLIEN   NUMBER(8),
  CODINSPE  NUMBER(6),
  CODFACTU  NUMBER(8),
  FECHALTA  DATE                                DEFAULT SYSDATE               NOT NULL
)
/
CREATE SEQUENCE SQ_TDISCAPACITADOS_CODDISCAP
  START WITH 1
  MAXVALUE 99999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  ORDER;
/
CREATE OR REPLACE PACKAGE BODY Pq_Liqdiaria
AS
PROCEDURE CalculaTotalesxFPagoVTV (FechaIni IN VARCHAR2, FechaFin IN VARCHAR2, FP IN VARCHAR2, CAJ IN NUMBER, NRO IN NUMBER) IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, CODDESCU, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
    	  (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = FP)
	  AND (F.CODFACTU=A.CODFACT)
	  AND (A.TIPOFAC = 'F')		-- DEBERA SER 'F' SI ES DE VTV Y 'G' SI ES DE GNC
	  AND (F.CODCOFAC IS NULL)
	  AND (A.IDUSUARI = CAJ)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de FACTURAS para las NC x Descuento sin NC
      --
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, RELCODFAC, CODDESCU, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
    	  (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = FP)
	  AND (F.CODFACTU=A.CODFACT)
	  AND (A.TIPOFAC = 'D')
	  AND RELCODFAC IS NOT NULL		-- ESTO ES PARA NO SUMAR LAS QUE TIENEN NC
	  AND (A.IDUSUARI = CAJ)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);		     -- Punto de venta pppp
       aFecha VARCHAR2(30);		     -- Para pasar a char la fecha
       aDate DATE;			     -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);		     -- Descripción del Descuento
       aIIBB NUMBER(4,2);		     -- Para almacenar el importe del IIBB
       DebeEnCaja NUMBER(8,2);
       IvaEnCaja NUMBER(8,2);
       IvaNoInscriptoEncaja NUMBER(8,2);
       IIBBEnCaja NUMBER(8,2);
       TotalEnCaja NUMBER(10,2);
       TotalGlobal NUMBER(10,2);
       IvaTotal	   NUMBER(8,2);
    BEGIN
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
         ImporteNeto  := 0.0;
         ImporteNet   := 0.0;
	 aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;		-- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;	-- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
	 IIBBEnCaja := IIBBEnCaja + aIIBB;	-- VOY ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
---------------------------
----- NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
	     aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
	 IIBBEnCaja := IIBBEnCaja - aIIBB;	-- RESTO DEL ACUMULANDO EL IIBB
         --
         --
       END LOOP;
       --
       -- Total en Caja
	 IvaTotal:= IvaEnCaja + IvaNoInscriptoEncaja;
         TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja;
	 TotalGlobal := TotalEnCaja + IIBBEnCaja;
	 INSERT INTO TTMP_LIQDIARIA_TOTFPAGO VALUES
	 (
	   NRO,'V',FP,DebeEnCaja, IvaTotal, IIBBEnCaja, TotalGlobal
	 );
    END;
---
---
PROCEDURE CalculaTotalesxFPagoGNC (FechaIni IN VARCHAR2, FechaFin IN VARCHAR2, FP IN VARCHAR2, CAJ IN NUMBER, NRO IN NUMBER) IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, CODDESCU, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
    	  (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = FP)
	  AND (F.CODFACTU=A.CODFACT)
	  AND (A.TIPOFAC = 'G')		-- DEBERA SER 'F' SI ES DE VTV Y 'G' SI ES DE GNC
	  AND (F.CODCOFAC IS NULL)
	  AND (A.IDUSUARI = CAJ)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
       --
       -- VARIABLES
       --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);		     -- Punto de venta pppp
       aFecha VARCHAR2(30);		     -- Para pasar a char la fecha
       aDate DATE;			     -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);		     -- Descripción del Descuento
       aIIBB NUMBER(4,2);		     -- Para almacenar el importe del IIBB
       DebeEnCaja NUMBER(8,2);
       IvaEnCaja NUMBER(8,2);
       IvaNoInscriptoEncaja NUMBER(8,2);
       IIBBEnCaja NUMBER(8,2);
       TotalEnCaja NUMBER(10,2);
       TotalGlobal NUMBER(10,2);
       IvaTotal	   NUMBER(8,2);
    BEGIN
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
         ImporteNeto  := 0.0;
         ImporteNet   := 0.0;
	 aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;		-- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;	-- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
	 IIBBEnCaja := IIBBEnCaja + aIIBB;	-- VOY ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
       END LOOP;
       --
       -- Total en Caja
	 IvaTotal:= IvaEnCaja + IvaNoInscriptoEncaja;
         TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja;
	 TotalGlobal := TotalEnCaja + IIBBEnCaja;
	 INSERT INTO TTMP_LIQDIARIA_TOTFPAGO VALUES
	 (
	   NRO,'G',FP,DebeEnCaja, IvaTotal, IIBBEnCaja, TotalGlobal
	 );
    END;
--
--
PROCEDURE CalculaGrillaTotales (FechaIni IN VARCHAR2, FechaFin IN VARCHAR2, Cajero IN NUMBER) IS
	--
	-- PROCEDIMIENTO PARA CALCULAR LOS TOTALES POR CADA FORMA DE PAGO VTV Y GNC CON SUBTOTALES
	--
linea	NUMBER(2);
BEGIN
	linea:=1;
	CalculaTotalesxFPagoVTV(FechaIni,FechaFin,'M',Cajero,linea);
	linea:= linea +1;
	CalculaTotalesxFPagoGNC(FechaIni,FechaFin,'M',Cajero,linea);
	linea:= linea +1;
	---
	--- CALCULO EL TOTAL METALICO ('M') PARA VTV Y GNC (S: INDICA SUBTOTAL, M: INDICA Metalico)
	---
	INSERT INTO TTMP_LIQDIARIA_TOTFPAGO
	SELECT linea,'S','M',SUM(SUBTOTAL),SUM(IVATOTAL),SUM(IIBBTOTAL),SUM(TOTAL)
	FROM TTMP_LIQDIARIA_TOTFPAGO
	WHERE FORMPAGO = 'M'
	AND INSPECCION IN ('V','G');
	--
	linea:= linea +1;
	CalculaTotalesxFPagoVTV(FechaIni,FechaFin,'H',Cajero,linea);
	linea:= linea +1;
	CalculaTotalesxFPagoGNC(FechaIni,FechaFin,'H',Cajero,linea);
	linea:= linea +1;
	---
	---
	--- CALCULO EL TOTAL CHEQUES ('H') PARA VTV Y GNC (S: INDICA SUBTOTAL, H: INDICA cHeques)
	---
	INSERT INTO TTMP_LIQDIARIA_TOTFPAGO
	SELECT linea,'S','H',SUM(SUBTOTAL),SUM(IVATOTAL),SUM(IIBBTOTAL),SUM(TOTAL)
	FROM TTMP_LIQDIARIA_TOTFPAGO
	WHERE FORMPAGO = 'H'
	AND INSPECCION IN ('V','G');
	--
	linea:= linea +1;
	--
	--- CALCULO EL TOTAL DE CONTADO ('M'+'H') PARA VTV Y GNC (T: INDICA TOTAL, O: INDICA cOntado)
	---
	INSERT INTO TTMP_LIQDIARIA_TOTFPAGO
	SELECT linea,'T','O',SUM(SUBTOTAL),SUM(IVATOTAL),SUM(IIBBTOTAL),SUM(TOTAL)
	FROM TTMP_LIQDIARIA_TOTFPAGO
	WHERE FORMPAGO IN ('M','H')
	AND INSPECCION IN ('V','G');
	---
	linea:= linea +1;
	--
	CalculaTotalesxFPagoVTV(FechaIni,FechaFin,'T',Cajero,linea);
	linea:= linea +1;
	CalculaTotalesxFPagoGNC(FechaIni,FechaFin,'T',Cajero,linea);
	linea:= linea +1;
	--
	--- CALCULO EL TOTAL DE TARJETA ('T') PARA VTV Y GNC (S: INDICA SUBTOTAL, T: INDICA Tarjeta)
	---
	INSERT INTO TTMP_LIQDIARIA_TOTFPAGO
	SELECT linea,'S','T',SUM(SUBTOTAL),SUM(IVATOTAL),SUM(IIBBTOTAL),SUM(TOTAL)
	FROM TTMP_LIQDIARIA_TOTFPAGO
	WHERE FORMPAGO = 'T'
	AND INSPECCION IN ('V','G');
	--
	linea:= linea +1;
	--
	CalculaTotalesxFPagoVTV(FechaIni,FechaFin,'C',Cajero,linea);
	linea:= linea +1;
	CalculaTotalesxFPagoGNC(FechaIni,FechaFin,'C',Cajero,linea);
	linea:= linea +1;
	--
	--- CALCULO EL TOTAL DE C.CORRIENTE ('C') PARA VTV Y GNC (S: INDICA SUBTOTAL, U: INDICA Cuenta corriente)
	---
	INSERT INTO TTMP_LIQDIARIA_TOTFPAGO
	SELECT linea,'S','C',SUM(SUBTOTAL),SUM(IVATOTAL),SUM(IIBBTOTAL),SUM(TOTAL)
	FROM TTMP_LIQDIARIA_TOTFPAGO
	WHERE FORMPAGO = 'C'
	AND INSPECCION IN ('V','G');
	--
	linea:= linea +1;
	---
	--- CALCULO EL TOTAL DE CREDITO ('T'+'C') PARA VTV Y GNC (T: INDICA TOTAL, R: INDICA cRedito)
	---
	INSERT INTO TTMP_LIQDIARIA_TOTFPAGO
	SELECT linea,'T','R',SUM(SUBTOTAL),SUM(IVATOTAL),SUM(IIBBTOTAL),SUM(TOTAL)
	FROM TTMP_LIQDIARIA_TOTFPAGO
	WHERE FORMPAGO IN ('T','C')
	AND INSPECCION IN ('V','G');
	---
	linea:= linea +1;
	---
	--- CALCULO EL TOTAL GLOBAL ('M'+'H')+('T'+'C') PARA VTV Y GNC (G: INDICA GLOBAL, A: All formpago!)
	---
	INSERT INTO TTMP_LIQDIARIA_TOTFPAGO
	SELECT linea,'T','A',SUM(SUBTOTAL),SUM(IVATOTAL),SUM(IIBBTOTAL),SUM(TOTAL)
	FROM TTMP_LIQDIARIA_TOTFPAGO
	WHERE FORMPAGO IN ('R','O')
	AND INSPECCION = 'T';
	---
	---
END;
--
--
FUNCTION DoTotalesACA  (FechaIni IN VARCHAR2,FechaFin IN VARCHAR2,Cajero IN NUMBER, FP IN VARCHAR2)
RETURN NUMBER
    IS
      --
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas levantando solo las que no tienen
      -- Nota de Crédito
      --
      CURSOR C_SOCIOS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT CODSOCIO,TOTALACA,FECHA FROM SOCIOS_ACAVTV
	WHERE FORMPAGO = FP
	AND IDUSUARIO = Cajero
        AND (FECHA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
        AND (FECHA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       --
       -- VARIABLES
       --
       TotalACA NUMBER(8,2);
--
    BEGIN
       TotalACA := 0.0;
       --
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_SOCIOS_REC IN C_SOCIOS (FechaIni, FechaFin) LOOP
         --
	 --
	 IF C_SOCIOS_REC.TOTALACA IS NOT NULL
	 THEN
		 TotalACA:= TotalACA + C_SOCIOS_REC.TOTALACA;
	 END IF;
	 --
         --
       END LOOP;
       --
	RETURN TotalACA;
    END DoTotalesACA;
--
--
FUNCTION FacturaNoComputable (codigodescuento NUMBER) RETURN VARCHAR2
IS
	NoComputable	VARCHAR2(1);
BEGIN
	NoComputable:='S';
	IF CodigoDescuento IS NULL
	THEN
		NoComputable:='N';
	ELSE
		SELECT DISCRIMCD INTO NoComputable
		FROM TDESCUENTOS
		WHERE CODDESCU = CodigoDescuento;
	END IF;
	--
	--
	RETURN NoComputable;
END FacturaNoComputable;
--
--
FUNCTION CalculaTotalesxTipoCliente (FechaIni IN VARCHAR2, FechaFin IN VARCHAR2, CAJ IN NUMBER, TC IN NUMBER) RETURN NUMBER
IS
      --
      -- DECLARACIONES
      -- ESTE PROCEDIMIENTO VA A CALCULAR PARA LOS TIPOS DE CLIENTE (NORMAL, NORMAL CON VTV VIG, VEH >= 20 Y USUARIO PUBLICO
      -- EL TOTAL CON IVA DE FACTURACION. NO TENIENDO EN CUENTA AQUELLAS FACTURAS EMITIDAS CON DETERMINADOS
      -- DESCUENTOS FILTRADOS CON LA INDICACION EN LA TABLA DE DESCUENTOS DISCRIMCD
      -- SI DISCRIMCD = S significa que no lo tengo en cuenta aca
      -- SI DISCRIMCD = N significa que lo tengo en cuenta
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, F.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          F.CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, IIBB, CODDESCU
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
    	  (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
	  AND (F.CODFACTU=A.CODFACT)
	  AND (A.TIPOFAC = 'F')		-- DEBERA SER 'F' SI ES DE VTV Y 'G' SI ES DE GNC
	  AND (F.CODCOFAC IS NULL)
	  AND (A.IDUSUARI = CAJ)
--	  AND ((A.CODDESCU IN (SELECT CODDESCU FROM TDESCUENTOS WHERE DISCRIMCD = 'N')) OR (A.CODDESCU IS NULL))
--	  AND (FacturaNoComputable(F.CODFACTU) = 'N')
	  AND (TIPOCLIENTE_ID = TC)
          AND (F.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (F.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de FACTURAS para las NC x Descuento sin NC
      --
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, F.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          F.CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, RELCODFAC, IIBB, CODDESCU
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
    	  (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
	  AND (F.CODFACTU=A.CODFACT)
	  AND (A.TIPOFAC = 'D')
	  AND RELCODFAC IS NOT NULL		-- ESTO ES PARA NO SUMAR LAS QUE TIENEN NC
	  AND (A.IDUSUARI = CAJ)
--	  AND ((A.CODDESCU IN (SELECT CODDESCU FROM TDESCUENTOS WHERE DISCRIMCD = 'N')) OR (A.CODDESCU IS NULL))
--	  AND (FacturaNoComputable(F.CODFACTU) = 'N')
	  AND (TIPOCLIENTE_ID = TC)
          AND (F.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (F.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);		     -- Descripción del Descuento
       aIIBB NUMBER(4,2);		     -- Para almacenar el importe del IIBB
       DebeEnCaja NUMBER(8,2);
       IvaEnCaja NUMBER(8,2);
       IvaNoInscriptoEncaja NUMBER(8,2);
       IIBBEnCaja NUMBER(8,2);
       TotalEnCaja NUMBER(10,2);
       TotalGlobal NUMBER(10,2);
       IvaTotal	   NUMBER(8,2);
    BEGIN
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
         ImporteNeto  := 0.0;
         ImporteNet   := 0.0;
	 aIIBB := 0.0;  ----------- INICIALIZO IIBB
       IF FacturaNoComputable(C_FACTURAS_REC.CODDESCU) = 'N'
	THEN
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;		-- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;	-- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
	 IIBBEnCaja := IIBBEnCaja + aIIBB;	-- VOY ACUMULANDO EL IIBB
       END IF;
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
---------------------------
----- NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
       IF FacturaNoComputable(C_NCXDESCUENTO_REC.CODDESCU) = 'N'
	THEN
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
	     aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
	 IIBBEnCaja := IIBBEnCaja - aIIBB;	-- RESTO DEL ACUMULANDO EL IIBB
         --
         --
       END IF;
       END LOOP;
       --
       -- Total en Caja
	 IvaTotal:= IvaEnCaja + IvaNoInscriptoEncaja;
         TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja;
	 TotalGlobal := TotalEnCaja + IIBBEnCaja;
       --
       --
	RETURN DebeEnCaja;
    END CalculaTotalesxTipoCliente;
---
---
FUNCTION CalculaTotalesxDescuento (FechaIni IN VARCHAR2, FechaFin IN VARCHAR2, Cajero IN NUMBER, Descuento IN NUMBER)
RETURN NUMBER
IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, CODDESCU, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
          (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
    	  AND (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (F.CODCOFAC IS NULL)
	  AND (F.CODFACTU=A.CODFACT)
	  AND (A.TIPOFAC = 'F')		-- DEBERA SER 'F' SI ES DE VTV Y 'G' SI ES DE GNC
	  AND (A.IDUSUARI = Cajero)
	  AND (A.CODDESCU = Descuento);
      --
      -- Cursor que recorre toda la tabla de FACTURAS para las NC x Descuento sin NC
      --
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, RELCODFAC, CODDESCU, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
              (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
    	  AND (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
	  AND (F.CODFACTU=A.CODFACT)
          AND (A.CODDESCU = Descuento)
	  AND (A.TIPOFAC = 'D')
	  AND RELCODFAC IS NOT NULL		-- ESTO ES PARA NO SUMAR LAS QUE TIENEN NC
	  AND (A.IDUSUARI = Cajero);
       --
       --
       -- VARIABLES
       --
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       aIIBB NUMBER(4,2);		     -- Para almacenar el importe del IIBB
       DebeEnCaja NUMBER(8,2);
       IvaEnCaja NUMBER(8,2);
       IvaNoInscriptoEncaja NUMBER(8,2);
       IIBBEnCaja NUMBER(8,2);
       TotalEnCaja NUMBER(10,2);
       TotalGlobal NUMBER(10,2);
       IvaTotal	   NUMBER(8,2);
    BEGIN
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
         ImporteNeto  := 0.0;
         ImporteNet   := 0.0;
	 aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;		-- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;	-- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
	 IIBBEnCaja := IIBBEnCaja + aIIBB;	-- VOY ACUMULANDO EL IIBB
         --
         --
       END LOOP;
       --
---------------------------
----- NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
	     aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
	 IIBBEnCaja := IIBBEnCaja - aIIBB;	-- RESTO DEL ACUMULANDO EL IIBB
         --
         --
       END LOOP;
       --
       -- Total en Caja
	 IvaTotal:= IvaEnCaja + IvaNoInscriptoEncaja;
         TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja;
	 TotalGlobal := TotalEnCaja + IIBBEnCaja;
--
	 RETURN DebeEnCaja;
    END CalculaTotalesxDescuento;
---
---
--
PROCEDURE CalculaTotalesUsuarios (FechaIni IN VARCHAR2, FechaFin IN VARCHAR2, Cajero IN NUMBER) IS
	--
	-- PROCEDIMIENTO PARA CALCULAR LOS TOTALES POR USUARIO (CON IVA INCLUIDO)
	--
	-- CONSTANTES
		USUARIO_NORMAL         CONSTANT NUMBER(8) := 1;
		USUARIO_M20            CONSTANT NUMBER(8) := 11;
		USUARIO_PUBLICO        CONSTANT NUMBER(8) := 7;
		USUARIO_NORMAL_VIG     CONSTANT NUMBER(8) := 10;
		USUARIO_TPP_VIG     CONSTANT NUMBER(8) := 12;
  USUARIO_PUBLICO_VIG        CONSTANT NUMBER(8) := 13;
BEGIN
	---
	--- CALCULO EL TOTAL DE CONTADO ('M'+'H') PARA VTV Y GNC (T: INDICA TOTAL, O: INDICA cOntado)
	---
	INSERT INTO TTMPTOTALXUSU
	SELECT 'NORMAL',CalculaTotalesxTipoCliente(FechaIni,FechaFin,Cajero,USUARIO_NORMAL) FROM DUAL;
	---
	INSERT INTO TTMPTOTALXUSU
	SELECT 'VEH. >= 20 A¥OS',CalculaTotalesxTipoCliente(FechaIni,FechaFin,Cajero,USUARIO_M20) FROM DUAL;
	---
	INSERT INTO TTMPTOTALXUSU
	SELECT 'USUARIO PUBLICO',CalculaTotalesxTipoCliente(FechaIni,FechaFin,Cajero,USUARIO_PUBLICO) FROM DUAL;
	---
	INSERT INTO TTMPTOTALXUSU
	SELECT 'NORMAL VTV VIG',CalculaTotalesxTipoCliente(FechaIni,FechaFin,Cajero,USUARIO_NORMAL_VIG) FROM DUAL;
	---
	INSERT INTO TTMPTOTALXUSU
	SELECT 'TPP VTV VIG',CalculaTotalesxTipoCliente(FechaIni,FechaFin,Cajero,USUARIO_TPP_VIG) FROM DUAL;
	---
INSERT INTO TTMPTOTALXUSU
	SELECT 'USU PUB VTV VIG' ,CalculaTotalesxTipoCliente(FechaIni,FechaFin,Cajero,USUARIO_PUBLICO_VIG) FROM DUAL;
	---
END;
--
--
PROCEDURE CalculaTotalesDescuentos (FechaIni IN VARCHAR2, FechaFin IN VARCHAR2, Cajero IN NUMBER) IS
	--
	-- PROCEDIMIENTO PARA CALCULAR LOS TOTALES POR DESCUENTOS (CON IVA INCLUIDO)
	--
      CURSOR C_DESCUENTOS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT CODDESCU,CONCEPTO FROM TDESCUENTOS
	WHERE FECVIGINI <= TO_DATE(FechaFin,'DD/MM/YYYY HH24:MI:SS')
	AND (FECVIGINI >= TO_DATE(FechaIni,'DD/MM/YYYY HH24:MI:SS') OR (FECVIGFIN >= TO_DATE(FechaIni,'DD/MM/YYYY HH24:MI:SS') OR FECVIGFIN IS NULL))
	AND (ACTIVO='S')
	AND (DISCRIMCD='S');
BEGIN
	---
	FOR C_DESCUENTOS_REC IN C_DESCUENTOS (FechaIni, FechaFin) LOOP
	---
	INSERT INTO TTMPTOTALXDESC
	SELECT
	C_DESCUENTOS_REC.CONCEPTO,CalculaTotalesxDescuento(FechaIni,FechaFin,Cajero,C_DESCUENTOS_REC.CODDESCU)
	FROM DUAL;
	---
	END LOOP;
END;
--
PROCEDURE CalculaTotalesxClienteCtaCte (FechaIni IN VARCHAR2, FechaFin IN VARCHAR2,CAJ IN NUMBER) IS
      --
      -- DECLARACIONES

      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          F.CODFACTU, F.NUMFACTU, F.FECHALTA,F.FORMPAGO, F.IMPONETO, F.TIPFACTU,F. IVAINSCR,
          F.CODCLIEN, trim(C.nombre )|| '  '|| C.apellid1 AS NOMBRE    , IVANOINS, CODCOFAC, F.TIPOCLIENTE_ID,A.CODDESCU, F.IIBB,C.document
        FROM
          TFACTURAS F, TFACT_ADICION A,TCLIENTES C
        WHERE
    	  (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = 'C')
	  AND (F.CODFACTU=A.CODFACT)
	  AND (F.CODCLIEN= C.codclien)
	  AND (A.TIPOFAC = 'F')		-- DEBERA SER 'F' SI ES DE VTV Y 'G' SI ES DE GNC
	  AND (F.CODCOFAC IS NULL)
	  AND (A.IDUSUARI = CAJ)
          AND (F.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (F.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de FACTURAS para las NC x Descuento sin NC
      --
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          F.CODFACTU, F.NUMFACTU, F.FECHALTA, F.FORMPAGO,F. IMPONETO, F.TIPFACTU, F.IVAINSCR,
          F.CODCLIEN, trim(C.nombre )|| '  '|| C.apellid1 AS NOMBRE ,F.IVANOINS, CODCOFAC, F.TIPOCLIENTE_ID, RELCODFAC, A.CODDESCU, F.IIBB,C.document
        FROM
          TFACTURAS F, TFACT_ADICION A,TCLIENTES C
        WHERE
    	  (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = 'C')
	    AND (F.CODFACTU=A.CODFACT)
	  	 AND (F.CODCLIEN=C.CODCLIEN)
	  AND (A.TIPOFAC = 'D')
	  AND RELCODFAC IS NOT NULL		-- ESTO ES PARA NO SUMAR LAS QUE TIENEN NC
	  AND (A.IDUSUARI = CAJ)
          AND (F.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (F.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);		     -- Punto de venta pppp
       aFecha VARCHAR2(30);		     -- Para pasar a char la fecha
       aDate DATE;			     -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);		     -- Descripción del Descuento
       aIIBB NUMBER(4,2);		     -- Para almacenar el importe del IIBB
       DebeEnCaja NUMBER(8,2);
       IvaEnCaja NUMBER(8,2);
       IvaNoInscriptoEncaja NUMBER(8,2);
       IIBBEnCaja NUMBER(8,2);
       TotalEnCaja NUMBER(10,2);
       TotalGlobal NUMBER(10,2);
       IvaTotal	   NUMBER(8,2);
    BEGIN
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --

	    DELETE   FROM TTMP_LIQDIARIA_CLIENTCTACTE ;
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
         ImporteNeto  := 0.0;
         ImporteNet   := 0.0;
	 aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;		-- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
	     aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;	-- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;

         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
     INSERT INTO TTMP_LIQDIARIA_CLIENTCTACTE  VALUES
	 ( C_FACTURAS_REC.NOMBRE ,1,C_FACTURAS_REC.DOCUMENT,ImporteNeto, aIva, aIIBB, ImporteTotal,CAJ );

         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
---------------------------
----- NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
         --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
	     ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
	     aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);		-- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
	     aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);	-- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;


	    INSERT INTO TTMP_LIQDIARIA_CLIENTCTACTE  VALUES
	 ( C_NCXDESCUENTO_REC. NOMBRE,1,C_NCXDESCUENTO_REC. DOCUMENT,ImporteNeto, aIva, aIIBB, ImporteTotal,CAJ );
         --
       END LOOP;
       --

    END;
---
--
END Pq_Liqdiaria;
--
/
CREATE OR REPLACE FUNCTION rellena_doc (adocument VARCHAR2)
   RETURN VARCHAR2
IS
--
   doc1      VARCHAR2 (13);
   doc      VARCHAR2 (13);
   letras   VARCHAR2 (100);
   valor    VARCHAR2 (1);
   i        NUMBER (2);
--
BEGIN
   doc1 := adocument;
   letras := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
   i := 1;

 FOR I IN 1..LENGTH(LETRAS) LOOP
      valor := SUBSTR (letras, I, 1);
      doc1 := REPLACE (doc1,valor,'1');

     END LOOP;

DOC:=DOC1;
   RETURN doc;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN (adocument);
   WHEN OTHERS
   THEN
      RETURN (adocument);
END;
/
CREATE OR REPLACE PACKAGE BODY Pq_Afip_Cisa
AS
--
   PROCEDURE doventascisa (
      fechaini             IN   VARCHAR2,
      fechafin             IN   VARCHAR2,
      caia                 IN   VARCHAR2,
      fecha_vencimientoa   IN   VARCHAR2,
      caib                 IN   VARCHAR2,
      fecha_vencimientob   IN   VARCHAR2
   )
   IS
      fecha_actual          VARCHAR2 (10);

      CURSOR cfacturas (fi IN VARCHAR2, ff IN VARCHAR2)
      IS
         SELECT codcofac, a.tipofac, a.codfact,
                TO_CHAR (f.fechalta, 'yyyymmdd') fecha,             --CAMPO 2
                DECODE (f.tipfactu, 'A', '01', 'B', '06') tipo_f,
                TO_CHAR (TRIM (a.ptovent), '0000') AS PTOVENTA,
                TRIM (TO_CHAR (f.numfactu, '00000000')) numfact,    --CAMPO 6
                TRIM (TO_CHAR (f.numfactu, '00000000')) numfacthasta,
                DECODE (cl.tipodocu,
                        'CUIT', '80',
                        'CUIL', '86',
                        'CDI', '87',
                        'LE', '89',
                        'LC', '91',
                        'CI', '00',
                        'en tramite', '92',
                        'DNI', '96'
                       ) tipodocu,
                cl.document,
                SUBSTR ((cl.nombre || ' ' || cl.apellid1 || ' ' || cl.apellid2
                        ),
                        1,
                        30
                       ) app_nombre,
                (f.imponeto * 21) / 100 + f.imponeto importetotal,
                0 AS otrosimp, f.imponeto, f.ivainscr,
                - ((f.imponeto * 21) / 100) liqiva, f.ivanoins, 0 AS rni,
                0 AS impexentas, 0 AS otraspercepciones, iibb AS impiibb,
                0 AS impimpuestomunicipales, 0 AS impimpuestointernos,
                DECODE (f.tiptribu,
                        'I', '01',
                        'E', '04',
                        'C', '05',
                        'M', '06'
                       ) AS TIPO_RESPONSABLE,
                'PES' codigo_moneda, '0001000000' tipo_cambio,
                '1' cant_alicuotas, ' ' codigo_operacion
           FROM TFACTURAS f, TFACT_ADICION a, TCLIENTES cl
          WHERE (NOT f.numfactu IS NULL)
            AND (f.numfactu > 0)
            AND (f.impresa IN ('S', 'R'))
            AND (f.tipfactu IN ('A', 'B'))
            AND (f.error = 'N')
            AND (f.codclien = cl.codclien)
            AND (f.codfactu = a.codfact)
            AND (NOT (a.tipofac = 'D'))
            AND (f.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24::MI::SS'))
            AND (f.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24::MI::SS'));
/*
      --
      CURSOR cnotas_credito (fi IN VARCHAR2, ff IN VARCHAR2)
      IS
         SELECT a.tipofac, a.codfact, TO_CHAR (f.fechalta, 'yyyymmdd') fecha,
                DECODE (f.tipfactu, 'A', '03', 'B', '08') tipo_f,
                TO_CHAR (TRIM (a.ptovent), '0000') AS PTOVENTA,
                TRIM (TO_CHAR (f.numfactu, '00000000')) numfact,
                TRIM (TO_CHAR (f.numfactu, '00000000')) numfacthasta,
                DECODE (cl.tipodocu,
                        'CUIT', '80',
                        'CUIL', '86',
                        'CDI', '87',
                        'LE', '89',
                        'LC', '91',
                        'CI', '00',
                        'en tramite', '92',
                        'DNI', '96'
                       ) tipodocu,
                cl.document,
                SUBSTR ((cl.nombre || ' ' || cl.apellid1 || ' ' || cl.apellid2
                        ),
                        1,
                        30
                       ) app_nombre,
                (f.imponeto * 21) / 100 + f.imponeto importetotal,
                0 AS otrosimp, f.imponeto, f.ivainscr,
                ((f.imponeto * 21) / 100) liqiva, f.ivanoins, 0 AS rni,
                0 AS impexentas, 0 AS otraspercepciones, iibb AS impiibb,
                0 AS impimpuestomunicipales, 0 AS impimpuestointernos,
                DECODE (f.tiptribu,
                        'I', '01',
                        'E', '04',
                        'C', '05',
                        'M', '06'
                       ) AS TIPO_RESPONSABLE,
                'PES' codigo_moneda, '0001000000' tipo_cambio,
                '1' cant_alicuotas, ' ' codigo_operacion
           FROM TFACTURAS f, TCONTRAFACT c, TFACT_ADICION a, TCLIENTES cl
          WHERE f.codcofac = c.codcofac
            AND (f.codclien = cl.codclien)
            AND (f.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24::MI::SS'))
            AND (c.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24::MI::SS'))
            AND (c.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24::MI::SS'))
            AND (NOT f.numfactu IS NULL)
            AND (f.numfactu > 0)
            AND (c.numfactu > 0)
            AND (NOT c.numfactu IS NULL)
            AND (f.tipfactu IN ('A', 'B'))
            AND (f.impresa IN ('S', 'R'))
            AND (c.impresa IN ('S', 'R'))
            AND (f.error = 'N')
            AND (c.codcofac = a.codfact)
            AND (tipofac IN ('N', 'C'));*/

--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
      CURSOR c_ncxdescuento (fi IN VARCHAR2, ff IN VARCHAR2)
      IS
         SELECT a.tipofac, a.codfact, TO_CHAR (f.fechalta, 'yyyymmdd') fecha,
                DECODE (f.tipfactu, 'A', '03', 'B', '08') tipo_f,
                TO_CHAR (TRIM (a.ptovent), '0000') AS PTOVENTA,
                TRIM (TO_CHAR (f.numfactu, '00000000')) numfact,
                TRIM (TO_CHAR (f.numfactu, '00000000')) numfacthasta,
                DECODE (cl.tipodocu,
                        'CUIT', '80',
                        'CUIL', '86',
                        'CDI', '87',
                        'LE', '89',
                        'LC', '91',
                        'CI', '00',
                        'en tramite', '92',
                        'DNI', '96'
                       ) tipodocu,
                cl.document,
                SUBSTR ((cl.nombre || ' ' || cl.apellid1 || ' ' || cl.apellid2
                        ),
                        1,
                        30
                       ) app_nombre,
                f.imponeto, f.ivainscr, f.ivanoins, 0 otrosimp,
                iibb AS impiibb, 0 AS impimpuestomunicipales,
                0 AS impimpuestointernos, 0 AS otraspercepciones,
                DECODE (f.tiptribu,
                        'I', '01',
                        'E', '04',
                        'C', '05',
                        'M', '06'
                       ) AS TIPO_RESPONSABLE,
                'PES' codigo_moneda, '0001000000' tipo_cambio,
                0 AS impexentas, '1' cant_alicuotas, ' ' codigo_operacion
           FROM TFACTURAS f, TFACT_ADICION a, TCLIENTES cl
          WHERE (NOT f.numfactu IS NULL)
            AND (f.numfactu > 0)
            AND (f.codclien = cl.codclien)
            AND (impresa IN ('S', 'R'))
            AND (f.tipfactu IN ('A', 'B'))
            AND (error = 'N')
            AND (f.codfactu = a.codfact)
            AND (a.tipofac = 'D')
            AND a.relcodfac IS NOT NULL
            AND (f.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24::MI::SS'))
            AND (f.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24::MI::SS'));

      /* CURSOR c_ventast1
       IS
          SELECT COUNT (*) cant_registro_tipo1, SUM (importe_total_11) sum11,
                 SUM (importe_12) sum12, SUM (importe_neto_13) sum13,
                 SUM (impuesto_liquidado) sum15, SUM (impuesto_16) sum16,
                 SUM (importe_exentas_17) sum17,
                 SUM (importe_nacional_18) sum18, SUM (importe_iibb_19) sum19,
                 SUM (importe_munic_20) sum20,
                 SUM (importe_impintenos_21) sum21
            FROM seguros.registro_ventas_t1;*/
      nombrecompleto        VARCHAR2 (110);
      -- Nombre del cliente Nombre Apellido 1 Apellido 2
      numerofactura         VARCHAR2 (50);
      -- Numero de factura t-eeee-nnnnnnnn
      numerocontrafactura   NUMBER;
      estacion              VARCHAR2 (10);                    -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      PTOVENTA              VARCHAR2 (10);              -- Punto de venta pppp
      aptoventa             NUMBER (4);    -- Para el punto de venta de las nc
      afecha                VARCHAR2 (30);       -- Para pasar a char la fecha
      adate                 DATE;     -- Para pasar la fecha de contrafacturas
      atipo                 VARCHAR2 (1);
      anumfactu             NUMBER;      -- Para sacarles los 9 a las facturas
      anewfactu             NUMBER;
-------------
      Cuitcliente           VARCHAR2 (13);
      fechacontrafactura    DATE;
      --variables
      aivano                NUMBER (4, 2);
      aivain                NUMBER (4, 2);
      importegravado        NUMBER (8, 2);
      tasa                  NUMBER (4, 2);
      poriva                NUMBER (8, 2);
      importetotal          NUMBER (8, 2);
      aiibb                 NUMBER (4, 2);
      anyo_documento        VARCHAR2 (4);
      periodo               VARCHAR2 (6);
      cuit_informante       VARCHAR2 (11);
      relleno_0             VARCHAR2 (5);
      relleno_1             VARCHAR2 (31);
      relleno_2             VARCHAR2 (30);
      relleno_3             VARCHAR2 (4);
      relleno_4             VARCHAR2 (114);
      controladorfiscal     VARCHAR2 (1);
      tiponc                VARCHAR2 (2);
      cai                   VARCHAR2 (14);
      fecha_vencimiento     VARCHAR (8);
   BEGIN
      cuit_informante := '30685200143';
      --
      relleno_0 := '     ';
      relleno_1 := '          ';
      relleno_2 := '          ' || '          ' || '          ';
      relleno_3 := '    ';
      relleno_4 := '          ';

      FOR cfc IN cfacturas (fechaini, fechafin)
      LOOP
         aivano := 0.0;
         aivain := 0.0;
         importetotal := 0.0;
         importegravado := 0.0;
         tasa := 0.0;
         poriva := 0.0;
         aiibb := 0.0;
         tiponc := '00';

         IF cfc.tipo_f = '06'
         THEN
            importegravado := (cfc.imponeto / (1 + (cfc.ivainscr / 100)));
            poriva := cfc.imponeto - importegravado;
            tasa := cfc.ivainscr;
            aiibb := ((cfc.imponeto * cfc.impiibb) / 100); -- calculo el iibb
            importetotal := cfc.imponeto + aiibb;
            tiponc := '08';                          -- sumo al total el iibb
            cai := TRIM (caib);
            fecha_vencimiento :=
               TO_CHAR (TO_DATE (fecha_vencimientob, 'DD/MM/YYYY'),
                        'YYYYMMDD'
                       );
         ELSE
            importegravado := cfc.imponeto;
            aivain := ((cfc.imponeto * cfc.ivainscr) / 100);
            aivano := ((cfc.imponeto * cfc.ivanoins) / 100);
            poriva := aivain + aivano;
            tasa := cfc.ivainscr + cfc.ivanoins;
            aiibb := ((cfc.imponeto * cfc.impiibb) / 100); -- calculo el iibb
            importetotal := cfc.imponeto + aivain + aivano + aiibb;
            tiponc := '03';
            cai := TRIM (caia);
            fecha_vencimiento :=
               TO_CHAR (TO_DATE (fecha_vencimientoa, 'DD/MM/YYYY'),
                        'YYYYMMDD'
                       );
         -- sumo al total el iibb
         END IF;

         SELECT DISTINCT tipo
                    INTO controladorfiscal
                    FROM TPTOVENTA
                   WHERE PTOVENTA =
                            TRIM (TO_CHAR (Obtieneptoventa (cfc.codfact,
                                                            cfc.tipofac,
                                                            cfc.fecha
                                                           ),
                                           '0000'
                                          )
                                 );

         INSERT INTO seguros.REGISTRO_VENTAS_T1
                     (tipo, fecha_comprobante, TIPO_COMPROBANTE,
                      controlador_fiscal,
                      punto_venta,
                      nro_comprobante, nro_comprobante_hasta,
                      cod_identif_comprador, nro_identif_comprador,
                      ap_nombres_comprador, importe_total_11, importe_12,
                      importe_neto_13, ALICUOTA_IVA, impuesto_liquidado,
                      impuesto_16, importe_exentas_17, importe_nacional_18,
                      importe_iibb_19, importe_munic_20,
                      importe_impintenos_21, TIPO_RESPONSABLE,
                      codigo_moneda, tipo_cambio, cant_alicuota_iva,
                      codigo_operacion, cai, fecha_vencimiento,
                      fecha_anulacion_compr, informacion_adicional
                     )
              VALUES (1, cfc.fecha, cfc.tipo_f,
                      controladorfiscal,
                      TRIM (TO_CHAR (Obtieneptoventa (cfc.codfact,
                                                      cfc.tipofac,
                                                      cfc.fecha
                                                     ),
                                     '0000'
                                    )
                           ),
                      cfc.numfact, cfc.numfacthasta,
                      cfc.tipodocu,Rellena_Doc(REPLACE (cfc.document, '-', '')),
                      cfc.app_nombre, importetotal, cfc.otrosimp,
                      importegravado, cfc.ivainscr, poriva,
                      0,                                            --cfc.rni,
                        cfc.impexentas, cfc.otraspercepciones,
                      aiibb, cfc.impimpuestomunicipales,
                      cfc.impimpuestointernos, cfc.TIPO_RESPONSABLE,
                      cfc.codigo_moneda, cfc.tipo_cambio, cfc.cant_alicuotas,
                      cfc.codigo_operacion, cai, fecha_vencimiento,
                      ' ', 'RRR'
                     );

         COMMIT;

         IF NOT cfc.codcofac IS NULL
         THEN
            SELECT fechalta, fechalta, numfactu, ptovent
              INTO fechacontrafactura, adate, numerocontrafactura, aptoventa
              FROM TCONTRAFACT c, TFACT_ADICION a
             WHERE (codcofac = cfc.codcofac)
               AND c.codcofac = a.codfact
               AND a.tipofac IN ('C', 'N');

            -- LAS NOTAS DE CREDITO GNC SON TIPOFAC=C LAS VTV SON TIPOFAC=N

            --
            SELECT fechalta, fechalta, numfactu
              INTO fechacontrafactura, adate, numerocontrafactura
              FROM TCONTRAFACT
             WHERE (codcofac = cfc.codcofac);

            --   UPDATE seguros.registro_ventas_t1
               --   SET fecha_anulacion_compr =
                         --                TO_CHAR (fechacontrafactura, 'YYYYMMDD')
               -- WHERE nro_comprobante = cfc.numfact;
                -- COMMIT;
               --
               -- Si esta dentro del intervalo de fechas
               --
            IF     (numerocontrafactura > 0)
               AND (fechacontrafactura >=
                                 TO_DATE (fechaini, 'DD/MM/YYYY HH24::MI::SS')
                   )
               AND (fechacontrafactura <=
                                 TO_DATE (fechafin, 'DD/MM/YYYY HH24::MI::SS')
                   )
            THEN
                    --
                    -- Se calcula de nuevo su numero de factura, pues no vale el anterior
                    --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
               PTOVENTA := TO_CHAR (aptoventa, '0000');

               SELECT DISTINCT tipo
                          INTO controladorfiscal
                          FROM TPTOVENTA
                         WHERE PTOVENTA =
                                  TRIM
                                      (TO_CHAR (Obtieneptoventa (cfc.codfact,
                                                                 cfc.tipofac,
                                                                 cfc.fecha
                                                                ),
                                                '0000'
                                               )
                                      );

               numerofactura :=
                             LTRIM (TO_CHAR (numerocontrafactura, '00000000'));

               INSERT INTO seguros.REGISTRO_VENTAS_T1
                           (tipo, fecha_comprobante,
                            TIPO_COMPROBANTE, controlador_fiscal,
                            punto_venta,
                            nro_comprobante, nro_comprobante_hasta,
                            cod_identif_comprador, nro_identif_comprador,
                            ap_nombres_comprador, importe_total_11,
                            importe_12, importe_neto_13, ALICUOTA_IVA,
                            impuesto_liquidado, impuesto_16,
                            importe_exentas_17, importe_nacional_18,
                            importe_iibb_19, importe_munic_20,
                            importe_impintenos_21, TIPO_RESPONSABLE,
                            codigo_moneda, tipo_cambio,
                            cant_alicuota_iva, codigo_operacion, cai,
                            fecha_vencimiento, fecha_anulacion_compr,
                            informacion_adicional
                           )
                    VALUES (1, TO_CHAR (fechacontrafactura, 'YYYYMMDD'),
                            tiponc, controladorfiscal,
                            TRIM (TO_CHAR (Obtieneptoventa (cfc.codfact,
                                                            cfc.tipofac,
                                                            cfc.fecha
                                                           ),
                                           '0000'
                                          )
                                 ),
                            numerofactura, numerofactura,
                            cfc.tipodocu, Rellena_Doc(REPLACE (cfc.document, '-', '')),
                            cfc.app_nombre, -importetotal,
                            -cfc.otrosimp, -importegravado, cfc.ivainscr,
                           - poriva, 0,                              --cfc.rni,
                           - cfc.impexentas, -cfc.otraspercepciones,
                          -  aiibb,- cfc.impimpuestomunicipales,
                           - cfc.impimpuestointernos, cfc.TIPO_RESPONSABLE,
                            cfc.codigo_moneda, cfc.tipo_cambio,
                            cfc.cant_alicuotas, cfc.codigo_operacion, cai,
                            fecha_vencimiento, ' ',
                            'AA '
                           );
            END IF;
         END IF;
      END LOOP;

      /*FOR cnc IN cnotas_credito (fechaini, fechafin)
      LOOP
         aivano := 0.0;
         aivain := 0.0;
         importetotal := 0.0;
         importegravado := 0.0;
         tasa := 0.0;
         poriva := 0.0;
         aiibb := 0.0;

         IF cnc.tipo_f = '08'
         THEN
            importegravado := (cnc.imponeto / (1 + (cnc.ivainscr / 100)));
            poriva := cnc.imponeto - importegravado;
            tasa := cnc.ivainscr;
            aiibb := ((cnc.imponeto * cnc.impiibb) / 100); -- calculo el iibb
            importetotal := cnc.imponeto + aiibb;    -- sumo al total el iibb
            cai := caib;
            fecha_vencimiento :=
               TO_CHAR (TO_DATE (fecha_vencimientob, 'DD/MM/YYYY'),
                        'YYYYMMDD'
                       );
         ELSE
            importegravado := cnc.imponeto;
            aivain := ((cnc.imponeto * cnc.ivainscr) / 100);
            aivano := ((cnc.imponeto * cnc.ivanoins) / 100);
            poriva := aivain + aivano;
            tasa := cnc.ivainscr + cnc.ivanoins;
            aiibb := ((cnc.imponeto * cnc.impiibb) / 100); -- calculo el iibb
            importetotal := cnc.imponeto + aivain + aivano + aiibb;
            cai := caia;
            fecha_vencimiento :=
               TO_CHAR (TO_DATE (fecha_vencimientoa, 'DD/MM/YYYY'),
                        'YYYYMMDD'
                       );
         -- sumo al total el iibb
         END IF;

         SELECT DISTINCT tipo
                    INTO controladorfiscal
                    FROM TPTOVENTA
                   WHERE PTOVENTA =
                            TRIM (TO_CHAR (Obtieneptoventa (cnc.codfact,
                                                            cnc.tipofac,
                                                            cnc.fecha
                                                           ),
                                           '0000'
                                          )
                                 );

         INSERT INTO seguros.REGISTRO_VENTAS_T1
                     (tipo, fecha_comprobante, TIPO_COMPROBANTE,
                      controlador_fiscal,
                      punto_venta,
                      nro_comprobante, nro_comprobante_hasta,
                      cod_identif_comprador, nro_identif_comprador,
                      ap_nombres_comprador, importe_total_11, importe_12,
                      importe_neto_13, ALICUOTA_IVA, impuesto_liquidado,
                      impuesto_16, importe_exentas_17, importe_nacional_18,
                      importe_iibb_19, importe_munic_20,
                      importe_impintenos_21, TIPO_RESPONSABLE,
                      codigo_moneda, tipo_cambio, cant_alicuota_iva,
                      codigo_operacion, cai, fecha_vencimiento,
                      fecha_anulacion_compr, informacion_adicional
                     )
              VALUES (1, cnc.fecha, cnc.tipo_f,
                      controladorfiscal,
                      TRIM (TO_CHAR (Obtieneptoventa (cnc.codfact,
                                                      cnc.tipofac,
                                                      cnc.fecha
                                                     ),
                                     '0000'
                                    )
                           ),
                      cnc.numfact, cnc.numfacthasta,
                      cnc.tipodocu, Rellena_Doc(REPLACE (cnc.document, '-', '')),
                      cnc.app_nombre, -importetotal, -cnc.otrosimp,
                      -importegravado, cnc.ivainscr, -poriva,
                      0,                                           -- cnc.rni,
                        -cnc.impexentas, -cnc.otraspercepciones,
                      -aiibb, -cnc.impimpuestomunicipales,
                      -cnc.impimpuestointernos, cnc.TIPO_RESPONSABLE,
                      cnc.codigo_moneda, cnc.tipo_cambio, cnc.cant_alicuotas,
                      cnc.codigo_operacion, cai, fecha_vencimiento,
                      'X', ' BB'
                     );
      END LOOP;
*/
      FOR cd IN c_ncxdescuento (fechaini, fechafin)
      LOOP
         IF cd.tipo_f = '08'
         THEN
            importegravado := (cd.imponeto / (1 + (cd.ivainscr / 100)));
            poriva := cd.imponeto - importegravado;
            tasa := cd.ivainscr;
            aiibb := ((cd.imponeto * cd.impiibb) / 100);   -- calculo el iibb
            importetotal := cd.imponeto + aiibb;     -- sumo al total el iibb
            cai := caib;
            fecha_vencimiento :=
               TO_CHAR (TO_DATE (fecha_vencimientob, 'DD/MM/YYYY'),
                        'YYYYMMDD'
                       );
         ELSE
            importegravado := cd.imponeto;
            aivain := ((cd.imponeto * cd.ivainscr) / 100);
            aivano := ((cd.imponeto * cd.ivanoins) / 100);
            poriva := aivain + aivano;
            tasa := cd.ivainscr + cd.ivanoins;
            aiibb := ((cd.imponeto * cd.impiibb) / 100);   -- calculo el iibb
            importetotal := cd.imponeto + aivain + aivano + aiibb;
            -- sumo al total el iibb
            cai := caia;
            fecha_vencimiento :=
               TO_CHAR (TO_DATE (fecha_vencimientoa, 'DD/MM/YYYY'),
                        'YYYYMMDD'
                       );
         END IF;

         SELECT DISTINCT tipo
                    INTO controladorfiscal
                    FROM TPTOVENTA
                   WHERE PTOVENTA =
                            TRIM (TO_CHAR (Obtieneptoventa (cd.codfact,
                                                            cd.tipofac,
                                                            cd.fecha
                                                           ),
                                           '0000'
                                          )
                                 );

         INSERT INTO seguros.REGISTRO_VENTAS_T1
                     (tipo, fecha_comprobante, TIPO_COMPROBANTE,
                      controlador_fiscal,
                      punto_venta,
                      nro_comprobante, nro_comprobante_hasta,
                      cod_identif_comprador, nro_identif_comprador,
                      ap_nombres_comprador, importe_total_11, importe_12,
                      importe_neto_13, ALICUOTA_IVA, impuesto_liquidado,
                      impuesto_16, importe_exentas_17, importe_nacional_18,
                      importe_iibb_19, importe_munic_20,
                      importe_impintenos_21, TIPO_RESPONSABLE,
                      codigo_moneda, tipo_cambio, cant_alicuota_iva,
                      codigo_operacion, cai, fecha_vencimiento,
                      fecha_anulacion_compr, informacion_adicional
                     )
              VALUES (1, cd.fecha, cd.tipo_f,
                      controladorfiscal,
                      TRIM (TO_CHAR (Obtieneptoventa (cd.codfact,
                                                      cd.tipofac,
                                                      cd.fecha
                                                     ),
                                     '0000'
                                    )
                           ),
                      cd.numfact, cd.numfacthasta,
                      cd.tipodocu,Rellena_Doc(REPLACE (cd.document, '-', '')),
                      cd.app_nombre, -importetotal, -cd.otrosimp,
                      -importegravado, cd.ivainscr, -poriva,
                      0, -cd.impexentas, -cd.otraspercepciones,
                      -aiibb, -cd.impimpuestomunicipales,
                      -cd.impimpuestointernos, cd.TIPO_RESPONSABLE,
                      cd.codigo_moneda, cd.tipo_cambio, cd.cant_alicuotas,
                      cd.codigo_operacion, cai, fecha_vencimiento,
                      'X', 'CC '
                     );
      END LOOP;
   /*  anyo_documento :=
              TO_CHAR (TO_DATE (fechafin, 'DD/MM/YYYY HH24::MI::SS'), 'YYYY');
     periodo :=
            TO_CHAR (TO_DATE (fechafin, 'DD/MM/YYYY HH24::MI::SS'), 'YYYYMM');

     FOR ct IN c_ventast1
     LOOP
        INSERT INTO seguros.registro_ventas_t2
                    (tipo, periodo, relleno_0, cant_registro_t1,
                     relleno_1, cuit_informante, relleno_2,
                     sumatoria_t1c11, sumatoria_t1c12, sumatoria_t1c13,
                     relleno_3, sumatoria_t1c15, sumatoria_t1c16,
                     sumatoria_t1c17, sumatoria_t1c18, sumatoria_t1c19,
                     sumatoria_t1c20, sumatoria_t1c21, relleno_4
                    )
             VALUES (2, periodo, relleno_0, ct.cant_registro_tipo1,
                     relleno_1, cuit_informante, relleno_2,
                     ct.sum11, ct.sum12, ct.sum13,
                     relleno_3, ct.sum15, ct.sum16,
                     ct.sum17, ct.sum18, ct.sum19,
                     ct.sum20, ct.sum21, ' '
                    );
     END LOOP;*/
   END doventascisa;
--
END Pq_Afip_Cisa;
/
CREATE OR REPLACE PACKAGE Pq_Controldiario
IS
-- PromoIns, obtiene el descuento a aplicar a un determinado cliente por una inspeccion normal
   FUNCTION promoins (atipocliente IN NUMBER,atipovehiculo IN NUMBER )
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (promoins, WNDS, WNPS, RNPS);

-- PromoReIns, obtiene el descuento a aplicar a un determinado cliente por una reinspecci¢n
   FUNCTION promoreins (atipocliente IN NUMBER)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (promoreins, WNDS, WNPS, RNPS);

-- Tarifa, obtiene la tarifa de una inspecci¢n sin el Iva
   FUNCTION tarifa
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (tarifa, WNDS, WNPS, RNPS);

-- TarifaxV, obtiene la tarifa (Sin Iva) para un tipo de veh¡culo pasado por par metro
   FUNCTION tarifaxv (atipovehiculo IN NUMBER)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (tarifaxv, WNDS, WNPS, RNPS);

-- TarifaxVxC_Ins, Obtiene en funci¢n de una tarifa por Vehiculo, y del tipo de cliente, el importe sin iva de una inspecci¢n
   FUNCTION tarifaxvxc_ins (atarifa IN NUMBER, atipocliente IN NUMBER,atipovehiculo IN NUMBER)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (tarifaxvxc_ins, WNDS, WNPS, RNPS);

-- TarifaxVxC_ReIns, Obtiene en funci¢n de una tarifa por Vehiculo, y del tipo de cliente, el importe sin iva de una Reinspecci¢n
   FUNCTION tarifaxvxc_reins (atarifa IN NUMBER, atipocliente IN NUMBER)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (tarifaxvxc_reins, WNDS, WNPS, RNPS);

-- NInspecciones, devuelve la cantidad de inspecciones finalizadas, pagadas, por tipo de vehiculo y por tipo de cliente, por fechas, por resultado y por tipo de Inspecci¢n
   FUNCTION ninspecciones (
      fi                IN   VARCHAR2,
      ff                IN   VARCHAR2,
      atipovehiculo     IN   NUMBER,
      atipocliente      IN   NUMBER,
      atipoinspeccion   IN   VARCHAR2,
      aresultado        IN   VARCHAR2
   )
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (ninspecciones, WNDS, WNPS, RNPS);

--    VentasxUsuario, devuelve la cantidad recaudada por tipo de usuario;
   FUNCTION ventasxusuario (atipousuario IN NUMBER)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (ventasxusuario, WNDS, WNPS, RNPS);

-- VentasSinUsuario, Devuelve el total recaudado, restando el recaudo de un determinado tipo de cliente;
   FUNCTION ventassinusuario (atipousuario IN NUMBER)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (ventassinusuario, WNDS, WNPS, RNPS);

-- InsPasadas, devuelve el n£mero de inspecciones con resultado apto o condicional
   FUNCTION inspasadas
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (inspasadas, WNDS, WNPS, RNPS);

-- InsNoPasadas, devuelve el n£mero de inspecciones rechazadas;
   FUNCTION insnopasadas
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (insnopasadas, WNDS, WNPS, RNPS);

-- InsTotales, devuelve el n£mero de inspecciones realizadas;
   FUNCTION instotales
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (instotales, WNDS, WNPS, RNPS);

-- VentasACredito, devuelve el importe sin iva de aqellos usuarios de cr¿dito y que adem s no son de un determinado tipo de las inspecciones
-- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion, que se han finalizado y facturado, no tiene en
-- cuenta las facturas abonadas
   FUNCTION ventasacredito (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (ventasacredito, WNDS, WNPS, RNPS);

--
--
    -- DifConvenioCredito, devuelve el importe sin iva de la dif entre el importe original
    -- GETIMPONETO(ejercici,codinspe) de una factura - el importe cobrado con descuento a credito,
    -- y que adem s no son de un determinado tipo de usuario, de las inspecciones
    -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion,
    -- que se han finalizado y facturado, no tiene en cuenta las facturas abonadas sin inspección
    --
   FUNCTION difconveniocredito (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (difconveniocredito, WNDS, WNPS, RNPS);

--
--
-- IVaVentasAContado, devuelve el iva de las ventas a contado, y que adem s no son de un determinado tipo, de las inspecciones
-- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion, que se han finalizado y facturado, no tiene en
-- cuenta las facturas abonadas
   FUNCTION ivaventasacontado (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (ivaventasacontado, WNDS, WNPS, RNPS);

-- Devuelve el numero de obleas dadas en inspecciones realizadas entre dos fechas, para aquellas
-- obleas con el formato AP-DDDDDD
   FUNCTION nobleas (
      fi          IN   VARCHAR2,
      ff          IN   VARCHAR2,
      ayear            VARCHAR2,
      aprovider        VARCHAR2
   )
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (nobleas, WNDS, WNPS, RNPS);

-- MinOblea, devuelve la menor oblea, con formato, emitida entre el intervalo de fechas, para el a¤o solicitado,
-- del provedor solicitado
   FUNCTION minoblea (
      fi          IN   VARCHAR2,
      ff          IN   VARCHAR2,
      ayear            VARCHAR2,
      aprovider        VARCHAR2
   )
      RETURN VARCHAR2;

   PRAGMA RESTRICT_REFERENCES (minoblea, WNDS, WNPS, RNPS);

-- MaxOblea, devuelve la mayor oblea, con formato, emitida entre el intervalo de fechas, para el a¤o solicitado,
-- del provedor solicitado
   FUNCTION maxoblea (
      fi          IN   VARCHAR2,
      ff          IN   VARCHAR2,
      ayear            VARCHAR2,
      aprovider        VARCHAR2
   )
      RETURN VARCHAR2;

   PRAGMA RESTRICT_REFERENCES (maxoblea, WNDS, WNPS, RNPS);

-- NObleaAnulada, devuelve la cant de obleas anuladas en el intervalo de fechas
   FUNCTION nobleaanulada (fi IN VARCHAR2, ff IN VARCHAR2)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (nobleaanulada, WNDS, WNPS, RNPS);

--
-- NObleaInutilizadas, devuelve la cant de obleas inutilizadas en el intervalo de fechas
   FUNCTION nobleainutilizadas (fi IN VARCHAR2, ff IN VARCHAR2)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (nobleainutilizadas, WNDS, WNPS, RNPS);

--
    -- DifNCxDescuento, devuelve el importe sin iva de las Notas de Crédito x descuento a contado,
    -- y que adem s no son de un determinado tipo de usuario, de las inspecciones
    -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion,
    -- que se han finalizado y facturado, no tiene en cuenta las facturas abonadas sin inspección
    --
   FUNCTION difncxdescuento (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (difncxdescuento, WNDS, WNPS, RNPS);

   --
   -- DifNCxDescuentoCredito, devuelve el importe sin iva de las Notas de Crédito x descuento a contado,
   -- y que adem s no son de un determinado tipo de usuario, de las inspecciones
   -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion,
   -- que se han finalizado y facturado, no tiene en cuenta las facturas abonadas sin inspección
   --
   FUNCTION difncxdescuentocredito (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (difncxdescuentocredito, WNDS, WNPS, RNPS);

   --
   -- DifxConvenio, devuelve el importe sin iva de la dif entre el importe original
   -- GETIMPONETO(ejercici,codinspe) de una factura - el importe cobrado con descuento a contado,
   -- y que adem s no son de un determinado tipo de usuario, de las inspecciones
   -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion,
   -- que se han finalizado y facturado, no tiene en cuenta las facturas abonadas sin inspección
   --
   FUNCTION difxconvenio (fi IN VARCHAR2, ff IN VARCHAR2, atipousuario NUMBER)
      RETURN NUMBER;

   PRAGMA RESTRICT_REFERENCES (difxconvenio, WNDS, WNPS, RNPS);

-- DoControlDiario, Realiza el control Diario
   PROCEDURE docontroldiario (fi IN VARCHAR2, ff IN VARCHAR2);
--nuevo forma de calcular la cantidad de  obleas por año
   PROCEDURE Doobleas (fi IN VARCHAR2, ff IN VARCHAR2);
END;
/
CREATE OR REPLACE PACKAGE BODY Pq_Controldiario
AS
-- Constantes
   t_normal                     CONSTANT VARCHAR2 (1) := 'A';
   t_preverificacion            CONSTANT VARCHAR2 (1) := 'B';
   t_gratuita                   CONSTANT VARCHAR2 (1) := 'C';
   t_voluntaria                 CONSTANT VARCHAR2 (1) := 'D';
   t_reverificacion             CONSTANT VARCHAR2 (1) := 'E';
   t_standby                    CONSTANT VARCHAR2 (1) := 'F';
   t_preverificacionok          CONSTANT VARCHAR2 (1) := 'G';
   t_mantenimiento              CONSTANT VARCHAR2 (1) := 'H';
   t_voluntariareverificacion   CONSTANT VARCHAR2 (1) := 'I';
   t_inspeccion_finalizada      CONSTANT VARCHAR2 (1) := 'S';
   inspeccion_apta              CONSTANT VARCHAR2 (1) := 'A';
   inspeccion_condicional       CONSTANT VARCHAR2 (1) := 'C';
   inspeccion_rechazado         CONSTANT VARCHAR2 (1) := 'R';
   inspeccion_baja              CONSTANT VARCHAR2 (1) := 'B';
   forma_pago_credito           CONSTANT VARCHAR2 (1) := 'C';
   forma_pago_metalico          CONSTANT VARCHAR2 (1) := 'M';
   forma_pago_cheques           CONSTANT VARCHAR2 (1) := 'H';
--
--  MODIFICACION TARJETAS DE CREDITO
--
   forma_pago_tarjeta           CONSTANT VARCHAR2 (1) := 'T';
--
   factura_tipo_a               CONSTANT VARCHAR2 (1) := 'A';
   factura_tipo_b               CONSTANT VARCHAR2 (1) := 'B';
--
-- PromoIns, obtiene el descuento a aplicar a un determinado cliente por una inspeccion normal
  --mal se agrega un parametro más a la funcion
   FUNCTION promoins (atipocliente IN NUMBER,atipovehiculo IN NUMBER)
      RETURN NUMBER
   IS
      apromoins   NUMBER;
   BEGIN
  --mla para tener en cuenta el descuento moto 50% y no 7,5
   IF atipovehiculo=1 AND atipocliente=10 THEN
    apromoins:=50;
   ELSE
      SELECT NVL (pornormal, 0)
        INTO apromoins
        FROM TTIPOSCLIENTE
       WHERE tipocliente_id = atipocliente;
END IF ;
      RETURN apromoins;
   END promoins;
--
-- PromoReIns, obtiene el descuento a aplicar a un determinado cliente por una reinspecci¢n
   FUNCTION promoreins (atipocliente IN NUMBER)
      RETURN NUMBER
   IS
      apromoreins   NUMBER;
   BEGIN
      SELECT NVL (porreverificacion, 0)
        INTO apromoreins
        FROM TTIPOSCLIENTE
       WHERE tipocliente_id = atipocliente;
      RETURN apromoreins;
   END promoreins;
--
-- Tarifa, obtiene la tarifa de una inspecci¢n sin el Iva
   FUNCTION tarifa
      RETURN NUMBER
   IS
      atarifa   NUMBER;
   BEGIN
      SELECT NVL (taribasi, 0)
        INTO atarifa
        FROM TVARIOS;
      RETURN atarifa;
   END tarifa;
--
-- TarifaxV, obtiene la tarifa (Sin Iva) para un tipo de veh¡culo pasado por par metro
   FUNCTION tarifaxv (atipovehiculo IN NUMBER)
      RETURN NUMBER
   IS
      atarifa     NUMBER;
      atarifaxv   NUMBER;
   BEGIN
      atarifa := tarifa;
      SELECT NVL (tarifave, 0) * atarifa * 0.01
        INTO atarifaxv
        FROM TTIPOVEHICU
       WHERE tipovehi = atipovehiculo;
      RETURN atarifaxv;
   END tarifaxv;
--
-- TarifaxVxC, Obtiene en funci¢n de una tarifa por Vehiculo, y del tipo de cliente, el importe sin iva de una inspecci¢n
   --mla se agrega un aprameto mas a la funcion atipovehiculo
FUNCTION tarifaxvxc_ins (atarifa IN NUMBER, atipocliente IN NUMBER,atipovehiculo IN NUMBER)
      RETURN NUMBER
   IS
   BEGIN
      RETURN atarifa - (atarifa * promoins (atipocliente,atipovehiculo) * 0.01);
   END tarifaxvxc_ins;
--
-- TarifaxVxC_ReIns, Obtiene en funci¢n de una tarifa por Vehiculo, y del tipo de cliente, el importe sin iva de una Reinspecci¢n
   FUNCTION tarifaxvxc_reins (atarifa IN NUMBER, atipocliente IN NUMBER)
      RETURN NUMBER
   IS
   BEGIN
      RETURN atarifa - (atarifa * promoreins (atipocliente) * 0.01);
   END tarifaxvxc_reins;
--
-- NInspecciones, devuelve la cantidad de inspecciones finalizadas, pagadas, por tipo de vehiculo y por tipo de cliente, por fechas, por resultado y por tipo de Inspecci¢n
   FUNCTION ninspecciones (
      fi                IN   VARCHAR2,
      ff                IN   VARCHAR2,
      atipovehiculo     IN   NUMBER,
      atipocliente      IN   NUMBER,
      atipoinspeccion   IN   VARCHAR2,
      aresultado        IN   VARCHAR2
   )
      RETURN NUMBER
   IS
      aninspecciones   NUMBER;
   BEGIN
      IF atipoinspeccion IN (t_normal)
      THEN
         SELECT COUNT (*)
           INTO aninspecciones
           FROM TINSPECCION i, TFACTURAS f, TVEHICULOS v
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND i.tipo IN (t_normal, t_voluntaria)
            AND i.inspfina = t_inspeccion_finalizada
            AND i.resultad = aresultado
            AND (NOT i.codfactu IS NULL)
            AND (f.codcofac IS NULL)
            AND f.tipocliente_id = atipocliente
            AND i.codfactu = f.codfactu
            AND v.codvehic = i.codvehic
            AND v.tipoespe IN (SELECT tipoespe
                                 FROM TTIPOESPVEH
                                WHERE tipovehi = atipovehiculo);
      ELSIF atipoinspeccion IN (t_reverificacion)
      THEN
         SELECT COUNT (*)
           INTO aninspecciones
           FROM TINSPECCION i, TFACTURAS f, TVEHICULOS v
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.tipo IN (t_reverificacion, t_voluntariareverificacion))
            AND (i.inspfina = t_inspeccion_finalizada)
            AND (i.resultad = aresultado)
            AND (NOT i.codfactu IS NULL)
            AND (f.codcofac IS NULL)
            AND (f.tipocliente_id = atipocliente)
            AND (i.codfactu = f.codfactu)
            AND (v.codvehic = i.codvehic)
            AND (v.tipoespe IN (SELECT tipoespe
                                  FROM TTIPOESPVEH
                                 WHERE tipovehi = atipovehiculo));
      ELSE
         aninspecciones := 0;
      END IF;
      RETURN aninspecciones;
   END ninspecciones;
--
    -- VentasxUsuario, devuelve la cantidad recaudada por tipo de usuario;
   FUNCTION ventasxusuario (atipousuario IN NUMBER)
      RETURN NUMBER
   IS
      aventasxusuario   NUMBER;
   BEGIN
      IF (atipousuario = 7)
      THEN
         SELECT SUM (NVL (tmonvr, 0))
           INTO aventasxusuario
           FROM vtmpcontroldiario
          WHERE tipocliente_id IN (7,13);
      ELSE
         SELECT SUM (NVL (tmonvr, 0))
           INTO aventasxusuario
           FROM vtmpcontroldiario
          WHERE tipocliente_id = atipousuario;
      END IF;
      RETURN aventasxusuario;
   END;
--
    --VentasSinUsuario, Devuelve el total recaudado, restando el recaudo de un determinado tipo de cliente;
   FUNCTION ventassinusuario (atipousuario IN NUMBER)
      RETURN NUMBER
   IS
      aventastotales   NUMBER;
   BEGIN
      SELECT SUM (NVL (tmonvr, 0))
        INTO aventastotales
        FROM vtmpcontroldiario;
      RETURN aventastotales - ventasxusuario (atipousuario);
   END;
--
-- InsPasadas, devuelve el n£mero de inspecciones con resultado apto o condicional
   FUNCTION inspasadas
      RETURN NUMBER
   IS
      ainspasadas   NUMBER;
   BEGIN
      SELECT SUM (naprv + nconv + naprr + nconr)
        INTO ainspasadas
        FROM TTMPCONTROLDIARIO;
      RETURN ainspasadas;
   END inspasadas;
--
-- InsNoPasadas, devuelve el n£mero de inspecciones rechazadas
   FUNCTION insnopasadas
      RETURN NUMBER
   IS
      ainsnopasadas   NUMBER;
   BEGIN
      SELECT SUM (nrecv + nrecr)
        INTO ainsnopasadas
        FROM TTMPCONTROLDIARIO;
      RETURN ainsnopasadas;
   END insnopasadas;
--
-- InsTotales, devuelve el n£mero de inspecciones realizadas
   FUNCTION instotales
      RETURN NUMBER
   IS
   BEGIN
      RETURN inspasadas + insnopasadas;
   END instotales;
--
-- VentasACredito, devuelve el importe sin iva de aqellos usuarios de cr¿dito y que adem s no son de un determinado tipo de las inspecciones
    -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion, que se han finalizado y facturado, no tiene en
    -- cuenta las facturas abonadas
-- MODIFICACION POR TARJETAS DE CREDITO
-- 10/08/2001
---------------
   FUNCTION ventasacredito (fi IN VARCHAR2, ff IN VARCHAR2, atipousuario NUMBER)
      RETURN NUMBER
   IS
      aventasacredito   NUMBER;
      aimporte          NUMBER;
      CURSOR cventascredtio (afi VARCHAR2, aff VARCHAR2, atipouser NUMBER)
      IS
         SELECT f.tipfactu, f.ivainscr, NVL (imponeto, 0) importe
           FROM TINSPECCION i, TFACTURAS f
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.tipo IN
                    (t_normal,
                     t_voluntaria,
                     t_reverificacion,
                     t_voluntariareverificacion
                    )
                )
            AND (i.inspfina = t_inspeccion_finalizada)
            AND (NOT i.codfactu IS NULL)
            AND (f.codcofac IS NULL)
            AND (f.tipocliente_id NOT IN(atipouser,13))
            AND (f.formpago IN (forma_pago_credito, forma_pago_tarjeta))
            AND (i.codfactu = f.codfactu);
--
   BEGIN
      aventasacredito := 0;
      FOR cf IN cventascredtio (fi, ff, atipousuario)
      LOOP
         IF cf.tipfactu = factura_tipo_a
         THEN
            aventasacredito := aventasacredito + cf.importe;
         ELSE
            aventasacredito :=
                  aventasacredito
                  + (cf.importe / (1 + (cf.ivainscr * 0.01)));
         END IF;
      END LOOP;
--
      RETURN aventasacredito;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END ventasacredito;
--
   FUNCTION difconveniocredito (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER
   IS
      adifconveniocredito   NUMBER;
      aimporte              NUMBER;
--
      CURSOR cventasconvenio (afi VARCHAR2, aff VARCHAR2, atipouser NUMBER)
      IS
         SELECT f.tipfactu, f.ivainscr, f.ivanoins, NVL (imponeto, 0)
                                                                     importe,
                ejercici, codinspe
           FROM TINSPECCION i, TFACTURAS f, TFACT_ADICION a
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.tipo IN
                    (t_normal,
                     t_voluntaria,
                     t_reverificacion,
                     t_voluntariareverificacion
                    )
                )
            AND (i.inspfina = t_inspeccion_finalizada)
            AND (NOT i.codfactu IS NULL)
            AND (f.tipocliente_id <> atipouser)
            AND (f.codcofac IS NULL)
            AND (f.formpago IN (forma_pago_credito, forma_pago_tarjeta))
            AND (i.codfactu = f.codfactu)
            AND (a.codfact = f.codfactu)
            AND (coddescu IN (SELECT coddescu
                                FROM TDESCUENTOS
                               WHERE emitenc = 'N'));
--
   BEGIN
      adifconveniocredito := 0;
      FOR cf IN cventasconvenio (fi, ff, atipousuario)
      LOOP
         aimporte := Getimporigin (cf.ejercici, cf.codinspe) - cf.importe;
         IF cf.tipfactu = factura_tipo_a
         THEN
            adifconveniocredito := adifconveniocredito + aimporte;
         ELSE
            adifconveniocredito :=
                adifconveniocredito
                + (aimporte / (1 + (cf.ivainscr * 0.01)));
         END IF;
      END LOOP;
--
      RETURN adifconveniocredito;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END difconveniocredito;
--
    -- IVaVentasAContado, devuelve el iva de las ventas a contado, y que adem s no son de un determinado tipo de usuario, de las inspecciones
    -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion, que se han finalizado y facturado, no tiene en
    -- cuenta las facturas abonadas
   FUNCTION ivaventasacontado (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER
   IS
      aivaventasacontado   NUMBER;
      CURSOR cventascredtio (afi VARCHAR2, aff VARCHAR2, atipouser NUMBER)
      IS
         SELECT f.tipfactu, f.ivainscr, f.ivanoins, NVL (imponeto, 0)
                                                                     importe
           FROM TINSPECCION i, TFACTURAS f
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.tipo IN
                    (t_normal,
                     t_voluntaria,
                     t_reverificacion,
                     t_voluntariareverificacion
                    )
                )
            AND (i.inspfina = t_inspeccion_finalizada)
            AND (NOT i.codfactu IS NULL)
            AND (f.tipocliente_id NOT IN (atipouser,13))
            AND (f.codcofac IS NULL)
            AND (f.formpago IN (forma_pago_metalico, forma_pago_cheques))
            AND (i.codfactu = f.codfactu);
--
      CURSOR cncxdescuento (afi VARCHAR2, aff VARCHAR2, atipouser NUMBER)
      IS
         SELECT f.tipfactu, f.ivainscr, f.ivanoins, NVL (imponeto, 0) importe
           FROM TINSPECCION i, TFACTURAS f, TFACT_ADICION a
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.tipo IN
                    (t_normal,
                     t_voluntaria,
                     t_reverificacion,
                     t_voluntariareverificacion
                    )
                )
            AND (i.inspfina = t_inspeccion_finalizada)
            AND (NOT i.codfactu IS NULL)
            AND (f.tipocliente_id NOT IN (atipouser,13))
            AND (f.codcofac IS NULL)
            AND (f.formpago IN (forma_pago_metalico, forma_pago_cheques))
            AND (i.codfactu = a.relcodfac)
            AND (f.codfactu = a.codfact)
            AND (a.tipofac = 'D')
            AND (a.relcodfac IS NOT NULL);
--
   BEGIN
      aivaventasacontado := 0;
      FOR cf IN cventascredtio (fi, ff, atipousuario)
      LOOP
         IF cf.tipfactu = factura_tipo_a
         THEN
            aivaventasacontado :=
                 aivaventasacontado
               + ((cf.importe * cf.ivainscr) / 100)
               + ((cf.importe * cf.ivanoins) / 100);
         ELSE
            aivaventasacontado :=
                 aivaventasacontado
               + (  ((cf.importe / (1 + (cf.ivainscr / 100))) * cf.ivainscr)
                  / 100
                 );
         END IF;
      END LOOP;
      FOR cf IN cncxdescuento (fi, ff, atipousuario)
      LOOP
         IF cf.tipfactu = factura_tipo_a
         THEN
            aivaventasacontado :=
                 aivaventasacontado
               - ((cf.importe * cf.ivainscr) / 100)
               + ((cf.importe * cf.ivanoins) / 100);
         ELSE
            aivaventasacontado :=
                 aivaventasacontado
               - (  ((cf.importe / (1 + (cf.ivainscr / 100))) * cf.ivainscr)
                  / 100
                 );
         END IF;
      END LOOP;
--
      RETURN aivaventasacontado;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END ivaventasacontado;
--
    -- NObleas, devuelve el numero de obleas dadas en inspecciones realizadas entre dos fechas, para aquellas
    -- obleas con el formato AP-DDDDDD
   FUNCTION nobleas (
      fi          IN   VARCHAR2,
      ff          IN   VARCHAR2,
      ayear            VARCHAR2,
      aprovider        VARCHAR2
   )
      RETURN NUMBER
   IS
      anobleas   NUMBER;
   BEGIN
      SELECT COUNT (*)
        INTO anobleas
        FROM TINSPECCION i
       WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
         AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
         AND (NOT numoblea IS NULL)
         AND (LENGTH (i.numoblea) >= 8)
         AND (SUBSTR (i.numoblea, 1, 1) = SUBSTR (ayear, 1, 1))
         AND (SUBSTR (i.numoblea, 2, 1) = SUBSTR (aprovider, 1, 1));
      RETURN anobleas;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;
--
    -- MinOblea, devuelve la menor oblea, con formato, emitida entre el intervalo de fechas, para el a¤o solicitado,
    -- del provedor solicitado
   FUNCTION minoblea (
      fi          IN   VARCHAR2,
      ff          IN   VARCHAR2,
      ayear            VARCHAR2,
      aprovider        VARCHAR2
   )
      RETURN VARCHAR2
   IS
      aminoblea   TINSPECCION.numoblea%TYPE;
   BEGIN
      SELECT LTRIM (MIN (i.numoblea))
        INTO aminoblea
        FROM TINSPECCION i
       WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
         AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
         AND (NOT numoblea IS NULL)
         AND (LENGTH (i.numoblea) >= 8)
         AND (SUBSTR (i.numoblea, 1, 1) = SUBSTR (ayear, 1, 1))
         AND (SUBSTR (i.numoblea, 2, 1) = SUBSTR (aprovider, 1, 1));
      IF LENGTH (aminoblea) = 8
      THEN
         aminoblea :=
              LTRIM (SUBSTR (aminoblea, 1, 2) || '-' || SUBSTR (aminoblea, 3));
      ELSE
         aminoblea :=
              LTRIM (SUBSTR (aminoblea, 1, 2) || '-' || SUBSTR (aminoblea, 4));
      END IF;
      RETURN aminoblea;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;
--
    -- MaxOblea, devuelve la mayor oblea, con formato, emitida entre el intervalo de fechas, para el a¤o solicitado,
    -- del provedor solicitado
   FUNCTION maxoblea (
      fi          IN   VARCHAR2,
      ff          IN   VARCHAR2,
      ayear            VARCHAR2,
      aprovider        VARCHAR2
   )
      RETURN VARCHAR2
   IS
      amaxoblea   TINSPECCION.numoblea%TYPE;
   BEGIN
      SELECT LTRIM (MAX (i.numoblea))
        INTO amaxoblea
        FROM TINSPECCION i
       WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
         AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
         AND (NOT numoblea IS NULL)
         AND (LENGTH (i.numoblea) >= 8)
         AND (SUBSTR (i.numoblea, 1, 1) = SUBSTR (ayear, 1, 1))
         AND (SUBSTR (i.numoblea, 2, 1) = SUBSTR (aprovider, 1, 1));
      IF LENGTH (amaxoblea) = 8
      THEN
         amaxoblea :=
              LTRIM (SUBSTR (amaxoblea, 1, 2) || '-' || SUBSTR (amaxoblea, 3));
      ELSE
         amaxoblea :=
              LTRIM (SUBSTR (amaxoblea, 1, 2) || '-' || SUBSTR (amaxoblea, 4));
      END IF;
      RETURN amaxoblea;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END maxoblea;
--  NObleaAnuladas Devuelve la cantidad de obleas anuladas entre 2 fechas
   FUNCTION nobleaanulada (fi IN VARCHAR2, ff IN VARCHAR2)
      RETURN NUMBER
   IS
      anobleas   NUMBER;
   BEGIN
      SELECT COUNT (*)
        INTO anobleas
        FROM T_ERVTV_ANULAC i
       WHERE (i.fecha >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
         AND (i.fecha <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'));
      RETURN anobleas;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;
--
--  NObleaInutilizadas Devuelve la cantidad de obleas inutilizadas entre 2 fechas
   FUNCTION nobleainutilizadas (fi IN VARCHAR2, ff IN VARCHAR2)
      RETURN NUMBER
   IS
      anobleas   NUMBER;
   BEGIN
      SELECT COUNT (*)
        INTO anobleas
        FROM T_ERVTV_INUTILIZ i
       WHERE (i.fecha >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
         AND (i.fecha <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'));
      RETURN anobleas;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;
--
--
--
    -- DifNCxDescuento, devuelve el importe sin iva de las Notas de Crédito x descuento a contado,
    -- y que adem s no son de un determinado tipo de usuario, de las inspecciones
    -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion,
    -- que se han finalizado y facturado, no tiene en cuenta las facturas abonadas sin inspección
    --
   FUNCTION difncxdescuento (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER
   IS
      adifncxdescuento   NUMBER;
      CURSOR cncxdescuento (afi VARCHAR2, aff VARCHAR2, atipouser NUMBER)
      IS
         SELECT f.tipfactu, f.ivainscr, f.ivanoins, NVL (imponeto, 0)
                                                                     importe
           FROM TINSPECCION i, TFACTURAS f, TFACT_ADICION a
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.tipo IN
                    (t_normal,
                     t_voluntaria,
                     t_reverificacion,
                     t_voluntariareverificacion
                    )
                )
            AND (i.inspfina = t_inspeccion_finalizada)
            AND (NOT i.codfactu IS NULL)
            AND (f.tipocliente_id <> atipouser)
            AND (f.codcofac IS NULL)
            AND (f.formpago IN (forma_pago_metalico, forma_pago_cheques))
            AND (i.codfactu = a.relcodfac)
            AND (f.codfactu = a.codfact)
            AND (a.tipofac = 'D')
            AND (a.relcodfac IS NOT NULL);
   BEGIN
      adifncxdescuento := 0;
      FOR cf IN cncxdescuento (fi, ff, atipousuario)
      LOOP
         IF cf.tipfactu = factura_tipo_a
         THEN
            adifncxdescuento := adifncxdescuento + cf.importe;
         ELSE
            adifncxdescuento :=
                 adifncxdescuento
                 + (cf.importe / (1 + (cf.ivainscr * 0.01)));
         END IF;
      END LOOP;
      RETURN adifncxdescuento;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END difncxdescuento;
--
    -- DifNCxDescuentoCredito, devuelve el importe sin iva de las Notas de Crédito x descuento a crédito,
    -- y que adem s no son de un determinado tipo de usuario, de las inspecciones
    -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion,
    -- que se han finalizado y facturado, no tiene en cuenta las facturas abonadas sin inspección
    --
   FUNCTION difncxdescuentocredito (
      fi             IN   VARCHAR2,
      ff             IN   VARCHAR2,
      atipousuario        NUMBER
   )
      RETURN NUMBER
   IS
      adifncxdescuentocredito   NUMBER;
      CURSOR cncxdescuento (afi VARCHAR2, aff VARCHAR2, atipouser NUMBER)
      IS
         SELECT f.tipfactu, f.ivainscr, f.ivanoins, NVL (imponeto, 0)
                                                                     importe
           FROM TINSPECCION i, TFACTURAS f, TFACT_ADICION a
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.tipo IN
                    (t_normal,
                     t_voluntaria,
                     t_reverificacion,
                     t_voluntariareverificacion
                    )
                )
            AND (i.inspfina = t_inspeccion_finalizada)
            AND (NOT i.codfactu IS NULL)
            AND (f.tipocliente_id NOT IN (atipouser,13))
            AND (f.codcofac IS NULL)
            AND (f.formpago IN (forma_pago_credito, forma_pago_tarjeta))
            AND (i.codfactu = a.relcodfac)
            AND (f.codfactu = a.codfact)
            AND (a.tipofac = 'D')
            AND (a.relcodfac IS NOT NULL);
   BEGIN
      adifncxdescuentocredito := 0;
      FOR cf IN cncxdescuento (fi, ff, atipousuario)
      LOOP
         IF cf.tipfactu = factura_tipo_a
         THEN
            adifncxdescuentocredito := adifncxdescuentocredito + cf.importe;
         ELSE
            adifncxdescuentocredito :=
                 adifncxdescuentocredito
               + (cf.importe / (1 + (cf.ivainscr * 0.01)));
         END IF;
      END LOOP;
      RETURN adifncxdescuentocredito;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END difncxdescuentocredito;
--
    -- DifxConvenio, devuelve el importe sin iva de la dif entre el importe original
    -- GETIMPONETO(ejercici,codinspe) de una factura - el importe cobrado con descuento a contado,
    -- y que adem s no son de un determinado tipo de usuario, de las inspecciones
    -- finalizadas y del tipo reverificaci¢n, verificaci¢n, voluntaria, y voluntaria reverificacion,
    -- que se han finalizado y facturado, no tiene en cuenta las facturas abonadas sin inspección
    --
   FUNCTION difxconvenio (fi IN VARCHAR2, ff IN VARCHAR2, atipousuario NUMBER)
      RETURN NUMBER
   IS
      adifxconvenio   NUMBER;
      aimporte        NUMBER;
      CURSOR cventasconvenio (afi VARCHAR2, aff VARCHAR2, atipouser NUMBER)
      IS
         SELECT f.tipfactu, f.ivainscr, f.ivanoins, NVL (imponeto, 0)
                                                                     importe,
                ejercici, codinspe
           FROM TINSPECCION i, TFACTURAS f, TFACT_ADICION a
          WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
            AND (i.tipo IN
                    (t_normal,
                     t_voluntaria,
                     t_reverificacion,
                     t_voluntariareverificacion
                    )
                )
            AND (i.inspfina = t_inspeccion_finalizada)
            AND (NOT i.codfactu IS NULL)
            AND (f.tipocliente_id <> atipouser)
            AND (f.codcofac IS NULL)
            AND (f.formpago IN (forma_pago_metalico, forma_pago_cheques))
            AND (i.codfactu = f.codfactu)
            AND (a.codfact = f.codfactu)
            AND (coddescu IN (SELECT coddescu
                                FROM TDESCUENTOS
                               WHERE emitenc = 'N'));
   BEGIN
      adifxconvenio := 0;
      FOR cf IN cventasconvenio (fi, ff, atipousuario)
      LOOP
         aimporte := Getimporigin (cf.ejercici, cf.codinspe) - cf.importe;
         IF cf.tipfactu = factura_tipo_a
         THEN
            adifxconvenio := adifxconvenio + aimporte;
         ELSE
            adifxconvenio :=
                      adifxconvenio
                      + (aimporte / (1 + (cf.ivainscr * 0.01)));
         END IF;
      END LOOP;
      RETURN adifxconvenio;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END difxconvenio;
--
    -- DoControlDiario, Realiza el control Diario por fechas
    -- DoControlDiario, Realiza el control Diario por fechas
   PROCEDURE docontroldiario (fi IN VARCHAR2, ff IN VARCHAR2)
   IS
      atarifaxv     NUMBER;
      diaryrecord   TTMPCONTROLDIARIO%ROWTYPE;

      CURSOR ctiposdevehiculos
      IS
         SELECT tipovehi
           FROM TTIPOVEHICU;

      CURSOR ctiposdeclientes
      IS
         SELECT tipocliente_id
           FROM TTIPOSCLIENTE
          WHERE vigente = 'S';
   BEGIN



      FOR ctv IN ctiposdevehiculos
      LOOP
         atarifaxv := tarifaxv (ctv.tipovehi);

         FOR ctc IN ctiposdeclientes
         LOOP
            diaryrecord.tipovehiculo_id := ctv.tipovehi;
            diaryrecord.tipocliente_id := ctc.tipocliente_id;
            diaryrecord.puv := tarifaxvxc_ins (atarifaxv, ctc.tipocliente_id,ctv.tipovehi);
            diaryrecord.naprv :=
               ninspecciones (fi,
                              ff,
                              ctv.tipovehi,
                              ctc.tipocliente_id,
                              t_normal,
                              inspeccion_apta
                             );
            diaryrecord.nconv :=
               ninspecciones (fi,
                              ff,
                              ctv.tipovehi,
                              ctc.tipocliente_id,
                              t_normal,
                              inspeccion_condicional
                             );
            diaryrecord.nrecv :=
                 ninspecciones (fi,
                                ff,
                                ctv.tipovehi,
                                ctc.tipocliente_id,
                                t_normal,
                                inspeccion_rechazado
                               )
               + ninspecciones (fi,
                                ff,
                                ctv.tipovehi,
                                ctc.tipocliente_id,
                                t_normal,
                                inspeccion_baja
                               );
            diaryrecord.pur :=
                              tarifaxvxc_reins (atarifaxv, ctc.tipocliente_id);
            diaryrecord.naprr :=
               ninspecciones (fi,
                              ff,
                              ctv.tipovehi,
                              ctc.tipocliente_id,
                              t_reverificacion,
                              inspeccion_apta
                             );
            diaryrecord.nconr :=
               ninspecciones (fi,
                              ff,
                              ctv.tipovehi,
                              ctc.tipocliente_id,
                              t_reverificacion,
                              inspeccion_condicional
                             );
            diaryrecord.nrecr :=
                 ninspecciones (fi,
                                ff,
                                ctv.tipovehi,
                                ctc.tipocliente_id,
                                t_reverificacion,
                                inspeccion_rechazado
                               )
               + ninspecciones (fi,
                                ff,
                                ctv.tipovehi,
                                ctc.tipocliente_id,
                                t_reverificacion,
                                inspeccion_baja
                               );

--
            INSERT INTO TTMPCONTROLDIARIO
                 VALUES (diaryrecord.tipovehiculo_id,
                         diaryrecord.tipocliente_id, diaryrecord.puv,
                         diaryrecord.naprv, diaryrecord.nconv,
                         diaryrecord.nrecv, diaryrecord.pur,
                         diaryrecord.naprr, diaryrecord.nconr,
                         diaryrecord.nrecr);
         END LOOP;
      END LOOP;
   EXCEPTION
      WHEN OTHERS
      THEN
         NULL;
   END;

PROCEDURE Doobleas (fi IN VARCHAR2, ff IN VARCHAR2)
   IS
   BEGIN
  INSERT INTO TTMPCDOBLEAS
   SELECT  'Oblea Año ' ||TO_CHAR(i.FECVENCI,'YYYY') ||' P ' ||SUBSTR (i.numoblea, 2, 1) ,LTRIM (MIN (i.numoblea)), LTRIM (MAX (i.numoblea)), COUNT(*)
        FROM TINSPECCION i, TFACTURAS f
       WHERE (i.fechalta >= TO_DATE (fi, 'DD/MM/YYYY HH24:MI:SS'))
         AND (i.fechalta <= TO_DATE (ff, 'DD/MM/YYYY HH24:MI:SS'))
         AND (NOT numoblea IS NULL)
		 AND (NOT numoblea IS NULL)
		 AND f.CODFACTU= i.CODFACTU AND f.CODCOFAC IS NULL
         AND (LENGTH (i.numoblea) >= 8)
		 GROUP BY   'Oblea Año ' ||TO_CHAR(i.FECVENCI,'YYYY') ||' P ' ||SUBSTR (i.numoblea, 2, 1) ;
END Doobleas;
END Pq_Controldiario;
/
COMMIT
/
SPOOL OFF
/
quit
/  