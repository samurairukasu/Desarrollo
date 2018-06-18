program tareas;

{%ToDo 'tareas.todo'}

uses
  Forms,
  UFPrincipal in 'ufprincipal.pas' {frmprincipal},
  UsagClasses in 'usagclasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfrmprincipal, frmprincipal);
  Application.Run;
end.
