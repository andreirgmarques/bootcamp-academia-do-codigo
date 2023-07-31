unit GeradorModeloOTA.NovoProjeto.SourceFile;

interface

uses
  System.SysUtils, System.StrUtils, ToolsAPI, GeradorModeloOTA.NovoProjeto.Model;

type
  TGeradorModeloOTANovoProjetoSourceFile = class(TNotifierObject, IOTAFile)
  private
    FDadosProjeto: TGeradorModeloOTANovoProjetoModel;
  protected
    // Return the actual source code
    function GetSource: string;
    function GetAge: TDateTime;
  public
    constructor Create(ADadosProjeto: TGeradorModeloOTANovoProjetoModel);
    destructor Destroy; override;
    class function New(ADadosProjeto: TGeradorModeloOTANovoProjetoModel): IOTAFile;
  end;

implementation

{ TGeradorModeloOTANovoProjetoSourceFile }

constructor TGeradorModeloOTANovoProjetoSourceFile.Create(ADadosProjeto: TGeradorModeloOTANovoProjetoModel);
begin
  FDadosProjeto := ADadosProjeto;
end;

destructor TGeradorModeloOTANovoProjetoSourceFile.Destroy;
begin

  inherited;
end;

function TGeradorModeloOTANovoProjetoSourceFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TGeradorModeloOTANovoProjetoSourceFile.GetSource: string;
var
  LResult: TStringBuilder;
begin
  LResult := TStringBuilder.Create;
  try
    Result := LResult
                .AppendLine('program %0:s;                                                                    ')
                .AppendLine
                .AppendLine('{$APPTYPE CONSOLE}                                                               ')
                .AppendLine
                .AppendLine('{$R *.res}                                                                       ')
                .AppendLine
                .AppendLine('uses                                                                             ')
                .AppendLine('  System.SysUtils,                                                               ')
                .AppendLine('  Horse,                                                                         ')
                .AppendLine('  Horse.CORS,                                                                    ')
                .AppendLine('  Horse.Jhonson,                                                                 ')
                .AppendLine('  Horse.GBSwagger;                                                               ')
                .AppendLine
                .AppendLine('begin                                                                            ')
                .AppendLine('  THorse.Use(CORS);                                                              ')
                .AppendLine('  THorse.Use(Jhonson);                                                           ')
                .AppendLine('  THorse.Use(HorseSwagger);                                                      ')
                .AppendLine
                .AppendLine('  THorse.Get(''ping'',                                                           ')
                .AppendLine('    procedure (ARequest: THorseRequest; AResponse: THorseResponse; ANext: TProc) ')
                .AppendLine('    begin                                                                        ')
                .AppendLine('      AResponse.Send(''pong'');                                                  ')
                .AppendLine('    end                                                                          ')
                .AppendLine('  );                                                                             ')
                .AppendLine
                .AppendLine('  THorse.Listen(%1:s,                                                            ')
                .AppendLine('    procedure (AHorse: THorse)                                                   ')
                .AppendLine('    begin                                                                        ')
//                .AppendLine('      WriteLn(''Servidor iniciado na porta '' + AHorse.Port.ToString);           ')
//                .AppendLine('      Write(''Pressione ENTER para finalizar...'');                              ')
                .AppendLine('      ReadLn;                                                                    ')
                .AppendLine('      THorse.StopListen;                                                         ')
                .AppendLine('    end                                                                          ')
                .AppendLine('  );                                                                             ')
                .AppendLine('end.                                                                             ')
                .ToString;
    Result := Format(Result, [FDadosProjeto.Nome, FDadosProjeto.Porta.ToString]);
  finally
    LResult.Free;
  end;
end;

class function TGeradorModeloOTANovoProjetoSourceFile.New(ADadosProjeto: TGeradorModeloOTANovoProjetoModel): IOTAFile;
begin
  Result := Self.Create(ADadosProjeto);
end;

end.
