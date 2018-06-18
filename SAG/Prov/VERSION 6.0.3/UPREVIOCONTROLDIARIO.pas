unit UPrevioControlDiario;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, Mask, DBCtrls, ExtCtrls, StdCtrls, RXSpin, RXLookup,
  Buttons, USAGCLASSES, USAGESTACION, RxGIF;

type
  TFPrevioControlDiario = class(TForm)
    Panel1: TPanel;
    RXTiposCliente: TRxDBLookupCombo;
    ETipoCliente: TDBEdit;
    DSTTiposCliente: TDataSource;
    Label3: TLabel;
    Bevel4: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label4: TLabel;
    EArqueoCaja: TEdit;
    Panel2: TPanel;
    Image1: TImage;
    Bevel3: TBevel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RXTiposClienteCloseUp(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure POblea2Exit(Sender: TObject);
    procedure EArqueoCajaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fSumaryCD : TSumaryCD;
    fTiposCliente : TTiposCliente;
  public
    { Public declarations }
    property SumaryCD : TSumaryCD read fSumaryCD;
  end;

var
  FPrevioControlDiario: TFPrevioControlDiario;

implementation

{$R *.DFM}

uses
        GLOBALS;



procedure TFPrevioControlDiario.FormKeyPress(Sender: TObject; var Key: Char);
begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0;
        end;
end;

procedure TFPrevioControlDiario.FormCreate(Sender: TObject);
begin
        fTiposCliente := TTiposCliente.CreateFromDatabase(MyBD,DATOS_TIPOS_DE_CLIENTE,'WHERE VIGENTE = ''S'' ORDER BY TIPOCLIENTE_ID');
        DSTTiposCliente.DataSet := fTiposCliente.DataSet;
        fTiposCliente.Open;
        RXTiposCliente.Value := ETipoCliente.Text;
        with fSumaryCD do
        begin
            iACodeUser       := '0';
            iPOblea1         := '0';
            iPOblea2         := '0';
            iSubPubUsers     := '0';
            iSalesWOPubUsers := '0';
            iOCreditSales    := '0';
            iContSales       := '0';
            iIvaContSales    := '0';
            iTtlContSales    := '0';
            iTtlArqueoCaja   := '0';
            iNAC             := '0';
            iNR              := '0';
            iNACR            := '0';
            iNOblCYP1        := '0';
            iNOblCYP2        := '0';
            iNOblNYP1        := '0';
            iNOblNYP2        := '0';
            FOblCYearP1      := '0';
            LOblCYearP1      := '0';
            FOblCYearP2      := '0';
            LOblCYearP2      := '0';
            FOblNYearP1      := '0';
            LOblNYearP1      := '0';
            FOblNYearP2      := '0';
            LOblNYearP2      := '0';
            Observaciones    := '0';
        end;
end;

procedure TFPrevioControlDiario.FormDestroy(Sender: TObject);
begin
        fTiposCliente.Free;
end;



procedure TFPrevioControlDiario.RXTiposClienteCloseUp(Sender: TObject);
begin
    RXTiposCliente.Value := fTiposCliente.ValueByName[FIELD_TIPOCLIENTE_ID];
end;

procedure TFPrevioControlDiario.BitBtn1Click(Sender: TObject);
begin
    with fSumaryCD do
    begin
        if length(Trim(EArqueoCaja.Text)) = 0
        then EArqueoCaja.Text := '0';
        iTtlArqueoCaja := EArqueoCaja.Text;
        iACodeUser := ETipoCliente.Text;
        iPOblea1 := '1';
        iPOblea2 := '2';
    end;
end;

procedure TFPrevioControlDiario.POblea2Exit(Sender: TObject);
begin
    if (Sender as TRXSpinEdit).Value > 9 then (Sender as TRXSpinEdit).Value := 9;
end;

procedure TFPrevioControlDiario.EArqueoCajaKeyPress(Sender: TObject;
  var Key: Char);
begin
    if not (Key in ['0','1','2','3','4','5','6','7','8','9',#37,#39,#46,#8,','])
    then key := #0
end;

end.


