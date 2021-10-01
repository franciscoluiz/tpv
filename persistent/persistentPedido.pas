unit persistentPedido;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, logicPedido, persistentConexao,
  logicProduto;

type
  TdmPedido = class(TDataModule)
    qryPedidosPesquisar: TFDQuery;
    qryPedidosGravar: TFDQuery;
    qryPedidosAlterar: TFDQuery;
    qryPedidosItensExcluir: TFDQuery;
    qryPedidosItensGravar: TFDQuery;
    qryPedidosItensPesquisar: TFDQuery;
  public
    procedure Carregar(oPedido: TPedido);
    procedure Gravar(oPedido: TPedido);
  end;

var
  dmPedido: TdmPedido;

implementation

{$R *.dfm}

procedure TdmPedido.Carregar(oPedido: TPedido);
var
  lProduto: TProduto;
begin
  qryPedidosPesquisar.Close;
  qryPedidosPesquisar.ParamByName('id').AsInteger := oPedido.Id;
  qryPedidosPesquisar.Open;

  oPedido.Id := qryPedidosPesquisar.FieldByName('id').AsInteger;
  oPedido.Cliente.Id := qryPedidosPesquisar.FieldByName('cliente_id').AsInteger;
  oPedido.Cliente.Nome := qryPedidosPesquisar.FieldByName('cliente_id').AsString;
  oPedido.Cliente.Cidade := qryPedidosPesquisar.FieldByName('cidade').AsString;
  oPedido.Cliente.UF := qryPedidosPesquisar.FieldByName('uf').AsString;
  oPedido.DataEmissao := qryPedidosPesquisar.FieldByName('dataemissao').AsDateTime;

  qryPedidosItensPesquisar.Close;
  qryPedidosItensPesquisar.ParamByName('pedido_id').AsInteger := oPedido.Id;
  qryPedidosItensPesquisar.Open;

  while not qryPedidosItensPesquisar.Eof do
  begin

    lProduto := TProduto.Create;
    lProduto.Codigo := qryPedidosItensPesquisar.FieldByName('produto_id').AsInteger;
    lProduto.Descricao := qryPedidosItensPesquisar.FieldByName('descricao').AsString;
    lProduto.Quantidade := qryPedidosItensPesquisar.FieldByName('quantidade').AsInteger;
    lProduto.Preco := qryPedidosItensPesquisar.FieldByName('valorunitario').AsFloat;
    oPedido.Produtos.Add(lProduto);
    qryPedidosItensPesquisar.Next;

  end;

  qryPedidosItensPesquisar.Close;
  qryPedidosPesquisar.Close;
end;

procedure TdmPedido.Gravar(oPedido: TPedido);
var
  lProduto: TProduto;
  lEditando: Boolean;
begin
  persistentConexao.dmConexao.transac.StartTransaction;
  try
    lEditando := oPedido.Id > 0;

    if lEditando then
    begin
      qryPedidosItensExcluir.ParamByName('pedido_id').AsInteger := oPedido.Id;
      qryPedidosItensExcluir.ExecSQL;
    end
    else
    begin
      oPedido.DataEmissao := Now;
      qryPedidosGravar.ParamByName('cliente_id').AsInteger := oPedido.Cliente.Id;
      qryPedidosGravar.ParamByName('valortotal').AsFloat := oPedido.Total;
      qryPedidosGravar.ParamByName('dataemissao').AsDateTime := oPedido.DataEmissao;
      qryPedidosGravar.ExecSQL;
      oPedido.Id := dmConexao.LastID('id');
    end;

    for lProduto in oPedido.Produtos do
    begin
      qryPedidosItensGravar.ParamByName('pedido_id').AsInteger := oPedido.Id;
      qryPedidosItensGravar.ParamByName('produto_id').AsInteger := lProduto.Codigo;
      qryPedidosItensGravar.ParamByName('quantidade').AsInteger := lProduto.Quantidade;
      qryPedidosItensGravar.ParamByName('valorunitario').AsFloat := lProduto.Preco;
      qryPedidosItensGravar.ParamByName('valortotal').AsFloat := lProduto.Total;
      qryPedidosItensGravar.ExecSQL;
    end;
    persistentConexao.dmConexao.transac.Commit;
  except
    persistentConexao.dmConexao.transac.Rollback;
    raise;
  end;
end;

end.
