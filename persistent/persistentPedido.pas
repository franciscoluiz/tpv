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
    qryPedidosExcluir: TFDQuery;
    qryPedidosItensGravar: TFDQuery;
    qryGetLastId: TFDQuery;
    qryPedidosItensPesquisar: TFDQuery;
  public
    procedure Carregar(oPedido: TPedido; iId: integer);
    procedure Gravar(oPedido: TPedido);
  end;

var
  dmPedido: TdmPedido;

implementation

{$R *.dfm}

procedure TdmPedido.Carregar(oPedido: TPedido; iId: integer);
var lProduto: TProduto;
begin
  if qryPedidosPesquisar.Active then
    qryPedidosPesquisar.Close;

  qryPedidosPesquisar.ParamByName('id').AsInteger := iId;
  qryPedidosPesquisar.Open;

  if qryPedidosPesquisar.RecordCount > 0 then
  begin
    oPedido.id := qryPedidosPesquisar.FieldByName('id').AsInteger;
    oPedido.Cliente.Id := qryPedidosPesquisar.FieldByName('cliente_id').AsInteger;
    oPedido.Cliente.Nome := qryPedidosPesquisar.FieldByName('cliente_id').AsString;
    oPedido.Cliente.Cidade := qryPedidosPesquisar.FieldByName('cidade').AsString;
    oPedido.Cliente.UF := qryPedidosPesquisar.FieldByName('uf').AsString;
    oPedido.DataEmissao := qryPedidosPesquisar.FieldByName('dataemissao').AsDateTime;

    qryPedidosItensPesquisar.ParamByName('id').AsInteger := qryPedidosPesquisar.FieldByName('id').AsInteger;
    qryPedidosItensPesquisar.Open;

    if qryPedidosItensPesquisar.RecordCount > 0 then
    begin
      while not qryPedidosItensPesquisar.Eof do
      begin

        lProduto := TProduto.Create;
        lProduto.Id := qryPedidosItensPesquisar.FieldByName('produto_id').AsInteger;
        lProduto.Descricao := qryPedidosItensPesquisar.FieldByName('descricao').AsString;
        lProduto.Quantidade := qryPedidosItensPesquisar.FieldByName('quantidade').AsInteger;
        lProduto.Preco := qryPedidosItensPesquisar.FieldByName('valorunitario').AsFloat;
        //lProduto.Total := qryPedidosItensPesquisar.FieldByName('valortotal').AsFloat;
        oPedido.Produtos.Add(lProduto);
        qryPedidosItensPesquisar.Next;

      end;
    end;
  end;

  qryPedidosPesquisar.Close;
end;

procedure TdmPedido.Gravar(oPedido: TPedido);
var
  lProduto: TProduto;
begin
  persistentConexao.dmConexao.transac.StartTransaction;
  try
    qryPedidosGravar.ParamByName('cliente_id').AsInteger := oPedido.Cliente.Id;
    qryPedidosGravar.ParamByName('valortotal').AsFloat := oPedido.Total;
    qryPedidosGravar.ParamByName('dataemissao').AsDateTime := oPedido.DataEmissao;
    qryPedidosGravar.ExecSQL;
    oPedido.Id := dmConexao.LastID('id');

    for lProduto in oPedido.Produtos do
    begin
      qryPedidosItensGravar.ParamByName('pedido_id').AsInteger := oPedido.Id;
      qryPedidosItensGravar.ParamByName('produto_id').AsInteger := lProduto.id;
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
