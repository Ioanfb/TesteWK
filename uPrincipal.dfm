inherited frmPrincipal: TfrmPrincipal
  Caption = 'Pedidos'
  ClientHeight = 456
  ClientWidth = 738
  KeyPreview = True
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitTop = -55
  ExplicitWidth = 754
  ExplicitHeight = 495
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 24
    Top = 13
    Width = 44
    Height = 16
    Caption = 'Produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel [1]
    Left = 335
    Top = 13
    Width = 31
    Height = 16
    Caption = 'Qtde.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [2]
    Left = 399
    Top = 13
    Width = 68
    Height = 16
    Caption = 'Vlr. Unit'#225'rio'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel [3]
    Left = 391
    Top = 342
    Width = 43
    Height = 19
    Caption = 'Total'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Font.Quality = fqClearType
    ParentFont = False
  end
  object Label4: TLabel [4]
    Left = 88
    Top = 320
    Width = 39
    Height = 16
    Caption = 'Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel [5]
    Left = 24
    Top = 320
    Width = 39
    Height = 16
    Caption = 'C'#243'digo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  inherited Panel1: TPanel
    Top = 384
    Width = 738
    Height = 72
    ExplicitTop = 384
    ExplicitWidth = 738
    ExplicitHeight = 72
    inherited btnSalvar: TButton
      Width = 88
      Height = 70
      Caption = 'Gravar pedido'
      OnClick = btnSalvarClick
      ExplicitWidth = 88
      ExplicitHeight = 70
    end
    inherited btnCancelar: TButton
      Left = 89
      Width = 97
      Height = 70
      Caption = 'Cancelar pedido'
      OnClick = btnCancelarClick
      ExplicitLeft = 89
      ExplicitWidth = 97
      ExplicitHeight = 70
    end
    inherited btnBuscaPedido: TButton
      Left = 186
      Width = 96
      Height = 70
      OnClick = btnBuscaPedidoClick
      ExplicitLeft = 186
      ExplicitWidth = 96
      ExplicitHeight = 70
    end
  end
  object gdProdutos: TDBGrid [7]
    Left = 24
    Top = 65
    Width = 554
    Height = 249
    DataSource = dtsProdutos
    DrawingStyle = gdsGradient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = gdProdutosKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'CDPRODUTO'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 235
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRUNITARIO'
        Title.Caption = 'Valor Un.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'QTDE'
        ReadOnly = False
        Title.Caption = 'Qtde.'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VLRTOTAL'
        ReadOnly = False
        Title.Caption = 'Total'
        Visible = True
      end>
  end
  object edtDescricao: TEdit [8]
    Tag = 1
    Left = 24
    Top = 32
    Width = 305
    Height = 27
    Hint = 'Digite o c'#243'digo do produto'
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TextHint = 'Digite o c'#243'digo do produto'
    OnExit = edtDestrycricaoExit
    OnKeyDown = edtDescricaoKeyDown
  end
  object edtQtde: TEdit [9]
    Tag = 1
    Left = 335
    Top = 32
    Width = 58
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object edtVlrUn: TEdit [10]
    Tag = 1
    Left = 399
    Top = 32
    Width = 98
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object btnGravaItem: TButton [11]
    Left = 503
    Top = 30
    Width = 75
    Height = 29
    Caption = 'Grava'
    TabOrder = 5
    OnClick = btnGravaItemClick
  end
  object edtTotalPedido: TEdit [12]
    Left = 448
    Top = 336
    Width = 130
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    Font.Quality = fqClearType
    ParentFont = False
    ReadOnly = True
    TabOrder = 6
  end
  object edtCodCliente: TEdit [13]
    Left = 24
    Top = 339
    Width = 58
    Height = 27
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 7
    OnChange = edtCodClienteChange
    OnExit = edtCodClienteExit
    OnKeyDown = edtCodClienteKeyDown
  end
  object edtNomeCliente: TEdit [14]
    Left = 88
    Top = 339
    Width = 265
    Height = 27
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 8
  end
  inherited ImageList1: TImageList
    Left = 600
    Top = 48
  end
  object fdProdutos: TFDMemTable
    BeforePost = fdProdutosBeforePost
    AfterDelete = fdProdutosAfterDelete
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 600
    Top = 128
    object fdProdutosCDPRODUTO: TIntegerField
      FieldName = 'CDPRODUTO'
    end
    object fdProdutosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object fdProdutosVLRUNITARIO: TCurrencyField
      FieldName = 'VLRUNITARIO'
    end
    object fdProdutosQTDE: TFloatField
      FieldName = 'QTDE'
    end
    object fdProdutosVLRTOTAL: TCurrencyField
      FieldName = 'VLRTOTAL'
    end
  end
  object dtsProdutos: TDataSource
    DataSet = fdProdutos
    Left = 600
    Top = 80
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 600
    Top = 176
  end
end
