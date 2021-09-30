unit formPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, System.Rtti, FMX.Grid.Style, FMX.Grid,
  FMX.ScrollBox, persistentConexao, persistentCliente, persistentProduto,
  logicCliente, logicProduto, logicPedido, persistentPedido, utils, FMX.Objects,
  FMX.DialogService;

type
  TfrmTpv = class(TForm)
    grpCliente: TGroupBox;
    grpProduto: TGroupBox;
    grpPedido: TGroupBox;
    grpPedidoItens: TGroupBox;
    edtClienteId: TEdit;
    lblClienteNome: TLabel;
    edtProdutoId: TEdit;
    lblProdutoNome: TLabel;
    edtPedidoQuantidade: TEdit;
    lblPedidoQuantidade: TLabel;
    lblPedidoPreco: TLabel;
    edtPedidoPreco: TEdit;
    btnPedidoAdicionarProduto: TButton;
    grpResumoPedido: TGroupBox;
    lblValorTotal: TLabel;
    edtProdutoValorTotal: TEdit;
    grpPedidoProdutos: TGrid;
    colProdutoId: TIntegerColumn;
    colProdutoNome: TStringColumn;
    colProdutoQuantidade: TIntegerColumn;
    colProdutoPreco: TCurrencyColumn;
    colProdutoPrecoTotal: TCurrencyColumn;
    lblResumoQuantidade: TLabel;
    edtResumoQuantidade: TEdit;
    lblResumoValorTotal: TLabel;
    edtResumoValorTotal: TEdit;
    btnGravar: TButton;
    pnlTopo: TPanel;
    lblTitulo: TLabel;
    btnCarregar: TButton;
    imgLogo: TImage;
    btnPedidoEditarProduto: TButton;
    procedure edtClienteIdExit(Sender: TObject);
    procedure edtProdutoIdExit(Sender: TObject);
    procedure btnPedidoAdicionarProdutoClick(Sender: TObject);
    procedure grpPedidoProdutosGetValue(Sender: TObject; const ACol,
      ARow: Integer; var Value: TValue);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtPedidoQuantidadeExit(Sender: TObject);
    procedure edtPedidoPrecoExit(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure grpPedidoProdutosSelectCell(Sender: TObject; const ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure grpPedidoProdutosCellDblClick(const Column: TColumn;
      const Row: Integer);
    procedure btnPedidoEditarProdutoClick(Sender: TObject);
  private
    fPedido: TPedido;
  public
    procedure MapearCliente;
    procedure MapearProdutoAtual;
    procedure AtualizarCliente;
    procedure AtualizarProdutoAtual;
    procedure AtualizarListaProdutos;
    procedure AtualizarTotalProdutos;
    procedure AtualizarTotais;
    procedure Limpar;
  end;

var
  frmTpv: TfrmTpv;

implementation

{$R *.fmx}

procedure TfrmTpv.FormCreate(Sender: TObject);
begin
  fPedido := TPedido.Create;
  fPedido.ProdutoAtual.Quantidade := 1;
  ActiveControl := edtClienteId;
end;

procedure TfrmTpv.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fPedido);
end;

procedure TfrmTpv.btnPedidoAdicionarProdutoClick(Sender: TObject);
begin
  fPedido.Produtos.Add(fPedido.ProdutoAtual.Clone);
  AtualizarListaProdutos;
  AtualizarTotais;
  ActiveControl := edtProdutoId;
end;

procedure TfrmTpv.btnPedidoEditarProdutoClick(Sender: TObject);
begin
//
end;

procedure TfrmTpv.btnCarregarClick(Sender: TObject);
begin
  TDialogService.InputQuery(
    'Digite o código do pedido!', ['Carregar pedido:'], ['0'],
    procedure(const AResult: TModalResult; const AValues: array of string)
    var
      pedido_id: string;
    begin
      if AResult <> idOK then
        Exit;
      pedido_id := AValues[0];
      if pedido_id <> '0' then
      begin
        Limpar;

        dmPedido.Carregar(fPedido, StrToIntDef(pedido_id, 0));

        AtualizarCliente;
        AtualizarListaProdutos;
        AtualizarTotais;
      end;
    end);
end;

procedure TfrmTpv.btnGravarClick(Sender: TObject);
begin
  fPedido.DataEmissao := Now;
  dmPedido.Gravar(fPedido);
  Limpar;
end;

procedure TfrmTpv.edtClienteIdExit(Sender: TObject);
begin
  MapearCliente;
  AtualizarCliente;
end;

procedure TfrmTpv.edtPedidoPrecoExit(Sender: TObject);
begin
  MapearProdutoAtual;
  AtualizarTotalProdutos;
end;

procedure TfrmTpv.edtPedidoQuantidadeExit(Sender: TObject);
begin
  MapearProdutoAtual;
  AtualizarTotalProdutos;
end;

procedure TfrmTpv.edtProdutoIdExit(Sender: TObject);
begin
  MapearProdutoAtual;
  AtualizarProdutoAtual;
  AtualizarTotalProdutos;
end;

procedure TfrmTpv.grpPedidoProdutosCellDblClick(const Column: TColumn;
  const Row: Integer);
begin
  AtualizarProdutoAtual;
  AtualizarTotalProdutos;
end;

procedure TfrmTpv.grpPedidoProdutosGetValue(Sender: TObject; const ACol,
  ARow: Integer; var Value: TValue);
var
  lProduto: TProduto;
begin
  if (ARow < 0) or (not Assigned(fPedido)) or
    (fPedido.Produtos.Count = 0) then
    Exit;
  lProduto := fPedido.Produtos[ARow];
  case ACol of
    0: Value := lProduto.ID;
    1: Value := lProduto.Descricao;
    2: Value := lProduto.Quantidade;
    3: Value := lProduto.Preco;
    4: Value := lProduto.Total;
  end;
end;

procedure TfrmTpv.grpPedidoProdutosSelectCell(Sender: TObject; const ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  btnPedidoEditarProduto.Enabled := (ARow > -1) and (fPedido.Produtos.Count > 0);
  if btnPedidoEditarProduto.Enabled then
    fPedido.ProdutoAtual.Assign(FPedido.Produtos[ARow])
  else
    fPedido.ProdutoAtual.Limpar;
end;

procedure TfrmTpv.Limpar;
begin
  fPedido.Limpar;
  AtualizarListaProdutos;
  edtClienteId.Text := '';
  edtProdutoId.Text := '';
  edtPedidoQuantidade.Text := '';
  edtPedidoPreco.Text := '';
  edtProdutoValorTotal.Text := '';
end;

procedure TfrmTpv.AtualizarTotalProdutos;
begin
  edtProdutoValorTotal.Text := FormataDinheiro(fPedido.ProdutoAtual.Total);
end;

procedure TfrmTpv.AtualizarCliente;
begin
  dmCliente.Carregar(fPedido.Cliente);
  lblClienteNome.Text := fPedido.Cliente.Nome;
end;

procedure TfrmTpv.AtualizarListaProdutos;
begin
  grpPedidoProdutos.RowCount := 0;
  grpPedidoProdutos.RowCount := fPedido.Produtos.Count;
end;

procedure TfrmTpv.AtualizarProdutoAtual;
begin
  dmProduto.Carregar(fPedido.ProdutoAtual);
  lblProdutoNome.Text := fPedido.ProdutoAtual.Descricao;
  edtPedidoQuantidade.Text := IntToStr(fPedido.ProdutoAtual.Quantidade);
  edtPedidoPreco.Text := FormataDinheiro(fPedido.ProdutoAtual.Preco);
end;

procedure TfrmTpv.MapearCliente;
begin
  fPedido.Cliente.Id := StrToIntDef(edtClienteId.Text, 0);
end;

procedure TfrmTpv.MapearProdutoAtual;
begin
  fPedido.ProdutoAtual.Id := StrToIntDef(edtProdutoId.Text, 0);
  fPedido.ProdutoAtual.Quantidade := StrToIntDef(edtPedidoQuantidade.Text,
    fPedido.ProdutoAtual.Quantidade);
  fPedido.ProdutoAtual.Preco := StrToFloatDef(edtPedidoPreco.Text, 0);
end;

procedure TfrmTpv.AtualizarTotais;
begin
  edtResumoQuantidade.Text := IntToStr(fPedido.Produtos.Count);
  edtResumoValorTotal.Text := FormataDinheiro(fPedido.Total);
end;

end.
