unit UReimpresion;
// Reimpresiones de Facturas, Notas de Crédito, Certificados e Informes de Inspección



interface
uses  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Db;
    //True si seng; desea reimprimir una factura y False si es una Nota de Crédito.
    procedure ReimpresionFacturasNCredito (const bEsFactura: boolean);
    //Reimpresión de un certificado
    procedure ReimpresionCertificados;
    //Reimprime un informe de inspección
    procedure ReimpresionInformesInspeccion;
//    procedure InspeccionesDiferidas;
    procedure ReimpresionTAmarilla;  //Reimprime una tarjeta amarilla
    procedure ReimpresionInformeGNC;  //Reimprime un Informe GNC
    procedure ReimpresionInformesMedicion;
    procedure ImprimirCertificado(sEjercici,sCodInsp,sMatricula: String);
    procedure Imprimirinmforme_cambio_oblea(sEjercici,sCodInsp,sMatricula: String);
    
function tiene_oblea_para_inutilizar(codfactura:longint): boolean;
implementation


uses
   UREIMPNC,
   UCOMPNF,
   UCDIALGS, ULOGS,
   USAGCLASSES,
   Globals,
   USAGESTACION,
   UREIMPCER,
   UCERTIFI,
   UINFORME,
   UTILORACLE,
   USAGVARIOS,
   UCTIMPRESION,
   UCLIENTE,
   UFTMP,
   ugacceso, ACCESO1, acceso,
   UFPagoConTarjeta,
   EPSON_impresora_Fiscal_TLB, ComObj,
   UUtils,
   uFMedicionesAutomaticas,
   uReimpTAmarilla, UCOMPNFGNC,uffactura,
    usuperregistry, SQLEXPR,UCONST, UUcontrola_de_impresion_nc,Utarjetas_nc_cf;



const
  { Constante que va a servir para indicar si en la tabla TINSPECCION se intenta
    recuperar un nº oblea que está vacío }
  NUM_OBLEA_ERROR = -1;


resourcestring
    FICHERO_ACTUAL = 'UReimpresion';

    CABECERA_MSJ_NOTA_EMITIDA = 'Nota Crédito Emitida';
    CABECERA_MENSAJES_REIMP_CERT = 'Reimpresión de Certificados';
    CABECERA_MENSAJES_REIMP_INF = 'Reimpresión de Informes Inspección';

    MSJ_UMAIN_INSPNOFIN = 'No se encuentra ningún vehículo con esa patente que haya finalizado la inspección';
    MSJ_UMAIN_INSPNOAPTA = 'El resultado de la inspección cuyo número de oblea se desea reimprimir ha sido RECHAZADA o BAJA';
    MSJ_UMAIN_NUMOBLEABLANCO = 'Lo siento pero al vehículo introducido NO se le ha asignado ningún número de oblea, con lo que NO se imprimirá su Certificado';




// Devuelve True si ha logrado enviar un trabajo correctamente al servidor de impresión
function EnviarTrabajo_ServidorImpresion (const sEjer, sCodInsp, sMatr: string; const aTrabajo: tTrabajo): boolean;
var
  dCabecera: tCabecera;

begin
    try
       with dCabecera do
       begin
           iEjercicio := StrToInt(sEjer);
           iCodigoInspeccion := StrToInt(sCodInsp);
           sMatricula := sMatr;
           Result := TrabajoEnviadoOk (dCabecera, aTrabajo);
          end;
    except
        on E:Exception do
        begin
            raise Exception.Create ('Error enviando un trabajo al servidor de impresión por: ' + E.Message);
        end;
    end;
end;





procedure ImprimirCertificado(sEjercici,sCodInsp,sMatricula: String);
var
   aRowId, sMatricula_Auxi: string; //var. auxi. que almacena la patente del vehículo
   frmReimpresionCertificados_Auxi: TfrmReimpresionCertificados;
   frmComprobarNumFactReimp_Auxi: TfrmComprobarNumFactReimp;
   aVehiculo_Auxi: TVehiculo;
   aInspeccion_Auxi: TInspeccion;
   aFTmp: TFTmp;
begin
   EnviarTrabajo_ServidorImpresion (sEjercici,sCodInsp,sMatricula, Certificado);
end;





 
procedure Imprimirinmforme_cambio_oblea(sEjercici,sCodInsp,sMatricula: String);
var
   aRowId, sMatricula_Auxi: string; //var. auxi. que almacena la patente del vehículo
   frmReimpresionCertificados_Auxi: TfrmReimpresionCertificados;
   frmComprobarNumFactReimp_Auxi: TfrmComprobarNumFactReimp;
   aVehiculo_Auxi: TVehiculo;
   aInspeccion_Auxi: TInspeccion;
   aFTmp: TFTmp;
begin
   EnviarTrabajo_ServidorImpresion (sEjercici,sCodInsp,sMatricula, Informe);
end;











function ImprimirTicket_ControladorFiscal (sMatr: string; aFactura: Tfacturacion; aContrafact: TContrafacturas ): boolean;     //
var impfis: _PrinterFiscalDisp;
    accion,texto,nroheader,tipostatus, ivacompr, tipodoc, nrodoc: widestring;
    fdatosEstacion: TDatos_Estacion;
    usuario: Tusuario;
    usuariotabla: tusuarios;
    i,idusuario: integer;
    aCliente: Tclientes;
    fInspeccion: Tinspeccion;
    tipover: string;
    FBusqueda : TFTmp;
