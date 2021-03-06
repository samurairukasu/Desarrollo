unit Ucambiodocumentotitular;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,globals,sqlExpr;

type
  Tfrmcambiotitular = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label6: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    FUNCTION DEVUELVE_CODIGO_CLIENTE(TIPODO,NRODOCU:STRING):STRING;
  public
    { Public declarations }
  end;

var
  frmcambiotitular: Tfrmcambiotitular;

implementation

{$R *.dfm}

procedure Tfrmcambiotitular.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Tfrmcambiotitular.BitBtn1Click(Sender: TObject);
var patente:string;
turnoid:longint;
TraeDatos:TSQLQuery;
titulartipodocumento,titularnrodocumento,titularnombre, titularapellido:string;
begin

patente:=trim(edit1.text);
turnoid:=strtoint(edit2.Text);



TraeDatos:=TSQLQuery.Create(nil);
  with TraeDatos do
    begin
    SQLConnection:=mybd;
    SQL.Add('SELECT ttulartipodocumento,titularnrodocumento,titularnombre, titularapellido FROM tdatosturno WHERE turnoid = :pturno AND dvdomino = :patente');
    ParamByName('pturno').Value:=turnoid;
     ParamByName('patente').Value:=patente;
      try
        Open;
        if not isempty then
        begin
           titulartipodocumento:=trim(fields[0].asstring);
           titularnrodocumento:=trim(fields[1].asstring);
           titularnombre:=trim(fields[2].asstring);
           titularapellido:=trim(fields[3].asstring);
           edit3.Text:=trim(titularnombre)+' '+trim(titularapellido);
           edit4.Text:=trim(titularnrodocumento);





           if trim(titulartipodocumento)='1' then
              combobox1.ItemIndex:=0;
           if trim(titulartipodocumento)='9' then
              combobox1.ItemIndex:=1;
           if trim(titulartipodocumento)='8' then
              combobox1.ItemIndex:=2;

            if trim(titulartipodocumento)='5' then
              combobox1.ItemIndex:=3;
           { if trim(titulartipodocumento)='5' then
              combobox1.ItemIndex:=4;
              }
           if trim(titulartipodocumento)='2' then
              combobox1.ItemIndex:=5;
           if trim(titulartipodocumento)='4' then
              combobox1.ItemIndex:=6;


           edit5.Text:=DEVUELVE_CODIGO_CLIENTE(trim(combobox1.Text),titularnrodocumento);

        end;
      finally
        Close;
        Free;
      end;
    end;

end;


FUNCTION Tfrmcambiotitular.DEVUELVE_CODIGO_CLIENTE(TIPODO,NRODOCU:STRING):STRING;
VAR TraeCLIENTE:TSQLQuery;
BEGIN

 

TraeCLIENTE:=TSQLQuery.Create(nil);
  with TraeCLIENTE do
    begin
    SQLConnection:=mybd;
    SQL.Add('SELECT CODCLIEN FROM TCLIENTES WHERE TIPODOCU = :PTIPODOCU AND  DOCUMENT = :pNUMERO');
    ParamByName('PTIPODOCU').Value:=TIPODO;
     ParamByName('pNUMERO').Value:=NRODOCU;
      try
        Open;
        if not isempty then
        begin
           DEVUELVE_CODIGO_CLIENTE:=trim(fields[0].asstring);


        end;
      finally
        Close;
        Free;
      end;
    end;
END;


procedure Tfrmcambiotitular.BitBtn3Click(Sender: TObject);
var codclien,TURNOID:longint;
numero,tipo,ITIPO:string;
TraeCLIENTE:TSQLQuery;
begin
IF TRIM(EDIT2.Text)='' THEN
EXIT;



if Application.MessageBox( '�Desea continuar con el cambio de n�mero de documento?', 'Atenci�n',
  MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
  begin
    codclien:=strtoint(edit5.Text);
    tipo:=trim(combobox1.text);
    numero:=trim(edit4.Text);
    TURNOID:=strtoint(edit2.Text);

     if trim(tipo)='DNI' THEN
        ITIPO:='1';

     if trim(tipo)='CUIT' THEN
        ITIPO:='9';

     if trim(tipo)='P.JCA.' THEN
        ITIPO:='0';

     if trim(tipo)='LE' THEN
        ITIPO:='2';

      if trim(tipo)='LC' THEN
        ITIPO:='3';

     if trim(tipo)='DNI.EX' THEN
        ITIPO:='4';

     if trim(tipo)='CED.EX' THEN
        ITIPO:='5';

     if trim(tipo)='PASAP.' THEN
        ITIPO:='6';

     if trim(tipo)='NO CONSTA' THEN
        ITIPO:='7';


     if trim(tipo)='CED' THEN
        ITIPO:='8';

    if trim(tipo)='CERT.NAC.' THEN
        ITIPO:='10';
    if trim(tipo)='CERT.' THEN
        ITIPO:='11';

    if trim(tipo)='CED.CIU.' THEN
        ITIPO:='12';

    if trim(tipo)='EXPEDIENTE' THEN
        ITIPO:='13';






    TraeCLIENTE:=TSQLQuery.Create(nil);
  with TraeCLIENTE do
    begin
    SQLConnection:=mybd;
    SQL.Add('SELECT CODCLIEN FROM TCLIENTES WHERE TIPODOCU = :PTIPODOCU AND  DOCUMENT = :pNUMERO');
    ParamByName('PTIPODOCU').Value:=tipo;
     ParamByName('pNUMERO').Value:=numero;
      try
        Open;
        if not isempty then
        begin
           Application.MessageBox( pchar('Ya existe un cliente con el tipo documento: '+tipo+' y el numero: '+numero+'.'+#13+
           'Llame a sistema para que le asocien el cliente a la inspecci�n.'),
          'Acceso denegado', MB_ICONSTOP );

           exit;

        end;
      finally
        Close;
        Free;
      end;
    end;


      TraeCLIENTE:=TSQLQuery.Create(nil);
  with TraeCLIENTE do
    begin
    try
    try
    mybd.StartTransaction(td);
    SQLConnection:=mybd;
    SQL.Clear;
    SQL.Add('update TCLIENTES set TIPODOCU = :PTIPODOCU, DOCUMENT = :pNUMERO   where CODCLIEN =:pcodclien');
    ParamByName('PTIPODOCU').Value:=tipo;
    ParamByName('pNUMERO').Value:=numero;
    ParamByName('pcodclien').Value:=codclien;
    ExecSQL;

    SQL.Clear;
    SQL.Add('update TDATOSTURNO set TTULARTIPODOCUMENTO = :PTIPODOCU ,  TITULARNRODOCUMENTO = :pNUMERO   where TURNOID =:pTURNOID');
    ParamByName('PTIPODOCU').Value:=ITIPO;
    ParamByName('pNUMERO').Value:=numero;
    ParamByName('pTURNOID').Value:=TURNOID;
    ExecSQL;
    if mybd.InTransaction then
       mybd.Commit(td);

       Application.MessageBox( 'Se ha actualizado correctamente.', 'Atenci�n',
       MB_ICONINFORMATION );
       edit1.Clear;
       edit2.clear;
       edit3.clear;
       edit4.Clear;
       edit5.Clear;


    except
      mybd.Rollback(td);
       application.MessageBox( 'Se produjo un error al intentar actualizar la informaci�n. Llame a sistemas.',
                           'Atenci�n', MB_ICONSTOP );
    end;

      finally
        Close;
        Free;
      end;
    
  end;



  end;
end;

end.
