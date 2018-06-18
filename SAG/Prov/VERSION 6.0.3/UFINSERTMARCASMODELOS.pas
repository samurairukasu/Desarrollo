unit UFInsertMarcasModelos;


interface

    uses
        Windows,
        Messages,
        SysUtils,
        Classes,
        Graphics,
        Controls,
        Forms,
        Dialogs,
        StdCtrls,
        Buttons,
        ExtCtrls,
        UCEdit,
        Db,
        Mask,
        DBCtrls,
        UCDBEdit,
        USAGFABRICANTE;

    type


        TFInsertMarcasModelos = class(TForm)
            Bevel1: TBevel;
            LNuevo: TLabel;
            btnAceptar: TBitBtn;
            btnCancelar: TBitBtn;
            Image1: TImage;
            CEMarcaModelo: TColorDBEdit;
            DSMarcasModelos: TDataSource;
            procedure FormKeyPress(Sender: TObject; var Key: Char);
            procedure CEMarcaModeloChange(Sender: TObject);
            procedure btnAceptarClick(Sender: TObject);
            procedure btnCancelarClick(Sender: TObject);
        private

            { Private declarations }
            fSetOfData : TSagFabricante;
            procedure SetDataSet (aValue : TSagFabricante);


        public
            { Public declarations }
            property DataSet : TSagFabricante read fSetOfData write SetDataSet;
        end;

        function InsercionDeMarcasModelos (SetOfData: TSagFabricante) : boolean;

implementation

{$R *.DFM}

    uses
        UCDialgs;


    function InsercionDeMarcasModelos (SetOfData: TSagFabricante) : boolean;
    var
        bOk : boolean;
    begin
        bOk := FALSE;
        with TFInsertMarcasModelos.Create(Application) do
        try
            DataSet := SetOfData;
            bOK := (ShowModal = mrOk)
        finally
            Free;
            result := bOk;
        end
    end;


    procedure TFInsertMarcasModelos.FormKeyPress(Sender: TObject; var Key: Char);
    begin
         if key = ^M
            then begin
                Perform(WM_NEXTDLGCTL,0,0);
                Key := #0
            end
    end;

    procedure TFinsertMarcasModelos.SetDataSet (aValue : TSagFabricante);
    begin
        fSetOfData := aValue;
        DSMarcasModelos.DataSet := fSetOfData.DataSet;
        CEMarcaModelo.DataField := fSetOfData.Nombre;

        if fSetOfData is TMarcas
        then begin
            Caption := 'Inserción de marcas';
            LNuevo.Caption := 'Nueva Marca:';
        end
        else if fSetOfData is TModelos
            then begin
                Caption := 'Inserción de modelos';
                LNuevo.Caption := Format('Nuevo modelo para la marca: %s',[(fSetOfData as TModelos).Marca]);
            end;
        fSetOfData.Append;
    end;

    procedure TFInsertMarcasModelos.CEMarcaModeloChange(Sender: TObject);
    begin
        btnAceptar.Enabled := (Length(Trim(CEMarcaModelo.Text)) > 0)
    end;

    procedure TFInsertMarcasModelos.btnAceptarClick(Sender: TObject);
    var
        sNuevaTupla : string;
    begin
        Perform(WM_NEXTDLGCTL,0,0);
        try
            sNuevaTupla := Trim(CEMarcaModelo.Text);
            if DataSet is TModelos
            then DataSet.ValueByName['CODMARCA'] := IntToStr((DataSet as TModelos).CodMarca);
            DataSet.Post(true);
            DataSet.Refresh;
            DataSet.DataSet.Locate(DataSet.Nombre,sNuevaTupla,[]);
            ShowMessage(Caption, 'Inserción realizada correctamente.');
            ModalResult := mrOk
        except
            on E: Exception do
                MessageDlg(Caption, 'No pudo insertarse. Si el error persiste contacte con el Jefe de Planta.',mtInformation,[mbOk],mbOk,0)
        end
    end;

    procedure TFInsertMarcasModelos.btnCancelarClick(Sender: TObject);
    begin
        DataSet.Cancel;
    end;

end.
