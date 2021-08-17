unit uCFactory;

interface

uses uInterface;

type TCFactory = class(TInterfacedObject, iFactory)
  class function New : TCFactory;

  function Produtos   :iProdutos;
  function Clientes   :iClientes;
  function Pedido     :iPedido;
  function ItemPedido :iItemPedido;
end;

implementation


{ TCFactory }

uses uCProdutos, uCClientes, uCPedidos, uCItemPedido;

function TCFactory.Clientes: iClientes;
begin
 result := TCCLientes.Create;
end;

function TCFactory.ItemPedido: iItemPedido;
begin
 result := TCItemPedido.Create;
end;

class function TCFactory.New: TCFactory;
begin
  result := Self.Create;
end;

function TCFactory.Pedido: iPedido;
begin
  result :=  TCPedidos.Create
end;

function TCFactory.Produtos: iProdutos;
begin
 result := TCProdutos.Create;
end;

end.
