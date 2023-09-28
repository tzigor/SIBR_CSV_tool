unit Utils;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, MaskEdit, DateUtils, Clipbrd, StrUtils, LConvEncoding,
  TAGraph, TACustomSource, LazSysUtils, TASeries, TATools, DateTimePicker,
  Unit2, Unit3, Unit4, Unit6, Unit7, Panel, Options, Types, TAChartUtils,
  TADataTools, TAChartExtentLink, TATransformations, SpinEx, SynHighlighterCpp,
  LCLType, Spin, IniPropStorage, Buttons, Parameters, PQConnection, Math,
  uComplex, TAChartAxisUtils, TAChartAxis, TATypes, TALegend,
  AddCurveToChart;

function GetLineSerie(ChartNumber, LineSerieNumber: Byte): TLineSeries;
procedure DeleteLabels(Chart1LineSeries: TLineSeries);
function AddLineSeries(AChart: TChart; AName: String): TLineSeries;
procedure SetLineSerieColor(LineSerie: TLineSeries; AColor: TColor);
function ListItemDrawed(Item: String): Boolean;
function ChartInList(Chart: TChart): Boolean;
procedure SetHorizontalExtent(Chart: TChart);
function GetAcumulatedStatusWord(SWLO, SWHi, ESWLO, ESWHi: Word; y: Double; SWParam: String): Word;
procedure HideTimeAxises;
procedure ShowTimeAxises;
function GetLastChart: Byte;
function GetFreeChart: Byte;
procedure SetDateTimeOnBottom;
procedure ChartsVisible(visible: Boolean);
procedure ResetZoom;
procedure ResetSeries;
procedure ResetCharts;
function GetColorBySerieName(LineSerieName: String): TColor;
function GetChartLineSerie(ChartNum: Byte; SerieTitle: String): TLineSeries;
function GetFreeLineSerie(ChartNum: Byte): Byte;

implementation

uses Unit1;

function GetAcumulatedStatusWord(SWLO, SWHi, ESWLO, ESWHi: Word; y: Double; SWParam: String): Word;
begin
   if SWParam = 'STATUS.SIBR.LO' then Result:= SWLO or Trunc(y)
   else if SWParam = 'STATUS.SIBR.HI' then Result:= SWHi or Trunc(y)
        else if SWParam = 'ESTATUS.SIBR.LO' then Result:= ESWLO or Trunc(y)
             else Result:= ESWHi or Trunc(y)
end;

procedure HideTimeAxises;
var i: byte;
begin
 for i:=1 to 8 do begin
    TChart(CSV.FindComponent('Chart' + IntToStr(i))).AxisList[1].Marks.Visible:= false;
    TChart(CSV.FindComponent('Chart' + IntToStr(i))).Foot.Visible:= false;
 end;
end;

procedure ShowTimeAxises;
var i: byte;
begin
 for i:=1 to 8 do begin
    TChart(CSV.FindComponent('Chart' + IntToStr(i))).AxisList[1].Marks.Visible:= true;
    TChart(CSV.FindComponent('Chart' + IntToStr(i))).Foot.Visible:= true;
 end;
end;

function GetLastChart: Byte;
var i: Byte;
    MaxTop: Integer;
begin
  MaxTop:= 0;
  for i:=1 to 8 do begin
     if TChart(CSV.FindComponent('Chart' + IntToStr(i))).Visible AND (TChart(CSV.FindComponent('Chart' + IntToStr(i))).Top >= MaxTop) then begin
        MaxTop:= TChart(CSV.FindComponent('Chart' + IntToStr(i))).Top;
        GetLastChart:= i;
     end;
  end;
end;

function GetFreeChart: Byte;
var i: Byte;
begin
  for i:=1 to 8 do begin
     if TChart(CSV.FindComponent('Chart' + IntToStr(i))).Visible = false then begin
        GetFreeChart:= i;
        Break;
     end;
  end;
end;

procedure SetDateTimeOnBottom;
var LastChart: Byte;
begin
  HideTimeAxises;
  LastChart:= GetLastChart;
  if LastChart > 0 then begin
     TChart(CSV.FindComponent('Chart' + IntToStr(LastChart))).AxisList[1].Marks.Visible:= true;
     TChart(CSV.FindComponent('Chart' + IntToStr(LastChart))).Foot.Visible:= true;
  end;
