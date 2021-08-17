unit uCItemPedido;

interface

uses uInterface, SysUtils, FireDac.Comp.Client;

type TItens = record
  NrPedido    :Integer;
  Codigo      :Integer;
  Qtde        :Extended;
  VlrUnitario :Extended;
  VlrTotal    :Extended;
end;

type TListItens = array of TItens;

type TCItemPedido = class(TInterfacedObject, iItemPedido)
private
 FRegistroEncontrado:Boolean;

  lSQL   :TStringBuilder;
  lQuery :TFDQUery;

 FListaItens  :TListItens;
 FItens       :TItens;

 function Salva:Boolean;
 function NrPedido(FValue:Integer):iItemPedido;
 function Codigo(FValue :Integer):iItemPedido;
 function Qtde(FValue:Extended):iItemPedido;
 function VlrUnitario(FValue:Extended):iItemPedido;
 function VlrTotal(FValue :Extended):iItemPedido;
 function Itens :TFDQUery;
 function Add :iItemPedido;
 function Delete:Boolean ;

 constructor Create;
 destructor Destroy;  override;


public



end;

implementation

{ TCItemPedido }

uses uDmdPrincipal;


function TCItemPedido.Add: iItemPedido;
var I:Integer;
begin
 SetLength(FListaItens, Length(FListaItens)+1);
 result := Self;
end;

function TCItemPedido.Codigo(FValue: Integer): iItemPedido;
var I :Integer;
begin
 FItens.Codigo := FValue;

 if length(FListaItens) > 0 then
 begin
  I := Length(FListaItens)-1;
  FListaItens[I].Codigo   := FValue;
 end;

 result                  := Self;
end;

constructor TCItemPedido.Create;
begin
  //
end;

function TCItemPedido.Delete:Boolean;
begin
 try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' DELETE ');
    lSQL.Append(' FROM ');
    lSQL.Append(' ITEMPEDIDO ');
    lSQL.Append(' WHERE ');
    lSQL.Append(' NRPEDIDO = :NRPEDIDO');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('NRPEDIDO').AsInteger := FItens.NrPedido;
    lQuery.ExecSQL;

     result := lQuery.RowsAffected > 0;
 finally
   lSQL.Free;
   lQUery.Free;
 end;

end;

destructor TCItemPedido.Destroy;
begin
  inherited;
end;

function TCItemPedido.Itens: TFDQUery;
begin
    try
    lSQL := TStringBuilder.Create;
    lSQL.Append(' SELECT ');
    lSQL.Append(' CDPRODUTO,');
    lSQL.Append(' QUANTIDADE,');
    lSQL.Append(' VLRUNITARIO,');
    lSQL.Append(' VLRTOTAL');
    lSQL.Append(' FROM ');
    lSQL.Append(' ITEMPEDIDO  ');
    lSQL.Append(' WHERE  ');
    lSQL.Append(' NRPEDIDO = :NRPEDIDO  ');
    lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
    lQuery.ParamByName('NRPEDIDO').AsInteger := FItens.NrPedido;
    lQuery.Open;

    result := lQuery;

 finally
   lSQL.Free;
 end;
end;

function TCItemPedido.NrPedido(FValue: Integer): iItemPedido;
var I :Integer;
begin
 FItens.NrPedido := FValue;

 if length(FListaItens) > 0 then
 begin
   I := Length(FListaItens)-1;
   FListaItens[I].NrPedido := FValue;
 end;
 result                   := Self;
end;

function TCItemPedido.Qtde(FValue: Extended): iItemPedido;
var I:Integer;
begin
 FItens.Qtde  := FValue;

 if length(FListaItens) > 0 then
 begin
   I := Length(FListaItens)-1;
   FListaItens[I].Qtde := FValue;
 end;
 result              := Self;
end;

function TCItemPedido.Salva: Boolean;
var I:Integer;
begin
  try
   lSQL := TStringBuilder.Create;
   lSQL.Append(' INSERT INTO ITEMPEDIDO ');
   lSQL.Append(' (NRPEDIDO,');
   lSQL.Append(' CDPRODUTO,');
   lSQL.Append(' QUANTIDADE,');
   lSQL.Append(' VLRUNITARIO,');
   lSQL.Append(' VLRTOTAL)');

   lSQL.Append(' VALUES ');

   lSQL.Append('(:NRPEDIDO,');
   lSQL.Append(' :CDPRODUTO,');
   lSQL.Append(' :QUANTIDADE,');
   lSQL.Append(' :VLRUNITARIO,');
   lSQL.Append(' :VLRTOTAL)');

   lQuery := dmdPrincipal.CriaQuery(lSQL.ToString);
   lQuery.Params.ArraySize := Length(FListaItens);

    for I := 0 to Pred(Length(FListaItens)) do
    begin
     lQuery.ParamByName('NRPEDIDO').AsIntegers[i]     := FListaItens[i].NrPedido;
     lQuery.ParamByName('CDPRODUTO').AsIntegers[i]    := FListaItens[i].Codigo;
     lQuery.ParamByName('QUANTIDADE').AsFloats[i]     := FListaItens[i].Qtde;
     lQuery.ParamByName('VLRUNITARIO').AsCurrencys[i] := FListaItens[i].VlrUnitario;
     lQuery.ParamByName('VLRTOTAL').AsCurrencys[i]    := FListaItens[i].VlrTotal;
    end;
    
    try
     lQuery.Connection.StartTransaction;
     lQuery.Execute(lQuery.Params.ArraySize, 0); 
     lQuery.Connection.Commit;
    except on E: Exception do
     lQuery.Connection.Rollback;
    end;    

  finally
   lSQL.Free;
  end;
end;

function TCItemPedido.VlrTotal(FValue: Extended): iItemPedido;
var I:Integer;
begin
 FItens.VlrTotal := FValue;

 if length(FListaItens) > 0 then
 begin
   I  := Length(FListaItens)-1;
   FListaItens[I].VlrTotal := FValue;
 end;
 result                  := Self;
end;

function TCItemPedido.VlrUnitario(FValue: Extended): iItemPedido;
VAR i:Integer;
begin
 FItens.VlrUnitario := FValue;

 if length(FListaItens) > 0 then
 begin
   I  := Length(FListaItens)-1;
   FListaItens[I].VlrUnitario := FValue;
 end;
 result    := Self;
end;

end.
