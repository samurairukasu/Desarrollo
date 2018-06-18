unit uGetEspeDesti;

{ Unidad encargada de recoger las fechas por teclado, la salida es
  Fecha Inicial + 00h:00m:00s, Fecha Final + 23h:59m:59ss}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Buttons, ExtCtrls, Mask, ToolEdit, UCEdit, RXLookup, Db, USagGruposVehiculares,
  usagclasificacion, uInterfazUsuario;

type

  TFGetEspeDesti = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DSToTGEspecies: TDataSource;
    DSToTEspecies: TDataSource;
    DSToTGDestinos: TDataSource;
    DSToTDestinos: TDataSource;
    Label13: TLabel;
    Label14: TLabel;
    CBGrupoEspecie: TRxDBLookupCombo;
    CBTipoEspecie: TRxDBLookupCombo;
    CBGrupoDestino: TRxDBLookupCombo;
    CBTipoDestino: TRxDBLookupCombo;
    CECodigoEspecie: TColorEdit;
    CECodigoDestino: TColorEdit;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CECodigoEspecieChange(Sender: TObject);
    procedure CECodigoEspecieKeyPress(Sender: TObject; var Key: Char);
    procedure CBGrupoEspecieChange(Sender: TObject);
    procedure CBGrupoEspecieCloseUp(Sender: TObject);
    procedure CBGrupoEspecieEnter(Sender: TObject);
    procedure CBGrupoEspecieExit(Sender: TObject);
    procedure CBTipoEspecieChange(Sender: TObject);
    procedure CBTipoEspecieCloseUp(Sender: TObject);
    procedure CECodigoDestinoChange(Sender: TObject);
  private
    fGEspecies: TGVehicularesEspecie;
    fGDestinos: TGVehicularesDestino;
    fDestinos : TTDestinos;
    fEspecies : TTEspecies;

    function DatosCorrectos: boolean;

  public

  end;

   Function GetEspeDesti (var vEspecie, vDestino: integer; var sEspecie, sDestino: string): Boolean;

var
  FGetEspeDesti: TFGetEspeDesti;

implementation

{$R *.DFM}

uses
   UCDIALGS,
   ULOGS,
   GLOBALS,
   dateutil,
   UTILORACLE,
   ugacceso,
   usagctte;


const
    CABECERA_MENSAJES_BUSFECH = 'Buscar por fecha';
    FICHERO_ACTUAL = 'UGetDates.pas';
   { Hints enviados al usuario desde la unidad MBusFech }
{    HNT_MBUSCFECH_FINI = 'Pinche sobre el calendario para introducir la fecha inicial|Fecha de comienzo de la búsqueda. Formato: dd/mm/yyyy';
    HNT_MBUSCFECH_FFIN = 'Pinche sobre el calendario para introducir la fecha final|Fecha de finalización de la búsqueda. Formato: dd/mm/yyyy';
    HNT_MBUSCFECH_ACEPTAR = 'Llevar a cabo la búsqueda señalada|Selecciona un rango de valores entre las fechas seleccionadas';
    HNT_MBUSCFECH_CANCELAR = 'Cancela la búsqueda|NO selecciona un rango de valores entre las fechas seleccionadas';
}


procedure TFGetEspeDesti.btnAceptarClick(Sender: TObject);
begin
    if not DatosCorrectos
    then begin
        MessageDlg (Caption,'La fecha de inicio debe ser menor o igual que la fecha final.', mtInformation, [mbOk], mbOk, 0);
//        DEFechaInicial.setfocus;
    end
    else ModalResult := mrOK
end;

function tfGetEspeDesti.DatosCorrectos:boolean;
begin
  result := true;
end;

procedure TFGetEspeDesti.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = Chr(VK_RETURN) then
    begin
        Perform (WM_NEXTDLGCTL, 0, 0);
        Key := #0;
    end;
end;

procedure TFGetEspeDesti.FormCreate(Sender: TObject);
begin
            fGEspecies := nil;
            fGDestinos := nil;
            fEspecies := nil;
            fDestinos := nil;

            fGEspecies := TGVehicularesEspecie.Create(MyBD);
            fEspecies := TTEspecies.Create(MyBD);
            fGDestinos := TGVehicularesDestino.Create(MyBD);
            fDestinos := TTDestinos.Create(MyBD);

            fGEspecies.open;
            fEspecies.open;
            fGDestinos.open;
            fDestinos.open;

            DSToTGEspecies.DataSet := fGEspecies.DataSet;
            DSToTEspecies.DataSet := fEspecies.DataSet;
            DSToTGDestinos.DataSEt := fGDestinos.DataSet;
            DSToTDestinos.DataSet := fDestinos.DataSet;

