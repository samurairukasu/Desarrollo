unit UUtils;
{ Utilidades generales }

interface

   uses
      Classes, SQLExpr, StdCtrls, forms, buttons, DBCtrls, RXDBCtrl, UCEdit, uSagEstacion,
      speedbar, comctrls,ExtCtrls, ToolEdit, RxLookup, quickrpt, qrctrls, dbclient,
      UVaryConst, graphics, dateutil;


   procedure DeleteTable(const aBD: tSQLConnection; const sTable: string);
   procedure LoockAndDeleteTable (const aBD: tSQLConnection; const sTable : string);
   function ConviertePuntoEnComa (const s: string): string;
   function ConvierteComaEnPunto (const s: string): string;
   // Devuelve True si el usuario ha introducido la fecha en un formato correcto
   function FechaCorrecta (F: string): boolean;
   function HoraCorrecta (H: string): boolean;
   // Devuelve True si sF1 es anterior a sF2
   function EsFechaMenor (sF1, sF2: string): boolean;
   // True si dH1 es menor o igual que dH2
   function Es_Hora_Menor (dH1, dH2: tDateTime): boolean;
   // True si es número real o entero
   function Es_Numero(sCadena: string): boolean;
   // Se pone el backslash en el directorio si no lo tiene
   function PonerBackSlash (const s : string) : string;
   { Hay que tener cuidado por si el usuario quiere salir del form pulsando
     Alt+F4, en cuyo caso habrá que asociar dicha combinación de teclas con
     el código del evento asociado al pulsar el botón de Cancelar }
   function Ha_Pulsado_AltF4 (EstadoShift:TShiftState ; TPulsada: Word): boolean;

   //   procedure AbrirTabla (UnaTabla : tClientDataSet);  { TODO -oran -cconsultas : esta bien asi??? }

   procedure AbrirTabla (UnaTabla : tClientDataSet);
   // Devuelve en qué posición del combo box se encuentra NombreTipo
   function Devolver_Posicion_ComboBox (Elementos: TStrings; NumElem: integer; NombreTipo: string):integer;
   procedure Combo_ConTeclas (Combo: TComboBox; var Tecla: word);
   // Devuelve True si el nº oblea se ha introducido correctamente, es decir, si el formato es dd-dddddd
   function ExisteRegistro (UnaTabla : tClientDataSet; UnasColumnas : string; UnosValores : Variant) : boolean;

   // Devuelve una cadena con ceros a la izquierda
   function FormatoCeros (anumero: integer; acantidad: integer):string;
   // Funciones que muestran o activan 1 o varios componentes
   procedure ActivarFondo(Modo: Boolean; pdatos: TPanel; DBENombre: TDBEdit);
   procedure ActivarComponentes(Modo: boolean; formulario: TForm; atag:ttagset);
   procedure MostrarComponentes(Modo: boolean; formulario: TForm; atag:ttagset);
   function  directorio(aDire:string):string;
   function  IntervalDatesOk(afecini, afecfin: tdatetime) : boolean;
   // Devuelve la fecha de inicio para las estadísticas (6 meses antes de la fecha actual)
   function FechaInicio(const Mes,Ano:integer):string;
   function DevuelveUsuario(aBD: Tsqlconnection):string;
   function devuelvecolor(serie: integer):tcolor;
   //Devuelve el mes en letras de una fecha
   function MesLetras(aFecha: string):string;
   function PoneFecha(aDesde, aHasta: string; aAno: integer): string;

implementation

   uses
      SysUtils,
//      Forms,
      Printers,
      QrPrnTr,
      UCDIALGS,
//      ULOGS,
      DB,
      Windows, Messages, globals;

      
   const
       PRIMER_ANIO_SIGLO20 = 70; { El 1er. año del siglo XX a tener en cuenta es 1970 }
       ULTIMO_ANIO_SIGLO20 = 99; { El último año del siglo XX a tener en cuenta es 1999 }

   resourcestring
       CARACTER_REVERIFICACION = 'R';
       PUNTO = '.';
       COMA = ',';

       FICHERO_ACTUAL = 'UUtils';

       MSJ_COM_IMPRBUSY = 'Lo siento pero la impresora se encuentra recibiendo un nuevo trabajo de impresión';
       MSJ_COM_ERRORIMPR = 'Lo siento pero la impresora no está preparada para aceptar nuevos trabajos de impresión. Verifique que la impresora funcione correctamente';
       MSJ_ENTDTCOM_IMPRESOCUP = 'Lo siento pero la impresora está ocupada recibiendo y/o imprimiendo un trabajo. Por favor, inténtelo de nuevo.';


