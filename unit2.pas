unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, DateUtils, StrUtils, LConvEncoding, TAGraph, TASeries, TATools, TAChartUtils, uComplex, Math, Unit3;

type String70 = String[70];
type ShortString = String[24];

  TSibrParam = record
    name: ShortString;
    min: Double;
    max: Double;
    stdDev: Double;
    k, m: Byte;
  end;

  TSibrReportParam = record
    name: ShortString;
    min: Double;
    max: Double;
    mean: Double;
    stdDev: Single;
    k, m: Byte;
  end;

  TCurve = record
    Parameter: ShortString;
    ParameterTitle: ShortString;
    SerieColor: TColor;
    PenWidth: Byte;
    PenStyle: TPenStyle;
  end;

  TPane = record
    Curves: array[0..3] of TCurve;
  end;

  TPaneSet = record
    Panes: array[0..9] of TPane;
  end;

  TPanel = record
    Name: ShortString;
    PaneSet: TPaneSet;
    ChartBGColor: TColor;
    ChartColor: TColor;
    GridColor: TColor;
    ShowTime: Boolean;
  end;

  TMinMax = record
    Min: Double;
    Max: Double;
  end;

Const
  { Error codes }
    NO_ERROR = 0;
    FILE_NOT_FOUND = 1;
    WRONG_FILE_FORMAT = 2;
    UNEXPECTED_END_OF_FILE = 3;

Const Line = #13#10;
      NumOsCharts: Byte = 8;
      ChartColors: array of TColor = (clRed, clBlue, clGreen, clPurple, clHighLight, clTeal, clFuchsia, clMaroon);
      StatusWords: array of String = ('STATUS.SIBR.LO', 'STATUS.SIBR.HI', 'ESTATUS.SIBR.LO', 'ESTATUS.SIBR.HI');
      SystemChannels: array of String = ('STATUS.SIBR.LO', 'STATUS.SIBR.HI', 'ESTATUS.SIBR.LO', 'ESTATUS.SIBR.HI', 'TEMP_CTRL', 'AX', 'AY', 'AZ', 'RES1', 'RES4', 'RES5', 'BHT', 'BHP', 'V1P', 'V2P', 'VTERM', 'ADC_VOFST', 'ADC_VREF');
      VoltChannels: array of String = ('I24', 'V_24V_CTRL', 'V_20VP_SONDE', 'V_20VP', 'V_5RV', 'V_5TV', 'V_3.3V', 'V_2.5V', 'V_1.8V', 'V_1.2V', 'I_24V_CTRL', 'I_20VP_SONDE', 'I_5RV', 'I_5TV', 'I_3.3V', 'I_1.8V', 'I_1.2V');
      AmplitudesChannels: array of String = ('AR1C0F1','AR2C0F1','AR1C0F2','AR2C0F2','AR1T0F1','AR2T0F1','AR1T0F2','AR2T0F2','AR1T1F1','AR2T1F1','AR1T1F2','AR2T1F2','AR1T2F1','AR2T2F1','AR1T2F2','AR2T2F2','AR1T3F1','AR2T3F1','AR1T3F2','AR2T3F2');
      PhaseChannels: array of String = ('PR1C0F1','PR2C0F1','PR1C0F2','PR2C0F2','PR1T0F1','PR2T0F1','PR1T0F2','PR2T0F2','PR1T1F1','PR2T1F1','PR1T1F2','PR2T1F2','PR1T2F1','PR2T2F1','PR1T2F2','PR2T2F2','PR1T3F1','PR2T3F1','PR1T3F2','PR2T3F2');
      CondChannels: array of String = ('A0L_UNC', 'A16L_UNC', 'A22L_UNC', 'A34L_UNC', 'P0L_UNC', 'P16L_UNC', 'P22L_UNC', 'P34L_UNC', 'A0H_UNC', 'A16H_UNC', 'A22H_UNC', 'A34H_UNC', 'P0H_UNC', 'P16H_UNC', 'P22H_UNC', 'P34H_UNC');
      CondCompChannels: array of String = ('A16L', 'A22L', 'A34L', 'P16L', 'P22L', 'P34L', 'A16H', 'A22H', 'A34H', 'P16H', 'P22H', 'P34H');
      const  a: array[1..3, 1..3] of real = ((2/3, 1/2, -1/6), (1/3, 1/2, 1/6), (-1/3, 1/2, 5/6));

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

