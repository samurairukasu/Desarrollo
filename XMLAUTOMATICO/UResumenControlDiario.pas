unit UResumenControlDiario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Buttons, USAGESTACION, RxGIF;

type
  TFSumaryCD = class(TForm)
    Panel5: TPanel;
    Label14: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Bevel10: TBevel;
    Bevel11: TBevel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Label11: TLabel;
    Bevel14: TBevel;
    Label12: TLabel;
    Bevel15: TBevel;
    Label13: TLabel;
    Bevel16: TBevel;
    Label7: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Bevel21: TBevel;
    ENACR: TPanel;
    ENR: TPanel;
    ENAC: TPanel;
    NOCYP1: TPanel;
    NOCYP2: TPanel;
    NONYP1: TPanel;
    ETotalObleas: TPanel;
    NONYP2: TPanel;
    Memo1: TMemo;
    ESubUPb: TPanel;
    VSinUPb: TPanel;
    OVenCredito: TPanel;
    VContado: TPanel;
    IvaVContado: TPanel;
    TVentasContado: TPanel;
    TArqueoCaja: TPanel;
    Bevel2: TBevel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Image1: TImage;
    Panel1: TPanel;
    Panel2: TPanel;
    EFOCYP2: TPanel;
    ELOCYP2: TPanel;
    EFONYP1: TPanel;
    ELONYP1: TPanel;
    EFOCYP1: TPanel;
    ELOCYP1: TPanel;
    EFONYP2: TPanel;
    ELONYP2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
  private
    fSumaryCD : tSumaryCD;
    { Private declarations }
  public
    { Public declarations }
    property SumaryCD : tSumaryCD read fSumaryCD;
    constructor CreateByCD (const aCD: tSumaryCD);
  end;

var
  FSumaryCD: TFSumaryCD;

implementation

{$R *.DFM}

    constructor TFSumaryCD.CreateByCD (const aCD: tSumaryCD);
    begin
        Inherited Create(Application);
        fSumaryCD := aCD;
        with fSumaryCD do
        begin
            ESubUPb.Caption := '$'+Format('%.2f',[StrToFloat(iSubPubUsers)]);
            VSinUPb.Caption := '$'+Format('%.2f',[StrToFloat(iSalesWOPubUsers)]);
            OVenCredito.Caption := '$'+Format('%.2f',[StrToFloat(iOCreditSales)]);
            VContado.Caption := '$'+Format('%.2f',[StrToFloat(iContSales)]);
            IvaVContado.Caption := '$'+Format('%.2f',[StrToFloat(iIvaContSales)]);
            TVentasContado.Caption := '$'+Format('%.2f',[StrToFloat(iTtlContSales)]);
            TArqueoCaja.Caption := '$'+Format('%.2f',[StrToFloat(iTtlArqueoCaja)]);
            ENAC.Caption := iNAC;
            ENR.Caption := iNR;
            ENACR.Caption := iNACR;

            NOCYP1.Caption := iNOblCYP1;
            NOCYP2.Caption := iNOblCYP2;
            NONYP1.Caption := iNOblNYP1;
            NONYP2.Caption := iNOblNYP2;
            ETotalObleas.Caption := IntToStr ( StrToInt(iNOblCYP1) + StrToInt(iNOblCYP2) + StrToInt(iNOblNYP1) + StrToInt(iNOblNYP2));

            EFOCYP1.Caption := FOblCYearP1;
            ELOCYP1.Caption := LOblCYearP1;

            EFONYP1.Caption := FOblNYearP1;
            ELONYP1.Caption := LOblNYearP1;

            EFOCYP2.Caption := FOblCYearP2;
            ELOCYP2.Caption := LOblCYearP2;

            EFONYP2.Caption := FOblNYearP2;
            ELONYP2.Caption := LOblNYearP2;
            Memo1.Lines.Add(Observaciones);
        end;
    end;

procedure TFSumaryCD.BitBtn1Click(Sender: TObject);
begin
    fSumaryCD.Observaciones := Memo1.Lines.Text;
end;

end.
