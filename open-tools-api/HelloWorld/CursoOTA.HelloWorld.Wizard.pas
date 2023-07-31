unit CursoOTA.HelloWorld.Wizard;

interface

uses
  ToolsAPI, Vcl.Dialogs;

type
  TCursoOTAHelloWorldWizard = class(TNotifierObject, IOTAWizard, IOTAMenuWizard)
  protected
    /// <summary>
    /// Expert UI strings
    /// </summary>
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;

    /// <summary>
    /// Launch the AddIn
    /// </summary>
    procedure Execute;

    function GetMenuText: string;
  end;

implementation

{ TCursoOTAHelloWorldWizard }

procedure TCursoOTAHelloWorldWizard.Execute;
begin
  ShowMessage('Hello World');
end;

function TCursoOTAHelloWorldWizard.GetIDString: string;
begin
  Result := 'Hello World';
end;

function TCursoOTAHelloWorldWizard.GetMenuText: string;
begin
  Result := 'Hello World';
end;

function TCursoOTAHelloWorldWizard.GetName: string;
begin
  Result := 'Hello World';
end;

function TCursoOTAHelloWorldWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

end.