begin
  FBusqueda := TFTmp.Create(Application);
  with FBusqueda do
  try
    MuestraClock('Cancelación','Imprimiendo Cancelación de Ticket No Fiscal...');
    try
      result := false;
      try
        impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
        impfis.PortNumber:=PortNumber;
        impfis.BaudRate:=BaudRate;
      except
        exit;
      end;
      
      aCliente := aFactura.GetCliente;
      aCliente.open;
     try
       fdatosestacion:=nil;
       fdatosestacion:= tdatos_estacion.create(MyBd);
       fdatosestacion.Open;
       accion:='S';

       nroheader:=ENCA_FANTASIA;
       texto:=#245+fdatosestacion.valuebyname[FIELD_NOMFANTASIA];
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);
       nroheader:=ENCA_RSOCIAL;
       texto:=fdatosestacion.valuebyname[FIELD_RSOCIAL];
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);

       texto:=#127;
       nroheader:=ENCA_L3;
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);
       nroheader:=ENCA_L4;
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);

       nroheader:=ENCA_L5;
       texto:=stringparacf(fdatosestacion.valuebyname[FIELD_CALLECOM]);
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);
       nroheader:=ENCA_L6;
       texto:='('+stringparacf(fdatosestacion.valuebyname[FIELD_CODPOSTA])+') - '+stringparacf(fdatosestacion.valuebyname[FIELD_LOCALIDAD]);
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);
       nroheader:=ENCA_L7;
       texto:='TEL: '+stringparacf(fdatosestacion.valuebyname[FIELD_TELEFONOS]);
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);
       nroheader:=ENCA_L8;
       texto:='II BB: '+fdatosestacion.valuebyname[FIELD_INSINGBRUT];
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);
       nroheader:=ENCA_L9;
       texto:='Inicio de Actividad: '+fdatosestacion.valuebyname[FIELD_FECHINIACT];
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);

       nroheader:=COLA_FORPAGO_2;
       texto := #127;
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);


     finally
       fdatosestacion.close;
       fdatosestacion.free;
     end;
       texto:=LINEA_DNF;
       nroheader:=COLA_FORPAGO_1;
       impfis.SetGetHeaderTrailer(accion,nroheader,texto);
       nroheader:=COLA_CAJERO_1;
       try
        usuario:=gestorseg.BuscarUsuario(applicationuser);
        idusuario:=usuario.obteneruid;
        usuariotabla:=tusuarios.CreateFromDataBase(mybd,DATOS_USUARIO,FORMAT('WHERE IDUSUARIO = %D',[idusuario]));
        usuariotabla.open;
        texto:='CAJERO: '+usuariotabla.ValueByName[FIELD_NOMBRE];
       finally
         usuariotabla.close;
         usuariotabla.free;
       end;
         impfis.SetGetHeaderTrailer(accion,nroheader,texto);
         texto:=LINEA_DNF;
         nroheader:=COLA_FORPAGO_3;
         impfis.SetGetHeaderTrailer(accion,nroheader,texto);
         impfis.OpenNoFiscal();
         tipostatus:=INF_NUMERADORES;
         impfis.Status(tipostatus);
         aContrafact.ValueByName[FIELD_NUMFACTU]:=impfis.AnswerField_10;
         texto:=LINEA_DNF;
         impfis.SendNoFiscalText(texto);
         ivacompr:=tipoiva(aFactura.ValueByName[FIELD_TIPTRIBU]);
         texto:=stringParaCF(acliente.ValueByName[FIELD_NOMBRE]+' '+acliente.ValueByName[FIELD_APELLID1]);
         impfis.SendNoFiscalText(texto);
         if (ivacompr = 'I') or (ivacompr = 'N') or (ivacompr = 'M')or (ivacompr = 'N')or (ivacompr = 'E') then
           begin
             tipodoc:=TIPO_DOC_CUIT;
             if CuitCorrecto(acliente.valuebyname[FIELD_CUIT_CLI]) then
                 nrodoc:=cuitsinguion(acliente.valuebyname[FIELD_CUIT_CLI]);
           end
           else
           begin
                 tipodoc:=acliente.valuebyname[FIELD_TIPODOCU];
                 nrodoc:=acliente.valuebyname[FIELD_DOCUMENT];
           end;
       tipodoc:=tipodoc+' '+nrodoc;
       impfis.SendNoFiscalText(tipodoc);
       texto:=stringParaCF(acliente.valuebyname[FIELD_DIRECCIO]);
       if length(texto) > 40 then
            begin
                 i:= abs(40- length(texto));
                 delete(texto,40,i);
            end;
       impfis.SendNoFiscalText(texto);
       texto:=stringParaCF(acliente.valuebyname[FIELD_CODPOSTA]+' - '+acliente.valuebyname[FIELD_LOCALIDA]);
       impfis.SendNoFiscalText(texto);
       texto:=LINEA_DNF;
       impfis.SendNoFiscalText(texto);
       texto:=#245+'CANCELACION';
       impfis.SendNoFiscalText(texto);
       texto:='VTV del vehiculo';
       impfis.SendNoFiscalText(texto);
       texto:=sMatr;
       impfis.SendNoFiscalText(texto);
       finspeccion := afactura.GetInspeccion;
       fInspeccion.open;
       if (finspeccion.ValueByName[FIELD_TIPO]= T_REVERIFICACION) or (finspeccion.ValueByName[FIELD_TIPO]=T_VOLUNTARIAREVERIFICACION)
       then
          tipover:= 'R'
       else
          tipover:='V';
       texto:='Nro: '+tipover+Trim(Copy(finspeccion.ValueByName[FIELD_EJERCICI],3,2))+'000'+fvarios.ValueByName[FIELD_ZONA]+'000'+fvarios.ValueByName[FIELD_ESTACION]+formatoceros(strtoint(finspeccion.ValueByName[FIELD_CODINSPE]),LENGTH(finspeccion.ValueByName[FIELD_CODINSPE])); //AGRE VAZ
       impfis.SendNoFiscalText(texto);
       if impfis.CloseNoFiscal() then
       begin
         result:=true;
         aContraFact.valuebyname[FIELD_IMPRESA]:='S';
       end;
    finally
       finspeccion.free;
       acliente.free;
    end;
  finally
     FBusqueda.Free;
  end;

end;


function tiene_oblea_para_inutilizar(codfactura:longint): boolean;             //
var
  nroinspeccion, ejercicio: integer;
  qryConsultas:TSQLQuery;
  nro_oblea:string;
begin
tiene_oblea_para_inutilizar:=false;

      qryConsultas:=TSQLQuery.Create(nil);
      qryConsultas.SQLConnection:=mybd;
      qryConsultas.Close;
      qryConsultas.Sql.Clear;

      qryConsultas.Sql.Add (Format ('SELECT numoblea FROM TINSPECCION WHERE codfactu = %d ',[codfactura]));

      qryConsultas.Open;

        if trim(qryConsultas.fields[0].asstring)<>'' then
             begin
               nro_oblea:=trim(qryConsultas.fields[0].asstring);

                   qryConsultas.Close;
                   qryConsultas.SQL.Clear;
                   qryConsultas.SQL.Add('update tobleas set estado=''S'' where numoblea=:OBLEA');
                   qryConsultas.ParamByName('OBLEA').AsString:=nro_oblea;
                   qryConsultas.ExecSQL;

                    Application.MessageBox(pchar('Se ha restaurado la oblea '+nro_oblea+'. Si esta oblea no se va a volver a utilizar por favor anular o inutilizar desde el sistema antes de continuar imprimiendo informes.'), 'Atención',
                    MB_ICONINFORMATION );





               tiene_oblea_para_inutilizar:=true;
              end;

       qryConsultas.close;
       qryConsultas.free;



end;



procedure ReimpresionFacturasNCredito (const bEsFactura: boolean);
var
  bDatosFiables: boolean; { Almacena True si la inspección NO se ha finalizado }
  iNuevoNumFactura: integer;
  aRowId: string;
  frmComprobarNumFactReimp_Auxi: TfrmComprobarNumFactReimp;
  frmReimpresionNC_Auxi: TfrmReimpresionNC;
  fFactura: TFacturacion;
  aVehiculo_Auxi: TVehiculo;
  aInspeccion_Auxi: TInspeccion;
  aInspGNC_Auxi : TINspGNC;
  sEjer_Auxi, sCodInsp_Auxi, sMatricula_Auxi: string; //var.auxi.
  aTrabajo_Auxi: tTrabajo;
  FPtoventa:tptoventa;    //
  ptoventa,ptoventaedit,ptoventacf:integer;
  FBusqueda : TFTmp;
  fFact_Descuento: tFacturacion;
   /////////////////////////////////////////////////////////////////////////////
   procedure GenerarFactura_Reimpresion;
   var
     aContraFactura: TContrafacturas;
     tcf:tcontrol_nc_cf;
   begin
     try
       fptoventa:=nil;
       fptoventa:=tptoventa.Create(fFactura.Database);
       ptoventa:=fptoventa.GetPtoVentaManual;
//       ptoventacf:=fptoventa.GetPtoVenta;
       aContraFactura := nil;
       try
          fFactura.Open;
          fFactura.Edit;
          ffactura.ffactadicionales.open;
          if bEsFactura then
          begin
              if (fFactura.ValueByName[FIELD_ERROR] = 'N') then
              begin
                  fFactura.ValueByName[FIELD_FECHALTA] := DateBD (fFactura.Database);
                  fFactura.ValueByName[FIELD_IMPRESA] := FACTURA_REIMPRESA;
                  if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                    bDatosFiables := fFactura.VerImprimirFactura (True, nil)
                  else
                    bDatosFiables := fFactura.VerImprimirFacturaGNC (True, nil)
              end
              else
              begin
                  bDatosFiables := False;
                  MessageDlg (Application.Title, 'La última factura con inspección finalizada ha sido cancelada', mtInformation, [mbOk], mbOk, 0);
              end
          end
          else
          begin
              aContraFactura := TContrafacturas.CreateFromFactura(fFactura.Database, fFactura);
              aContraFactura.Open;
            //  uffactura.tiene_que_imprimir:=true;
              if (aContraFactura.ValueByName[FIELD_NUMFACTU] <> '') then
              begin
                // tiene_que_imprimir:=false;
                  aContraFactura.ValueByName[FIELD_IMPRESA] := FACTURA_REIMPRESA;
                  MessageDlg (Application.Title, 'La factura introducida se ha cancelado anteriormente', mtInformation, [mbOk], mbOk, 0);
              end
              else
              begin
                  aContraFactura.ValueByName[FIELD_IMPRESA] := FACTURA_NO_IMPRESA;
              end;
              aContraFactura.ValueByName[FIELD_FECHALTA] := DateBD (fFactura.Database);
              ffactura.open;
              ffactura.ffactadicionales.open;
              aContraFactura.ffactAdicionales.open;
              aContraFactura.ffactAdicionales.valuebyname[FIELD_CODTARJET]:= fFactura.ffactadicionales.ValueByName[FIELD_CODTARJET];
              aContraFactura.ffactAdicionales.valuebyname[FIELD_NUMTARJET]:= fFactura.ffactadicionales.ValueByName[FIELD_NUMTARJET];
              aContraFactura.ffactAdicionales.valuebyname[FIELD_FECHAVEN]:= fFactura.ffactadicionales.ValueByName[FIELD_FECHAVEN];
              aContraFactura.ffactAdicionales.valuebyname[FIELD_CANTCUOT]:= fFactura.ffactadicionales.ValueByName[FIELD_CANTCUOT];
              if fFactura.ValueByName[FIELD_FORMPAGO] = FORMA_PAGO_TARJETA then
              begin
                if fFactura.ValueByName[FIELD_TIPFACTU] <> 'N' then
                begin
