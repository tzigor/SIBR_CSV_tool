unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uComplex, Math, StrUtils, LazSysUtils, Dialogs;

var
  VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2: complex;
  CP: array[0..10] of real;

function angle(z : complex): real;
function costruct_probe(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2: complex; f, n: byte; reg: string): real;
procedure coeffpoly(f, n: byte; reg: string);
function probe2sig(probe: real; f, n: byte; reg: string): real;
function conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2: complex; f, n: byte; reg: string; c: Byte): real;
//function Poly(x: real; f, n: byte; reg: string): Real;

implementation
function angle(z : complex): real;
begin
  if z.re = 0 then
    if z.im > 0 then angle:= Pi/2
    else angle:= -Pi/2
  else
    if z.re > 0 then angle:= Arctan(z.im/z.re)
    else angle:= Pi-Arctan(-z.im/z.re)
end;

function costruct_probe(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2: complex; f, n: byte; reg: string): real;
// f = 1 - '404000' or 2 - '1818000' - frequency (Hz)
// n = 1 or 2 or 3 - number of the synthesized probe
// reg = "abs" or "ang" - probe type (amplitude/phase, respectively)
const  a: array[1..3, 1..3] of real = ((-2/3, 1/2, 1/6), (-1/3, 1/2, -1/6), (1/3, 1/2, -5/6));
var d1, d2, d3, s: complex;
    K: array[1..3] of complex;
begin
  if ((VT1R2.re = 0) and (VT1R2.im = 0)) or ((VT2R2.re = 0) and (VT2R2.im = 0)) or ((VT3R2.re = 0) and (VT3R2.im = 0)) or
     ((VT1R1.re = 0) and (VT1R1.im = 0)) or ((VT2R1.re = 0) and (VT2R1.im = 0)) or ((VT3R1.re = 0) and (VT3R1.im = 0)) then
    costruct_probe:= 0
  else begin
    d1:= VT1R2/VT1R1;
    d2:= VT2R2/VT2R1;
    d3:= VT3R2/VT3R1;
    if f = 1 then begin // 400 KHz
      K[1]:= 0.388742894 + 4.627e-6*i;
      K[2]:= 0.458389342 + 1.365e-6*i;
      K[3]:= 0.637350908 - 9.479e-6*i;
    end
    else begin // 2 MHz
      K[1]:= 0.388779642 + 1.964e-6*i;
      K[2]:= 0.458441645 + 1.51e-7*i;
      K[3]:= 0.637448576 - 5.81e-6*i;
    end;
    s:= d1**a[n,1]*d2**a[n,2]*d3**a[n,3] / K[n];
    if reg = 'abs' then costruct_probe:= 20*Log10(cMod(s))
    else costruct_probe:= angle(s);
  end;
end;

