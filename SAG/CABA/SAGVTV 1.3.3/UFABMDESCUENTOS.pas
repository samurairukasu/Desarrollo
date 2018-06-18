unit ufabmdescuentos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ucDialgs,
  Db, SpeedBar, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  SQLExpr, usagClasses, RxLookup, USAGESTACION,UTilOracle, UCEdit, usagcuit,
  ToolEdit, RXDBCtrl, UInterfazUsuario, ULOGS, uutils, dateutil, Provider,
  DBClient;

type
  TfrmAbmDescuentos = class(TForm)
    DBGrid1: TDBGrid;
    Fondo: TPanel;
    Bevel1: TBevel;
    Label1: TLabel;
    Identificador: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    dbeconcepto: TDBEdit;
    EPORCENTA: TDBEdit;
    SBarPrincipal: TSpeedBar;
    SpeedbarSection3: TSpeedbarSection;
    SBSalir: TSpeedItem;
    bAnadir: TBitBtn;
    bEliminar: TBitBtn;
    dsTDescuento: TDataSource;
    dsVista: TDataSource;
    dsClientes: TDataSource;
    CBTDPropietario: TComboBox;
    CENroPropietario: TColorEdit;
    dbedescripcion: TDBEdit;
    CENombrePropietario: TColorEdit;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    dbevigini: TDBDateEdit;
    dbefecfin: TDBDateEdit;
    Label9: TLabel;
    btnmodificar: TBitBtn;
    CBEmite: TDBComboBox;
    CBComprob: TDBComboBox;
    CBDiscim: TDBComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Bevel2: TBevel;
    Label13: TLabel;
    DBComboBox1: TDBComboBox;
    procedure SBSalirClick(Sender: TObject);
    procedure bAnadirClick(Sender: TObject);
    procedure CBTDPropietarioChange(Sender: TObject);
    procedure CENroPropietarioChange(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bEliminarClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeconceptoEnter(Sender: TObject);
    procedure dbeconceptoExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure EPORCENTAKeyPress(Sender: TObject; var Key: Char);
    procedure dsVistaDataChange(Sender: TObject; Field: TField);
    procedure btnmodificarClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure CBEmiteKeyPress(Sender: TObject; var Key: Char);
    procedure CBEmiteChange(Sender: TObject);
  private
    { Private declarations }
    fDatabase: tSQLConnection;
    fDescuento : TDescuento;
    fClientes: TClientes;

    aQ: TSQLDataset;
    dsp : TDataSetProvider;
    cds : TClientDataSet;

    constructor CreateFromDataBase(aOwner:TComponent; aDataBase: TSQLConnection);
    Procedure ActivarFondo(Modo: Boolean);
    function validatepost:boolean;
    procedure CompletarDatosCliente;
    function IntervalDatesOk : boolean;
  public
    { Public declarations }
  end;

  Procedure DoABMDescuento(aDataBase: TSQLConnection);

var
  frmAbmDescuentos: TfrmAbmDescuentos;

implementation

{$R *.DFM}
ResourceString

    MSJ_CANNOT_DELETE_TYPE = '¡ No se Puede Borrar Este Descuento !';
    MSJ_DELETE_TYPE = '¿ Borrar el Descuento Seleccionado ?';
    MSJ_WRONG_POST = 'No Se Pudieron Grabar Los Datos: ';
    FILE_NAME = 'UFABMDESCUENTOS.PAS';


Procedure DoABMDescuento(aDataBase: TSQLConnection);
begin
    With TFrmABMDescuentos.CreateFromDataBase(Application,aDatabase) do
    Try
        Showmodal;
    Finally
        Free;
    end;

end;

constructor TFrmABMDescuentos.CreateFromDataBase(aOwner:TComponent; aDataBase: TSQLConnection);
begin
    //Constructor de la clase
    Inherited Create(aOwner);
    FDatabase:= aDataBase;
    fDescuento:=TDescuento.create(FDatabase);
//    fDescuento.DataSet.RequestLive:=True;
    fDescuento.Open;
    dsTDescuento.DataSet:=fdescuento.DataSet;


    aQ := TSQLDataSet.Create(Self);
    aQ.SQLConnection := aDataBase;
    aQ.CommandType := ctQuery;

    aQ.GetMetadata := false;
    aQ.NoMetadata := true;
    aQ.ParamCheck := false;

    dsp := TDataSetProvider.Create(self);
    dsp.Name := 'dsp';
    dsp.DataSet := aQ;
    dsp.Options := [poIncFieldProps,poAllowCommandText];

    cds:=TClientDataSet.Create(self);

    with cds do
    begin
        ProviderName := dsp.Name;
        SetProvider(dsp);
        commandtext := ('SELECT CODDESCU, PORCENTA, D.CODCLIEN, TO_CHAR(FECVIGINI,''DD/MM/YYYY'') as FECVIGINI,TO_CHAR(FECVIGFIN,''DD/MM/YYYY'') as FECVIGFIN, CONCEPTO,'+
                'DESCRIPCION, NOMBRE||'' ''||APELLID1||'' ''||APELLID2 as NOMBRE, DECODE(EMITENC,''S'',''SI'',''NO'') EMITENC, DECODE(PRESCOMPROB,''S'',''SI'',''NO'') PRESCOMPROB,'+
	        'DECODE(DISCRIMCD,''S'',''SI'',''NO'') DISCRIMCD, DECODE(ACTIVO,''S'',''SI'',''NO'') ACTIVO '+
                'FROM TDESCUENTOS D, TCLIENTES C WHERE D.CODCLIEN = C.CODCLIEN');
        OPEN;
    end;
    dsVista.dataset := cds;
    fClientes := tclientes.Create(fdatabase);
    dsClientes.DataSet:=fClientes.dataset;

end;

procedure TfrmAbmDescuentos.SBSalirClick(Sender: TObject);
begin
  close;
end;


procedure TfrmAbmDescuentos.bAnadirClick(Sender: TObject);
begin
    ActivarFondo(True);
    ActivarComponentes(true,self,[4,3,6]);
    CBTDPropietario.text := '';
    CENroPropietario.Clear;
    CENombrePropietario.clear;
    fDescuento.Append;
    FDescuento.ValueByName[FIELD_FECHALTA] := DateBD(FDatabase);
end;

Procedure TfrmAbmDescuentos.ActivarFondo(Modo: Boolean);
begin
    Fondo.Visible:=Modo;
    if Modo
    then begin
        Fondo.BringToFront;
        if CBTDPropietario.enabled then
          CBTDPropietario.SetFocus;
    end;
end;

procedure TfrmAbmDescuentos.CBTDPropietarioChange(Sender: TObject);
begin
        with CENroPropietario do
        begin
            Text := ''; Color := clWindow; Enabled := TRUE
        end;
end;

procedure TfrmAbmDescuentos.CENroPropietarioChange(Sender: TObject);
begin
        CENombrePropietario.Text := '';
        if ((Length((SEnder as TColorEdit).Text) > 0) and (CBTDPropietario.ItemIndex<>-1))
        then begin
                try
                    Label1.Font.Color:=clBlack;
                    if (TTipoDocumento(CBTDPropietario.ItemIndex) <> ttdCUIT) or
                       ((TTipoDocumento(CBTDPropietario.ItemIndex) = ttdCUIT) and (TCUIT.IsCorrect((Sender as TColorEdit).Text)))
                    then begin
                        fclientes.Free;
                        fclientes := nil;
                        fclientes := TClientes.CreateFromCode(fdatabase,CBTDPropietario.Items[CBTDPropietario.ItemIndex],(Sender as TColorEdit).Text);
                        fclientes.Open;
                        if (fclientes.RecordCount <> 0) then
                        begin
                            CBTDPropietario.ItemIndex := CBTDPropietario.Items.IndexOf (fclientes.ValueByName[FIELD_TIPODOCU]);
                            CENroPropietario.Text := fclientes.ValueByName[FIELD_DOCUMENT];
                            CENombrePropietario.Text := fclientes.ValueByName[FIELD_NOMBRE_Y_APELLIDOS];
                        end;
                    end;
                except
                    on E: Exception do
                        MessageDlg('Identificación del Cliente',Format('Esta fallando la introducción de datos del cliente por: %s. Compruebe que los datos introducidos son correctos. Si el error persiste indíquelo al jefe de planta.',[E.message]), mtInformation, [mbOk], mbOk, 0)
                end;
        end;

end;


procedure TfrmAbmDescuentos.bOKClick(Sender: TObject);
begin
    Try
        fDescuento.ValueByName[FIELD_CODCLIEN]:=fClientes.ValueByName[FIELD_CODCLIEN];
        if validatepost then
        begin
          cds.Close;
          cds.Open;
          fclientes.Free;
          fClientes:=nil;
          CENroPropietario.Clear;
          CENombrePropietario.clear;
          CBTDPropietario.text := '';
          ActivarFondo(False);
          cds.Locate(FIELD_CODDESCU,fdescuento.valuebyname[FIELD_CODDESCU],[]);
        end;
    Except
            on E: Exception do begin
              ShowMessage('Mantenimiento Tarjetas','Error al conectarse a la base de datos: '+E.Message);
            end;

    End;
end;







procedure TfrmAbmDescuentos.bEliminarClick(Sender: TObject);
begin
    if cds.recordcount > 0 then
    begin
      fDescuento.locate(FIELD_CODDESCU,cds.fields[0].asstring,[]);
      If Messagedlg(Caption,MSJ_DELETE_TYPE+' : '+fDescuento.ValuebyName[FIELD_CONCEPTO],mtconfirmation,[mbyes,mbno],mbNo,0)=mrYes
      then begin
          Try
            fDescuento.DataSet.Delete;
            cds.close;
            cds.open;
          Except
            Messagedlg(Caption,MSJ_CANNOT_DELETE_TYPE,mtInformation,[mbOk],mbOk,0);
          end;
      end;
    end;
end;

procedure TfrmAbmDescuentos.bCancelClick(Sender: TObject);
begin
    Try
        fDescuento.Cancel;
        fclientes.Free;
        fclientes:=nil;
    Except
    End;
    ActivarFondo(False);
end;

procedure TfrmAbmDescuentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    if assigned(fclientes) then fClientes.free;
    fDescuento.free;
    cds.Close;
    cds.Free;
    dsp.Free;
    aq.Close;
    aq.Free;
end;

procedure TfrmAbmDescuentos.dbeconceptoEnter(Sender: TObject);
begin
    DestacarControl (Sender, clGreen, clWhite, TRUE);
end;

procedure TfrmAbmDescuentos.dbeconceptoExit(Sender: TObject);
begin
    AtenuarControl(Sender, TRUE);
end;

procedure TfrmAbmDescuentos.FormKeyPress(Sender: TObject; var Key: Char);
begin               
  if (key = #13) and not (activeControl is Tbutton) then
  begin
    Perform(WM_Nextdlgctl, 0, 0);
    key := #0;
  end;
end;

function TfrmAbmDescuentos.validatepost:boolean;
var laQ: TSQLDataset;
    ldsp : TDataSetProvider;
    lcds : TClientDataSet;
begin
  result:=false;
  try
    if (CBTDPropietario.Text = '') or (CENroPropietario.text = '') or (fDescuento.ValueByName[FIELD_CODCLIEN] = '') then
    begin
      MessageDlg(Caption,'Debe seleccionar un Cliente Existente',mtInformation, [mbOk],mbOk,0);
      CBTDPropietario.setfocus;
      exit;
    end;
    if (dbeConcepto.text = '') then
    begin
      MessageDlg(Caption,'Debe ingresar un Concepto',mtInformation, [mbOk],mbOk,0);
      dbeConcepto.setfocus;
      exit;
    end;
    if (ePorcenta.Text = '') then
    begin
      MessageDlg(Caption,'Debe ingresar un Porcentaje de Descuento',mtInformation, [mbOk],mbOk,0);
      ePorcenta.setfocus;
      exit;
    end;
    if fDescuento.dataset.state in [dsInsert] then
    begin
      try

    laQ := TSQLDataSet.Create(self);
    laQ.SQLConnection := fDataBase;
    laQ.CommandType := ctQuery;

    laQ.GetMetadata := false;
    laQ.NoMetadata := true;
    laQ.ParamCheck := false;


    

    ldsp := TDataSetProvider.Create(self);
    ldsp.DataSet := aQ;
    ldsp.Options := [poIncFieldProps,poAllowCommandText];

    lcds:=TClientDataSet.Create(self);

        with lcds do
        begin
          SetProvider(ldsp);
          CommandText := ('SELECT CONCEPTO FROM TDESCUENTOS');
          open;
          if locate(FIELD_CONCEPTO,DBECONCEPTO.Text,[]) then
          begin
            MessageDlg(Caption,pchar(format('El Concepto: %S ya existe.  No se pueden tener dos conceptos iguales.',[DBECONCEPTO.Text])),mtInformation, [mbOk],mbOk,0);
            dbeconcepto.setfocus;
            exit;
          end;
        end;
      finally
        lcds.Close;
        lcds.Free;
        ldsp.Free;
        laq.Close;
        laq.Free;
      end;
    end;
    try
      strtodate(dbevigini.text)
    except
         MessageDlg (Caption,'Debe ingresar una fecha de Inicio de Vigencia válida', mtInformation, [mbOk], mbOk, 0);
         dbevigini.setfocus;
         exit;
    end;
    if dbefecfin.text <> '  /  /    ' then
    begin
      try
        strtodate(dbefecfin.text)
      except
           MessageDlg (Caption,'Debe ingresar una fecha de Fin de Vigencia válida', mtInformation, [mbOk], mbOk, 0);
           dbefecfin.setfocus;
           exit;
      end;
      if not IntervalDatesOk
      then begin
         MessageDlg (Caption,'La fecha de inicio debe ser posterior o igual que la fecha final.', mtInformation, [mbOk], mbOk, 0);
         dbefecfin.setfocus;
         exit;
      end;
    end;
    if (dbedescripcion.text = '') then
    begin
      MessageDlg(Caption,'Debe ingresar una Descripción',mtInformation, [mbOk],mbOk,0);
      dbedescripcion.setfocus;
      exit;
    end;

    fDescuento.Post(true);
    result := True;
  except
    on E: Exception do
       begin
          MessageDlg(Caption,Format('Error al intentar guardar los datos: %s. Si el error persiste indíquelo al Jefe de Planta.',[E.message]), mtInformation, [mbOk],mbOk,0);
       end

  end;
end;



procedure TfrmAbmDescuentos.EPORCENTAKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (Key in ['-','+','*','/'])
  then key := #0
end;


procedure TfrmAbmDescuentos.dsVistaDataChange(Sender: TObject;
  Field: TField);
begin
  if (cds.fields[4].asstring = '') or (strtodate(cds.fields[4].asstring) >= date)then
  begin
    activarComponentes(true,self,[5]);
  end
  else
    activarComponentes(false,self,[5]);
end;

procedure TfrmAbmDescuentos.btnmodificarClick(Sender: TObject);
begin
    if cds.RecordCount > 0 then
    begin
      ActivarFondo(True);
      fDescuento.Locate(field_coddescu,cds.fields[0].asstring,[]);
      fDescuento.edit;
      activarComponentes(false,self,[4,3,6]);
      CompletarDatosCliente;
      dbefecfin.setfocus;
    end;
end;

procedure TfrmAbmDescuentos.CompletarDatosCliente;
begin
    fclientes:=nil;
    fclientes:=tclientes.CreateFromCodclien(fdatabase,cds.fields[2].asinteger);
    fclientes.open;
    CBTDPropietario.ItemIndex := CBTDPropietario.Items.IndexOf (fclientes.ValueByName[FIELD_TIPODOCU]);
    CENroPropietario.Text := fclientes.ValueByName[FIELD_DOCUMENT];
end;

procedure TfrmAbmDescuentos.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
     if Key = #4 then
     begin
          btnmodificar.Click;
          activarComponentes(true,self,[3]);
     end
     else
     if Key = #18 then
     begin
          btnmodificar.Click;
          activarComponentes(true,self,[3,6]);
     end

end;

function TfrmAbmDescuentos.IntervalDatesOk : boolean;
begin
    result :=  (dbevigini.Date <= dbefecfin.Date);
end;

procedure TfrmAbmDescuentos.CBEmiteKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['S','N','s','n'])
        then key := #0
end;

procedure TfrmAbmDescuentos.CBEmiteChange(Sender: TObject);
begin
  (sender as tdbcombobox).TEXT:=UPPERCASE((sender as tdbcombobox).TEXT);
end;


end.
