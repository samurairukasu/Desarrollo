unit USAGCuit;

interface

   type

      TCUIT = class
      private
      public
          //True si el sCadena se corresponde con el formato de CUIT correcto: 99-99999999-9
          class function IsCorrect (const sCadena: string): boolean;
      end;


implementation

uses
   SysUtils;

    //True si el sCadena se corresponde con el formato de CUIT correcto: 99-99999999-9
    class function TCUIT.IsCorrect (const sCadena: string): boolean;
    var
        i: integer;
    begin
        if Length(sCadena) <> 13
        then Result := False
        else begin
            Result := True;
            for i := 1 to 13 do
            begin
                if (i = 3) or (i = 12)
                then Result := Result and (sCadena[i] = '-')
                else Result := Result and (sCadena[i] in ['1','2','3','4','5','6','7','8','9','0']);

                if not Result
                then break
            end
        end
    end;


end.
