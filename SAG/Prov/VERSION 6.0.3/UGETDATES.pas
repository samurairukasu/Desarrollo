unit UGetDates;

{ Unidad encargada de recoger las fechas por teclado, la salida es
  Fecha Inicial + 00h:00m:00s, Fecha Final + 23h:59m:59ss}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit;

type

  TFGetDates = class(TForm)
    Bevel1: TBevel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Label1: TLabel;
    lblHasta: TLabel;
    DEFechaInicial: TDateEdit;
    DEFechaFinal: TDateEdit;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    OldDateFormat : string;
    function IntervalDatesOk : boolean;
    function GetFechaInicial : string;
    function GetFechaFinal : string;
  public
    property FechaInicial : string read GetFechaInicial;
    property FechaFinal : string read GetFechaFinal;
  end;

   Function GetDates (var vFechaIni, vFechaFin: string): Boolean;

var
  FGetDates: TFGetDates;

implementation

{$R *.DFM}

uses
   UCDIALGS,
   ULOGS,
   GLOBALS,
   dateutil,
   UTILORACLE,
   ugacceso,
   usagctte;


const
    CABECERA_MENSAJES_BUSFECH = 'Buscar por fecha';
    FICHERO_ACTUAL = 'UGetDates.pas';
   { Hints enviados al usuario desde la unidad MBusFech }
{    HNT_MBUSCFECH_FINI = 'Pinche sobre el calendario para introducir la fecha inicial|Fecha de comienzo de la búsqueda. Formato: dd/mm/yyyy';
    HNT_MBUSCFECH_FFIN = 'Pinche sobre el calendario para introducir la fecha final|Fecha de finalización de la búsqueda. Formato: dd/mm/yyyy';
    HNT_MBUSCFECH_ACEPTAR = 'Llevar a cabo la búsqueda señalada|Selecciona un rango de valores entre las fechas seleccionadas';
    HNT_MBUSCFECH_CANCELAR = 'Cancela la búsqueda|NO selecciona un rango de valores entre las fechas seleccionadas';
}


function TFgetDates.GetFechaFinal : string;
begin
    result := Copy(DEFechaFinal.Text,1,10) + ' 23:59:59';
end;

function TFgetDates.GetFechaInicial : string;
begin
    result := Copy(DEFechaInicial.Text,1,10) + ' 00:00:00';
end;

procedure TFGetDates.btnAceptarClick(Sender: TObject);
begin
    if not IntervalDatesOk
    then begin
        MessageDlg (Caption,'La fecha de inicio debe ser menor o igual que la fecha final.', mtInformation, [mbOk], mbOk, 0);
        DEFechaInicial.setfocus;
    end
    else ModalResult := mrOK
end;

procedure TFGetDates.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TFGetDates.FormCreate(Sender: TObject);
begin
    OldDateFormat := LongDateFormat;
    LongDateFormat := 'dd/mm/yyyy hh:nn:ss';
    if PasswordUser = MASTER_KEY then
    begin
      DEFechaInicial.Text := Copy(datetimetostr(firstdayofprevmonth),1,10);
      DEFechaFinal.Text := datetimetostr(lastdayofprevmonth);
      exit;
    end;
    DEFechaInicial.Text := Copy(DateTimeBD(MyBD),1,10);
    DEFechaFinal.Text := DEFechaInicial.Text
end;


function TFGetDates.IntervalDatesOk : boolean;
begin
    result :=  ValidDate(DEFechaInicial.Date) and ValidDate(DEFechaFinal.Date) and (DEFechaInicial.Date <= DEFechaFinal.Date) 
end;


procedure TFGetDates.FormDestroy(Sender: TObject);
begin
    LongDateFormat := OldDateFormat
end;

Function GetDates (var vFechaIni, vFechaFin: string):Boolean;
begin
    Result:=FalsE;
    try
        with TFGetDates.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                vFechaIni := FechaInicial;
                vFechaFin := FechaFinal;
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;

end.


