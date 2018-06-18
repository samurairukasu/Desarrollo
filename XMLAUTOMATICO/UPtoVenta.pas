unit UPtoVenta;

interface

    uses
        USAGDATA,
        Classes;



    type

        TPtoVenta = class(TSagData)
        private

            function GetPtoVenta: integer;
            procedure SetPtoVenta(PtoVenta: integer);
            function GetVigente: string;
            procedure SetVigente(Vigente: string);
            function GetTipo: string;
            procedure SetTipo(Tipo: string);
            function GetModo: string;
            function GetImpNC: string;
        public

            constructor Create(const aBD : TDataBase);
            function EsCaja(const idcaja : Integer): boolean;
            property PtoVenta: integer read GetPtoVenta;
            property Vigente: string read GetVigente;
            property Tipo: string read GetTipo write SetTipo;
            property Modo: string read GetModo;
             property ImpNC: string read GetImpNC;
        end;

implementation

    uses
        USAGESTACION,
        SysUtils;

    resourcestring

        FILE_NAME = 'UPtoVenta.PAS';


    constructor TPtoVenta.Create(const aBD : TDataBase);
    begin
        inherited CreateFromDataBase(aBD, DATOS_PTOVENTA ,'');
    end;

    function TPtoVenta.GetImpNC: string;
    begin
        if not Active
        then Open;
        result := fptoVenta.ValueByName[FIELD_NC]
    end;

     function TPtoVenta.GetTipo: string;
    begin
        if not Active
        then Open;
        result := fptoVenta.ValueByName[FIELD_TIPO]
    end;


    procedure TPtoVenta.SetTipo(Tipo: string);
    begin
        ValueByName[FIELD_TIPO] := Tipo;
    end;

    function TPtoVenta.GetPtoVenta: integer;
    begin
        if not Active
        then Open;
        result := strtoint(ValueByName[FIELD_PTOVENTA]);
    end;

    procedure TPtoVenta.SetPtoVenta(PtoVenta: integer);
    begin
        ValueByName[FIELD_PTOVENTA] := inttostr(ptoventa);
    end;

    function TPtoVenta.GetVigente : string;
    begin
        if not Active
        then Open;
        result := ValueByName[FIELD_VIGENTE]
    end;

    procedure TPtoVenta.SetVigente(Vigente: string);
    begin
        ValueByName[FIELD_VIGENTE] := Vigente;
    end;

 

    function TPtoVenta.GetModo:string;
    begin

    end;

    function TPtoVenta.EsCaja(const idcaja : Integer): boolean;
    begin

    end;

end.