const ParameterError = -35535;
var
  ErrorCode                                      : Byte;
  CSVFileName, CSVCompareFileName, DrawParameter : String;
  CSVContent, CSVCompare                         : TStringList;
  DataSource                                     : array of Single;
  TimeSource                                     : array of TDateTime;
  ParamList                                      : array of String;
  SelectedParams                                 : array[0..7] of ShortString;
  ParameterCount                                 : Integer;
  ChartHeight                                    : Integer;
  ShowPR                                         : Boolean;
  Warning                                        : Boolean;
  SibrParams                                     : array of TSibrParam;
  AdditionalParams                               : array[0..31] of ShortString;
  SelectedCount                                  : Byte;
  hrsPlus, prevHrsPlus                           : Integer;
  ChartPointIndex                                : Longint;
  LabelSticked                                   : Boolean;
  StartZone, EndZone                             : TDateTime;
  CurrentSW                                      : String;
  ChartsCurrentExtent                            : TDoubleRect;
  NewChart                                       : Boolean;
  Redraw, DrawClicked                            : Boolean;
  AmplsInmVolts                                  : Boolean;
  ReportParams                                   : array[0..62] of TSibrReportParam;
  TimePosition                                   : Longint;
  SondeError                                     : Boolean;
  CurvesPanel                                    : TPanel;
  PanelsLibFile                                  : file of TPanel;
  LibFileName                                    : String;
  NumberOfPoints                                 : Longint;
  SelectedChartToAdd                             : Byte;

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
function ComplexAmplitude(nParam, n, shift: Integer): complex;
function GetSonde(Param: String; n: Integer): Double;
function GetCompSonde(Param: String; n: Integer): Double;
function Amplitude(nParam, n: Integer): Double;
function PhaseShift(nParam, n: Integer): Double;
procedure FillCoplexParams(n: Integer; Freq: Byte);

implementation
uses Unit1;

function DateTimePlusLocal(DateTime: String): String;
begin
  if DateTime<>'' then DateTimePlusLocal:= DateTimeToStr(IncHour(StrToDateTime(DateTime), hrsPlus - prevHrsPlus))
  else DateTimePlusLocal:= '';
end;

function GetParamPosition(Param: String): Integer;
var i, Pos: Integer;
begin
  Pos:= 0;
  for i:= 0 to Length(ParamList)-1 do begin
     if ParamList[i] = Param then begin
        Pos:= i + 1;
        Break
     end;
  end;
  if Pos = 0 then ErrorCode:= WRONG_FILE_FORMAT;
  Result:= Pos;
end;

function GetParamValue(ParamNum: Integer; TextLine: String): String;
var LineLength, i, Counter, ParamStart: Integer;
    SubStr: String;
begin
  if ParamNum > 0 then begin
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
      Result:= Trim(SubStr);
  end
  else Result:= '';
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
   if name[4] = 'C' then NameToInt:= StrToInt(name[5])*4 + (StrToInt(name[7])-1)*2 + StrToInt(name[3])-1 + 1000;
end;

function ComplexAmplitude(nParam, n, shift: Integer): complex;
var StartParamPos, Step: Integer;
begin
  StartParamPos:= GetParamPosition('VR1C0F1r') + shift;
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  ComplexAmplitude.re:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  ComplexAmplitude.im:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
end;

