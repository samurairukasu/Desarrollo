unit UFDefectosInspGNC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, sqlexpr, Provider, DBClient, Buttons, globals, usagClasses, ucdialgs, ExtCtrls,
  Grids, DBGrids, uSagEstacion;

type
  TfmDefectosInspGNC = class(TForm)
    btnAceptar: TBitBtn;
    btnsalir: TBitBtn;
    Bevel1: TBevel;
    edMatricula: TEdit;
    Label1: TLabel;
    btnBuscar: TBitBtn;
    grInspecciones: TDBGrid;
    dsInspeccion: TDataSource;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBuscarClick(Sender: TObject);
    procedure edMatriculaChange(Sender: TObject);
    procedure grInspeccionesDblClick(Sender: TObject);
  private
    { Private declarations }
    fDefectos, aQu, fInspecciones: TClientDataSet;
    sdsfDefectos, sdsaQu, sdsfInspecciones : TSQLDataSet;
    dspfDefectos, dspaQu, dspfInspecciones : TDataSetProvider;
    FDatInspecc : TInspGNC_Defectos; //
    function ExisteInspeccion(codinsp,anio:integer) : boolean;
    Procedure DoImprimeMedAuto;   //
    function ValidateCompleto:boolean;
  public
    { Public declarations }
  end;
  Procedure doDefectosInspeccion;



var
  fmDefectosInspGNC: TfmDefectosInspGNC;

implementation

uses ufDefectosInspGNCToPrint,
     uftmp;

{$R *.DFM}

procedure doDefectosInspeccion;
begin
   with TfmDefectosInspGNC.Create(Application) do
      try
         ShowModal;
      finally
         Free;
      end;
end;

function TfmDefectosInspGNC.ExisteInspeccion(codinsp,anio:integer):boolean;
begin
   result := false;
   aQu.Close;
   aQu.CommandText := format('SELECT CODINSPGNC FROM INSPGNC WHERE EJERCICI = %S AND CODINSPGNC = %S',[inttostr(anio),inttostr(codinsp)]);
   aQu.SetProvider(dspaQu);
   aQu.Open;
   if not aQu.IsEmpty then begin
      result := true;
   end;
end;

Procedure TfmDefectosInspGNC.DoImprimeMedAuto;   //
begin
  FTmp.Temporizar(True,True,'Impresión de Informes','Preparando el Informe Defectos de Inspección GNC');
  try
    fDatInspecc := nil;
    try
      fDatInspecc := TInspGNC_Defectos.CreateFromInspeccion(mybd,fInspecciones.fieldbyName(FIELD_EJERCICI).asstring,fInspecciones.fieldbyName(FIELD_CODINSPGNC).asstring);
      fDatInspecc.open;
      if fDatInspecc.RecordCount > 0 then
      begin


         sdsfDefectos := TSQLDataSet.Create(self);
         sdsfDefectos.SQLConnection := MyBD;
         sdsfDefectos.CommandType := ctQuery;
         sdsfDefectos.GetMetadata := false;
         sdsfDefectos.NoMetadata := true;
         sdsfDefectos.ParamCheck := false;

         dspfDefectos := TDataSetProvider.Create(self);
         dspfDefectos.DataSet := sdsfDefectos;
         dspfDefectos.Options := [poIncFieldProps,poAllowCommandText];
         fDefectos := TClientDataSet.Create(self);
         with fDefectos do
         begin
              SETProvider(dspfDefectos);
              CommandText := Format(' SELECT  DESCRIPCION, I.FECHALTA ' +
                       ' FROM                                         ' +
                       '   INSPGNC_DEFECTOS D, DEFECTOSGNC  T, INSPGNC I ' +
                       ' WHERE                                           ' +
                       '   D.CODDEFEC = T.CODDEFEC   AND                 ' +
                       '   D.EJERCICI = %S AND                           ' +
                       '   D.CODINSPGNC = %S     AND I.CODINSPGNC = D.CODINSPGNC ',
                       [fDatInspecc.ValueByName[FIELD_EJERCICI],fDatInspecc.ValuebyName[FIELD_CODINSPGNC]]);
              open;
         end;
         with tfrmDefectosInspGNCToPrint.Create(application) do
           try
             repDefInspGNC.DataSet:=fDefectos;
             QRLVehiculo.caption:= fdatinspecc.GetDominio;
             qrlInforme.caption:=fDatInspecc.GetNroInforme;
             QRLFecha.caption := copy(fDefectos.fieldByName(FIELD_FECHALTA).asstring,1,10);
             repDefInspGNC.preview;
           finally
             free;
           end
      end
      else
        messagedlg(caption,'No se encontraron defectos para este nro de inspección',mtError,[mbOK],mbOK,0);
    finally
      fdatinspecc.close;
      fdatinspecc.free;
    end;
  finally
      FTmp.Temporizar(False,True,'','');
  end;
