unit uCClientes;

interface

uses uInterface, FireDac.Comp.Client, SysUtils;

type  TCCLientes = class(TInterfacedObject, iClientes)
 private
   FRegistroEncontrado:Boolean;

   lSQL   :TStringBuilder;
   lQuery :TFDQUery;

   FCDCLiente :Integer;
   FNome      :String;
   FCidade    :String;
   FUF        :String;

   function Pesquisa:Boolean;

   constructor Create;
   destructor Destroy; override;
 public
   function Codigo(FVAlue:Integer):iClientes;
   function Nome(FValue:String):iClientes;
   function Cidade(FValue:String):iClientes;
   function UF(FValue:String):iClientes;

   function GetCliente:String;

   function Salva:Boolean;
end;

implementation

{ TCCLientes }

uses uDmdPrincipal;

function TCCLientes.Cidade(FValue: String): iClientes;
begin
  FCidade := FValue;
  Result  := Self;
end;

function TCCLientes.Codigo(FVAlue: Integer): iClientes;
begin
  FCDCLiente := FValue;
  Result     := Self;
end;

constructor TCCLientes.Create;
begin

end;

destructor TCCLientes.Destroy;
begin

  inherited;
end;

function TCCLientes.GetCliente: String;
begin
  try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' SELECT ');
    lSQL.Append(' NOME');
    lSQL.Append(' FROM ');
    lSQL.Append(' CLIENTES  ');
    lSQL.Append(' WHERE   ');
    lSQL.Append(' CDCLIENTE = :CDCLIENTE ');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('CDCLIENTE').AsInteger := FCDCliente;
    lQuery.Open;
    Result               := lQuery.FieldByName('NOME').AsString;

 finally
   lSQL.Free;
   lQUery.Free;
 end;
end;

function TCCLientes.Nome(FValue: String): iClientes;
begin
  FNome   := FValue;
  Result  := Self;
end;

function TCCLientes.Pesquisa: Boolean;
begin
 try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' SELECT ');
    lSQL.Append(' CDCLIENTE,');
    lSQL.Append(' NOME,');
    lSQL.Append(' CIDADE,');
    lSQL.Append(' UF ');
    lSQL.Append(' FROM ');
    lSQL.Append(' CLIENTES  ');
    lSQL.Append(' WHERE   ');
    lSQL.Append(' CDCLIENTE = :CDCLIENTE ');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('CDCLIENTE').AsInteger := FCDCliente;
    lQuery.Open;
    FRegistroEncontrado  := (not lQuery.IsEmpty);
    Result               := FRegistroEncontrado;
 finally
   lSQL.Free;
   lQUery.Free;
 end;
end;

function TCCLientes.Salva: Boolean;
begin
 try
   Pesquisa;
    lSQL   := TStringBuilder.Create;
    if not FRegistroEncontrado then
    begin
      lSQL.Append(' INSERT INTO PEDIDOS(');
      lSQL.Append(' CDCLIENTE,');
      lSQL.Append(' NOME,');
      lSQL.Append(' CIDADE,');
      lSQL.Append(' UF )');
      lSQL.Append(' VALUES (');
      lSQL.Append(' :CDCLIENTE,');
      lSQL.Append(' :NOME,');
      lSQL.Append(' :CIDADE,');
      lSQL.Append(' :UF )');
    end
    else
    begin
      lSQL.Append(' UPDATE PEDIDOS SET ');
      lSQL.Append(' NOME   = :NOME,');
      lSQL.Append(' CIDADE = :CIDADE,');
      lSQL.Append(' UF     = :UF)');
      lSQL.Append(' WHERE ');
      lSQL.Append(' CDCLIENTE = :CDCLIENTE');
    end;

    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    try
      lQUery.Connection.StartTransaction;
      lQuery.ParamByName('CDCLIENTE').AsInteger := FCDCliente;
      lQuery.ParamByName('NOME').AsString       := FNome;
      lQuery.ParamByName('CIDADE').AsString     := FCidade;
      lQuery.ParamByName('UF').AsString         := FUF;
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
//
end;

function TCCLientes.UF(FValue: String): iClientes;
begin
  FUF     := FValue;
  Result  := Self;
end;

end.
