unit Unit_borrar_defecto_patente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,SqlExpr, Buttons,GLOBALS, sHintManager;

type
  Tborrar_defecto_patente = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Edit2: TEdit;
    Label4: TLabel;
    Edit3: TEdit;
    BitBtn2: TBitBtn;
    Label5: TLabel;
    Edit4: TEdit;
    BitBtn3: TBitBtn;
    sHintManager1: TsHintManager;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  borrar_defecto_patente: Tborrar_defecto_patente;

implementation

{$R *.dfm}

procedure Tborrar_defecto_patente.BitBtn1Click(Sender: TObject);
VAR SQL1,PATENTE,TIPO:STRING;
CODINSPE,EJERCICI,CODVEHIC:LONGINT;
begin
IF TRIM(EDIT1.Text)='' THEN
BEGIN
Application.MessageBox( 'Debe ingresar la patente.',
  'Atención', MB_ICONSTOP );
  edit1.SetFocus;
  EXIT;
END;
if combobox1.ItemIndex=-1 THEN
BEGIN
Application.MessageBox( 'Debe seleccionar el tipo de inspección.',
  'Atención', MB_ICONSTOP );
  combobox1.SetFocus;
  EXIT;
END;


PATENTE:=TRIM(EDIT1.Text);

IF COMBOBOX1.ItemIndex=0 THEN
   TIPO:='A';

IF COMBOBOX1.ItemIndex=1 THEN
   TIPO:='E';




          sql1:='SELECT TI.CODINSPE AS TICODINSPE,TI.EJERCICI AS TIEJERCICI,TI.CODVEHIC AS TICODVEHIC FROM TVEHICULOS TV, TINSPECCION TI  '+
                ' WHERE TI.CODVEHIC=TV.CODVEHIC AND TO_CHAR(TI.FECHALTA,''DD/MM/YYYY'')=TO_CHAR(SYSDATE,''DD/MM/YYYY'') '+
                ' AND TV.PATENTEN=:PATENTE AND TI.TIPO=:TIPO';


        with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;

                close;
                sql.clear;
                SQL.Add(sql1);
                ParamByName('PATENTE').ASSTRING:=PATENTE;
                ParamByName('TIPO').ASSTRING:=TIPO;
                OPEN;
                 if  IsEmpty then
                  begin

                     edit1.setfocus;
                     edit1.SelectAll;
                     exit;
                  end ELSE
                  BEGIN
                   CODINSPE:=FIELDBYNAME('TICODINSPE').ASINTEGER;
                   EJERCICI:=FIELDBYNAME('TIEJERCICI').ASINTEGER;
                   CODVEHIC:=FIELDBYNAME('TICODVEHIC').ASINTEGER;
                   EDIT3.Text:=INTTOSTR(CODINSPE);

                  END;

            FINALLY

            END;





          sql1:=' SELECT TM.NOMMARCA,TMO.NOMMODEL FROM TVEHICULOS TV, TMARCAS TM,TMODELOS TMO   '+
            ' WHERE TV.CODVEHIC=:CODVEHIC AND TV.CODMARCA=TM.CODMARCA '+
                 ' AND TV.CODMODEL=TMO.CODMODEL';


        with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;

                close;
                sql.clear;
                SQL.Add(sql1);
                ParamByName('CODVEHIC').ASINTEGER:=CODVEHIC;
                OPEN;
                 if  IsEmpty then
                  begin
                    
                     edit1.setfocus;
                     edit1.SelectAll;
                     exit;
                  end ELSE
                  BEGIN
                   EDIT2.Text:=TRIM(FIELDS[0].ASSTRING)+' '+TRIM(FIELDS[1].ASSTRING);

                  END;

            FINALLY

            END;






end;

procedure Tborrar_defecto_patente.BitBtn2Click(Sender: TObject);
var cadena,patente,sql1,sql2,t,f,califica,sql3:string;
  CODINSPE:longint;

  sql_global: TSQLQuery;


begin
if trim(edit3.Text)='' then
 begin
     Application.MessageBox( 'No hay niguna inspección del vehículo',
  'Atención', MB_ICONSTOP );
    edit1.SetFocus;

     exit;
 end;


 if trim(edit4.Text)='' then
 begin
     Application.MessageBox( 'Debe ingresar la Cadena del Defecto.',
  'Atención', MB_ICONSTOP );
    edit4.SetFocus;

     exit;
 end;





codinspe:=strtoint(trim(edit3.Text));
cadena:=trim(edit4.Text);


if Application.MessageBox( pchar('¿Desea eliminar  el defecto: '+trim(cadena)+' ?'), 'Eliminar',
  MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
  begin

    





        with TSQLQuery.Create(self) do
          try
            SQLConnection:=mybd;



                 sql3:=' select * from tdatinspevi where codinspe=:codinspe and CADDEFEC=:cadena AND CALIFDEF=1 ';
                 close;
                sql.clear;
                SQL.Add(sql3);
                    ParamByName('codinspe').asinteger:=codinspe;
                   ParamByName('cadena').AsString:=cadena;
                OPEN;
                 if  IsEmpty then
                  begin
                      Application.MessageBox( pchar('No se ha encontrando ningun defecto con la cadena:'+#39+trim(cadena)+#39+'.'),
                       'Acceso denegado', MB_ICONSTOP );
                     edit2.setfocus;
                     edit2.SelectAll;
                     exit;
                  end;


                   sql2:= 'INSERT INTO TREVESDEL (SELECT CODINSPE, NUMREVIS, CADDEFEC FROM TDATINSPEVI WHERE CODINSPE=:codinspe  and CADDEFEC=:cadena)';



                  mybd.StartTransaction(td);
                    close;
                    sql.clear;
                   SQL.Add(sql2);
                   ParamByName('codinspe').asinteger:=codinspe;
                   ParamByName('cadena').AsString:=cadena;
                   ExecSQL;

                   sql2:= 'delete from tdatinspevi  where codinspe=:codinspe and CADDEFEC=:cadena';
                   sql.clear;
                   SQL.Add(sql2);
                   ParamByName('codinspe').asinteger:=codinspe;
                   ParamByName('cadena').AsString:=cadena;

                   ExecSQL;

                   //temporal
                     sql2:= 'delete from TMPDATODEFECIM  where codinspe=:codinspe and CADDEFEC=:cadena';
                   sql.clear;
                   SQL.Add(sql2);
                   ParamByName('codinspe').asinteger:=codinspe;
                   ParamByName('cadena').AsString:=cadena;

                   ExecSQL;

                   mybd.Commit(td);
                   Application.MessageBox( 'Se ha borrado correctamente.', 'Atención',
                    MB_ICONINFORMATION );
                 edit4.Clear;
             except
               Application.MessageBox( 'Se produjo un error la intentar borrar el defecto.',
                       'Acceso denegado', MB_ICONSTOP );
            mybd.Rollback(td);
          end;

  end;



end;

procedure Tborrar_defecto_patente.BitBtn3Click(Sender: TObject);
begin
CLOSE;
end;

procedure Tborrar_defecto_patente.FormCreate(Sender: TObject);
begin
EDIT2.CLEAR;
EDIT3.Clear;
EDIT4.Clear;
EDIT1.Clear;
end;

end.