//                   bDatosFiables := CreateFromBD (aContraFactura, aContraFactura.ffactAdicionales, false) and aContraFactura.VerImprimirFactura (True, nil)

                        if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                           begin
                             tcf:=tcontrol_nc_cf.Create;
              //             bDatosFiables := CreateFromBD (aContraFactura, false);
                                 if   not tcf.controla_cf then
                                         bDatosFiables :=  CreateFromBD (aContraFactura, false) and  aContraFactura.VerImprimirFactura (True, nil)
                                     else
                                       begin
                                          globals.datos_tarjetausa:=0;
                                          bDatosFiables :=  Utarjetas_nc_cf.CreateFromBD (aContraFactura, false);
                                           if    Utarjetas_nc_cf.cancelo=false then
                                                 bDatosFiables := aContraFactura.VerImprimirFactura (True, nil)
                                                 else
                                                bDatosFiables:=false;
                                        //  bDatosFiables :=    aContraFactura.VerImprimirFactura (True, nil);
                                       end;
                              tcf.Free;
                           end
                            else
                             bDatosFiables := CreateFromBD (aContraFactura, false) and aContraFactura.VerImprimirFacturaGNC (True, nil)
                      
                end
                else
                   bDatosFiables := True;
              end
              else
              begin
                if fFactura.ValueByName[FIELD_TIPFACTU] <> 'N' then
                begin
                   if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                     bDatosFiables := aContraFactura.VerImprimirFactura (True, nil)
                   else
                     bDatosFiables := aContraFactura.VerImprimirFacturaGNC (True, nil)
                end
                else
                begin
                   FBusqueda := TFTmp.Create(Application);
                   with FBusqueda do
                   MuestraClock('Cancelación','Comprobando la comunicación con el Controlador Fiscal ...');
                   if fptoventa.EncendidoyFunciona then
                   begin
                     fbusqueda.free;
                     bDatosFiables := ImprimirTicket_ControladorFiscal(sMatricula_Auxi,Ffactura,aContraFactura)
                   end
                   else
                   begin
                     fbusqueda.free;
                     bDatosFiables := False;
                   end;

                   if bDatosFiables = False then
                   begin
                        raise Exception.Create('El Controlador Fiscal no funciona.'+#13+
                              'No es posible generar una cancelación de Documento No Fiscal');
                   end;
               end;

              end;
          end;

          if bDatosFiables then
          begin
              if bEsFactura then
              begin
                  if (fFactura.ValueByName[FIELD_TIPFACTU] = FACTURA_TIPO_A) then
                  begin
                     if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                       aTrabajo_Auxi := Factura_A
                     else
                       aTrabajo_Auxi := Factura_A_GNC
                  end
                  else
                  begin
                     if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                       aTrabajo_Auxi := Factura_B
                     else
                       aTrabajo_Auxi := Factura_B_GNC
                  end;

                  fFactura.Post(true); //Para guardar IMPRESA en TFacturas
              end
              else
              begin
                  if (aContraFactura.fMasterFactura.ValueByName[FIELD_TIPFACTU] = FACTURA_TIPO_A) then
                  begin
                    if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                      aTrabajo_Auxi := Nota_A
                    else
                      aTrabajo_Auxi := Nota_A_GNC
                  end
                  else
                  begin
                    if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                      aTrabajo_Auxi := Nota_B
                    else
                      aTrabajo_Auxi := Nota_B_GNC
                  end;

                  aContraFactura.Post(true); //Para guardar IMPRESA en TContrafact
                  fFactura.ValueByName[FIELD_CODCOFAC]:=aContraFactura.ValueByName[FIELD_CODCOFAC];
                  if fFactura.ffactadicionales.ValueByName[FIELD_RELCODFAC] <> '' then
                  begin
                    fFact_Descuento := nil;
                    try
                      fFact_Descuento := TFacturacion.CreateFromDataBase(MyBd,DATOS_FACTURAS,FORMAT('WHERE CODFACTU = ''%S''',[fFactura.ffactadicionales.valuebyname[FIELD_RELCODFAC]]));
                      fFact_Descuento.open;
                      fFact_Descuento.ffactadicionales:=nil;
                      fFact_Descuento.ffactadicionales:=TFact_adicionales.CreateFromFactura(MyBD,fFact_Descuento.valuebyname[FIELD_CODFACTU],'D','D');
                      fFact_Descuento.ffactadicionales.open;
                      fFact_Descuento.ffactadicionales.edit;
                      fFact_Descuento.ffactadicionales.valuebyName[FIELD_RELCODFAC] := '';
                      fFact_Descuento.ffactadicionales.post(true);
                    finally
                      fFact_Descuento.ffactadicionales.close;
                      fFact_Descuento.ffactadicionales.free;
                      fFact_Descuento.close;
                      fFact_Descuento.free
                    end;
                  end;
                  fFactura.Post(true);
                  fFactura.ffactadicionales.open;
                  aContraFactura.ffactadicionales.valuebyname[FIELD_CODFACT]:=aContraFactura.ValueByName[FIELD_CODCOFAC];
                  if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                    aContraFactura.ffactadicionales.valuebyname[FIELD_TIPOFAC]:='N'
                  else
                    aContraFactura.ffactadicionales.valuebyname[FIELD_TIPOFAC]:='C';
                  if fFactura.ValueByName[FIELD_TIPFACTU] <> 'N' then                              
                     aContraFactura.ffactadicionales.valuebyname[FIELD_PTOVENT]:=inttostr(ptoventa)
                  else
                  begin
                     ptoventacf:=fptoventa.GetPtoVenta;
                     aContraFactura.ffactadicionales.valuebyname[FIELD_PTOVENT]:=inttostr(ptoventacf);
                  end;

                  aContraFactura.ffactAdicionales.valuebyname[FIELD_IDUSUARI]:= fFactura.ffactadicionales.ValueByName[FIELD_IDUSUARI];

                  aContraFactura.ffactadicionales.post(true);
              end;

              if fFactura.ValueByName[FIELD_TIPFACTU] <> 'N' then
                 bDatosFiables := EnviarTrabajo_ServidorImpresion (sEjer_Auxi, sCodInsp_Auxi, sMatricula_Auxi, aTrabajo_Auxi)
              else
              begin
                   bDatosFiables := True;

              end;

              if bDatosFiables then
              begin
                  if bEsFactura then
                  begin
                      fFactura.Refresh;
                      if (fFactura.ValueByName[FIELD_IMPRESA] <> FACTURA_IMPRESA) then
                         raise Exception.Create ('Factura no impresa');

                      iNuevoNumFactura := StrToInt(fFactura.ValueByName[FIELD_NUMFACTU])
                  end
                  else
                  begin
                      aContraFactura.Refresh;
                      if (aContraFactura.ValueByName[FIELD_IMPRESA] <> FACTURA_IMPRESA) then
                         raise Exception.Create ('Nota de Crédito no impresa');

                  end;

                  if bEsFactura then
                     frmComprobarNumFactReimp_Auxi := TfrmComprobarNumFactReimp.CreateFromComprobarFactura (fFactura)
                  else
                     frmComprobarNumFactReimp_Auxi := TfrmComprobarNumFactReimp.CreateFromComprobarNCredito (aContraFactura,fFactura.ValueByName[FIELD_TIPFACTU]);

                  try
                     frmComprobarNumFactReimp_Auxi.ShowModal;

                     if (frmComprobarNumFactReimp_Auxi.NumeroFactura <> -1) then
                     begin
                         if bEsFactura then
                         begin
                             aRowId := fFactura.ValueByName[FIELD_ROWID];
                             fFactura.Close;
                             fFactura.Free;
                             fFactura := TFacturacion.CreateByRowId (MyBD,aRowId);
                             fFactura.Open;
                             fFactura.ValueByName[FIELD_NUMFACTU] := IntToStr(frmComprobarNumFactReimp_Auxi.NumeroFactura)
                         end
                         else
                         begin
                             aRowId := aContraFactura.ValueByName[FIELD_ROWID];
                             aContraFactura.Close;
                             aContraFactura.Free;
                             aContraFactura := TContraFacturas.CreateByRowId (MyBD,aRowId);
                             aContraFactura.Open;
                             aContraFactura.ValueByName[FIELD_NUMFACTU] := IntToStr(frmComprobarNumFactReimp_Auxi.NumeroFactura)
                         end;


                         if (bEsFactura)
                         then
                            FFactura.Post(true)
                         else
                            aContraFactura.Post(true);


                         if bEsFactura then
                            MessageDlg (Application.Title,'Número de factura modificado satisfactoriamente',mtInformation, [mbOk], mbOk, 0)
                         else
                            MessageDlg (Application.Title,'Número de nota de crédito modificado satisfactoriamente',mtInformation, [mbOk], mbOk, 0); //
                     end
                  finally
                       frmComprobarNumFactReimp_Auxi.Free;
                  end;
              end
          end
       finally
            aContraFactura.ffactadicionales.Close;
            aContrafactura.ffactadicionales.free;
            aContraFactura.Free;
       end;
     finally
           fptoventa.free;
     end;
   end;
   /////////////////////////////////////////////////////////////////////////////