procedure FillCoplexParams(n: Integer; Freq: Byte);
// Freq = 0 - 400 KHz, Freq = 1 - 2 MHz
begin
  SondeError:= False;
  if Freq = 0 then begin // F1 - 400 KHz
     VT0R1F1:= ComplexAmplitude(0, n, 4);
     VT0R2F1:= ComplexAmplitude(1, n, 4);

     VT1R1F1:= ComplexAmplitude(4, n, 4);
     VT1R2F1:= ComplexAmplitude(5, n, 4);
     VT2R1F1:= ComplexAmplitude(8, n, 4);
     VT2R2F1:= ComplexAmplitude(9, n, 4);
     VT3R1F1:= ComplexAmplitude(12, n, 4);
     VT3R2F1:= ComplexAmplitude(13, n, 4);

     VR1C0F1:= ComplexAmplitude(0, n, 0);
     VR2C0F1:= ComplexAmplitude(1, n, 0);

     VR1C1F1:= ComplexAmplitude(4, n, 0);
     VR2C1F1:= ComplexAmplitude(5, n, 0);
     VR1C2F1:= ComplexAmplitude(8, n, 0);
     VR2C2F1:= ComplexAmplitude(9, n, 0);
     VR1C3F1:= ComplexAmplitude(12, n, 0);
     VR2C3F1:= ComplexAmplitude(13, n, 0);

     if (VT0R1F1<>0) and
        (VT0R2F1<>0) and
        (VT1R1F1<>0) and
        (VT1R2F1<>0) and
        (VT2R1F1<>0) and
        (VT2R2F1<>0) and
        (VT3R1F1<>0) and
        (VT3R2F1<>0) and
        (VR1C0F1<>0) and
        (VR2C0F1<>0) and
        (VR1C1F1<>0) and
        (VR2C1F1<>0) and
        (VR1C2F1<>0) and
        (VR2C2F1<>0) and
        (VR1C3F1<>0) and
        (VR2C3F1<>0) then begin
           T0F1_UNC:= VR1C0F1 / VR2C0F1;
           T1F1_UNC:= (VT1R1F1/VR1C1F1) / (VT1R2F1/VR2C1F1);
           T2F1_UNC:= (VT2R2F1/VR2C2F1) / (VT2R1F1/VR1C2F1);
           T3F1_UNC:= (VT3R1F1/VR1C3F1) / (VT3R2F1/VR2C3F1);
        end
        else SondeError:= True;
   end
   else begin // F2 - 2 MHz
     VT0R1F2:= ComplexAmplitude(2, n, 4);
     VT0R2F2:= ComplexAmplitude(3, n, 4);

     VT1R1F2:= ComplexAmplitude(6, n, 4);
     VT1R2F2:= ComplexAmplitude(7, n, 4);
     VT2R1F2:= ComplexAmplitude(10, n, 4);
     VT2R2F2:= ComplexAmplitude(11, n, 4);
     VT3R1F2:= ComplexAmplitude(14, n, 4);
     VT3R2F2:= ComplexAmplitude(15, n, 4);

     VR1C0F2:= ComplexAmplitude(2, n, 0);
     VR2C0F2:= ComplexAmplitude(3, n, 0);

     VR1C1F2:= ComplexAmplitude(6, n, 0);
     VR2C1F2:= ComplexAmplitude(7, n, 0);
     VR1C2F2:= ComplexAmplitude(10, n, 0);
     VR2C2F2:= ComplexAmplitude(11, n, 0);
     VR1C3F2:= ComplexAmplitude(14, n, 0);
     VR2C3F2:= ComplexAmplitude(15, n, 0);

     if (VT0R1F2<>0) and
        (VT0R2F2<>0) and
        (VT1R1F2<>0) and
        (VT1R2F2<>0) and
        (VT2R1F2<>0) and
        (VT2R2F2<>0) and
        (VT3R1F2<>0) and
        (VT3R2F2<>0) and
        (VR1C0F2<>0) and
        (VR2C0F2<>0) and
        (VR1C1F2<>0) and
        (VR2C1F2<>0) and
        (VR1C2F2<>0) and
        (VR2C2F2<>0) and
        (VR1C3F2<>0) and
        (VR2C3F2<>0) then begin
           T0F2_UNC:= VR1C0F2 / VR2C0F2;
           T1F2_UNC:= (VT1R1F2/VR1C1F2) / (VT1R2F2/VR2C1F2);
           T2F2_UNC:= (VT2R2F2/VR2C2F2) / (VT2R1F2/VR1C2F2);
           T3F2_UNC:= (VT3R1F2/VR1C3F2) / (VT3R2F2/VR2C3F2);
        end
        else SondeError:= True;
   end;
end;

function GetSonde(Param: String; n: Integer): Double;
begin
   if RightStr(Param, 5) = 'L_UNC' then FillCoplexParams(n, 0) // F1 - 400 KHz
   else FillCoplexParams(n, 1); // F2 - 2 MHz
   if SondeError then GetSonde:= ParameterError
   else
     case Param of
       'P0L_UNC': GetSonde:= angle(T0F1_UNC) * 180/Pi;
       'P0H_UNC': GetSonde:= angle(T0F2_UNC) * 180/Pi;
       'P16L_UNC': GetSonde:= angle(T1F1_UNC) * 180/Pi;
       'P22L_UNC': GetSonde:= angle(T2F1_UNC) * 180/Pi;
       'P34L_UNC': GetSonde:= angle(T3F1_UNC) * 180/Pi;
       'P16H_UNC': GetSonde:= angle(T1F2_UNC) * 180/Pi;
       'P22H_UNC': GetSonde:= angle(T2F2_UNC) * 180/Pi;
       'P34H_UNC': GetSonde:= angle(T3F2_UNC) * 180/Pi;
       'A0L_UNC': GetSonde:= -20*Log10(cMod(T0F1_UNC));
       'A0H_UNC': GetSonde:= -20*Log10(cMod(T0F2_UNC));
       'A16L_UNC': GetSonde:= -20*Log10(cMod(T1F1_UNC));
       'A22L_UNC': GetSonde:= -20*Log10(cMod(T2F1_UNC));
       'A34L_UNC': GetSonde:= -20*Log10(cMod(T3F1_UNC));
       'A16H_UNC': GetSonde:= -20*Log10(cMod(T1F2_UNC));
       'A22H_UNC': GetSonde:= -20*Log10(cMod(T2F2_UNC));
       'A34H_UNC': GetSonde:= -20*Log10(cMod(T3F2_UNC));
     end;
