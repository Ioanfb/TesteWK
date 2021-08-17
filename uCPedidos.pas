unit uCPedidos;

interface

uses uInterface, FireDac.Comp.Client, SysUtils;

type TCPedidos = class(TInterfacedObject, iPedido)
 private
  FRegistroEncontrado:Boolean;

  lSQL   :TStringBuilder;
  lQuery :TFDQUery;

  FNrPedido   :Integer;
  FDtEmissao  :TDate;
  FCOdCliente :Integer;
  FVLrTotal   :Extended;

  function Pesquisa:Boolean;

  constructor Create;
  destructor  Destroy; override;
 public
  function NrPedido(FValue:Integer):iPedido;
  function DtEmissao(FValue:TDate):iPedido;
  function CodCliente(FValue:Integer):iPedido;
  function VlrTotal(FValue:Extended):iPedido;
  function GetCodCliente: Integer;
  function GeraNrPedido:Integer;
  function Salva :Boolean;
  procedure Delete;
end;
implementation

{ TCPedidos }

uses uCController, uDmdPrincipal, uClasseBase;

function TCPedidos.CodCliente(FValue: Integer): iPedido;
begin
  FCodCliente := FValue;
  result      := Self;
end;

constructor TCPedidos.Create;
begin

end;

procedure TCPedidos.Delete;
begin
 try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' DELETE ');
    lSQL.Append(' FROM ');
    lSQL.Append(' PEDIDOS ');
    lSQL.Append(' WHERE ');
    lSQL.Append(' NRPEDIDO = :NRPEDIDO');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('NRPEDIDO').AsInteger := FNrPedido;
    lQuery.ExecSQL;
 finally
   lSQL.Free;
   lQUery.Free;
 end;

end;

destructor TCPedidos.Destroy;
begin

  inherited;
end;

function TCPedidos.DtEmissao(FValue: TDate): iPedido;
begin
 FDtEmissao := FValue;
 result     := Self;
end;

function TCPedidos.GeraNrPedido: Integer;
begin
  FNrPedido :=  TClasseBase.GeraCodigo('NRPEDIDO', 'PEDIDOS', '');
  Result    :=  FNrPedido;
end;

function TCPedidos.GetCodCliente: Integer;
begin
  try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' SELECT ');
    lSQL.Append(' CDCLIENTE');
    lSQL.Append(' FROM ');
    lSQL.Append(' PEDIDOS ');
    lSQL.Append(' WHERE  ');
    lSQL.Append(' NRPEDIDO = :NRPEDIDO  ');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('NRPEDIDO').AsInteger := FNrPedido;
    lQuery.Open;

    result := lQuery.FieldByName('CDCLIENTE').AsInteger;
 finally
   lSQL.Free;
   lQUery.Free;
 end;
end;

function TCPedidos.NrPedido(FValue: Integer): iPedido;
begin
  FNrPedido := FValue;
  Result    := Self;
end;

function TCPedidos.Pesquisa: Boolean;
begin
 try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' SELECT ');
    lSQL.Append(' NRPEDIDO,');
    lSQL.Append(' DTEMISSAO,');
    lSQL.Append(' CDCLIENTE');
    lSQL.Append(' VLRTOTAL');
    lSQL.Append(' FROM ');
    lSQL.Append(' PEDIDOS ');
    lSQL.Append(' WHERE  ');
    lSQL.Append(' NRPEDIDO = :NRPEDIDO  ');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('NRPEDIDO').AsInteger := FNrPedido;
    lQuery.Open;
    FRegistroEncontrado  := (not lQuery.IsEmpty);
    Result               := FRegistroEncontrado;
 finally
   lSQL.Free;
   lQUery.Free;
 end;
end;

function TCPedidos.Salva: Boolean;
begin
 try
  Pesquisa;
  lSQL   := TStringBuilder.Create;
  if not FRegistroEncontrado then
  begin
    lSQL.Append(' INSERT INTO PEDIDOS(');
    lSQL.Append(' NRPEDIDO,');
    lSQL.Append(' DTEMISSAO,');
    lSQL.Append(' CDCLIENTE,');
    lSQL.Append(' VLRTOTAL)');
    lSQL.Append(' VALUES (');
    lSQL.Append(' :NRPEDIDO,');
    lSQL.Append(' :DTEMISSAO,');
    lSQL.Append(' :CDCLIENTE,');
    lSQL.Append(' :VLRTOTAL)');
  end
  else
  begin
    lSQL.Append(' UPDATE PEDIDOS SET ');
    lSQL.Append(' DTEMISSAO = :DTEMISSAO,');
    lSQL.Append(' CDCLIENTE = :CDCLIENTE,');
    lSQL.Append(' VLRTOTAL  = :VLRTOTAL');
    lSQL.Append(' WHERE ');
    lSQL.Append(' NRPEDIDO = :NRPEDIDO');
  end;

    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);

    lQuery.ParamByName('NRPEDIDO').AsInteger  := FNrPedido;
    lQuery.ParamByName('DTEMISSAO').AsDate    := FDtEmissao;
    lQuery.ParamByName('CDCLIENTE').AsInteger := FCOdCliente;
    lQuery.ParamByName('VLRTOTAL').AsExtended := FVLrTotal;

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

function TCPedidos.VlrTotal(FValue: Extended): iPedido;
begin
   FVLrTotal := FValue;
   Result    := Self;
end;

end.