begin
    bDatosFiables := True;
    try
       if bEsFactura
       then frmReimpresionNC_Auxi := TfrmReimpresionNC.CreateFromFactura (StrToInt(fVarios.ValueByName[FIELD_ESTACION]))
       else frmReimpresionNC_Auxi := TfrmReimpresionNC.CreateFromNCredito (StrToInt(fVarios.ValueByName[FIELD_ESTACION]));
       try
          if (frmReimpresionNC_Auxi.ShowModal = mrOk)
          then begin
              if (not frmReimpresionNC_Auxi.ChkBxNumFactura.Checked)
              then begin
                if frmReimpresionNC_Auxi.rgtipo.itemindex = 1 then
                begin
                  aInspeccion_Auxi := tInspeccion.CreateByRowId(MyBd,frmReimpresionNC_Auxi.RowidInspeccion);
                  aInspeccion_Auxi.open;
                  fFactura := aInspeccion_Auxi.getfactura;
                end
                else
                begin
                  aInspGNC_Auxi := tInspgnc.CreateByRowId(MyBd,frmReimpresionNC_Auxi.RowidInspeccion);
                  aInspGNC_Auxi.open;
                  fFactura := aInspGNC_Auxi.getFactura;
                end;
                  fFactura.Open;
                  fFactura.ffactadicionales:=TFact_adicionales.CreateFromFactura(MyBd,fFactura.valuebyname[FIELD_CODFACTU],TIPO_FACTURA,TIPO_FACTURAGNC);
                  fFactura.ffactadicionales.open;
              end
              else
              begin
                  ptoventaedit:=strtoint(Copy(frmReimpresionNC_Auxi.edtNumFactura.Text,1,4));
                  fFactura := TFacturacion.CreateByTipoNumeroAdic (MyBD, frmReimpresionNC_Auxi.TipoFactura, frmReimpresionNC_Auxi.NumeroFactura,ptoventaedit);
                  fFactura.Open;
                  GLOBALS.CODFACT_NC:=STRTOINT(fFactura.valuebyname[FIELD_CODFACTU]);
                

                  fFactura.ffactadicionales:=TFact_adicionales.CreateFromFactura(MyBd,fFactura.valuebyname[FIELD_CODFACTU],TIPO_FACTURA,TIPO_FACTURAGNC);
                  fFactura.ffactadicionales.open;
                  if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                    aInspeccion_Auxi := fFactura.GetInspeccion
                  else
                    aInspGNC_Auxi := fFactura.GetInspeccionGNC;
              end;
                  if fFactura.ffactadicionales.ValueByName[FIELD_TIPOFAC] = TIPO_FACTURA then
                  begin
                  try
                    If aInspeccion_Auxi<>nil
                    Then begin
                        aInspeccion_Auxi.Open;
                        sEjer_Auxi := aInspeccion_Auxi.ValueByName[FIELD_EJERCICI];
                        sCodInsp_Auxi := aInspeccion_Auxi.ValueByName[FIELD_CODINSPE];
                        aVehiculo_Auxi := aInspeccion_Auxi.GetVehiculo;
                        try
                          aVehiculo_Auxi.Open;
                          sMatricula_Auxi := aVehiculo_Auxi.GetPatente;
                        finally
                             aVehiculo_Auxi.Close;
                             aVehiculo_Auxi.Free;
                        end;
                    end
                    else begin
                        Messagedlg(Application.Title,'Inspección No encontrada',mtInformation,[mbyes],mbyes,0);
                        Exit;
                    end;
                  finally
                       fFactura.Close;
                       fFactura.ffactadicionales.Close;
                       aInspeccion_Auxi.Close;
                       aInspeccion_Auxi.Free;
                  end;

                  end
                  else
                  begin
                  try
                    If aInspGNC_Auxi<>nil
                    Then begin
                        aInspGNC_Auxi.Open;
                        sEjer_Auxi := aInspGNC_Auxi.ValueByName[FIELD_EJERCICI];
                        sCodInsp_Auxi := aInspGNC_Auxi.ValueByName[FIELD_CODINSPGNC];
                        aVehiculo_Auxi := aInspGNC_Auxi.GetVehiculo;
                        try
                          aVehiculo_Auxi.Open;
                          sMatricula_Auxi := aVehiculo_Auxi.GetPatente;
                        finally
                             aVehiculo_Auxi.Close;
                             aVehiculo_Auxi.Free;
                        end;
                    end
                    else begin
                        Messagedlg(Application.Title,'Inspección No encontrada',mtInformation,[mbyes],mbyes,0);
                        Exit;
                    end;
                  finally
                       fFactura.Close;
                       fFactura.ffactadicionales.Close;
                       aInspGNC_Auxi.Close;
                       aInspGNC_Auxi.Free;
                  end;

                  end ;
                  GenerarFactura_Reimpresion;

          end
       finally
           frmReimpresionNC_Auxi.Free;
       end;
    finally
        if assigned(fFactura) then
        begin
             ffactura.ffactadicionales.close;
             ffactura.ffactadicionales.free;
             ffactura.close;
             fFactura.Free;
        end;
    end;
end;


Procedure DoImprimeMedAuto(finspecciones: tInspeccion);   
var fDatInspecc : tDatInspecc;
begin
(*  FTmp.Temporizar(True,True,'Impresión de Informes','Imprimiendo las Mediciones Automáticas');
  try
    fDatInspecc := nil;
    try
      fDatInspecc := tdatinspecc.CreatebyInspecc(finspecciones);
      fDatInspecc.open;
      with tfrmMedicionesAutomaticas.Create(application) do
       try
         repmedauto.DataSet:=fdatinspecc.DataSet;
         QRLVehiculo.caption:= fdatinspecc.GetDominio;
         qrlInforme.caption:=fDatInspecc.GetNroInforme;
         repmedauto.prepare;
         repmedauto.printersetup;
         repmedauto.print;
       finally
         free;
       end;
    finally
      fdatinspecc.close;
      fdatinspecc.free;
    end;
  finally
      FTmp.Temporizar(False,True,'','');
  end;*)
end;


procedure ReimpresionInformesInspeccion;
var
  frmReimpresionCertificados_Auxi: TfrmReimpresionCertificados;
  aVehiculo_Auxi: TVehiculo;
  aInspeccion_Auxi: TInspeccion;
  aRowId, sMatricula_Auxi: string;
  frmComprobarNumFactReimp_Auxi: TfrmComprobarNumFactReimp;
  aFTmp: TFTmp;

   /////////////////////////////////////////////////////////////////////////////
   procedure GenerarInfInspeccion_Reimpresion;
   begin
        aFtmp.Hide;
       if (aInspeccion_Auxi.VerImprimirInformeInspeccion (True, True, nil)) then
       begin
          EnviarTrabajo_ServidorImpresion (aInspeccion_Auxi.ValueByName[FIELD_EJERCICI],aInspeccion_Auxi.ValueByName[FIELD_CODINSPE],sMatricula_Auxi, Informe);
          {$IFDEF CRICA}
          doImprimeMedAuto(aInspeccion_Auxi);
          {$ENDIF}
       end;
   end;
   /////////////////////////////////////////////////////////////////////////////
