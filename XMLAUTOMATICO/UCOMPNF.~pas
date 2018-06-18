unit UCompNF;
{ Sirve para comprobar el nº factura o de nota de crédito impreso que se va a
  almacenar en TFACTURAS. Este form se muestra a los clientes de crédito que no
  van a abonar en el momento la cantidad a pagar por la inspección realizada. }

{
  Ultima Traza: 14
  Ultima Incidencia: 5
  Ultima Anomalia: 3
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db, USAGCLASSES, FMTBcd, SqlExpr;


type
  TfrmComprobarNumFactReimp = class(TForm)
    Bevel1: TBevel;
    lblComprobarNF: TLabel;
    edtNumFactura: TEdit;
    btnAceptar: TBitBtn;
    qryConsultas: TSQLQuery;
    Bevel2: TBevel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtNumFacturaEnter(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
    NumeroEstacion: integer; // Número de la estación
    fFactura: TFacturacion;
    sTipoFactura: string;
    // -1 si no hay que cambiar el número de factura. Otro valor en caso contrario
    fNumeroFactura: integer;
    // -1 si no hay que cambiar el número de oblea. Otro valor en caso contrario
    fNumeroOblea: integer;
    fptoventa: tptoventa;

    function NumEstacionCorrecto (sNumFactura: string): boolean;
  //  function ExisteNumeroFactura_TFACTURAS (iNumFactura: integer; sTipo: string): boolean;
    function Componer_NumeroOblea (const iNumeroOblea: integer): string;
    function Devolver_NumeroOblea (sOblea: string): integer;

  public
    { Public declarations }
    property NumeroFactura: integer read fNumeroFactura write fNumeroFactura;
    property NumeroOblea: integer read fNumeroOblea write fNumeroOblea;

    constructor CreateFromComprobarFactura (aFactura: TFacturacion);
    constructor CreateFromComprobarNCredito (aFactura: TContrafacturas; aTipoFactura: string);
    constructor CreateFromComprobarNOblea (const iNumeroOblea: integer);
  end;

var
  frmComprobarNumFactReimp: TfrmComprobarNumFactReimp;

implementation

{$R *.DFM}

uses
    UCDIALGS,
    ULOGS,
    Globals,
    UINTERFAZUSUARIO,
    UUTILS,
    USAGESTACION,
    UReimpresion,
    ufOblInutilizad;


resourcestring
    LBL_NF = 'Número de factura impreso:';
    LBL_NC = 'Número de nota impreso:';
    LBL_OBLEA = 'Nº de oblea impreso:';
    FICHERO_ACTUAL = 'UCompNF';

    MSJ_SISTEMA_INESTABLE = 'Ha ocurrido un error grave en la base de datos. El sistema está inestable, con lo que deberá reiniciarlo de nuevo';
    MSJ_CAJA_NUMFACTMAYOR = 'No puede emitir una factura cuyo número sea mayor al que se ha indicado.';
    MSJ_NUMOBLEA_MODIFICADO = 'El número de oblea se ha modificado. ¿Está seguro de que quiere cambiarlo?';
    MSJ_NUMOBLEA_OBLEAMAL = 'El nº oblea del vehículo es incorrecto o no se encuentra almacenado. El formato correcto es: dd-dddddd';
    //MSJ_NUMOBLEA_OBLEAMAYOR = 'No puede emitir una oblea cuyo número sea mayor al que se ha indicado.';

    HNT_COMP_NF = 'Compruebe si el número de factura mostrada y la impresa coinciden';
    HNT_COMP_NC = 'Compruebe si el número de nota de crédito mostrada y la impresa coinciden';
    HNT_COMP_OBLEA = 'Compruebe si el número de oblea mostrada y la impresa coinciden';


    CABECERA_MENSAJES_NF = 'Comprobar Número Factura';
    CABECERA_MENSAJES_NC = 'Comprobar Número Nota Crédito';
    CABECERA_MENSAJES_OBLEA = 'Comprobar Número Oblea';

    MSJ_COMPNF_CAMBIARFACT = '¿Realmente desea cambiar el número de factura?';
    MSJ_CAJA_NUMFACTEXIST = 'Si desea cambiar el número de factura deberá poner ' +
                             'un número cuya factura no se haya emitido anteriormente. ' +
                             'Además debería cambiar el próximo número de factura en la ' +
                             'pantalla de DATOS VARIABLES.';
    MSJ_CAJA_NUMFACERR = 'No se ha introducido un nuevo número de factura o éste es incorrecto. Introdúzcalo de nuevo por favor.';
    MSJ_NUMOBLEA_OBLEA_NODISPONIBLE = 'El número de oblea ingresado no se encuentra disponible. '+#13#10+
                                      'El motivo puede ser que la oblea no se encuentre en la base de datos'+#13#10+
                                      'o que esa oblea se encuentre tomada por otro supervisor.';


var
   NumFacturaAuxiReimp: string; { Nº factura auxiliar }



constructor TfrmComprobarNumFactReimp.CreateFromComprobarFactura (aFactura: TFacturacion);
var ptoventa:integer;
begin
    inherited Create (Application);

    Self.Caption := CABECERA_MENSAJES_NF;
    LblComprobarNF.Caption := LBL_NF;
    edtNumFactura.Hint := HNT_COMP_NF;

    fFactura:=aFactura;
    try
       fNumeroFactura := -1;
       fptoventa:=nil;
       fptoventa:=tptoventa.Create(ffactura.DataBase);
       fptoventa.Open;
       ptoventa:=fptoventa.GetPtoVentaManual;
       NumFacturaAuxiReimp := Format ('%1.4d-%1.8d', [ptoventa,StrToInt(fFactura.ValueByName[FIELD_NUMFACTU])]);
    finally
       fptoventa.close;
       fptoventa.free;
    end;
    edtNumFactura.Text := NumFacturaAuxiReimp;
    sTipoFactura := fFactura.ValueByName[FIELD_TIPFACTU];
end;


constructor TfrmComprobarNumFactReimp.CreateFromComprobarNCredito (aFactura: TContrafacturas; aTipoFactura: string);
var ptoventa:integer;
begin
    inherited Create (Application);

    Self.Caption := CABECERA_MENSAJES_NF;
    LblComprobarNF.Caption := LBL_NC;
    edtNumFactura.Hint := HNT_COMP_NC;

    fFactura:=(aFactura as TFacturacion);
    try
       fNumeroFactura := -1;
       fptoventa:=nil;
       fptoventa:=tptoventa.Create(fFactura.Database);
       fptoventa.open;
       if aTipoFactura <> 'N' then
          ptoventa:=fptoventa.GetPtoVentaManual
       else
       begin
          ptoventa:=fptoventa.GetPtoVenta;
          edtNumFactura.enabled := False;
       end;
       NumFacturaAuxiReimp := Format ('%1.4d-%1.8d',[ptoventa,StrToInt(fFactura.ValueByName[FIELD_NUMFACTU])]);
    finally
       fptoventa.close;
       fptoventa.free;
    end;
    edtNumFactura.Text := NumFacturaAuxiReimp;
    sTipoFactura := aTipoFactura;
end;


constructor TfrmComprobarNumFactReimp.CreateFromComprobarNOblea (const iNumeroOblea: integer);
begin
    inherited Create (Application);

    Self.Caption := CABECERA_MENSAJES_OBLEA;
    LblComprobarNF.Caption := LBL_OBLEA;
    edtNumFactura.Hint := HNT_COMP_OBLEA;

    fNumeroOblea := -1;
    NumFacturaAuxiReimp := Componer_NumeroOblea (iNumeroOblea);
    edtNumFactura.Text := NumFacturaAuxiReimp;
end;


procedure TfrmComprobarNumFactReimp.FormKeyPress(Sender: TObject;
  var Key: Char);
begin
    if (Key = Chr(VK_RETURN)) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;


procedure TfrmComprobarNumFactReimp.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    qryConsultas.Close;
end;

procedure TfrmComprobarNumFactReimp.FormDestroy(Sender: TObject);
begin
    qryConsultas.Close;
end;

procedure TfrmComprobarNumFactReimp.FormCreate(Sender: TObject);
begin
    with qryConsultas do
    begin
        Close;
        SQLConnection := MyBD;
    end;
end;

// Dado un nº factura con formato: abcd-nnnnnnnn, devuelve True si abcd se corresponde con el nº de la estación
function TfrmComprobarNumFactReimp.NumEstacionCorrecto (sNumFactura: string): boolean;
begin
    try
       Result := (StrToInt(Copy (sNumFactura, 1, 4)) = NumeroEstacion);
    except
         on E:Exception do
         begin
             Result := False;
             FAnomalias.PonAnotacion (TRAZA_SIEMPRE,3,FICHERO_ACTUAL, 'Error en NumEstacionCorrecto: ' + E.Message);
         end;
    end;
end;


(*function TfrmComprobarNumFactReimp.ExisteNumeroFactura_TFACTURAS (iNumFactura: integer; sTipo: string): boolean;
begin
    Result := False;
    try
      with qryConsultas do
      begin
          Close;
          Sql.Clear;
          Sql.Add (Format ('SELECT %s FROM %s WHERE %s=%d AND %s=''%s''',[FIELD_NUMFACTU,DATOS_FACTURAS,FIELD_NUMFACTU,iNumFactura, FIELD_TIPFACTU,sTipo]));
          {$IFDEF TRAZAS}
            FTrazas.PonComponente (TRAZA_SQL,18,FICHERO_ACTUAL,qryConsultas);
          {$ENDIF}
          Open;
      end;
      Result := (qryConsultas.Fields[0].AsInteger <> 0);
      {$IFDEF TRAZAS}
        FTrazas.PonRegistro (TRAZA_REGISTRO,19,FICHERO_ACTUAL,qryConsultas);
      {$ENDIF}
    except
        on E:Exception do
           FAnomalias.PonAnotacion (TRAZA_SIEMPRE,6,FICHERO_ACTUAL,'Error en ExisteNumeroFactura_TFACTURAS: ' + E.Message);
    end;
end;
*)

procedure TfrmComprobarNumFactReimp.edtNumFacturaEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, False);
end;

function TfrmComprobarNumFactReimp.Componer_NumeroOblea (const iNumeroOblea: integer): string;
var
  sNumeroOblea: string; //var. auxi.

begin
    if (iNumeroOblea <= 999999) then
       Result := Format ('%1.2d-%1.6d',[0, iNumeroOblea])
    else
    begin
        sNumeroOblea := IntToStr (iNumeroOblea);
        Result := Format ('%1.2d-%1.6d',[
             StrToInt(Copy (sNumeroOblea,1,(Length(sNumeroOblea)-6))),
             StrToInt(Copy (sNumeroOblea,(Length(sNumeroOblea)-6)+1,Length(sNumeroOblea)))]);
    end
end;

function TfrmComprobarNumFactReimp.Devolver_NumeroOblea (sOblea: string): integer;
{ Dado un nº oblea con el formato aa-bbbbbb (siendo a y b dígitos) devuelve:
      - bbbbbb   si bbbbbb <= 999999 y
      - aabbbbbb si bbbbbb >  999999 }
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
            FAnomalias.PonAnotacion (TRAZA_SIEMPRE,20,FICHERO_ACTUAL,Format ('%s %s %s', ['Error en Devolver_NumeroOblea:', E.Message,sOblea]));
    end;
end;


procedure TfrmComprobarNumFactReimp.btnSalirClick(Sender: TObject);
begin
Close;
end;

procedure TfrmComprobarNumFactReimp.btnAceptarClick(Sender: TObject);
var
  iNumero_ACambiar, vOblea, vObleaNew,vEjercici, vInspeccion: String;
  fOblea, OldOblea: TOblea;
  fInspeccion: Tinspeccion;
begin
Self.Text := Trim (Self.Text);
if (LblComprobarNF.Caption = LBL_OBLEA) then
  begin
    try
      if (edtNumFactura.Text <> NumFacturaAuxiReimp) then
        try
          Screen.Cursor:=crHourGlass;
          vOblea:= Copy(NumFacturaAuxiReimp,1,2)+Copy(NumFacturaAuxiReimp,4,8);
          vObleaNew:= Copy(edtNumFactura.Text ,1,2)+Copy(edtNumFactura.Text ,4,8);

          fInspeccion:=TInspeccion.Create(MyBd,Format('WHERE NUMOBLEA = %s',[vOblea]));
          fInspeccion.Open;

          vEjercici := fInspeccion.ValueByName[FIELD_EJERCICI];
          vInspeccion := fInspeccion.ValueByName[FIELD_CODINSPE];

          fOblea:=TOblea.CreateByOblea(MyBd,vObleaNew);
          fOblea.Open;

          OldOblea:=TOblea.CreateByOblea(MyBd,vOblea);
          OldOblea.Open;

          if NumObleaCorrecto(edtNumFactura.Text) and fOblea.IsObleaDisponible then
            begin
              fOblea.TomarOblea;
              Screen.Cursor:=crDefault;
                if (MessageDlg (CABECERA_MENSAJES_OBLEA, MSJ_NUMOBLEA_MODIFICADO, mtInformation, [mbYes, mbNo], mbNo, 0) = mrYes) then
                  begin
                    Screen.Cursor:=crHourGlass;
                    fNumeroOblea := Devolver_NumeroOblea (edtNumFactura.Text);
                    fOblea.ConsumirOblea(DateTimeToStr(Now),vEjercici,vInspeccion);
                    {$IFDEF TRAZAS}
                    FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, ' SE CONSUMIO LA OBLEA: '+vObleaNew );
                    {$ENDIF}
                    OldOblea.InutilizarOblea(DateTimeToStr(Now));
                    {$IFDEF TRAZAS}
                    FTrazas.PonAnotacion (1,1, FICHERO_ACTUAL, ' SE INUTILIZO LA OBLEA '+vOblea);
                    {$ENDIF}
                  end
                else
                  begin
                    fOblea.LiberarOblea;
                    edtNumFactura.Text := NumFacturaAuxiReimp
                  end;
              end
          else
            begin
              Screen.Cursor:=crDefault;
              MessageDlg (CABECERA_MENSAJES_OBLEA, MSJ_NUMOBLEA_OBLEAMAL, mtInformation, [mbOk], mbOk, 0);
              edtNumFactura.Text := NumFacturaAuxiReimp;
              edtNumFactura.setfocus;
            end;
        finally
          Screen.Cursor:=crDefault;
          fOblea.Free;
          OldOblea.Free;
          fInspeccion.Free;
        end;
    except
      on E:Exception do
        FAnomalias.PonAnotacion (TRAZA_SIEMPRE,5,FICHERO_ACTUAL,'Error en edtNumeroObleaExit: ' + E.Message);
      end;
  end
