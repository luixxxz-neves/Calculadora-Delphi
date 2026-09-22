program ProjCalculadora;

uses
  Forms,
  FormCalculadora in 'FormCalculadora.pas' {Calculadora};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCalculadora, Calculadora);
  Application.Run;
end.