begin
    try
       frmReimpresionCertificados_Auxi := TfrmReimpresionCertificados.CreateFromInforme (StrToInt(fVarios.ValueByName[FIELD_ZONA]),StrToInt(fVarios.ValueByName[FIELD_ESTACION]));
       try
          if (frmReimpresionCertificados_Auxi.ShowModal = mrOk) then
          begin
              aFTmp := TFTmp.Create (Application);
              try

                 aFTmp.MuestraClock ('Informe de Inspección', 'Generando Un Informe De Inspección...');

                 if (frmReimpresionCertificados_Auxi.ChkBxBusquedaMatricula.Checked) then
                 begin
                    If frmReimpresionCertificados_Auxi.RowidVehiculo<>''
                    then begin
                         aVehiculo_Auxi := TVehiculo.CreateByRowid (MyBD, frmReimpresionCertificados_Auxi.RowidVehiculo);
                         try
                            aVehiculo_Auxi.Open;
                            aInspeccion_Auxi := aVehiculo_Auxi.GetInspections;
                            sMatricula_Auxi := aVehiculo_Auxi.GetPatente;

                             If aInspeccion_Auxi<>nil then aInspeccion_Auxi.Open
                             else begin
                                Messagedlg(Application.Title,'Vehículo Sin Inspecciones',mtInformation,[mbyes],mbyes,0);
                                Exit;
                             end;

                            if (aInspeccion_Auxi.RecordCount = 0) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'El vehículo no tiene asociada ninguna inspección', mtInformation, [mbOk], mbOk, 0);
                                exit;
                            end
                            else
                            begin
                                aInspeccion_Auxi.Last;
                                //Hay que tomar la última inspección finalizada
                                while ((aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) and (not aInspeccion_Auxi.Bof)) do
                                begin
                                    aInspeccion_Auxi.Prior;
                                end;
                            end;

                            if (aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                            end
                            else
                            begin
                                aVehiculo_Auxi.Close;
                                try
                                   aRowId := aInspeccion_Auxi.ValueByName[FIELD_ROWID];
                                   aInspeccion_Auxi.Free;
                                   aInspeccion_Auxi := TInspeccion.CreateByRowId (MyBD, aRowId);
                                   aInspeccion_Auxi.Open;

                                     ///*******************pido oblea     martin 06/12/2013
                             // Comprobamos el número de oblea
              if trim(aInspeccion_Auxi.ValueByName[FIELD_NUMOBLEA])<>'' then
              begin
               frmComprobarNumFactReimp_Auxi := nil;
               try
                  frmComprobarNumFactReimp_Auxi := TfrmComprobarNumFactReimp.CreateFromComprobarNOblea (StrToInt(aInspeccion_Auxi.ValueByName[FIELD_NUMOBLEA]));
                  frmComprobarNumFactReimp_Auxi.ShowModal;

                  if (frmComprobarNumFactReimp_Auxi.NumeroOblea <> -1) then
                  begin
                      //Cambiamos el número de oblea
                      aRowId := aInspeccion_Auxi.ValueByName[FIELD_ROWID];
                      aInspeccion_Auxi.Close;
                      aInspeccion_Auxi.Free;
                      aInspeccion_Auxi := TInspeccion.CreateByRowId (MyBd, aRowId);
                      aInspeccion_Auxi.Open;
                      aInspeccion_Auxi.Edit;
                      aInspeccion_Auxi.ValueByName[FIELD_NUMOBLEA] := IntToStr(frmComprobarNumFactReimp_Auxi.NumeroOblea);
                      aInspeccion_Auxi.Post(true);
                      aInspeccion_Auxi.Open;

                      MessageDlg (Application.Title,'Número de oblea modificado satisfactoriamente',mtInformation, [mbOk], mbOk, 0);
                  end;
               finally
                    frmComprobarNumFactReimp_Auxi.Free;
               end;

           end;//si vacio la oblea    
                 /////fin oblea
                 
                                   GenerarInfInspeccion_Reimpresion;
                                finally
                                     aInspeccion_Auxi.Free;
                                end;
                            end;
                         finally
                              aVehiculo_Auxi.Free;
                         end;
                    end
                    else begin
                        aFtmp.Hide;
                        MessageDlg (Application.Title, 'Vehiculo No Encontrado', mtInformation, [mbOk], mbOk, 0);
                        Exit;
                    end;
                 end
                 else begin
                     aInspeccion_Auxi := nil;
                     aInspeccion_Auxi := TInspeccion.Create (MyBD, Format ('where a.%s=%d and a.%s=%d',[FIELD_EJERCICI,frmReimpresionCertificados_Auxi.Ejercicio, FIELD_CODINSPE,frmReimpresionCertificados_Auxi.CodigoInspeccion]));
                     try
                        aInspeccion_Auxi.Open;
                        if (aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                        begin
                            aFtmp.Hide;
                            MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                        end
                        else
                        begin
                            aVehiculo_Auxi := aInspeccion_Auxi.GetVehiculo;
                            If aVehiculo_Auxi=nil
                            then begin
                                Messagedlg(Application.Title,'Vehículo No encontrado',mtInformation,[mbyes],mbyes,0);
                                Exit;
                            end;
                            try
                              aVehiculo_Auxi.Open;
                              sMatricula_Auxi := aVehiculo_Auxi.GetPatente;
                            finally
                                 aVehiculo_Auxi.Close;
                                 aVehiculo_Auxi.Free;
                            end;





                            GenerarInfInspeccion_Reimpresion;
                        end;
                     finally
                          aInspeccion_Auxi.Free;
                     end;
                 end;
              finally
                   aFTmp.Free;
              end;
          end;
       finally
            frmReimpresionCertificados_Auxi.Free;
       end;
    finally
        //If Assigned(aInspeccion_Auxi) then aInspeccion_Auxi.Free;
    end;
end;


procedure ReimpresionCertificados;
var
aRowId, sMatricula_Auxi: string; //var. auxi. que almacena la patente del vehículo
frmReimpresionCertificados_Auxi: TfrmReimpresionCertificados;
frmComprobarNumFactReimp_Auxi: TfrmComprobarNumFactReimp;
aVehiculo_Auxi: TVehiculo;
aInspeccion_Auxi: TInspeccion;
aFTmp: TFTmp;

   ////////////////////////////////////////////////////////////////////////////////
   procedure GenerarCertificado_Reimpresion;
   var
     aRowId: string;

   begin
        aFtmp.Hide;
       if (((aInspeccion_Auxi.ValueByName[FIELD_RESULTAD] = INSPECCION_RECHAZADO) or
            (aInspeccion_Auxi.ValueByName[FIELD_RESULTAD] = INSPECCION_BAJA)) and
            (aInspeccion_Auxi.ValueByName[FIELD_NUMOBLEA] = '')) then
       begin
           MessageDlg (Application.Title, 'La inspección no tiene número de oblea por ser rechazada o baja.', mtInformation, [mbOk], mbOk, 0);
       end
       else
       begin
           if aInspeccion_Auxi.VerImprimirCertificado (True, nil, fVarios.ValueByName[FIELD_ZONA], fVarios.ValueByName[FIELD_ESTACION]) then
           begin
               // Comprobamos el número de oblea
               frmComprobarNumFactReimp_Auxi := nil;
               try
                  frmComprobarNumFactReimp_Auxi := TfrmComprobarNumFactReimp.CreateFromComprobarNOblea (StrToInt(aInspeccion_Auxi.ValueByName[FIELD_NUMOBLEA]));
                  frmComprobarNumFactReimp_Auxi.ShowModal;

                  if (frmComprobarNumFactReimp_Auxi.NumeroOblea <> -1) then
                  begin
                      //Cambiamos el número de oblea
                      aRowId := aInspeccion_Auxi.ValueByName[FIELD_ROWID];
                      aInspeccion_Auxi.Close;
                      aInspeccion_Auxi.Free;
                      aInspeccion_Auxi := TInspeccion.CreateByRowId (MyBd, aRowId);
                      aInspeccion_Auxi.Open;
                      aInspeccion_Auxi.Edit;
                      aInspeccion_Auxi.ValueByName[FIELD_NUMOBLEA] := IntToStr(frmComprobarNumFactReimp_Auxi.NumeroOblea);
                      aInspeccion_Auxi.Post(true);
                      aInspeccion_Auxi.Open;

                      MessageDlg (Application.Title,'Número de oblea modificado satisfactoriamente',mtInformation, [mbOk], mbOk, 0);
                  end;
               finally
                    frmComprobarNumFactReimp_Auxi.Free;
               end;
               // Enviamos el trabajo al servidor de impresión




           //      //martin mensaje en certificado 21/12/2010
           // if  not (aInspeccion_Auxi.ValueByName[FIELD_TIPO][1] in [t_voluntaria, T_VOLUNTARIAREVERIFICACION]) then
          // begin
          // FrmCertificado.qrlabel1.Enabled:=false;
          // FrmCertificado.qrlabel2.Enabled:=false;
          // FrmCertificado.qrlabel3.Enabled:=false;
          // FrmCertificado.QRShape13.Enabled:=falsE;
          // end;


               EnviarTrabajo_ServidorImpresion (aInspeccion_Auxi.ValueByName[FIELD_EJERCICI],aInspeccion_Auxi.ValueByName[FIELD_CODINSPE], sMatricula_Auxi, Certificado);
           end;
       end
   end;
   ////////////////////////////////////////////////////////////////////////////////
begin
    try
       frmReimpresionCertificados_Auxi := TfrmReimpresionCertificados.CreateFromCertificado (StrToInt(fVarios.ValueByName[FIELD_ZONA]),StrToInt(fVarios.ValueByName[FIELD_ESTACION]));
       try
          if (frmReimpresionCertificados_Auxi.ShowModal = mrOk) then
          begin
              aFTmp := TFTmp.Create (Application);
              try
                 aFTmp.MuestraClock ('Certificado', 'Generando Un Certificado...');

                 if (frmReimpresionCertificados_Auxi.ChkBxBusquedaMatricula.Checked) then
                 begin
                     aVehiculo_Auxi := TVehiculo.CreateByRowid (MyBD, frmReimpresionCertificados_Auxi.RowidVehiculo);
                     try
                        aVehiculo_Auxi.Open;
                        aInspeccion_Auxi := aVehiculo_Auxi.GetInspections;
                        If aInspeccion_Auxi<>nil
                        then begin
                            aInspeccion_Auxi.Open;
                            if (aInspeccion_Auxi.RecordCount = 0) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'El vehículo no tiene asociada ninguna inspección', mtInformation, [mbOk], mbOk, 0);
                                exit;
                            end
                            else
                            begin
                                aInspeccion_Auxi.Last;

                                while ((aInspeccion_Auxi.ValueByName[FIELD_TIPO] = T_GRATUITA) or
                                       (aInspeccion_Auxi.ValueByName[FIELD_TIPO] = T_PREVERIFICACION) or
                                       (aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA)) and
                                       (not aInspeccion_Auxi.Bof) do
                                begin
                                    aInspeccion_Auxi.Prior;
                                end;
                            end;

                            if ((aInspeccion_Auxi.ValueByName[FIELD_TIPO] = T_GRATUITA) or
                                (aInspeccion_Auxi.ValueByName[FIELD_TIPO] = T_PREVERIFICACION)) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'La inspección es gratuita o una preverificación y no tiene asociada número de oblea', mtInformation, [mbOk], mbOk, 0);
                            end
                            else if (aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                            end
                            else
                            begin
                                sMatricula_Auxi := aVehiculo_Auxi.GetPatente;

                                aVehiculo_Auxi.Close;
                                try
                                   aRowId := aInspeccion_Auxi.ValueByName[FIELD_ROWID];
                                   aInspeccion_Auxi.Free;
                                   aInspeccion_Auxi := TInspeccion.CreateByRowId (MyBD, aRowId);
                                   aInspeccion_Auxi.Open;
                                   GenerarCertificado_Reimpresion;
                                finally
                                     aInspeccion_Auxi.Free;
                                end;
                            end;
                        end
                        else begin
                            Messagedlg(Application.Title, 'El vehículo no tiene asociada ninguna inspección o No Exite', mtInformation, [mbOk], mbOk, 0);
                            Exit;
                        end;
                     finally
                          aVehiculo_Auxi.Free;
                     end;
                 end
                 else
                 begin
                     aInspeccion_Auxi := nil;
                     aInspeccion_Auxi := TInspeccion.Create (MyBD, Format ('where a.%s=%d and a.%s=%d',[FIELD_EJERCICI,frmReimpresionCertificados_Auxi.Ejercicio, FIELD_CODINSPE,frmReimpresionCertificados_Auxi.CodigoInspeccion]));
                     try
                        aInspeccion_Auxi.Open;

                        if ((aInspeccion_Auxi.ValueByName[FIELD_TIPO] = T_GRATUITA) or
                            (aInspeccion_Auxi.ValueByName[FIELD_TIPO] = T_PREVERIFICACION)) then
                        begin
                            aFtmp.Hide;
                            MessageDlg (Application.Title, 'La inspección es gratuita o una preverificación y no tiene asociada número de oblea', mtInformation, [mbOk], mbOk, 0);
                        end
                        else if (aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                        begin
                            aFtmp.Hide;
                            MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                        end
                        else
                        begin
                            aVehiculo_Auxi := aInspeccion_Auxi.GetVehiculo;
                            If aVehiculo_Auxi=nil
                            then begin
                                Messagedlg(Application.Title,'Vehículo No encontrado',mtInformation,[mbyes],mbyes,0);
                                Exit;
                            end;
                            try
                              aVehiculo_Auxi.Open;
                              sMatricula_Auxi := aVehiculo_Auxi.GetPatente;
                            finally
                                 aVehiculo_Auxi.Close;
                                 aVehiculo_Auxi.Free;
                            end;
                            GenerarCertificado_Reimpresion;
                        end;
                     finally
                          aInspeccion_Auxi.Free;
                     end;
                 end
              finally
                   aFTmp.Free;
              end;
          end;
       finally
            frmReimpresionCertificados_Auxi.Free;
       end;
    finally
        //If Assigned(aInspeccion_Auxi) then aInspeccion_Auxi.Free;
    end;
end;

procedure ReimpresionTAmarilla;
var
   aRowId, sMatricula_Auxi: string; //var. auxi. que almacena la patente del vehículo
   frmReimpresionTAmarilla_Auxi: TfrmReimpTAamarilla;
   frmComprobarNumOblReimpGNC_Auxi: TfrmComprobarNumOblReimpGNC;
   aVehiculo_Auxi: TVehiculo;
   aInspGNC_Auxi: TInspGNC;
   aFTmp: TFTmp;

   ////////////////////////////////////////////////////////////////////////////////
   procedure GenerarTAmarilla_Reimpresion;
   var
     aRowId: string;

   begin
        aFtmp.Hide;
       if ((aInspGNC_Auxi.ValueByName[FIELD_RESULTADO] = INSPECCION_RECHAZADO) and
            (aInspGNC_Auxi.ValueByName[FIELD_NUMOBLEA] = '')) then
       begin
           MessageDlg (Application.Title, 'La inspección no tiene número de oblea por ser rechazada.', mtInformation, [mbOk], mbOk, 0);
       end
       else
       begin
           if aInspGNC_Auxi.VerImprimirTAmarilla (True, nil, fVarios.ValueByName[FIELD_ZONA], fVarios.ValueByName[FIELD_ESTACION]) then
           begin
               // Comprobamos el número de oblea
               frmComprobarNumOblReimpGNC_Auxi := nil;
               try
                  frmComprobarNumOblReimpGNC_Auxi := TfrmComprobarNumOblReimpGNC.CreateFromComprobarNOblea (StrToInt(aInspGNC_Auxi.ValueByName[FIELD_OBLEANUEVA]),aInspGNC_Auxi.valuebyname[FIELD_EJERCICI],aInspGNC_Auxi.valuebyname[FIELD_CODINSPGNC]);
                  frmComprobarNumOblReimpGNC_Auxi.ShowModal;

                  if (frmComprobarNumOblReimpGNC_Auxi.NumeroOblea <> -1) then
                  begin
                      //Cambiamos el número de oblea
                      aRowId := aInspGNC_Auxi.ValueByName[FIELD_ROWID];
                      aInspGNC_Auxi.Close;
                      aInspGNC_Auxi.Free;
                      aInspGNC_Auxi := TInspGNC.CreateByRowId (MyBd, aRowId);
                      aInspGNC_Auxi.Open;
                      aInspGNC_Auxi.Edit;
                      aInspGNC_Auxi.ValueByName[FIELD_OBLEANUEVA] := IntToStr(frmComprobarNumOblReimpGNC_Auxi.NumeroOblea);
                      aInspGNC_Auxi.Post(true);
                      aInspGNC_Auxi.Open;

                      MessageDlg (Application.Title,'Número de oblea modificado satisfactoriamente',mtInformation, [mbOk], mbOk, 0);
                  end;
               finally
                    frmComprobarNumOblReimpGNC_Auxi.Free;
               end;
               // Enviamos el trabajo al servidor de impresión
               EnviarTrabajo_ServidorImpresion (aInspGNC_Auxi.ValueByName[FIELD_EJERCICI],aInspGNC_Auxi.ValueByName[FIELD_CODINSPGNC], sMatricula_Auxi, TAmarilla);
           end;
       end
   end;
   ////////////////////////////////////////////////////////////////////////////////
begin
    try
       frmReimpresionTAmarilla_Auxi := TfrmReimpTAamarilla.CreateFromCertificado (StrToInt(fVarios.ValueByName[FIELD_ZONA]),StrToInt(fVarios.ValueByName[FIELD_ESTACION]));
       try
          if (frmReimpresionTAmarilla_Auxi.ShowModal = mrOk) then
          begin
              aFTmp := TFTmp.Create (Application);
              try
                 aFTmp.MuestraClock ('Tarjeta Amarilla', 'Generando Una Tarjeta Amarilla...');

                 if (frmReimpresionTAmarilla_Auxi.ChkBxBusquedaMatricula.Checked) then
                 begin
                     aVehiculo_Auxi := TVehiculo.CreateByRowid (MyBD, frmReimpresionTAmarilla_Auxi.RowidVehiculo);
                     try
                        aVehiculo_Auxi.Open;
                        aInspGNC_Auxi := aVehiculo_Auxi.GetInspectionsGNC;
                        If aInspGNC_Auxi<>nil
                        then begin
                            aInspGNC_Auxi.Open;
                            if (aInspGNC_Auxi.RecordCount = 0) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'El vehículo no tiene asociada ninguna inspección GNC', mtInformation, [mbOk], mbOk, 0);
                                exit;
                            end
                            else
                            begin
                                aInspGNC_Auxi.Last;

                                while ((aInspGNC_Auxi.ValueByName[FIELD_TIPO] = T_GNCRC) or
                                       (aInspGNC_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA)) and
                                       (not aInspGNC_Auxi.Bof) do
                                begin
                                    aInspGNC_Auxi.Prior;
                                end;
                            end;

                            if (aInspGNC_Auxi.ValueByName[FIELD_TIPO] = T_GNCRC) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'La inspección es RC y no tiene asociada número de oblea', mtInformation, [mbOk], mbOk, 0);
                            end
                            else if (aInspGNC_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                            end
                            else
                            begin
                                sMatricula_Auxi := aVehiculo_Auxi.GetPatente;

                                aVehiculo_Auxi.Close;
                                try
                                   aRowId := aInspGNC_Auxi.ValueByName[FIELD_ROWID];
                                   aInspGNC_Auxi.Free;
                                   aInspGNC_Auxi := TInspGNC.CreateByRowId (MyBD, aRowId);
                                   aInspGNC_Auxi.Open;
                                   GenerarTAmarilla_Reimpresion;
                                finally
                                     aInspGNC_Auxi.Free;
                                end;
                            end;
                        end
                        else begin
                            Messagedlg(Application.Title, 'El vehículo no tiene asociada ninguna inspección o No Exite', mtInformation, [mbOk], mbOk, 0);
                            Exit;
                        end;
                     finally
                          aVehiculo_Auxi.Free;
                     end;
                 end
                 else
                 begin
                     aInspGNC_Auxi := nil;
                     aInspGNC_Auxi := TInspGNC.Create (MyBD, Format ('where a.%s=%d and a.%s=%d',[FIELD_EJERCICI,frmReimpresionTAmarilla_Auxi.Ejercicio, FIELD_CODINSPGNC,frmReimpresionTAmarilla_Auxi.CodigoInspeccion]));
                     try
                        aInspGNC_Auxi.Open;

                        if (aInspGNC_Auxi.ValueByName[FIELD_TIPO] = T_GNCRC) then
                        begin
                            aFtmp.Hide;
                            MessageDlg (Application.Title, 'La inspección es RC y no tiene asociada número de oblea', mtInformation, [mbOk], mbOk, 0);
                        end
                        else if (aInspGNC_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                        begin
                            aFtmp.Hide;
                            MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                        end
                        else
                        begin
                            aVehiculo_Auxi := aInspGNC_Auxi.GetVehiculo;
                            If aVehiculo_Auxi=nil
                            then begin
                                Messagedlg(Application.Title,'Vehículo No encontrado',mtInformation,[mbyes],mbyes,0);
                                Exit;
                            end;
                            try
                              aVehiculo_Auxi.Open;
                              sMatricula_Auxi := aVehiculo_Auxi.GetPatente;
                            finally
                                 aVehiculo_Auxi.Close;
                                 aVehiculo_Auxi.Free;
                            end;
                            GenerarTAmarilla_Reimpresion;
                        end;
                     finally
                          aInspGNC_Auxi.Free;
                     end;
                 end
              finally
                   aFTmp.Free;
              end;
          end;
       finally
            frmReimpresionTAmarilla_Auxi.Free;
       end;
    finally
        //If Assigned(aInspeccion_Auxi) then aInspeccion_Auxi.Free;
    end;
end;

procedure ReimpresionInformeGNC;
var
   aRowId, sMatricula_Auxi: string; //var. auxi. que almacena la patente del vehículo
   frmReimpresionTAmarilla_Auxi: TfrmReimpTAamarilla;
   frmComprobarNumFactReimp_Auxi: TfrmComprobarNumFactReimp;
   aVehiculo_Auxi: TVehiculo;
   aInspGNC_Auxi: TInspGNC;
   aFTmp: TFTmp;

   ////////////////////////////////////////////////////////////////////////////////
   procedure GenerarInformeGNC_Reimpresion;
   var
     aRowId: string;

   begin
        aFtmp.Hide;
       if ((aInspGNC_Auxi.ValueByName[FIELD_RESULTADO] = INSPECCION_RECHAZADO) and
            (aInspGNC_Auxi.ValueByName[FIELD_NUMOBLEA] = '')) then
       begin
           MessageDlg (Application.Title, 'La inspección no tiene número de oblea por ser rechazada.', mtInformation, [mbOk], mbOk, 0);
       end
       else
       begin
           if aInspGNC_Auxi.VerImprimirInformeGNC (True, nil, fVarios.ValueByName[FIELD_ZONA], fVarios.ValueByName[FIELD_ESTACION]) then
           begin
               // Enviamos el trabajo al servidor de impresión
               EnviarTrabajo_ServidorImpresion (aInspGNC_Auxi.ValueByName[FIELD_EJERCICI],aInspGNC_Auxi.ValueByName[FIELD_CODINSPGNC], sMatricula_Auxi, InformeGNC);
           end;
       end
   end;
   ////////////////////////////////////////////////////////////////////////////////
begin
    try
       frmReimpresionTAmarilla_Auxi := TfrmReimpTAamarilla.CreateFromInforme (StrToInt(fVarios.ValueByName[FIELD_ZONA]),StrToInt(fVarios.ValueByName[FIELD_ESTACION]));
       try
          if (frmReimpresionTAmarilla_Auxi.ShowModal = mrOk) then
          begin
              aFTmp := TFTmp.Create (Application);
              try
                 aFTmp.MuestraClock ('Ficha Técnica', 'Generando Una Ficha Técnica...');

                 if (frmReimpresionTAmarilla_Auxi.ChkBxBusquedaMatricula.Checked) then
                 begin
                     aVehiculo_Auxi := TVehiculo.CreateByRowid (MyBD, frmReimpresionTAmarilla_Auxi.RowidVehiculo);
                     try
                        aVehiculo_Auxi.Open;
                        aInspGNC_Auxi := aVehiculo_Auxi.GetInspectionsGNC;
                        If aInspGNC_Auxi<>nil
                        then begin
                            aInspGNC_Auxi.Open;
                            if (aInspGNC_Auxi.RecordCount = 0) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'El vehículo no tiene asociada ninguna inspección GNC', mtInformation, [mbOk], mbOk, 0);
                                exit;
                            end
                            else
                            begin
                                aInspGNC_Auxi.Last;

                                while ((aInspGNC_Auxi.ValueByName[FIELD_TIPO] = T_GNCRC) or
                                       (aInspGNC_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA)) and
                                       (not aInspGNC_Auxi.Bof) do
                                begin
                                    aInspGNC_Auxi.Prior;
                                end;
                            end;

                            if (aInspGNC_Auxi.ValueByName[FIELD_TIPO] = T_GNCRC) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'La inspección es RC y no tiene asociada número de oblea', mtInformation, [mbOk], mbOk, 0);
                            end
                            else if (aInspGNC_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                            end
                            else
                            begin
                                sMatricula_Auxi := aVehiculo_Auxi.GetPatente;

                                aVehiculo_Auxi.Close;
                                try
                                   aRowId := aInspGNC_Auxi.ValueByName[FIELD_ROWID];
                                   aInspGNC_Auxi.Free;
                                   aInspGNC_Auxi := TInspGNC.CreateByRowId (MyBD, aRowId);
                                   aInspGNC_Auxi.Open;
                                   GenerarInformeGNC_Reimpresion;
                                finally
                                     aInspGNC_Auxi.Free;
                                end;
                            end;
                        end
                        else begin
                            Messagedlg(Application.Title, 'El vehículo no tiene asociada ninguna inspección o No Exite', mtInformation, [mbOk], mbOk, 0);
                            Exit;
                        end;
                     finally
                          aVehiculo_Auxi.Free;
                     end;
                 end
                 else
                 begin
                     aInspGNC_Auxi := nil;
                     aInspGNC_Auxi := TInspGNC.Create (MyBD, Format ('where a.%s=%d and a.%s=%d',[FIELD_EJERCICI,frmReimpresionTAmarilla_Auxi.Ejercicio, FIELD_CODINSPGNC,frmReimpresionTAmarilla_Auxi.CodigoInspeccion]));
                     try
                        aInspGNC_Auxi.Open;

                        if (aInspGNC_Auxi.ValueByName[FIELD_TIPO] = T_GNCRC) then
                        begin
                            aFtmp.Hide;
                            MessageDlg (Application.Title, 'La inspección es RC y no tiene asociada número de oblea', mtInformation, [mbOk], mbOk, 0);
                        end
                        else if (aInspGNC_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                        begin
                            aFtmp.Hide;
                            MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                        end
                        else
                        begin
                            aVehiculo_Auxi := aInspGNC_Auxi.GetVehiculo;
                            If aVehiculo_Auxi=nil
                            then begin
                                Messagedlg(Application.Title,'Vehículo No encontrado',mtInformation,[mbyes],mbyes,0);
                                Exit;
                            end;
                            try
                              aVehiculo_Auxi.Open;
                              sMatricula_Auxi := aVehiculo_Auxi.GetPatente;
                            finally
                                 aVehiculo_Auxi.Close;
                                 aVehiculo_Auxi.Free;
                            end;
                            GenerarInformeGNC_Reimpresion;
                        end;
                     finally
                          aInspGNC_Auxi.Free;
                     end;
                 end
              finally
                   aFTmp.Free;
              end;
          end;
       finally
            frmReimpresionTAmarilla_Auxi.Free;
       end;
    finally
        //If Assigned(aInspeccion_Auxi) then aInspeccion_Auxi.Free;
    end;
end;

procedure ReimpresionInformesMedicion;
var
  frmReimpresionCertificados_Auxi: TfrmReimpresionCertificados;
  aVehiculo_Auxi: TVehiculo;
  aInspeccion_Auxi: TInspeccion;
  aRowId, sMatricula_Auxi: string;
  aFTmp: TFTmp;

   /////////////////////////////////////////////////////////////////////////////
   procedure GenerarInfMedicion_Reimpresion;
   begin
        aFtmp.Hide;
       if (aInspeccion_Auxi.VerImprimirInformeMedicion (strtoint(aInspeccion_Auxi.valueByName[FIELD_EJERCICI]), strtoint(aInspeccion_Auxi.valueByName[FIELD_CODINSPE]), nil, true)) then
       begin
          EnviarTrabajo_ServidorImpresion (aInspeccion_Auxi.ValueByName[FIELD_EJERCICI],aInspeccion_Auxi.ValueByName[FIELD_CODINSPE],sMatricula_Auxi, Medicion);
          {$IFDEF CRICA}
          doImprimeMedAuto(aInspeccion_Auxi);
          {$ENDIF}
       end;
   end;
   /////////////////////////////////////////////////////////////////////////////
begin
    try
       frmReimpresionCertificados_Auxi := TfrmReimpresionCertificados.CreateFromInforme (StrToInt(fVarios.ValueByName[FIELD_ZONA]),StrToInt(fVarios.ValueByName[FIELD_ESTACION]));
       try
          if (frmReimpresionCertificados_Auxi.ShowModal = mrOk) then
          begin
              aFTmp := TFTmp.Create (Application);
              try
                 aFTmp.MuestraClock ('Informe de Inspección', 'Generando Un Informe De Inspección...');

                 if (frmReimpresionCertificados_Auxi.ChkBxBusquedaMatricula.Checked) then
                 begin
                    If frmReimpresionCertificados_Auxi.RowidVehiculo<>''
                    then begin
                         aVehiculo_Auxi := TVehiculo.CreateByRowid (MyBD, frmReimpresionCertificados_Auxi.RowidVehiculo);
                         try
                            aVehiculo_Auxi.Open;
                            aInspeccion_Auxi := aVehiculo_Auxi.GetInspections;
                            sMatricula_Auxi := aVehiculo_Auxi.GetPatente;

                             If aInspeccion_Auxi<>nil then aInspeccion_Auxi.Open
                             else begin
                                Messagedlg(Application.Title,'Vehículo Sin Inspecciones',mtInformation,[mbyes],mbyes,0);
                                Exit;
                             end;

                            if (aInspeccion_Auxi.RecordCount = 0) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'El vehículo no tiene asociada ninguna inspección', mtInformation, [mbOk], mbOk, 0);
                                exit;
                            end
                            else
                            begin
                                aInspeccion_Auxi.Last;
                                //Hay que tomar la última inspección finalizada
                                while ((aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) and (not aInspeccion_Auxi.Bof)) do
                                begin
                                    aInspeccion_Auxi.Prior;
                                end;
                            end;

                            if (aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                            begin
                                aFtmp.Hide;
                                MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                            end
                            else
                            begin
                                aVehiculo_Auxi.Close;
                                try
                                   aRowId := aInspeccion_Auxi.ValueByName[FIELD_ROWID];
                                   aInspeccion_Auxi.Free;
                                   aInspeccion_Auxi := TInspeccion.CreateByRowId (MyBD, aRowId);
                                   aInspeccion_Auxi.Open;
                                   GenerarInfMedicion_Reimpresion;
                                finally
                                     aInspeccion_Auxi.Free;
                                end;
                            end;
                         finally
                              aVehiculo_Auxi.Free;
                         end;
                    end
                    else begin
                        aFtmp.Hide;
                        MessageDlg (Application.Title, 'Vehiculo No Encontrado', mtInformation, [mbOk], mbOk, 0);
                        Exit;
                    end;
                 end
                 else begin
                     aInspeccion_Auxi := nil;
                     aInspeccion_Auxi := TInspeccion.Create (MyBD, Format ('where a.%s=%d and a.%s=%d',[FIELD_EJERCICI,frmReimpresionCertificados_Auxi.Ejercicio, FIELD_CODINSPE,frmReimpresionCertificados_Auxi.CodigoInspeccion]));
                     try
                        aInspeccion_Auxi.Open;
                        if (aInspeccion_Auxi.ValueByName[FIELD_INSPFINA] <> INSPECCION_FINALIZADA) then
                        begin
                            aFtmp.Hide;
                            MessageDlg (Application.Title, 'La inspección introducida no se ha finalizado.', mtInformation, [mbOk], mbOk, 0);
                        end
                        else
                        begin
                            aVehiculo_Auxi := aInspeccion_Auxi.GetVehiculo;
                            If aVehiculo_Auxi=nil
                            then begin
                                Messagedlg(Application.Title,'Vehículo No encontrado',mtInformation,[mbyes],mbyes,0);
                                Exit;
                            end;
                            try
                              aVehiculo_Auxi.Open;
                              sMatricula_Auxi := aVehiculo_Auxi.GetPatente;
                            finally
                                 aVehiculo_Auxi.Close;
                                 aVehiculo_Auxi.Free;
                            end;

                            GenerarInfMedicion_Reimpresion;
                        end;
                     finally
                          aInspeccion_Auxi.Free;
                     end;
                 end;
              finally
                   aFTmp.Free;
              end;
          end;
       finally
            frmReimpresionCertificados_Auxi.Free;
       end;
    finally
        //If Assigned(aInspeccion_Auxi) then aInspeccion_Auxi.Free;
    end;
end;



(*procedure InspeccionesDiferidas;
var
  frmInformesDiferidos_Auxi: TfrmInformesDiferidos;

begin
    frmInformesDiferidos_Auxi := nil;
    try
       frmInformesDiferidos_Auxi := TfrmInformesDiferidos.CreateFromInformeDiferido;
       frmInformesDiferidos_Auxi.ShowModal;
    finally
         frmInformesDiferidos_Auxi.Free;
    end;
end;*)

end.
