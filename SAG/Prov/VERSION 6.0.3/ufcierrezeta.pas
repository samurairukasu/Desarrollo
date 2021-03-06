unit ufcierrezeta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  StdCtrls, ExtCtrls, Buttons,
  EPSON_Impresora_Fiscal_TLB,usuperregistry,UVERSION,
  ComObj,
  UCONST,
  UTILORACLE,
  USAGCLASSES,
  USAGDATA,
  USAGESTACION,
  DB,
  DateUtil, Grids, DBGrids, UUtils, OleCtrls, OCXFISLib_TLB, RxGIF,
  EpsonFPHostControlX_TLB;

type
  Tfcierrezeta = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Label1: TLabel;
    lblnumero: TLabel;
    Bevel2: TBevel;
    Timer1: TTimer;
    lblfechora: TLabel;
    lblfecha: TLabel;
    lblok: TLabel;
    Image1: TImage;
    DriverFiscal1: TDriverFiscal;
    procedure FormCreate(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    impfis: _PrinterFiscalDisp;
    FCierrez: TCierrez;
    FPtoVenta: TPtoVenta;
    procedure datosencabezado;
  public
    { Public declarations }
  end;

procedure DoCierreZ(aForm: Tform);

var
  fcierrezeta: Tfcierrezeta;
  tipocierre, tipostatus, imprime:widestring;


implementation

uses
    GLOBALS;


{$R *.DFM}


procedure Tfcierrezeta.FormCreate(Sender: TObject);
var x:byte;
begin
  impfis:=nil;
  impfis := CreateComObject(CLASS_PrinterFiscal) as _PrinterFiscalDisp;
  impfis.PortNumber:=PortNumber;
  impfis.BaudRate:=BaudRate;
  FCierrez:= nil;
  FPtoVenta:= nil;
  FCierrez:=Tcierrez.create(MyBD);
  FPtoVenta:=TPtoVenta.create(MyBD);
end;

procedure Tfcierrezeta.btnAceptarClick(Sender: TObject);
var accion,hora,fecha,dfnumero,texto:widestring;
    horastring:string;
    err,velocidad:longint;
    Nro_caja:longint;
puertocom,com_puerto,cancelado:string;
 tipo:longint ;

   NROULTIM:string;
   archilog:textfile;
   destlog,linea:string;

begin
destlog:=ExtractFilePath(Application.ExeName) + 'Log_controlador.txt';
assignfile(archilog,destlog);

 if not fileexists(destlog) then
    rewrite(archilog)
    else
    append(archilog);

   linea:='**************************'+datetostr(date)+'**************************';
  writeln(archilog,linea);

with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
      begin
          Messagedlg('ERROR','No se pueder leer el Controlador Predeterminado', mtInformation, [mbOk],mbOk,0);
           linea:='No se pueder leer el Controlador Predeterminado del Registro de windows';
           writeln(archilog,linea);
      end
      else
      begin
        tipo := ReadInteger(PRINTER_);
        puertocom:='COM'+Readstring(PortNumber_);
            linea:='Lee Puerto y Tipo de Contolador';
            writeln(archilog,linea);
            linea:='Puerto: '+puertocom;
            writeln(archilog,linea);
            linea:='Tipo CF: '+inttostr(tipo);
            writeln(archilog,linea);
      end;
     finally
       free;
     end;



if (tipo = 3) or (tipo = 4) then
begin
 DriverFiscal1.Printer:='TM2000';

 velocidad:=9600;
 err :=DriverFiscal1.IF_OPEN(puertocom,velocidad);
            linea:='Abre Puerto para controlador';
            writeln(archilog,linea);

   DriverFiscal1.SerialNumber:='27-0163848-435';
            if err<>0 then
  begin
  DriverFiscal1.IF_CLOSE;
  linea:='Error al abrir el puerto';
            writeln(archilog,linea);
            closefile(archilog);
   exit;
  end;
  fcierrez.Append;

 //   datosencabezado;

      err := DriverFiscal1.IF_WRITE('@ESTADO|N');
            linea:='Prepara el Estado @ESTADO|N';
            writeln(archilog,linea);


        if err<>0 then
  begin
  DriverFiscal1.IF_CLOSE;
  linea:='Error al preparar el estado de impresion en el controlador. @ESTADO';
            writeln(archilog,linea);
            closefile(archilog);
   exit;
  end;



    with fcierrez do
  begin
      valuebyname[FIELD_AUDIPARC]:=DriverFiscal1.IF_READ(7);
      valuebyname[FIELD_AUDITOTA]:=DriverFiscal1.IF_READ(8);
      valuebyname[FIELD_CODIMPRE]:=DriverFiscal1.IF_READ(9);
      valuebyname[FIELD_TEXTAUDI]:=DriverFiscal1.IF_READ(10);
  end;

 err :=DriverFiscal1.IF_WRITE('@CIERREZ|...');
             linea:='Realiza Cierre Z... @CIERREZ|';
            writeln(archilog,linea);

 if err<>0 then
  begin
  DriverFiscal1.IF_CLOSE;
  linea:='Error en Cierre Z. Genera el X y Despues el Z para probar reimprimir el Z';
            writeln(archilog,linea);

    
  err :=DriverFiscal1.IF_OPEN(puertocom,velocidad);





  err :=DriverFiscal1.IF_WRITE('@CIERREX|...');
  err :=DriverFiscal1.IF_WRITE('@CIERREZ|...');
  end;

    with fcierrez do
  begin
    NROULTIM:=DriverFiscal1.IF_READ(3);
          Valuebyname[FIELD_NROULTIM]:=NROULTIM;

          cancelado:=DriverFiscal1.IF_READ(4);

          valuebyname[FIELD_FECHORPRIM]:=datetimetostr(now);
          ValueByName[FIELD_FECHAPC]:=datetimetostr(now);
          Valuebyname[FIELD_NROBCOK]:=DriverFiscal1.IF_READ(9);
          valuebyname[FIELD_NROBCIMP]:=DriverFiscal1.IF_READ(7);
          valuebyname[FIELD_NROAOK]:=DriverFiscal1.IF_READ(13);
          valuebyname[FIELD_NROAIMPR]:=DriverFiscal1.IF_READ(8);
          valuebyname[FIELD_NRODNF]:=DriverFiscal1.IF_READ(6);
          valuebyname[FIELD_NRODNFH]:=DriverFiscal1.IF_READ(5);

          //modificacion setiembre 2010

          with TSuperRegistry.Create do
          try
            RootKey := HKEY_LOCAL_MACHINE;
                if not OpenKeyRead(CAJA_) then
                 begin
                  Nro_caja:=0;
                 end
                  else
                   begin
                    Nro_caja := ReadInteger(NROCAJA_);
                     valuebyname[FIELD_PVENTA]:=inttostr(Nro_caja);
                   end;
         finally
        free;
       end;



          //valuebyname[FIELD_NROREFNF]:=





   end;

  lblnumero.caption:='N� '+inttostr(strtoint(DriverFiscal1.IF_READ(3)));
  lblfecha.caption:=datetostr(date+1)+' '+timetostr(time+1);

  DriverFiscal1.IF_CLOSE;

   if fcierrez.DataSet.State In [dsEdit,dsInsert]  then
   begin
    linea:='Post en la Base';
          writeln(archilog,linea);
    fcierrez.post(true);
   end;
  btnAceptar.Enabled:=falsE;
   linea:='**************************FIN**************************';
   writeln(archilog,linea);    
end
else
begin
  btnaceptar.Enabled:=false;
  datosencabezado;
  tipostatus:='N';
  impfis.Status(Tipostatus);    
  btncancelar.enabled:=true;
  imprime:='P';
  tipocierre:='Z';
  fcierrez.Append;
  with fcierrez do
  begin
          Valuebyname[FIELD_NROULTIM]:=impfis.AnswerField_6;
          valuebyname[FIELD_AUDIPARC]:=impfis.answerfield_7;
          valuebyname[FIELD_AUDITOTA]:=impfis.answerfield_8;
          valuebyname[FIELD_CODIMPRE]:=impfis.answerfield_9;
          valuebyname[FIELD_TEXTAUDI]:=impfis.answerfield_10;
          valuebyname[FIELD_FECHORPRIM]:=datetimetostr(devolverfecha(impfis.AnswerField_4+' '+impfis.AnswerField_5));
          ValueByName[FIELD_FECHAPC]:=datetimetostr(now);
          dfnumero:=COLA_FORPAGO_1;
          texto:=#127;
          accion:='S';
          impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
          dfnumero:=COLA_FORPAGO_3;
          impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
          dfnumero:=COLA_FORPAGO_2;
          impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
          dfnumero:=COLA_CAJERO_1;
          impfis.SetGetHeaderTrailer(accion,dfnumero,texto);

          tipostatus:='A';
          impfis.Status(Tipostatus);
          Valuebyname[FIELD_NROBCOK]:=impfis.AnswerField_4;
          valuebyname[FIELD_NROBCIMP]:=impfis.answerfield_5;
          valuebyname[FIELD_NROAOK]:=impfis.answerfield_6;
          valuebyname[FIELD_NROAIMPR]:=impfis.answerfield_7;
          valuebyname[FIELD_NRODNF]:=impfis.answerfield_8;
          valuebyname[FIELD_NRODNFH]:=impfis.answerfield_9;
          valuebyname[FIELD_NROREFNF]:=impfis.answerfield_10;
          valuebyname[FIELD_PVENTA]:='2';
       end;
  if impfis.CloseJournal(tipocierre,imprime) then
  begin
    if fcierrez.DataSet.State In [dsEdit,dsInsert]  then fcierrez.post(true);
    tipostatus:='N';
    impfis.Status(Tipostatus);
    lblnumero.caption:='N� '+inttostr(strtoint(impfis.AnswerField_6));
    accion:='G';
    hora:=#127;
    fecha:=#127;
    impfis.SetGetDateTime(accion,fecha,hora);
//    fecha:=impfis.AnswerField_3;
    fecha:=DateBD(mybd);
    fecha:=copy(fecha,9,2)+copy(fecha,4,2)+copy(fecha,1,2);
    accion:='S';
//    horastring:=timetostr(time);
    horastring:=TimeBD(mybd);
    while pos(':',horastring) > 0 do
          delete(horastring,pos(':',horastring),1);
    hora:=horastring;
    impfis.SetGetDateTime(accion,fecha,hora);


    lblfechora.Visible:=false;
    lblfecha.visible:=false;
    lblok.visible:=true;
    cierrezok:=true;
  end
  else
  begin
    fcierrez.cancel;
    btnaceptar.Enabled:=True;
  end;


end;//if tipo
 closefile(archilog);
end;

procedure DoCierreZ(aForm: Tform);
var
    frmcierrez: Tfcierrezeta;
begin
    aForm.Enabled := False;
    try
          frmcierrez := Tfcierrezeta.Create(Application);
          try
                frmcierrez.ShowModal;

          finally
               frmcierrez.Free;
          end;
    finally
         aForm.Enabled := True;
         aForm.Show;
    end;

end;

procedure Tfcierrezeta.FormActivate(Sender: TObject);
begin
      tipostatus:='N';
      if impfis.Status(Tipostatus) then
      begin
        if (strtoint(impfis.AnswerField_4) = 0) then
        begin
          showmessage('Cierre Z','No se han realizado movimientos desde el �ltimo Cierre de Jornada.'+
          #13+'No se puede generar un nuevo Cierre de Jornada.');
          btnaceptar.Enabled:=false;
        end
        else
        begin
          lblnumero.caption:='N� '+inttostr(strtoint(impfis.AnswerField_6));
          lblfecha.caption:=datetimetostr(devolverfecha(impfis.AnswerField_4+' '+impfis.AnswerField_5)+1);
        end;
      end
      else
        timer1.enabled:=true;
end;

procedure Tfcierrezeta.Timer1Timer(Sender: TObject);
begin
    impfis.Status(Tipostatus);
    lblnumero.caption:='N� '+inttostr(strtoint(impfis.AnswerField_6));
    lblfecha.caption:=datetimetostr(devolverfecha(impfis.AnswerField_4+' '+impfis.AnswerField_5)+1);
    timer1.enabled:=false;
end;

procedure TFcierrezeta.datosencabezado;
var dfnumero,texto,accion: widestring;
    fdatosestacion: TDatos_Estacion;
begin
  try
      fdatosestacion:=nil;
      fdatosestacion:= tdatos_estacion.create(MyBd);
      fdatosestacion.Open;
      accion := 'S';
      dfnumero:=ENCA_FANTASIA;
      texto:=#245+fdatosestacion.valuebyname[FIELD_NOMFANTASIA];
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_RSOCIAL;
      texto:=fdatosestacion.valuebyname[FIELD_RSOCIAL];
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_L3;
      texto:=#127;
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_L4;
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_L5;
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_L6;
//      texto:='('+stringparacf(fdatosestacion.valuebyname[FIELD_CODPOSTA])+') - '+stringparacf(fdatosestacion.valuebyname[FIELD_LOCALIDAD]);
      texto:=stringparacf(fdatosestacion.valuebyname[FIELD_CALLECOM]);
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_L7;
      texto:='TEL: '+stringparacf(fdatosestacion.valuebyname[FIELD_TELEFONOS]);
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_L8;
      texto:='II BB: '+fdatosestacion.valuebyname[FIELD_INSINGBRUT];
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_L9;
      texto:='Inicio de Actividad: '+fdatosestacion.valuebyname[FIELD_FECHINIACT];
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_IB_1;
      texto:='II BB: '+fdatosestacion.valuebyname[FIELD_INSINGBRUT];
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_DOMIC_1;
      texto:=stringparacf(fdatosestacion.valuebyname[FIELD_CALLECOM]);
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_DOMIC_2;
      if (fdatosestacion.valuebyname[FIELD_CODPOSTA] = '') and (fdatosestacion.valuebyname[FIELD_LOCALIDAD] = '') then
        texto:= #127
      else
        texto:= '('+stringparacf(fdatosestacion.valuebyname[FIELD_CODPOSTA])+') - '+stringparacf(fdatosestacion.valuebyname[FIELD_LOCALIDAD]);
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_TELEFONO;
      texto:='TEL: '+stringparacf(fdatosestacion.valuebyname[FIELD_TELEFONOS]);
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
      dfnumero:=ENCA_FECINI;
      texto:='Inicio de Actividad: '+fdatosestacion.valuebyname[FIELD_FECHINIACT];
      impfis.SetGetHeaderTrailer(accion,dfnumero,texto);
  finally
      fDatosEstacion.close;
      fDatosestacion.free;
  end;
end;


procedure Tfcierrezeta.FormDestroy(Sender: TObject);
begin
    FCierrez.free;
    FPtoVenta.free;
end;

end.
