unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uComplex, Math, StrUtils, LazSysUtils, Dialogs;

type TDoubleArray = array of Double;

  // Пример входых данных для 8-ми точек
const
    Xi: array of Double = (0.215, 0.441, 0.638, 0.865, 1.05, 1.30, 1.55, 1.82);
    Yi: array of Double = (5.82, 4.63, 4.10, 3.34, 3.0, 3.29, 4.32, 5.72);

var
  VT0R1F1, VT0R2F1, VT0R1F2, VT0R2F2, VT1R1F1, VT1R2F1, VT2R1F1, VT2R2F1, VT3R1F1, VT3R2F1, VT1R1F2, VT1R2F2, VT2R1F2, VT2R2F2, VT3R1F2, VT3R2F2: complex;
  VR1C0F1, VR2C0F1, VR1C0F2, VR2C0F2, VR1C1F1, VR2C1F1, VR1C2F1, VR2C2F1, VR1C3F1, VR2C3F1, VR1C1F2, VR2C1F2, VR1C2F2, VR2C2F2, VR1C3F2, VR2C3F2: complex;
  T0F1_UNC, T1F1_UNC, T2F1_UNC, T3F1_UNC, T0F2_UNC, T1F2_UNC, T2F2_UNC, T3F2_UNC: complex;
  CP: array[0..10] of Double;

function angle(q : complex): Double;
function expon2(n: Integer): Integer;
function Polinom(n, m: integer): TDoubleArray;

implementation

uses Unit1, Unit2;

function expon2(n: Integer): Integer;
var i, exp: Integer;
begin
  exp:= 1;
  for i:=1 to n do exp:= exp * 2;
  expon2:= exp;
end;

function Polinom(n, m: integer): TDoubleArray;
// n - Степень полинома
// m - кол-во точек

var T: array [0..16] of Double;
    C, A: array[0..8] of Double;
    B: array [0..8, 0..9] of Double;
    i, j, k: integer;
    Y, Bik, Delta: Double;

begin
  CSV.Results.Text:= '';
  for i:=0 to 16 do T[i]:= 0;
  for i:=0 to 8 do begin
    C[i]:=0; A[i]:= 0
  end;
  for i:=0 to 8 do
    for j:=0 to 9 do B[i, j]:= 0;

  for i:=1 to m do begin
    // Вычисляем коэффициенты Т и С
    for j:= 1 to 2*n do T[j]:= T[j] + exp(j * ln(Xi[i-1]));
    for j:= 0 to n do C[j]:= C[j] + Yi[i-1] * exp(j * ln(Xi[i-1]));
  end;

  T[0]:= m;

  // Формируем расширенную матрицу системы уравнений

  for i:= 0 to n do
    for j:= 0 to n do B[i, j]:= T[j + i];

  for i:=0 to n do B[i, n + 1]:= C[i];

  // Приводим её к треугольному виду (прямой ход метода Гаусса)

  for k:= 0 to n-1 do
    for i:= k to n do begin
      Bik:= B[i, k];
      for j:= k to n+1 do
        if i = k then B[i, j]:= B[i, j] / Bik
        else B[i, j]:= B[i, j] / Bik - B[k, j];
  end;

  // Вычисляем и выводим коэффициенты (обратный ход метода Гаусса)
  CSV.Results.Text:= 'Коэффициенты полинома:' + Line;
  for i:= n downto 0 do
    A[i]:= (B[i,n+1] - B[i,1]*A[1] - B[i,2]*A[2] - B[i,3]*A[3] - B[i,4]*A[4] - B[i,5]*A[5] - B[i,6]*A[6] - B[i,7]*A[7] - B[i,8]*A[8]) / B[i,i];

  for i:= 0 to n do CSV.Results.Text:= CSV.Results.Text + FloatToStrF(A[i], ffFixed, 10, 5) + Line;

  // Вычисляем среднеквадратичное отклонениея

  for i:=1 to m do begin
    Y:=0;

    // Вычисляем значение функции с помощью полинома

    for j:= 0 to n do Y:= Y + A[j] * exp(j * ln(Xi[i-1]));

    // Вычисляем сумму квадратов разностей экспериментального значения функции и рассчитанного с помощью полинома

    Delta:= Delta + sqr(Y - Yi[i-1]);
  end;

  // Окончательное вычисление среднеквадратичного отклонения

  Delta:= sqrt(Delta / m);

  CSV.Results.Text:= CSV.Results.Text + Line + 'Cреднеквадратичное отклонение:' + Line;
  CSV.Results.Text:= CSV.Results.Text + FloatToStrF(Delta, ffFixed, 10, 5);

  Polinom:= A; // возвращаем коэффициента
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


