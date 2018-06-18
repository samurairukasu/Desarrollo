unit UCtDefectos;

interface

const
   DEFECTO_NOACTIVO = 'N'; { Si el campo Activo de TDEFECTOS contiene 'N',
                             entonces el defecto NO está activo }
   CAPTION_NUEVO_DEFECTO = 'Añadir nuevo defecto';
   CAPTION_MODIFICAR_DEFECTO = 'Modificar defecto';


type
   tValoresDefecto = record
       CodigoCapitulo: integer;
       CodigoApartado: integer;
       CodigoDefecto: integer;
       DefectoActivo: string; { 'N' si el defecto NO está activo y NULL en caso contrario }
       AbreviaturaDefecto: string;
       LiteralDefecto: string;
   end;



implementation

end.
