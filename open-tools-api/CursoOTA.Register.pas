unit CursoOTA.Register;

// Para debugar o projeto direto no Delphi, primeiro fazer a instalação dele depois acessar
// Run -> Parameters
// Depois em Host Application informar o caminho "C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\bds.exe"

interface

uses
  ToolsAPI, CursoOTA.HelloWorld.Wizard, CursoOTA.MainMenu.Wizard;

procedure Register;

implementation

procedure Register;
begin
  RegisterPackageWizard(TCursoOTAHelloWorldWizard.Create);
  RegisterPackageWizard(TCursoOTAMainMenuWizard.Create);
end;

end.
