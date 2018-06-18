CREATE OR REPLACE PACKAGE Pq_Arqueo_Vtv
 AS
 --
 --
 PROCEDURE Doalltotalestarjeta
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2
  );
 --
 PROCEDURE Doarqueocajafxpago
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      FormPago IN VARCHAR2,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  );
 --
 PROCEDURE Doarqueocajaglobal
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  );
 --
  PROCEDURE Doarqueocajaxcajerofxpago
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      IdCajero IN NUMBER,
      FormPago IN VARCHAR2,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  );
 --
 PROCEDURE Doarqueocajaxcajeroglobal
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      IdCajero IN NUMBER,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  );
 --
 PROCEDURE  Doarqueocajaxdescuento
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      aDescuento IN NUMBER,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  );
  --
  PROCEDURE Doarqueocajaxtipocliente
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      aTipoCliente IN NUMBER,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  );
  --
  PROCEDURE Dolistadocheques
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      NumCheques IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  );
 --
 PROCEDURE Dototalescajacontado
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER,
      TotalGlobal IN OUT NUMBER
  );
 --
 PROCEDURE Dototalestarjeta
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      CodigoTarjeta IN NUMBER
  );
 --
 PROCEDURE DoalltotalestarjetaxCajero
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      IdCajero IN NUMBER
  );
 PROCEDURE Dototalestarjetaxcajero
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      CodigoTarjeta IN NUMBER,
      IdCajero IN NUMBER
  );
 END;
/
CREATE OR REPLACE PACKAGE BODY Pq_Arqueo_Vtv
 AS
 --
 --
 PROCEDURE Doalltotalestarjeta
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2
  )
    IS
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de tarjetas
      --
      CURSOR C_TARJETAS  IS
        SELECT CODTARJET, NOMTARJET
        FROM TTARJETAS;
      --
    BEGIN
       --
       -- Se inicia el recorrido de la tabla TTARJETAS
       --
       FOR C_TARJETAS_REC IN C_TARJETAS LOOP
         --
         Dototalestarjeta(FechaIni,FechaFin,C_TARJETAS_REC.CODTARJET);
     --
       END LOOP;
    END Doalltotalestarjeta;
 --
PROCEDURE Doarqueocajafxpago
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      FormPago IN VARCHAR2,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  )
    IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2, FP IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, CODDESCU, IDUSUARI, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = FP)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2, FP IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, CODDESCU, IDUSUARI, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (FORMPAGO = FP)
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
            AND (A.CODFACT=F.CODFACTU)
            AND (A.TIPOFAC='F')
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2, FP IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, RELCODFAC, CODDESCU, IDUSUARI, IIBB
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
      AND RELCODFAC IS NOT NULL
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);             -- Descripción del Descuento
       NombreCajero VARCHAR2(32);         -- Nombre Cajero
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
       TarPago VARCHAR2(20);             -- Para almacenar la forma de Pago o la tarjeta
       CodTarjeta NUMBER(8);
    BEGIN
       NumFacturas := 0;
       NumContrafacturas := 0;
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se obtienen el codigo de zona y estacion
       --
       SELECT TO_CHAR(ZONA,'0000'), TO_CHAR(ESTACION,'0000') INTO Zona, Estacion
         FROM TVARIOS;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin, FormPago) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_FACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='F';
     aFecha:=TO_CHAR(C_FACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_FACTURAS_REC.NUMFACTU,'00000000'));
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_FACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_FACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_FACTURAS_REC.TIPOCLIENTE_ID);
     --
     IF C_FACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_FACTURAS_REC.CODDESCU);
     ELSE
         Concepto := ' ';
     END IF;
     --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
         ImporteNet   := 0.0;
         ImporteNeto  := 0.0;
     aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;            -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
         --
     --
     -- Busco el nombre del cajero
     --
     SELECT NOMBRE INTO NombreCajero FROM TUSUARIO
     WHERE IDUSUARIO=C_FACTURAS_REC.IDUSUARI;
         --
     IF FormPago = 'T'
     THEN
         SELECT CODTARJET INTO CodTarjeta FROM TFACT_ADICION
         WHERE CODFACT=C_FACTURAS_REC.CODFACTU
         AND TIPOFAC='F';
         SELECT ABREVIA INTO TarPago FROM TTARJETAS
         WHERE CODTARJET= CodTarjeta;
     ELSE
          SELECT DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente')
         INTO TarPago FROM DUAL;
     END IF;
         --
     --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENCAJ
            VALUES ( C_FACTURAS_REC.FECHALTA, C_FACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
--                     DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
             TarPago,
                     TipoCliente, NombreCompleto, ImporteNeto,
                     AIva, AIvaNo, ImporteTotal, Concepto,C_FACTURAS_REC.IDUSUARI,NombreCajero, aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
         NumFacturas := NumFacturas + 1;
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
                --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
            aTipo:='N';
            aFecha:= TO_CHAR(aDate,'DD/MM/YYYY HH24::MI::SS');
                PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
                    NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(NumeroContrafactura,'00000000'));
                    --
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
            --
            -- Busco el nombre del cajero
             --
            SELECT NOMBRE INTO NombreCajero FROM TUSUARIO
            WHERE IDUSUARIO=C_FACTURAS_REC.IDUSUARI;
                 --
                    --
                    -- Se inserta TTMPARQCAJA en tupla
                    --
         IF FormPago = 'T'
         THEN
            SELECT CODTARJET INTO CodTarjeta FROM TFACT_ADICION
            WHERE CODFACT = C_FACTURAS_REC.CODCOFAC
            AND TIPOFAC='N';
                SELECT ABREVIA INTO TarPago FROM TTARJETAS
                WHERE CODTARJET= CodTarjeta;
         ELSE
            SELECT DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente')
            INTO TarPago FROM DUAL;
         END IF;
             --
                    INSERT INTO TTMPARQCAJAEXTENCAJ
                       VALUES ( FechaContraFactura, C_FACTURAS_REC.TIPFACTU, NumeroFactura,
                                PtoVenta, NumeroInforme, Dominio,
--                                DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
                TarPago,
                                TipoCliente, NombreCompleto, -ImporteNeto,
                                -AIva, -AIvaNo, -ImporteTotal, Concepto,C_FACTURAS_REC.IDUSUARI,NombreCajero,-aIIBB);
                    --
                    -- Se incrementa el contador de contrafacturas
                    --
                    NumContrafacturas := NumContraFacturas + 1;
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin, FormPago) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_CONTRAFACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='N';
     aFecha:=TO_CHAR(C_CONTRAFACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_CONTRAFACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_CONTRAFACTURAS_REC.NUMFACTU,'00000000'));
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_CONTRAFACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_CONTRAFACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         --
     IF C_CONTRAFACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_CONTRAFACTURAS_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
     --
         TipoCliente := Tipodelcliente(C_CONTRAFACTURAS_REC.TIPOCLIENTE_ID);
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
     ImporteNeto  := 0.0;
     ImporteNet   := 0.0;
     aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
     --
     -- Busco el nombre del cajero
     --
     SELECT NOMBRE INTO NombreCajero FROM TUSUARIO
     WHERE IDUSUARIO=C_CONTRAFACTURAS_REC.IDUSUARI;
         --
         --
     --
         IF FormPago = 'T'
         THEN
                 SELECT CODTARJET INTO CodTarjeta FROM TFACT_ADICION
             WHERE CODFACT = C_CONTRAFACTURAS_REC.CODFACTU
             AND TIPOFAC='N';
             --
                 SELECT ABREVIA INTO TarPago FROM TTARJETAS
                 WHERE CODTARJET= CodTarjeta;
             --
         ELSE
            SELECT DECODE(C_CONTRAFACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente')
            INTO TarPago FROM DUAL;
         END IF;
     --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENCAJ
            VALUES ( C_CONTRAFACTURAS_REC.FECHALTA,C_CONTRAFACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
--                     DECODE(C_CONTRAFACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
             TarPago,
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal, Concepto,C_CONTRAFACTURAS_REC.IDUSUARI,NombreCajero,-aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
           NumContraFacturas := NumContraFacturas + 1;
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin, FormPago) LOOP
     aTipo:='D';
     aFecha:=TO_CHAR(C_NCXDESCUENTO_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_NCXDESCUENTO_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_NCXDESCUENTO_REC.NUMFACTU,'00000000'));
-----------
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_NCXDESCUENTO_REC.RELCODFAC);
         --
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_NCXDESCUENTO_REC.RELCODFAC AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_NCXDESCUENTO_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         --
     IF C_NCXDESCUENTO_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_NCXDESCUENTO_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
     --
         TipoCliente := Tipodelcliente(C_NCXDESCUENTO_REC.TIPOCLIENTE_ID);
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
     --
     -- Busco el nombre del cajero
     --
     SELECT NOMBRE INTO NombreCajero FROM TUSUARIO
     WHERE IDUSUARIO=C_NCXDESCUENTO_REC.IDUSUARI;
         --
         --
         IF FormPago = 'T'
         THEN
                 SELECT CODTARJET INTO CodTarjeta FROM TFACT_ADICION
             WHERE CODFACT = C_NCXDESCUENTO_REC.CODFACTU
             AND TIPOFAC='N';
             --
                 SELECT ABREVIA INTO TarPago FROM TTARJETAS
                 WHERE CODTARJET= CodTarjeta;
             --
         ELSE
            SELECT DECODE(C_NCXDESCUENTO_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente')
            INTO TarPago FROM DUAL;
         END IF;
     --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENCAJ
            VALUES ( C_NCXDESCUENTO_REC.FECHALTA, C_NCXDESCUENTO_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
--                     DECODE(C_NCXDESCUENTO_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
             TarPago,
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,C_NCXDESCUENTO_REC.IDUSUARI,NombreCajero,-aIIBB);
         --
         -- Incremento en uno el numero de NOTAS DE CREDITO;
         --
         NumContrafacturas := NumContraFacturas + 1;
         --
       END LOOP;
       --
       -- Total en Caja
         TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja + IIBBEnCaja;
    END Doarqueocajafxpago;
---
PROCEDURE Doarqueocajaglobal
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  )
    IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, CODDESCU, IDUSUARI, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, CODDESCU, IDUSUARI, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
            AND (A.CODFACT=F.CODFACTU)
            AND (A.TIPOFAC='F')
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
      --
      -- Cursor que recorre toda la tabla de facturas para levantar las nc x descuento
      --
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, RELCODFAC, CODDESCU, IDUSUARI, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'D')
      AND RELCODFAC IS NOT NULL
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
--------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);             -- Descripción del Descuento
       NombreCajero VARCHAR2(32);         -- Nombre Cajero
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
    BEGIN
       NumFacturas := 0;
       NumContrafacturas := 0;
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se obtienen el codigo de zona y estacion
       --
       SELECT TO_CHAR(ZONA,'0000'), TO_CHAR(ESTACION,'0000') INTO Zona, Estacion
         FROM TVARIOS;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_FACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='F';
     aFecha:=TO_CHAR(C_FACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_FACTURAS_REC.NUMFACTU,'00000000'));
