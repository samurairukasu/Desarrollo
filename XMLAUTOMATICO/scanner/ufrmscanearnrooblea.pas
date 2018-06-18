unit ufrmscanearnrooblea;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons,UUtils,globals,SQLExpr;

type
  Tfrmscanearnrooblea = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Edit2: TEdit;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    sale:boolean;
  end;

var
  frmscanearnrooblea: Tfrmscanearnrooblea;

implementation

uses UFinVeri;

{$R *.dfm}

procedure Tfrmscanearnrooblea.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
if key=#13 then
   begin
     LABEL2.CAPTION:='PRESIONAR CTRL + C PARA CONTINUAR';
     BitBtn1.SetFocus;
     
     //BitBtn1Click(Sender);
   end;

end;

procedure Tfrmscanearnrooblea.BitBtn1Click(Sender: TObject);
var vAnioVenci:longint;
oblea:string;
aQ:TSQLQuery;
ok:boolean;
begin
 IF TRIM(EDIT1.Text)='' THEN
 BEGIN
     SHOWMESSAGE('Debe Scanear el Nro de Oblea');
     edit1.clear;
     edit1.setfocus;
     EXIT;
 END;


  aQ:=TSQLQuery.Create(nil);

     ////armar consulta
     ok:=false;
          with aQ do
            begin
              SQLConnection:=mybd;
              SQL.Add ('select * from tobleas where estado in (''S'',''T'') and numoblea='+#39+trim(edit1.Text)+#39);
                try
                  Open;
                   while not eof do
                   begin
                   edit2.text:=trim(fieldbyname('anio').asstring);
                        ok:=true;

                      next;
                   end;


                except
                   close;
                   free;
                end;
             end;
             
             if  ok=false then
                  begin
                         SHOWMESSAGE('La oblea scaneada no est� en Stock');
                         edit1.Clear;
                          edit1.setfocus;
                          EXIT;
                end;

{oblea:=trim(FrmFinal.BEdtOblea.Text);
 if  (TRIM(EDIT1.Text))<>(trim(oblea)) then
 begin

     SHOWMESSAGE('La Oblea Scaneada no corresponde a la pr�xima ');
     edit1.setfocus;
     EXIT
 end;  }


 sale:=false;
CLOSE;
end;

procedure Tfrmscanearnrooblea.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 { if trim(edit1.Text)='' then
  begin
  sale:=true;
   canclose:=false
  end else
  begin
    canclose:=true;
    sale:=fale;
    end; }
end;

procedure Tfrmscanearnrooblea.BitBtn2Click(Sender: TObject);
begin
sale:=true ;
close;
end;

procedure Tfrmscanearnrooblea.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key=#37 then
begin
sale:=true;
close;
end;
end;

end.