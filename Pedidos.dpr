program Pedidos;

uses
  Vcl.Forms,
  uFormBase in 'uFormBase.pas' {frmBase},
  uDmdPrincipal in 'uDmdPrincipal.pas' {dmdPrincipal: TDataModule},
  uException in 'uException.pas' {frmException},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uClasseBase in 'Comum\uClasseBase.pas',
  uInterface in 'uInterface.pas',
  uCController in 'uCController.pas',
  uCFactory in 'uCFactory.pas',
  uCProdutos in 'uCProdutos.pas',
  uCClientes in 'uCClientes.pas',
  uCPedidos in 'uCPedidos.pas',
  uCItemPedido in 'uCItemPedido.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TdmdPrincipal, dmdPrincipal);
  Application.OnException := dmdPrincipal.TrataExeption;

  Application.Run;
end.
