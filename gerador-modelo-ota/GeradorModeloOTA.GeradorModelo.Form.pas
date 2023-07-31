unit GeradorModeloOTA.GeradorModelo.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Vcl.Menus, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.UI, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.CheckLst, DockForm, GeradorModeloOTA.GeradorModelo.Classes, ToolsAPI, System.StrUtils, GeradorModeloOTA.Utils,
  FireDAC.Phys.PGDef, FireDAC.Phys.PG, Vcl.Grids, Vcl.DBGrids;

type
  TFormGeradorModeloOTAGeradorModelo = class(TDockableForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    chklstTabelas: TCheckListBox;
    edtDataBase: TEdit;
    edtPorta: TEdit;
    edtHost: TEdit;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    btnOnOff: TButton;
    rgDriver: TRadioGroup;
    FDConn: TFDConnection;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDMetaInfoTable: TFDMetaInfoQuery;
    FDMetaInfoPK: TFDMetaInfoQuery;
    fdqTable: TFDQuery;
    pmMenuTabelas: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarcarTodos1: TMenuItem;
    N1: TMenuItem;
    GerarModelos1: TMenuItem;
    GerarController1: TMenuItem;
    PGDriver: TFDPhysPgDriverLink;
    procedure btnOnOffClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarcarTodos1Click(Sender: TObject);
    procedure GerarModelos1Click(Sender: TObject);
    procedure GerarController1Click(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarComponentes;
    procedure Conectar;
    procedure ConectarMySQL;
    procedure ConectarPostgreSQL;
    procedure ListarTabelas;

    function GetModelo(ATabela: String): TGeradorModeloOTAGeradorModeloTable;
    procedure GerarClassesController;
    procedure GerarClassesEntity;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  FormGeradorModeloOTAGeradorModelo: TFormGeradorModeloOTAGeradorModelo;

implementation

{$R *.dfm}

{ TFormGeradorModeloOTAGeradorModelo }

procedure TFormGeradorModeloOTAGeradorModelo.AtualizarComponentes;
begin
  btnOnOff.Caption := IfThen(FDConn.Connected, 'Desconectar', 'Conectar');
end;

procedure TFormGeradorModeloOTAGeradorModelo.btnOnOffClick(Sender: TObject);
begin
  chklstTabelas.Clear;
  if not FDConn.Connected then
  begin
    Self.Conectar;
    Self.ListarTabelas;
  end
  else begin
    FDConn.Connected := False;
  end;
  Self.AtualizarComponentes;
end;

procedure TFormGeradorModeloOTAGeradorModelo.Conectar;
begin
  FDConn.Connected := False;
  FDConn.Params.Clear;
  case rgDriver.ItemIndex of
    0: Self.ConectarMySQL;
    1: Self.ConectarPostgreSQL;
  end;
  FDConn.Connected := True;
end;

procedure TFormGeradorModeloOTAGeradorModelo.ConectarMySQL;
begin
  FDConn.DriverName              := 'MySQL';
  FDConn.Params.DriverID         := 'MySQL';
  FDConn.Params.UserName         := edtUsuario.Text;
  FDConn.Params.Password         := edtSenha.Text;
  FDConn.Params.Database         := edtDataBase.Text;
  FDConn.Params.Values['Server'] := edtHost.Text;
  if edtPorta.Text <> '' then
    FDConn.Params.Values['Port'] := edtPorta.Text;
end;

procedure TFormGeradorModeloOTAGeradorModelo.ConectarPostgreSQL;
begin
  FDConn.DriverName              := 'PG';
  FDConn.Params.DriverID         := 'PG';
  FDConn.Params.UserName         := edtUsuario.Text;
  FDConn.Params.Password         := edtSenha.Text;
  FDConn.Params.Database         := edtDataBase.Text;
  FDConn.Params.Values['Server'] := edtHost.Text;
  if edtPorta.Text <> '' then
    FDConn.Params.Values['Port'] := edtPorta.Text;
end;

constructor TFormGeradorModeloOTAGeradorModelo.Create(AOwner: TComponent);
begin
  inherited;
  Self.DeskSection        := Self.Name;
  Self.AutoSave           := True;
  Self.SaveStateNecessary := True;
end;

procedure TFormGeradorModeloOTAGeradorModelo.DesmarcarTodos1Click(Sender: TObject);
var
  LIndex: Integer;
begin
  for LIndex := 0 to Pred(chklstTabelas.Items.Count) do
    chklstTabelas.Checked[LIndex] := False;
end;

procedure TFormGeradorModeloOTAGeradorModelo.GerarClassesController;
var
  LIndex: Integer;
  LModelo: TGeradorModeloOTAGeradorModeloTable;
  LFileName: String;
  LEditView: IOTAEditView;
  LEdit: TStrings;
  LIndex2: Integer;
begin
  for LIndex := 0 to Pred(chklstTabelas.Items.Count) do
  begin
    if chklstTabelas.Checked[LIndex] then
    begin
      LModelo := Self.GetModelo(chklstTabelas.Items[LIndex]);
      try
        LFileName := ExtractFilePath(GetActiveProject.FileName) + 'src\Controller\Controller.' + LModelo.Nome.ToUpper + '.pas';
        ForceDirectories(ExtractFilePath(LFileName));

        with TStringList.Create do
        begin
          Text := LModelo.UnitController;
          SaveToFile(LFileName);
          Free;
        end;

        GetActiveProject.AddFile(LFileName, True);

//        (BorlandIDEServices as IOTAMessageServices)
//          .AddToolMessage(LFileName, 'Arquivo gerado', 'Passaporte', 0, 0);

        (BorlandIDEServices as IOTAModuleServices)
          .FindModule(GetActiveProject.FileName).Show;

        LEdit := TGeradorModeloOTAUtils.ActiveEditorAsStringList;
        try
          for LIndex2 := 0 to Pred(LEdit.Count) do
          begin
            if LEdit[LIndex2].Trim.ToLower.Contains('thorse.listen') then
            begin
              LEditView := (BorlandIDEServices as IOTAEditorServices).TopView;
              LEditView.Buffer.EditPosition.GotoLine(LIndex2);
              LeditView.Buffer.EditPosition.InsertText('  Controller.' + LModelo.Nome.ToUpper + '.Registry;' + sLineBreak);
            end;
          end;
        finally
          LEdit.Free;
        end;
      finally
        LModelo.Free;
      end;
    end;
  end;

  if FileExists(LFileName) then
    (BorlandIDEServices as IOTAModuleServices).FindModule(LFileName).Show;
end;

procedure TFormGeradorModeloOTAGeradorModelo.GerarClassesEntity;
var
  LIndex: Integer;
  LModelo: TGeradorModeloOTAGeradorModeloTable;
  LFileName: String;
begin
  for LIndex := 0 to Pred(chklstTabelas.Items.Count) do
  begin
    if chklstTabelas.Checked[LIndex] then
    begin
      LModelo := Self.GetModelo(chklstTabelas.Items[LIndex]);
      try
        LFileName := ExtractFilePath(GetActiveProject.FileName) + 'src\Model\Entity\Model.Entity.' + LModelo.Nome.ToUpper + '.pas';
        ForceDirectories(ExtractFilePath(LFileName));

        with TStringList.Create do
        begin
          Text := LModelo.UnitEntity;
          SaveToFile(LFileName);
          Free;
        end;

        GetActiveProject.AddFile(LFileName, True);
      finally
        LModelo.Free;
      end;
    end;
  end;

  if FileExists(LFileName) then
    (BorlandIDEServices as IOTAModuleServices).FindModule(LFileName).Show;
end;

procedure TFormGeradorModeloOTAGeradorModelo.GerarController1Click(Sender: TObject);
begin
  Self.GerarClassesController;
end;

procedure TFormGeradorModeloOTAGeradorModelo.GerarModelos1Click(Sender: TObject);
begin
  Self.GerarClassesEntity;
end;

function TFormGeradorModeloOTAGeradorModelo.GetModelo(ATabela: String): TGeradorModeloOTAGeradorModeloTable;
var
  LIndex: Integer;
  LFieldName: String;
  LPrimaryKey: Boolean;
begin
  fdqTable.Close;
  fdqTable.SQL.Text := Format('SELECT * FROM %s WHERE 1 = 2', [ATabela]);
  fdqTable.Open;

  FDMetaInfoPK.Close;
  FDMetaInfoPK.BaseObjectName := ATabela;
  if rgDriver.ItemIndex = 1 then
    FDMetaInfoPK.SchemaName := 'public';
  FDMetaInfoPK.Open;
  
  Result := TGeradorModeloOTAGeradorModeloTable.Create;
  try
    Result.Nome := ATabela;
    for LIndex := 0 to Pred(fdqTable.Fields.Count) do
    begin
      LFieldName := fdqTable.Fields[LIndex].FieldName;
      LPrimaryKey := FDMetaInfoPK.Locate('column_name', LFieldName, [loCaseInsensitive]);
      Result.AddCampo(LFieldName, fdqTable.Fields[LIndex].DataType, LPrimaryKey);
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TFormGeradorModeloOTAGeradorModelo.ListarTabelas;
begin
  FDMetaInfoTable.CatalogName := edtDataBase.Text;
  if rgDriver.ItemIndex = 1 then
    FDMetaInfoTable.SchemaName := 'public';
  FDMetaInfoTable.Active := True;
  FDMetaInfoTable.First;
  chklstTabelas.Clear;
  while not FDMetaInfoTable.Eof do
  begin
    chklstTabelas.Items.Add(FDMetaInfoTable.FieldByName('table_name').AsString);
    FDMetaInfoTable.Next;
  end;
end;

procedure TFormGeradorModeloOTAGeradorModelo.MarcarTodos1Click(Sender: TObject);
var
  LIndex: Integer;
begin
  for LIndex := 0 to Pred(chklstTabelas.Items.Count) do
    chklstTabelas.Checked[LIndex] := True;
end;

end.
