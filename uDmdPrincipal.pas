unit uDmdPrincipal;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TdmdPrincipal = class(TDataModule)
    fdPrincipal: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    fdTransaction: TFDTransaction;
  private
    { Private declarations }
  public
  class procedure TrataExeption(Sender: TObject; E: Exception);

  function CriaQuery(lSQL:String):TFDQUery;
    { Public declarations }
  end;

var
  dmdPrincipal: TdmdPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uException;

{$R *.dfm}

{ TdmdPrincipal }

function TdmdPrincipal.CriaQuery(lSQL: String): TFDQUery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := fdPrincipal;
  Result.SQL.Add(lSQL);
end;

class procedure TdmdPrincipal.TrataExeption(Sender: TObject; E: Exception);
var lException :TfrmException;
begin
 try
   lException := TfrmException.Create(nil);
   lException.memException.Lines.Add(E.Message);
   lException.ShowModal;
 finally
   lException.Free;
 end;
end;

end.
