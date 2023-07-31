unit GeradorModeloOTA.NovoProjeto.Form;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Mask,
  GeradorModeloOTA.NovoProjeto.Model;

type
  TFormNovoProjetoHorse = class(TForm)
    ImgHorse: TImage;
    LbeNome: TLabeledEdit;
    LbePorta: TLabeledEdit;
    LbeDiretorio: TLabeledEdit;
    BtnCriar: TButton;
    procedure BtnCriarClick(Sender: TObject);
    procedure LbeNomeExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetProjeto: TGeradorModeloOTANovoProjetoModel;
  end;

var
  FormNovoProjetoHorse: TFormNovoProjetoHorse;

implementation

{$R *.dfm}

{ TFormNovoProjetoHorse }

procedure TFormNovoProjetoHorse.BtnCriarClick(Sender: TObject);
begin
  Self.ModalResult := mrOk;
end;

function TFormNovoProjetoHorse.GetProjeto: TGeradorModeloOTANovoProjetoModel;
begin
  try
    Result := TGeradorModeloOTANovoProjetoModel.Create;
    Result.Nome := LbeNome.Text;
    Result.Porta := StrToInt(LbePorta.Text);
    Result.Diretorio := LbeDiretorio.Text;
  except
    Result.Free;
    raise;
  end;
end;

procedure TFormNovoProjetoHorse.LbeNomeExit(Sender: TObject);
begin
  LbeDiretorio.Text := LbeDiretorio.Text + '\' + LbeNome.Text;
end;

end.
