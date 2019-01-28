unit UUtils;
{ Utilidades generales }

interface

   uses
      Classes, SqlExpr, StdCtrls, ExtCtrls, DBCtrls, Forms, speedbar, comctrls, buttons, ToolEdit,
      dateutil, RxLookup, qrctrls, db, UCEdit, Graphics, uStockEstacion;


   procedure DeleteTable(const aBD: TSqlconnection; const sTable: string);
   procedure LoockAndDeleteTable (const aBD: TSqlconnection; const sTable : string);
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
   procedure AbrirTabla (UnaTabla : TSqlDataSet);
   // Devuelve en qué posición del combo box se encuentra NombreTipo
   function Devolver_Posicion_ComboBox (Elementos: TStrings; NumElem: integer; NombreTipo: string):integer;
   procedure Combo_ConTeclas (Combo: TComboBox; var Tecla: word);


   function ExisteRegistro (UnaTabla : TSqlDataSet; UnasColumnas : string; UnosValores : Variant) : boolean;

   // Devuelve una cadena con ceros a la izquierda
   function FormatoCeros (anumero: integer; acantidad: integer):string;

   procedure ActivarFondo(Modo: Boolean; pdatos: TPanel; DBENombre: TDBEdit);
   procedure ActivarComponentes(Modo: boolean; formulario: TForm; atag:ttagset);
   procedure MostrarComponentes(Modo: boolean; formulario: TForm; atag:ttagset);
   function  directorio(aDire:string):string;
   function  IntervalDatesOk(afecini, afecfin: tdatetime) : boolean;
   // Devuelve la fecha de inicio para las estadísticas (6 meses antes de la fecha actual)
   function FechaInicio(const Mes,Ano:integer):string;
   function DevuelveUsuario(aBD: TSqlConnection):string;
   function devuelvecolor(serie: integer):tcolor;
   //Devuelve el mes en letras de una fecha
   function MesLetras(aFecha: string):string;
   //Devuelve el mes y año de una fecha, pudiendo sumarle o restarle años (aAno)
   function PoneFecha(aDesde, aHasta: string; aAno: integer): string;

implementation

   uses
      SysUtils,
      Printers,
      QrPrnTr,
      UCDIALGS,
      Windows, Messages,
      GLOBALS;

      
   const
       PRIMER_ANIO_SIGLO20 = 70; { El 1er. año del siglo XX a tener en cuenta es 1970 }
       ULTIMO_ANIO_SIGLO20 = 99; { El último año del siglo XX a tener en cuenta es 1999 }

   resourcestring
       CARACTER_REVERIFICACION = 'R';
       PUNTO = '.';
       COMA = ',';

       FICHERO_ACTUAL = 'UUtils';

(*
   function Devolver_Porcentaje (const fCantidad, fPorcen: double): double;
   begin
       Result := (fCantidad * fPorcen)/100;
   end;
*)
   procedure DeleteTable(const aBD: TSqlConnection; const sTable: string);
   begin
       with TsqlQuery.Create(nil) do
       try
           SqlConnection := aBD;
           SQL.Add(Format('DELETE %s',[sTable]));
           ExecSQL;                   
           Close;
       finally
           Application.ProcessMessages;
           Free
       end
   end;

   procedure LoockAndDeleteTable (const aBD: TSqlConnection; const sTable : string);
   begin
       with TsqlQuery.Create(nil) do
       try
           SqlConnection := aBD;
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


   { Hay que tener cuidado por si el usuario quiere salir del form pulsando
     Alt+F4, en cuyo caso habrá que asociar dicha combinación de teclas con
     el código del evento asociado al pulsar el botón de Cancelar }
   function Ha_Pulsado_AltF4 (EstadoShift:TShiftState ; TPulsada: Word): boolean;
   begin
      Result := ((EstadoShift = [ssAlt]) and (TPulsada = VK_F4));
   end;

   procedure AbrirTabla (UnaTabla : TSqlDataSet);
   begin
     try
       UnaTabla.Open;
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

function ExisteRegistro (UnaTabla : TSqlDataSet; UnasColumnas : string; UnosValores : Variant) : boolean;
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
    if length(nrocuit) < 11 then
    begin
      result := False;
      exit;
    end;
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
//        showmessage('Error de Validación', 'El número de CUIT/CUIL no es válido');
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

procedure ActivarComponentes(Modo: boolean; formulario: TForm; atag: ttagset);
var i:integer;
begin
  for i := 0 to formulario.ComponentCount-1 do
  begin
    if (formulario.Components[i].Tag in atag) then
    begin
       if (formulario.Components[i] is TColorEdit) then
           TColorEdit(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TSpeedBar) then
           TSpeedBar(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TSpeedItem) then
           TSpeedItem(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TQRLabel) then
           TQRLabel(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TQRExpr) then
           TQRExpr(formulario.Components[i]).enabled := Modo
       else if (formulario.Components[i] is TQRShape) then
           TQRShape(formulario.Components[i]).enabled := Modo

    end;
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
       else if (formulario.Components[i] is TEdit) then
           TEdit(formulario.Components[i]).visible := Modo;
    end;
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

function DevuelveUsuario(aBD: TSqlConnection):string;
var ind,largo:integer;
begin
  ind:=Pos('=',aBD.params[0]);
  largo:=length(aBD.params[0]);
  result := copy(aBD.params[0],ind+1,largo-ind);
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
  with tSQLquery.Create(nil) do
    try
      SqlConnection := mybd;
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
