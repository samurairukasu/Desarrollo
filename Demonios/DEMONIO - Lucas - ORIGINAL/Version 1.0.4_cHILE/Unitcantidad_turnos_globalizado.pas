unit Unitcantidad_turnos_globalizado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, jpeg, QuickRpt, ExtCtrls, QRExport, DB, ADODB;

type
  Tcantidad_turnos_globalizado = class(TForm)
    ADOQuery1: TADOQuery;
    QRExcelFilter1: TQRExcelFilter;
    QRExcelFilter2: TQRExcelFilter;
    ADOQuery2: TADOQuery;
    repConsumosGNCxAno: TQuickRep;
    QRBand1: TQRBand;
    QRImage1: TQRImage;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel4: TQRLabel;
    QRBand2: TQRBand;
    qrlComprob: TQRLabel;
    qrlTaller: TQRLabel;
    QRLabel7: TQRLabel;
    QRBDetalle: TQRBand;
    qretaller: TQRExpr;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRBand3: TQRBand;
    QRSysData1: TQRSysData;
    QRBand4: TQRBand;
    QRLabel6: TQRLabel;
    QRExpr9: TQRExpr;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  cantidad_turnos_globalizado: Tcantidad_turnos_globalizado;

implementation

{$R *.dfm}

procedure Tcantidad_turnos_globalizado.FormCreate(Sender: TObject);
begin
{
select '+
 ' count(*) as cantidad, '+
 ' CONVERT(DATETIME,r.fecha,103) as rfecha,  '   +
 ' r.centro as rcentro,  '  +
 ' c.nombre as cnombre    '  +
 ' from reserva r, centros c  ' +
 ' where r.centro=c.centro  and '  +
 ' r.fecha between CONVERT(DATETIME,'+#39+fd+#39+',103) and CONVERT(DATETIME,'+#39+fh+#39+',103) '+
 ' group by CONVERT(DATETIME,r.fecha,103), r.centro, c.nombre order by CONVERT(DATETIME,r.fecha,103) asc ' ;
 }

end;

end.
