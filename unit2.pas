unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, DateUtils, StrUtils, csvdataset, LConvEncoding, TAGraph,
  TASources, TACustomSource, TASeries, TATools, TAIntervalSources,
  DateTimePicker, Types, TAChartUtils, uComplex, Math, Unit3;

type String70 = String[70];
type ShortString = String[24];

type TSibrParam = record
    name: ShortString;
    min: Double;
    max: Double;
    stdDev: Double;
    k, m: Byte;
end;

type TSibrReportParam = record
    name: ShortString;
    min: Double;
    max: Double;
    mean: Double;
    stdDev: Single;
    k, m: Byte;
end;

Const Line = #13#10;
      NumOsCharts: Byte = 8;
      SystemChannels: array of String = ('STATUS.SIBR.LO', 'STATUS.SIBR.HI', 'ESTATUS.SIBR.LO', 'ESTATUS.SIBR.HI', 'TEMP_CTRL', 'AX', 'AY', 'AZ', 'RES1', 'RES4', 'RES5', 'BHT', 'BHP', 'V1P', 'V2P', 'VTERM', 'ADC_VOFST', 'ADC_VREF');
      VoltChannels: array of String = ('I24', 'V_24V_CTRL', 'V_20VP_SONDE', 'V_20VP', 'V_5RV', 'V_5TV', 'V_3.3V', 'V_2.5V', 'V_1.8V', 'V_1.2V', 'I_24V_CTRL', 'I_20VP_SONDE', 'I_5RV', 'I_5TV', 'I_3.3V', 'I_1.8V', 'I_1.2V');
      CondChannels: array of String = ('A0L_UNC', 'A16L_UNC', 'A22L_UNC', 'A34L_UNC', 'P0L_UNC', 'P16L_UNC', 'P22L_UNC', 'P34L_UNC', 'A0H_UNC', 'A16H_UNC', 'A22H_UNC', 'A34H_UNC', 'P0H_UNC', 'P16H_UNC', 'P22H_UNC', 'P34H_UNC');
      CondCompChannels: array of String = ('A16L', 'A22L', 'A34L', 'P16L', 'P22L', 'P34L', 'A16H', 'A22H', 'A34H', 'P16H', 'P22H', 'P34H');

Const SWLo: array of String70 = (
      '+24V_CTRL out of range ±30%',
      '+20V_SONDE out of range ±30%',
      '+20VP out of range ±10%',
      '+5V out of range ±10%',
      '+3.3V out of range ±10%',
      '+2.5V out of range ±10%',
      '+1.8V out of range ±10%',
      '+1.2V out of range ±10%',
      '+5V Transmitters out of range ±10%',
      'CTRL board temperature out of range',
      'RTC is out of sync (waiting for TIMESTAMPING command)',
      'CAN bus error. Data cannot be sent',
      'GOLD firmware loaded',
      'SPI-Flash error',
      'I2C0 bus error',
      'I2C0 bus multiple error');
      SWHi: array of String70 = (
      'SPI0 bus error',
      'SPI1 bus error',
      'NAND Flash initialisation error',
      'NAND Flash page write error',
      'NAND Flash block clear error',
      'NAND Flash page read error',
      'NAND Flash new bad block',
      'NAND-Flash is about full',
      'NAND-Flash is full',
      'Packets loss',
      'LVDS bus error',
      'ADC input overflow',
      'ADC multiple input overflow',
      'Low signal of any receivers',
      'Reserved',
      'PIPE DETECTOR. Low signal of both receivers');
      ESWLo: array of String70 = (
      'Data exchange error with transmitter - addr 1',
      'Data exchange error with transmitter - addr 2',
      'Data exchange error with transmitter - addr 3',
      'Data exchange error with receiver - addr 4',
      'Data exchange error with receiver - addr 5',
      'Logging started',
      'BHT & TEMP_CTRL difference > 25C ',
      'Calculation error',
      'Cabration file corrupted',
      'Reserve',
      'Reserve',
      'Reserve',
      'Active logging identifier bit 0',
      'Active logging identifier bit 1',
      'Active logging identifier bit 2',
      'Active logging identifier bit 3');