(*
   function Devolver_Porcentaje (const fCantidad, fPorcen: double): double;
   begin
       Result := (fCantidad * fPorcen)/100;
   end;
*)
   procedure DeleteTable(const aBD: tSQLConnection; const sTable: string);
   begin
       with TsqlQuery.Create(application) do
       try
           SQLConnection := aBD;
           SQL.Add(Format('DELETE %s',[sTable]));
           ExecSQL;
           Close;
       finally
           Application.ProcessMessages;
           Free
       end
   end;

   procedure LoockAndDeleteTable (const aBD: tSQLConnection; const sTable : string);
   begin
       with TsqlQuery.Create(application) do
       try
           SQLConnection := aBD;

           Sql.Add (Format('LOCK TABLE %s IN EXCLUSIVE MODE NOWAIT',[sTable]));
           ExecSQL;
           Close;
       finally
           Application.ProcessMessages;
           Free
       end;
       DeleteTable(aBD, sTable)
   end;

   function ConviertePuntoEnComa (const s: string): string;
   begin
       { una o dos cifras decimales }
       if (Pos(PUNTO, s) = 0) then { Es un nº entero }
          Result := s
       else if (Pos(PUNTO, s) = Length (s)-2) then
          Result := copy (s, 1, length(s)-3) + COMA + copy (s, pos (punto,s)+1, length(s))
       else if (Pos(PUNTO, s) = Length (s)-1) then
          Result := copy (s, 1, length(s)-2) + COMA + copy (s, pos (punto,s)+1, length(s))
   end;


   function ConvierteComaEnPunto (const s: string): string;
   begin
       { una o dos cifras decimales }
       if (Pos(COMA, s) = 0) then { Es un nº entero }
          Result := s
       else if (Pos(COMA, s) = Length (s)-2) then
          Result := copy (s, 1, length(s)-3) + PUNTO + copy (s, pos (COMA,s)+1, length(s))
       else if (Pos(COMA, s) = Length (s)-1) then
          Result := copy (s, 1, length(s)-2) + PUNTO + copy (s, pos (COMA,s)+1, length(s))
   end;

(*
   function Es_NumeroReal_Valido (Cadena: string): boolean;
   { Devuelve True si Cadena puede pasarse a número real }
   var
      fNumero: double;
      CodigoError: integer;

   begin
       {$IFDEF TRAZAS}
         //FTrazas.PonAnotacionFmt (TRAZA_FLUJO, 8, FICHERO_ACTUAL, 'Entrada en Es_NumeroReal_Valido %s', [Cadena]);
       {$ENDIF}
       Val (Cadena, fNumero, CodigoError);
       Result := (CodigoError = 0);
       {$IFDEF TRAZAS}
         //FTrazas.PonAnotacion (TRAZA_FLUJO, 9, FICHERO_ACTUAL, 'Salida de Es_NumeroReal_Valido');
       {$ENDIF}
   end;
*)

   // Devuelve True si el usuario ha introducido la fecha en un formato correcto
   function FechaCorrecta (F: string): boolean;
   begin { de FechaCorrecta }
       try
          StrToDate (F);
          Result := True;
       except
          on E:Exception do
          begin
              Result := False;
          end;
       end;
   end; { de FechaCorrecta }


   function HoraCorrecta (H: string): boolean;
   { Devuelve True si el usuario ha introducido la fecha en un formato correcto }
   begin { de HoraCorrecta }
       try
          StrToTime (H);
          Result := True;
       except
          on E:Exception do
          begin
              Result := False;
          end;
       end;
   end; { de HoraCorrecta }


   function Es_Hora_Menor (dH1, dH2: tDateTime): boolean;
   begin
       Result := (dH1 <= dH2);
   end;

   function Es_Numero(sCadena: string): boolean;
   begin
       Result := False;
       try
          StrToFloat(sCadena);
          Result := True;
       except
           on E:Exception do;
       end;
   end;

   // Se pone el backslash en el directorio si no lo tiene
   function PonerBackSlash (const s : string) : string;
   begin
     if s[length(s)] <> '\' then result := s + '\'
     else result := s;
   end;

   // Devuelve True si la impresora está lista para imprimir un informe
   function ImpresoraPreparada_ImprimirInformes: boolean;
   const
      NUM_REINTENTOS_INFORME = 20;  { Máximo número de reintentos para imprimir un
                                     informe }
   var
     iNumReintentos, iContador: integer; { actúan a modo de índices }

     {$IFDEF TRAZAS}
       sEstadoImpresora: string;
     {$ENDIF}

   begin
       Result := False;
       iNumReintentos := 0;
       try
       {mar-compila}
           repeat
                inc (iNumReintentos);
                if (iNumReintentos <> 1) then
                begin
                    for iContador := 1 to 1000 do; { bucle de retardo }
                end;
                {$IFDEF TRAZAS}
                    FTrazas.PonAnotacion (TRAZA_BUCLES,4,FICHERO_ACTUAL,'Reintento ' + inttostr(iNumReintentos));
                    sEstadoImpresora := '';

                    if (QRPrinter.Status = mpBusy) then
                       sEstadoImpresora := 'Impresora Ocupada'
                    else if (QRPrinter.Status = mpFinished) then
                       sEstadoImpresora := 'Se ha finalizado un trabajo'
   (*                 else if (QRPrinter.Status = mpPrinting) then
                       sEstadoImpresora := 'Se está enviando un trabajo a la impresora'
                    else if (QRPrinter.Status = mpPreviewing) then
                       sEstadoImpresora := 'Está activo un preview'*)
                    else if (QRPrinter.Status = mpReady) then
                       sEstadoImpresora := 'Impresora preparada para aceptar nuevos trabajos'
                    else if (Printer.Printing) then
                       sEstadoImpresora := 'Impresora imprimiendo';

                    FTrazas.PonAnotacion (TRAZA_BUCLES,5,FICHERO_ACTUAL,'  Estado: ' + sEstadoImpresora);
                {$ENDIF}
           until (((QRPrinter.Status = mpReady) and (not Printer.Printing)) or (iNumReintentos = NUM_REINTENTOS_INFORME));
           if ((QRPrinter.Status = mpReady) and (not Printer.Printing)) then
              Result := True
           else
              MessageDlg ('Impresión', MSJ_ENTDTCOM_IMPRESOCUP, mtInformation,[mbOk], mbOk, 0)
       except
            on E:Exception do
