unit uFormBase;

interface

uses
  Winapi.Windows, Winapi.Messages, Vcl.Mask, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls;


type THEdit = class helper for TEdit
private
  function  GetAsCurrency :Currency;
  procedure SetAsCurrency(lValue:Currency);
  function  GetAsExtended: Extended;
  procedure SetAsExtended(const Value: Extended);
  function  GetAsInteger: Integer;
  procedure SetAsInteger(const Value: Integer);

public
  property AsExtended : Extended  read GetAsExtended write SetAsExtended;
  property AsCurrency : Currency  read GetASCurrency write SetAsCurrency;
  property AsInteger  : Integer   read GetAsInteger  write SetAsInteger;

end;

type TModoFormulario = (_mdNone,_mdInicial, _mdEdicao, _mdInclusao);

type
  TfrmBase = class(TForm)
    Panel1: TPanel;
    ImageList1: TImageList;
    btnSalvar: TButton;
    btnCancelar: TButton;
    btnBuscaPedido: TButton;
    procedure btnSalvaItemClick(Sender: TObject);
  private
    FModoform: TModoformulario;
    { Private declarations }
    procedure DesativaComponentes;
    procedure AtivaComponentes;


   procedure SetModoForm(const Value: TModoformulario);



  public
   procedure ValidaCampos;
   procedure LimpaCampos;
   function  SimNao(FPergunta:String):Boolean;
   procedure Erro(FMsg:String);
   procedure Alerta(FMsg:String);
   procedure Informa(FMsg:String);
   property  ModoForm :TModoformulario read FModoform write SetModoForm;



    { Public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}

{ TfrmBase }

procedure TfrmBase.Alerta(FMsg: String);
begin
  MessageDlg(FMsg, mtWarning,[mbok],0);
end;

procedure TfrmBase.AtivaComponentes;
var I :Integer;
begin
    for I := 0   to Pred(ComponentCount) do
  begin
    if TComponent(Self).Tag = 0 then
    Continue;

    if TComponent(Components[i]).ClassType = TEdit then
    TEdit(Components[i]).Enabled := True;

    if TComponent(Components[i]).ClassType = TLabeledEdit then
    TLabeledEdit(Components[i]).Enabled := True;

    if TComponent(Components[i]).ClassType = TMaskEdit then
    TMaskEdit(Components[i]).Enabled := True;


   if TComponent(Components[i]).ClassType = TMemo then
   TMemo(Components[i]).Enabled := True;

    if TComponent(Components[i]).ClassType = TComboBox then
    TComboBox(Components[i]).Enabled := True;

    if TComponent(Components[i]).ClassType = TCheckBox then
    TCheckBox(Components[i]).Enabled := True;

  end;
end;

procedure TfrmBase.btnSalvaItemClick(Sender: TObject);
begin
  ValidaCampos;
end;

procedure TfrmBase.DesativaComponentes;
var I :Integer;
begin
    for I := 0   to Pred(ComponentCount) do
  begin
    if TComponent(Self).Tag = 0 then
    Continue;

    if TComponent(Components[i]).ClassType = TEdit then
    TEdit(Components[i]).Enabled := False;

    if TComponent(Components[i]).ClassType = TLabeledEdit then
    TLabeledEdit(Components[i]).Enabled := False;

    if TComponent(Components[i]).ClassType = TMaskEdit then
    TMaskEdit(Components[i]).Enabled := False;


   if TComponent(Components[i]).ClassType = TMemo then
   TMemo(Components[i]).Enabled := False;

    if TComponent(Components[i]).ClassType = TComboBox then
    TComboBox(Components[i]).Enabled := False;

    if TComponent(Components[i]).ClassType = TCheckBox then
    TCheckBox(Components[i]).Enabled := False;

  end;
//
end;

procedure TfrmBase.Erro(FMsg: String);
begin
  MessageDlg(FMsg, mtError,[mbok],0);
end;

procedure TfrmBase.Informa(FMsg: String);
begin
  MessageDlg(FMsg, mtInformation,[mbok],0);
end;

procedure TfrmBase.LimpaCampos;
var I :Integer;
begin
    for I := 0   to Pred(ComponentCount) do
  begin
    if TComponent(Self).Tag = 0 then
    Continue;

    if TComponent(Components[i]).ClassType = TEdit then
    TEdit(Components[i]).Text := '';

    if TComponent(Components[i]).ClassType = TLabeledEdit then
    TLabeledEdit(Components[i]).Text := '';

    if TComponent(Components[i]).ClassType = TCheckBox then
    TCheckBox(Components[i]).Checked := False;

    if TComponent(Components[i]).ClassType = TMemo then
    TMemo(Components[i]).Lines.Clear;

    if TComponent(Components[i]).ClassType = TComboBox then
    TComboBox(Components[i]).Itemindex := -1
  end;
end;

procedure TfrmBase.SetModoForm(const Value: TModoformulario);
begin
  FModoform := Value;
  case FModoform of
     _mdInicial             : DesativaComponentes;
     _mdEdicao, _mdInclusao : AtivaComponentes;
   end;
end;

function TfrmBase.SimNao(FPergunta: String): Boolean;
begin
  result := MessageDlg(FPergunta, mtConfirmation,[mbYes, mbNo],0) = ID_YES;
end;

procedure TfrmBase.ValidaCampos;
var I:Integer;
begin
  for I := 0   to Pred(ComponentCount) do
  begin

    if TComponent(Self).Tag = 0 then
    Continue;

    if TComponent(Components[i]).Tag = 0 then
    Continue;


    if TComponent(Components[i]).ClassType = TEdit then
    if TEdit(Components[i]).Text = EmptyStr then
    begin
      ShowMessage('Preencha os campos corretamente!');
      TEdit(Self.Components[i]).SetFocus;
      Abort;
    end;

    if TComponent(Components[i]).ClassType = TMaskEdit then
    if TMaskEdit(Components[i]).Text = '' then
    begin
      ShowMessage('Preencha os campos corretamente!');
      TEdit(Self.Components[i]).SetFocus;
      Abort;
    end;

    if TComponent(Components[i]).ClassType = TLabeledEdit then
    if TLabeledEdit(Components[i]).Text = EmptyStr then
    begin
      ShowMessage('Preencha os campos corretamente!');
      TLabeledEdit(Components[i]).SetFocus;
      Abort;
    end;
  end;

end;

{ THEdit }


function THEdit.GetAsCurrency: Currency;
begin
 result :=  StrToCurr(Self.Text)
end;

function THEdit.GetAsExtended: Extended;
begin
  result := StrtoFloat(Self.Text);
end;

function THEdit.GetAsInteger: Integer;
begin
 result := StrToInt(Self.Text);
end;

procedure THEdit.SetAsCurrency(lValue: Currency);
begin
 Self.Text := CurrtoStr(lValue)
end;

procedure THEdit.SetAsExtended(const Value: Extended);
begin
   Self.Text := FloatToStr(Value);
end;

procedure THEdit.SetAsInteger(const Value: Integer);
begin
  Self.Text := IntToStr(Value)
end;

end.
