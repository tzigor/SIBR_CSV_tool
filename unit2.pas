unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils;

type SibrParam = record
    name: String;
    min: Single;
    max: Single;
    stdDev: Single;
    k, m: Integer;
end;

var SibrParams: array of SibrParam;
    AdditionalParams: array[0..31] of Single;

function ParamLine(name:String; mean, min, max, stdDev, minTol, maxTol, stdDevTol: Single; k, m: Integer; PF: String): String;
function SWLine(name:String; SW, Expected: Longint; PF: String): String;
procedure FillParams;
function AmplitudeName(n: Integer):String;
function PhaseShiftName(n: Integer):String;
function NameToInt(name: String): Integer;

implementation

function ParamLine(name:String; mean, min, max, stdDev, minTol, maxTol, stdDevTol: Single; k, m: Integer; PF: String): String;
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

procedure FillParams;
begin
  setLength(SibrParams, 63);
  SibrParams[0].name:= 'TEMP_CTRL';
  SibrParams[0].min:= 0;
  SibrParams[0].max:= 40;
  SibrParams[0].stdDev:= 0.2;
  SibrParams[0].k:= 5;
  SibrParams[0].m:= 2;

  SibrParams[1].name:= 'AX';
  SibrParams[1].min:= -1;
  SibrParams[1].max:= 1;
  SibrParams[1].stdDev:= 0.1;
  SibrParams[1].k:= 5;
  SibrParams[1].m:= 4;

  SibrParams[2].name:= 'RES1';
  SibrParams[2].min:= 0;
  SibrParams[2].max:= 0;
  SibrParams[2].stdDev:= 0;
  SibrParams[2].k:= 8;
  SibrParams[2].m:= 3;

  SibrParams[3].name:= 'AZ';
  SibrParams[3].min:= -1;
  SibrParams[3].max:= 1;
  SibrParams[3].stdDev:= 0.1;
  SibrParams[3].k:= 5;
  SibrParams[3].m:= 4;

  SibrParams[4].name:= 'AY';
  SibrParams[4].min:= -1;
  SibrParams[4].max:= 1;
  SibrParams[4].stdDev:= 0.1;
  SibrParams[4].k:= 5;
  SibrParams[4].m:= 4;

  SibrParams[5].name:= 'RES4';
  SibrParams[5].min:= 0;
  SibrParams[5].max:= 0;
  SibrParams[5].stdDev:= 0;
  SibrParams[5].k:= 8;
  SibrParams[5].m:= 3;

  SibrParams[6].name:= 'RES5';
  SibrParams[6].min:= 0;
  SibrParams[6].max:= 0;
  SibrParams[6].stdDev:= 0;
  SibrParams[6].k:= 8;
  SibrParams[6].m:= 3;

  SibrParams[7].name:= 'BHT';
  SibrParams[7].min:= 0;
  SibrParams[7].max:= 40;
  SibrParams[7].stdDev:= 0.2;
  SibrParams[7].k:= 5;
  SibrParams[7].m:= 2;

  SibrParams[8].name:= 'BHP';
  SibrParams[8].min:= -5;
  SibrParams[8].max:= 5;
  SibrParams[8].stdDev:= 0.2;
  SibrParams[8].k:= 6;
  SibrParams[8].m:= 2;

  SibrParams[9].name:= 'V1P';
  SibrParams[9].min:= -1;
  SibrParams[9].max:= 1;
  SibrParams[9].stdDev:= 0.02;
  SibrParams[9].k:= 7;
  SibrParams[9].m:= 6;

  SibrParams[10].name:= 'V2P';
  SibrParams[10].min:= 2.4;
  SibrParams[10].max:= 2.8;
  SibrParams[10].stdDev:= 0.02;
  SibrParams[10].k:= 4;
  SibrParams[10].m:= 3;

  SibrParams[11].name:= 'VTERM';
  SibrParams[11].min:= 0;
  SibrParams[11].max:= 1;
  SibrParams[11].stdDev:= 0.02;
  SibrParams[11].k:= 7;
  SibrParams[11].m:= 6;

  SibrParams[12].name:= 'ADC_VOFST';
  SibrParams[12].min:= -1;
  SibrParams[12].max:= 1;
  SibrParams[12].stdDev:= 0.02;
  SibrParams[12].k:= 7;
  SibrParams[12].m:= 6;

  SibrParams[13].name:= 'ADC_VREF';
  SibrParams[13].min:= 3;
  SibrParams[13].max:= 4;
  SibrParams[13].stdDev:= 0.02;
  SibrParams[13].k:= 7;
  SibrParams[13].m:= 6;

  SibrParams[14].name:= 'I24';
  SibrParams[14].min:= 0;
  SibrParams[14].max:= 1;
  SibrParams[14].stdDev:= 0.02;
  SibrParams[14].k:= 7;
  SibrParams[14].m:= 6;

  SibrParams[15].name:= 'V_24V_CTRL';
  SibrParams[15].min:= 17;
  SibrParams[15].max:= 31;
  SibrParams[15].stdDev:= 0.02;
  SibrParams[15].k:= 5;
  SibrParams[15].m:= 3;

  SibrParams[16].name:= 'V_20VP_SONDE';
  SibrParams[16].min:= 14;
  SibrParams[16].max:= 26;
  SibrParams[16].stdDev:= 0.02;
  SibrParams[16].k:= 5;
  SibrParams[16].m:= 3;

  SibrParams[17].name:= 'V_20VP';
  SibrParams[17].min:= 14;
  SibrParams[17].max:= 26;
  SibrParams[17].stdDev:= 0.02;
  SibrParams[17].k:= 5;
  SibrParams[17].m:= 3;

  SibrParams[18].name:= 'V_5RV';
  SibrParams[18].min:= 4.5;
  SibrParams[18].max:= 5.5;
  SibrParams[18].stdDev:= 0.02;
  SibrParams[18].k:= 7;
  SibrParams[18].m:= 3;

  SibrParams[19].name:= 'V_5TV';
  SibrParams[19].min:= 4.5;
  SibrParams[19].max:= 5.5;
  SibrParams[19].stdDev:= 0.02;
  SibrParams[19].k:= 7;
  SibrParams[19].m:= 3;

  SibrParams[20].name:= 'V_3.3V';
  SibrParams[20].min:= 3;
  SibrParams[20].max:= 3.6;
  SibrParams[20].stdDev:= 0.02;
  SibrParams[20].k:= 7;
  SibrParams[20].m:= 3;

  SibrParams[21].name:= 'V_2.5V';
  SibrParams[21].min:= 2.25;
  SibrParams[21].max:= 2.75;
  SibrParams[21].stdDev:= 0.02;
  SibrParams[21].k:= 7;
  SibrParams[21].m:= 3;

  SibrParams[22].name:= 'V_1.8V';
  SibrParams[22].min:= 1.62;
  SibrParams[22].max:= 1.98;
  SibrParams[22].stdDev:= 0.02;
  SibrParams[22].k:= 7;
  SibrParams[22].m:= 3;

  SibrParams[23].name:= 'V_1.2V';
  SibrParams[23].min:= 1.08;
  SibrParams[23].max:= 1.32;
  SibrParams[23].stdDev:= 0.02;
  SibrParams[23].k:= 7;
  SibrParams[23].m:= 3;

  SibrParams[24].name:= 'I_24V_CTRL';
  SibrParams[24].min:= 0.03;
  SibrParams[24].max:= 0.05;
  SibrParams[24].stdDev:= 0.02;
  SibrParams[24].k:= 7;
  SibrParams[24].m:= 3;

  SibrParams[25].name:= 'I_20VP_SONDE';
  SibrParams[25].min:= 0;
  SibrParams[25].max:= 0.01;
  SibrParams[25].stdDev:= 0.02;
  SibrParams[25].k:= 7;
  SibrParams[25].m:= 3;

  SibrParams[26].name:= 'I_5RV';
  SibrParams[26].min:= 0.05;
  SibrParams[26].max:= 0.1;
  SibrParams[26].stdDev:= 0.02;
  SibrParams[26].k:= 7;
  SibrParams[26].m:= 3;

  SibrParams[27].name:= 'I_5TV';
  SibrParams[27].min:= 0.1;
  SibrParams[27].max:= 0.2;
  SibrParams[27].stdDev:= 0.02;
  SibrParams[27].k:= 7;
  SibrParams[27].m:= 3;

  SibrParams[28].name:= 'I_3.3V';
  SibrParams[28].min:= 0.3;
  SibrParams[28].max:= 0.5;
  SibrParams[28].stdDev:= 0.02;
  SibrParams[28].k:= 7;
  SibrParams[28].m:= 6;

  SibrParams[29].name:= 'I_1.8V';
  SibrParams[29].min:= 0.02;
  SibrParams[29].max:= 0.05;
  SibrParams[29].stdDev:= 0.02;
  SibrParams[29].k:= 7;
  SibrParams[29].m:= 3;

  SibrParams[30].name:= 'I_1.2V';
  SibrParams[30].min:= 0.1;
  SibrParams[30].max:= 0.3;
  SibrParams[30].stdDev:= 0.02;
  SibrParams[30].k:= 7;
  SibrParams[30].m:= 3;

  SibrParams[31].name:= 'AR1T0F1';
  SibrParams[31].min:= 0;
  SibrParams[31].max:= 0;
  SibrParams[31].stdDev:= 0;
  SibrParams[31].k:= 10;
  SibrParams[31].m:= 2;

  SibrParams[32].name:= 'AR2T0F1';
  SibrParams[32].min:= 0;
  SibrParams[32].max:= 0;
  SibrParams[32].stdDev:= 0;
  SibrParams[32].k:= 10;
  SibrParams[32].m:= 2;

  SibrParams[33].name:= 'AR1T0F2';
  SibrParams[33].min:= 0;
  SibrParams[33].max:= 0;
  SibrParams[33].stdDev:= 0;
  SibrParams[33].k:= 10;
  SibrParams[33].m:= 2;

  SibrParams[34].name:= 'AR2T0F2';
  SibrParams[34].min:= 0;
  SibrParams[34].max:= 0;
  SibrParams[34].stdDev:= 0;
  SibrParams[34].k:= 10;
  SibrParams[34].m:= 2;

  SibrParams[35].name:= 'AR1T1F1';
  SibrParams[35].min:= 0;
  SibrParams[35].max:= 0;
  SibrParams[35].stdDev:= 0;
  SibrParams[35].k:= 10;
  SibrParams[35].m:= 2;

  SibrParams[36].name:= 'AR2T1F1';
  SibrParams[36].min:= 0;
  SibrParams[36].max:= 0;
  SibrParams[36].stdDev:= 0;
  SibrParams[36].k:= 10;
  SibrParams[36].m:= 2;

  SibrParams[37].name:= 'AR1T1F2';
  SibrParams[37].min:= 0;
  SibrParams[37].max:= 0;
  SibrParams[37].stdDev:= 0;
  SibrParams[37].k:= 10;
  SibrParams[37].m:= 2;

  SibrParams[38].name:= 'AR2T1F2';
  SibrParams[38].min:= 0;
  SibrParams[38].max:= 0;
  SibrParams[38].stdDev:= 0;
  SibrParams[38].k:= 10;
  SibrParams[38].m:= 2;

  SibrParams[39].name:= 'AR1T2F1';
  SibrParams[39].min:= 0;
  SibrParams[39].max:= 0;
  SibrParams[39].stdDev:= 0;
  SibrParams[39].k:= 10;
  SibrParams[39].m:= 2;

  SibrParams[40].name:= 'AR2T2F1';
  SibrParams[40].min:= 0;
  SibrParams[40].max:= 0;
  SibrParams[40].stdDev:= 0;
  SibrParams[40].k:= 10;
  SibrParams[40].m:= 2;

  SibrParams[41].name:= 'AR1T2F2';
  SibrParams[41].min:= 0;
  SibrParams[41].max:= 0;
  SibrParams[41].stdDev:= 0;
  SibrParams[41].k:= 10;
  SibrParams[41].m:= 2;

  SibrParams[42].name:= 'AR2T2F2';
  SibrParams[42].min:= 0;
  SibrParams[42].max:= 0;
  SibrParams[42].stdDev:= 0;
  SibrParams[42].k:= 10;
  SibrParams[42].m:= 2;

  SibrParams[43].name:= 'AR1T3F1';
  SibrParams[43].min:= 0;
  SibrParams[43].max:= 0;
  SibrParams[43].stdDev:= 0;
  SibrParams[43].k:= 10;
  SibrParams[43].m:= 2;

  SibrParams[44].name:= 'AR2T3F1';
  SibrParams[44].min:= 0;
  SibrParams[44].max:= 0;
  SibrParams[44].stdDev:= 0;
  SibrParams[44].k:= 10;
  SibrParams[44].m:= 2;

  SibrParams[45].name:= 'AR1T3F2';
  SibrParams[45].min:= 0;
  SibrParams[45].max:= 0;
  SibrParams[45].stdDev:= 0;
  SibrParams[45].k:= 10;
  SibrParams[45].m:= 2;

  SibrParams[46].name:= 'AR2T3F2';
  SibrParams[46].min:= 0;
  SibrParams[46].max:= 0;
  SibrParams[46].stdDev:= 0;
  SibrParams[46].k:= 10;
  SibrParams[46].m:= 2;

  SibrParams[47].name:= 'PR1T0F1';
  SibrParams[47].min:= 0;
  SibrParams[47].max:= 0;
  SibrParams[47].stdDev:= 0;
  SibrParams[47].k:= 7;
  SibrParams[47].m:= 6;

  SibrParams[48].name:= 'PR2T0F1';
  SibrParams[48].min:= 0;
  SibrParams[48].max:= 0;
  SibrParams[48].stdDev:= 0;
  SibrParams[48].k:= 7;
  SibrParams[48].m:= 6;

  SibrParams[49].name:= 'PR1T0F2';
  SibrParams[49].min:= 0;
  SibrParams[49].max:= 0;
  SibrParams[49].stdDev:= 0;
  SibrParams[49].k:= 7;
  SibrParams[49].m:= 6;

  SibrParams[50].name:= 'PR2T0F2';
  SibrParams[50].min:= 0;
  SibrParams[50].max:= 0;
  SibrParams[50].stdDev:= 0;
  SibrParams[50].k:= 7;
  SibrParams[50].m:= 6;

  SibrParams[51].name:= 'PR1T1F1';
  SibrParams[51].min:= 0;
  SibrParams[51].max:= 0;
  SibrParams[51].stdDev:= 0;
  SibrParams[51].k:= 7;
  SibrParams[51].m:= 6;

  SibrParams[52].name:= 'PR2T1F1';
  SibrParams[52].min:= 0;
  SibrParams[52].max:= 0;
  SibrParams[52].stdDev:= 0;
  SibrParams[52].k:= 7;
  SibrParams[52].m:= 6;

  SibrParams[53].name:= 'PR1T1F2';
  SibrParams[53].min:= 0;
  SibrParams[53].max:= 0;
  SibrParams[53].stdDev:= 0;
  SibrParams[53].k:= 7;
  SibrParams[53].m:= 6;

  SibrParams[54].name:= 'PR2T1F2';
  SibrParams[54].min:= 0;
  SibrParams[54].max:= 0;
  SibrParams[54].stdDev:= 0;
  SibrParams[54].k:= 7;
  SibrParams[54].m:= 6;

  SibrParams[55].name:= 'PR1T2F1';
  SibrParams[55].min:= 0;
  SibrParams[55].max:= 0;
  SibrParams[55].stdDev:= 0;
  SibrParams[55].k:= 7;
  SibrParams[55].m:= 6;

  SibrParams[56].name:= 'PR2T2F1';
  SibrParams[56].min:= 0;
  SibrParams[56].max:= 0;
  SibrParams[56].stdDev:= 0;
  SibrParams[56].k:= 7;
  SibrParams[56].m:= 6;

  SibrParams[57].name:= 'PR1T2F2';
  SibrParams[57].min:= 0;
  SibrParams[57].max:= 0;
  SibrParams[57].stdDev:= 0;
  SibrParams[57].k:= 7;
  SibrParams[57].m:= 6;

  SibrParams[58].name:= 'PR2T2F2';
  SibrParams[58].min:= 0;
  SibrParams[58].max:= 0;
  SibrParams[58].stdDev:= 0;
  SibrParams[58].k:= 7;
  SibrParams[58].m:= 6;

  SibrParams[59].name:= 'PR1T3F1';
  SibrParams[59].min:= 0;
  SibrParams[59].max:= 0;
  SibrParams[59].stdDev:= 0;
  SibrParams[59].k:= 7;
  SibrParams[59].m:= 6;

  SibrParams[60].name:= 'PR2T3F1';
  SibrParams[60].min:= 0;
  SibrParams[60].max:= 0;
  SibrParams[60].stdDev:= 0;
  SibrParams[60].k:= 7;
  SibrParams[60].m:= 6;

  SibrParams[61].name:= 'PR1T3F2';
  SibrParams[61].min:= 0;
  SibrParams[61].max:= 0;
  SibrParams[61].stdDev:= 0;
  SibrParams[61].k:= 7;
  SibrParams[61].m:= 6;

  SibrParams[62].name:= 'PR2T3F2';
  SibrParams[62].min:= 0;
  SibrParams[62].max:= 0;
  SibrParams[62].stdDev:= 0;
  SibrParams[62].k:= 7;
  SibrParams[62].m:= 6;
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


end.