-----------
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_FACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_FACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_FACTURAS_REC.TIPOCLIENTE_ID);
         --
     IF C_FACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_FACTURAS_REC.CODDESCU);
     ELSE
         Concepto := ' ';
     END IF;
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
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;        -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
     --
     -- Busco el nombre del cajero
     --
     SELECT NOMBRE INTO NombreCajero FROM TUSUARIO
     WHERE IDUSUARIO=C_FACTURAS_REC.IDUSUARI;
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENCAJ
            VALUES ( C_FACTURAS_REC.FECHALTA, C_FACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                     TipoCliente, NombreCompleto, ImporteNeto,
                     AIva, AIvaNo, ImporteTotal,Concepto,C_FACTURAS_REC.IDUSUARI,NombreCajero,aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
         NumFacturas := NumFacturas + 1;
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
               --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
            aTipo:='N';
                    aFecha:= TO_CHAR(aDate,'DD/MM/YYYY HH24::MI::SS');
                PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
                    NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(NumeroContrafactura,'00000000'));
                    --
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
                    --
            --
            -- Busco el nombre del cajero
             --
            SELECT NOMBRE INTO NombreCajero FROM TUSUARIO
            WHERE IDUSUARIO=C_FACTURAS_REC.IDUSUARI;
                 --
                    -- Se inserta TTMPARQCAJA en tupla
                   --
                   INSERT INTO TTMPARQCAJAEXTENCAJ
                       VALUES ( FechaContraFactura, C_FACTURAS_REC.TIPFACTU, NumeroFactura,
                                PtoVenta, NumeroInforme, Dominio,
                                DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                                TipoCliente, NombreCompleto, -ImporteNeto,
                               -AIva, -AIvaNo, -ImporteTotal,Concepto,C_FACTURAS_REC.IDUSUARI,NombreCajero,-aIIBB);
                    --
                    -- Se incrementa el contador de contrafacturas
                    --
                    NumContrafacturas := NumContraFacturas + 1;
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_CONTRAFACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='N';
     aFecha:=TO_CHAR(C_CONTRAFACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_CONTRAFACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_CONTRAFACTURAS_REC.NUMFACTU,'00000000'));
-----------
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_CONTRAFACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_CONTRAFACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_CONTRAFACTURAS_REC.TIPOCLIENTE_ID);
         --
     IF C_CONTRAFACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_CONTRAFACTURAS_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
     --
     -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
     ImporteNeto  := 0.0;
     ImporteNet   := 0.0;
     aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
     --
     -- Busco el nombre del cajero
     --
     SELECT NOMBRE INTO NombreCajero FROM TUSUARIO
     WHERE IDUSUARIO=C_CONTRAFACTURAS_REC.IDUSUARI;
         --
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENCAJ
            VALUES ( C_CONTRAFACTURAS_REC.FECHALTA,C_CONTRAFACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_CONTRAFACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,C_CONTRAFACTURAS_REC.IDUSUARI,NombreCajero,-aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
           NumContraFacturas := NumContraFacturas + 1;
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
     aTipo:='D';
     aFecha:=TO_CHAR(C_NCXDESCUENTO_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_NCXDESCUENTO_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_NCXDESCUENTO_REC.NUMFACTU,'00000000'));
