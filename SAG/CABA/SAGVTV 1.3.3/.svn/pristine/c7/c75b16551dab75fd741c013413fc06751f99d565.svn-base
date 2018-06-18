unit Unit1reimprimir_factura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DB,GLOBALS, FMTBcd,
  SqlExpr, RxMemDS,SHELLAPI;

type
  Treimprimir_factura = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    BitBtn2: TBitBtn;
    DataSource1: TDataSource;
    SQLQuery1: TSQLQuery;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1idturno: TIntegerField;
    RxMemoryData1fecha: TStringField;
    RxMemoryData1tipocomprobante: TStringField;
    RxMemoryData1nrocomprobante: TStringField;
    BitBtn3: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  reimprimir_factura: Treimprimir_factura;

implementation

uses Uvisorpdf;

{$R *.dfm}

procedure Treimprimir_factura.BitBtn2Click(Sender: TObject);
begin
close;
end;

procedure Treimprimir_factura.BitBtn1Click(Sender: TObject);
var buscar:string;

begin
buscar:='%'+trim(edit1.text)+'%';
self.RxMemoryData1.Close;
self.RxMemoryData1.Open;
  With TSQLQuery.Create(Self) do
                      try
                        Close;
                        SQL.Clear;
                        SQLConnection:=mybd;
                       // SQL.Add('select turnoid,fechaturno,nro_comprobante,tipocomprobanteafip from tdatosturno where dvdomino like '+#39+trim(buscar)+#39);



                       SQL.Add(' SELECT IP.DOMINIO,DP.FECHAPAGO As FP,DP.IDDETALLESPAGO AS turnoid,DP.ARCHIVOENVIADO,DP.NRO_COMPROBANTE AS NRO, '+
                               ' DP.TIPOCOMPROBANTEAFIP AS TP '+
                               ' FROM TINFORMACIONPAGO IP, TDETALLESPAGO DP  '+
                               ' WHERE IP.DOMINIO like '+#39+trim(buscar)+#39+' AND  '+
                               ' IP.IDDETALLESPAGO=DP.IDDETALLESPAGO '+
                               ' ORDER BY DP.IDDETALLESPAGO DESC') ;

                        ExecSQL;
                        open ;
                        while not eof do
                        begin
                              self.RxMemoryData1.Append;
                               self.RxMemoryData1idturno.Value:=fieldbyname('turnoid').asinteger;
                               self.RxMemoryData1fecha.Value:=trim(fieldbyname('FP').asstring);
                               self.RxMemoryData1tipocomprobante.Value:=trim(fieldbyname('TP').asstring);
                               self.RxMemoryData1nrocomprobante.Value:=trim(fieldbyname('NRO').asstring);

                              self.RxMemoryData1.Post;

                            next;
                        end;
                        finally
                         close;
                         free;
                       end;
end;

procedure Treimprimir_factura.BitBtn3Click(Sender: TObject);
VAR    TURNOID:LONGINT;
  ARCHIVOENVIADO:string;
begin
   TURNOID:=SELF.RxMemoryData1idturno.Value;
   With TSQLQuery.Create(Self) do
                      try
                        Close;
                        SQL.Clear;
                        SQLConnection:=mybd;
                        SQL.Add('SELECT ARCHIVOENVIADO FROM TDETALLESPAGO WHERE IDDETALLESPAGO='+INTTOSTR(TURNOID));
                        ExecSQL;
                        open ;
                        ARCHIVOENVIADO:=trim(fieldbyname('ARCHIVOENVIADO').asstring);
                   finally
                         close;
                         free;
                       end;

         

  visorpdf.ARCHIVOENVIADO:=ARCHIVOENVIADO;
   visorpdf.Show;

  {                     URL := 'file://' + lblDocFullName.Caption;
    Flags := navNoHistory or navNoReadFromCache or navNoWriteToCache;
    wbPreview.Navigate(WideString(URL), Flags);
    while wbPreview.ReadyState <> READYSTATE_COMPLETE do
    begin
      Application.ProcessMessages;
      Sleep(0);
    end;   }


end;

end.
