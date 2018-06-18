unit Ufrmconveniorucara;

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
        ufDeclaracionJurada, uGetObleaPlanta, USAGCLASSES,
        UFDatosReveExterna, Uversion, RxLookup, FMTBcd, DB, DBCtrls,
  sComboBox;

type
  Tfrmconveniorucara = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    RadioButton1: TRadioButton;
    GroupBox3: TGroupBox;
    RadioButton2: TRadioButton;
    GroupBox4: TGroupBox;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    Label8: TLabel;
    Panel2: TPanel;
    BitBtn3: TBitBtn;
    PartidoSource: TDataSource;
    CBPartido: TRxDBLookupCombo;
    procedure BitBtn1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure CargarPartidos();


  private
    { Private declarations
    LPartidos : TPartidos;
    FDAtaBase: TSQLConnection;     }      LPartidos : TPartidos; 
  public
    { Public declarations }
   UVEHICULO, UCLIENTE:string;
   cancela:boolean;
  end;

var
  frmconveniorucara: Tfrmconveniorucara;

implementation

uses Unitmodificar_nro_oblea_rucara;


{$R *.dfm}

procedure Tfrmconveniorucara.BitBtn1Click(Sender: TObject);
var  codvehic,codclien:longint;
datos_licencia:string;
municipio:string;
datos_municipio:string;
seguro:string;
conductor:string;
mas:string;
oblea,codinspe:LONGINT;
fecha,ssql:string;
sale:boolean;
begin
try
if trim(edit1.Text)='' then
begin

 Application.MessageBox( 'No ha rellenado el dominio del vehiculo.',
  'Acceso denegado', MB_ICONSTOP );

 exit;
end;

if trim(edit2.Text)='' then
begin

Application.MessageBox( 'No ha rellenado el apellido y nombre del titular.',
  'Acceso denegado', MB_ICONSTOP );

 exit;
end;



if trim(edit3.Text)='' then
begin

 Application.MessageBox( 'No ha rellenado los datos de la licencia de conducir.',
  'Acceso denegado', MB_ICONSTOP );

 exit;
end;

IF SELF.CheckBox1.Checked=TRUE THEN
BEGIN
{
if trim(edit4.Text)='' then
begin

Application.MessageBox( 'No ha rellenado la habilitación municipal.',
  'Acceso denegado', MB_ICONSTOP );

 exit;
end; }

END;

if (radiobutton1.Checked=false) and  (radiobutton2.Checked=false) then
 begin
Application.MessageBox( 'No ha seleccionado si tiene o no seguro del automotor.',
  'Acceso denegado', MB_ICONSTOP );

     exit;

 end;


  if (radiobutton3.Checked=false) and  (radiobutton4.Checked=false) then
 begin
Application.MessageBox( 'No ha seleccionado si la persona es conductor del vehiculo.',
  'Acceso denegado', MB_ICONSTOP );

     exit;

 end;

     if (radiobutton5.Checked=false) and  (radiobutton6.Checked=false) then
 begin
Application.MessageBox( 'No ha seleccionado si es conducido por otros conductores.',
  'Acceso denegado', MB_ICONSTOP );

     exit;

 end;
if  trim(UVEHICULO)=''then
    codvehic:=-1
else
   codvehic:=strtoint(trim(UVEHICULO));

      
codclien:=strtoint(trim(UCLIENTE));
datos_licencia:=trim(edit3.Text);
oblea:=STRTOINT(trim(panel2.Caption));
if checkbox1.Checked=true then
begin
 municipio:='S';
 datos_municipio:=trim(CBPartido.Text);
 end else
 begin
  municipio:='N';
  datos_municipio:='-';
 end;
 if radiobutton1.Checked=true then
    seguro:='S';

 if radiobutton2.Checked=true then
    seguro:='N';



    if radiobutton3.Checked=true then
    conductor:='S';

 if radiobutton4.Checked=true then
    conductor:='N';


    
    if radiobutton5.Checked=true then
    mas:='S';

 if radiobutton6.Checked=true then
    mas:='N';
                                                                                                


fecha:=DATETOSTR(DATE);
 codinspe:=-1;
ssql:='insert into TRUCARAS (CODVEHIC,CODCLIEN,DATOS_LICENCIA, MUNICIPIO,DATOS_MUNICIPIO, SEGURO_AUTO,ES_CONDUCTOR,MAS_CONDUCTOR,FECHALTA,NUMOBLEA,codinspe) ' +
' values ('+inttostr(codvehic)+','+inttostr(codclien)+','+#39+trim(datos_licencia)+#39+','+#39+trim(municipio)+#39+','+#39+trim(datos_municipio)+#39+
','+#39+trim(seguro)+#39+','+#39+trim(conductor)+#39+','+#39+trim(mas)+#39+',to_date('+#39+trim(fecha)+#39+',''dd/mm/YYYY HH24::MI::SS''),'+INTTOSTR(oblea)+','+inttostr(codinspe)+')';

 With TSQLQuery.Create(Self) do
    try
      Close;
      SQL.Clear;
      SQLConnection:=mybd;
      SQL.Add(ssql);
      ExecSQL;
    finally
      free;
    end;
        sale:=true;
    except
       sale:=falsE;
    end;

 if sale=true then
 begin
 cancela:=false;
 closE;
 end;

end;

procedure Tfrmconveniorucara.Label4Click(Sender: TObject);
begin
if checkbox1.Checked=true then
 begin
  //  edit4.Enabled:=false;
 end;

 if checkbox1.Checked=false then
 begin
   // edit4.Enabled:=true;
 end;

end;

procedure Tfrmconveniorucara.CargarPartidos();
begin

LPartidos := TPartidos.Create(fVarios);
LPartidos.Open;
PartidoSource.DataSet:=LPArtidos.DataSet;

end;

procedure Tfrmconveniorucara.CheckBox1Click(Sender: TObject);
begin

if checkbox1.Checked=true then
begin
  //  edit4.Color:= clInfoBk;
  //  edit4.Enabled:=true;
    CBPartido.Enabled:=True;
end    else
begin
    //  edit4.Enabled:=true;
      // edit4.Color:= cl3DLight;
    CBPartido.Enabled:=False;
 end;

end;

procedure Tfrmconveniorucara.BitBtn2Click(Sender: TObject);
begin
cancela:=true;
end;



procedure Tfrmconveniorucara.BitBtn3Click(Sender: TObject);
var modificar_nro_oblea_rucara:Tmodificar_nro_oblea_rucara ;
begin

  modificar_nro_oblea_rucara := nil;

       modificar_nro_oblea_rucara := Tmodificar_nro_oblea_rucara.Create(Application);
       try
          if (modificar_nro_oblea_rucara.ShowModal = mrOk) then
          begin
             if    trim(modificar_nro_oblea_rucara.Edit1.Text)<>'' then
              panel2.Caption:=trim(modificar_nro_oblea_rucara.Edit1.Text);
          end;
       finally
            modificar_nro_oblea_rucara.Free;

       end;


end;



end.
