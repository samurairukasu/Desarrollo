unit UFStandByData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, UCDialgs,
  StdCtrls, Buttons, ExtCtrls, USAGCLASSES, usagestacion, sqlExpr;

type
  TFrmToStandByData = class(TForm)
    bContinuar: TBitBtn;
    bCancelar: TBitBtn;
    EditMotivo: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditInspector: TEdit;
    LabelEjercici: TLabel;
    LabelCodinspe: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LabelPatente: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    procedure bContinuarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    fDataBase: TSQLConnection;
    fInspeccion: TEstadoInspeccion;
    Function ValidData: Boolean;
  public
    { Public declarations }
    Constructor CreateFromInspeccion(aInspeccion: TEstadoInspeccion);
  end;

var
  FrmToStandByData: TFrmToStandByData;

implementation

{$R *.DFM}

Const
    FIELD_EJERCICI = 'EJERCICI';
    FIELD_CODINSPE = 'CODINSPE';
    FIELD_MATRICUL = 'MATRICUL';

Constructor TFrmToStandByData.CreateFromInspeccion(aInspeccion: TEstadoInspeccion);
begin
    //Crea el form a partir de los datos de la inpseccion pasada como parámetro
    Inherited Create(Application);
    fInspeccion := aInspeccion;
    fDataBase := fInspeccion.DataBase;
end;

procedure TFrmToStandByData.bContinuarClick(Sender: TObject);
var
    aQ: TSQLQuery;
begin
    //Actualizar auditoria de StandBy's
    If Not ValidData
    then begin
        Messagedlg('ENVIAR A STANDBY','¡ Datos Erroneos o Incompletos !',mtInformation,[mbIgnore],mbIgnore,0);
        Exit;
    end;

    aQ:=TSQLQuery.Create(self);
    With aQ do begin
        Try
            sqlconnection := FDataBase;
            Sql.Add(Format('INSERT INTO TAUDITORIAINSPECCIONES '+
                    '(EJERCICI,CODINSPE,INSPECTOR,MOTIVO) '+
                    ' VALUES '+
                    '(%S,%S,''%S'',''%S'')',
                    [LabelEjercici.Caption,LabelCodinspe.Caption,EditInspector.Text,EditMotivo.Text]));
            ExecSql;
        Finally
            Close;
            Free;
        end;
    end;
    
    //cerrar
    ModalResult:=MrOk;
end;

procedure TFrmToStandByData.FormActivate(Sender: TObject);
begin
    //Rellenar datos de la inspeccion
    LabelEjercici.Caption:=fInspeccion.ValueByName[FIELD_EJERCICI];
    LabelCodInspe.Caption:=fInspeccion.ValueByName[FIELD_CODINSPE]; 
    LabelPatente.Caption:=fInspeccion.ValueByName[FIELD_MATRICUL];
    EditMotivo.SetFocus;
end;

Function TFrmToStandByData.ValidData: Boolean;
begin
    //Valida los datos rellenados
    Result:=True;
    If ((EditMotivo.Text='') or (EditInspector.Text='')) Then Result:=False;
end;

end.//Fianl de la unidad
