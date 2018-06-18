unit UFPrevioMantClientes;

interface

   uses
        Windows,
        Messages,
        SysUtils,
        Classes,
        Graphics,
        Controls,
        Forms,
        UCDialgs,
        StdCtrls,
        ExtCtrls,
        Buttons,
        USAGCLASSES,
        USAGVARIOS,
        UCDBEDIT,
        UFMantClientes,
        UCEdit, Db, Mask, DBCtrls, RxGIF;

   type

         TFPrevioMantenimientoCliente = class(TForm)
         Panel1: TPanel;
         CBTDCliente: TComboBox;
         CENroCliente: TColorEdit;
         BContinuar: TBitBtn;
         BCancelar: TBitBtn;
         Bevel1: TBevel;
         Label2: TLabel;
         Label3: TLabel;
         Label4: TLabel;
         Label23: TLabel;
         Image1: TImage;
         CENombreCliente: TColorEdit;
         ClienteSource: TDataSource;
    LblCuitformat: TLabel;
         procedure CBTDClienteChange(Sender: TObject);
         procedure CBTDClienteEnter(Sender: TObject);
         procedure CBTDClienteExit(Sender: TObject);
         procedure CENroClienteChange(Sender: TObject);
         procedure CENroClienteKeyPress(Sender: TObject; var Key: Char);
         procedure FormKeyPress(Sender: TObject; var Key: Char);
         procedure FormCreate(Sender: TObject);
         procedure FormDestroy(Sender: TObject);
         procedure BContinuarClick(Sender: TObject);
         procedure FormActivate(Sender: TObject);
    procedure CENroClienteMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
       private
         { Private declarations }

       public
         { Public declarations }
         aCliente : TClientes;
       end;

        procedure DoMantenimientoDeClientes;

   var
       FPrevioMantenimientoCliente: TFPrevioMantenimientoCliente;

implementation

