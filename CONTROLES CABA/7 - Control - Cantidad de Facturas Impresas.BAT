@echo off 

color 0A
ECHO ===========================================
ECHO ### Control - Cantidad de Facturas y NC ### 
ECHO		  Para Salir Ingrese "." 
ECHO ===========================================

REM Listar las carpetas del directorio
REM DIR \\10.54.3.3\fc-elect\ /D

REM Conecta Disco Virtual
SUBST V: \\10.54.3.3\fc-elect\
SUBST S: \\10.54.4.3\fc-elect\

:INICIO
SET /P FECHA=Fecha:
SET "PERIODO=%FECHA%"

IF "%PERIODO%" == "." GOTO SALIR
IF "%PERIODO%" == "%FECHA%" GOTO BUSCAR

:BUSCAR
set "ContarFactVS=%ContarFactVS*=%"
set "ContarFactSM=%ContarFactSM*=%"
set "ContarNCVS=%ContarNCVS*=%"
set "ContarNCSM=%ContarNCSM*=%"

for %%x in (V:\%PERIODO%\Fact*ORIGINAL.PDF) do ( 
	set file[!ContarFactVS!]=%%~nfx  
	set /a ContarFactVS+=1 
) 
for %%x in (S:\%PERIODO%\Fact*ORIGINAL.PDF) do ( 
	set file[!ContarFactSM!]=%%~nfx 
	set /a ContarFactSM+=1 
) 

for %%x in (V:\%PERIODO%\NC*ORIGINAL.PDF) do ( 
	set file[!ContarNCVS!]=%%~nfx 
	set /a ContarNCVS+=1 
) 
for %%x in (S:\%PERIODO%\NC*ORIGINAL.PDF) do ( 
	set file[!ContarNCSM!]=%%~nfx 
	set /a ContarNCSM+=1 
)

ECHO ===========================================
ECHO ### Facturas Encontradas VS: %ContarFactVS% 
ECHO ### Facturas Encontradas SM: %ContarFactSM% 
ECHO ### Notas de Credito Encontradas VS: %ContarNCVS% 
ECHO ### Notas de Credito Encontradas SM: %ContarNCSM% 
ECHO ===========================================

REM Listar los archivos PDF encontrados
REM set /a index=%ContarFactVS%-1 
REM for /L %%i in (0,1,%index%) do ( 
REM  	echo !file[%%i]! 
REM )

GOTO INICIO

:SALIR
REM Desconecta Disco Virtual
SUBST /D V:
SUBST /D S:
EXIT