-----------
         --
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_NCXDESCUENTO_REC.RELCODFAC);
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_NCXDESCUENTO_REC.RELCODFAC AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_NCXDESCUENTO_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_NCXDESCUENTO_REC.TIPOCLIENTE_ID);
         --
     IF C_NCXDESCUENTO_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_NCXDESCUENTO_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
     --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
     --
     -- Busco el nombre del cajero
     --
     SELECT NOMBRE INTO NombreCajero FROM TUSUARIO
     WHERE IDUSUARIO=C_NCXDESCUENTO_REC.IDUSUARI;
         --
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENCAJ
            VALUES ( C_NCXDESCUENTO_REC.FECHALTA, C_NCXDESCUENTO_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_NCXDESCUENTO_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,C_NCXDESCUENTO_REC.IDUSUARI,NombreCajero,-aIIBB);
         --
         -- Incremento en uno el numero de NOTAS DE CREDITO;
         --
         NumContrafacturas := NumContraFacturas + 1;
         --
       END LOOP;
       --
         -- Total en Caja
       TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja + IIBBEnCaja;
    END Doarqueocajaglobal;
    --
     PROCEDURE Doarqueocajaxcajerofxpago
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      IdCajero IN NUMBER,
      FormPago IN VARCHAR2,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  )
    IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2, FP IN VARCHAR2) IS
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
      AND (A.TIPOFAC = 'F')
      AND (A.IDUSUARI = IdCajero)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2, FP IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, A.CODDESCU, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (FORMPAGO = FP)
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
            AND (A.CODFACT=F.CODFACTU)
            AND (A.TIPOFAC='F')
                    AND (A.IDUSUARI = IdCajero)
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2, FP IN VARCHAR2) IS
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
      AND RELCODFAC IS NOT NULL
      AND (A.IDUSUARI = IdCajero)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);             -- Descripción del Descuento
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
       TarPago VARCHAR2(20);             -- Para almacenar la forma de Pago o la tarjeta
       CodTarjeta NUMBER(8);
    BEGIN
       NumFacturas := 0;
       NumContrafacturas := 0;
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se obtienen el codigo de zona y estacion
       --
       SELECT TO_CHAR(ZONA,'0000'), TO_CHAR(ESTACION,'0000') INTO Zona, Estacion
         FROM TVARIOS;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin, FormPago) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_FACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='F';
     aFecha:=TO_CHAR(C_FACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_FACTURAS_REC.NUMFACTU,'00000000'));
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_FACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_FACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_FACTURAS_REC.TIPOCLIENTE_ID);
         --
     IF C_FACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_FACTURAS_REC.CODDESCU);
     ELSE
         Concepto := ' ';
     END IF;
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
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;            -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         --
     IF FormPago = 'T'
     THEN
         SELECT CODTARJET INTO CodTarjeta FROM TFACT_ADICION
         WHERE CODFACT=C_FACTURAS_REC.CODFACTU
         AND TIPOFAC='F';
         SELECT ABREVIA INTO TarPago FROM TTARJETAS
         WHERE CODTARJET= CodTarjeta;
     ELSE
          SELECT DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente')
         INTO TarPago FROM DUAL;
     END IF;
         --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_FACTURAS_REC.FECHALTA, C_FACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
--                     DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
             TarPago,
                     TipoCliente, NombreCompleto, ImporteNeto,
                     AIva, AIvaNo, ImporteTotal,Concepto, aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
         NumFacturas := NumFacturas + 1;
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
                --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
            aTipo:='N';
            aFecha:= TO_CHAR(aDate,'DD/MM/YYYY HH24::MI::SS');
                PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
                    NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(NumeroContrafactura,'00000000'));
                    --
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
                    --
                    -- Se inserta TTMPARQCAJA en tupla
                    --
                    --
         IF FormPago = 'T'
         THEN
            SELECT CODTARJET INTO CodTarjeta FROM TFACT_ADICION
            WHERE CODFACT = C_FACTURAS_REC.CODCOFAC
            AND TIPOFAC='N';
                SELECT ABREVIA INTO TarPago FROM TTARJETAS
                WHERE CODTARJET= CodTarjeta;
         ELSE
            SELECT DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente')
            INTO TarPago FROM DUAL;
         END IF;
             --
                    INSERT INTO TTMPARQCAJAEXTEN
                       VALUES ( FechaContraFactura, C_FACTURAS_REC.TIPFACTU, NumeroFactura,
                                PtoVenta, NumeroInforme, Dominio,
--                                DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
                TarPago,
                                TipoCliente, NombreCompleto, -ImporteNeto,
                                -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
                    --
                    -- Se incrementa el contador de contrafacturas
                    --
                    NumContrafacturas := NumContraFacturas + 1;
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin, FormPago) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_CONTRAFACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='N';
     aFecha:=TO_CHAR(C_CONTRAFACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_CONTRAFACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_CONTRAFACTURAS_REC.NUMFACTU,'00000000'));
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_CONTRAFACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_CONTRAFACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_CONTRAFACTURAS_REC.TIPOCLIENTE_ID);
         --
     IF C_CONTRAFACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_CONTRAFACTURAS_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
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
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
     --
         IF FormPago = 'T'
         THEN
                 SELECT CODTARJET INTO CodTarjeta FROM TFACT_ADICION
             WHERE CODFACT = C_CONTRAFACTURAS_REC.CODFACTU
             AND TIPOFAC='N';
             --
                 SELECT ABREVIA INTO TarPago FROM TTARJETAS
                 WHERE CODTARJET= CodTarjeta;
             --
         ELSE
            SELECT DECODE(C_CONTRAFACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente')
            INTO TarPago FROM DUAL;
         END IF;
     --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_CONTRAFACTURAS_REC.FECHALTA,C_CONTRAFACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
--                     DECODE(C_CONTRAFACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
             TarPago,
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
           NumContraFacturas := NumContraFacturas + 1;
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin, FormPago) LOOP
     aTipo:='D';
     aFecha:=TO_CHAR(C_NCXDESCUENTO_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_NCXDESCUENTO_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_NCXDESCUENTO_REC.NUMFACTU,'00000000'));
