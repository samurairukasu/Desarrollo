unit Umodulo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls,GLOBALS,SqlExpr, FMTBcd, DB;

type
  Tmodulo = class(TDataModule)
    sql_global: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function guardar_incidencia(texto:string):boolean;
  end;

var
  modulo: Tmodulo;

implementation

{$R *.dfm}
  function Tmodulo.guardar_incidencia(texto:string):boolean;
  var fecha:string;
      hora:string;
      archi:textfile;
      path,nombre,linea:string;
  begin
    fecha:=datetostr(date);
    fecha:=StringReplace(fecha, '/', '-',[rfReplaceAll, rfIgnoreCase]);
     hora:=timetostr(time);
    nombre:='Inci_'+fecha+'.txt';
    path:=ExtractFilePath( Application.ExeName ) + nombre;

    assignfile(archi, path);

    if fileexists(path) = false then
       rewrite(archi)
       else
        append(archi);

        linea:='['+hora+']      '+texto;
        writeln(archi,linea);


        closefile(archi);







  end;


end.
