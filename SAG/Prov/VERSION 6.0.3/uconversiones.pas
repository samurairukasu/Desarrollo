unit uconversiones;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls;

type
                                                       
Tconversion = (mtok);


    function hexadeci(stat: string):integer;
    function decibina(stat: integer):string;
    function hexabina(stat: string):string;
    function letrnume(letra: char):integer;



var
  conversion: Tconversion;

implementation

function hexadeci(stat: string):integer;
var c1,c2,c3,c4:char;
begin
  c1:=stat[1];
  c2:=stat[2];
  c3:=stat[3];
  c4:=stat[4];
  result:=(letrnume(c1)*4096+letrnume(c2)*256+letrnume(c3)*16+letrnume(c4));
end;

function decibina(stat: integer):string;
var resto,numrea:real;
    auxi:string;
begin
  numrea:=stat;
  resto:=numrea;
  while (resto >= 1) or (length(auxi) < 16) do
  begin
    numrea:=resto/2;
    numrea:=((numrea-int(numrea))*2);
    auxi:=auxi+floattostr(numrea);
    resto:=int(resto/2);
    numrea:=int(resto);
    resto:=int(numrea);
  end;
    result:=auxi;
end;

function hexabina(stat: string):string;
var auxdec:integer;
    auxbin:string;
begin
  auxdec:=hexadeci(stat);
  auxbin:=decibina(auxdec);
  result:=auxbin;
end;

function letrnume(letra: char):integer;
begin
  try
    result:=strtoint(letra);
  except
    case letra of
      'a','A':begin
        result:=10;
      end;
      'b','B':begin
        result:=11;
      end;
      'c','C':begin
        result:=12;
      end;
      'd','D':begin
        result:=13;
      end;
      'e','E':begin
        result:=14;
      end;
      'g','G':begin
        result:=15;
      end;
      else begin
      end;
    end;
  end;
end;

end.