-----------
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_NCXDESCUENTO_REC.RELCODFAC);
         --
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_NCXDESCUENTO_REC.RELCODFAC AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_NCXDESCUENTO_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
     IF C_NCXDESCUENTO_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_NCXDESCUENTO_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
     --
         --
         TipoCliente := Tipodelcliente(C_NCXDESCUENTO_REC.TIPOCLIENTE_ID);
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         --
         IF FormPago = 'T'
         THEN
                 SELECT CODTARJET INTO CodTarjeta FROM TFACT_ADICION
             WHERE CODFACT = C_NCXDESCUENTO_REC.CODFACTU
             AND TIPOFAC='N';
             --
                 SELECT ABREVIA INTO TarPago FROM TTARJETAS
                 WHERE CODTARJET= CodTarjeta;
             --
         ELSE
            SELECT DECODE(C_NCXDESCUENTO_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente')
            INTO TarPago FROM DUAL;
         END IF;
     --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_NCXDESCUENTO_REC.FECHALTA, C_NCXDESCUENTO_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
--                     DECODE(C_NCXDESCUENTO_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
             TarPago,
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
         --
         -- Incremento en uno el numero de NOTAS DE CREDITO;
         --
         NumContrafacturas := NumContraFacturas + 1;
         --
       END LOOP;
       --
       -- Total en Caja
         TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja + IIBBEnCaja;
    END Doarqueocajaxcajerofxpago;
    --
     PROCEDURE Doarqueocajaxcajeroglobal
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      IdCajero IN NUMBER,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  )
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
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
      AND (A.IDUSUARI = IdCajero)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, CODDESCU, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
            AND (A.CODFACT=F.CODFACTU)
            AND (A.TIPOFAC='F')
                AND (A.IDUSUARI = IdCajero)
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
      --
      -- Cursor que recorre toda la tabla de facturas para levantar las nc x descuento
      --
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
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
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'D')
      AND RELCODFAC IS NOT NULL
      AND (A.IDUSUARI = IdCajero)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
--------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);             -- Descripción del Descuento
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
    BEGIN
       NumFacturas := 0;
       NumContrafacturas := 0;
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se obtienen el codigo de zona y estacion
       --
       SELECT TO_CHAR(ZONA,'0000'), TO_CHAR(ESTACION,'0000') INTO Zona, Estacion
         FROM TVARIOS;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_FACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='F';
     aFecha:=TO_CHAR(C_FACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_FACTURAS_REC.NUMFACTU,'00000000'));
-----------
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_FACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_FACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_FACTURAS_REC.TIPOCLIENTE_ID);
         --
     IF C_FACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_FACTURAS_REC.CODDESCU);
     ELSE
         Concepto := ' ';
     END IF;
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
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;        -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo;
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_FACTURAS_REC.FECHALTA, C_FACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                     TipoCliente, NombreCompleto, ImporteNeto,
                     AIva, AIvaNo, ImporteTotal,Concepto,aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
         NumFacturas := NumFacturas + 1;
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
               --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
            aTipo:='N';
                    aFecha:= TO_CHAR(aDate,'DD/MM/YYYY HH24::MI::SS');
                PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
                    NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(NumeroContrafactura,'00000000'));
                    --
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
                    --
                    -- Se inserta TTMPARQCAJA en tupla
                   --
                   INSERT INTO TTMPARQCAJAEXTEN
                       VALUES ( FechaContraFactura, C_FACTURAS_REC.TIPFACTU, NumeroFactura,
                                PtoVenta, NumeroInforme, Dominio,
                                DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                                TipoCliente, NombreCompleto, -ImporteNeto,
                               -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
                    --
                    -- Se incrementa el contador de contrafacturas
                    --
                    NumContrafacturas := NumContraFacturas + 1;
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_CONTRAFACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='N';
     aFecha:=TO_CHAR(C_CONTRAFACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_CONTRAFACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_CONTRAFACTURAS_REC.NUMFACTU,'00000000'));
-----------
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_CONTRAFACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_CONTRAFACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_CONTRAFACTURAS_REC.TIPOCLIENTE_ID);
         --
     IF C_CONTRAFACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_CONTRAFACTURAS_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
     --
     -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
     ImporteNeto  := 0.0;
     ImporteNet   := 0.0;
     aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_CONTRAFACTURAS_REC.FECHALTA,C_CONTRAFACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_CONTRAFACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
           NumContraFacturas := NumContraFacturas + 1;
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
     aTipo:='D';
     aFecha:=TO_CHAR(C_NCXDESCUENTO_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_NCXDESCUENTO_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_NCXDESCUENTO_REC.NUMFACTU,'00000000'));
-----------
         --
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_NCXDESCUENTO_REC.RELCODFAC);
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_NCXDESCUENTO_REC.RELCODFAC AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_NCXDESCUENTO_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_NCXDESCUENTO_REC.TIPOCLIENTE_ID);
         --
     IF C_NCXDESCUENTO_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_NCXDESCUENTO_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
     --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_NCXDESCUENTO_REC.FECHALTA, C_NCXDESCUENTO_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_NCXDESCUENTO_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
         --
         -- Incremento en uno el numero de NOTAS DE CREDITO;
         --
         NumContrafacturas := NumContraFacturas + 1;
         --
       END LOOP;
       --
         -- Total en Caja
       TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja + IIBBEnCaja;
    END Doarqueocajaxcajeroglobal;
--
 PROCEDURE  Doarqueocajaxdescuento
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      aDescuento IN NUMBER,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  )
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
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (CODDESCU = aDescuento)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, A.CODDESCU, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
            AND F.CODFACTU=A.CODFACT
            AND A.TIPOFAC='F'
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (CODDESCU = aDescuento)
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
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
          AND (CODDESCU = aDescuento)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'D')
      AND RELCODFAC IS NOT NULL
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);             -- Descripción del Descuento
       NroCupon VARCHAR2(30);             -- Nro de Cupón (si corresponde) del descuento
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
--
    BEGIN
       NumFacturas := 0;
       NumContrafacturas := 0;
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se obtienen el codigo de zona y estacion
       --
       SELECT TO_CHAR(ZONA,'0000'), TO_CHAR(ESTACION,'0000') INTO Zona, Estacion
         FROM TVARIOS;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_FACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='F';
     aFecha:=TO_CHAR(C_FACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_FACTURAS_REC.NUMFACTU,'00000000'));
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_FACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_FACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_FACTURAS_REC.TIPOCLIENTE_ID);
         --
     Concepto := Conceptodescuento(C_FACTURAS_REC.CODDESCU);
     NroCupon := Cupondescuento(C_FACTURAS_REC.CODDESCU,C_FACTURAS_REC.CODFACTU);
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
             ImporteNeto := ROUND (ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;        -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENDESC
            VALUES ( C_FACTURAS_REC.FECHALTA, C_FACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
                     TipoCliente, NombreCompleto, ImporteNeto,
                     AIva, AIvaNo, ImporteTotal,
             Concepto, NroCupon,aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
         NumFacturas := NumFacturas + 1;
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
                --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
            aTipo:='N';
            aFecha:= TO_CHAR(aDate,'DD/MM/YYYY HH24::MI::SS');
                PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
                    NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(NumeroContrafactura,'00000000'));
                    --
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
                    --
                    -- Se inserta TTMPARQCAJA en tupla
                    --
                    INSERT INTO TTMPARQCAJAEXTENDESC
                       VALUES ( FechaContraFactura, C_FACTURAS_REC.TIPFACTU, NumeroFactura,
                                PtoVenta, NumeroInforme, Dominio,
                                DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
                                TipoCliente, NombreCompleto, -ImporteNeto,
                                -AIva, -AIvaNo, -ImporteTotal,
                        Concepto, NroCupon,-aIIBB);
                    --
                    -- Se incrementa el contador de contrafacturas
                    --
                    NumContrafacturas := NumContraFacturas + 1;
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_CONTRAFACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='N';
     aFecha:=TO_CHAR(C_CONTRAFACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_CONTRAFACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_CONTRAFACTURAS_REC.NUMFACTU,'00000000'));
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_CONTRAFACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_CONTRAFACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_CONTRAFACTURAS_REC.TIPOCLIENTE_ID);
         --
         --
     Concepto := Conceptodescuento(C_CONTRAFACTURAS_REC.CODFACTU);
     NroCupon := Cupondescuento(C_CONTRAFACTURAS_REC.CODDESCU,C_CONTRAFACTURAS_REC.CODFACTU);
     --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
     ImporteNet   := 0.0;
     ImporteNeto  := 0.0;
         ImporteTotal := 0.0;
     aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
         ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
             ImporteNeto := ROUND (ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENDESC
            VALUES ( C_CONTRAFACTURAS_REC.FECHALTA,C_CONTRAFACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_CONTRAFACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,
             Concepto, NroCupon,-aIIBB);
         --
         -- Incremento en uno el numero de NC;
         --
           NumContraFacturas := NumContraFacturas + 1;
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
     aTipo:='D';
     aFecha:=TO_CHAR(C_NCXDESCUENTO_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_NCXDESCUENTO_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_NCXDESCUENTO_REC.NUMFACTU,'00000000'));
