unit GeradorModeloOTA.NovoProjeto.Model;

interface

uses
  System.SysUtils;

type
  TGeradorModeloOTANovoProjetoModel = class
  private
    FNome: String;
    FPorta: Integer;
    FDiretorio: String;
    function GetDiretorio: String;
    procedure SetDiretorio(const Value: String);
  published
    property Nome: String read FNome write FNome;
    property Porta: Integer read FPorta write FPorta;
    property Diretorio: String read GetDiretorio write SetDiretorio;

    function GetProjectFileName: String;
    function DiretorioConnection: String;
  end;

implementation

{ TGeradorModeloOTANovoProjetoModel }

function TGeradorModeloOTANovoProjetoModel.DiretorioConnection: String;
begin
  Result := Diretorio + 'src\Model\Connection\';
  ForceDirectories(Result);
end;

function TGeradorModeloOTANovoProjetoModel.GetDiretorio: String;
begin
  Result := FDiretorio;
  ForceDirectories(FDiretorio);
end;

function TGeradorModeloOTANovoProjetoModel.GetProjectFileName: String;
begin
  Result := Diretorio + Nome + '.dpr';
end;

procedure TGeradorModeloOTANovoProjetoModel.SetDiretorio(const Value: String);
begin
  FDiretorio := Value;
  if not FDiretorio.EndsWith('\') then
    FDiretorio := FDiretorio + '\';
end;

end.
