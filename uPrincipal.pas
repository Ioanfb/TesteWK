unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFormBase, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param,Vcl.Mask, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, FireDac.Dapt, uInterface, uCController, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

 type TDadosPedido = record
   UltCodLido      :Integer;
   NrPedido        :Integer;
   TotalAtualizado :Extended;
   CodCliente      :Integer;
   CliIdentificado :Boolean;
   Editando        :Boolean;

   procedure Clear;

 end;

type
  TfrmPrincipal = class(TfrmBase)
    gdProdutos: TDBGrid;
    edtDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtQtde: TEdit;
    Label3: TLabel;
    edtVlrUn: TEdit;
    fdProdutos: TFDMemTable;
    fdProdutosCDPRODUTO: TIntegerField;
    fdProdutosDESCRICAO: TStringField;
    fdProdutosVLRUNITARIO: TCurrencyField;
    fdProdutosQTDE: TFloatField;
    fdProdutosVLRTOTAL: TCurrencyField;
    dtsProdutos: TDataSource;
    btnGravaItem: TButton;
    edtTotalPedido: TEdit;
    Label6: TLabel;
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure gdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fdProdutosBeforePost(DataSet: TDataSet);
    procedure btnGravaItemClick(Sender: TObject);
    procedure edtDescricaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure fdProdutosAfterDelete(DataSet: TDataSet);
    procedure edtCodClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtDestrycricaoExit(Sender: TObject);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodClienteChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBuscaPedidoClick(Sender: TObject);

  private
   Produto    :iProdutos;
   Cliente    :iClientes;
   Pedido     :iPedido;
   ItemPedido :iItemPedido;


   PedidoAtual :TDadosPedido;
   procedure SolicitaAlteracao;
   procedure IncluiItem;
   procedure AtualizaTotal;
   procedure DeletaItem;
   procedure BuscaCliente;
   procedure BuscaPedido;
   procedure BuscaProduto;
   procedure TrataBuscaProduto;
   procedure SalvaPedido;
   procedure ValidaCliente;
   procedure TrataExlcusaoPedido;
   procedure CarregaItens;
   procedure InicializaRegistros(lNovoPedido:Boolean = True);

    { Interfaces }


    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uDmdPrincipal;


{ TfrmPrincipal }

procedure TfrmPrincipal.AtualizaTotal;
var lTotal :Currency;
begin
  lTotal := 0;

  dtsProdutos.Enabled := False;
  fdProdutos.First;
  while not fdProdutos.Eof do
  begin
    fdProdutos.Edit;
    lTotal := lTotal + fdProdutosVLRTOTAL.AsCurrency;
    fdProdutos.Next;
  end;

  fdProdutos.First;
  dtsProdutos.Enabled := True;

  edtTotalPedido.AsCurrency   := lTotal;
  PedidoAtual.TotalAtualizado := edtTotalPedido.AsCurrency;
end;

procedure TfrmPrincipal.btnBuscaPedidoClick(Sender: TObject);
begin
  inherited;
  BuscaPedido;
end;

procedure TfrmPrincipal.btnCancelarClick(Sender: TObject);
begin
  inherited;
 TrataExlcusaoPedido;
end;

procedure TfrmPrincipal.btnGravaItemClick(Sender: TObject);
begin
  inherited;
  try
    if PedidoAtual.Editando then
    begin
      fdProdutos.Post;
      gdProdutos.ReadOnly := True;
    end
    else
    begin
      ValidaCampos;
      IncluiItem;
    end;
  finally
    AtualizaTotal;
    InicializaRegistros(False);
    edtDescricao.SetFocus;
  end;
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
begin
  inherited;
  ValidaCliente;
  SalvaPedido;
  InicializaRegistros;
end;

procedure TfrmPrincipal.BuscaCliente;
begin
 Cliente := TCController.New.Clientes;
 edtNomeCliente.Text := Cliente
                        .Codigo(edtCodCliente.AsInteger)
                        .GetCliente;
                                 
  PedidoAtual.CliIdentificado := Trim(edtNomeCliente.Text) <> EmptyStr;                      
  PedidoAtual.CodCliente      := edtCodCliente.AsInteger;
end;

procedure TfrmPrincipal.BuscaPedido;
var lNumPedido:String;
    lQuery    :TFDQuery;
