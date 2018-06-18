unit ucontstatus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  UCONST, ucdialgs, uconversiones;

type

    Testfiscal = (PrinterFiscalStatus);

    function estadoprinter(stat: string):string;
    function estadofiscal(stat: string):string;
    function statusok(status: string;tipo: char;imprimir:boolean):boolean;

implementation

function estadoprinter(stat: string):string;
var estado:string;
    i:integer;
    hayerror:boolean;
begin
  hayerror:=false;
  estado:='';
  for i:=1 to 16 do
  begin
    if (stat[i] = '1') and (i <> 8) then
    begin
      estado:=estado+TMENS_STATUS_IMPRE[i-1]+#13;
      hayerror:=true;
    end;
  end;
  if hayerror then result:=estado
  else result:='OK';
end;

function estadofiscal(stat: string):string;
var estado:string;
    i:integer;
    hayerror:boolean;
begin
  hayerror:=false;
  estado:='';
  for i:=1 to 16 do
  begin
    if (stat[i] = '1') and (i<>10) and (i<>11) then
    begin
      estado:=estado+TMENS_STATUS_FISCAL[i-1]+#13;
      hayerror:=true;
    end;
  end;
  if hayerror then result:=estado
  else result:='OK';

end;

function statusok(status: string;tipo: char;imprimir:boolean):boolean;
begin
  case tipo of
    'f','F': begin
      if estadofiscal(status) = 'OK' then
      begin
        result:=true;
      end
      else
      begin
        if not imprimir then ShowMessage('Estado Fiscal',estadofiscal(status));
        result:=false;
      end;
    end;
    'i','I': begin
      if estadoprinter(status) = 'OK' then
      begin
        result:=true;
      end
      else
      begin
        if not imprimir then ShowMessage('Estado Impresora',estadoprinter(status));
        result:=false;
      end;
    end;
    else begin
        result:=false;
    end;
  end;
end;

end.
