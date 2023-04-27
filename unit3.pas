unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uComplex, Math, StrUtils, LazSysUtils, Dialogs;

var
  VT0R1F1, VT0R2F1, VT0R1F2, VT0R2F2, VT1R1F1, VT1R2F1, VT2R1F1, VT2R2F1, VT3R1F1, VT3R2F1, VT1R1F2, VT1R2F2, VT2R1F2, VT2R2F2, VT3R1F2, VT3R2F2: complex;
  VR1C0F1, VR2C0F1, VR1C0F2, VR2C0F2, VR1C1F1, VR2C1F1, VR1C2F1, VR2C2F1, VR1C3F1, VR2C3F1, VR1C1F2, VR2C1F2, VR1C2F2, VR2C2F2, VR1C3F2, VR2C3F2: complex;
  T0F1_UNC, T1F1_UNC, T2F1_UNC, T3F1_UNC, T0F2_UNC, T1F2_UNC, T2F2_UNC, T3F2_UNC: complex;
  CP: array[0..10] of Double;

function angle(q : complex): Double;
function expon2(n: Integer): Integer;

implementation

function expon2(n: Integer): Integer;
var i, exp: Integer;
begin
  exp:= 1;
  for i:=1 to n do exp:= exp * 2;
  expon2:= exp;
end;

//function angle(z : complex): Double;
//begin
//  if z.re = 0 then
//    if z.im > 0 then angle:= Pi/2
//    else angle:= -Pi/2
//  else
//    if z.re > 0 then angle:= Arctan(z.im/z.re)
//    else angle:= Pi-Arctan(-z.im/z.re)
//end;

function angle(q : complex): Double;
var a: Double;
begin
  if q.re = 0 then begin
    if q.im > 0 then a:= Pi/2
    else a:= -Pi/2;
  end
  else begin
    if q.re > 0 then a:= Arctan(q.im/q.re)
    else a:= Pi-Arctan(-q.im/q.re);
  end;
  if a > 1.75*pi then a:= a - 2 * pi
  else if a < -0.25*pi then a:= a + 2 * pi;
  angle:= a;
end;

end.