var
  CSVFileName, CSVCompareFileName, DrawParameter: String;
  CSVContent, CSVCompare: TStringList;
  DataSource: array of Single;
  TimeSource: array of TDateTime;
  ParamList: array of String;
  SelectedParams: array[0..7] of ShortString;
  ParameterCount: Integer;
  ChartHeight: Integer;
  ShowPR: Boolean;
  Warning: Boolean;
  SibrParams: array of TSibrParam;
  AdditionalParams: array[0..31] of ShortString;
  SelectedCount: Byte;
  hrsPlus, prevHrsPlus: Integer;
  ChartPointIndex: Longint;
  LabelSticked: Boolean;
  StartZone, EndZone: TDateTime;
  CurrentSW: String;
  ChartsCurrentExtent: TDoubleRect;
  NewChart: Boolean;
  Redraw, DrawClicked: Boolean;
  AmplsInmVolts: Boolean;
  ReportParams: array[0..62] of TSibrReportParam;
  TimePosition: Longint;

function AmplitudeName(n: Integer):String;
function PhaseShiftName(n: Integer):String;
function NameToInt(name: String): Integer;
function GetLineColor(): TColor;
function GetParamPosition(Param: String): Integer;
function GetParamValue(ParamNum: Integer; TextLine: String): String;
function FileSize(FileName:string):Integer;
function ParamLine(name:String; mean, min, max, stdDev, minTol, maxTol, stdDevTol: Double; k, m: Integer; PF: String): String;
function SWLine(name:String; SW, Expected: Longint; PF: String): String;
procedure GetResParameters(var Amplitude, PhaseShift: Double; nParam, n: Integer);
function DateTimePlusLocal(DateTime: String): String;
function GetReportAmpl(Param: String): Double;
function ComplexAmplitude(nParam, n: Integer): complex;
function GetConductivity(Param: String; n: Integer; c: Byte): Double;
function Amplitude(nParam, n: Integer): Double;
function PhaseShift(nParam, n: Integer): Double;

implementation

function DateTimePlusLocal(DateTime: String): String;
begin
  if DateTime<>'' then DateTimePlusLocal:= DateTimeToStr(IncHour(StrToDateTime(DateTime), hrsPlus - prevHrsPlus))
  else DateTimePlusLocal:= '';
end;

function GetParamPosition(Param: String): Integer;
var i: Integer;
begin
  for i:= 0 to Length(ParamList)-1 do begin
     if ParamList[i] = Param then begin
        GetParamPosition:= i+1;
        break
     end
  end
end;

function GetParamValue(ParamNum: Integer; TextLine: String): String;
var LineLength, i, Counter, ParamStart: Integer;
    SubStr: String;
begin
  LineLength:= Length(TextLine);
  Counter:= 1;
  SubStr:= '';
  for i:= 1 to LineLength do begin
     if ParamNum = Counter then begin
        ParamStart:= i;
        break;
     end;
     if TextLine[i] = ';' then Counter:= Counter + 1;
  end;
  i:= ParamStart;
  repeat
    SubStr:= SubStr + TextLine[i];
    i:= i + 1;
  until ( TextLine[i] = ';' ) OR ( i > LineLength );
  GetParamValue:= Trim(SubStr);
end;

function FileSize(FileName:string):Integer;
var
FS: TFileStream;
begin
  try
    FS:=TFilestream.Create(FileName, fmOpenRead);
  except
  Result := -1;
  end;
  if Result <> -1 then Result :=FS.Size;
  FS.Free;
end;

function GetLineColor(): TColor;
var R, G, B: Byte;
begin
   Randomize;
   repeat
      R:= Random(256);
      G:= Random(256);
      B:= Random(256);
   until (R + B + G) < 350;
   GetLineColor:= RGBToColor(R, G, B);
end;

function ParamLine(name:String; mean, min, max, stdDev, minTol, maxTol, stdDevTol: Double; k, m: Integer; PF: String): String;
var wStr: String;
begin
   wStr:= AddCharR(' ',name, 15);
   wStr:= wStr + AddCharR(' ', FloatToStrF(mean, ffFixed, k, m), 12);
   wStr:= wStr + AddCharR(' ', FloatToStrF(min, ffFixed, k, m), 12);
   wStr:= wStr + AddCharR(' ', FloatToStrF(max, ffFixed, k, m), 12);
   wStr:= wStr + AddCharR(' ', FloatToStrF(stdDev, ffFixed, 10, 3), 12);
   wStr:= wStr + ' | ';
   wStr:= wStr + AddCharR(' ', FloatToStrF(minTol, ffFixed, k, m), 12);
   wStr:= wStr + AddCharR(' ', FloatToStrF(maxTol, ffFixed, k, m), 12);
   wStr:= wStr + AddCharR(' ', FloatToStrF(stdDevTol, ffFixed, 10, 3), 12);
   wStr:= wStr + ' | ' + PF;
   ParamLine:= wStr;
end;