begin
  try
    Pedido     := TCController.New.Pedido;
    Cliente    := TCController.New.Clientes;
    ItemPedido := TCcontroller.New.ItemPedido;
    Produto    := TCController.New.Produtos;

    lNumPedido := InputBox('Pesquisa', 'Informe o número do pedido que deseja buscar', '');

    if Trim(lNumPedido) = EmptyStr then
    begin
      Erro('Operação cancelada');
      Exit;
    end;

    Pedido.NrPedido(StrToInt(lNumPedido));

    edtCodCliente.AsInteger := Pedido.GetCodCliente;

    edtNomeCliente.Text := Cliente
                          .Codigo(edtCodCliente.AsInteger)
                          .GetCliente;

    PedidoAtual.CodCliente      := edtCodCliente.AsInteger;
    PedidoAtual.CliIdentificado := True;

    ItemPedido
    .NrPedido(StrToInt(lNumPedido))
    .Itens;

    lQuery := ItemPedido.Itens;

    lQuery.First;

    fdProdutos.Close;
    fdProdutos.CreateDataSet;
    while not lQuery.Eof do
    begin
      fdProdutos.Open;
      fdProdutos.Insert;
      fdProdutosCDPRODUTO.AsInteger    := lQuery.FieldByName('CDPRODUTO').AsInteger;
      fdProdutosDESCRICAO.AsString     := Produto.Codigo(fdProdutosCDPRODUTO.AsInteger).GetProduto;
      fdProdutosVLRUNITARIO.AsCurrency := lQuery.FieldByName('VLRUNITARIO').AsCurrency;
      fdProdutosQTDE.AsFloat           := lQuery.FieldByName('QUANTIDADE').AsFloat;
      fdProdutosVLRTOTAL.AsCurrency    := lQuery.FieldByName('VLRTOTAL').AsCurrency;
      fdProdutos.Post;
      lQuery.Next
    end;

    AtualizaTotal;

  finally
    lQuery.Free;
  end;
end;

procedure TfrmPrincipal.BuscaProduto;
begin

Produto                := TCController.New.Produtos;
PedidoAtual.UltCodLido := edtDescricao.AsInteger;

edtDescricao.Text := Produto
                    .Codigo(edtDescricao.AsInteger)
                    .GetProduto;
end;

procedure TfrmPrincipal.CarregaItens;
var I:Integer;
begin
  ItemPedido := TCController.New.ItemPedido;

//  for I := 0 to ItemPedido.Lista do



end;

procedure TfrmPrincipal.DeletaItem;
begin
  fdProdutos.Delete;
end;

procedure TfrmPrincipal.edtCodClienteChange(Sender: TObject);
begin
  inherited;
  btnCancelar.Visible    := Length(Trim(edtCodCliente.Text)) = 0;
  btnBuscaPedido.Visible := Length(Trim(edtCodCliente.Text)) = 0;
end;

procedure TfrmPrincipal.edtCodClienteExit(Sender: TObject);
var lInt :Integer;
begin
  inherited;
  if TryStrToInt(edtCodCliente.Text, lInt) then
  BuscaCliente;
  
end;

procedure TfrmPrincipal.edtCodClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = VK_RETURN ) then
  if Trim(edtCodCliente.Text)<> EmptyStr then
  BuscaCliente;
end;

procedure TfrmPrincipal.edtDestrycricaoExit(Sender: TObject);
var lInt :Integer;
begin
  inherited;
   
   if TryStrToInt(edtDescricao.Text, lInt) then
   TrataBuscaProduto;
end;

procedure TfrmPrincipal.edtDescricaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = VK_RETURN ) then
  TrataBuscaProduto;

end;

procedure TfrmPrincipal.fdProdutosAfterDelete(DataSet: TDataSet);
begin
  inherited;
  AtualizaTotal;
end;

procedure TfrmPrincipal.fdProdutosBeforePost(DataSet: TDataSet);
begin
  inherited;
  fdProdutosVLRTOTAL.AsCurrency := fdProdutosVLRUNITARIO.AsExtended * fdProdutosQTDE.AsFloat;

end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   if key = VK_DOWN then      
   gdProdutos.SetFocus;
end;



procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  inherited;
  InicializaRegistros;
  ModoForm := _mdEdicao;
  edtDescricao.SetFocus;

end;

procedure TfrmPrincipal.gdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_DELETE then
  if SimNao('Confirma a exclusão do item selecionado?') then
  DeletaItem;

  if key = VK_RETURN then
  if gdProdutos.SelectedIndex in [2,3] then
  SolicitaAlteracao;
end;

