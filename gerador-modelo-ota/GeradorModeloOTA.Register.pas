unit GeradorModeloOTA.Register;

interface

uses
  ToolsAPI, GeradorModeloOTA.GeradorModelo.Wizard, GeradorModeloOTA.GeradorModelo.Form, GeradorModeloOTA.NovoProjeto.Wizard,
  DeskUtil, System.SysUtils;

procedure Register;
procedure DockFormRegister;
procedure DockFormUnRegister;

implementation

procedure Register;
begin
  RegisterPackageWizard(TGeradorModeloOTAGeradorModeloWizard.Create);
  RegisterPackageWizard(TGeradorModeloOTANovoProjetoWizard.Create)
end;

procedure DockFormRegister;
begin
  if not Assigned(FormGeradorModeloOTAGeradorModelo) then
    FormGeradorModeloOTAGeradorModelo := TFormGeradorModeloOTAGeradorModelo.Create(nil);

  if @RegisterFieldAddress <> nil then
    RegisterFieldAddress(FormGeradorModeloOTAGeradorModelo.Name, @FormGeradorModeloOTAGeradorModelo);

  RegisterDesktopFormClass(
    TFormGeradorModeloOTAGeradorModelo,
    FormGeradorModeloOTAGeradorModelo.Name,
    FormGeradorModeloOTAGeradorModelo.Name
  )
end;

procedure DockFormUnRegister;
begin
  if Assigned(FormGeradorModeloOTAGeradorModelo) then
  begin
    if @UnregisterFieldAddress <> nil then
      UnregisterFieldAddress(@FormGeradorModeloOTAGeradorModelo);
    FreeAndNil(FormGeradorModeloOTAGeradorModelo);
  end;
end;

initialization
  DockFormRegister;

finalization
  DockFormUnRegister;

end.