end;

procedure TFGetEspeDesti.FormDestroy(Sender: TObject);
begin
        fGEspecies.Free;
        fGDestinos.Free;
        fEspecies.Free;
        fDestinos.Free;
end;

Function GetEspeDesti (var vEspecie, vDestino: integer; var sEspecie, sDestino: string):Boolean;
begin
    Result:=FalsE;
    try
        with TFGetEspeDesti.Create(Application) do
        try
            if ShowModal = mrOk
            then begin
                vEspecie := strtoint(CECodigoEspecie.text);
                vDestino := strtoint(CECodigoDestino.text);
                sEspecie := CBTipoEspecie.text;
                sDestino := CBTipoDestino.text;
                Result:=True;
            end;
        finally
            Free
        end
    finally
        Application.ProcessMessages
    end
end;



procedure TFGetEspeDesti.CECodigoEspecieChange(Sender: TObject);
    var
        a,b,c,d: tNotifyEvent;
    begin
        a := CBTipoEspecie.OnChange;
        b := CBGrupoEspecie.OnChange;
        c := CBTipoDestino.OnChange;
        d := CBGrupoDestino.OnChange;
        try
            CBTipoEspecie.OnChange := nil;
            CBGrupoEspecie.OnChange := nil;
            CBTipoDestino.OnChange := nil;
            CBGrupoDestino.OnChange := nil;

            case (Sender as TControl).Tag of

                0: //Especie
                begin
                    fEspecies.FiltraPorCodigo (CECodigoEspecie.Text);
                    CBTipoEspecie.Value := CECodigoEspecie.Text;
                    if CBTipoEspecie.Text <> ''
                    then begin
                        CBGrupoEspecie.Value := fEspecies.ValueByName[CBGrupoEspecie.LookupField];
                        CBTipoEspecie.Enabled := TRUE;
                    end
                    else begin
                        CBGrupoEspecie.Value := '';
                        CBTipoEspecie.Enabled := FALSE;
                    end;
                end;

                1: //Destino
                begin
                    fDestinos.FiltraPorCodigo (CECodigoDestino.Text);
                    CBTipoDestino.Value := CECodigoDestino.Text;
                    if CBTipoDestino.Text <> ''
                    then begin
                        CBGrupoDestino.Value := fDestinos.ValueByName[CBGrupoDestino.LookupField];
                        CBTipoDestino.Enabled := TRUE;
                    end
                    else begin
                        CBGrupoDestino.Value := '';
                        CBTipoDestino.Enabled := FALSE;
                    end
                end;
            end;

        finally
            CBTipoEspecie.OnChange := a;
            CBGrupoEspecie.OnChange := b;
            CBTipoDestino.OnChange := c;
            CBGrupoDestino.OnChange := d;
        end;


end;

procedure TFGetEspeDesti.CECodigoEspecieKeyPress(Sender: TObject;
  var Key: Char);
