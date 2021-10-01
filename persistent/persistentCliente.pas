unit persistentCliente;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, logicCliente;

type
  TdmCliente = class(TDataModule)
    qryClientesPesquisar: TFDQuery;
  public
    procedure Pesquisar(id: integer; var id_retorno: integer);
    procedure Carregar(oCliente: TCliente);
  end;

var
  dmCliente: TdmCliente;

implementation

uses persistentConexao;

{$R *.dfm}

procedure TdmCliente.Pesquisar(id: integer; var id_retorno: integer);
begin
  if qryClientesPesquisar.Active then
    qryClientesPesquisar.Close;

  qryClientesPesquisar.ParamByName('id').AsInteger := id;
  qryClientesPesquisar.Open;
  id_retorno := qryClientesPesquisar.FieldByName('id').AsInteger;

  qryClientesPesquisar.Close;
end;

procedure TdmCliente.Carregar(oCliente: TCliente);
begin
  if qryClientesPesquisar.Active then
    qryClientesPesquisar.Close;

  qryClientesPesquisar.ParamByName('id').AsInteger := oCliente.Id;
  qryClientesPesquisar.Open;
  oCliente.id := qryClientesPesquisar.FieldByName('id').AsInteger;
  oCliente.Nome := qryClientesPesquisar.FieldByName('nome').AsString;
  oCliente.Cidade := qryClientesPesquisar.FieldByName('cidade').AsString;
  oCliente.UF := qryClientesPesquisar.FieldByName('uf').AsString;

  qryClientesPesquisar.Close;
end;

end.
