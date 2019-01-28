unit UGetDates;

{ Unidad encargada de recoger las fechas por teclado, la salida es
  Fecha Inicial + 00h:00m:00s, Fecha Final + 23h:59m:59ss}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit, uUtiles;

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
//    function IntervalDatesOk : boolean;
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
uses
  DateUtil;
{$R *.DFM}

const
    CABECERA_MENSAJES_BUSFECH = 'Buscar por fecha';


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
    if not IntervalDatesOk(DEFechaInicial.Date,DEFechaFinal.Date)
    then begin
        application.messagebox('La fecha de inicio debe ser menor o igual que la fecha final.',pchar(caption), mb_ok+mb_iconexclamation+mb_applmodal);
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
    LongDateFormat := 'dd/mm/yyyy';

    DEFechaInicial.Text := Copy(datetostr(Date),1,10);
    DEFechaFinal.Text := DEFechaInicial.Text;

end;


//function TFGetDates.IntervalDatesOk : boolean;
//begin
//    result :=  ValidDate(DEFechaInicial.Date) and ValidDate(DEFechaFinal.Date) and (DEFechaInicial.Date <= DEFechaFinal.Date)
//end;


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