//               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,17,FICHERO_ACTUAL,'Error en ImpresoraPreparada_ImprimirInformes: ' + E.Message);
       end;
   end;

   // Muestra al usuario un mensaje de error porque la impresora NO puede imprimir en el Mantenimiento
   procedure Lanzar_ErrorImpresion_Mantenimiento;
   const
       CABECERA_IMPRESION = 'Impresión';

   begin
       {mar-compila}
       if (QRPrinter.Status = mpBusy) then
       begin
           MessageDlg (CABECERA_IMPRESION, MSJ_COM_IMPRBUSY, mtInformation, [mbOk],mbOk, 0);
       end
   (*    else if (QRPrinter.Status = mpPrinting) then
       begin
           MessageDlg (CABECERA_IMPRESION, MSJ_COM_PRINTING, mtInformation, [mbOk],mbOk, 0);
       end*)
       else
       begin
           MessageDlg (CABECERA_IMPRESION, MSJ_COM_ERRORIMPR, mtInformation, [mbOk],mbOk, 0);
       end
   end;

   { Hay que tener cuidado por si el usuario quiere salir del form pulsando
     Alt+F4, en cuyo caso habrá que asociar dicha combinación de teclas con
     el código del evento asociado al pulsar el botón de Cancelar }
   function Ha_Pulsado_AltF4 (EstadoShift:TShiftState ; TPulsada: Word): boolean;
   begin
      Result := ((EstadoShift = [ssAlt]) and (TPulsada = VK_F4));
   end;

   procedure AbrirTabla (UnaTabla : TClientDataSet);
   begin
     try
       UnaTabla.Open;
       {$IFDEF TRAZAS}
         fTrazas.PonAnotacion(TRAZA_FLUJO,3,FICHERO_ACTUAL, 'ACTIVADA CORRECTAMENTE LA TABLA ' + UnaTabla.Name );
       {$ENDIF}
     except
       on E : Exception do
       begin
