unit UFABMTarjeta;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs, usagclasses,
  USagEstacion, Db, Grids, DBGrids, StdCtrls, DBCtrls, Mask, Buttons, UTilOracle,
  RXSpin, ExtCtrls, SpeedBar, UInterfazUsuario, SQLExpr;


type
  TFrmABMTarjeta = class(TForm)             
    SBarPrincipal: TSpeedBar;
    SpeedbarSection3: TSpeedbarSection;
    SBSalir: TSpeedItem;
    Fondo: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Identificador: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    bOK: TBitBtn;
    bCancel: TBitBtn;
    DBEdit1: TDBEdit;
    bAnadir: TBitBtn;
    bEliminar: TBitBtn;
    DBGrid1: TDBGrid;
    TarjetaSource: TDataSource;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    Image1: TImage;
    procedure SBSalirClick(Sender: TObject);
    procedure TarjetaSourceDataChange(Sender: TObject; Field: TField);
    procedure bAnadirClick(Sender: TObject);
    procedure bEliminarClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FDataBase: TSQLConnection;
    ftarjeta: TTarjeta;
    Procedure ActivarFondo(Modo: Boolean);    
  public
    { Public declarations }
    constructor CreateFromDataBase(aOwner:TComponent; aDataBase: TSQLConnection);
  end;

  Procedure DoABMTarjeta(aDataBase: TSQLConnection);

var
  FrmABMTarjeta: TFrmABMTarjeta;

implementation

{$R *.DFM}
ResourceString

    MSJ_CANNOT_DELETE_TYPE = '¡ No se Puede Borrar Esta Tarjeta !';
    MSJ_DELETE_TYPE = '¿ Borrar la Tarjeta Seleccionada ?';
    MSJ_WRONG_POST = 'No Se Pudieron Grabar Los Datos: ';


Procedure DoABMTarjeta(aDataBase: TSQLConnection);
begin
    With TFrmABMTarjeta.CreateFromDataBase(Application,aDatabase) do
    Try
        Showmodal;
    Finally
        Free;
    end;

end;

constructor TFrmABMTarjeta.CreateFromDataBase(aOwner:TComponent; aDataBase: TSQLConnection);
begin
    //Constructor de la clase
    Inherited Create(aOwner);
    FDatabase:= aDataBase;
    ftarjeta:=TTarjeta.create(FDatabase);
    { TODO -oran -cquedo asi !!!! : ver si esto es necesario hacer algo }
    //    ftarjeta.DataSet.RequestLive:=True;
    ftarjeta.Open;
    TarjetaSource.DataSet:=ftarjeta.DataSet;
end;


procedure TFrmABMTarjeta.SBSalirClick(Sender: TObject);
begin
  close;
end;

procedure TFrmABMTarjeta.TarjetaSourceDataChange(Sender: TObject;
  Field: TField);
begin
    If ((fTarjeta<>nil) and (fTarjeta.Active))
    then begin
        bAnadir.Enabled:=True;
        if FTarjeta.RecordCount>0
        then begin
//            bModificar.Enabled:=True;
            bEliminar.Enabled:=True;
        end
        else begin
//            bModificar.Enabled:=False;
            bEliminar.Enabled:=False;
        end;
    end
    else begin
        bAnadir.Enabled:=False;
//        bModificar.Enabled:=False;
        bEliminar.Enabled:=False;
    end;

end;

procedure TFrmABMTarjeta.bAnadirClick(Sender: TObject);
var aQ: TSQLQuery;
begin
    ActivarFondo(True);
    fTarjeta.Append;
    aQ:=TSQLQuery.Create(self);
    With aQ do
        Try
            SQLConnection:=FDataBase;
            Sql.Add('SELECT SQ_TTARJETAS_CODTARJET.NEXTVAL FROM DUAL');
            Open;
            FTarjeta.ValueByName[FIELD_CODTARJET]:=aQ.fields[0].asstring;
        Finally
            Close;
            Free;
        end;
    FTarjeta.ValueByName[FIELD_FECHALTA] := DateBD(FDatabase);


end;

procedure TFrmABMTarjeta.bEliminarClick(Sender: TObject);
begin
    If Messagedlg(Caption,MSJ_DELETE_TYPE+' : '+fTarjeta.ValuebyName[FIELD_NOMTARJET],mtconfirmation,[mbyes,mbno],mbNo,0)=mrYes
    then begin
        //Borrar Tipo de cliente
        Try
            fTarjeta.DataSet.Delete;
            if fTarjeta.dataset.applyupdates(-1) > 0 then
              raise Exception.Create(MSJ_CANNOT_DELETE_TYPE);
        Except
            fTarjeta.DataSet.CancelUpdates;
            Messagedlg(Caption,MSJ_CANNOT_DELETE_TYPE,mtInformation,[mbOk],mbOk,0);
        end;
    end;
end;

Procedure TFrmABMTarjeta.ActivarFondo(Modo: Boolean);
begin
    Fondo.Visible:=Modo;
    if Modo
    then begin
        Fondo.BringToFront;
        DBEdit1.SetFocus;
    end;
end;

procedure TFrmABMTarjeta.bOKClick(Sender: TObject);
begin
  try
    Try
        fTarjeta.Post(true);
        fTarjeta.Refresh;
        ActivarFondo(False);
    Except
            on E: Exception do begin
              ShowMessage('Mantenimiento Tarjetas','Error al conectarse a la base de datos: '+E.Message);
//              Destroy;
            end;

    End;
  finally
    dbedit1.ReadOnly := False;
    dbedit3.ReadOnly := False;
  end;

end;

procedure TFrmABMTarjeta.bCancelClick(Sender: TObject);
begin
  Try
    Try
        fTarjeta.Cancel;
    Except
    End;
    ActivarFondo(False);
  finally
    dbedit1.ReadOnly := False;
    dbedit3.ReadOnly := False;
  end;
end;



procedure TFrmABMTarjeta.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
        if key = #13
        then begin
            Perform(WM_NEXTDLGCTL,0,0);
            Key := #0
        end
end;

procedure TFrmABMTarjeta.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
     if Key = #4 then
     begin
          ActivarFondo(True);
          fTarjeta.edit;
          dbedit1.ReadOnly := True;
          dbedit3.ReadOnly := True;
     end;
end;

end.