end;

procedure ChartsVisible(visible: Boolean);
var i: byte;
begin
 for i:=1 to 8 do TChart(CSV.FindComponent('Chart' + IntToStr(i))).Visible:= visible;
end;

procedure ResetZoom;
var i: byte;
begin
 for i:=1 to 8 do TChart(CSV.FindComponent('Chart' + IntToStr(i))).ZoomFull();
end;

procedure ResetSeries;
var i, j: byte;
begin
 for i:= 1 to 8 do
    for j:= 1 to 8 do GetLineSerie(i, j).Clear;
end;

procedure ResetCharts;
begin
  NewChart:= true;
  ResetSeries;
  ResetZoom;
  ChartsVisible(false);
end;

procedure SetHorizontalExtent(Chart: TChart);
var Ext: TDoubleRect;
begin
   Ext := Chart.GetFullExtent;
   Ext.coords[1]:= ChartsCurrentExtent.coords[1];
   Ext.coords[3]:= ChartsCurrentExtent.coords[3];
   Chart.LogicalExtent:= Ext;
end;

function ChartInList(Chart: TChart): Boolean;
var i: Byte;
    InList: Boolean;
begin
  InList:= false;
  for i:=1 to CSV.SelectedChannels.Items.Count do begin
     if (Chart.Visible) And (Chart.Title.Text[0] = CSV.SelectedChannels.Items[i-1]) then begin
        InList:= true;
     end;
  end;
  ChartInList:= InList;
end;

function ListItemDrawed(Item: String): Boolean;
var i: Byte;
    Drawed: Boolean;
begin
  Drawed:= false;
  for i:=1 to 8 do begin
     if TChart(CSV.FindComponent('Chart' + IntToStr(i))).Visible and (TChart(CSV.FindComponent('Chart' + IntToStr(i))).Title.Text[0] = Item) then Drawed:= true;
  end;
  ListItemDrawed:= Drawed;
end;

function GetLineSerie(ChartNumber, LineSerieNumber: Byte): TLineSeries;
begin
   Result:= TLineSeries(TChart(CSV.FindComponent('Chart' + IntToStr(ChartNumber))).Series[LineSerieNumber - 1]);
end;

function GetChartLineSerie(ChartNum: Byte; SerieTitle: String): TLineSeries;
var i: Byte;
begin
  for i:=2 to 8 do
     if GetLineSerie(ChartNum, i).Title = SerieTitle then begin
        Result:= GetLineSerie(ChartNum, i);
        Exit;
     end;
end;

function GetFreeLineSerie(ChartNum: Byte): Byte;
var i: Byte;
begin
  for i:=2 to 8 do
     if GetLineSerie(ChartNum, i).Count = 0 then begin
        Result:= i;
        Exit;
     end;
end;

procedure DeleteLabels(Chart1LineSeries: TLineSeries);
var i, count: Longint;
begin
   count:= Chart1LineSeries.Count;
   for i:=0 to count-1 do Chart1LineSeries.ListSource.Item[i]^.text:= '';
   Chart1LineSeries.ParentChart.Repaint;
end;

function AddLineSeries(AChart: TChart; AName: String): TLineSeries;
begin
  Result := TLineSeries.Create(AChart);
  with TLineSeries(Result) do
  begin
    Name:= AChart.Name + AName;
    Pointer.Style := psCircle;
    Pointer.VertSize:= 2;
    Pointer.HorizSize:= 2;
    ShowLines := true;
    LinePen.Style := psSolid;
    Legend.Visible:= False;
  end;
  AChart.AddSeries(Result);
end;

procedure SetLineSerieColor(LineSerie: TLineSeries; AColor: TColor);
begin
  LineSerie.SeriesColor := AColor;
  LineSerie.Pointer.Brush.Color := AColor;
  LineSerie.Pointer.Pen.Color := AColor;
end;

function GetColorIndex(n: Byte): Byte;
begin
  Result:= n - (n Div 8) * 8;
end;

function GetColorBySerieName(LineSerieName: String): TColor;
var Serie, Chart: Byte;
begin
  Chart:= StrToInt(MidStr(LineSerieName, 6, 1)) - 1;
  Serie:= StrToInt(MidStr(LineSerieName, 17, 1)) - 1;
  Result:= ChartColors[GetColorIndex(Serie + Chart)];
end;

end.