//         fAnomalias.PonAnotacion(TRAZA_SIEMPRE,5,FICHERO_ACTUAL, 'NO SE PUEDE ABRIR LA TABLA ' + UnaTabla.Name + ' : ' + E.message);
         raise;
       end;
     end;
   end;

   // Devuelve en qué posición del combo box se encuentra NombreTipo
   function Devolver_Posicion_ComboBox (Elementos: TStrings; NumElem: integer; NombreTipo: string):integer;
   var
      NumElementosCombo: integer; // var. auxi. que contiene el nº elementos del combo box Combo
      iContador: integer; // Actúa a modo de índice

   begin
       Result := -1;
       NumElementosCombo := NumElem-1;
       for iContador := 0 to NumElementosCombo do
         if (NombreTipo = Elementos[iContador]) then
         begin
             Result := iContador;
             break;
         end
   end;

   procedure Combo_ConTeclas (Combo: TComboBox; var Tecla: word);
   begin
       if (Boolean(SendMessage (Combo.Handle, CB_GETDROPPEDSTATE, 0, 0))) then
          SendMessage (Combo.Handle, CB_SHOWDROPDOWN, 0, 0)
       else
          SendMessage (Combo.Handle, CB_SHOWDROPDOWN, 1, 0);

       Tecla := 0;
   end;

   // Devuelve True si el nº oblea se ha introducido correctamente, es decir, si el formato es dd-dddddd
   function NumObleaCorrecto (sOblea: string): boolean;
   begin
       Result := False;
       try
          {$B-}
          Result := (Es_Numero(sOblea[1]) and Es_Numero(sOblea[2]) and (sOblea[3] = '-') and
                     Es_Numero(sOblea[4]) and Es_Numero(sOblea[5]) and Es_Numero(sOblea[6]) and
                     Es_Numero(sOblea[7]) and Es_Numero(sOblea[8]) and Es_Numero(sOblea[9])and
                     (Length(sOblea) = 9));
       except
            on E:Exception do
//               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,19,FICHERO_ACTUAL,Format ('%s %s %s', ['Error en NumObleaCorrecto:', E.Message,sOblea]));
       end;
   end;

   function NumObleaGNCCorrecto (sOblea: string): boolean;
   begin
       Result := False;
       try
          {$B-}
          Result := (Es_Numero(sOblea[1]) and Es_Numero(sOblea[2]) and Es_Numero(sOblea[3]) and
                     Es_Numero(sOblea[4]) and Es_Numero(sOblea[5]) and Es_Numero(sOblea[6]) and
                     Es_Numero(sOblea[7]) and Es_Numero(sOblea[8]) and
                     (Length(sOblea) >= 8));
       except
            on E:Exception do
//               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,19,FICHERO_ACTUAL,Format ('%s %s %s', ['Error en NumObleaCorrecto:', E.Message,sOblea]));
       end;
   end;


   { Dado un nº oblea con el formato aa-bbbbbb (siendo a y b dígitos) devuelve:
         - bbbbbb   si bbbbbb <= 999999 y
         - aabbbbbb si bbbbbb >  999999 }
   function Devolver_NumeroOblea (sOblea: string): integer;
   var
      iOblea_Inicio, iOblea_Fin: integer; { var. auxi. que almacenan los dos primeros
                                            y los 6 últimos dígitos del nº oblea,
                                            respectivamente }

   begin
       Result := 0;
       try
          iOblea_Inicio := StrToInt (Copy (sOblea,1,2));
          iOblea_Fin := StrToInt (Trim(Copy (sOblea,4,Length(sOblea))));
          if (iOblea_Inicio = 0) then
            Result := iOblea_Fin
          else
            Result := (iOblea_Inicio * 1000000) + iOblea_Fin
       except
            on E:Exception do
//               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,20,FICHERO_ACTUAL,Format ('%s %s %s', ['Error en Devolver_NumeroOblea:', E.Message,sOblea]));
       end;
   end;


   { Suma 1900 si el año está comprendido entre 70-99 y Suma 2000 si iAnio está
     comprendido entre 00-69. Devuelve 0 si se ha producido algún error }
   function Sumar_1900 (iAnio: integer): integer;
   begin
       Result := 0;
       try
          if (iAnio in [PRIMER_ANIO_SIGLO20..ULTIMO_ANIO_SIGLO20]) then
              Result := 1900 + iAnio
          else
              Result := 2000 + iAnio
       except
            on E:Exception do
//               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,9,FICHERO_ACTUAL,'Error en Sumar_1900: ' + E.Message);
       end;
   end;

   // Dado un nº con el formato: 96 00020003123456 devuelve 96 y dado 01 00020003123456 devuelve 2001
   function Obtener_Ejercicio (sNumInsp: string): integer;
   begin
       Result := 0;
       try
          Result := Sumar_1900 (StrToInt(Copy (sNumInsp, 1, 2)));
       except
            on E:Exception do