end;

function GetCompSonde(Param: String; n: Integer): Double;
begin
   case Param of
     'A16L': GetCompSonde:= Abs(GetSonde('A16L_UNC' ,n)*a[1,1]+GetSonde('A22L_UNC', n)*a[1,2]+GetSonde('A34L_UNC', n)*a[1,3]);
     'A22L': GetCompSonde:= Abs(GetSonde('A16L_UNC' ,n)*a[2,1]+GetSonde('A22L_UNC', n)*a[2,2]+GetSonde('A34L_UNC', n)*a[2,3]);
     'A34L': GetCompSonde:= Abs(GetSonde('A16L_UNC' ,n)*a[3,1]+GetSonde('A22L_UNC', n)*a[3,2]+GetSonde('A34L_UNC', n)*a[3,3]);
     'A16H': GetCompSonde:= Abs(GetSonde('A16H_UNC' ,n)*a[1,1]+GetSonde('A22H_UNC', n)*a[1,2]+GetSonde('A34H_UNC', n)*a[1,3]);
     'A22H': GetCompSonde:= Abs(GetSonde('A16H_UNC' ,n)*a[2,1]+GetSonde('A22H_UNC', n)*a[2,2]+GetSonde('A34H_UNC', n)*a[2,3]);
     'A34H': GetCompSonde:= Abs(GetSonde('A16H_UNC' ,n)*a[3,1]+GetSonde('A22H_UNC', n)*a[3,2]+GetSonde('A34H_UNC', n)*a[3,3]);

     'P16L': GetCompSonde:= Abs(GetSonde('P16L_UNC' ,n)*a[1,1]+GetSonde('P22L_UNC', n)*a[1,2]+GetSonde('P34L_UNC', n)*a[1,3])*180/Pi;
     'P22L': GetCompSonde:= Abs(GetSonde('P16L_UNC' ,n)*a[2,1]+GetSonde('P22L_UNC', n)*a[2,2]+GetSonde('P34L_UNC', n)*a[2,3])*180/Pi;
     'P34L': GetCompSonde:= Abs(GetSonde('P16L_UNC' ,n)*a[3,1]+GetSonde('P22L_UNC', n)*a[3,2]+GetSonde('P34L_UNC', n)*a[3,3])*180/Pi;
     'P16H': GetCompSonde:= Abs(GetSonde('P16H_UNC' ,n)*a[1,1]+GetSonde('P22H_UNC', n)*a[1,2]+GetSonde('P34H_UNC', n)*a[1,3])*180/Pi;
     'P22H': GetCompSonde:= Abs(GetSonde('P16H_UNC' ,n)*a[2,1]+GetSonde('P22H_UNC', n)*a[2,2]+GetSonde('P34H_UNC', n)*a[2,3])*180/Pi;
     'P34H': GetCompSonde:= Abs(GetSonde('P16H_UNC' ,n)*a[3,1]+GetSonde('P22H_UNC', n)*a[1,2]+GetSonde('P34H_UNC', n)*a[3,3])*180/Pi;
   end;
   if SondeError then GetCompSonde:= ParameterError
end;

function Amplitude(nParam, n: Integer): Double;
var StartParamPos, Step, numParam: Integer;
    RawR, RawX: Double;
begin
  numParam:= nParam;
  if nParam >= 1000 then begin
     StartParamPos:= GetParamPosition('VR1C0F1r');
    numParam:= nParam - 1000;
  end
  else StartParamPos:= GetParamPosition('VR1T0F1r');
  if (numParam mod 2) = 0 then Step:= (numParam div 2) * 8
  else Step:= ((numParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  if CSV.MVolts.Checked then Amplitude:= Sqrt(Sqr(RawR)+Sqr(RawX)) * 5000 / 4294967295
  else Amplitude:= Sqrt(Sqr(RawR)+Sqr(RawX)) / CSV.Divider.Value;
end;

function PhaseShift(nParam, n: Integer): Double;
var StartParamPos, Step, numParam: Integer;
    RawR, RawX: Double;
    Phase: complex;
begin
  numParam:= nParam;
  if nParam >= 1000 then begin
    StartParamPos:= GetParamPosition('VR1C0F1r');
    numParam:= nParam - 1000;
  end
  else StartParamPos:= GetParamPosition('VR1T0F1r');
  if (numParam mod 2) = 0 then Step:= (numParam div 2) * 8
  else Step:= ((numParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  Phase:= cInit(RawR, RawX);
  //if RawR <> 0 then PhaseShift:= Arctan(-RawX/RawR)
  if RawR <> 0 then PhaseShift:= Angle(Phase) * 180/Pi
  else PhaseShift:= 0;
end;


end.

