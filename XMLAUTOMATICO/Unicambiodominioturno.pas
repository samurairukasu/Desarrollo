unit Unicambiodominioturno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tcambiodominioturno = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cambiodominioturno: Tcambiodominioturno;

implementation

uses Ufrmturnos;

{$R *.dfm}

procedure Tcambiodominioturno.BitBtn1Click(Sender: TObject);
begin
CLOSE;
end;

procedure Tcambiodominioturno.BitBtn2Click(Sender: TObject);
begin
IF TRIM(EDIT1.Text)='' THEN
BEGIN
Application.MessageBox( 'ERROR CON EL TURNOID',
  'Acceso denegado', MB_ICONSTOP );
  EXIT;
END;


IF TRIM(EDIT3.Text)='' THEN
BEGIN
Application.MessageBox( 'DEBE INGRESAR LA PATENTE NUEVA',
  'Acceso denegado', MB_ICONSTOP );
  EXIT;
END;


self.BitBtn1.Enabled:=falsE;
frmturnos.Inicializa;
frmturnos.ControlServidor;
if (frmturnos.disponibilidad_servidor='true') AND (frmturnos.respuestaidservidor=1) THEN
begin

  //ver_respuestamensajeservidor);
  APPLICATION.ProcessMessages;
  frmturnos.Abrir_Seccion;
    if frmturnos.respuestaid_Abrir=1 then
     begin
       //self.respuestamensaje_Abrir;

          if frmturnos.cambiar_dominio_en_turno(strtoint(edit1.text),trim(edit2.text),trim(edit3.text))=true then
                begin
                 if fileexists(ExtractFilePath(Application.ExeName) +'cambiopatente'+trim(edit1.text)+'.xml') then
                      begin
                       if frmturnos.generar_archivo('cambiopatente'+trim(edit1.text))=true then
                         begin
                             frmturnos.leer_respuesta_CAMBIOPATENTE('cambiopatente'+trim(edit1.text)+'.txt',strtoint(edit1.text),trim(edit3.text));
                         end;

                     end;



        frmturnos.Cerrar_seccion;
         
        self.BitBtn1.Enabled:=true;
        end else
         begin
          //error al abrir
         end;

end
else
begin
//error de servidor
//ver_respuestamensajeservidor);
end;



end;

 self.BitBtn1.Enabled:=true;
 


end;

end.