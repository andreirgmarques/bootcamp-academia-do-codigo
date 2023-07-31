unit GeradorModeloOTA.NovoProjeto.Files;

interface

uses
  System.SysUtils, System.Classes, GeradorModeloOTA.NovoProjeto.Model;

type
  TGeradorModeloOTANovoProjetoFiles = class
  public
    class function CreateUnitConnection(ADados: TGeradorModeloOTANovoProjetoModel): String;
    class function CreateUnitDAOGeneric(ADados: TGeradorModeloOTANovoProjetoModel): String;
  end;


implementation

{ TGeradorModeloOTANovoProjetoFiles }

class function TGeradorModeloOTANovoProjetoFiles.CreateUnitConnection(
  ADados: TGeradorModeloOTANovoProjetoModel): String;
var
  LContent: TStringList;
begin
  Result := ADados.DiretorioConnection + 'Model.Connection.pas';
  LContent := TStringList.Create;
  try
    LContent.Add('unit Model.Connection;         ');
    LContent.Add('                               ');
    LContent.Add('interface                      ');
    LContent.Add('                               ');
    LContent.Add('uses                           ');
    LContent.Add('  System.JSON,                 ');
    LContent.Add('  FireDAC.Stan.Intf,           ');
    LContent.Add('  FireDAC.Stan.Option,         ');
    LContent.Add('  FireDAC.Stan.Error,          ');
    LContent.Add('  FireDAC.UI.Intf,             ');
    LContent.Add('  FireDAC.Phys.Intf,           ');
    LContent.Add('  FireDAC.Stan.Def,            ');
    LContent.Add('  FireDAC.Stan.Pool,           ');
    LContent.Add('  FireDAC.Stan.Async,          ');
    LContent.Add('  FireDAC.Phys,                ');
    LContent.Add('  FireDAC.Comp.Client,         ');
    LContent.Add('  FireDAC.Phys.PGDef,          ');
    LContent.Add('  FireDAC.Phys.PG,             ');
    LContent.Add('  System.Generics.Collections; ');
    LContent.Add('                               ');
    LContent.Add('var                            ');
    LContent.Add('  FDriver: TFDPhysPgDriverLink; ');
    LContent.Add('  FConnList: TObjectList<TFDConnection>; ');
    LContent.Add('                               ');
    LContent.Add('function Connected: Integer;  ');
    LContent.Add('procedure Disconnected(AIndex: Integer); ');
    LContent.Add('                               ');
    LContent.Add('implementation                 ');
    LContent.Add('                               ');
    LContent.Add('function Connected: Integer;   ');
    LContent.Add('begin                          ');
    LContent.Add('  if not Assigned(FConnList) then ');
    LContent.Add('    FConnList := TObjectList<TFDConnection>.Create; ');
    LContent.Add('  FConnList.Add(TFDConnection.Create(nil));         ');
    LContent.Add('  Result := Pred(FConnList.Count);                  ');
    LContent.Add('  FConnList.Items[Result].Params.DriverID := ''PG''; ');
    LContent.Add('  FConnList.Items[Result].Params.Database := ''DBNEGOCIOSMT''; ');
    LContent.Add('  FConnList.Items[Result].Params.UserName := ''fontdata'';  ');
    LContent.Add('  FConnList.Items[Result].Params.Password := ''FDTI1252''; ');
    LContent.Add('  FConnList.Items[Result].Params.Add(''Port=5432'');    ');
    LContent.Add('  FConnList.Items[Result].Params.Add(''CharacterSet=utf8''); ');
    LContent.Add('  FConnList.Items[Result].Params.Add(''Server=localhost'');  ');
    LContent.Add('  FConnList.Items[Result].Connected       := True;      ');
    LContent.Add('end;                           ');
    LContent.Add('                               ');
    LContent.Add('procedure Disconnected(AIndex: Integer); ');
    LContent.Add('begin                          ');
    LContent.Add('  FConnList.Items[AIndex].Connected := False; ');
    LContent.Add('  FConnList.Items[AIndex].Free;                ');
    LContent.Add('  FConnList.TrimExcess;        ');
    LContent.Add('end;                           ');
    LContent.Add('                               ');
    LContent.Add('end.                           ');
    LContent.SaveToFile(Result);
  finally
    LContent.Free;
  end;