end;


procedure TfmDefectosInspGNC.btnAceptarClick(Sender: TObject);
var
    codinsp,anio:integer;
begin
   if ValidateCompleto then
   begin
     anio :=sTRtOiNT(fInspecciones.fieldbyName(FIELD_EJERCICI).asstring);
     codinsp :=StrToInt(fInspecciones.fieldbyName(FIELD_CODINSPGNC).asstring);
     if existeInspeccion(codinsp, anio) then
     begin
       doImprimeMedAuto
     end
     else
     begin
       messagedlg(caption,'El Nro de Inspección GNC no se ha encontrado',mtError,[mbOK],mbOK,0);
     end;
   end;
end;

procedure TfmDefectosInspGNC.FormCreate(Sender: TObject);
begin
    sdsaqu := TSQLDataSet.Create(self);
    sdsaqu.SQLConnection := MyBD;
    sdsaqu.CommandType := ctQuery;
    sdsaqu.GetMetadata := false;
    sdsaqu.NoMetadata := true;
    sdsaqu.ParamCheck := false;

    dspaqu := TDataSetProvider.Create(self);
    dspaqu.DataSet := sdsaqu;
    dspaqu.Options := [poIncFieldProps,poAllowCommandText];
    aqu := TClientDataSet.Create(self);

    sdsfInspecciones := TSQLDataSet.Create(self);
    sdsfInspecciones.SQLConnection := MyBD;
    sdsfInspecciones.CommandType := ctQuery;
    sdsfInspecciones.GetMetadata := false;
    sdsfInspecciones.NoMetadata := true;
    sdsfInspecciones.ParamCheck := false;


    dspfInspecciones := TDataSetProvider.Create(self);
    dspfInspecciones.DataSet := sdsfInspecciones;
    dspfInspecciones.Options := [poIncFieldProps,poAllowCommandText];
    fInspecciones := TClientDataSet.Create(self);
end;

procedure TfmDefectosInspGNC.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key=#13 then begin
      Perform(WM_NEXTDLGCTL,0,0);
      Key:=#0;
   end;
end;

procedure TfmDefectosInspGNC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  aQu.close;
  aQu.free;
  fDefectos.free;
  if assigned (fInspecciones) then fInspecciones.free;
end;

function TfmDefectosInspGNC.ValidateCompleto:boolean;
begin
  result:=false;
  if edMatricula.text = '' then
  begin
       messagedlg(caption,'Se debe ingresar un nro de matrícula',mtError,[mbOK],mbOK,0);
       edMatricula.setfocus;
       exit;
  end;
  result:=true;
end;

procedure TfmDefectosInspGNC.btnBuscarClick(Sender: TObject);
var
  fSQL : TStringList;
begin
  fSQL := TStringList.Create;
  with fInspecciones do
  begin
    close;
    SetProvider(dspfInspecciones);
    fsql.Clear;
    fsql.add('SELECT EJERCICI, CODINSPGNC, SUBSTR(TO_CHAR(I.FECHALTA,''DD/MM/YYYY''),1,10) FECHALTA, TO_CHAR(I.FECHALTA,''YYYY/MM/DD'') FO, ');
    fsql.add('SUBSTR(LTRIM(TO_CHAR(MOD(I.EJERCICI,100),''00'')) || '' '' || LTRIM(TO_CHAR(A.ZONA,''0000'')) || LTRIM(TO_CHAR(A.ESTACION,''0000'')) || LTRIM(TO_CHAR(I.CODINSPGNC,''000000'')),1,17) INFORME ');
    fsql.add('FROM INSPGNC I, TVARIOS A, TVEHICULOS V ');
    fsql.add(format('WHERE V.CODVEHIC = I.CODVEHIC AND (PATENTEN = ''%s'' OR PATENTEA = ''%s'') ',[edMatricula.text,edMatricula.text]));
    fsql.Add('AND INSPFINA = ''S'' AND RESULTADO = ''R'' ');
    fsql.add('ORDER BY FO DESC');
    CommandText := fSQL.Text;
    open;
    if recordcount > 0 then
    begin
         btnAceptar.Enabled := true;
         dsInspeccion.DataSet := fInspecciones;
    end
    else
    begin
        btnAceptar.Enabled := false;
        messagedlg(caption,'No se encontraron inspecciones rechazadas para esta matrícula',mtError,[mbOK],mbOK,0);
        edmatricula.SetFocus;  
    end;
  end;
end;

procedure TfmDefectosInspGNC.edMatriculaChange(Sender: TObject);
begin
  if assigned (fInspecciones) then fInspecciones.close;
end;

procedure TfmDefectosInspGNC.grInspeccionesDblClick(Sender: TObject);
begin
  if btnAceptar.Enabled then
    btnAceptarClick(btnaceptar);
end;

end.
