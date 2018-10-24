CREATE OR REPLACE PACKAGE CABASM.PQ_INSERTAXML
 AS
 procedure INSPECCION ( 
                          Planta IN VARCHAR2, Fecha IN VARCHAR2,
						  Ejercici IN VARCHAR2, Codinspe IN VARCHAR2,
						  Codvehic IN VARCHAR2, Codclpro IN VARCHAR2,
						  Codclcon IN VARCHAR2, Codclten IN VARCHAR2,
						  Inspfina IN VARCHAR2, Tipo IN VARCHAR2,
						  Fechalta IN VARCHAR2, Codfrecu IN VARCHAR2,
						  FecVenci IN VARCHAR2, Numoblea IN VARCHAR2,
						  Codfactu IN VARCHAR2, HorFinal IN VARCHAR2,
						  HorentZ1 IN VARCHAR2, HorsalZ1 IN VARCHAR2,
						  HorentZ2 IN VARCHAR2, HorSalZ2 IN VARCHAR2,
						  HorentZ3 IN VARCHAR2, HorSalZ3 IN VARCHAR2,
						  OBSERVAC IN VARCHAR2,Resultado IN VARCHAR2, 
						  Waspre IN VARCHAR2,
						  NumrevS1 IN VARCHAR2, NumlinS1 IN VARCHAR2,
						  NumrevS2 IN VARCHAR2, NumlinS2 IN VARCHAR2,
						  NumrevS3 IN VARCHAR2,  NumlinS3 IN VARCHAR2,
						  Codservicio IN VARCHAR2, Enviado IN VARCHAR2
					  );
					  
 procedure VEHICULOS ( 
                        Planta IN VARCHAR2,     Codvehic IN VARCHAR2, Fechamatri IN VARCHAR2, Aniofabr IN VARCHAR2, Codmarca IN VARCHAR2, 
                        Codmodel IN VARCHAR2,   Tipoespe IN VARCHAR2, Tipodest IN VARCHAR2,   Numchasis IN VARCHAR2,  
                        AnyoChasis IN VARCHAR2, Numejes IN VARCHAR2,  Nummotor IN VARCHAR2,   PatenteN IN VARCHAR2,  
                        PatenteA IN VARCHAR2,   Cola IN VARCHAR2,     Largo IN VARCHAR2,      Alto IN VARCHAR2,      
                        Ancho IN VARCHAR2,      Tara IN VARCHAR2,     Codpais IN VARCHAR2,    Error IN VARCHAR2,      
                        Internacional IN VARCHAR2, Tacografo IN VARCHAR2, Codpavehic IN VARCHAR2, CodpadClien IN VARCHAR2, NroRegistro IN VARCHAR2, 
                        Codtipocombustible IN VARCHAR2, Codmarcachasis IN VARCHAR2, Codmodelochasis IN VARCHAR2, 
                        Tiporegistradoreventos IN VARCHAR2, Codtiposuspension IN VARCHAR2, Fechalta IN VARCHAR2
					  );

 procedure EJEDISTANCIA ( 
                         Planta IN VARCHAR2,     Codinspe IN VARCHAR2,  Codvehic IN VARCHAR2,
                         Numejes IN VARCHAR2,    Cola IN VARCHAR2,      DPE IN VARCHAR2,
                         Numchasis IN VARCHAR2,  Disejes12 IN VARCHAR2, Disejes23 IN VARCHAR2,
                         Disejes34 IN VARCHAR2,  Disejes45 IN VARCHAR2, Disejes56 IN VARCHAR2,
                         Numrevis IN VARCHAR2,   Fechalta IN VARCHAR2,  Disejes67 IN VARCHAR2,
                         Disejes78 IN VARCHAR2,  Disejes89 IN VARCHAR2, Alto IN VARCHAR2,
                         Ancho IN VARCHAR2,  Largo IN VARCHAR2                        
                        );	

 procedure DATINSPEVI ( 
                         Planta IN VARCHAR2,    Ejercici IN VARCHAR2,   Codinspe IN VARCHAR2,
                         Secudefe IN VARCHAR2,  Numrevis IN VARCHAR2,   Numlinea IN VARCHAR2,
                         Numzona IN VARCHAR2,   Caddefec IN VARCHAR2,   Califdef IN VARCHAR2,
                         Ubicadef IN VARCHAR2,  OtrosDef IN VARCHAR2,   Fechalta IN VARCHAR2                        
                        );     
 procedure DIMENSIONESVEHICULOS ( 
                                 Planta IN VARCHAR2,    Ejercici IN VARCHAR2,   Codinspe IN VARCHAR2,
                                 Codvehic IN VARCHAR2,  Largo IN VARCHAR2,      Alto IN VARCHAR2,
                                 Ancho IN VARCHAR2,     Tara IN VARCHAR2,       PesoBruto IN VARCHAR2,
                                 Fecha IN VARCHAR2                        
                                );   
 procedure VEHICOMNIBUS ( 
                         Planta IN VARCHAR2,    Codvehic IN VARCHAR2,   Cantasientos IN VARCHAR2,   
                         Banio IN VARCHAR2,     Cantpuertas IN VARCHAR2,    Aireacondicionado IN VARCHAR2,
                         Codtiposientos IN VARCHAR2,    Codtipobodega IN VARCHAR2,  Codcategoriaservicio IN VARCHAR2,
                         Accesibilidad IN VARCHAR2, Codmarcacarroceria IN VARCHAR2, 
                         CODTIPOSERVICIO IN VARCHAR2, CODTIPOSUBSERVICIO  IN VARCHAR2                        
                        );                                                                            					  					  
 procedure TINSPDEFECT ( 
                         Planta IN VARCHAR2,    Ejercici IN VARCHAR2,   Codinspe IN VARCHAR2,   Secdefec IN VARCHAR2,
                         Localiza IN VARCHAR2,  Caddefec IN VARCHAR2,   Calidef IN VARCHAR2,    Valormed IN VARCHAR2,
                         Fechalta IN VARCHAR2                        
                        );  
 procedure VEHICCARGA ( 
                         Planta IN VARCHAR2,    Codvehic IN VARCHAR2,   Longitudenganche IN VARCHAR2,
                         Codtipocajacarga IN VARCHAR2,  Codtipocabina IN VARCHAR2,  Codtipocarga IN VARCHAR2,
                         Codtipoaditamento IN VARCHAR2 
                        ); 
 procedure TCLIENTES ( 
                        Planta IN VARCHAR2,    Codclien IN VARCHAR2,   Tipodocu IN VARCHAR2,
                        Document IN VARCHAR2,   TipoclienteID IN VARCHAR2,  Fechalta IN VARCHAR2,
                        Nombre IN VARCHAR2,     Apellid1 IN VARCHAR2,       Codparti IN VARCHAR2, 
                        Tiptribu IN VARCHAR2,   Creditcl IN VARCHAR2,       Codposta IN VARCHAR2,       
                        Telefono IN VARCHAR2,   Apellid2 IN VARCHAR2,       Localida IN VARCHAR2,
                        Direccio IN VARCHAR2,   Nrocalle IN VARCHAR2,       Piso IN VARCHAR2,           
                        Depto IN VARCHAR2,      Idlocalidad IN VARCHAR2,    CodArea IN VARCHAR2,    
                        Celular IN VARCHAR2,    Mail IN VARCHAR2,           Idpais IN VARCHAR2,
                        Coddocu IN VARCHAR2,    Iddepartamento IN VARCHAR2, Dvdocument IN VARCHAR2, 
                        Profesional IN VARCHAR2 
                     );
