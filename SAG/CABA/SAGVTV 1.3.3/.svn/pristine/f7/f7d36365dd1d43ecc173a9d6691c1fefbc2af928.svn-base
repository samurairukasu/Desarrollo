unit Insertar_Localidad_CP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ExtCtrls, dblookup, DBCtrls, SQLExpr, globals,
  FMTBcd, RxLookup, usagclasses;

type
    TUFInserta_Localidad_CP = class(TForm)
    NombreLocalidad: TEdit;
    TLocalidad: TLabel;
    TProvincia: TLabel;
    LocalidadNueva: TLabel;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    Image1: TImage;
    Bevel1: TBevel;
    DBListaDeProvincias: TDBLookupComboBox;
    DSProvincias: TDataSource;
    SQLQuery1: TSQLQuery;
    Label1: TLabel;
    CodPostal: TEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UFInserta_Localidad_CP: TUFInserta_Localidad_CP;

implementation

{$R *.dfm}

procedure TUFInserta_Localidad_CP.btnCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TUFInserta_Localidad_CP.FormShow(Sender: TObject);

var
  aq:TSQLQuery;
  i:longint;
  LProvincias : TProvincias;

begin
  LProvincias := TProvincias.Create(mybd);
  LProvincias.Open;
  DSProvincias.DataSet:=LProvincias.DataSet;
end;

procedure TUFInserta_Localidad_CP.btnAceptarClick(Sender: TObject);

var
  nomloca, codigopostal:string;
  codprovi, idcodposta, idlocalidad:longint;
  aq:TSQLQuery;

begin

if Application.MessageBox( pchar('¿Desea guardar la localidad: '+trim(NombreLocalidad.Text)+'?'), 'Guardando localidad',
  MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
  begin

    if trim(NombreLocalidad.Text) = '' then
      begin
        Application.MessageBox('Debe ingresar la localidad.','Atención', MB_ICONSTOP );
      exit;
    end;

    if trim(CodPostal.Text) = '' then
      begin
        Application.MessageBox('Debe ingresar el codigo postal.','Atención', MB_ICONSTOP );
      exit;
    end;

    if trim(DBListaDeProvincias.KeyField) = '' then
      begin
        Application.MessageBox('Debe seleccionar la provincia.','Atención', MB_ICONSTOP );
      exit;
    end;

    nomloca := trim(NombreLocalidad.Text);
    codprovi := DBListaDeProvincias.KeyValue;
    codigopostal := trim(CodPostal.Text);

   MyBD.StartTransaction(TD);
    TRY

     if codprovi = 2 then
      begin
         //guarda en la tabla caba el codigopostal
          aq:=TSQLQuery.Create(Self);
          aq.Close;
          aq.SQL.Clear;
          aq.SQLConnection:=mybd;
          aq.SQL.Add('select idcodposta from codposta_capital where codposta ='+#39+trim(codigopostal)+#39);
          aq.ExecSQL;
          aq.open;
          if aq.recordcount > 0 then
             idcodposta := aq.fields[0].asinteger
          else
             begin
                  aq.Close;
                  aq.SQL.Clear;
                  aq.SQLConnection:=mybd;
                  aq.SQL.Add('select max(idcodposta) from codposta_capital');
                  aq.ExecSQL;
                  aq.open;
                  idcodposta := aq.fields[0].asinteger + 1;

                  aq.Close;
                  aq.SQL.Clear;
                  aq.SQLConnection:=mybd;
                  aq.SQL.Add('insert into codposta_capital (codposta, fechalta, idcodposta) '+
                                 ' values ('+#39+trim(codigopostal)+#39+',sysdate,'+inttostr(idcodposta)+')');
                  aq.ExecSQL;
             end;
                  //insertar localidad
                  aq.Close;
                  aq.SQL.Clear;
                  aq.SQLConnection:=mybd;
                  aq.SQL.Add('select max(idlocalidad) from localidad_interior');
                  aq.ExecSQL;
                  aq.open;
                  idlocalidad := aq.fields[0].asinteger + 1;

                  aq.Close;
                  aq.SQL.Clear;
                  aq.SQLConnection:=mybd;
                  aq.SQL.Add('insert into localidad_interior (IDCODPOSTA,  '+
                                                              'LOCALIDAD,  '+
                                                              'FECHALTA,   '+
                                                              'CODPROVI,   '+
                                                              'IDLOCALIDAD)'+
                                 ' values ('+inttostr(idcodposta)+
                                           ','+#39+trim(nomloca)+#39+
                                           ',sysdate'+
                                           ','+inttostr(codprovi)+
                                           ','+inttostr(idlocalidad)+')');
                  aq.ExecSQL;

      end
  else
      begin
         //guarda en la tabla provincia el codigopostal
          aq:=TSQLQuery.Create(Self);
          aq.Close;
          aq.SQL.Clear;
          aq.SQLConnection:=mybd;
          aq.SQL.Add('select idcodposta from codposta_interior where codposta = '+#39+trim(codigopostal)+#39);
          aq.ExecSQL;
          aq.open;
          if aq.recordcount > 0 then
             idcodposta := aq.fields[0].asinteger
          else
             begin
                  aq.Close;
                  aq.SQL.Clear;
                  aq.SQLConnection:=mybd;
                  aq.SQL.Add('select max(idcodposta) from codposta_interior');
                  aq.ExecSQL;
                  aq.open;
                  idcodposta := aq.fields[0].asinteger + 1;

                  aq.Close;
                  aq.SQL.Clear;
                  aq.SQLConnection:=mybd;
                  aq.SQL.Add('insert into codposta_interior (idcodposta, codposta, codprovi, fechalta) '+
                                 ' values ('+inttostr(idcodposta)+','+#39+trim(codigopostal)+#39+','+inttostr(codprovi)+',sysdate)');
                  aq.ExecSQL;
             end;
                  //insertar localidad
                  aq.Close;
                  aq.SQL.Clear;
                  aq.SQLConnection:=mybd;
                  aq.SQL.Add('select max(idlocalidad) from localidad_interior');
                  aq.ExecSQL;
                  aq.open;
                  idlocalidad := aq.fields[0].asinteger + 1;

                  aq.Close;
                  aq.SQL.Clear;
                  aq.SQLConnection:=mybd;
                  aq.SQL.Add('insert into localidad_interior (IDCODPOSTA,  '+
                                                              'LOCALIDAD,  '+
                                                              'FECHALTA,   '+
                                                              'CODPROVI,   '+
                                                              'IDLOCALIDAD)'+
                                 ' values  ('+inttostr(idcodposta)+
                                            ','+#39+trim(nomloca)+#39+
                                            ',sysdate'+
                                            ','+inttostr(codprovi)+
                                            ','+inttostr(idlocalidad)+')');
                  aq.ExecSQL;

     end;

    MYBD.Commit(TD);
    Application.MessageBox( 'Se ha procesado correctamente.','Atención',  MB_ICONINFORMATION );

EXCEPT
    MyBD.Rollback(TD);
    Application.MessageBox( 'Se produjo un error la intentar procesar la localidad.','Atención', MB_ICONSTOP );

  END;
  
  end;//pregunta del mensaje

end;

end.
