unit CursoOTA.MainMenu.Wizard;

interface

uses
  ToolsAPI, ShellAPI, System.SysUtils, System.Classes, Vcl.Menus, Vcl.Dialogs, Vcl.Graphics;

type
  TCursoOTAMainMenuWizard = class(TNotifierObject, IOTAWizard)
  private
    function AddImageToImageList(AImageName: String): Integer;
    procedure CreateMenu;
    function CreateSubMenu(AParent: TMenuItem; ACaption: String; AName: String; AOnClick: TNotifyEvent;
      AImageIndex: Integer = -1): TMenuItem;
    procedure OnClickNovoWizard(ASender: TObject);
    procedure OnClickDBeaver(ASender: TObject);
    procedure OnClickSQLite(ASender: TObject);
    procedure OnClickMySQL(ASender: TObject);
    procedure OnClickSQLDeveloper(ASender: TObject);
    procedure OnClickPostgreSQL(ASender: TObject);
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
  public
    constructor Create;
  end;

implementation

{ TCursoOTAMainMenuWizard }

function TCursoOTAMainMenuWizard.AddImageToImageList(AImageName: String): Integer;
var
  LBitmap: TBitmap;
begin
  LBitmap := TBitmap.Create;
  try
    LBitmap.LoadFromResourceName(HInstance, AImageName);
    Result := (BorlandIDEServices as INTAServices).AddMasked(LBitmap, LBitmap.TransparentColor, Format('img%s', [AImageName]));
  finally
    LBitmap.Free;
  end;
end;

constructor TCursoOTAMainMenuWizard.Create;
begin
  Self.CreateMenu;
end;

procedure TCursoOTAMainMenuWizard.CreateMenu;
var
  LMainMenu: TMainMenu;
  LMenuName: String;
  LMenuItem: TMenuItem;
  LMenuUtilitarios: TMenuItem;
begin
  LMainMenu := (BorlandIDEServices as INTAServices).MainMenu;
  LMenuName := 'mnuCursoOTA';

  if Assigned(LMainMenu.FindComponent(LMenuName)) then
    LMainMenu.FindComponent(LMenuName).Free;

  LMenuItem := TMenuItem.Create(LMainMenu);
  LMenuItem.Name := LMenuName;
  LMenuItem.Caption := 'Curso OTA';
  LMainMenu.Items.Add(LMenuItem);

  Self.CreateSubMenu(LMenuItem, 'Novo Wizard', 'mnuNovoWizard', Self.OnClickNovoWizard);
  Self.CreateSubMenu(LMenuItem, 'Modelo', 'mnuModelo', nil);
  Self.CreateSubMenu(LMenuItem, 'Histórico de Projetos', 'mnuHistoricoProjetos', nil);

  LMenuUtilitarios := Self.CreateSubMenu(LMenuItem, 'Utilitários', 'mnuUtilitarios', nil);
  Self.CreateSubMenu(LMenuUtilitarios, 'DBeaver', 'mnuDBeaver', Self.OnClickDBeaver, Self.AddImageToImageList('dbeaver'));
  Self.CreateSubMenu(LMenuUtilitarios, 'SQLite', 'mnuSQLite', Self.OnClickSQLite, Self.AddImageToImageList('sqlite'));
  Self.CreateSubMenu(LMenuUtilitarios, 'MySQL', 'mnuMySQL', Self.OnClickMySQL, Self.AddImageToImageList('mysql'));
  Self.CreateSubMenu(LMenuUtilitarios, 'SQLDeveloper', 'mnuSQLDeveloper', Self.OnClickSQLDeveloper, Self.AddImageToImageList('sqldeveloper'));
  Self.CreateSubMenu(LMenuUtilitarios, 'PostgreSQL', 'mnuPostgreSQL', Self.OnClickPostgreSQL, Self.AddImageToImageList('postgresql'));
end;

function TCursoOTAMainMenuWizard.CreateSubMenu(AParent: TMenuItem; ACaption, AName: String;
  AOnClick: TNotifyEvent; AImageIndex: Integer): TMenuItem;
begin
  Result := TMenuItem.Create(AParent);
  Result.Caption := ACaption;
  Result.Name := AName;
  Result.OnClick := AOnClick;
  if AImageIndex > -1 then
    Result.ImageIndex := AImageIndex;
  AParent.Add(Result);
end;

procedure TCursoOTAMainMenuWizard.Execute;
begin

end;

function TCursoOTAMainMenuWizard.GetIDString: string;
begin
  Result := Self.ClassName;
end;

function TCursoOTAMainMenuWizard.GetName: string;
begin
  Result := Self.ClassName;
end;

function TCursoOTAMainMenuWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TCursoOTAMainMenuWizard.OnClickDBeaver(ASender: TObject);
begin
  ShellExecute(HInstance, 'open', 'C:\Program Files\DBeaver\dbeaver.exe', '', '', 0);
end;

procedure TCursoOTAMainMenuWizard.OnClickMySQL(ASender: TObject);
begin
  ShellExecute(HInstance, 'open', 'C:\Program Files\DBeaver\dbeaver.exe', '', '', 0);
end;

procedure TCursoOTAMainMenuWizard.OnClickNovoWizard(ASender: TObject);
begin
  ShowMessage('Novo Wizard');
end;

procedure TCursoOTAMainMenuWizard.OnClickPostgreSQL(ASender: TObject);
begin
  ShellExecute(HInstance, 'open', 'C:\Program Files\DBeaver\dbeaver.exe', '', '', 0);
end;

procedure TCursoOTAMainMenuWizard.OnClickSQLDeveloper(ASender: TObject);
begin
  ShellExecute(HInstance, 'open', 'C:\Program Files\DBeaver\dbeaver.exe', '', '', 0);
end;

procedure TCursoOTAMainMenuWizard.OnClickSQLite(ASender: TObject);
begin
  ShellExecute(HInstance, 'open', 'C:\Program Files\DBeaver\dbeaver.exe', '', '', 0);
end;

end.