begin
        if not (Key in ['0','1','2','3','4','5','6','7','8','9',#37,#39,#46,#8])
        then key := #0

end;

procedure TFGetEspeDesti.CBGrupoEspecieChange(Sender: TObject);
    var
        a,b,c,d: tNotifyEvent;
    begin
        a := CECodigoEspecie.Onchange;
        b := CBTipoEspecie.OnChange;
        c := CECodigoDestino.Onchange;
        d := CBTipoDestino.OnChange;

        try
            CECodigoEspecie.OnCHange := nil;
            CBTipoEspecie.OnChange := nil;
            CECodigoDestino.Onchange := nil;
            CBTipoDestino.OnChange := nil;

            case (Sender as TControl).Tag of
                0: //Especie
                begin
                    CECodigoEspecie.Text := '';
                    CBTipoEspecie.Value := '';
                    fEspecies.FiltraPorGrupo(CBGrupoEspecie.Value);
                    CBTipoEspecie.Enabled := CBGrupoEspecie.Text <> '';
                end;

                1: //Destino
                begin
                    CECodigoDestino.Text := '';
                    CBTipoDestino.Value := '';
                    fDestinos.FiltraPorGrupo(CBGrupoDestino.Value);
                    CBTipoDestino.Enabled := CBGrupoDestino.Text <> '';
                end;
            end;
        finally
            CECodigoEspecie.Onchange := a;
            CBTipoEspecie.OnChange := b;
            CECodigoDestino.Onchange := c;
            CBTipoDestino.OnChange := d;
        end;


end;

procedure TFGetEspeDesti.CBGrupoEspecieCloseUp(Sender: TObject);
begin
        if (Sender as TControl).Tag = 0
        then CBGrupoEspecie.Value := fGEspecies.ValueByName[fGEspecies.KeyField]
        else CBGrupoDestino.Value := fGDestinos.ValueByName[fGDestinos.KeyField]

end;

procedure TFGetEspeDesti.CBGrupoEspecieEnter(Sender: TObject);
begin
        DestacarControl (Sender, clGreen, clWhite, TRUE);

        if (Sender.ClassType = TRxDBLookupCombo) and
           ((TRxDBLookupCombo(Sender).Name = 'CBGrupoDestino') or
            (TRxDBLookupCombo(Sender).Name = 'CBTipoEspecie')  or
            (TRxDBLookupCombo(Sender).Name = 'CBTipoDestino')
           )
        then begin
            with (Sender as TRxDBLookupCombo) do
            begin
                Width := Width + 50;
                if Name = 'CBTipoDestino'
                then Left := Left - 71
                else if Name = 'CBGrupoDestino'
                    then Width := Width + 70;
            end;
            exit
        end

end;

procedure TFGetEspeDesti.CBGrupoEspecieExit(Sender: TObject);
begin
        AtenuarControl(Sender, TRUE);
        if (Sender.ClassType = TRxDBLookupCombo) and
           ((TRxDBLookupCombo(Sender).Name = 'CBGrupoDestino') or
            (TRxDBLookupCombo(Sender).Name = 'CBTipoEspecie')  or
            (TRxDBLookupCombo(Sender).Name = 'CBTipoDestino')
           )
        then begin
            with (Sender as TRxDBLookupCombo) do
            begin
                Width := Width - 50;
                if Name = 'CBTipoDestino'
                then Left := Left + 71
                else if Name = 'CBGrupoDestino'
                    then Width := Width - 70;
            end;
            exit
        end


end;

procedure TFGetEspeDesti.CBTipoEspecieChange(Sender: TObject);
    var
        b,c: tNotifyEvent;
    begin
        b := CECodigoEspecie.OnChange;
        c := CECodigoDestino.OnChange;
        try
            CECodigoEspecie.OnChange := nil;
            case (Sender as TControl).Tag of
                0: //Especie
                begin
                    CECodigoEspecie.Text := CBTipoEspecie.Value;
                end;

                1: //Destino
                begin
                   CECodigoDestino.Text := CBTipoDestino.Value;
                end;
            end;
        finally
            CECodigoEspecie.OnChange := b;
            CECodigoDestino.OnChange := c;
        end;

end;

procedure TFGetEspeDesti.CBTipoEspecieCloseUp(Sender: TObject);
begin
        if (Sender as TControl).Tag = 0
        then CBTipoEspecie.Value := fEspecies.ValueByName[fEspecies.KeyField]
        else CBTipoDestino.Value := fDestinos.ValueByName[fDestinos.KeyField]
end;

procedure TFGetEspeDesti.CECodigoDestinoChange(Sender: TObject);
    var
        a,b,c,d: tNotifyEvent;
    begin
        a := CBTipoEspecie.OnChange;
        b := CBGrupoEspecie.OnChange;
        c := CBTipoDestino.OnChange;
        d := CBGrupoDestino.OnChange;
        try
            CBTipoEspecie.OnChange := nil;
            CBGrupoEspecie.OnChange := nil;
            CBTipoDestino.OnChange := nil;
            CBGrupoDestino.OnChange := nil;

            case (Sender as TControl).Tag of

                0: //Especie
                begin
                    fEspecies.FiltraPorCodigo (CECodigoEspecie.Text);
                    CBTipoEspecie.Value := CECodigoEspecie.Text;
                    if CBTipoEspecie.Text <> ''
                    then begin
                        CBGrupoEspecie.Value := fEspecies.ValueByName[CBGrupoEspecie.LookupField];
                        CBTipoEspecie.Enabled := TRUE;
                    end
                    else begin
                        CBGrupoEspecie.Value := '';
                        CBTipoEspecie.Enabled := FALSE;
                    end;
                end;

                1: //Destino
                begin
                    fDestinos.FiltraPorCodigo (CECodigoDestino.Text);
                    CBTipoDestino.Value := CECodigoDestino.Text;
                    if CBTipoDestino.Text <> ''
                    then begin
                        CBGrupoDestino.Value := fDestinos.ValueByName[CBGrupoDestino.LookupField];
                        CBTipoDestino.Enabled := TRUE;
                    end
                    else begin
                        CBGrupoDestino.Value := '';
                        CBTipoDestino.Enabled := FALSE;
                    end
                end;
            end;

        finally
            CBTipoEspecie.OnChange := a;
            CBGrupoEspecie.OnChange := b;
            CBTipoDestino.OnChange := c;
            CBGrupoDestino.OnChange := d;
        end;


end;

end.


