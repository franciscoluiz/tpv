unit utils;

interface

uses
  SysUtils;

function FormataDinheiro(const aValue: Double): string;

implementation

function FormataDinheiro(const aValue: Double): string;
begin
  Result := FloatToStrF(aValue, ffNumber, 18, 2);
end;

end.
