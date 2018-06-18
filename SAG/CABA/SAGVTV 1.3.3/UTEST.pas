unit UTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls, Printers, StdCtrls, UTiposPr, UCDialgs, Buttons, ULogs;

const
  FICHERO_ACTUAL = 'UTest.pas';
type
  TFormTest = class(TForm)
    Panel4: TPanel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    MemoDisponibles: TMemo;
    MemoNoDisponibles: TMemo;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure MemoDisponiblesClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTest: TFormTest;

implementation

{$R *.DFM}

procedure TFormTest.FormActivate(Sender: TObject);
var
  i : integer;
  Impresoras : TPrinter;
//  Asa :  HDC;
begin
 Impresoras:= nil;
 try
   try
     Impresoras := TPrinter.Create;
     MemoDisponibles.Lines.Clear;
     MemoNoDisponibles.Lines.Clear;
     with Impresoras do
     begin
       for I := 0 to (Printers.Count - 1)  do
       begin
         try
           PrinterIndex := i;
//           Asa := Handle;
           MemoDisponibles.Lines.Add(Printers[i]);
         except
           MemoNoDisponibles.Lines.Add(Printers[i]);
         end;
       end;
     end;
   except
     on E : Exception do
     begin
       fIncidencias.PonAnotacion(TRAZA_SIEMPRE,0,FICHERO_ACTUAL,'ERROR REALIZANDO EL TEST: ' + E.message);
       MessageDlg('Test de Impresoras','Hubo un error al realizar el test, si el error persiste contacte con su Administrador',
                   mtError, [mbOk], mbOk, 0);
       ModalResult := mrCancel;
     end;
   end;
 finally
   Impresoras.Free;
 end;
end;


procedure TFormTest.MemoDisponiblesClick(Sender: TObject);
begin
 Panel5.SetFocus;
end;

procedure TFormTest.SpeedButton1Click(Sender: TObject);
begin
  ModalResult := MrOk;
end;

end.
