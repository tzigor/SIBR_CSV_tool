unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type String70 = String[70];
type ShortString = String[24];

type TSibrReportParam = record
    name: ShortString;
    min: Double;
    max: Double;
    mean: Double;
    stdDev: Single;
    k, m: Byte;
end;

type TParamFormat = record
    name: ShortString;
    k, m: Byte;
end;

Const NumOfParameters: Integer = 63;
      LN = #13#10;
var
  NumOfFiles: Integer;
  ReportParams: array[0..62] of TSibrReportParam;
  AvarageParams: array[0..62] of TSibrReportParam;
  ParamFormats: array[0..62] of TParamFormat;
  SelectedParamIndx: Integer;
  ChartHeight: Integer;

function GetAvarage(ParamName: String): Integer;

implementation

function GetAvarage(ParamName: String): Integer;
var i: Integer;
begin
   for i:=0 to NumOfParameters - 1 do
     if AvarageParams[i].name = ParamName then GetAvarage:= i;
end;

end.