{$R *.DFM}
    uses
        UINTERFAZUSUARIO,
        USAGESTACION,
        USAGCUIT,
        ULOGS,
        GLOBALS;

    ResourceString

        FILE_NAME = 'UFPREVIOMANTENIMIENTOCLIENTE.PAS';

        MQ_NEW_CLIENT = '¿ Crear Nuevo Cliente ?';
        MQ_EDIT_CLIENT = '¿ Editar Datos del Cliente ?';

        FIELD_NombreYApellidos = 'NombreYApellidos';
        FIELD_TIPODOCU = 'TIPODOCU';
        FIELD_DOCUMENT = 'DOCUMENT';


    procedure DoMantenimientoDeClientes;
    var
        bSeguir : boolean;
        FichaPrevia : TFPrevioMantenimientoCliente;
    begin  
        bSeguir := TRUE;
        FichaPrevia := TFPrevioMantenimientoCliente.Create(Application);
        try
            Try
                //UnCliente := TClientes.CreateByRowId(MyBD,'');
                while bSeguir do
                begin
                    with FichaPrevia do
                    begin
                        //aCliente := TClientes.CreateByCopy(UnCliente);
                        if (ShowModal <> mrCancel)
                        then //RegistraClienteEnEstacion (aCliente, aDV, FALSE)
                        else bSeguir := FALSE;
                    end;
                end
            except
                on E: Exception do
                    MessageDlg('Mantenimiento de clientes',Format('La presentación de los datos del cliente no ha podido realizarse por: %s. Cancele la operación. Si el error persiste indíquelo al jefe de planta.',[E.message]), mtWarning ,[mbOk], mbOk, 0)
            end
        finally
            //UnCliente.Free;
            FichaPrevia.Free;
        end

    end;


    procedure TFPrevioMantenimientoCliente.CBTDClienteChange(Sender: TObject);
    begin
        with CENroCliente do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;

        with (CENombreCliente) do
        begin
            Text := ''; Color := clWindow;  Enabled := TRUE
        end;

        If CBTDCliente.ItemIndex<>4
        then LblCuitformat.Visible:=False
        else begin
            LblCuitformat.Visible:=True;
            LblCuitformat.Font.Color:=ClRed;
        end;
    end;

    procedure TFPrevioMantenimientoCliente.CBTDClienteEnter(Sender: TObject);
    begin
        DestacarControl (Sender, clGreen, clWhite, TRUE);
    end;

    procedure TFPrevioMantenimientoCliente.CBTDClienteExit(Sender: TObject);
    begin
        AtenuarControl(Sender, TRUE);
    end;

    procedure TFPrevioMantenimientoCliente.CENroClienteChange(Sender: TObject);
    begin
        if Length((SEnder as TColorEdit).Text) > 0
        then begin
            try
                try
                    BContinuar.Enabled := FALSE;
                    CENombreCliente.Text := '';
                    LblCuitformat.Font.Color:=ClBlack;

                    if (TTipoDocumento(CBTDCliente.ItemIndex) <> ttdCUIT) or
                       ((TTipoDocumento(CBTDCliente.ItemIndex) = ttdCUIT) and (TCUIT.IsCorrect((Sender as TColorEdit).Text)))
                    then begin
                        aCliente.Free;
                        aCliente:=nil;
                        aCliente := TClientes.CreateFromCode(MyBD,CBTDCliente.Items[CBTDCliente.ItemIndex],(Sender as TColorEdit).Text);
                        aCliente.Open;
                        ClienteSource.DataSet:=aCliente.DataSet;
                        CENombreCliente.Text := aCliente.ValueByName[FIELD_NombreYApellidos];
                        BContinuar.Enabled := TRUE
                    end
                    else begin
                        LblCuitformat.Font.Color:=ClRed;
                        BContinuar.Enabled := False;
                    end;
                finally
                    //BContinuar.Enabled := TRUE
                end
            except
                on E: Exception do
                    MessageDlg('Identificación del Cliente',Format('Esta fallando la introducción de datos del cliente por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste indíquelo al jefe de planta.',[E.message]), mtWarning, [mbOk], mbOk, 0)
            end
        end
        else BContinuar.Enabled := FALSE
    end;

    procedure TFPrevioMantenimientoCliente.CENroClienteKeyPress(Sender: TObject; var Key: Char);
    begin
        if Key = Char(VK_SPACE)
        then Key := #0
    end;

    procedure TFPrevioMantenimientoCliente.FormKeyPress(Sender: TObject; var Key: Char);
    begin
        if key = ^M
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
    end;

    procedure TFPrevioMantenimientoCliente.FormCreate(Sender: TObject);
    begin
        aCliente := nil
    end;

    procedure TFPrevioMantenimientoCliente.FormDestroy(Sender: TObject);
    begin
        aCliente.Free
    end;

    procedure TFPrevioMantenimientoCliente.BContinuarClick(Sender: TObject);
    var
        EditCliente: TFAMCliente;
    begin
        If aCliente.IsNew
        Then begin
            //Cliente Nuevo
            //If Messagedlg(Application.Title,MQ_NEW_CLIENT,mtConfirmation,[mbyes,mbNo],mbYes,0)<>mryes Then Exit;
            aCliente.Append;
            aCliente.ValueByName[FIELD_TIPODOCU]:=CBTDCliente.Items[CBTDCliente.ItemIndex];
            aCliente.ValueByName[FIELD_DOCUMENT]:=CENroCliente.Text;
        end
        else begin
            //editar Cliente
            //If Messagedlg(Application.Title,MQ_EDIT_CLIENT,mtConfirmation,[mbyes,mbNo],mbYes,0)<>mryes Then Exit;
            If not aCliente.Edit
            then begin
                fAnomalias.PonAnotacion(TRAZA_SIEMPRE,1,FILE_NAME,'Falló la puesta en edicion de la tabla de clientes');
                Raise Exception.Create('The Data Could not Be Edit');
            end;
        end;
        EditCliente:=TFAMCliente.CreateFromCliente(Application,aCliente);
        Try
            EditCliente.ShowModal;
        Finally
            EditCliente.Free;
            CENombreCliente.Clear;
            CENroCliente.Clear;
        end;
    end;

    procedure TFPrevioMantenimientoCliente.FormActivate(Sender: TObject);
    begin
        //iNICALIZA LOS CAMPOS DE BUSQUEDA DEL FORM
        CBTDCliente.ItemIndex:=-1;
        CENroCliente.Text:='';
        CENombreCliente.Text:='';
        CBTDCliente.SetFocus;
    end;

procedure TFPrevioMantenimientoCliente.CENroClienteMouseMove(
  Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
    If CBTDCliente.ItemIndex<>4
    then CENroCliente.Hint:='Número de documento del cliente.'
    else CENroCliente.Hint:='Número de documento del cliente. "00-00000000-0"'
end;

end.