//               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,13,FICHERO_ACTUAL,'Error en Obtener_Ejercicio: ' + E.Message);
       end;
   end;

   // Dado un nº con el formato: 96 00020003123456 devuelve 123456
   function Obtener_NumeroInspeccion (sNumInsp: string): integer;
   begin
       Result := 0;
       try
          Result := StrToInt(Copy (sNumInsp, 12, 6));
       except
            on E:Exception do
//               FAnomalias.PonAnotacion (TRAZA_SIEMPRE,11,FICHERO_ACTUAL,'Error en Obtener_NumeroInspeccion: ' + E.Message);
       end;
   end;

   // Devuelve True si sF1 es anterior a sF2
   function EsFechaMenor (sF1, sF2: string): boolean;
   begin
       try
         Result := (StrToDate(sF1) <= StrToDate(sF2));
       except
            on E:Exception do
              Result := False;
       end;
   end;

function ExisteRegistro (UnaTabla : tClientDataSet; UnasColumnas : string; UnosValores : Variant) : boolean;
var
  bok : boolean;
begin
  bok := False;
  try
    try
      bOk := UnaTabla.Locate(UnasColumnas, UnosValores, [loCaseInsensitive]);
    except
      on E : Exception do begin
        bOk := False;
        //VarGlobs.bHayAlgunError := ERROR_VTV;
//        fAnomalias.PonAnotacion(TRAZA_SIEMPRE,7,FICHERO_ACTUAL, 'NO SE PUEDE BUSCAR EN ' + UnaTabla.Name + ': ' + E.message);
      end;
    end;
  finally
    result := bOk;
  end;
end;

function CuitCorrecto (nrocuit: string):boolean;
var i, suma, coeficiente, digito, control: integer;
    cadcuit: string;
begin

  while Pos('-', nrocuit) > 0 do
  delete(nrocuit,Pos('-', nrocuit),1);
  cadcuit := nrocuit;
  suma := 0;
  coeficiente := 2;
  try
    for i := 10 DownTo 1 do
    begin
      digito := strtoint(cadcuit[i]);
      suma := suma + digito * coeficiente;
      if coeficiente = 7 then
        coeficiente := 2
      else
        inc(coeficiente);
    end;
      control := 11 - (suma mod 11);

      if control = 11 then
        control := 0;

      result:= TRUE;
      if (strtoint(cadcuit[11]) <> control)then
      begin
        showmessage('Error de Validación', 'El número de CUIT/CUIL no es válido');
        result:= FALSE;
      end;
    except
      result:=false;
      raise Exception.Createfmt('Número de CUIT/CUIL: %s no es válido',[cadcuit]);
    end;
end;

function FormatoCeros (anumero: integer; acantidad: integer):string;
var aux:string;
    ceros,i: integer;
begin
  try
    ceros:= length(inttostr(anumero));
    if ceros > acantidad then
       raise exception.create('Error en la conversión de formato')
    else
    begin
       ceros:=acantidad-ceros;
       for i:= 1 to ceros do
         aux:=aux+'0';
       aux:=aux+inttostr(anumero);
       result:=aux;
    end;

  except
        Messagedlg('ERROR','Error en la conversión de formato',mtERROR,[mbok],mbok,0);

  end;

end;

procedure ActivarComponentes(Modo: boolean; formulario: TForm; atag: tTagSet);
var i:integer;
begin
  for i := 0 to formulario.ComponentCount-1 do
  begin
            if (formulario.Components[i].Tag in aTag) then
               TForm(formulario.Components[i]).Enabled := Modo;

  end;
end;

procedure MostrarComponentes(Modo: boolean; formulario: TForm; atag: ttagset);
var i:integer;
begin
  for i := 0 to formulario.ComponentCount-1 do
  begin
    if (formulario.Components[i].Tag in atag) then
    begin
       if (formulario.Components[i] is TLabel) then
           TLabel(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TProgressBar) then
           TProgressBar(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TBitBtn) then
           TBitBtn(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TDirectoryEdit) then
           TDirectoryEdit(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TBevel) then
           TBevel(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TRxDBLookupCombo) then
           TRxDBLookupCombo(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TCheckBox) then
           TCheckBox(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TPanel) then
           TPanel(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TQRLabel) then
           TQRLabel(formulario.Components[i]).visible := Modo
       else if (formulario.Components[i] is TDBDateEdit) then
           TDBDateEdit(formulario.Components[i]).visible := Modo;


    end;
  end;
