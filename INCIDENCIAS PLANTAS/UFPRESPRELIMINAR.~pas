unit UFPresPreliminar;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, qrprntr, ExtCtrls, SpeedBar;

type
  TfrmPresPreliminar = class(TForm)
    QRPrevPresPrel: TQRPreview;
    SpeedBar1: TSpeedBar;
    SpeedbarSection1: TSpeedbarSection;
    SpeedItemAmpliarZoom: TSpeedItem;
    SpeedItemReducirZoom: TSpeedItem;
    SpeedbarSection2: TSpeedbarSection;
    SpeedItemImprimir: TSpeedItem;
    SpeedItemVolver: TSpeedItem;
    SpeedItemZoomAnchoPag: TSpeedItem;
    SpeedItemZoomTodaPag: TSpeedItem;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedItemAmpliarZoomClick(Sender: TObject);
    procedure SpeedItemReducirZoomClick(Sender: TObject);
    procedure SpeedItemImprimirClick(Sender: TObject);
    procedure SpeedItemVolverClick(Sender: TObject);
    procedure SpeedItemZoomAnchoPagClick(Sender: TObject);
    procedure SpeedItemZoomTodaPagClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  frmPresPreliminar: TfrmPresPreliminar;

implementation

{$R *.DFM}

uses
   UINTERFAZUSUARIO;

const
    VALOR_INCDEC_ZOOM = 25; { aumenta o decrementa el zoom en un 25% }

resourcestring
    LITERAL_PRESPREL = 'Presentación Preliminar';



procedure TfrmPresPreliminar.FormCreate(Sender: TObject);
begin
    Inicializar_FrmAlturaAnchura (TForm(Sender));
    Caption := LITERAL_PRESPREL;
end;


procedure TfrmPresPreliminar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure TfrmPresPreliminar.SpeedItemAmpliarZoomClick(Sender: TObject);
begin
    QRPrevPresPrel.Zoom :=  QRPrevPresPrel.Zoom + VALOR_INCDEC_ZOOM;
end;

procedure TfrmPresPreliminar.SpeedItemReducirZoomClick(Sender: TObject);
begin
    QRPrevPresPrel.Zoom :=  QRPrevPresPrel.Zoom - VALOR_INCDEC_ZOOM;
end;

procedure TfrmPresPreliminar.SpeedItemImprimirClick(Sender: TObject);
begin
    ModalResult := mrOk;
    Close;
end;

procedure TfrmPresPreliminar.SpeedItemVolverClick(Sender: TObject);
begin
    ModalResult := mrCancel;
    Close;
end;

procedure TfrmPresPreliminar.SpeedItemZoomAnchoPagClick(Sender: TObject);
begin
    QRPrevPresPrel.ZoomToWidth;
end;

procedure TfrmPresPreliminar.SpeedItemZoomTodaPagClick(Sender: TObject);
begin
    QRPrevPresPrel.ZoomToFit;
end;

procedure TfrmPresPreliminar.FormResize(Sender: TObject);
begin
    Abort;
end;

end.