function SWLine(name:String; SW, Expected: Longint; PF: String): String;
var wStr: String;
begin
   wStr:= AddCharR(' ',name, 16);
   wStr:= wStr + AddCharR(' ',IntToStr(SW), 6);
   wStr:= wStr + AddCharR(' ', '0x' + Dec2Numb(SW, 4, 16),7);
   wStr:= wStr + AddCharR(' ', Dec2Numb(SW, 16, 2), 16);
   wStr:= wStr + ' | ' + AddCharR(' ', '0x' + Dec2Numb(Expected, 4, 16),7);
   wStr:= wStr + ' | ' + PF;
   SWLine:= wStr;
end;

procedure GetResParameters(var Amplitude, PhaseShift: Double; nParam, n: Integer);
var StartParamPos, Step: Integer;
    RawR, RawX: Double;
begin
  StartParamPos:= GetParamPosition('VR1T0F1r');
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  if AmplsInmVolts then Amplitude:= Sqrt(Sqr(RawR)+Sqr(RawX)) * 5000 / 4294967295
  else Amplitude:= Sqrt(Sqr(RawR)+Sqr(RawX));
  if RawR <> 0 then PhaseShift:= Arctan(-RawX/RawR)
  else PhaseShift:= 0;
end;

function GetReportAmpl(Param: String): Double;
var i, NumReportParams: integer;
begin
  NumReportParams:= Length(ReportParams);
  for i:=0 to NumReportParams - 1 do begin
     if ReportParams[i].name = Param then GetReportAmpl:= ReportParams[i].mean;
  end;
end;

function AmplitudeName(n: Integer):String;
begin
   AmplitudeName:= 'AR' + IntToStr((n mod 2) + 1) + 'T' + IntToStr((n mod 16) div 4) + 'F' + IntToStr(((n div 2) mod 2) + 1);
end;

function PhaseShiftName(n: Integer):String;
begin
   PhaseShiftName:= 'PR' + IntToStr((n mod 2) + 1) + 'T' + IntToStr((n mod 16) div 4) + 'F' + IntToStr(((n div 2) mod 2) + 1);
end;

function NameToInt(name: String): Integer;
begin
   NameToInt:= StrToInt(name[5])*4 + (StrToInt(name[7])-1)*2 + StrToInt(name[3])-1;
end;


function ComplexAmplitude(nParam, n: Integer): complex;
var StartParamPos, Step: Integer;
    RawR, RawX: Real;
begin
  StartParamPos:= GetParamPosition('VR1T0F1r');
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  ComplexAmplitude:= cinit(RawR, RawX);
end;

function ComplexCalibration(nParam, n: Integer): complex;
var StartParamPos, Step: Integer;
    RawR, RawX: Real;
begin
  StartParamPos:= GetParamPosition('VR1C0F1r');
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  ComplexCalibration:= cinit(RawR, RawX);
end;

function GetConductivity(Param: String; n: Integer; c: Byte): Double;
// c = 1 - Compensated
var x, x1: real;
    T0F1_UNC, T1F1_UNC, T2F1_UNC, T3F1_UNC, T0F2_UNC, T1F2_UNC, T2F2_UNC, T3F2_UNC: complex;
