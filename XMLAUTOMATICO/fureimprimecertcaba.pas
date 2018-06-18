unit fureimprimecertcaba;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,SQLEXPR, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, globals,DBGrids, ExtCtrls, DB, RxMemDS,class_impresion;

type
  Tureimprimecertcaba = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    RxMemoryData1: TRxMemoryData;
    DataSource1: TDataSource;
    RxMemoryData1FECHA: TStringField;
    RxMemoryData1NROINSPECCION: TStringField;
    RxMemoryData1RESULTADO: TStringField;
    RxMemoryData1OBLEA: TStringField;
    RxMemoryData1INFORME1: TStringField;
    RxMemoryData1INFORME2: TStringField;
    RxMemoryData1CODINSPE: TIntegerField;
    RxMemoryData1ANIO: TIntegerField;
    RxMemoryData1TITULAR: TStringField;
    RxMemoryData1CONDUCTOR: TStringField;
    RxMemoryData1VENCE: TStringField;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ureimprimecertcaba: Tureimprimecertcaba;

implementation

uses UMENSAJEIMPRESION;

{$R *.dfm}

procedure Tureimprimecertcaba.BitBtn2Click(Sender: TObject);
begin
CLOSE;
end;

procedure Tureimprimecertcaba.BitBtn1Click(Sender: TObject);
var codinspe:longint;
    anio:longint;

    TIMPRE:TIMPRESIONCABA;

    aQim:TSQLQuery;
begin
 MENSAJEIMPRESION.Label1.Caption:='REIMPRIMIENDO INFORME DE INSPECCION...';
 MENSAJEIMPRESION.SHOW;
 aPPLICATION.ProcessMessages;
codinspe:=dbgrid1.Fields[7].asinteger;
anio:=dbgrid1.Fields[8].asinteger;
TIMPRE:=TIMPRESIONCABA.Create;
TIMPRE.imprimir_certificado_caba(codinspe,anio,0,true,'x');
TIMPRE.Free;



 aQim:=TSQLQuery.Create(nil);
        aQim.SQLConnection:=mybd;
        aQim.SQL.Clear;
        aQim.sql.add('delete from tmp_imprsion WHERE CODINSPE=:CODINSPE ');
        aQim.ParamByName('CODINSPE').Value:=codinspe;
        aQim.ExecSQL;
        aQim.close;
        aQim.free;

MENSAJEIMPRESION.close;
end;

end.
