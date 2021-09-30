program projetoTpv;

uses
  System.StartUpCopy,
  FMX.Forms,
  formPrincipal in 'forms\formPrincipal.pas' {frmTpv},
  logicCliente in 'logic\logicCliente.pas',
  logicProduto in 'logic\logicProduto.pas',
  logicPedido in 'logic\logicPedido.pas',
  persistentCliente in 'persistent\persistentCliente.pas' {dmCliente: TDataModule},
  persistentConexao in 'persistent\persistentConexao.pas' {dmConexao: TDataModule},
  persistentPedido in 'persistent\persistentPedido.pas' {dmPedidos: TDataModule},
  persistentProduto in 'persistent\persistentProduto.pas' {dmProduto: TDataModule},
  utils in 'utils\utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTpv, frmTpv);
  Application.CreateForm(TdmCliente, dmCliente);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmPedido, dmPedido);
  Application.CreateForm(TdmProduto, dmProduto);
  Application.Run;
end.
