unit GeradorModeloOTA.Utils;

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Forms,
  Vcl.Menus,
  ToolsAPI,
  Vcl.Dialogs;
type TGeradorModeloOTAUtils = class
  public
    class function GetProjectGroup: IOTAProjectGroup;
    class function CurrentModule: IOTAModule;
    class function SourceEditor: IOTASourceEditor;
    class function EditorAsString(AEditor: IOTASourceEditor): string;
    class function EditorAsStringList(AEditor: IOTASourceEditor): TStrings;
    class function ActiveEditorAsStringList: TStrings;
    class function ActiveFormEditor: IOTAFormEditor;
    class function IsFormDesignerActive: Boolean;
    class function MainMenu: TMainMenu;
end;
implementation
{ TGeradorModeloOTAUtils }
class function TGeradorModeloOTAUtils.ActiveEditorAsStringList: TStrings;
Const
  iBufferSize : Integer = 1024;
var
  i            : Integer;
  module       : IOTAModule;
  activeEditor : IOTASourceEditor;
  Reader       : IOTAEditReader;
  iRead        : Integer;
  iPosition    : Integer;
  strBuffer    : AnsiString;
  content      : string;
begin
  module := (BorlandIDEServices as IOTAModuleServices).CurrentModule;
  for i := 0 to module.ModuleFileCount - 1 do
  begin
    if module.ModuleFileEditors[i].QueryInterface(IOTASourceEditor, activeEditor) = S_OK then
      Break;
  end;
  result  := TStringList.Create;
  content := EmptyStr;
  try
    Reader := SourceEditor.CreateReader;
    Try
      iPosition := 0;
      Repeat
        SetLength(strBuffer, iBufferSize);
        iRead := Reader.GetText(iPosition, PAnsiChar(strBuffer), iBufferSize);
        SetLength(strBuffer, iRead);
        content := content + String(strBuffer);
        Inc(iPosition, iRead);
      Until iRead < iBufferSize;
    Finally
      Reader := Nil;
    End;
    Result.Text := content;
  except
    Result.Free;
    raise;
  end;
end;
class function TGeradorModeloOTAUtils.CurrentModule: IOTAModule;
begin
  result := (BorlandIDEServices as IOTAModuleServices).CurrentModule;
end;
class function TGeradorModeloOTAUtils.EditorAsString(AEditor: IOTASourceEditor): string;
Const
  iBufferSize : Integer = 1024;
Var
  Reader : IOTAEditReader;
  iRead : Integer;
  iPosition : Integer;
  strBuffer : AnsiString;
Begin
  Result := '';
  Reader := SourceEditor.CreateReader;
  Try
    iPosition := 0;
    Repeat
      SetLength(strBuffer, iBufferSize);
      iRead := Reader.GetText(iPosition, PAnsiChar(strBuffer), iBufferSize);
      SetLength(strBuffer, iRead);
      Result := Result + String(strBuffer);
      Inc(iPosition, iRead);
    Until iRead < iBufferSize;
  Finally
    Reader := Nil;
  End;
End;
class function TGeradorModeloOTAUtils.EditorAsStringList(AEditor: IOTASourceEditor): TStrings;
begin
  result := TStringList.Create;
  Result.Text := EditorAsString(AEditor);
end;
class function TGeradorModeloOTAUtils.ActiveFormEditor: IOTAFormEditor;
var
  module: IOTAModule;
  editor: IOTAEditor;
begin
  Result := nil;
  module := (BorlandIDEServices as IOTAModuleServices).CurrentModule;
  if module = nil then
    Exit;
  editor := module.CurrentEditor;
  if editor = nil then
    Exit;
  Supports(editor, IOTAFormEditor, Result);
end;
class function TGeradorModeloOTAUtils.GetProjectGroup: IOTAProjectGroup;
var
  moduleServices: IOTAModuleServices;
  module : IOTAModule;
  projectGroup: IOTAProjectGroup;
  i: Integer;
begin
  result := nil;
  moduleServices := BorlandIDEServices as IOTAModuleServices;
  for i := 0 to Pred(moduleServices.ModuleCount) do
  begin
    module := moduleServices.Modules[i];
    if module.QueryInterface(IOTAProjectGroup, projectGroup) = S_OK then
      Exit(projectGroup);
  end;
end;
class function TGeradorModeloOTAUtils.IsFormDesignerActive: Boolean;
begin
  Result := ActiveFormEditor <> nil;
end;
class function TGeradorModeloOTAUtils.MainMenu: TMainMenu;
begin
  result := (BorlandIDEServices as INTAServices).MainMenu;
end;
class function TGeradorModeloOTAUtils.SourceEditor: IOTASourceEditor;
var
  i: Integer;
  module : IOTAModule;
begin
  module := currentModule;
  for i := 0 to module.ModuleFileCount - 1 do
  begin
    if module.ModuleFileEditors[i].QueryInterface(IOTASourceEditor, result) = S_OK then
      Break;
  end;
end;
end.

