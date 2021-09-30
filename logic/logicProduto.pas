unit logicProduto;

interface

uses
  System.Classes,
  System.Generics.Collections;

type
  TProduto = class(TPersistent)
  private
    FIndice: Integer;
    FCodigo: Integer;
    FDescricao: string;
    FPreco: Double;
    FQuantidade: Integer;
    function GetTotal: Double;
  public
    procedure Assign(Source: TPersistent); override;
    function Clone: TProduto;
    procedure Limpar;
    property Indice: Integer read FIndice write FIndice;
    property Codigo: Integer read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property Preco: Double read FPreco write FPreco;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property Total: Double read GetTotal;
  end;

  TProdutos = class(TObjectList<TProduto>)
  private
    function GetTotal: Double;
  public
    function Add(const oProduto: TProduto): Integer;
    procedure Mesclar(oProduto: TProduto);
    procedure Excluir(oProduto: TProduto);
    property Total: Double read GetTotal;
  end;

implementation

{ TProduto }

procedure TProduto.Assign(Source: TPersistent);
var
  lSource: TProduto;
begin
  if Source is TProduto then
  begin
    lSource := Source as TProduto;
    FIndice := lSource.Indice;
    FCodigo := lSource.FCodigo;
    FDescricao := lSource.FDescricao;
    FPreco := lSource.FPreco;
    FQuantidade := lSource.FQuantidade;
  end
  else
    inherited Assign(Source);
end;

function TProduto.Clone: TProduto;
begin
  Result := TProduto.Create;
  Result.Assign(Self);
end;

function TProduto.GetTotal: Double;
begin
  Result := FQuantidade * FPreco;
end;

procedure TProduto.Limpar;
begin
  FCodigo := 0;
  FDescricao := '';
  FPreco := 0;
  FQuantidade := 0;
end;

{ TProdutos }

function TProdutos.Add(const oProduto: TProduto): Integer;
begin
  Result := inherited Add(oProduto);
  oProduto.Indice := Count;
end;

procedure TProdutos.Excluir(oProduto: TProduto);
var
  lProduto: TProduto;
  lIndice: Integer;
begin
  for lIndice := 0 to Pred(Count) do
  begin
    lProduto := Self[lIndice];
    if lProduto.Indice = oProduto.Indice then
    begin
      Delete(lIndice);
      Break;
    end;
  end;
end;

function TProdutos.GetTotal: Double;
var
  lProduto: TProduto;
begin
  Result := 0;
  for lProduto in Self do
    Result := Result + lProduto.Total;
end;

procedure TProdutos.Mesclar(oProduto: TProduto);
var
  lProduto: TProduto;
  lIndice: Integer;
begin
  for lIndice := 0 to Pred(Count) do
  begin
    lProduto := Self[lIndice];
    if lProduto.Indice = oProduto.Indice then
    begin
      lProduto.Assign(oProduto);
      Break;
    end;
  end;
end;

end.