procedure coeffpoly(f, n: byte; reg: string);
begin
  CP[10]:= 0;
  if reg = 'abs' then
    if f = 1 then // 400 KHz
       case n of
          1: begin
            CP[10]:= -0.000005671;
            CP[9]:= 0.000013907;
            CP[8]:= 0.000270588;
            CP[7]:= 0.000072199;
            CP[6]:= -0.004255444;
            CP[5]:= -0.011114486;
            CP[4]:= 0.001516358;
            CP[3]:= 0.061865206;
            CP[2]:= 0.170428556;
            CP[1]:= 1.263880967;
            CP[0]:= -0.076016969;
          end;
          2: begin
            CP[10]:= 0.000036545;
            CP[9]:= 0.000479218;
            CP[8]:= 0.002022028;
            CP[7]:= 0.002217698;
            CP[6]:= -0.005899294;
            CP[5]:= -0.016334912;
            CP[4]:= -0.001951243;
            CP[3]:= 0.058819617;
            CP[2]:= 0.179079295;
            CP[1]:= 1.310289405;
            CP[0]:= -0.144291602;
          end;
          3: begin
            CP[10]:= 0.000214545;
            CP[9]:= 0.002095739;
            CP[8]:= 0.006929069;
            CP[7]:= 0.005976605;
            CP[6]:= -0.014161268;
            CP[5]:= -0.033081154;
            CP[4]:= -0.010321707;
            CP[3]:= 0.067353711;
            CP[2]:= 0.216236309;
            CP[1]:= 1.372071338;
            CP[0]:= -0.27560316;
          end;
       end
    else
       case n of
          1: begin
            CP[10]:= 0.000050982;
            CP[9]:= 0.000385496;
            CP[8]:= 0.00099448;
            CP[7]:= 0.000046552;
            CP[6]:= -0.005725842;
            CP[5]:= -0.01216591;
            CP[4]:= 0.002115976;
            CP[3]:= 0.062690582;
            CP[2]:= 0.17033136;
            CP[1]:= 1.264029431;
            CP[0]:= -0.729508069;
          end;
          2: begin
            CP[10]:= -0.000177284;
            CP[9]:= -0.000660361;
            CP[8]:= 0.0006532;
            CP[7]:= 0.004241867;
            CP[6]:= -0.001456653;
            CP[5]:= -0.01685089;
            CP[4]:= -0.005982981;
            CP[3]:= 0.058477584;
            CP[2]:= 0.180036101;
            CP[1]:= 1.310777055;
            CP[0]:= -0.797892091;
          end;
          3: begin
            CP[10]:= -0.001144227;
            CP[9]:= -0.003919276;
            CP[8]:= 0.002815629;
            CP[7]:= 0.019950637;
            CP[6]:= 0.002898866;
            CP[5]:= -0.042788726;
            CP[4]:= -0.026138652;
            CP[3]:= 0.06951328;
            CP[2]:= 0.220268282;
            CP[1]:= 1.372616249;
            CP[0]:= -0.929474915;
          end;
       end
  else
    if f = 1 then // 400 KHz
       case n of
          1: begin
            CP[9]:= 0.000069595;
            CP[8]:= 0.000871252;
            CP[7]:= 0.002656751;
            CP[6]:= -0.011967686;
            CP[5]:= -0.110313872;
            CP[4]:= -0.327597056;
            CP[3]:= -0.401374075;
            CP[2]:= 0.096881176;
            CP[1]:= 1.862377918;
            CP[0]:= 1.471105626;
          end;
          2: begin
            CP[9]:= 0.000270385;
            CP[8]:= 0.004235718;
            CP[7]:= 0.026355619;
            CP[6]:= 0.079106282;
            CP[5]:= 0.095813383;
            CP[4]:= -0.056439887;
            CP[3]:= -0.224269709;
            CP[2]:= 0.121670006;
            CP[1]:= 1.899486487;
            CP[0]:= 1.463513047;
          end;
          3: begin
            CP[9]:= 0.001044807;
            CP[8]:= 0.016898381;
            CP[7]:= 0.113229739;
            CP[6]:= 0.402053681;
            CP[5]:= 0.791775649;
            CP[4]:= 0.789574802;
            CP[3]:= 0.262706626;
            CP[2]:= 0.18166095;
            CP[1]:= 1.975312082;
            CP[0]:= 1.447590683;
          end;
       end
    else
       case n of
          1: begin
            CP[9]:= 0.000617958;
            CP[8]:= 0.008935382;
            CP[7]:= 0.05228881;
            CP[6]:= 0.153653898;
            CP[5]:= 0.213973558;
            CP[4]:= 0.048538238;
            CP[3]:= -0.153781677;
            CP[2]:= 0.179187362;
            CP[1]:= 1.872850644;
            CP[0]:= 0.818019207;
          end;
          2: begin
            CP[9]:= 0.000176868;
            CP[8]:= 0.003278244;
            CP[7]:= 0.023197949;
            CP[6]:= 0.078420779;
            CP[5]:= 0.115894877;
            CP[4]:= -0.004156203;
            CP[3]:= -0.165546944;
            CP[2]:= 0.153026187;
            CP[1]:= 1.90655007;
            CP[0]:= 0.810683322;
          end;
          3: begin
            CP[9]:= -0.00212636;
            CP[8]:= -0.023460183;
            CP[7]:= -0.099509906;
            CP[6]:= -0.197345755;
            CP[5]:= -0.178030602;
            CP[4]:= -0.106169481;
            CP[3]:= -0.17171014;
            CP[2]:= 0.097125639;
            CP[1]:= 1.976789173;
            CP[0]:= 0.795387646;
          end;
       end
end;

function Poly(probe: real; f, n: byte; reg: string): Real;
var c_probe, sig: double;
    i: integer;
begin
  sig:= 0;
  //c_probe:= Log10(Abs(probe));
  //c_probe:= probe;
  coeffpoly(f, n, reg);
  for i:= 10 downto 0 do sig:= sig + CP[i] * power(c_probe, i);
  //probe2sig:= power(10, sig)
  Poly:= sig
end;

function probe2sig(probe: real; f, n: byte; reg: string): real;
var c_probe, sig: double;
    i: integer;
begin
  sig:= 0;
  if Abs(probe) < 0.001 then probe2sig:= 0
  else begin
     c_probe:= Log10(Abs(probe));
     coeffpoly(f, n, reg);
     for i:= 10 downto 0 do sig:= sig + CP[i] * power(c_probe, i);
     try
       c_probe:= power(10, sig);
     except
     on E : Exception do
       probe2sig:= 0;
     end;
     //if probe > 0 then probe2sig:= c_probe
     //else probe2sig:= -c_probe
     probe2sig:= c_probe
  end;
end;

function conductivity(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2: complex; f, n: byte; reg: string; c: Byte): real;
// c = 1 - Compensated
var x: real;
begin
  x:= costruct_probe(VT1R1, VT1R2, VT2R1, VT2R2, VT3R1, VT3R2, f, n, reg);
  if c = 1 then conductivity:= probe2sig(x, f, n, reg)
  else conductivity:= x;
end;

end.

