unit UfDatosInspeccion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db,SqlExpr, Buttons, globals, usagClasses, ucdialgs, ExtCtrls,
  uSagEstacion;

type
  TfmDatosInsp = class(TForm)
    Label1: TLabel;
    ednromatricula: TEdit;
    ednroinspe: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edano: TEdit;
    btnAceptar: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    procedure btnAceptarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    aQu:TSQLQuery;
    FDatInspecc : TDatinspecc; //
    procedure poisk(codinsp,anio:integer; var nnov,nst:string);
    Procedure DoImprimeMedAuto;   //
    function ValidateCompleto:boolean;
  public
    { Public declarations }
  end;
  Procedure doMedicionesInspeccion;



var
  fmDatosInsp: TfmDatosInsp;

implementation

uses ufMedAuto,
     uftmp;

{$R *.DFM}

procedure doMedicionesInspeccion;
begin
   with TfmDatosInsp.Create(Application) do
      try
         ShowModal;
      finally
         Free;
      end;
end;

procedure TfmDatosInsp.poisk(codinsp,anio:integer; var nnov,nst:string);
begin
   nnov:='';
   nst:='';
   aQu.Close;
   aQu.SQL.Clear;
   aQu.SQL.Add('SELECT V.PATENTEN,V.PATENTEA FROM TINSPECCION I,TVEHICULOS V ');
   aQu.SQL.Add(' WHERE I.CODVEHIC=V.CODVEHIC AND I.EJERCICI=:ANIO AND I.CODINSPE=:INSP');
   aQu.ParamByName('INSP').AsInteger:=codinsp;
   aQu.ParamByName('ANIO').AsInteger:=anio;
   aQu.Open;
   if not aQu.IsEmpty then begin
      nnov:=aQu.Fields[0].AsString;
      nst:=aQu.Fields[1].Asstring;
   end;
end;

Procedure TfmDatosInsp.DoImprimeMedAuto;   //
begin
  FTmp.Temporizar(True,True,'Impresi�n de Informes','Preparando el Informe Mediciones Autom�ticas');
  try
    fDatInspecc := nil;
    try
      fDatInspecc := tdatinspecc.CreateByEjerCodinspe(mybd,edano.Text,ednroinspe.text);
      fDatInspecc.open;
      if fDatInspecc.RecordCount > 0 then
        with tfrmMedAuto.Create(application) do
         try
           repmedauto.DataSet:=fdatinspecc.DataSet;
           QRLVehiculo.caption:= fdatinspecc.GetDominio;
           qrlInforme.caption:=fDatInspecc.GetNroInforme;
           with TInspeccion.CreateFromDataBase(mybd,DATOS_INSPECCIONES,format('WHERE EJERCICI = %S AND CODINSPE = %S',[edano.Text,ednroinspe.text])) do
           try
              open;
              qrlFechalta.Caption := copy(ValueByName[FIELD_FECHALTA],1,10);
           finally
              free;
           end;
           repmedauto.preview;
         finally
           free;
         end
      else
        messagedlg(caption,'El Nro de Inspecci�n no es correcto',mtError,[mbOK],mbOK,0);
    finally
      fdatinspecc.close;
      fdatinspecc.free;
    end;
  finally
      FTmp.Temporizar(False,True,'','');
  end;
end;


procedure TfmDatosInsp.btnAceptarClick(Sender: TObject);
var
    codinsp,anio:integer;
    nnov,nst,matric:string;
begin
   if ValidateCompleto then
   begin
     matric:=ednromatricula.Text;
     codinsp:=sTRtOiNT(ednroinspe.Text);
     anio:=StrToInt(edano.Text);
     poisk(codinsp,anio,nnov,nst);
     if (nnov=matric) or (nst=matric) then
     begin
       doImprimeMedAuto
     end
     else
     begin
       messagedlg(caption,'La patente ingresada no corresponde a esta Inspecci�n',mtError,[mbOK],mbOK,0);
     end;
   end;
end;

procedure TfmDatosInsp.FormCreate(Sender: TObject);
begin
   aQu:=TSQLQuery.Create(self);
   aQu.SQLConnection:=mybd;
end;

procedure TfmDatosInsp.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key=#13 then begin
      Perform(WM_NEXTDLGCTL,0,0);
      Key:=#0;
   end;
end;

procedure TfmDatosInsp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  aQu.close;
  aQu.free;
end;

function TfmDatosInsp.ValidateCompleto:boolean;
begin
  result:=false;
  if ednromatricula.text = '' then
  begin
       messagedlg(caption,'Se debe ingresar un n�mero de matr�cula',mtError,[mbOK],mbOK,0);
       ednromatricula.setfocus;
       exit;
  end;
    if ednroinspe.text = '' then
  begin
       messagedlg(caption,'Se debe ingresar un n�mero de inspecci�n',mtError,[mbOK],mbOK,0);
       ednroinspe.setfocus;
       exit;
  end;
  if edano.text = '' then
  begin
       messagedlg(caption,'Se debe ingresar el a�o de la inspecci�n',mtError,[mbOK],mbOK,0);
       edano.setfocus;
       exit;
  end;
  result:=true;
end;
end.
