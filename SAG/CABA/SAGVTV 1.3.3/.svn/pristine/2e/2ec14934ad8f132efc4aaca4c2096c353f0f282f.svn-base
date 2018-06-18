unit UFINFORMESDIALOGEXCEL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  tExportarExcel = (teeGeneral,teeResumen,teeAmbos);

  TFExcelDialog = class(TForm)
    Panel1: TPanel;
    RImprimir: TRadioGroup;
    Image1: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure RImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fOpcion : tExportarExcel;
    { Private declarations }
  public
    { Public declarations }
    property ExportarExcel : tExportarExcel read fOpcion;
  end;

var
  FExcelDialog: TFExcelDialog;

implementation

{$R *.DFM}

procedure TFExcelDialog.RImprimirClick(Sender: TObject);
begin
    fOpcion := tExportarExcel((Sender as TRadioGroup).ItemIndex);
end;

procedure TFExcelDialog.FormCreate(Sender: TObject);
begin
    fOpcion := tExportarExcel(0);
end;

end.
