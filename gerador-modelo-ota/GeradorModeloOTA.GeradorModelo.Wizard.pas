unit GeradorModeloOTA.GeradorModelo.Wizard;

interface

uses
  Vcl.Dialogs, Vcl.Menus, ToolsAPI, GeradorModeloOTA.GeradorModelo.Form, DeskUtil;

type
  TGeradorModeloOTAGeradorModeloWizard = class(TNotifierObject, IOTAWizard)
  private
    procedure OnClickMenu(AObject: TObject);
  protected
    function GetIDString: String;
    function GetName: string;
    function GetState: TWizardState;

    // Launch the AddIn
    procedure Execute;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TGeradorModeloOTAGeradorModeloWizard }

constructor TGeradorModeloOTAGeradorModeloWizard.Create;
var
  LDelphiMenu: TMainMenu;
  LItemMenu: TMenuItem;
  LItemExecute: TMenuItem;
begin
  LDelphiMenu := (BorlandIDEServices as INTAServices).MainMenu;
  if not Assigned(LDelphiMenu.Items.Find('Gerador de Modelo')) then
  begin
    LItemMenu := TMenuItem.Create(nil);
    LItemMenu.Caption := 'Gerador de Modelo';
    LDelphiMenu.Items.Add(LItemMenu);

    LItemExecute := TMenuItem.Create(LItemMenu);
    LItemExecute.Caption := 'Executar';
    LItemExecute.OnClick := Self.OnClickMenu;
    LItemMenu.Add(LItemExecute);
  end;
end;

destructor TGeradorModeloOTAGeradorModeloWizard.Destroy;
var
  LDelphiMenu: TMainMenu;
  LItemMenu: TMenuItem;
begin
  LDelphiMenu := (BorlandIDEServices as INTAServices).MainMenu;
  LItemMenu := LDelphiMenu.Items.Find('Gerador de Modelo');
  LItemMenu.Free;
  inherited;
end;

procedure TGeradorModeloOTAGeradorModeloWizard.Execute;
begin
  //
end;

function TGeradorModeloOTAGeradorModeloWizard.GetIDString: String;
begin
  Result := Self.ClassName;
end;

function TGeradorModeloOTAGeradorModeloWizard.GetName: string;
begin
  Result := Self.ClassName;
end;

function TGeradorModeloOTAGeradorModeloWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TGeradorModeloOTAGeradorModeloWizard.OnClickMenu(AObject: TObject);
begin
  if not Assigned(FormGeradorModeloOTAGeradorModelo) then
    Exit;

  ShowDockableForm(FormGeradorModeloOTAGeradorModelo);
  FocusWindow(FormGeradorModeloOTAGeradorModelo);
end;

end.