else
    begin
        // Factura o nota de crédito
        { En principio no hay que comprobar que el nº factura asignado sea mayor
          o menor que el actual }
        //if (NumFacturaAuxiReimp > edtNumFactura.Text) then
        if (NumFacturaAuxiReimp <> edtNumFactura.Text) then
        begin
            if (Es_Numero (Copy (edtNumFactura.Text,6,8))) then
            begin
                iNumero_ACambiar :=  edtNumFactura.Text;
                if ((Caption = CABECERA_MENSAJES_NF) or (Caption = CABECERA_MENSAJES_NC)) then
                begin
                    if (MessageDlg (CABECERA_MENSAJES_NF,MSJ_COMPNF_CAMBIARFACT, mtConfirmation, [mbYes, mbNo], mbYes, 0) = mrYes) then
                    begin
                        if Not(fFactura.ValidateNumeroFactura(iNumero_ACambiar)) then
                        begin
                            MessageDlg (CABECERA_MENSAJES_NF, MSJ_CAJA_NUMFACTEXIST, mtInformation, [mbOk], mbOk,0);
                            {$IFDEF TRAZAS}
                              FTrazas.PonAnotacion (TRAZA_FLUJO,4,FICHERO_ACTUAL,'Se intenta poner un nº factura que ya existe en TFACTURAS');
                            {$ENDIF}
                            edtNumFactura.Text := NumFacturaAuxiReimp;
                            edtNumFactura.setfocus;
                        end
                        else
                        begin
                            fNumeroFactura := StrToInt((Copy (edtNumFactura.Text,6,8)));   
                        end;
                    end
                    else { TeclaPulsada = PULSADO_NO }
                    begin
                        edtNumFactura.Text := NumFacturaAuxiReimp;
                    end;
                    AtenuarControl (Sender, False);
                    btnAceptar.setfocus;
                end
            end
            else
            begin
                { No se ha introducido el nº factura o éste es incorrecto  }
                MessageDlg (CABECERA_MENSAJES_NF, MSJ_CAJA_NUMFACERR, mtInformation, [mbOk], mbOk,0);
                edtNumFactura.Text := NumFacturaAuxiReimp;
                edtNumFactura.Setfocus;
            end;
        end
        (*
        else if (NumFacturaAuxiReimp < edtNumFactura.Text) then
        begin
            MessageDlg (Caption, MSJ_CAJA_NUMFACTMAYOR, mtInformation, [mbOk], mbOk, 0);
            edtNumFactura.Text := NumFacturaAuxiReimp;
            edtNumFactura.Setfocus;
        end;
        *)
    end
end;


end.
