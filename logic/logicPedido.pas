unit logicPedido;

interface

uses
  logicCliente,
  logicProduto;

type
  TPedido = class
  private
    FId: Integer;
    FCliente: TCliente;
    FProdutoAtual: TProduto;
    FProdutos: TProdutos;
    FDataEmissao: TDateTime;
    function GetTotal: Double;
  public
    constructor Create;
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Cliente: TCliente read FCliente;
    property ProdutoAtual: TProduto read FProdutoAtual write FProdutoAtual;
    property Produtos: TProdutos read FProdutos;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property Total: Double read GetTotal;
    procedure Limpar;
  end;

implementation

constructor TPedido.Create;
begin
  inherited Create;
  FCliente := TCliente.Create;
  FProdutoAtual := TProduto.Create;
  FProdutos := TProdutos.Create;
end;

destructor TPedido.Destroy;
begin
  FProdutoAtual.Free;
  FProdutos.Free;
  FCliente.Free;
  inherited Destroy;
end;

function TPedido.GetTotal: Double;
begin
  Result := FProdutos.Total;
end;

procedure TPedido.Limpar;
begin
  Cliente.Limpar;
  ProdutoAtual.Limpar;
  Produtos.Clear;
  ProdutoAtual.Quantidade := 1;
end;

end.
