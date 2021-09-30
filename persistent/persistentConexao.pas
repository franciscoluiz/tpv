unit persistentConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.FMXUI.Wait, FireDAC.Comp.Client, Data.DB,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

type
  TdmConexao = class(TDataModule)
    con: TFDConnection;
    transac: TFDTransaction;
    waitCursor: TFDGUIxWaitCursor;
  public
    function LastID(const aName: string): Integer;
  end;

var
  dmConexao: TdmConexao;

implementation

{$R *.dfm}

{ TdmConexao }

function TdmConexao.LastID(const aName: string): Integer;
begin
  Result := con.GetLastAutoGenValue(aName);
end;

end.
