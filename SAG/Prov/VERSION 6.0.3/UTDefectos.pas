unit UTDefectos;

    interface

    type

        tValoresDefecto = record
            CodigoCapitulo: integer;
            CodigoApartado: integer;
            CodigoDefecto: integer;
            DefectoActivo: string; { 'N' si el defecto NO est� activo y NULL en caso contrario }
            AbreviaturaDefecto: string;
            LiteralDefecto: string;
       end;

     const

        { Si la tabla TDEFECTOS contiene en el campo ACTIVO una 'N' entonces ese
        defecto estar� inhabilitado }
        DEFECTO_NOACTIVO = 'N'; { Si el campo Activo de TDEFECTOS contiene 'N',
                                 entonces el defecto NO est� activo }

        CAPTION_NUEVO_DEFECTO = 'A�adir nuevo defecto';
        CAPTION_MODIFICAR_DEFECTO = 'Modificar defecto';
        MINIMO_CODIGO_VALIDO = 1;
        MAXIMO_CODIGO_VALIDO = 99;
        RANGO_CODIGOS_VALIDOS = [MINIMO_CODIGO_VALIDO..MAXIMO_CODIGO_VALIDO];


implementation

end.
