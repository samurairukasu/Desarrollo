unit Unitmodificar_nro_oblea_rucara;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons,
   ULOGS,
        GLOBALS,
        DATEUTIL,
        UFINSERTMARCASMODELOS,
        UFHISTORICOINSPECCIONES,
        UINTERFAZUSUARIO,
        USAGCUIT,
        UFTMP,
        UFDOMINIOS,
        UTILORACLE,
        UFCAJA,
        UCTIMPRESION,
        UCLIENTE,
        SQLExpr,
        UFRECEPGNC,
        ufDeclaracionJurada, uGetObleaPlanta,
        UFDatosReveExterna, Uversion;

type
  Tmodificar_nro_oblea_rucara = class(TForm)
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  modificar_nro_oblea_rucara: Tmodificar_nro_oblea_rucara;

implementation

uses Ufrmconveniorucara;

{$R *.dfm}

procedure Tmodificar_nro_oblea_rucara.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tmodificar_nro_oblea_rucara.BitBtn1Click(Sender: TObject);
var nro:longint;
begin
if trim(edit1.Text)='' then
begin
Application.MessageBox( 'No ha ingresado el número de oblea.',
  'Acceso denegado', MB_ICONSTOP );
  exit;
end;
        With TSQLQuery.Create(Self) do
               try
                 nro:=strtoint(edit1.Text);
                 Close;
                 SQL.Clear;
                 SQLConnection:=mybd;
                 SQL.Add('update tvarios set oblea_rucara='+inttostr(nro));
                 ExecSQL;
                 frmconveniorucara.Panel2.Caption:=trim(edit1.Text);
                 application.ProcessMessages;
             finally
             free;
             end;
             
end;

procedure Tmodificar_nro_oblea_rucara.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
if key in ['0','1','2','3','4','5','6','7','8','9'] then
 self.Edit1.ReadOnly:=false
 else
 edit1.ReadOnly:=true;
end;

procedure Tmodificar_nro_oblea_rucara.FormCreate(Sender: TObject);
begin
edit1.Clear;
end;

end.
