unit Ulistadocierrez;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, FMTBcd, DB, SqlExpr,GLOBALS,UfimprimeinformeZ,
  DataExport, DataToXLS;

type
  Tlistadocierrez = class(TForm)
    Label1: TLabel;
    fechadesde: TDateTimePicker;
    fechahasta: TDateTimePicker;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    exporta: TCheckBox;
    query: TSQLQuery;
    dt_query: TDataSource;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    aexel: TDataToXLS;
    guardar: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  listadocierrez: Tlistadocierrez;

implementation

{$R *.dfm}

procedure Tlistadocierrez.FormCreate(Sender: TObject);
begin
fechadesde.DateTime:=now;
fechahasta.DateTime:=now;
exporta.Checked:=false;
radiobutton1.Checked:=true;

end;

procedure Tlistadocierrez.SpeedButton1Click(Sender: TObject);
var fd,fh,sql,filtro,dir:string;
begin
filtro:='';
fd:=datetostr(fechadesde.DateTime);
fh:=datetostr(fechahasta.DateTime + 1);

filtro:='desde: '+fd+' hasta: '+fh;
  if query.Active=false then
     query.SQLConnection:=MyBD;


    if radiobutton1.Checked then
        begin
          sql:='select  nroultim, codimpre, nroaok, nrobcok, sum(nroaimpr + nrobcimp) as cantidad, nrodnfh, nrodnf, fechapc  from   tcierrez  '+
                    ' where fechapc between to_date('+#39+trim(fd)+#39+',''dd/mm/yyyy'') and  to_date('+#39+trim(fh)+#39+',''dd/mm/yyyy'') group by nroultim, fechapc,codimpre, nroaok, nrobcok, nrodnfh, nrodnf  order by fechapc asc';

          filtro:=filtro+'  ordernado por fecha en forma ascendente';
        end
         else
           begin
              sql:='select  nroultim, codimpre, nroaok, nrobcok, nroaimpr, nrobcimp, nrodnfh, nrodnf, fechapc  from   tcierrez  '+
                    ' where fechapc between to_date('+#39+trim(fd)+#39+',''dd/mm/yyyy'') and  to_date('+#39+trim(fh)+#39+',''dd/mm/yyyy'')  group by nroultim, fechapc,codimpre, nroaok, nrobcok, nrodnfh, nrodnf  order by fechapc desc';

              filtro:=filtro+'  ordernado por fecha en forma ascendente';
           end;

     query.Close;
     query.SQL.Clear;
     query.SQL.Add(sql);
     query.ExecSQL;
     query.Open;


     if exporta.Checked=true then
  begin
  if guardar.Execute then
   begin
        dir:=trim(guardar.FileName);
            if trim(dir)=''then
              begin
                showmessage('Debe ingresar un nombre para el archivo a guardar');
                exit;
              end;
        dir:=dir + '.xls';
      aexel.SaveToFile(dir);
    end;
end;


    with TUimprimeinformeZ.Create(application) do
    try
      qrlabel6.Caption:=trim(filtro);
      qrlabel11.Caption:=datetostr(now);
      QuickRep1.Prepare;
      QuickRep1.Preview;

    finally
      free;
    end;

   







end;

end.
