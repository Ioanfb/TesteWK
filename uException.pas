unit uException;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TfrmException = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    memException: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmException: TfrmException;

implementation

{$R *.dfm}

end.
