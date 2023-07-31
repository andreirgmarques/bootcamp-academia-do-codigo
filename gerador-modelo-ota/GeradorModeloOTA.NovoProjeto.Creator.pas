unit GeradorModeloOTA.NovoProjeto.Creator;

interface

uses
  System.SysUtils, ToolsAPI, GeradorModeloOTA.NovoProjeto.SourceFile, GeradorModeloOTA.NovoProjeto.Model;

type
  TGeradorModeloOTANovoProjetoCreator = class(TNotifierObject, IOTACreator, IOTAProjectCreator)
  private
    FDadosProjeto: TGeradorModeloOTANovoProjetoModel;
  protected
    /// <summary>
    /// Return a string representing the default creator type in which to augment.
    /// See the definitions of sApplication, sConsole, sLibrary and
    /// sPackage, etc.. above.  Return an empty string indicating that this
    /// creator will provide *all* information
    /// </summary>
    function GetCreatorType: string;
    /// <summary>
    /// Return False if this is a new module
    /// </summary>
    function GetExisting: Boolean;
    /// <summary>
    /// Return the File system IDString that this module uses for reading/writing
    /// </summary>
    function GetFileSystem: string;
    /// <summary>
    /// Return the Owning module, if one exists (for a project module, this would
    /// be a project; for a project this is a project group)
    /// </summary>
    function GetOwner: IOTAModule;
    /// <summary>
    /// Return true, if this item is to be marked as un-named.  This will force the
    /// save as dialog to appear the first time the user saves.
    /// </summary>
    function GetUnnamed: Boolean;
    /// <summary>
    /// Return the project filename. NOTE: This *must* be a fully qualified file name.
    /// </summary>
    function GetFileName: string;
    /// <summary>
    /// Deprecated!! Return the option file name (C++ .bpr, .bpk, etc...)
    /// </summary>
    function GetOptionFileName: string; deprecated;
    /// <summary>
    /// Return True to show the source
    /// </summary>
    function GetShowSource: Boolean;
    /// <summary>
    /// Deprecated!! Called to create a new default module for this project.
    /// Please implement and use the method on IOTAProjectCreator50.
    /// </summary>
    procedure NewDefaultModule; deprecated;
    /// <summary>
    /// Deprecated!! Create and return the project option source. (C++)
    /// </summary>
    function NewOptionSource(const ProjectName: string): IOTAFile; deprecated;
    /// <summary>
    /// Called to indicate when to create/modify the project resource file
    /// </summary>
    procedure NewProjectResource(const Project: IOTAProject);
    /// <summary>
    /// Create and return the Project source file
    /// </summary>
    function NewProjectSource(const ProjectName: string): IOTAFile;
  public
    constructor Create(ADadosProjeto: TGeradorModeloOTANovoProjetoModel);
    destructor Destroy; override;
    class function New(ADadosProjeto: TGeradorModeloOTANovoProjetoModel): IOTAProjectCreator;
  end;


implementation

{ TGeradorModeloOTANovoProjetoCreator }

constructor TGeradorModeloOTANovoProjetoCreator.Create(ADadosProjeto: TGeradorModeloOTANovoProjetoModel);
begin
  FDadosProjeto := ADadosProjeto;
end;

destructor TGeradorModeloOTANovoProjetoCreator.Destroy;
begin

  inherited;
end;

function TGeradorModeloOTANovoProjetoCreator.GetCreatorType: string;
begin
  Result := sConsole;
end;

function TGeradorModeloOTANovoProjetoCreator.GetExisting: Boolean;
begin
  Result := False;
end;

function TGeradorModeloOTANovoProjetoCreator.GetFileName: string;
begin
  Result := FDadosProjeto.GetProjectFileName;
end;

function TGeradorModeloOTANovoProjetoCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TGeradorModeloOTANovoProjetoCreator.GetOptionFileName: string;
begin
  Result := '';
end;

function TGeradorModeloOTANovoProjetoCreator.GetOwner: IOTAModule;
begin
  Result := (BorlandIDEServices as IOTAModuleServices).MainProjectGroup;
end;

function TGeradorModeloOTANovoProjetoCreator.GetShowSource: Boolean;
begin
  Result := True;
end;

function TGeradorModeloOTANovoProjetoCreator.GetUnnamed: Boolean;
begin
  Result := False;
end;

class function TGeradorModeloOTANovoProjetoCreator.New(
  ADadosProjeto: TGeradorModeloOTANovoProjetoModel): IOTAProjectCreator;
begin
  Result := Self.Create(ADadosProjeto);
end;

procedure TGeradorModeloOTANovoProjetoCreator.NewDefaultModule;
begin

end;

function TGeradorModeloOTANovoProjetoCreator.NewOptionSource(const ProjectName: string): IOTAFile;
begin
  Result := nil;
end;

procedure TGeradorModeloOTANovoProjetoCreator.NewProjectResource(const Project: IOTAProject);
begin

end;

function TGeradorModeloOTANovoProjetoCreator.NewProjectSource(const ProjectName: string): IOTAFile;
begin
  Result := TGeradorModeloOTANovoProjetoSourceFile.New(FDadosProjeto);
end;

end.
