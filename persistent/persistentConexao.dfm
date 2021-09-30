object dmConexao: TdmConexao
  OldCreateOrder = False
  Height = 285
  Width = 498
  object con: TFDConnection
    Params.Strings = (
      'Database=tdv'
      'User_Name=root'
      'CharacterSet=utf8'
      'DriverID=MySQL')
    LoginPrompt = False
    Transaction = transac
    Left = 48
    Top = 16
  end
  object transac: TFDTransaction
    Connection = con
    Left = 144
    Top = 16
  end
  object waitCursor: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 232
    Top = 16
  end
end