end;

class function TGeradorModeloOTANovoProjetoFiles.CreateUnitDAOGeneric(
  ADados: TGeradorModeloOTANovoProjetoModel): String;
var
  content : string;
begin
  result := ADados.DiretorioConnection + 'Model.DAO.Generic.pas';
  content :=
    'unit Model.DAO.Generic;' + sLineBreak +
    '' + sLineBreak +
    'interface' + sLineBreak +
    '' + sLineBreak +
    'uses' + sLineBreak +
    '  System.JSON,' + sLineBreak +
    '  REST.Json,' + sLineBreak +
    '  SimpleInterface,' + sLineBreak +
    '  SimpleDAO,' + sLineBreak +
    '  SimpleAttributes,' + sLineBreak +
    '  SimpleQueryFiredac,' + sLineBreak +
    '  Data.DB,' + sLineBreak +
    '  DataSetConverter4D,' + sLineBreak +
    '  DataSetConverter4D.Impl,' + sLineBreak +
    '  DataSetConverter4D.Helper,' + sLineBreak +
    '  DataSetConverter4D.Util;' + sLineBreak +
    '' + sLineBreak +
    'type' + sLineBreak +
    '' + sLineBreak +
    '  iDAOGeneric<T : Class> = interface' + sLineBreak +
    '    [''%0:s'']' + sLineBreak +
    '    function Find : TJsonArray; overload;' + sLineBreak +
    '    function Find (const aID : String; var aObject : T ) : iDAOGeneric<T>; overload;' + sLineBreak +
    '    function Find (const aID : String ) : TJsonObject; overload;' + sLineBreak +
    '    function Insert (const aJsonObject : TJsonObject) : TJsonObject;' + sLineBreak +
    '    function Update (const aJsonObject : TJsonObject) : TJsonObject; overload;' + sLineBreak +
    '    function Update (const aObject : T) : iDAOGeneric<T>; overload;' + sLineBreak +
    '    function Delete (aField : String; aValue : String) : TJsonObject;' + sLineBreak +
    '    function DAO : ISimpleDAO<T>;' + sLineBreak +
    '    function DataSetAsJsonArray : TJsonArray;' + sLineBreak +
    '    function DataSetAsJsonObject : TJsonObject;' + sLineBreak +
    '    function DataSet : TDataSet;' + sLineBreak +
    '  end;' + sLineBreak +
    '' + sLineBreak +
    '  TDAOGeneric<T : class, constructor> = class(TInterfacedObject, iDAOGeneric<T>)' + sLineBreak +
    '  private ' + sLineBreak +
    '    FIndexConn : Integer;' + sLineBreak +
    '    FConn : iSimpleQuery;' + sLineBreak +
    '    FDAO : iSimpleDAO<T>;' + sLineBreak +
    '    FDataSource : TDataSource;' + sLineBreak +
    '  public' + sLineBreak +
    '    constructor Create;' + sLineBreak +
    '    destructor Destroy; override;' + sLineBreak +
    '    class function New : iDAOGeneric<T>;' + sLineBreak +
    '    function Find : TJsonArray; overload;' + sLineBreak +
    '    function Find (const aID : String; var aObject : T ) : iDAOGeneric<T>; overload;' + sLineBreak +
    '    function Find (const aID : String ) : TJsonObject; overload;' + sLineBreak +
    '    function Insert (const aJsonObject : TJsonObject) : TJsonObject;' + sLineBreak +
    '    function Update (const aJsonObject : TJsonObject) : TJsonObject; overload;' + sLineBreak +
    '    function Update (const aObject : T) : iDAOGeneric<T>; overload;' + sLineBreak +
    '    function Delete (aField : String; aValue : String) : TJsonObject;' + sLineBreak +
    '    function DAO : ISimpleDAO<T>;' + sLineBreak +
    '    function DataSetAsJsonArray : TJsonArray;' + sLineBreak +
    '    function DataSetAsJsonObject : TJsonObject;' + sLineBreak +
    '    function DataSet : TDataSet;' + sLineBreak +
    '  end;' + sLineBreak +
    '' + sLineBreak +
    'implementation' + sLineBreak +
    '' + sLineBreak +
    '{ TDAOGeneric<T> }' + sLineBreak +
    '' + sLineBreak +
    'uses Model.Connection, System.SysUtils;' + sLineBreak +
    '' + sLineBreak +
    'constructor TDAOGeneric<T>.Create;' + sLineBreak +
    'begin' + sLineBreak +
    '  FDataSource := TDataSource.Create(nil);' + sLineBreak +
    '  FIndexConn := Model.Connection.Connected;' + sLineBreak +
    '  FConn := TSimpleQueryFiredac.New(Model.Connection.FConnList.Items[FIndexConn]);' + sLineBreak +
    '  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.DAO: ISimpleDAO<T>;' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := FDAO;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.DataSet: TDataSet;' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := FDataSource.DataSet;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.DataSetAsJsonArray: TJsonArray;' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := FDataSource.DataSet.AsJSONArray;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.DataSetAsJsonObject: TJsonObject;' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := FDataSource.DataSet.AsJSONObject;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.Delete(aField, aValue: String): TJsonObject;' + sLineBreak +
    'begin' + sLineBreak +
    '  FDAO.Delete(aField, aValue);' + sLineBreak +
    '  Result := FDataSource.DataSet.AsJSONObject;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'destructor TDAOGeneric<T>.Destroy;' + sLineBreak +
    'begin' + sLineBreak +
    '  FDataSource.Free;' + sLineBreak +
    '  Model.Connection.Disconnected(FIndexConn);' + sLineBreak +
    '  inherited;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.Find(const aID: String; var aObject: T): iDAOGeneric<T>;' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := Self;' + sLineBreak +
    '  aObject := FDAO.Find(StrToInt(aID));' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.Find(const aID: String): TJsonObject;' + sLineBreak +
    'begin' + sLineBreak +
    '  FDAO.Find(StrToInt(aID));' + sLineBreak +
    '  Result := FDataSource.DataSet.AsJSONObject;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.Find: TJsonArray;' + sLineBreak +
    'begin' + sLineBreak +
    '  FDAO.Find;' + sLineBreak +
    '  Result := FDataSource.DataSet.AsJSONArray;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.Insert(const aJsonObject: TJsonObject): TJsonObject;' + sLineBreak +
    'begin' + sLineBreak +
    '  FDAO.Insert(TJson.JsonToObject<T>(aJsonObject));' + sLineBreak +
    '  Result := FDataSource.DataSet.AsJSONObject;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'class function TDAOGeneric<T>.New: iDAOGeneric<T>;' + sLineBreak +
    'begin' + sLineBreak +
    '  Result := Self.Create;' + sLineBreak +
    'end;' + sLineBreak +
    '                    ' + sLineBreak +
    'function TDAOGeneric<T>.Update(const aJsonObject: TJsonObject): TJsonObject;' + sLineBreak +
    'begin' + sLineBreak +
    '  FDAO.Update(TJson.JsonToObject<T>(aJsonObject));' + sLineBreak +
    '  Result := FDataSource.DataSet.AsJSONObject;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'function TDAOGeneric<T>.Update(const aObject: T): iDAOGeneric<T>;' + sLineBreak +
    'begin' + sLineBreak +
    '  FDAO.Update(aObject);' + sLineBreak +
    '  Result := Self;' + sLineBreak +
    'end;' + sLineBreak +
    '' + sLineBreak +
    'end.';
  with TStringList.Create do
  begin
    Text := Format( content, [TGuid.NewGuid.ToString] );
    SaveToFile(result);
    Free;
  end;
end;

end.
