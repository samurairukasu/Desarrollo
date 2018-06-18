unit Ufrconfiguracion_impresoras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, UVERSION,
  Dialogs, StdCtrls, Buttons, ComCtrls,printers,globals, usuperregistry, SQLEXPR, DBXpress;

type
  Tfrconfiguracion_impresoras = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    Edit4: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frconfiguracion_impresoras: Tfrconfiguracion_impresoras;

implementation

{$R *.dfm}

procedure Tfrconfiguracion_impresoras.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tfrconfiguracion_impresoras.FormCreate(Sender: TObject);
var i,NRO:longint;
begin

with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(II_) then
      begin
      Application.MessageBox( 'No se encontraron los par�metros NROPC de la Estaci�n de Trabajo.',
  'Acceso denegado', MB_ICONSTOP );
        //  Messagedlg('ERROR','No se encontraron los par�metros de la Estaci�n de Trabajo', mtInformation, [mbOk],mbOk,0);

       EXIT;
      end
      else
      begin
        NRO :=strtoint(ReadString('NROPC'));

      end;


      FINALLY
       FREE;
      END;



edit3.Clear;
edit1.Clear;
edit2.Clear;

  With TSQLQuery.Create(nil) do
     try
        SQLConnection:=mybd;
        Close;
        SQL.Clear;
        sql.add('select IMPRESION,NOMBREIMPRESORA,IZQUIERDO,SUPERIOR from CONFIGURACIONIMPRESORA where impresion=:IMPRE  AND NROPC=:NROPC');
        ParamByName('IMPRE').Value:='II';
        ParamByName('NROPC').Value:=NRO;
        open;
        edit3.Text:=trim(fieldbyname('NOMBREIMPRESORA').asstring);
        edit1.Text:=trim(fieldbyname('IZQUIERDO').asstring);
        edit2.Text:=trim(fieldbyname('SUPERIOR').asstring);
        finally
           Close;
           Free;
     end;

EDIT4.TEXT:=INTTOSTR(NRO);
combobox1.Clear;
for I := 0 to Printer.Printers.Count - 1 do

  begin

      combobox1.Items.Add(Printer.Printers.Strings[I])


  end;
end;

procedure Tfrconfiguracion_impresoras.ComboBox1Change(Sender: TObject);
begin
edit3.Text:=trim(combobox1.Text);
end;

procedure Tfrconfiguracion_impresoras.BitBtn1Click(Sender: TObject);
var impresora,izquierdo, superior:string;
NRO:LONGINT;
begin

 if trim(edit3.Text)='' then
 begin
 showmessage('Debe seleccionar la impresora');
  exit;
 end;

impresora:=trim(edit3.Text);
NRO:=STRTOINT(EDIT4.Text);
if trim(edit1.Text)='' then
    izquierdo:='0'
    else
    izquierdo:=trim(edit1.Text);


if trim(edit2.Text)='' then
    superior:='0'
    else
    superior:=trim(edit2.Text);


          try
                With TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                      sql.add('delete from CONFIGURACIONIMPRESORA where IMPRESION=:IMPRE  AND NROPC=:NROPC');
                      ParamByName('IMPRE').Value:='II';
                      ParamByName('NROPC').Value:=NRO;
                      execsql;

                      finally
                        Close;
                        Free;
                     end;

               With TSQLQuery.Create(nil) do
                try
                    SQLConnection:=mybd;
                    Close;
                    SQL.Clear;

                      sql.add('insert into CONFIGURACIONIMPRESORA(IMPRESION,NOMBREIMPRESORA,IZQUIERDO,SUPERIOR,NROPC) values(:IMPRE,:NOMBREIMPRESORA,:IZQUIERDO,:SUPERIOR,:NROPC) ');
                      ParamByName('IMPRE').Value:='II';
                      ParamByName('NOMBREIMPRESORA').Value:=trim(impresora);
                      ParamByName('IZQUIERDO').Value:=trim(izquierdo);
                      ParamByName('SUPERIOR').Value:=trim(superior);
                      ParamByName('NROPC').Value:=NRO;

                      execsql;

                      finally
                        Close;
                        Free;
                     end;
                Application.MessageBox( 'Se ha guardado la configuraci�n correctamente.', 'Atenci�n',
              MB_ICONINFORMATION );
           except
              Application.MessageBox( 'Se produjo un error al intentar guardar la configuraci�n.',
                       'Atenci�n', MB_ICONSTOP );
           end;


end;

end.