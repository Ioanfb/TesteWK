unit uCProdutos;

interface

uses uInterface, FireDac.Comp.Client, SysUtils;

type TCProdutos = class(TInterfacedObject, iProdutos)
 private
  FRegistroEncontrado:Boolean;

  lSQL   :TStringBuilder;
  lQuery :TFDQUery;

  FCDProduto :Integer;
  FDescricao :String;
  FVlrVenda  :Extended;

  constructor Create;
  destructor Destroy; override;

  function   Pesquisa:boolean;
 public
  function Codigo(FValue:Integer):iProdutos;
  function Descricao(FValue:String):iProdutos;
  function VlrVenda(FValue:Extended):iProdutos;
  function GetProduto:String;
  function Salva :Boolean;
end;

implementation


{ TCProdutos }

uses uDmdPrincipal;

function TCProdutos.Codigo(FValue: Integer): iProdutos;
begin
  FCDProduto := FValue;
  Result     := Self;
end;

constructor TCProdutos.Create;
begin

end;

function TCProdutos.Descricao(FValue: String): iProdutos;
begin
  FDescricao := FValue;
  Result     := Self;
end;

destructor TCProdutos.Destroy;
begin

  inherited;
end;

function TCProdutos.GetProduto: String;
begin
  try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' SELECT ');
    lSQL.Append(' DESCRICAO ');
    lSQL.Append(' FROM ');
    lSQL.Append(' PRODUTOS  ');
    lSQL.Append(' WHERE   ');
    lSQL.Append(' CDPRODUTO = :CDPRODUTO ');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('CDPRODUTO').AsInteger := FCDProduto;
    lQuery.Open;
    Result               := lQuery.FieldByName('DESCRICAO').AsString;
 finally
   lSQL.Free;
   lQUery.Free;
 end;
end;

function TCProdutos.Pesquisa: boolean;
begin
 try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' SELECT ');
    lSQL.Append(' CDPRODUTO,');
    lSQL.Append(' DESCRICAO,');
    lSQL.Append(' VLRVENDA ');
    lSQL.Append(' FROM ');
    lSQL.Append(' PRODUTOS  ');
    lSQL.Append(' WHERE   ');
    lSQL.Append(' CDPRODUTO = :CDPRODUTO ');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('CDPRODUTO').AsInteger := FCDProduto;
    lQuery.Open;
    FRegistroEncontrado  := (not lQuery.IsEmpty);
    Result               := FRegistroEncontrado;
 finally
   lSQL.Free;
   lQUery.Free;
 end;
end;

function TCProdutos.Salva: Boolean;
begin
 try
  Pesquisa;
  lSQL   := TStringBuilder.Create;
  if not FRegistroEncontrado then
  begin
    lSQL.Append(' INSERT INTO PRODUTOS(');
    lSQL.Append(' CDPRODUTO,');
    lSQL.Append(' DESCRICAO,');
    lSQL.Append(' VLRVENDA)');
    lSQL.Append(' VALUES (');
    lSQL.Append(' :CDPRODUTO,');
    lSQL.Append(' :DESCRICAO,');
    lSQL.Append(' :VLRVENDA)');
  end
  else
  begin
    lSQL.Append(' UPDATE PRODUTOS SET ');
    lSQL.Append(' DESCRICAO = :DESCRICAO,');
    lSQL.Append(' VLRVENDA = :VLRVENDA,');
    lSQL.Append(' WHERE ');
    lSQL.Append(' CDPRODUTO = :CDPRODUTO');
  end;

    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);

    lQuery.ParamByName('CDPRODUTO').AsInteger := FCDProduto;
    lQuery.ParamByName('DESCRICAO').AsString  := FDescricao;
    lQuery.ParamByName('VLRVENDA').AsExtended := FVlrVenda;

  try
    lQuery.Connection.StartTransaction;
    lQuery.ExecSQL;

    if FRegistroEncontrado then
    if lQuery.RowsAffected > 1 then
    raise Exception.Create('Mais de um registro Afetado');

    lQuery.Connection.Commit;
  except on E: Exception do
   begin
     dmdPrincipal.TrataExeption(Self, E);
     lQuery.Connection.Rollback;
   end;
  end;

 finally
   lSQL.Free;
   lQUery.Free;
 end;
end;

function TCProdutos.VlrVenda(FValue: Extended): iProdutos;
begin
  FVlrVenda := FValue;
  Result    := Self;
end;

end.
