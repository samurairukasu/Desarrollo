program Sag98;

uses
  Forms,
  Acceso1 in 'Acceso1.pas',
  Acceso in 'ACCESO.pas',
  UFRecepcion in 'UFRECEPCION.pas' {FRecepcion},
  UFinVeri in 'UFinVeri.pas' {FrmFinal},
  UProtect in 'UPROTECT.pas',
  UFHistoricoInspecciones in 'UFHISTORICOINSPECCIONES.pas' {FHistoricoInspecciones},
  UVERSION_old in 'UVERSION_old.pas',
  UFMainSag98 in 'UFMainSag98.pas' {FMainSag98},
  UFDominios in 'UFDOMINIOS.pas' {FDominios},
  Ulistadocierrez in 'Ulistadocierrez.pas' {listadocierrez},
  UfimprimeinformeZ in 'UfimprimeinformeZ.pas' {UimprimeinformeZ},
  Ubuscar_inspeccion_por_patente in 'Ubuscar_inspeccion_por_patente.pas' {buscar_inspeccion_por_patente};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Sag. X3 (Estaciones) Ver 5.3.3';
  Application.CreateForm(TFMainSag98, FMainSag98);
  Application.CreateForm(TFDominios, FDominios);
  Application.CreateForm(Tbuscar_inspeccion_por_patente, buscar_inspeccion_por_patente);
  Application.Run;
end.
