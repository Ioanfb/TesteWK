unit uCController;

interface

uses uInterface, uCFactory;

type TCController = class(TInterfacedObject, iController)
 class function New :TCFactory;
   function Produtos   :iProdutos;
   function Clientes   :iClientes;
   function Pedido     :iPedido;
   function ItemPedido :iItemPedido;

end;

implementation



{ TCController }

function TCController.Clientes: iClientes;
begin
 result := TCFactory.New.Clientes;
end;

function TCController.ItemPedido: iItemPedido;
begin
 result := TCFactory.New.ItemPedido;
end;

class function TCController.New: TCFactory;
begin
  result := TCFactory.Create;
end;

function TCController.Pedido: iPedido;
begin
 result := TCFactory.New.Pedido;
end;

function TCController.Produtos: iProdutos;
begin
 result := TCFactory.New.Produtos;
end;

end.