end PQ_INSERTAXML;
/

CREATE OR REPLACE PACKAGE BODY CABASM.PQ_INSERTAXML
AS
   PROCEDURE INSPECCION (
						  Planta IN VARCHAR2, Fecha IN VARCHAR2,
						  Ejercici IN VARCHAR2, Codinspe IN VARCHAR2,
						  Codvehic IN VARCHAR2, Codclpro IN VARCHAR2,
						  Codclcon IN VARCHAR2, Codclten IN VARCHAR2,
						  Inspfina IN VARCHAR2, Tipo IN VARCHAR2,
						  Fechalta IN VARCHAR2, Codfrecu IN VARCHAR2,
						  FecVenci IN VARCHAR2, Numoblea IN VARCHAR2,
						  Codfactu IN VARCHAR2, HorFinal IN VARCHAR2,
						  HorentZ1 IN VARCHAR2, HorsalZ1 IN VARCHAR2,
						  HorentZ2 IN VARCHAR2, HorSalZ2 IN VARCHAR2,
						  HorentZ3 IN VARCHAR2, HorSalZ3 IN VARCHAR2,
						  OBSERVAC IN VARCHAR2, Resultado IN VARCHAR2, 
						  Waspre IN VARCHAR2,
						  NumrevS1 IN VARCHAR2, NumlinS1 IN VARCHAR2,
						  NumrevS2 IN VARCHAR2, NumlinS2 IN VARCHAR2,
						  NumrevS3 IN VARCHAR2,  NumlinS3 IN VARCHAR2,
						  Codservicio IN VARCHAR2, Enviado IN VARCHAR2
						)   
   IS
   
    EXISTE VARCHAR2(2);
    vFechalta VARCHAR2(12);
    vFecVenci VARCHAR2(12);
    vHORFINAL VARCHAR2(12);
    vHORENTZ1 VARCHAR2(20);
	vHORSALZ1 VARCHAR2(20);
	vHORENTZ2 VARCHAR2(20);
	vHORSALZ2 VARCHAR2(20);
	vHORENTZ3 VARCHAR2(20);
	vHORSALZ3 VARCHAR2(20);
	vEjercici VARCHAR2(4);
	vCodinspe VARCHAR2(20);
	vPlanta VARCHAR2(3);

   BEGIN
   
   
    vEjercici:=Ejercici;
    vCodinspe:=Codinspe;
    vPlanta:=Planta;
    vFechalta := TO_CHAR(TO_DATE(Fechalta, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido
    vFecVenci := TO_CHAR(TO_DATE(FecVenci, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido 
    vHORFINAL := TO_CHAR(TO_DATE(HORFINAL, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido  
    vHORENTZ1 := TO_CHAR(TO_DATE(HORENTZ1, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido 
    vHORSALZ1 := TO_CHAR(TO_DATE(HORSALZ1, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido 
    vHORENTZ2 := TO_CHAR(TO_DATE(HORENTZ2, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido 
    vHORSALZ2 := TO_CHAR(TO_DATE(HORSALZ2, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido 
    vHORENTZ3 := TO_CHAR(TO_DATE(HORENTZ3, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido 
    vHORSALZ3 := TO_CHAR(TO_DATE(HORSALZ3, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido 
   
   SELECT COUNT(*) INTO EXISTE FROM TINSPECCION 
	WHERE EJERCICI = vEjercici
	  AND CODINSPE = vCodinspe
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
            INSERT INTO TINSPECCION (
										  PLANTA, 
										  EJERCICI, 
										  CODINSPE, 
										  CODVEHIC, 
										  CODCLPRO, 
										  CODCLCON,
										  CODCLTEN,
										  INSPFINA,
										  TIPO, 
										  FECHALTA,
										  CODFRECU,    
										  NUMOBLEA,
										  FECVENCI,
										  CODFACTU,
										  HORFINAL,
										  HORENTZ1,
										  HORSALZ1,
										  HORENTZ2,
										  HORSALZ2,
										  HORENTZ3,
										  HORSALZ3,
										  OBSERVAC,
										  RESULTAD,
										  WASPRE,
										  NUMREVS1,
										  NUMLINS1,
										  NUMREVS2,
										  NUMLINS2,  
										  NUMREVS3,
										  NUMLINS3,
										  CODSERVICIO,
										  ENVIADO
										 )
								 VALUES (
										Planta,
										Ejercici,
										Codinspe,
										Codvehic,
										Codclpro,
										Codclcon,
										Codclten,
										Inspfina,
										Tipo,
										TO_DATE(vFechalta,'DD/MM/YYYY'),
										Codfrecu,
										Numoblea,
										TO_DATE(vFecVenci,'DD/MM/YYYY'),
										Codfactu,
										TO_DATE(vHORFINAL,'DD/MM/YYYY'),										
										TO_DATE(vHORENTZ1,'DD/MM/YYYY'),
										TO_DATE(vHORSALZ1,'DD/MM/YYYY'),
										TO_DATE(vHORENTZ2,'DD/MM/YYYY'),
										TO_DATE(vHORSALZ2,'DD/MM/YYYY'),
										TO_DATE(vHORENTZ3,'DD/MM/YYYY'),
										TO_DATE(vHORSALZ3,'DD/MM/YYYY'),
										OBSERVAC,										
										Resultado,
										WASPRE,
										NUMREVS1,
										NUMLINS1,
										NUMREVS2,
										NUMLINS2,  
										NUMREVS3,
										NUMLINS3,
										Codservicio,
										ENVIADO
										);
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END INSPECCION;
   
PROCEDURE VEHICULOS (
                        Planta IN VARCHAR2,     Codvehic IN VARCHAR2, Fechamatri IN VARCHAR2, Aniofabr IN VARCHAR2, Codmarca IN VARCHAR2, 
                        Codmodel IN VARCHAR2,   Tipoespe IN VARCHAR2, Tipodest IN VARCHAR2,   Numchasis IN VARCHAR2,  
                        AnyoChasis IN VARCHAR2, Numejes IN VARCHAR2,  Nummotor IN VARCHAR2,   PatenteN IN VARCHAR2,  
                        PatenteA IN VARCHAR2,   Cola IN VARCHAR2,     Largo IN VARCHAR2,      Alto IN VARCHAR2,      
                        Ancho IN VARCHAR2,      Tara IN VARCHAR2,     Codpais IN VARCHAR2,    Error IN VARCHAR2,      
                        Internacional IN VARCHAR2, Tacografo IN VARCHAR2, Codpavehic IN VARCHAR2, CodpadClien IN VARCHAR2, NroRegistro IN VARCHAR2,   
                        Codtipocombustible IN VARCHAR2, Codmarcachasis IN VARCHAR2, Codmodelochasis IN VARCHAR2, 
                        Tiporegistradoreventos IN VARCHAR2, Codtiposuspension IN VARCHAR2, Fechalta IN VARCHAR2
					 )   
   IS
   
    EXISTE VARCHAR2(2);
    vFechalta VARCHAR2(12);
    vFechamatri VARCHAR2(12);
	vPlanta VARCHAR2(3);
	vCodvehic VARCHAR2(12);

   BEGIN

    vPlanta:=Planta;
    vCodvehic:=Codvehic;
    vFechalta := TO_CHAR(TO_DATE(Fechalta, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido
    vFechamatri := TO_CHAR(TO_DATE(Fechamatri, 'YYYY-MM-DD'), 'DD/MM/YYYY');
   
   SELECT COUNT(*) INTO EXISTE FROM TVEHICULOS 
	WHERE Codvehic = vCodvehic
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
            INSERT INTO TVEHICULOS (
                                            PLANTA,
                                            CODVEHIC,
                                            FECMATRI,
                                            FECHALTA,
                                            ANIOFABR,
                                            CODMARCA,
                                            CODMODEL,
                                            TIPOESPE,
                                            TIPODEST,
                                            NUMCHASIS,
                                            ANYOCHASIS,
                                            NUMEJES,
                                            NUMMOTOR,
                                            PATENTEN,
                                            PATENTEA,
                                            CODTIPOCOMBUSTIBLE,
                                            CODMARCACHASIS,
                                            CODMODELOCHASIS,
                                            PESOBRUTO,
                                            COLA,
                                            DPE,
                                            TIPOMOTORMOTO,
                                            LARGO,
                                            ALTO,
                                            ANCHO,
                                            TARA,
                                            TIPOREGISTRADOREVENTOS,
                                            CODTIPOSUSPENSION,
                                            CODDEPARTAMENTO,
                                            CODPAIS,
                                            DISEJES12,
                                            DISEJES23,
                                            DISEJES34,
                                            DISEJES45,
                                            DISEJES56,
                                            ERROR,
                                            INTERNACIONAL,
                                            TACOGRAFO,
                                            CODPADVEHIC,
                                            CODPADCLIEN,
                                            TACO,
                                            PROFESIONAL,
                                            NROREGISTRO
										 )
								 VALUES (
										Planta,
										vCodvehic,
										TO_DATE(vFechamatri,'DD/MM/YYYY'),
										TO_DATE(vFechalta,'DD/MM/YYYY'),
										Aniofabr,
										Codmarca,
										Codmodel,
										Tipoespe,
										Tipodest,
										Numchasis,
										AnyoChasis,
										Numejes,
										Nummotor,
										PatenteN,
										PatenteA,
										Codtipocombustible,
										Codmarcachasis,
										Codmodelochasis,
										NULL, --PESOBRUTO
										REPLACE(Cola,',','.'),
										NULL, --DPE
										NULL, --TIPOMOTORMOTO
										REPLACE(Largo,',','.'),
										REPLACE(Alto,',','.'),
										REPLACE(Ancho,',','.'),
										REPLACE(Tara,',','.'),
										Tiporegistradoreventos,
										Codtiposuspension,
										NULL,
										Codpais,
										NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        NULL,
                                        ERROR,
                                        Internacional,
                                        Tacografo,
                                        Codpavehic,
                                        CodpadClien,
                                        NULL,
                                        NULL,
                                        NroRegistro
										);
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END VEHICULOS;  
   
PROCEDURE EJEDISTANCIA ( 
                         Planta IN VARCHAR2, Codinspe IN VARCHAR2, Codvehic IN VARCHAR2,
                         Numejes IN VARCHAR2, Cola IN VARCHAR2,  DPE IN VARCHAR2,
                         Numchasis IN VARCHAR2,  Disejes12 IN VARCHAR2, Disejes23 IN VARCHAR2,
                         Disejes34 IN VARCHAR2,  Disejes45 IN VARCHAR2, Disejes56 IN VARCHAR2,
                         Numrevis IN VARCHAR2,   Fechalta IN VARCHAR2,  Disejes67 IN VARCHAR2,
                         Disejes78 IN VARCHAR2,  Disejes89 IN VARCHAR2, Alto IN VARCHAR2,
                         Ancho IN VARCHAR2,  Largo IN VARCHAR2                        
                        ) 
   IS
   
    EXISTE VARCHAR2(2);
    vFechalta VARCHAR2(12);
	vPlanta VARCHAR2(3);
	vCodvehic VARCHAR2(12);
	vCodinspe VARCHAR2(12);

   BEGIN

    vPlanta:=Planta;
    vCodvehic:=Codvehic;
    vCodinspe:=Codinspe;
    vFechalta := TO_CHAR(TO_DATE(Fechalta, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido
   
   SELECT COUNT(*) INTO EXISTE FROM EJEDISTANCIA 
	WHERE Codvehic = vCodvehic
      AND Codinspe = vCodinspe
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
            INSERT INTO EJEDISTANCIA (
                                            PLANTA,
                                            CODINSPE,
                                            CODVEHIC,
                                            NUMEJES,
                                            CANTIDAD,
                                            COLA,
                                            DPE,
                                            NUMCHASIS,
                                            DISEJES12,
                                            DISEJES23,
                                            DISEJES34,
                                            DISEJES45,
                                            DISEJES56,
                                            NUMREVIS,
                                            FECHALTA,
                                            DISEJES67,
                                            DISEJES78,
                                            DISEJES89,
                                            ALTO,
                                            ANCHO,
                                            LARGO                                            
										 )
								 VALUES (
										vPlanta,
										vCodinspe,
										vCodvehic,
										Numejes,
										NULL, --CANTIDAD
                                        REPLACE(Cola,',','.'),
                                        DPE,
                                        Numchasis,
                                        REPLACE(Disejes12,',','.'),
                                        REPLACE(Disejes23,',','.'),
                                        REPLACE(Disejes34,',','.'),
                                        REPLACE(Disejes45,',','.'),
                                        REPLACE(Disejes56,',','.'),
                                        Numrevis,
                                        TO_DATE(vFechalta,'DD/MM/YYYY'),
                                        REPLACE(Disejes67,',','.'),
                                        REPLACE(Disejes78,',','.'),
                                        REPLACE(Disejes89,',','.'),
                                        REPLACE(Alto,',','.'),
                                        REPLACE(Ancho,',','.'),
                                        REPLACE(Largo,',','.')
										);
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END EJEDISTANCIA;  

PROCEDURE DATINSPEVI ( 
                         Planta IN VARCHAR2,    Ejercici IN VARCHAR2,   Codinspe IN VARCHAR2,
                         Secudefe IN VARCHAR2,  Numrevis IN VARCHAR2,   Numlinea IN VARCHAR2,
                         Numzona IN VARCHAR2,   Caddefec IN VARCHAR2,   Califdef IN VARCHAR2,
                         Ubicadef IN VARCHAR2,  OtrosDef IN VARCHAR2,   Fechalta IN VARCHAR2
                        ) 
   IS
   
    EXISTE VARCHAR2(2);
    vFechalta VARCHAR2(12);
	vPlanta VARCHAR2(3);
	vCodinspe VARCHAR2(12);
	vEjercici VARCHAR2(4);

   BEGIN

    vPlanta:=Planta;
    vCodinspe:=Codinspe;
    vEjercici:=Ejercici;
    vFechalta:=TO_CHAR(TO_DATE(Fechalta, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido
   
   SELECT COUNT(*) INTO EXISTE FROM TDATINSPEVI 
	WHERE Ejercici = vEjercici
      AND Codinspe = vCodinspe
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
            INSERT INTO TDATINSPEVI (
                                            PLANTA,
                                            EJERCICI,
                                            CODINSPE,
                                            SECUDEFE,
                                            NUMREVIS,
                                            NUMLINEA,
                                            NUMZONA,
                                            CADDEFEC,
                                            CALIFDEF,
                                            UBICADEF,
                                            OTROSDEF,
                                            OBSERVAC,
                                            FECHALTA                                         
										 )
								 VALUES (
                                            vPlanta,
                                            vEjercici,
                                            vCodinspe,
                                            Secudefe,
                                            Numrevis,
                                            Numlinea,
                                            Numzona,
                                            Caddefec,
                                            Califdef,
                                            Ubicadef,
                                            OtrosDef,
                                            NULL, --OBSERVAC,
                                            TO_DATE(vFechalta,'DD/MM/YYYY') 
										);
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END DATINSPEVI;        

PROCEDURE DIMENSIONESVEHICULOS ( 
                                 Planta IN VARCHAR2,    Ejercici IN VARCHAR2,   Codinspe IN VARCHAR2,
                                 Codvehic IN VARCHAR2,  Largo IN VARCHAR2,      Alto IN VARCHAR2,
                                 Ancho IN VARCHAR2,     Tara IN VARCHAR2,       PesoBruto IN VARCHAR2,
                                 Fecha IN VARCHAR2 
                                ) 
   IS
   
    EXISTE VARCHAR2(2);
    vFecha VARCHAR2(12);
	vPlanta VARCHAR2(3);
	vCodinspe VARCHAR2(12);
	vCodvehic VARCHAR2(12);
	vEjercici VARCHAR2(4);

   BEGIN

    vPlanta:=Planta;
    vCodinspe:=Codinspe;
    vEjercici:=Ejercici;
    vCodvehic:=Codvehic;
    vFecha:=TO_CHAR(TO_DATE(Fecha, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido
   
   SELECT COUNT(*) INTO EXISTE FROM DIMENSIONES_VEHICULOS 
	WHERE Ejercici = vEjercici
      AND Codinspe = vCodinspe
      AND Codvehic = vCodvehic
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
    INSERT INTO DIMENSIONES_VEHICULOS (
                                            PLANTA,
                                            CODINSPE,
                                            EJERCICI,
                                            CODVEHIC,
                                            LARGO,
                                            ALTO,
                                            ANCHO,
                                            TARA,
                                            PESOBRUTO,
                                            FECHA
										   )
								 VALUES (
                                            vPlanta,
                                            vCodinspe,
                                            vEjercici,                                            
                                            vCodvehic,
                                            Largo,--REPLACE(Largo,',','.'),
                                            Alto,--REPLACE(Alto,',','.'),
                                            Ancho,--REPLACE(Ancho,',','.'),
                                            Tara,--REPLACE(Tara,',','.'),
                                            PesoBruto,--REPLACE(PesoBruto,',','.'),
                                            TO_DATE(vFecha,'DD/MM/YYYY') 
										);
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END DIMENSIONESVEHICULOS; 

PROCEDURE VEHICOMNIBUS ( 
                         Planta IN VARCHAR2,    Codvehic IN VARCHAR2,   Cantasientos IN VARCHAR2,   
                         Banio IN VARCHAR2,     Cantpuertas IN VARCHAR2,    Aireacondicionado IN VARCHAR2,
                         Codtiposientos IN VARCHAR2,    Codtipobodega IN VARCHAR2,  Codcategoriaservicio IN VARCHAR2,
                         Accesibilidad IN VARCHAR2, Codmarcacarroceria IN VARCHAR2, 
                         CODTIPOSERVICIO IN VARCHAR2, CODTIPOSUBSERVICIO  IN VARCHAR2                       
                        )
   IS
   
    EXISTE VARCHAR2(2);
	vPlanta VARCHAR2(3);
	vCodvehic VARCHAR2(12);

   BEGIN

    vPlanta:=Planta;
    vCodvehic:=Codvehic;
    
   SELECT COUNT(*) INTO EXISTE FROM VEHICOMNIBUS_TMOP 
	WHERE Codvehic = vCodvehic
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
    INSERT INTO VEHICOMNIBUS_TMOP (
                                    PLANTA,
                                    CODVEHIC,
                                    CANTASIENTOS,
                                    BANIO,
                                    CANTPUERTAS,
                                    AIREACONDICIONADO,
                                    CODTIPOASIENTOS,
                                    CODTIPOBODEGA,
                                    CODCATEGORIASERVICIO,
                                    ACCESIBILIDAD,
                                    CODMARCACARROCERIA,
                                    CODTIPOSERVICIO,
                                    CODTIPOSUBSERVICIO
                                   )
                         VALUES (
                                    vPlanta,
                                    vCodvehic,
                                    Cantasientos,
                                    Banio,
                                    Cantpuertas,
                                    Aireacondicionado,
                                    Codtiposientos,
                                    Codtipobodega,
                                    Codcategoriaservicio,
                                    Accesibilidad,
                                    Codmarcacarroceria,
                                    CODTIPOSERVICIO,
                                    CODTIPOSUBSERVICIO
                                );
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END VEHICOMNIBUS;    

PROCEDURE TINSPDEFECT ( 
                         Planta IN VARCHAR2,    Ejercici IN VARCHAR2,   Codinspe IN VARCHAR2,   Secdefec IN VARCHAR2,
                         Localiza IN VARCHAR2,  Caddefec IN VARCHAR2,   Calidef IN VARCHAR2,    Valormed IN VARCHAR2,
                         Fechalta IN VARCHAR2                        
                        )
   IS
   
    EXISTE VARCHAR2(2);
    vFecha VARCHAR2(12);
	vPlanta VARCHAR2(3);
	vCodinspe VARCHAR2(12);
	vEjercici VARCHAR2(4);

   BEGIN

    vPlanta:=Planta;
    vCodinspe:=Codinspe;
    vEjercici:=Ejercici;
    vFecha:=TO_CHAR(TO_DATE(Fechalta, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido
    
   SELECT COUNT(*) INTO EXISTE FROM TINSPDEFECT 
	WHERE Codinspe = vCodinspe
      AND Ejercici = vEjercici
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
    INSERT INTO TINSPDEFECT (
                                    PLANTA,
                                    EJERCICI,
                                    CODINSPE,
                                    SECDEFEC,
                                    LOCALIZA,
                                    CADDEFEC,
                                    CALIFDEF,
                                    VALORMED,
                                    FECHALTA
                                   )
                         VALUES (
                                    vPlanta,
                                    vEjercici,
                                    vCodinspe,
                                    Secdefec,
                                    Localiza,
                                    Caddefec,
                                    Calidef,
                                    Valormed,
                                    TO_DATE(vFecha,'DD/MM/YYYY')                                    
                                );
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END TINSPDEFECT;
   
PROCEDURE VEHICCARGA ( 
                        Planta IN VARCHAR2,    Codvehic IN VARCHAR2,   Longitudenganche IN VARCHAR2,
                        Codtipocajacarga IN VARCHAR2,  Codtipocabina IN VARCHAR2,  Codtipocarga IN VARCHAR2,
                        Codtipoaditamento IN VARCHAR2                     
                     )
   IS
   
    EXISTE VARCHAR2(2);
	vPlanta VARCHAR2(3);
	vCodvehic VARCHAR2(12);

   BEGIN

    vPlanta:=Planta;
    vCodvehic:=Codvehic;
    
   SELECT COUNT(*) INTO EXISTE FROM VEHICCARGA 
	WHERE Codvehic = vCodvehic
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
    INSERT INTO VEHICCARGA (
                                    PLANTA,
                                    CODVEHIC,
                                    LONGITUDENGANCHE,
                                    CODTIPOCAJACARGA,
                                    CODTIPOCABINA,
                                    CODTIPOCARGA,
                                    CODTIPOADITAMENTO
                                   )
                         VALUES (
                                    vPlanta,
                                    vCodvehic,
                                    REPLACE(Longitudenganche,',','.'),
                                    Codtipocajacarga,
                                    Codtipocabina,
                                    Codtipocarga,
                                    Codtipoaditamento
                                );
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END VEHICCARGA;     

PROCEDURE TCLIENTES ( 
                        Planta IN VARCHAR2,     Codclien IN VARCHAR2,       Tipodocu IN VARCHAR2,
                        Document IN VARCHAR2,   TipoclienteID IN VARCHAR2,  Fechalta IN VARCHAR2,
                        Nombre IN VARCHAR2,     Apellid1 IN VARCHAR2,       Codparti IN VARCHAR2, 
                        Tiptribu IN VARCHAR2,   Creditcl IN VARCHAR2,       Codposta IN VARCHAR2,       
                        Telefono IN VARCHAR2,   Apellid2 IN VARCHAR2,       Localida IN VARCHAR2,
                        Direccio IN VARCHAR2,   Nrocalle IN VARCHAR2,       Piso IN VARCHAR2,           
                        Depto IN VARCHAR2,      Idlocalidad IN VARCHAR2,    CodArea IN VARCHAR2,    
                        Celular IN VARCHAR2,    Mail IN VARCHAR2,           Idpais IN VARCHAR2,
                        Coddocu IN VARCHAR2,    Iddepartamento IN VARCHAR2, Dvdocument IN VARCHAR2, 
                        Profesional IN VARCHAR2                     
                     )
   IS
   
    EXISTE VARCHAR2(2);
    vFecha VARCHAR2(12);
	vPlanta VARCHAR2(3);
	vCodclien VARCHAR2(12);

   BEGIN

    vPlanta:=Planta;
    vCodclien:=Codclien;
    vFecha:=TO_CHAR(TO_DATE(Fechalta, 'YYYY-MM-DD'), 'DD/MM/YYYY'); --Convierto el formato de entrada a un formato de fecha valido
    
   SELECT COUNT(*) INTO EXISTE FROM TCLIENTES 
	WHERE Codclien = vCodclien
	  AND PLANTA = vPlanta;
   
	IF (EXISTE = 0) THEN
      
    INSERT INTO TCLIENTES (
                                    PLANTA,
                                    CODCLIEN,
                                    TIPODOCU,
                                    DOCUMENT,
                                    TIPOCLIENTE_ID,
                                    FECHALTA,
                                    NOMBRE,
                                    APELLID1,
                                    CODPARTI,
                                    TIPFACTU,
                                    TIPTRIBU,
                                    CREDITCL,
                                    FORM_576,
                                    CODPOSTA,
                                    FECMOROS,
                                    TELEFONO,
                                    LOCALIDA,
                                    APELLID2,
                                    DIRECCIO,
                                    HABILITACION,
                                    NROCALLE,
                                    PISO,
                                    DEPTO,
                                    IDLOCALIDAD,
                                    EXENTO_IIBB,
                                    NRO_IIBB,
                                    COD_AREA,
                                    CELULAR,
                                    MAIL,
                                    IDPAIS,
                                    CODDOCU,
                                    IDDEPARTAMENTO,
                                    DVDOCUMENT,
                                    PROFESIONAL
                                    
                                   )
                         VALUES (
                                    vPlanta,
                                    vCodclien,
                                    Tipodocu,
                                    Document,
                                    TipoclienteID,
                                    TO_DATE(vFecha,'DD/MM/YYYY'),
                                    Nombre,
                                    Apellid1,
                                    Codparti,
                                    NULL, --TIPFACTU
                                    Tiptribu,
                                    Creditcl,
                                    NULL, --FORM_576
                                    Codposta,
                                    NULL, --FECMOROS
                                    Telefono,
                                    Localida,
                                    Apellid2,
                                    Direccio,
                                    NULL, --HABILITACION
                                    Nrocalle,
                                    Piso,
                                    Depto,
                                    Idlocalidad,
                                    NULL, --EXENTO_IIBB
                                    NULL, --NRO_IIBB
                                    CodArea,
                                    Celular,
                                    Mail,
                                    Idpais,
                                    Coddocu,
                                    Iddepartamento,                                   
                                    Dvdocument,
                                    Profesional
                                );
			COMMIT;				
    END IF;
      
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RAISE_APPLICATION_ERROR (-20015, 'NO SE ENCONTRARON DATOS ');
      WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR (-20015, 'Se ha producido un error al intentar ejecutar  por: ' || SQLERRM);
   END TCLIENTES;         
  
END;
/