-----------
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_NCXDESCUENTO_REC.RELCODFAC);
         --
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_NCXDESCUENTO_REC.RELCODFAC AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_NCXDESCUENTO_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_NCXDESCUENTO_REC.TIPOCLIENTE_ID);
         --
         --
     Concepto := Conceptodescuento(C_NCXDESCUENTO_REC.CODDESCU);
     NroCupon := ' ';
     --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
         ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
             ImporteNeto := ROUND (ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTENDESC
            VALUES ( C_NCXDESCUENTO_REC.FECHALTA, C_NCXDESCUENTO_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_NCXDESCUENTO_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,
             Concepto, NroCupon,-aIIBB);
         --
         -- Incremento en uno el numero de NOTAS DE CREDITO;
         --
         NumContrafacturas := NumContraFacturas + 1;
         --
       END LOOP;
       --
       -- Total en Caja
       TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja + IIBBEnCaja;
    END Doarqueocajaxdescuento;
--
 PROCEDURE Doarqueocajaxtipocliente
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      aTipoCliente IN NUMBER,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  )
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
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (TIPOCLIENTE_ID=aTipoCliente)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, A.CODDESCU, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (TIPOCLIENTE_ID=aTipoCliente)
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
            AND (A.CODFACT=F.CODFACTU)
            AND (A.TIPOFAC='F')
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
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
          AND (TIPOCLIENTE_ID=aTipoCliente)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'D')
      AND RELCODFAC IS NOT NULL
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);             -- Descripción del Descuento
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
    BEGIN
       NumFacturas := 0;
       NumContrafacturas := 0;
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se obtienen el codigo de zona y estacion
       --
       SELECT TO_CHAR(ZONA,'0000'), TO_CHAR(ESTACION,'0000') INTO Zona, Estacion
         FROM TVARIOS;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_FACTURAS_REC IN C_FACTURAS (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_FACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='F';
     aFecha:=TO_CHAR(C_FACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_FACTURAS_REC.NUMFACTU,'00000000'));
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_FACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_FACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_FACTURAS_REC.TIPOCLIENTE_ID);
         --
     IF C_FACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_FACTURAS_REC.CODDESCU);
     ELSE
         Concepto := ' ';
     END IF;
     --
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         AIvaNo := 0.0;
         AIva := 0.0;
         ImporteTotal := 0.0;
         ImporteNet   := 0.0;
         ImporteNeto  := 0.0;
     aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;        -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_FACTURAS_REC.FECHALTA, C_FACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
                     TipoCliente, NombreCompleto, ImporteNeto,
                     AIva, AIvaNo, ImporteTotal,Concepto,aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
         NumFacturas := NumFacturas + 1;
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
                --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
            aTipo:='N';
            aFecha:= TO_CHAR(aDate,'DD/MM/YYYY HH24::MI::SS');
                PtoVenta:= TO_CHAR(Obtieneptoventa(C_FACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
                    NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(NumeroContrafactura,'00000000'));
                    --
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
                    --
                    -- Se inserta TTMPARQCAJA en tupla
                    --
                    INSERT INTO TTMPARQCAJAEXTEN
                       VALUES ( FechaContraFactura, C_FACTURAS_REC.TIPFACTU, NumeroFactura,
                                PtoVenta, NumeroInforme, Dominio,
                                DECODE(C_FACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
                                TipoCliente, NombreCompleto, -ImporteNeto,
                                -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
                    --
                    -- Se incrementa el contador de contrafacturas
                    --
                    NumContrafacturas := NumContraFacturas + 1;
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_CONTRAFACTURAS_REC.CODFACTU);
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
     aTipo:='N';
     aFecha:=TO_CHAR(C_CONTRAFACTURAS_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_CONTRAFACTURAS_REC.CODCOFAC,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_CONTRAFACTURAS_REC.NUMFACTU,'00000000'));
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_CONTRAFACTURAS_REC.CODFACTU AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_CONTRAFACTURAS_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
         TipoCliente := Tipodelcliente(C_CONTRAFACTURAS_REC.TIPOCLIENTE_ID);
         --
     IF C_CONTRAFACTURAS_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_CONTRAFACTURAS_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
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
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_CONTRAFACTURAS_REC.FECHALTA,C_CONTRAFACTURAS_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_CONTRAFACTURAS_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C.Corriente'),
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
         --
         -- Incremento en uno el numero de facturas;
         --
           NumContraFacturas := NumContraFacturas + 1;
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
     aTipo:='D';
     aFecha:=TO_CHAR(C_NCXDESCUENTO_REC.FECHALTA,'DD/MM/YYYY HH24::MI::SS');
         PtoVenta:= TO_CHAR(Obtieneptoventa(C_NCXDESCUENTO_REC.CODFACTU,aTipo,aFecha),'0000');
         NumeroFactura := LTRIM(PtoVenta) || '-' || LTRIM(TO_CHAR(C_NCXDESCUENTO_REC.NUMFACTU,'00000000'));
-----------
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         NumeroInforme := Numerodeinforme(Zona,Estacion,C_NCXDESCUENTO_REC.RELCODFAC);
         --
         --
         -- Se obtiene la matricula del vehiculo
         --
         SELECT NVL(PATENTEN,PATENTEA) INTO Dominio
           FROM TVEHICULOS V, TINSPECCION I
             WHERE CODFACTU = C_NCXDESCUENTO_REC.RELCODFAC AND
                   I.CODVEHIC = V.CODVEHIC;
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_NCXDESCUENTO_REC.CODCLIEN);
         --
         -- Se obtiene el tipo del Cliente
         --
     IF C_NCXDESCUENTO_REC.CODDESCU IS NOT NULL
     THEN
         Concepto := Conceptodescuento(C_NCXDESCUENTO_REC.CODDESCU);
     ELSE
         Concepto :=' ';
     END IF;
     --
         --
         TipoCliente := Tipodelcliente(C_NCXDESCUENTO_REC.TIPOCLIENTE_ID);
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPARQCAJAEXTEN
            VALUES ( C_NCXDESCUENTO_REC.FECHALTA, C_NCXDESCUENTO_REC.TIPFACTU,
                     NumeroFactura, PtoVenta, NumeroInforme, Dominio,
                     DECODE(C_NCXDESCUENTO_REC.FORMPAGO,'M','Contado','T','Tarjeta','H','Cheque','C. Corriente'),
                     TipoCliente, NombreCompleto, -ImporteNeto,
                     -AIva, -AIvaNo, -ImporteTotal,Concepto,-aIIBB);
         --
         -- Incremento en uno el numero de NOTAS DE CREDITO;
         --
         NumContrafacturas := NumContraFacturas + 1;
         --
       END LOOP;
       --
       -- Total en Caja
       TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja + IIBBEnCaja;
    END Doarqueocajaxtipocliente;

     PROCEDURE Dolistadocheques
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      NumCheques IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER
  )
    IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre todos los cheques cuya factura no tenga NC, la forma de pago sea CHEQUE y IMPRESA='S', ERROR='N'
      --
      CURSOR C_CHEQUES (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODCHEQUE,C.CODFACTU,PTOVENT,NUMFACTU,C.CODCLIEN,C.FECHALTA,FECHPAGO,CODBANCO,CODSUCURSAL,
      NUMCHEQUE,IMPORTE,CODMONEDA
        FROM
          TCHEQUES C,TFACTURAS F,TFACT_ADICION A
        WHERE
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (F.IMPRESA IN ('S', 'R'))
          AND (F.ERROR = 'N')
      AND (C.ERROR = 'N')
          AND (FORMPAGO = 'H')
      AND (C.CODFACTU= F.CODFACTU)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
      AND (F.CODCOFAC IS NULL)
          AND (F.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (F.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       NombreBanco VARCHAR2(50);             -- Nombre Banco
       NombreSucursal VARCHAR2(50);         -- Nombre Sucursal
       NumeroFactura VARCHAR2(15);           -- Numero de factura eeee-nnnnnnnn
       SimbMoneda VARCHAR2(3);             -- Simbología utilizada para la moneda
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
    BEGIN
       NumCheques := 0;
       TotalEnCaja := 0;
       --
       -- Se obtienen el codigo de zona y estacion
       --
       SELECT TO_CHAR(ZONA,'0000'), TO_CHAR(ESTACION,'0000') INTO Zona, Estacion
         FROM TVARIOS;
       --
       -- Se inicia el recorrido de la tabla TFACTURAS
       --
       FOR C_CHEQUES_REC IN C_CHEQUES (FechaIni, FechaFin) LOOP
         --
         -- Se Calcula el numero de informe, formato ee zzzzeeeennnnnn r
         --
         --
         -- Se calcula el numero de factura, en formato eeee-nnnnnnnn
         --
         NumeroFactura := LTRIM(TO_CHAR(C_CHEQUES_REC.PTOVENT,'0000')) || '-' || LTRIM(TO_CHAR(C_CHEQUES_REC.NUMFACTU,'00000000'));
         --
         --
         -- Se obtiene el nombre completo del cliente
         --
         NombreCompleto := Nombreyapellidos(C_CHEQUES_REC.CODCLIEN);
         --
     -- Se obtiene el nombre del banco y la sucursal
        NombreBanco:='';
        SELECT CODBANCO||'-'||NOMBRE INTO NombreBanco FROM TBANCOS
        WHERE CODBANCO=C_CHEQUES_REC.CODBANCO;
     --
        NombreSucursal:='';
        SELECT CODSUCURSAL||'-'||NOMBRE INTO NombreSucursal FROM TSUCURSALES
        WHERE CODSUCURSAL=C_CHEQUES_REC.CODSUCURSAL
        AND CODBANCO=C_CHEQUES_REC.CODBANCO;
         --
     -- Se obtiene el símbolo (abreviatura de la moneda)
     --
        SELECT NVL(SIMBOLO,'$') INTO SimbMoneda FROM TMONEDAS
        WHERE CODMONEDA= C_CHEQUES_REC.CODMONEDA;
     --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         ImporteTotal := C_CHEQUES_REC.IMPORTE;
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         INSERT INTO TTMPLISTCHEQUES
            VALUES ( NVL(NombreBanco,'nb'),NVL(NombreSucursal,'NS'),C_CHEQUES_REC.NUMCHEQUE,NombreCompleto,
             SimbMoneda,ImporteTotal,NumeroFactura,C_CHEQUES_REC.FECHALTA,
             C_CHEQUES_REC.FECHPAGO);
         --
         -- Incremento en uno el numero de Cheques;
         --
         NumCheques := NumCheques + 1;
     TotalEnCaja := TotalEnCaja + ImporteTotal;
         --
       END LOOP;
       --
    END Dolistadocheques;

    PROCEDURE Dototalescajacontado
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      NumFacturas IN OUT NUMBER,
      NumContrafacturas IN OUT NUMBER,
      DebeEnCaja IN OUT NUMBER,
      IvaEnCaja IN OUT NUMBER,
      IvaNoInscriptoEnCaja IN OUT NUMBER,
      IIBBEnCaja IN OUT NUMBER,
      TotalEnCaja IN OUT NUMBER,
      TotalGlobal IN OUT NUMBER
  )
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
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO IN ('M','H'))
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, A.CODDESCU, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (FORMPAGO = 'M')
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
            AND (A.CODFACT=F.CODFACTU)
            AND (A.TIPOFAC='F')
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
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
          AND (FORMPAGO = 'M')
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'D')
      AND RELCODFAC IS NOT NULL
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       Concepto VARCHAR2(20);             -- Descripción del Descuento
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
    BEGIN
       NumFacturas := 0;
       NumContrafacturas := 0;
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       IIBBEnCaja := 0.0;
       --
       -- Se obtienen el codigo de zona y estacion
       --
       SELECT TO_CHAR(ZONA,'0000'), TO_CHAR(ESTACION,'0000') INTO Zona, Estacion
         FROM TVARIOS;
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
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;        -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
         --
         -- Se inserta la tupla en la tabla temporal para el arqueo
         --
         -- Incremento en uno el numero de facturas;
         --
         NumFacturas := NumFacturas + 1;
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
                --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
                    --
                    --
                    -- Se incrementa el contador de contrafacturas
                    --
                    NumContrafacturas := NumContraFacturas + 1;
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin) LOOP
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
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
         ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Incremento en uno el numero de facturas;
         --
           NumContraFacturas := NumContraFacturas + 1;
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
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
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         -- Incremento en uno el numero de NOTAS DE CREDITO;
         --
         NumContrafacturas := NumContraFacturas + 1;
         --
       END LOOP;
       --
       -- Total en Caja
         TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja;
     TotalGlobal := TotalEnCaja + IIBBEnCaja;
    END Dototalescajacontado;
    ---
