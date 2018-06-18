unit UCtHistorialVehiculo;

interface

const
    FECHA_COMPLETA = 'DD/MM/YYYY';
    SIN_FECHA = '01/01/1500';
    NUM_DIAS_MES = 30; { Suponemos que un mes tiene 30 d�as para calcular antiguedad }
    DIAS_X_MES = 31;   { Suponenemos que un mes tiene 31 d�as para calcular la fecha de vencimeinto }
    INTERVALO_DIAS_PERIODO = 60; { Si el resultado de una inspecci�n NO es APTO,
       es el n� de d�as m�ximos que deben transcurrir para volver a pasar la
       pr�xima verificaci�n del veh�culo }

    INTERVALO_DIEZ_DIAS_PERIODO = 10; { Si el resultado de una inspecci�n NO es APTO,
       es el n� de d�as m�ximos que deben transcurrir para volver a pasar la
       pr�xima verificaci�n del veh�culo, en Transporte Publico > 10 a�os }


    { Indica que no se conoce el n�mero y/o nombre de un inspector }
    INSP_DESCONOCIDO = 'Desconocido:';

    { Posibles calificaciones que puede tomar un defecto }
    CALIFICACION_OK = 'Ok';
    CALIFICACION_OBSERVACION = 'Observaci�n';
    CALIFICACION_DLEVE = 'D. Leve';
    CALIFICACION_DGRAVE = 'D. Grave';

    { RESULTADO DE LA INSPECCION }
    rOK = 0;
    rOBS = 1;
    rDL = 2;
    rDG = 3;
    rIMP = 4;
    rEXT = 5;

    INSPECCION_OBLIGATORIA    = 'I. Obligatoria';

    CADENA_APTA = 'Apto';
    CADENA_CONDICIONAL = 'Condicional';
    CADENA_RECHAZADO = 'Rechazado';
    CADENA_BAJA = 'Baja';

implementation



end.
