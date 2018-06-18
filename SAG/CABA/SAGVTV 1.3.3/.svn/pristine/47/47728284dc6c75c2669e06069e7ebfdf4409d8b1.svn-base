unit ufmantptoventa;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  StdCtrls, Buttons, SQLExpr, USAGCLASSES, Grids, DBGrids, Db, ExtCtrls,
  Mask, DBCtrls, PicClip, RXSpin, SpeedBar,usuperregistry,UVERSION, globals;

type
  TFmantptoventa = class(TForm)
    PtoVentaSource: TDataSource;
    DBGrid1: TDBGrid;
    bAnadir: TBitBtn;
    bModificar: TBitBtn;
    bEliminar: TBitBtn;
    Fondo: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Identificador: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    DBEdit1: TDBEdit;
    edtcaja: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBComboBox2: TDBComboBox;
    SBarPrincipal: TSpeedBar;
    SpeedbarSection3: TSpeedbarSection;
    SBSalir: TSpeedItem;
    SEMinusMas: TRxSpinButton;
    ComboBox1: TComboBox;
    Label2: TLabel;
    procedure PtoVentaSourceDataChange(Sender: TObject; Field: TField);
    procedure bAnadirClick(Sender: TObject);
    procedure bModificarClick(Sender: TObject);
    procedure bEliminarClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure SBSalirClick(Sender: TObject);
    procedure SEMinusMasBottomClick(Sender: TObject);
    procedure SEMinusMasTopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBComboBox2KeyPress(Sender: TObject; var Key: Char);
    procedure DBComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    FDataBase: TSQLConnection;
    fPtoVenta: TPtoVenta;
    Procedure ActivarFondo(Modo: Boolean);
  public
    { Public declarations }
       tipo_impre:string;
    constructor CreateFromDataBase(aOwner:TComponent; aDataBase: TSQLConnection);

  end;

  Procedure DoMantPtoVenta(aDataBase: TSQLConnection);

var
  Ffmantptoventa: TFmantptoventa;

implementation

uses usagestacion,
   UFPRESPRELIMINAR,
   QrPrnTr,
   UTILORACLE,
   ULOGS,
   UCTIMPRESION,
   UCONST,
   UCLIENTE,
   UUtils,
  USAGDATA;
{$R *.DFM}

ResourceString

    MSJ_CANNOT_DELETE_TYPE = '¡ No se Puede Borrar Este Punto de Venta !';
    MSJ_DELETE_TYPE = '¿ Borrar el Punto de Venta Seleccionado ?';
    MSJ_WRONG_POST = 'No Se Pudieron Grabar Los Datos: ';


Procedure DoMantPtoVenta(aDataBase: TSQLConnection);
begin
    With TFMantPtoVenta.CreateFromDataBase(Application,aDatabase) do
    Try
        Showmodal;
    Finally
        Free;
    end;

end;

constructor TFMantPtoVenta.CreateFromDataBase(aOwner:TComponent; aDataBase: TSQLConnection);
begin
    //Constructor de la clase
    Inherited Create(aOwner);
    FDatabase:= aDataBase;
    fptoventa:=Tptoventa.CreateFromDataBase(fDataBase,DATOS_PTOVENTA,'');
   // fptoventa.DataSet.RequestLive:=True;
    fptoventa.Open;
    PtoVentaSource.DataSet:=fptoventa.DataSet;
end;




procedure TFmantptoventa.PtoVentaSourceDataChange(Sender: TObject;
  Field: TField);
begin
    If ((fPtoVenta<>nil) and (fPtoVenta.Active))
    then begin
        bAnadir.Enabled:=True;
        if FPtoVenta.RecordCount>0
        then begin
            bModificar.Enabled:=True;
            bEliminar.Enabled:=True;
        end
        else begin
            bModificar.Enabled:=False;
            bEliminar.Enabled:=False;
        end;
    end
    else begin
        bAnadir.Enabled:=False;
        bModificar.Enabled:=False;
        bEliminar.Enabled:=False;
    end;
end;

procedure TFmantptoventa.bAnadirClick(Sender: TObject);
begin
    ActivarFondo(True);
    fPtoVenta.Append;
end;

procedure TFmantptoventa.bModificarClick(Sender: TObject);

begin
    tipo_impre:=trim(dbgrid1.Fields[1].AsString);
 with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
      if not OpenKeyRead(CAJA_) then
      begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
      end
      else
      begin

         if   trim(tipo_impre)='C' then
         begin
             COMBOBOX1.ItemIndex := ReadInteger(PRINTER_);
             { if  ReadInteger(NCCF_)= 1 then
              checkbox1.Checked:=true
              else
              checkbox1.Checked:=false;}
         end
         else
         begin
         COMBOBOX1.ItemIndex:=0;
         
         end;


      end;
     finally
       free;
     end;


  ActivarFondo(True);

  fptoVenta.edit;
end;

