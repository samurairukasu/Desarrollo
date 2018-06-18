unit UFRMSCANEOCERTIFICADO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,GLOBALS,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB,sqlExpr, RxMemDS,
  Menus, sHintManager;

type
  TFRMSCANEOCERTIFICADO = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1hoja: TIntegerField;
    RxMemoryData1certificado: TStringField;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn2: TBitBtn;
    MainMenu1: TMainMenu;
    continuar1: TMenuItem;
    Label2: TLabel;
    sHintManager1: TsHintManager;
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure continuar1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sale,anular_certificado:boolean;
    cantidadhojas:longint;
    cantscaneeo:longint;
    FUNCTION VERIFICA_QUE_NO_ESTE_USADO_EL_CERTIFICADO(NROCERTIFI:STRING):BOOLEAN;
  end;

var
  FRMSCANEOCERTIFICADO: TFRMSCANEOCERTIFICADO;

implementation

{$R *.dfm}

procedure TFRMSCANEOCERTIFICADO.BitBtn1Click(Sender: TObject);
begin
self.RxMemoryData1.Open;
if self.RxMemoryData1.RecordCount = 0 then
begin
 Application.MessageBox( 'No hay certificados scaneados',
  'Atención', MB_ICONSTOP );
  exit;
end;
 {
  if cantidadhojas = cantscaneeo then
  begin
     if Application.MessageBox( '¿Desea continuar con la finalización de la inspección?', 'Finalizando Inspección',
         MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
          begin
            sale:=false;
            close;
           end else begin
              edit1.Clear;
               edit1.SetFocus

             end;


  end else begin
     cantscaneeo:=cantscaneeo + 1;
     edit1.Clear;
     edit1.SetFocus;
     label2.Caption:='CANTIDAD: '+inttostr(cantscaneeo)+' de '+inttostr(cantidadhojas);
     APPLICATION.ProcessMessages;
  end;


 }
if Application.MessageBox( '¿Desea continuar con la finalización de la inspección?', 'Finalizando Inspección',
  MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
  begin
     sale:=false;
      close;
  end else begin
     edit1.Clear;
     edit1.SetFocus

  end;







end;

procedure TFRMSCANEOCERTIFICADO.Edit1KeyPress(Sender: TObject;
  var Key: Char);
begin
IF TRIM(EDIT1.Text)='' THEN
EXIT;


if key=#13 then
 begin



       With TSQLQuery.Create(nil) do
                try
                    Close;
                    SQL.Clear;
                    SQLConnection:=mybd;
                    SQL.Add ('SELECT count(*) FROM tcertificados  WHERE estado=''S'' and numcertif=:NROCERTI');
                    ParamByName('NROCERTI').Value:=TRIM(edit1.Text);

                    OPEN;
                    IF fields[0].asinteger = 0 THEN
                    begin
                         showmessage('EL CERTIFICADO SCANEADO NO SE ENCUENTRA EN STOCK.');
                         edit1.Clear;
                         edit1.SetFocus;
                         exit;
                      end;
                      finally
                        Close;
                        Free;
                     end;




    self.RxMemoryData1.First;
    while not self.RxMemoryData1.Eof do
    begin
           if trim(self.RxMemoryData1certificado.Value)=trim(edit1.Text) then
            begin
               showmessage('EL NRO DE CERTIFICADO SCANEADO YA ESTÁ INGRESADO.');
               exit;
                EDIT1.Clear;
                EDIT1.SetFocus;

            end;


        self.RxMemoryData1.Next;
    end;

     IF VERIFICA_QUE_NO_ESTE_USADO_EL_CERTIFICADO(TRIM(EDIT1.Text))=TRUE THEN
      BEGIN
        showmessage('EL NRO DE CERTIFICADO YA EXISTE EN OTRA INSPECCION.');
        exit;
        EDIT1.Clear;
        EDIT1.SetFocus;

      END;


       self.RxMemoryData1.Append;
       self.RxMemoryData1hoja.Value:=self.RxMemoryData1.RecordCount + 1 ;
       self.RxMemoryData1certificado.Value:=trim(edit1.Text);
       self.RxMemoryData1.Post;
       self.DataSource1.DataSet.Refresh;
       edit1.Clear;
       edit1.SetFocus;
      // BitBtn1Click(Sender);


 end;


end;

FUNCTION TFRMSCANEOCERTIFICADO.VERIFICA_QUE_NO_ESTE_USADO_EL_CERTIFICADO(NROCERTIFI:STRING):BOOLEAN ;
BEGIN

       With TSQLQuery.Create(nil) do
                try
                    Close;
                    SQL.Clear;
                    SQLConnection:=mybd;
                    SQL.Add ('SELECT COUNT(*) FROM certificadoinspeccion  WHERE NROCERTIFICADO=:NROCERTI');
                    ParamByName('NROCERTI').Value:=TRIM(NROCERTIFI);

                    OPEN;
                    IF FIELDS[0].ASINTEGER > 0 THEN
                        VERIFICA_QUE_NO_ESTE_USADO_EL_CERTIFICADO:=TRUE
                        ELSE
                        VERIFICA_QUE_NO_ESTE_USADO_EL_CERTIFICADO:=FALSE;

                      finally
                        Close;
                        Free;
                     end;
END;


procedure TFRMSCANEOCERTIFICADO.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin

canclose:=true;


end;

procedure TFRMSCANEOCERTIFICADO.DBGrid1DblClick(Sender: TObject);
begin
if Application.MessageBox(pchar('¿Desea eliminar el certidicado: '+trim(self.RxMemoryData1certificado.Value)+' ?'), 'Guardando factura',
  MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
  BEGIN

     self.RxMemoryData1.Delete;
  

     Application.MessageBox( pchar('Se ha borrado el certidicado scaneado '+trim(self.RxMemoryData1certificado.Value)), 'Atención',
  MB_ICONINFORMATION );

  END;

end;

procedure TFRMSCANEOCERTIFICADO.BitBtn2Click(Sender: TObject);
begin
anular_certificado:=false;
if Application.MessageBox( '¿Desea anular el formulario ?', 'Cancelar',
               MB_ICONQUESTION OR MB_YESNO ) = ID_YES then
               BEGIN
                   self.RxMemoryData1.Open;
                      if self.RxMemoryData1.RecordCount = 0 then
                       begin
                        Application.MessageBox( 'No hay certificados scaneados.Por favor scanee el certificado a anular.',
                      'Atención', MB_ICONSTOP );
                      edit1.SetFocus;
                       exit;
                      end;

                 anular_certificado:=true;
               end;

sale:=true;
close;
end;

procedure TFRMSCANEOCERTIFICADO.continuar1Click(Sender: TObject);
begin
BitBtn1Click(Sender);
end;

end.
