unit Uvisorpdf;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, AcroPDFLib_TLB;

type
  Tvisorpdf = class(TForm)
    AcroPDF1: TAcroPDF;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ARCHIVOENVIADO:string;
  end;

var
  visorpdf: Tvisorpdf;

implementation

{$R *.dfm}

procedure Tvisorpdf.FormShow(Sender: TObject);
begin

self.AcroPDF1.LoadFile(trim(ARCHIVOENVIADO));
self.AcroPDF1.setZoom(70);

end;

end.
