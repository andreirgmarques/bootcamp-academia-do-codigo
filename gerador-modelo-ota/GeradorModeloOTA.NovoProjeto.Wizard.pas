unit GeradorModeloOTA.NovoProjeto.Wizard;

interface

uses
  System.SysUtils, System.Classes, Vcl.Dialogs, ToolsAPI, DCCStrs, Winapi.Windows, Vcl.Controls,
  GeradorModeloOTA.NovoProjeto.Form, GeradorModeloOTA.NovoProjeto.Creator, GeradorModeloOTA.NovoProjeto.Model,
  GeradorModeloOTA.NovoProjeto.Files;

type
  TGeradorModeloOTANovoProjetoWizard = class(TNotifierObject, IOTAWizard, IOTARepositoryWizard, IOTAProjectWizard)
  private
    procedure CriarProjeto(ADadosProjeto: TGeradorModeloOTANovoProjetoModel);
  protected
    // IOTAWizard
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;

    // IOTARepositoryWizard e IOTAProjectWizard
    function GetAuthor: string;
    function GetComment: string;
    function GetPage: string;

    // Handle to an Icon
    function GetGlyph: Cardinal;

    // Launch the AddIn
    procedure Execute;
  public

  end;


implementation

{ TGeradorModeloOTANovoProjetoWizard }

procedure TGeradorModeloOTANovoProjetoWizard.CriarProjeto(ADadosProjeto: TGeradorModeloOTANovoProjetoModel);
var
  LProjeto: IOTAProjectCreator;
  LModule: IOTAModuleServices;
  LConfig: IOTAProjectOptionsConfigurations;
  LBuild: IOTABuildConfiguration;
  LSearchPath: TStrings;
begin
  LProjeto := TGeradorModeloOTANovoProjetoCreator.New(ADadosProjeto);

  LModule  := (BorlandIDEServices as IOTAModuleServices);
  LModule.CreateModule(LProjeto);

  LConfig  := (GetActiveProject.ProjectOptions as IOTAProjectOptionsConfigurations);
  LBuild   := LConfig.BaseConfiguration;

  LSearchPath := TStringList.Create;
  try
    LSearchPath.Add('D:\GitHub\bootcamp-academia-do-codigo\gerador-modelo-ota\Libs\DataSetConverter4Delphi\src');
    LSearchPath.Add('D:\GitHub\bootcamp-academia-do-codigo\gerador-modelo-ota\Libs\horse\src');
    LSearchPath.Add('D:\GitHub\bootcamp-academia-do-codigo\gerador-modelo-ota\Libs\horse-cors\src');
    LSearchPath.Add('D:\GitHub\bootcamp-academia-do-codigo\gerador-modelo-ota\Libs\jhonson\src');
    LSearchPath.Add('D:\GitHub\bootcamp-academia-do-codigo\gerador-modelo-ota\Libs\SimpleORM');
    LSearchPath.Add('D:\GitHub\bootcamp-academia-do-codigo\gerador-modelo-ota\Libs\gbswagger\Source\Core');
    LSearchPath.Add('D:\GitHub\bootcamp-academia-do-codigo\gerador-modelo-ota\Libs\gbswagger\Source\Horse');

    LBuild.SetValues(sUnitSearchPath, LSearchPath);
    LBuild.SetValue(sDefine, 'horse');
    LBuild.SetValue(sDUPLICATE_CTOR_DTOR, 'false');

    GetActiveProject.AddFile(TGeradorModeloOTANovoProjetoFiles.CreateUnitConnection(ADadosProjeto), True);
    GetActiveProject.AddFile(TGeradorModeloOTANovoProjetoFiles.CreateUnitDAOGeneric(ADadosProjeto), True);
  finally
    LSearchPath.Free;
  end;

  GetActiveProject.Save(False, True);
end;

procedure TGeradorModeloOTANovoProjetoWizard.Execute;
var
  LDadosProjeto: TGeradorModeloOTANovoProjetoModel;
begin
  FormNovoProjetoHorse := TFormNovoProjetoHorse.Create(nil);
  try
    if FormNovoProjetoHorse.ShowModal = mrOk then
    begin
      LDadosProjeto := FormNovoProjetoHorse.GetProjeto;
      try
        Self.CriarProjeto(LDadosProjeto);
      finally
        LDadosProjeto.Free;
      end;
    end;
  finally
    FormNovoProjetoHorse.Free;
  end;
end;

function TGeradorModeloOTANovoProjetoWizard.GetAuthor: string;
begin
  Result := 'Andrei Ricardo';
end;

function TGeradorModeloOTANovoProjetoWizard.GetComment: string;
begin
  Result := 'Novo Projeto Horse';
end;

function TGeradorModeloOTANovoProjetoWizard.GetGlyph: Cardinal;
begin
  Result := LoadIcon(HInstance, 'horse');
end;

function TGeradorModeloOTANovoProjetoWizard.GetIDString: string;
begin
  Result := Self.ClassName;
end;

function TGeradorModeloOTANovoProjetoWizard.GetName: string;
begin
  Result := 'Novo Projeto';
end;

function TGeradorModeloOTANovoProjetoWizard.GetPage: string;
begin
  Result := 'Horse';
end;

function TGeradorModeloOTANovoProjetoWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

end.