end;

procedure MuevoComponentes(formulario: TForm; atag: ttagset; adelta: integer);
var i:integer;
begin
  for i := 0 to formulario.ComponentCount-1 do
  begin
    if (formulario.Components[i].Tag in atag) then
    begin
       if (formulario.Components[i] is TQRMemo) then
           TQRMemo(formulario.Components[i]).top := TQRMemo(formulario.Components[i]).top + adelta
       else if (formulario.Components[i] is Tqrshape) then
           Tqrshape(formulario.Components[i]).top := Tqrshape(formulario.Components[i]).top + adelta
       else if (formulario.Components[i] is Tqrlabel) then
           Tqrlabel(formulario.Components[i]).top := Tqrlabel(formulario.Components[i]).top + adelta;


    end;
  end;
end;

procedure HeightComponentes(formulario: TForm; atag: ttagset; adelta: integer);
var i:integer;
begin
  for i := 0 to formulario.ComponentCount-1 do
  begin
    if (formulario.Components[i].Tag in atag) then
    begin
       if (formulario.Components[i] is TQRBand) then
           TQRBand(formulario.Components[i]).Height := TQRBand(formulario.Components[i]).Height + adelta

    end;
  end;
end;


function DevuelveUsuario(aBD: tSQLConnection):string;
var ind,largo:integer;
begin
  ind:=Pos('=',aBD.Params.Values['User_Name']);
  largo:=length(aBD.Params.Values['User_Name']);
  result := copy(aBD.Params.Values['User_Name'],ind+1,largo-ind);
end;
procedure ActivarFondo(Modo: Boolean; pdatos: TPanel; DBENombre: TDBEdit);
begin
    pDatos.Visible:=Modo;
    if Modo
    then begin
        pDatos.BringToFront;
        if dbeNombre <> nil then
           DBEnombre.SetFocus;
    end;
end;
function directorio(aDire:string):string;
var posi:integer;
begin
  posi:=length(adire);
  if Pos('\', adire) = posi then
       delete(adire,Pos('\', adire),1);
  result:=adire;
end;

function IntervalDatesOk(afecini, afecfin:tdatetime) : boolean;
begin
    result :=  ValidDate(afecini) and ValidDate(afecfin) and (afecini <= afecfin)
end;

function FechaInicio(const Mes,Ano:integer):string;
begin
  if mes > 5 then result:='01/'+FormatoCeros(Mes-5,2)+'/'+inttostr(ano)+' 00:00:00'
  else
  begin
    result:='01/'+FormatoCeros(Mes+7,2)+'/'+inttostr(ano-1)+' 00:00:00';
  end;
end;

function devuelvecolor(serie: integer):tcolor;
begin
  case serie of
  1:begin
    result := clred;
  end;
  2:begin
    result := clblack;
  end;
  3:begin
    result := clgreen;
  end;
  4:begin
    result := clyellow;
  end;
  5:begin
    result := clfuchsia;
  end;
  6:begin
    result := clmaroon;
  end;
  7:begin
    result := clnavy;
  end;
  8:begin
    result := clpurple;
  end;
  else
  begin
    result := clteal;
  end;
  end;
end;
function MesLetras(aFecha: string):string;
begin
  with tsqlquery.Create(nil) do
    try
      SQLConnection := mybd;
      sql.add('alter session set nls_date_format = ''DD/MM/YYYY''');
      execsql;
      sql.Clear;
      sql.Add(format('SELECT TO_CHAR(TO_DATE(''%S''),''Month'') FROM DUAL',[aFecha]));
      open;
      result := TrimRight(fields[0].AsString);
    finally
      free;
    end;
end;

function PoneFecha(aDesde, aHasta: string;
      aAno: integer): string;
var
  auxDesde, auxHasta: string;
begin
  aDesde := datetimetostr(incyear(strtodatetime(aDesde),-aAno));
  aHasta := datetimetostr(incyear(strtodatetime(aHasta),-aAno));
  auxDesde:=MesLetras(aDesde)+' '+copy(aDesde,7,4);
  auxHasta:=MesLetras(aHasta)+' '+copy(aHasta,7,4);
  if auxDesde = auxHasta then
    result := auxDesde
  else
  begin
    if copy(aDesde,7,4) = copy(aHasta,7,4) then
      result := MesLetras(aDesde)+' / '+MesLetras(aHasta)+' '+ copy(aDesde,7,4)
    else
      result := auxDesde+' / '+auxHasta;
  end;
end;


end.
