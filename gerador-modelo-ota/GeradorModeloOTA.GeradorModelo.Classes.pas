unit GeradorModeloOTA.GeradorModelo.Classes;

interface

uses
  System.Generics.Collections, System.SysUtils, System.StrUtils, Data.DB;

type
  TGeradorModeloOTAGeradorModeloCampo = class
  private
    FNome: String;
    FPrimaryKey: Boolean;
    FDataType: TFieldType;
  public
    property Nome: String read FNome write FNome;
    property PrimaryKey: Boolean read FPrimaryKey write FPrimaryKey default false;
    property DataType: TFieldType read FDataType write FDataType;

    function DelphiType: String;
  end;

  TGeradorModeloOTAGeradorModeloTable = class
  private
    FNome: String;
    FCampos: TObjectList<TGeradorModeloOTAGeradorModeloCampo>;

  public
    property Nome: string read FNome write FNome;
    property Campos: TObjectList<TGeradorModeloOTAGeradorModeloCampo> read FCampos write FCampos;

    procedure AddCampo(ANome: string; ADataType: TFieldType; APK: Boolean);

    function UnitEntity: String;
    function UnitController: string;

    constructor Create;
    destructor  Destroy; override;
end;

implementation

{ TGeradorModeloOTAGeradorModeloTable }

procedure TGeradorModeloOTAGeradorModeloTable.AddCampo(ANome: string; ADataType: TFieldType; APK: Boolean);
begin
  FCampos.Add(TGeradorModeloOTAGeradorModeloCampo.Create);
  FCampos.Last.Nome := ANome;
  FCampos.Last.DataType := ADataType;
  FCampos.Last.PrimaryKey := APK;
end;

constructor TGeradorModeloOTAGeradorModeloTable.Create;
begin
  FCampos := TObjectList<TGeradorModeloOTAGeradorModeloCampo>.Create;
end;

destructor TGeradorModeloOTAGeradorModeloTable.Destroy;
begin
  FCampos.Free;
  inherited;
end;

function TGeradorModeloOTAGeradorModeloTable.UnitController: string;
begin
  result :=
    'unit Controller.%0:s;' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  Horse,' + sLineBreak +
    '  System.JSON;' + sLineBreak +
    '' + sLineBreak +
    'procedure Registry;' + sLineBreak +
    'procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    '' + sLineBreak +
    'implementation' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  Model.DAO.Generic,' + sLineBreak +
    '  Model.Entity.%0:s;' + sLineBreak +
    '' + sLineBreak +
    'procedure Registry;' + sLineBreak +
    'begin' + sLineBreak +
    '  THorse.Get(''/%1:s'', Get);' + sLineBreak +
    '  THorse.Get(''/%1:s/:id'', GetID);' + sLineBreak +
    '  THorse.Post(''/%1:s'', Insert);' + sLineBreak +
    '  THorse.Put(''/%1:s/:id'', Update);' + sLineBreak +
    '  THorse.Delete(''/%1:s/:id'', Delete);' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'var' + sLineBreak +
    '  LDAO : IDAOGeneric<T%0:s>;' + sLineBreak +
    'begin' + sLineBreak +
    '  LDAO := TDAOGeneric<T%0:s>.New;' + sLineBreak +
    '  Res.Send<TJSonArray>(LDAO.Find);' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'var' + sLineBreak +
    '  LDAO : IDAOGeneric<T%0:s>;' + sLineBreak +
    'begin' + sLineBreak +
    '  LDAO := TDAOGeneric<T%0:s>.New;' + sLineBreak +
    '  Res.Send<TJSONObject>( LDAO.Find(Req.Params[''id'']));' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'var' + sLineBreak +
    '  LDAO : IDAOGeneric<T%0:s>;' + sLineBreak +
    'begin' + sLineBreak +
    '  LDAO := TDAOGeneric<T%0:s>.New;' + sLineBreak +
    '  Res.Send<TJSONObject>(LDAO.Insert(Req.Body<TJsonObject>));' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'var' + sLineBreak +
    '  LDAO : IDAOGeneric<T%0:s>;' + sLineBreak +
    '  JSON : TJSONObject;' + sLineBreak +
    'begin' + sLineBreak +
    '  LDAO := TDAOGeneric<T%0:s>.New;' + sLineBreak +
    '  JSON := Req.Body<TJSONObject>;' + sLineBreak +
    '  JSON.AddPair(''ID'', Req.Params[''id'']);' + sLineBreak +
    '  Res.Send<TJSONObject>(LDAO.Update(JSON));' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);' + sLineBreak +
    'var' + sLineBreak +
    '  LDAO : IDAOGeneric<T%0:s>;' + sLineBreak +
    'begin' + sLineBreak +
    '  LDAO := TDAOGeneric<T%0:s>.New;' + sLineBreak +
    '  LDAO.Delete(''ID'', Req.Params.Items[''id'']);' + sLineBreak +
    '  Res.Status(204);' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'end.';

  result := Format(Result, [Nome.ToUpper, Nome.ToLower]);
end;

function TGeradorModeloOTAGeradorModeloTable.UnitEntity: String;

  function GetFields: string;
  var
    i : Integer;
  begin
    for i := 0 to Pred(Self.Campos.Count) do
    begin
      result := result +
      Format('    F%s: %s;', [Campos[i].Nome.ToUpper, Campos[i].DelphiType]) + sLineBreak;
    end;
  end;

  function GetProperties: string;
  var
    i: Integer;
  begin
    for i := 0 to Pred(Self.Campos.Count) do
    begin
      result := result + Format(
        '    [Campo(''%0:s'')%1:s]' + sLineBreak +
        '    property %0:s: %2:s read F%0:s write F%0:s;' + sLineBreak + sLineBreak,

        [Campos[i].Nome.ToUpper,
         IfThen(Campos[i].PrimaryKey, ', Pk, AutoInc'),
         Campos[i].DelphiType]);
    end;
  end;

begin
  result :=
    'unit Model.Entity.%0:s;' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  SimpleAttributes;' + sLineBreak +
    '' + sLineBreak +
    'type' + sLineBreak +
    '  [Tabela(''%0:s'')]' + sLineBreak +
    '  T%0:s = class' + sLineBreak +
    '  private' + sLineBreak +
    '%1:s' + sLineBreak +
    '  public' + sLineBreak +
    '%2:s' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'implementation' + sLineBreak +
    '' + sLineBreak +
    'end.';

  result := Format(Result, [Self.Nome.ToUpper, GetFields, GetProperties]);
end;

{ TGeradorModeloOTAGeradorModeloCampo }

function TGeradorModeloOTAGeradorModeloCampo.DelphiType: string;
begin
  Result := 'String';
  case Self.DataType of
    ftBoolean: result := 'Boolean';

    ftSmallint,
    ftInteger,
    ftLongWord,
    ftShortint,
    ftWord      : Result := 'Integer';

    ftFloat,
    ftCurrency,
    ftExtended,
    ftBCD : Result := 'Double';

    ftDate,
    ftTimeStamp,
    ftOraTimeStamp,
    ftTime,
    ftDateTime: Result := 'TDateTime';
  end;
end;

end.
