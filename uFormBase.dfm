object frmBase: TfrmBase
  Left = 0
  Top = 0
  Caption = 'Form Base'
  ClientHeight = 395
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 328
    Width = 647
    Height = 67
    Align = alBottom
    TabOrder = 0
    object btnSalvar: TButton
      Left = 1
      Top = 1
      Width = 90
      Height = 65
      Align = alLeft
      Caption = 'Salvar'
      TabOrder = 0
      ExplicitHeight = 58
    end
    object btnCancelar: TButton
      Left = 91
      Top = 1
      Width = 90
      Height = 65
      Align = alLeft
      Caption = 'Cancelar'
      TabOrder = 1
      ExplicitHeight = 58
    end
    object btnBuscaPedido: TButton
      Left = 181
      Top = 1
      Width = 90
      Height = 65
      Align = alLeft
      Caption = 'Buscar Pedido'
      TabOrder = 2
      ExplicitHeight = 58
    end
  end
  object ImageList1: TImageList
    Left = 544
    Top = 176
  end
end
