unit persistentProduto;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, logicProduto;

type
  TdmProduto = class(TDataModule)
    qryProdutosPesquisar: TFDQuery;
  public
    procedure Pesquisar(id: integer; var id_retorno: integer);
    procedure Carregar(oProduto: TProduto);
  end;

var
  dmProduto: TdmProduto;

implementation

uses persistentConexao;

{$R *.dfm}

procedure TdmProduto.Pesquisar(id: integer; var id_retorno: integer);
begin
  if qryProdutosPesquisar.Active then
    qryProdutosPesquisar.Close;

  qryProdutosPesquisar.ParamByName('id').AsInteger := id;
  qryProdutosPesquisar.Open;
  id_retorno := qryProdutosPesquisar.FieldByName('id').AsInteger;

  qryProdutosPesquisar.Close;
end;

procedure TdmProduto.Carregar(oProduto: TProduto);
begin
  if qryProdutosPesquisar.Active then
    qryProdutosPesquisar.Close;

  qryProdutosPesquisar.ParamByName('id').AsInteger := oProduto.Codigo;
  qryProdutosPesquisar.Open;
  oProduto.Codigo := qryProdutosPesquisar.FieldByName('id').AsInteger;
  oProduto.Descricao := qryProdutosPesquisar.FieldByName('descricao').AsString;
  oProduto.Preco := qryProdutosPesquisar.FieldByName('preco').AsFloat;

  qryProdutosPesquisar.Close;
end;

end.