PROCEDURE Dototalestarjeta
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      CodigoTarjeta IN NUMBER
      
  )
    IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, CODDESCU, NUMTARJET,CODAUTO, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = 'T')
      AND (CODTARJET = CodigoTarjeta)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que
      -- no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, A.CODDESCU, NUMTARJET, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (FORMPAGO = 'T')
                AND (CODTARJET = CodigoTarjeta)
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
            AND (A.CODFACT=F.CODFACTU)
            AND (A.TIPOFAC='F')
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
--
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, RELCODFAC, CODDESCU, NUMTARJET,CODAUTO, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = 'T')
      AND (CODTARJET = CodigoTarjeta)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'D')
      AND RELCODFAC IS NOT NULL
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
---------------------------
-----MODIFICACION TARJETA
---------------------------
       aCodAuto VARCHAR2(20);
       CodTarjeta NUMBER(8);
       Concepto VARCHAR2(20);             -- Descripción del Descuento
--------------------------
--variables totalizadoras
--------------------------
       DebeEnCaja NUMBER(9,2);
       IvaEnCaja NUMBER(9,2);
       IvaNoInscriptoEnCaja NUMBER(9,2);
       TotalEnCaja NUMBER(9,2);
       IIBBEnCaja NUMBER(9,2);
       aNombreTarjeta VARCHAR2(25);
    BEGIN
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       TotalEnCaja := 0.0;
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
         ImporteNet   := 0.0;
         ImporteNeto  := 0.0;
     aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;        -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
                --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
            --
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
                    --
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin) LOOP
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
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
     --
     --
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         --
       END LOOP;
       --
       -- Calculo el Total en Caja
       TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja + IIBBEnCaja;
       --
       --
       SELECT NOMTARJET INTO aNombreTarjeta FROM TTARJETAS
       WHERE CODTARJET=CodigoTarjeta;
       INSERT INTO TTMPTOTALTARJETA
       VALUES ( CodigoTarjeta, aNombreTarjeta,DebeEnCaja, IvaEnCaja, IvaNoInscriptoEnCaja,TotalEnCaja, IIBBEnCaja);
       --
       --
    END Dototalestarjeta;


