unit ufImportaProvincia;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Globals, uSagClasses, USagEstacion, ucdialgs, utiloracle;

type
  TfrmImportaProvincia = class(TForm)
    btnImportar: TBitBtn;
    btnSalir: TBitBtn;
    OpenDialog1: TOpenDialog;
    procedure btnSalirClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fDatosProvincia : TDatosProvincia;
    procedure ImportarDatos(aDatos: string);
  public
    { Public declarations }
  end;

  procedure DoImportaProvincia;

var
  frmImportaProvincia: TfrmImportaProvincia;

implementation

{$R *.DFM}

uses
  UUTILS, uLogs, UFTMP;

resourcestring
  FICHERO_ACTUAL = 'ufImportaProvincia';

procedure DoImportaProvincia;
begin
  with TfrmImportaProvincia.Create(application) do
   try
     showmodal;
   finally
     free;
   end;
end;

procedure TfrmImportaProvincia.btnSalirClick(Sender: TObject);
begin
  close;
end;

procedure TfrmImportaProvincia.btnImportarClick(Sender: TObject);
var
  F: TextFile;
  S: string;
begin
  try

    DeleteTable(MyBD, 'DATOS_PROVINCIA');
    if OpenDialog1.Execute then
    begin
      FTmp.Temporizar(TRUE,FALSE,'Importación Provincia Seguros', 'Importando los datos de Provincia Seguros.');
      Application.ProcessMessages;

      AssignFile(F, OpenDialog1.FileName);
      Reset(F);
      while True do
      begin
        Readln(F, S);
        try
          if S = '' then Break
          else begin
            ImportarDatos (s);
          end;
        finally
        end;
      end;
      CloseFile(F);
    end;
    mybd.Commit(td);

    FTmp.Temporizar(FALSE,FALSE,'', '');
    Application.ProcessMessages;

    MessageDlg('Importación Provincia Seguros.', 'Importación Realizada con Exito', mtInformation, [mbOk], mbOk, 0)
  except
     on E: Exception do
     begin
        mybd.rollback(td);
        FTmp.Temporizar(FALSE,FALSE,'', '');
        Application.ProcessMessages;
        FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Importación Provincia Seguros Cancelada por: %s', [E.message]);
        MessageDlg('Importación Provincia Seguros.', 'Importación Provincia Seguros Cancelada por: ' + E.message, mtError, [mbOk], mbOk, 0)
     end
  end;
end;

procedure TfrmImportaProvincia.ImportarDatos(aDatos: string);
begin
  try
          fDatosProvincia.Append;
          fDatosProvincia.ValueByName[FIELD_PATENTE] := copy(aDatos,1,9) ;
          fDatosProvincia.ValueByName[FIELD_MOTOR] := copy(aDatos,10,24) ;
          fDatosProvincia.ValueByName[FIELD_CHASIS] := copy(aDatos,34,24) ;
          fDatosProvincia.ValueByName[FIELD_ANO] :=copy(aDatos,58,4) ;
          fDatosProvincia.ValueByName[FIELD_MARCA] :=copy(aDatos,62,30) ;
          fDatosProvincia.ValueByName[FIELD_MODELO]:=copy(aDatos,92,30) ;
          fDatosProvincia.ValueByName[FIELD_NROPOLIZA] := copy(aDatos,122,9);
          fDatosProvincia.ValueByName[FIELD_CERTIFICADO] := copy(aDatos,131,7);
          fDatosProvincia.ValueByName[FIELD_ASEGURADO] := copy(aDatos,138,80);
          fDatosProvincia.ValueByName[FIELD_TIPODOC] := copy(aDatos,218,3) ;
          fDatosProvincia.ValueByName[FIELD_NRODOC] :=copy(aDatos,221,13) ;
          fDatosProvincia.ValueByName[FIELD_TIPOVENTA] := copy(aDatos,234,1);
          fDatosProvincia.ValueByName[FIELD_FECHA] := DateBD(mybd);
          fDatosProvincia.Post(true);
  except
     on E: Exception do
     begin
        FAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,1,FICHERO_ACTUAL,'Error al intentar ingresar un registro a la tabla DATOS_PROVINCIA por: %s', [E.message]);
        MessageDlg('Importación Provincia Seguros.', 'Error al intentar ingresar un registro a la tabla DATOS_PROVINCIA por: ' + E.message, mtError, [mbOk], mbOk, 0)
     end
  end;

end;


procedure TfrmImportaProvincia.FormCreate(Sender: TObject);
begin
  mybd.StartTransaction(td);
  fDatosProvincia := TDatosProvincia.CreateByRowId(mybd,'');
  fDatosProvincia.Open;
end;

procedure TfrmImportaProvincia.FormDestroy(Sender: TObject);
begin
  if MyBD.InTransaction then MyBD.Rollback(td);
  fDatosProvincia.close;
  fDatosProvincia.Free;
end;

end.
