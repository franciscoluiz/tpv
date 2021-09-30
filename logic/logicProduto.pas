unit logicProduto;

interface

uses
  System.Classes,
  System.Generics.Collections;

type
  TProduto = class(TPersistent)
  private
    FId: Integer;
    FDescricao: string;
    FPreco: Double;
    FQuantidade: Integer;
    function GetTotal: Double;
  public
    procedure Assign(Source: TPersistent); override;
    function Clone: TProduto;
    procedure Limpar;
    property Id: Integer read FId write FId;
    property Descricao: string read FDescricao write FDescricao;
    property Preco: Double read FPreco write FPreco;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property Total: Double read GetTotal;
  end;

  TProdutos = class(TObjectList<TProduto>)
  private
    function GetTotal: Double;
  public
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
    FId := lSource.FId;
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
  Result.Id := FId;
  Result.Descricao := FDescricao;
  Result.Preco := FPreco;
  Result.Quantidade := FQuantidade;
end;

function TProduto.GetTotal: Double;
begin
  Result := FQuantidade * FPreco;
end;

procedure TProduto.Limpar;
begin
  FId := 0;
  FDescricao := '';
  FPreco := 0;
  FQuantidade := 0;
end;

{ TProdutos }

function TProdutos.GetTotal: Double;
var
  lProduto: TProduto;
begin
  Result := 0;
  for lProduto in Self do
    Result := Result + lProduto.Total;
end;

end.
