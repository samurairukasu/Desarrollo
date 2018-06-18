unit UFHistoricoInspecciones;

interface

    uses
        Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
        Db, ExtCtrls, Grids, DBGrids, RXDBCtrl, Buttons,
        UCDialgs, USAGCLASSES, USAGESTACION, USAGDOMINIOS, StdCtrls;

    type
        TFHistoricoInspecciones = class(TForm)
            Panel1: TPanel;
            RxDBGrid1: TRxDBGrid;
            DSInspecciones: TDataSource;
            Bevel1: TBevel;
            PCabecera: TPanel;
    BitBtn1: TBitBtn;
            procedure RxDBGrid1GetCellParams(Sender: TObject; Field: TField;   AFont: TFont; var Background: TColor; Highlight: Boolean);
            procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
        private
            fInspections : TInspeccion;
            fPatentes : tDominio;
        public
            constructor CreateByInspection (const aInspections : TInspeccion; const aP : TDominio);
        end;

    var
        FHistoricoInspecciones: TFHistoricoInspecciones;

    procedure VisualizaHistoricoInspecciones (const aInspections : TInspeccion; const aP : TDominio);


implementation

{$R *.DFM}

    uses
        ULogs;

    type
        tEstilo = (Fondo, Texto, Apariencia);

    const
        BOLD = 1;
        ARRAY_ESTILOS : array [ fvNormal..fvVoluntariaReverificacion, Fondo..Apariencia] of integer =
                {( (clWhite, clBlack, Ord(fsBold)),
                  (clRed, clWhite, Ord(fsBold)),
                  (clGreen, clWhite, Ord(fsBold)),
                  (clBlue, clWhite, Ord(fsBold)),
                  (clYellow, clBlue, Ord(fsBold)),
                  (clWhite, clBlack, Ord(fsBold)),
                  (clWhite, clBlack, Ord(fsBold)),
                  (clWhite, clBlack, Ord(fsBold)),
                  (clBlue, clYellow, Ord(fsBold))
                );}
                  (($00FF8000 , clWhite, Ord(fsBold)),
                  (clSilver, clblack, Ord(fsBold)),
                  (clGreen, clWhite, Ord(fsBold)),
                  (clBlue, clWhite, Ord(fsBold)),
                  (clRed, clWhite, Ord(fsBold)),
                  (clWhite, clBlack, Ord(fsBold)),
                  (clWhite, clBlack, Ord(fsBold)),
                  (clWhite, clBlack, Ord(fsBold)),
                  (clBlue, clYellow, Ord(fsBold)));


    resourcestring
        FILE_NAME = 'UFHISTORICOINSPECCIONES.PAS';


    procedure VisualizaHistoricoInspecciones (const aInspections : TInspeccion; const aP: tDominio);
    begin
        try
            with TFHistoricoInspecciones.CreateByInspection(aInspections, aP) do
            try
                ShowModal;
            finally
                Free;
            end;
        except
           MessageDlg('Histórico Inspecciones',Format('No se puden visualizar las inspecciones anteriores del vehículo: %s. Si el error persiste indíquelo al Jefe de Planta.', [aP.Patente + ' (' + aP.Complementaria + ')']), mtWarning, [mbOk], mbOK, 0);
        end
    end;

    constructor TFHistoricoInspecciones.CreateByInspection (const aInspections : TInspeccion; const aP : TDominio);
    begin
        inherited Create(Application);
        fInspections := aInspections;
        fPatentes := aP;
    end;


    function TipoVerificacion(const aValue: string) : tfVerificacion;
    var
        i : tfVerificacion;
    begin
        result := fvNormal;
        for i := fvNormal to fvVoluntariaReverificacion do
            if aValue = S_TIPO_VERIFICACION[i]
            then begin
                result := i;
                break;
            end;
    end;


     procedure TFHistoricoInspecciones.RxDBGrid1GetCellParams(Sender: TObject;
       Field: TField; AFont: TFont; var Background: TColor; Highlight: Boolean);
     var
         Tipo: tfVerificacion;
         Estilo : TFontStyles;
     begin
         Estilo := [];
         Tipo := TipoVerificacion((Sender as TrxDBGrid).DataSource.DataSet.FieldByName(FIELD_TIPO).AsString);
         Background := ARRAY_ESTILOS[Tipo,Fondo];
         AFont.Color := ARRAY_ESTILOS[Tipo,Texto];
         Include(Estilo,TFontStyle(ARRAY_ESTILOS[Tipo,Apariencia]));
         AFont.Style := Estilo;
     end;


procedure TFHistoricoInspecciones.FormDestroy(Sender: TObject);
begin
//  fInspections := nil;
//  fPatentes := nil;
end;

procedure TFHistoricoInspecciones.FormShow(Sender: TObject);
begin
    PCabecera.Caption := Format('%s -> %d',[PCabecera.Caption, fInspections.RecordCount]);
    PCabecera.Caption := Format(PCabecera.Caption,[fPatentes.Patente + ' (' + fPatentes.Complementaria + ')']);
    DSInspecciones.DataSet := fInspections.DataSet;
    fInspections.Open;
end;

procedure TFHistoricoInspecciones.BitBtn1Click(Sender: TObject);
begin
ModalResult := mrOK
end;

end.
