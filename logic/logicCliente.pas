unit logicCliente;

interface

type
  TCliente = class
  private
    FId: Integer;
    FNome: string;
    FCidade: string;
    FUF: string;
  public
    procedure Limpar;
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property Cidade: string read FCidade write FCidade;
    property UF: string read FUF write FUF;
  end;

implementation

procedure TCliente.Limpar;
begin
  FId := 0;
  FNome := '';
  FCidade := '';
  FUF := '';
end;

end.