begin
   if RightStr(Param, 5) = 'L_UNC' then begin // F1 - 400 KHz
     VT0R1F1:= ComplexAmplitude(0, n);
     VT0R2F1:= ComplexAmplitude(1, n);

     VT1R1F1:= ComplexAmplitude(4, n);
     VT1R2F1:= ComplexAmplitude(5, n);
     VT2R1F1:= ComplexAmplitude(8, n);
     VT2R2F1:= ComplexAmplitude(9, n);
     VT3R1F1:= ComplexAmplitude(12, n);
     VT3R2F1:= ComplexAmplitude(13, n);

     VR1C0F1:= ComplexCalibration(0, n);
     VR2C0F1:= ComplexCalibration(1, n);

     VR1C1F1:= ComplexCalibration(4, n);
     VR2C1F1:= ComplexCalibration(5, n);
     VR1C2F1:= ComplexCalibration(8, n);
     VR2C2F1:= ComplexCalibration(9, n);
     VR1C3F1:= ComplexCalibration(12, n);
     VR2C3F1:= ComplexCalibration(13, n);

     T0F1_UNC:= (VT0R1F1/VR1C0F1) / (VT0R2F1/VR2C0F1);
     T1F1_UNC:= (VT1R1F1/VR1C1F1) / (VT1R2F1/VR2C1F1);
     T2F1_UNC:= (VT2R2F1/VR2C2F1) / (VT2R1F1/VR1C2F1);
     T3F1_UNC:= (VT3R1F1/VR1C3F1) / (VT3R2F1/VR2C3F1);
   end
   else begin // F2 - 2 MHz
     VT0R1F2:= ComplexAmplitude(2, n);
     VT0R2F2:= ComplexAmplitude(3, n);

     VT1R1F2:= ComplexAmplitude(6, n);
     VT1R2F2:= ComplexAmplitude(7, n);
     VT2R1F2:= ComplexAmplitude(10, n);
     VT2R2F2:= ComplexAmplitude(11, n);
     VT3R1F2:= ComplexAmplitude(14, n);
     VT3R2F2:= ComplexAmplitude(15, n);

     VR1C0F2:= ComplexCalibration(2, n);
     VR2C0F2:= ComplexCalibration(3, n);

     VR1C1F2:= ComplexCalibration(6, n);
     VR2C1F2:= ComplexCalibration(7, n);
     VR1C2F2:= ComplexCalibration(10, n);
     VR2C2F2:= ComplexCalibration(11, n);
     VR1C3F2:= ComplexCalibration(14, n);
     VR2C3F2:= ComplexCalibration(15, n);

     T0F2_UNC:= (VT0R1F2/VR1C0F2) / (VT0R2F2/VR2C0F2);
     T1F2_UNC:= (VT1R1F2/VR1C1F2) / (VT1R2F2/VR2C1F2);
     T2F2_UNC:= (VT2R2F2/VR2C2F2) / (VT2R1F2/VR1C2F2);
     T3F2_UNC:= (VT3R1F2/VR1C3F2) / (VT3R2F2/VR2C3F2);
   end;

   case Param of
     'P0L_UNC': GetConductivity:= angle(T0F1_UNC);
     'P0H_UNC': GetConductivity:= angle(T0F2_UNC);
     'P16L_UNC': GetConductivity:= angle(T1F1_UNC);
     'P22L_UNC': GetConductivity:= angle(T2F1_UNC);
     'P34L_UNC': GetConductivity:= angle(T3F1_UNC);
     'P16H_UNC': GetConductivity:= angle(T1F2_UNC);
     'P22H_UNC': GetConductivity:= angle(T2F2_UNC);
     'P34H_UNC': GetConductivity:= angle(T3F2_UNC);
     'A0L_UNC': GetConductivity:= -20*Log10(cMod(T0F1_UNC));
     'A0H_UNC': GetConductivity:= -20*Log10(cMod(T0F2_UNC));
     'A16L_UNC': GetConductivity:= -20*Log10(cMod(T1F1_UNC));
     'A22L_UNC': GetConductivity:= -20*Log10(cMod(T2F1_UNC));
     'A34L_UNC': GetConductivity:= -20*Log10(cMod(T3F1_UNC));
     'A16H_UNC': GetConductivity:= -20*Log10(cMod(T1F2_UNC));
     'A22H_UNC': GetConductivity:= -20*Log10(cMod(T2F2_UNC));
     'A34H_UNC': GetConductivity:= -20*Log10(cMod(T3F2_UNC));

     //'A16L': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 1, 1, 'abs', c);
     //'A22L': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 1, 2, 'abs', c);
     //'A34L': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 1, 3, 'abs', c);
     //'A16H': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 2, 1, 'abs', c);
     //'A22H': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 2, 2, 'abs', c);
     //'A34H': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 2, 3, 'abs', c);
     //'P16L': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 1, 1, 'ang', c);
     //'P22L': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 1, 2, 'ang', c);
     //'P34L': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 1, 3, 'ang', c);
     //'P16H': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 2, 1, 'ang', c);
     //'P22H': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 2, 2, 'ang', c);
     //'P34H': GetConductivity:= conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, 2, 3, 'ang', c);
   end;
end;

function Amplitude(nParam, n: Integer): Double;
var StartParamPos, Step: Integer;
    RawR, RawX: Double;
begin
  StartParamPos:= GetParamPosition('VR1T0F1r');
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  if AmplsInmVolts then Amplitude:= Sqrt(Sqr(RawR)+Sqr(RawX)) * 5000 / 4294967295
  else Amplitude:= Sqrt(Sqr(RawR)+Sqr(RawX));
end;

function PhaseShift(nParam, n: Integer): Double;
var StartParamPos, Step: Integer;
    RawR, RawX: Double;
    Phase: complex;
begin
  StartParamPos:= GetParamPosition('VR1T0F1r');
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  Phase:= cInit(RawR, RawX);
  //if RawR <> 0 then PhaseShift:= Arctan(-RawX/RawR)
  if RawR <> 0 then PhaseShift:= Angle(Phase) * 180/Pi
  else PhaseShift:= 0;
end;


end.