PROCEDURE DoalltotalestarjetaxCajero
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      IdCajero IN NUMBER
  )
    IS
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de tarjetas
      --
      CURSOR C_TARJETAS  IS
        SELECT CODTARJET, NOMTARJET
        FROM TTARJETAS;
      --
    BEGIN
       --
       -- Se inicia el recorrido de la tabla TTARJETAS
       --
       FOR C_TARJETAS_REC IN C_TARJETAS LOOP
         --
         Dototalestarjetaxcajero(FechaIni,FechaFin,C_TARJETAS_REC.CODTARJET,IdCajero);
     --
       END LOOP;
    END Doalltotalestarjetaxcajero;
    
    
    PROCEDURE Dototalestarjetaxcajero
  (
      FechaIni IN VARCHAR2,
      FechaFin IN VARCHAR2,
      CodigoTarjeta IN NUMBER,
      IdCajero IN NUMBER
  )
    IS
      --
      -- DECLARACIONES
      --
      -- Cursor que recorre toda la tabla de facturas
      --
      CURSOR C_FACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, CODDESCU, NUMTARJET,CODAUTO, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = 'T')
      AND (CODTARJET = CodigoTarjeta)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'F')
       AND (A.IDUSUARI = IdCajero)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
      --
      -- Cursor que recorre toda la tabla de contrafacturas para las que
      -- no corresponden a facturas dentro del intervalo
      --
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
      CURSOR C_CONTRAFACTURAS (FI IN VARCHAR2, FF IN VARCHAR2) IS
          SELECT CODFACTU, C.NUMFACTU, C.FECHALTA, FORMPAGO, IMPONETO, TIPFACTU,
     IVAINSCR, CODCLIEN, IVANOINS, TIPOCLIENTE_ID, C.CODCOFAC, A.CODDESCU, NUMTARJET, IIBB
              FROM TFACTURAS F, TCONTRAFACT C, TFACT_ADICION A
                  WHERE F.CODCOFAC = C.CODCOFAC
                        AND (F.FECHALTA < TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (C.FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'))
                        AND (F.IMPRESA IN ('S', 'R'))
                        AND (C.IMPRESA IN ('S', 'R'))
                        AND (F.ERROR = 'N')
                        AND (FORMPAGO = 'T')
                AND (CODTARJET = CodigoTarjeta)
                        AND (F.NUMFACTU > 0)
                        AND (C.NUMFACTU > 0)
            AND (A.CODFACT=F.CODFACTU)
            AND (A.TIPOFAC='F')
             AND (A.IDUSUARI = IdCajero)
                        AND (NOT F.NUMFACTU IS NULL)
                        AND (NOT C.NUMFACTU IS NULL);
--
--------------------------------
-----MODIFICACION NC X DESCUENTO
--------------------------------
      CURSOR C_NCXDESCUENTO (FI IN VARCHAR2, FF IN VARCHAR2) IS
        SELECT
          CODFACTU, NUMFACTU, FECHALTA, FORMPAGO, IMPONETO, TIPFACTU, IVAINSCR,
          CODCLIEN, IVANOINS, CODCOFAC, TIPOCLIENTE_ID, RELCODFAC, CODDESCU, NUMTARJET,CODAUTO, IIBB
        FROM
          TFACTURAS F, TFACT_ADICION A
        WHERE
          (NOT NUMFACTU IS NULL)
          AND (NUMFACTU > 0)
          AND (IMPRESA IN ('S', 'R'))
          AND (ERROR = 'N')
          AND (FORMPAGO = 'T')
      AND (CODTARJET = CodigoTarjeta)
      AND (F.CODFACTU=A.CODFACT)
      AND (A.TIPOFAC = 'D')
      AND RELCODFAC IS NOT NULL
       AND (A.IDUSUARI = IdCajero)
          AND (FECHALTA >= TO_DATE(FI, 'DD/MM/YYYY HH24:MI:SS'))
          AND (FECHALTA <= TO_DATE(FF, 'DD/MM/YYYY HH24:MI:SS'));
       --
       --
       -- VARIABLES
       --
       NombreCompleto VARCHAR2(110);         -- Nombre del cliente Nombre Apellido 1 Apellido 2
       TipoCliente TTIPOSCLIENTE.DESCRIPCION%TYPE; -- Descripcion del Tipo del cliente;
       NumeroInforme VARCHAR2(50);           -- Numero de informe de inspeccion  ee zzzzeeeennnnnn r
       NumeroFactura VARCHAR2(50);           -- Numero de factura eeee-nnnnnnnn
       NumeroContraFactura NUMBER;           -- Nuemero de la contrafactura
       Dominio VARCHAR2(10);                 -- Matr¡cula del vehiculo
       Zona VARCHAR2(10);                    -- Zona zzzz
       Estacion VARCHAR2(10);                -- Estacion eeee
---------------------------
-----MODIFICACION PTO VENTA
---------------------------
       PtoVenta VARCHAR2(10);             -- Punto de venta pppp
       aFecha VARCHAR2(30);             -- Para pasar a char la fecha
       aDate DATE;                 -- Para pasar la fecha de contrafacturas
       aTipo VARCHAR2(1);
----------
       FechaContraFactura VARCHAR2(30);      -- Fecha de la cotrafactura
       ImporteNet   NUMBER(9,3);             -- Importe Neto sin ROUND
       ImporteNeto  NUMBER(9,2);             -- Importe Neto de la Factura
       AIvaNo NUMBER(4,2);                   -- Auxiliar para el Iva No inscripto
       AIva NUMBER(5,3);                     -- Auxiliar para el Iva
       ImporteTotal NUMBER(9,2);             -- Importe Total de una factura.
       aIIBB NUMBER(4,2);             -- Para almacenar el importe del IIBB
---------------------------
-----MODIFICACION TARJETA
---------------------------
       aCodAuto VARCHAR2(20);
       CodTarjeta NUMBER(8);
       Concepto VARCHAR2(20);             -- Descripción del Descuento
--------------------------
--variables totalizadoras
--------------------------
       DebeEnCaja NUMBER(9,2);
       IvaEnCaja NUMBER(9,2);
       IvaNoInscriptoEnCaja NUMBER(9,2);
       TotalEnCaja NUMBER(9,2);
       IIBBEnCaja NUMBER(9,2);
       aNombreTarjeta VARCHAR2(25);
    BEGIN
       DebeEnCaja := 0.0;
       IvaEnCaja := 0.0;
       IvaNoInscriptoEncaja := 0.0;
       TotalEnCaja := 0.0;
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
         ImporteNet   := 0.0;
         ImporteNeto  := 0.0;
     aIIBB := 0.0;  ----------- INICIALIZO IIBB
         IF C_FACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_FACTURAS_REC.IMPONETO / (1+(C_FACTURAS_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_FACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_FACTURAS_REC.IMPONETO * C_FACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIIBB;        -- sumo al total el iibb
           ELSE
             ImporteNeto := C_FACTURAS_REC.IMPONETO;
             AIva := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_FACTURAS_REC.IMPONETO*C_FACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_FACTURAS_REC.IMPONETO + aIva + aIvaNo + aIIBB;    -- sumo al total el iibb
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja + AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja + ImporteNeto;
         IvaEnCaja := IvaEnCaja + aIva;
     IIBBEnCaja := IIBBEnCaja + aIIBB;    -- VOY ACUMULANDO EL IIBB
         --
         -- Si la factura tiene una contrafactura, hay que incluirla y restar de los acumulados
         --
         IF NOT C_FACTURAS_REC.CODCOFAC IS NULL
            THEN
               SELECT FECHALTA, FECHALTA, NUMFACTU INTO FechaContraFactura, aDate, NumeroContraFactura
                 FROM TCONTRAFACT
                   WHERE (CODCOFAC = C_FACTURAS_REC.CODCOFAC);
                --
                -- Si esta dentro del intervalo de fechas
                --
                IF (NumeroContrafactura > 0) AND
                    (FechaContrafactura >= TO_DATE(FechaIni, 'DD/MM/YYYY HH24:MI:SS')) AND
                   (FechaContrafactura <= TO_DATE(FechaFin, 'DD/MM/YYYY HH24:MI:SS'))
                  THEN
            --
                    --  Se resta el importe y el iva de los acumulados
                    --
                    DebeEnCaja := DebeEnCaja - ImporteNeto;
                    IvaEnCaja := IvaEnCaja - AIva;
                    IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
            IIBBEnCaja := IIBBEnCaja - aIIBB;                --RESTO AL ACUMULADO EL IIBB ACTUAL
                    --
                END IF;
         END IF;
       END LOOP;
       --
       -- Las contrafacuras que estan dentro del intervalo
       --
       FOR C_CONTRAFACTURAS_REC IN C_CONTRAFACTURAS (FechaIni, FechaFin) LOOP
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
         IF C_CONTRAFACTURAS_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_CONTRAFACTURAS_REC.IMPONETO / (1+(C_CONTRAFACTURAS_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_CONTRAFACTURAS_REC.IVAINSCR)/100),2);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO * C_CONTRAFACTURAS_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + aIIBB;    -- sumo al total el iibb
           ELSE
             AIva := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVAINSCR)/100);
             AIvaNo := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IVANOINS)/100);
         aIIBB := ((C_CONTRAFACTURAS_REC.IMPONETO*C_CONTRAFACTURAS_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_CONTRAFACTURAS_REC.IMPONETO + AIva + AIvaNo + aIIBB;    -- SUMO AL TOTAL EL IIBB
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - AIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
     --
     --
         END LOOP;
---------------------------
-----MODIFICACION NC X DESCUENTO
---------------------------
       FOR C_NCXDESCUENTO_REC IN C_NCXDESCUENTO (FechaIni, FechaFin) LOOP
         --
         -- Se calcula el Importe Total, e Ivas de la factura, asi como los acumulados
         --
         IF C_NCXDESCUENTO_REC.TIPFACTU = 'B'
           THEN
             ImporteNet  := C_NCXDESCUENTO_REC.IMPONETO / (1+(C_NCXDESCUENTO_REC.IVAINSCR/100));
             ImporteNeto := ROUND(ImporteNet,2);
             AIva := ROUND(((ImporteNet * C_NCXDESCUENTO_REC.IVAINSCR)/100),2);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO * C_NCXDESCUENTO_REC.IIBB)/100);        -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIIBB;
           ELSE
             ImporteNeto := C_NCXDESCUENTO_REC.IMPONETO;
             AIva := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVAINSCR)/100);
             AIvaNo := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IVANOINS)/100);
         aIIBB := ((C_NCXDESCUENTO_REC.IMPONETO*C_NCXDESCUENTO_REC.IIBB)/100);    -- calculo el iibb
             ImporteTotal := C_NCXDESCUENTO_REC.IMPONETO + aIva + aIvaNo;
             IvaNoInscriptoEncaja := IvaNoInscriptoEnCaja - AIvaNo;
         END IF;
         DebeEnCaja := DebeEnCaja - ImporteNeto;
         IvaEnCaja := IvaEnCaja - aIva;
     IIBBEnCaja := IIBBEnCaja - aIIBB;    -- RESTO DEL ACUMULANDO EL IIBB
         --
         --
       END LOOP;
       --
       -- Calculo el Total en Caja
       TotalEnCaja := DebeEnCaja + IvaEnCaja + IvaNoInscriptoEnCaja + IIBBEnCaja;
       --
       --
       SELECT NOMTARJET INTO aNombreTarjeta FROM TTARJETAS
       WHERE CODTARJET=CodigoTarjeta;
       INSERT INTO TTMPTOTALTARJETA
       VALUES ( CodigoTarjeta, aNombreTarjeta,DebeEnCaja, IvaEnCaja, IvaNoInscriptoEnCaja,TotalEnCaja, IIBBEnCaja);
       --
       --
    END Dototalestarjetaxcajero;
 --
--
 END  Pq_Arqueo_Vtv;
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
	 ( C_FACTURAS_REC.NOMBRE ,C_FACTURAS_REC.TIPOCLIENTE_ID,C_FACTURAS_REC.DOCUMENT,ImporteNeto, aIva, aIIBB, ImporteTotal,CAJ );

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
	 ( C_NCXDESCUENTO_REC. NOMBRE,C_NCXDESCUENTO_REC.TIPOCLIENTE_ID,C_NCXDESCUENTO_REC. DOCUMENT,ImporteNeto, aIva, aIIBB, ImporteTotal,CAJ );
         --
       END LOOP;
       --

    END;
---
--
END Pq_Liqdiaria;
--
/