procedure TfrmPrincipal.IncluiItem;
begin
  fdProdutos.Open;
  fdProdutos.Insert;
  fdProdutosCDPRODUTO.AsInteger    := PedidoAtual.UltCodLido;
  fdProdutosDESCRICAO.AsString     := edtDescricao.Text;
  fdProdutosVLRUNITARIO.AsCurrency := edtVlrUn.AsCurrency;
  fdProdutosQTDE.AsFloat           := edtQtde.AsExtended;
  fdProdutos.Post;
end;

procedure TfrmPrincipal.InicializaRegistros(lNovoPedido:Boolean);
begin
  
  edtDescricao.Clear;
  edtQtde.Clear;
  edtVlrUn.Clear;
  if lNovoPedido then
  begin
    edtTotalPedido.Clear;
    fdProdutos.Close;
    fdProdutos.CreateDataSet;
    PedidoAtual.Clear;
    edtCodCliente.Clear;
    edtNomeCliente.Clear;
  end;
  edtDescricao.SetFocus;
end;

procedure TfrmPrincipal.SalvaPedido;
begin
 try
   dmdPrincipal.fdTransaction.StartTransaction;

   Pedido               := TCController.New.Pedido;
   PedidoAtual.NrPedido :=  Pedido.GeraNrPedido;
 
    Pedido
   .DtEmissao(Date)
   .CodCliente(PedidoAtual.CodCliente)
   .VlrTotal(PedidoAtual.TotalAtualizado)
   .Salva;

   ItemPedido := TCController.New.ItemPedido;
   fdProdutos.First;
   while not fdProdutos.Eof do
   begin
     fdProdutos.Edit;
     ItemPedido
     .Add
     .NrPedido(PedidoAtual.NrPedido)
     .Codigo(fdProdutosCDPRODUTO.AsInteger)
     .Qtde(fdProdutosQTDE.AsFloat)
     .VlrUnitario(fdProdutosVLRUNITARIO.AsCurrency)
     .VlrTotal(fdProdutosVLRTOTAL.AsCurrency);
     fdProdutos.Next;
   end;

   ItemPedido.Salva; 
   dmdPrincipal.fdTransaction.Commit;
       
   Informa('Pedido '+IntToStr(PedidoAtual.NrPedido)+' salvo com sucesso!');
     
 except on E: Exception do
    dmdPrincipal.fdTransaction.Rollback;
 end;  
end;

procedure TfrmPrincipal.SolicitaAlteracao;
begin
 gdProdutos.ReadOnly      := False;
 PedidoAtual.Editando     := True;
end;

procedure TfrmPrincipal.TrataBuscaProduto;
begin
    if Trim(edtDescricao.Text)<> EmptyStr then
    BuscaProduto;

    if Trim(edtDescricao.Text) <> EmptyStr then
    edtQtde.SetFocus
    else
    begin
     Alerta('Item não localizado!');
     edtDescricao.SetFocus;
    end;
end;

procedure TfrmPrincipal.TrataExlcusaoPedido;
var lNumPedido :String;
    lDeletou :Boolean;
begin

 lNumPedido := InputBox('Cancelamento', 'Informe o número do pedido à ser cancelado', '');

 if Trim(lNumPedido) = EmptyStr then
 begin
   Erro('Operação cancelada');
   Exit;
 end;

 try 
   dmdPrincipal.fdTransaction.StartTransaction;
   ItemPedido := TCController.New.ItemPedido;
   Pedido     := TCController.New.Pedido;
   

   lDeletou :=
    ItemPedido
   .NrPedido(StrToInt(lNumPedido))
   .Delete;

   if not lDeletou then
   begin
     Alerta('Pedido não localizado');
     Abort;
   end;


   Pedido
   .NrPedido(StrToInt(lNumPedido))
   .Delete;
   
   dmdPrincipal.fdTransaction.Commit; 

   Informa('Exclusão realizada com sucesso!');
 except on E: Exception do
   dmdPrincipal.fdTransaction.Rollback; 
 end;
end;

procedure TfrmPrincipal.ValidaCliente;
begin
  if not PedidoAtual.CliIdentificado then
  begin
    Alerta('Identifique o cliente antes de prosseguir!');
    Abort;
  end;
  
end;

{ TDadosPedido }

procedure TDadosPedido.Clear;
begin
UltCodLido      := 0;
TotalAtualizado := 0;
CodCliente      := 0;
Editando        := False;
CliIdentificado := False;
end;

end.