procedure TFmantptoventa.bEliminarClick(Sender: TObject);
begin
    If Messagedlg(Caption,MSJ_DELETE_TYPE+' : '+fPtoVenta.ValuebyName[FIELD_PTOVENTA],mtconfirmation,[mbyes,mbno],mbNo,0)=mrYes
    then begin
        //Borrar Tipo de cliente
        Try
            fPtoVenta.DataSet.Delete;
            if fPtoVenta.dataset.applyupdates(-1) > 0 then
              raise Exception.Create(MSJ_CANNOT_DELETE_TYPE);
        Except
            fPtoVenta.DataSet.CancelUpdates;
            Messagedlg(Caption,MSJ_CANNOT_DELETE_TYPE,mtInformation,[mbOk],mbOk,0);
        end;
    end;
end;


procedure TFmantptoventa.bOKClick(Sender: TObject);
var impr:longint;
NCCF,posi,imprime_nc:longint;
begin

   Try




if (trim(dbcombobox1.Text)='Manual') or  (trim(dbcombobox1.Text)='M')   then
 begin
 impr:=0;
 end else
 begin
 posi:=pos('-',trim(combobox1.Text));
 impr:=strtoint(trim(copy(trim(combobox1.Text),0,posi-1)));



if (impr > -1 ) then
begin

  with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
        if not OpenKeySec(CAJA_,False,KEY_SET_VALUE) then
      begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
      end
      else
      begin
        Writeinteger(PRINTER_, impr);

      end;
     finally
       free;
     end;



 end;
 {
   if checkbox1.Checked=true then
      imprime_nc:=1
      else
      imprime_nc:=0;



    with TSuperRegistry.Create do
     try
        RootKey := HKEY_LOCAL_MACHINE;
        if not OpenKeySec(CAJA_,False,KEY_SET_VALUE) then
      begin
          Messagedlg('ERROR','No se encontraron los parámetros de la Estación de Trabajo', mtInformation, [mbOk],mbOk,0);
      end
      else
      begin
        Writeinteger(NCCF_, imprime_nc);

      end;
     finally
       free;
     end;

   }

 end;  //manual





        fPtoVenta.Post(true);
        fPtoVenta.Refresh;
        ActivarFondo(False);
    Except
            on E: Exception do begin
              ShowMessage('Mantenimiento Puntos de Venta','Error al conectarse a la base de datos: '+E.Message);
//              Destroy;
            end;

    End;
end;

procedure TFmantptoventa.bCancelClick(Sender: TObject);
begin
    Try
        fPtoVenta.Cancel;
    Except
    End;
    ActivarFondo(False);
end;

Procedure TFMantPtoVenta.ActivarFondo(Modo: Boolean);
begin
    Fondo.Visible:=Modo;
    if Modo
    then begin
        Fondo.BringToFront;
        DBEdit1.SetFocus;
    end;
end;



procedure TFmantptoventa.SBSalirClick(Sender: TObject);
begin
  close;
end;


procedure TFmantptoventa.SEMinusMasBottomClick(Sender: TObject);
begin
      edtcaja.SetFocus;
      try
        if StrToInt(edtcaja.Text) > 1
        then edtcaja.Text := IntToStr(StrToInt(edtcaja.Text) - 1)
      except
        edtcaja.Text := IntToStr(1);
      end;
end;

procedure TFmantptoventa.SEMinusMasTopClick(Sender: TObject);
begin
      edtcaja.SetFocus;
      try
        if StrToInt(edtcaja.Text) < 9
        then edtcaja.Text := IntToStr(StrToInt(edtcaja.Text) + 1)
      except
        edtcaja.Text := IntToStr(1);
      end;
end;

procedure TFmantptoventa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    fPtoVenta.free;
end;

procedure TFmantptoventa.FormKeyPress(Sender: TObject; var Key: Char);
begin
     if key = #13
     then begin
         Perform(WM_NEXTDLGCTL,0,0);
         Key := #0
     end;
end;

procedure TFmantptoventa.DBComboBox2KeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['S','N'])
        then key := #0

end;

procedure TFmantptoventa.DBComboBox1KeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['C','M'])
        then key := #0
end;

procedure TFmantptoventa.FormActivate(Sender: TObject);
 var aQ : TsqlQuery;
 I:LONGINT;
begin
COMBOBOX1.Clear;
COMBOBOX1.Items.Add('Seleccione Controlador Fiscal');
  aQ := TsqlQuery.Create(self);
            try
               aQ.SQLConnection := MyBD;
               aQ.SQL.Add('SELECT CODIGO, CONTROLADOR FROM TCONTROLADORES_FISCALES ORDER BY CODIGO');
               aQ.Open;
               FOR I:= 1 TO AQ.RecordCount DO
                BEGIN
                COMBOBOX1.Items.Add(TRIM(AQ.Fields[0].ASSTRING)+' - '+TRIM(AQ.Fields[1].ASSTRING));
                AQ.Next;
                END;
             
            finally
                aQ.Free;
            end;
end;

end.
