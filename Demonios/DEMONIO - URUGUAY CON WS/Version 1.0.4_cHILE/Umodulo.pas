unit Umodulo;

interface

uses

    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ADODB, DB;

type
  Tmodulo = class(TDataModule)
    conexion: TADOConnection;
    sql_global: TADOQuery;
    sql_usuario: TADOQuery;
    dt_usuarios: TDataSource;
    sql_empresa: TADOQuery;
    dt_empresa: TDataSource;
    sql_habilita_empresa: TADOQuery;
    dt_habilita_empresa: TDataSource;
    sql_planilla: TADOQuery;
    sql_buscA_por_fecha: TADOQuery;
    dt_busca_fecha: TDataSource;
    sql_estados: TADOQuery;
    dt_estados: TDataSource;
    sql_listado: TADOQuery;
    dt_sql_copia: TDataSource;
    sql_copia: TADOQuery;
    sql_canti_copia: TADOQuery;
    dt_canti_copia: TDataSource;
    sql_reporte_centros: TADOQuery;
    sql_reporte_reserva: TADOQuery;
    sql_aux1: TADOQuery;
    query_exportar1: TADOQuery;
    QUERY_WEB: TADOQuery;
    query_actualiza: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }

    function cargar_centros_combo(combo:tcombobox):boolean;
  end;

var
  modulo: Tmodulo;

implementation

{$R *.dfm}
   function tmodulo.cargar_centros_combo(combo:tcombobox):boolean;
   var i:longint;
   begin
        combo.Clear;
        modulo.sql_global.Close;
        modulo.sql_global.SQL.Clear;
        modulo.sql_global.SQL.Add('select centro, nombre from centros ');
        modulo.sql_global.ExecSQL;
        modulo.sql_global.Open;
        combo.Items.Add('0 - Todos los centros');
        for i:= 1 to modulo.sql_global.RecordCount do
        begin
            combo.Items.Add(trim(modulo.sql_global.Fields[0].asstring)+' - '+trim(modulo.sql_global.Fields[1].asstring));

            modulo.sql_global.Next;
        end;
   end;
end.


