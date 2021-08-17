object dmdPrincipal: TdmdPrincipal
  OldCreateOrder = False
  Height = 170
  Width = 240
  object fdPrincipal: TFDConnection
    Params.Strings = (
      'Database=WKPedidos'
      'User_Name=root'
      'Password=quessego123'
      'DriverID=MySQL')
    TxOptions.AutoStop = False
    LoginPrompt = False
    Transaction = fdTransaction
    Left = 112
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 168
    Top = 16
  end
  object fdTransaction: TFDTransaction
    Connection = fdPrincipal
    Left = 168
    Top = 80
  end
end
