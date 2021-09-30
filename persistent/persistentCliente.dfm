object dmCliente: TdmCliente
  OldCreateOrder = False
  Height = 279
  Width = 495
  object qryClientesPesquisar: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      'select * from clientes where id = :id')
    Left = 79
    Top = 40
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
