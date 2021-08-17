unit uInterface;

interface

uses FireDac.Comp.Client;


type iItemPedido = interface
 ['{E111EEE2-58B3-4879-A000-B62097FB91AF}']


 function NrPedido(FValue:Integer):iItemPedido;
 function Codigo(FValue :Integer):iItemPedido;
 function Qtde(FValue:Extended):iItemPedido;
 function VlrUnitario(FValue:Extended):iItemPedido;
 function VlrTotal(FValue :Extended):iItemPedido;
 function Add :iItemPedido;
 function Delete :Boolean;
 function Itens :TFDQUery;


 function Salva:Boolean;
end;

type iPedido = interface
  ['{A8B660DB-1CBF-42FE-BE82-137EBAAF5623}']
  function NrPedido(FValue:Integer)  :iPedido;
  function DtEmissao(FValue:TDate)   :iPedido;
  function CodCliente(FValue:Integer):iPedido;
  function VlrTotal(FValue:Extended) :iPedido;
  function GetCodCliente :Integer;
  function GeraNrPedido  :Integer;
  procedure Delete;

  function Salva:Boolean;
end;

type iClientes = interface
 ['{842094D4-E1DB-476B-8A24-81D18BC50C87}']
  function Codigo(FVAlue:Integer):iClientes;
  function Nome(FValue:String)   :iClientes;
  function Cidade(FValue:String) :iClientes;
  function UF(FValue:String)     :iClientes;
  function GetCliente            :String;
  function Salva:Boolean;
end;

type iProdutos = interface
  ['{613BE59F-4ED7-4343-9EC6-044B5779D4C2}']
  function Codigo(FValue:Integer):iProdutos;
  function Descricao(FValue:String):iProdutos;
  function VlrVenda(FValue:Extended):iProdutos;
  function GetProduto:String;

  function Salva :Boolean;
end;

type iFactory = interface
  ['{E5E03BE7-C5DC-4F22-8BD0-CA17B3502419}']
  function Produtos   :iProdutos;
  function Clientes   :iClientes;
  function Pedido     :iPedido;
  function ItemPedido :iItemPedido;

end;

type iController = interface
  ['{12757AC5-1938-4A21-B5FD-8849CA5DA821}']
  function Produtos   :iProdutos;
  function Clientes   :iClientes;
  function Pedido     :iPedido;
  function ItemPedido :iItemPedido;
end;

implementation


end.
