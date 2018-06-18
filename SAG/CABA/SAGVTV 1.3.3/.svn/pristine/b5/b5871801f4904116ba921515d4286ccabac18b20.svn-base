unit USecuenciadores;
// Contiene propiedades y métodos necesarios para el manejo de secuenciadores

interface

uses
   SQLExpr;

resourcestring
      {$IFNDEF SAT98}
      SECUENCIADOR_FACTA = 'SQ_TFACTURAS_NUMFACTUA';
      {$ELSE}
      SECUENCIADOR_FACTA = 'SQ_TFACTURAS_NUMFACTU';
      {$ENDIF}
      SECUENCIADOR_FACTB = 'SQ_TFACTURAS_NUMFACTUB';
      SECUENCIADOR_INSP  = 'SQ_TINSPECCION_CODINSPE';
      SECUENCIADOR_DEFECTOS = 'SQ_TDEFECTOS_NUMDEFEC';
      SECUENCIADOR_REVISOR = 'SQ_TREVISOR_NUMREVIS';
      SECUENCIADOR_INSP_GNC = 'SQ_INSPGNC_CODINSPGNC';


   type
      TSecuenciadores = class(TObject)
      private
           fSagBD : tSQLConnection;

      protected
          function BorrarSecuenciador (const sNombreSecuenc: string): boolean;
      public
          constructor Create (aBD: TSQLConnection);
          destructor Destroy; override;

          function GetValorSecuenciador (const sNombreSecuenc: string): integer;
          function GetValorSecuenciador_UserSequences (const sNombreSecuenc: string): integer;
          function CrearSecuenciador (const sNombreSecuenc: string; const iInicio: integer): boolean;

          property DataBase : tSQLConnection read fSagBD;
      end;



implementation

    uses
       SysUtils,
       ULOGS,
       UCDIALGS;


    const
        // Máximo valor puede tomar un secuenciador para las facturas de tipos A y B
        {
         26/12/2000 Modificacion SLS/VAZ para aumentar de 6 a 8 dígitos (como corresponde por base de datos)
        el tamaño del secuenciador utilizado para el número de facturas A y B
        También se modificó el Formulario UFVariableDataSecuenciadores.dfm los campos
        Edit edtFacturasB y edtFacturasA de long. 6 pasaron a long. 8
        }
        MAX_VALUE_FACTURAS = 99999999;
        // Máximo valor que puede tomar un secuenciador para los códigos de inspección
        MAX_VALUE_CODINSPE = 99999999;


    resourcestring
       FILE_NAME = 'USecuenciadores';



    constructor TSecuenciadores.Create (aBD: TSQLConnection);
    begin
        inherited Create;

        fSagBD := aBD;
    end;


    destructor TSecuenciadores.Destroy;
    begin
        inherited Destroy;
    end;


    function TSecuenciadores.GetValorSecuenciador (const sNombreSecuenc: string): integer;
    var
      aQuery: TSQLQuery;

    begin
        Result := 0;
        aQuery := TSQLQuery.Create (nil);
        try
           try
              with aQuery do
              begin
                  SQLConnection := fSagBD;
                  SQL.Add(Format('SELECT %s.NEXTVAL FROM DUAL',[sNombreSecuenc]));
                  Open;
                  Result := Fields[0].AsInteger;
              end;
           except
               on E: Exception do
               begin
                   fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo un valor de un secuenciador por: %s',[E.message]);
                   raise Exception.Create('An error occur when gettin an sequence value');
               end
           end
        finally
             aQuery.Close;
             aQuery.Free;
        end;
    end;


    function TSecuenciadores.GetValorSecuenciador_UserSequences (const sNombreSecuenc: string): integer;
    var
      aQuery: TSQLQuery;

    begin
        Result := 0;
        aQuery := TSQLQuery.Create (nil);
        try
           try
              with aQuery do
              begin
                  SQLConnection := fSagBD;
                  SQL.Add(Format('select last_number from user_sequences where sequence_name=''%s''',[sNombreSecuenc]));
                  Open;
                  Result := Fields[0].AsInteger;
              end;
           except
               on E: Exception do
               begin
                   fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo un valor de un secuenciador (2) por: %s',[E.message]);
                   raise Exception.Create('An error occur when gettin an sequence value (2)');
               end
           end
        finally
             aQuery.Close;
             aQuery.Free;
        end;
    end;


    function TSecuenciadores.BorrarSecuenciador (const sNombreSecuenc: string): boolean;
    var
      aQuery: TSQLQuery;

    begin
        //Result := False;
        Result := True;
        aQuery := TSQLQuery.Create (nil);
        try
           try
              with aQuery do
              begin
                  SQLConnection := fSagBD;
                  SQL.Add(Format('drop sequence %s',[sNombreSecuenc]));
                  ExecSQL;
              end;
              //Result := True;
           except
               on E: Exception do
               begin
                   fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo un valor de un secuenciador (2) por: %s',[E.message]);
                   //raise Exception.Create('An error occur when gettin an sequence value (2)');
               end
           end
        finally
             aQuery.Close;
             aQuery.Free;
        end;
    end;


    function TSecuenciadores.CrearSecuenciador (const sNombreSecuenc: string; const iInicio: integer): boolean;
    var
      iMaximo: longint; { máximo valor que tomará el secuenciador }
      aQuery: TSQLQuery;

    begin
        Result := False;
        iMaximo := 1;
        if BorrarSecuenciador (sNombreSecuenc) then
        begin
            if ((sNombreSecuenc = SECUENCIADOR_FACTA) or (sNombreSecuenc = SECUENCIADOR_FACTB) or (sNombreSecuenc = SECUENCIADOR_INSP_GNC)) then
               iMaximo := MAX_VALUE_FACTURAS
            else if (sNombreSecuenc = SECUENCIADOR_INSP) then
               iMaximo := MAX_VALUE_CODINSPE;

            aQuery := TSQLQuery.Create (nil);
            try
               try
                  with aQuery do
                  begin
                      SQLConnection := fSagBD;
                      SQL.Add(Format('create sequence %s START WITH %d INCREMENT BY 1 MAXVALUE %d NOCYCLE NOCACHE ORDER',[sNombreSecuenc, iInicio, iMaximo]));
                      ExecSQL;
                  end;
                  Result := True;
               except
                   on E: Exception do
                   begin
                       fAnomalias.PonAnotacionFmt(TRAZA_SIEMPRE,0,FILE_NAME,'Error obteniendo un valor de un secuenciador (2) por: %s',[E.message]);
                       raise Exception.Create('An error occur when gettin an sequence value (2)');
                   end
               end
            finally
                 aQuery.Close;
                 aQuery.Free;
            end;
        end
        else
        begin
           fAnomalias.PonAnotacion (TRAZA_SIEMPRE,0,FILE_NAME,'No se ha podido borrar un secuenciador');
           raise Exception.Create('A sequence couldn''t be deleted');
        end;
    end;


end.



