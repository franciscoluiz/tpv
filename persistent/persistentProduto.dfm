object dmProduto: TdmProduto
  OldCreateOrder = False
  Height = 259
  Width = 412
  object qryProdutosPesquisar: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      'select * from produtos where id = :id')
    Left = 63
    Top = 32
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
