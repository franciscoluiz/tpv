object dmPedido: TdmPedido
  OldCreateOrder = False
  Height = 347
  Width = 541
  object qryPedidosPesquisar: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      
        'SELECT p.id, p.dataemissao, p.cliente_id, c.nome, c.cidade, c.uf' +
        ' '
      '  FROM pedidos p LEFT JOIN clientes c ON c.id = p.cliente_id '
      ' WHERE p.id = :id')
    Left = 71
    Top = 176
    ParamData = <
      item
        Name = 'ID'
        ParamType = ptInput
      end>
  end
  object qryPedidosGravar: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      
        'INSERT INTO pedidos (cliente_id, valortotal, dataemissao) VALUES' +
        ' (:cliente_id, :valortotal, :dataemissao)')
    Left = 175
    Top = 176
    ParamData = <
      item
        Name = 'CLIENTE_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALORTOTAL'
        ParamType = ptInput
      end
      item
        Name = 'DATAEMISSAO'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryPedidosAlterar: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      'select * from clientes')
    Left = 295
    Top = 176
  end
  object qryPedidosItensExcluir: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      'delete from pedidos_produtos where pedido_id = :pedido_id')
    Left = 295
    Top = 248
    ParamData = <
      item
        Name = 'PEDIDO_ID'
        ParamType = ptInput
      end>
  end
  object qryPedidosItensGravar: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      
        'INSERT INTO pedidos_produtos (pedido_id, produto_id, quantidade,' +
        ' valorunitario, valortotal) VALUES (:pedido_id, :produto_id, :qu' +
        'antidade, :valorunitario, :valortotal)')
    Left = 175
    Top = 240
    ParamData = <
      item
        Name = 'PEDIDO_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'PRODUTO_ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'QUANTIDADE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALORUNITARIO'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'VALORTOTAL'
        DataType = ftCurrency
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryGetLastId: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      'SELECT * FROM pedidos WHERE id = :id')
    Left = 71
    Top = 96
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qryPedidosItensPesquisar: TFDQuery
    Connection = dmConexao.con
    SQL.Strings = (
      
        'SELECT pp.id, pp.produto_id, p.descricao, pp.quantidade, pp.valo' +
        'runitario '
      
        '  FROM pedidos_produtos pp LEFT JOIN produtos p ON p.id = pp.pro' +
        'duto_id'
      ' WHERE pp.pedido_id = :pedido_id')
    Left = 71
    Top = 248
    ParamData = <
      item
        Name = 'PEDIDO_ID'
        ParamType = ptInput
      end>
  end
end
