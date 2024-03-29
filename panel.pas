unit Panel;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, MaskEdit, DateUtils, Clipbrd, LConvEncoding,
  TAGraph, TACustomSource, TASeries, TATools, TATypes,
  Unit2, Options, TAChartUtils, TADataTools, TATransformations,
  SpinEx, SynHighlighterCpp, LCLType, Spin, PQConnection, TAChartAxis;

function GetVisiblePanesCount: Byte;
procedure DrawCurve(LineSerie: TLineSeries; SelectedParamName: String);
function GetExtentMinMax(LineSerie: TLineSeries): TMinMax;
function GetFullMinMax(LineSerie: TLineSeries): TMinMax;
procedure ZoomCurveExtent(LineSerie: TLineSeries);
procedure CurveTitle(LineSerie: TLineSeries; Title: String);
procedure DrawCurveFromPane(CurrentCurve: TLineSeries; Pane: TPane; PaneNum, CurveNum: Byte);
procedure FitPanesToWindow;
procedure PanesVisible(visible: Boolean; n: Byte);
procedure PanesResetZoom;
procedure PanesResetSeries;
procedure ResetPanes(n: Byte);
procedure PaneSetInit;
procedure PanesResetAxises;
procedure InitTransformations;
procedure HideRightAxises;
procedure SetDateTimeVisible;
procedure CurveInvert(invert: boolean);

implementation

uses Unit1;

function GetVisiblePanesCount: Byte;
var i, n: Byte;
Begin
  n:= 0;
  for i:=1 to 10 do
     if TChart(CSV.FindComponent('Pane' + IntToStr(i))).Visible = true then n:= n + 1;
  GetVisiblePanesCount:= n;
end;

procedure FitPanesToWindow;
var i, PanesWidth, PanesCount: Integer;
begin
  PanesCount:= GetVisiblePanesCount;
  if PanesCount > 1 then begin
    PanesWidth:= (CSV.Width - 10) Div PanesCount;
    for i:=1 to 10 do
      TChart(CSV.FindComponent('Pane' + IntToStr(i))).Width:= PanesWidth;
  end
  else
    for i:=1 to 10 do
      TChart(CSV.FindComponent('Pane' + IntToStr(i))).Width:= CSV.Width Div 2;
end;

procedure DrawCurve(LineSerie: TLineSeries; SelectedParamName: String);
var PRMem, DotsMem, MVoltsMem, TimeScaleMem, ByTemperatureMem, MFastMode: boolean;
    DividerMem: Integer;
begin
  TimeScaleMem:= CSV.TimeScale.Checked;
  ByTemperatureMem:= CSV.ByTemperature.Checked;
  DotsMem:= CSV.ByDots.Checked;
  MVoltsMem:= CSV.MVolts.Checked;
  PRMem:= CSV.PowerResets.Checked;
  MFastMode:= CSV.FastMode.Checked;
  DividerMem:= CSV.Divider.Value;
  CSV.ByDots.Checked:= true;
  CSV.MVolts.Checked:= false;
  CSV.PowerResets.Checked:= false;
  CSV.Divider.Value:= 1;
  CSV.FastMode.Checked:= true;
  DrawChart(LineSerie, SelectedParamName, 0);
  CSV.ByDots.Checked:= DotsMem;
  CSV.PowerResets.Checked:= PRMem;
  CSV.MVolts.Checked:= MVoltsMem;
  CSV.Divider.Value:= DividerMem;
  CSV.TimeScale.Checked:= TimeScaleMem;
  CSV.ByTemperature.Checked:= ByTemperatureMem;
  CSV.FastMode.Checked:= MFastMode;
end;

function GetExtentMinMax(LineSerie: TLineSeries): TMinMax;
var wMax, wMin, K: Double;
    dr: TDoubleRect;
    i, start, count, startExt, endExt, startCurrentExt, endCurrentExt: Longint;
begin
  if LineSerie.Count > 0 then begin
    start:= 0;
    count:= LineSerie.Count-1;
    dr:= LineSerie.ParentChart.GetFullExtent;
    startExt:= Trunc(dr.a.Y);
    endExt:= Trunc(dr.b.Y);
    dr:= LineSerie.ParentChart.CurrentExtent;
    startCurrentExt:= Trunc(dr.a.Y);
    endCurrentExt:= Trunc(dr.b.Y);
    K:= (endExt - startExt) / count;
    if startCurrentExt < startExt then startCurrentExt:= startExt;
    if endCurrentExt > endExt then endCurrentExt:= endExt;

    start:= Trunc((startCurrentExt - startExt) / K);
    count:= Trunc((endCurrentExt - startExt) / K);

    wMin:= LineSerie.ListSource.Item[start]^.Y;
    wMax:= wMin;

    for i:=start to count do begin
      if LineSerie.ListSource.Item[i]^.Y < wMin then wMin:= LineSerie.ListSource.Item[i]^.Y;
      if LineSerie.ListSource.Item[i]^.Y > wMax then wMax:= LineSerie.ListSource.Item[i]^.Y;
    end;
  end;
  GetExtentMinMax.Min:= wMin;
  GetExtentMinMax.Max:= wMax;
end;

function GetFullMinMax(LineSerie: TLineSeries): TMinMax;
begin
  GetFullMinMax.Min:= LineSerie.GetYMin;
  GetFullMinMax.Max:= LineSerie.GetYMax;
end;

procedure ZoomCurveExtent(LineSerie: TLineSeries);
var MinMax, FullMinMax: TMinMax;
    dr: TDoubleRect;
    coeff: Double;
begin
  FullMinMax:= GetFullMinMax(LineSerie);
  MinMax:= GetExtentMinMax(LineSerie);
  dr:= LineSerie.ParentChart.CurrentExtent;

  coeff:= FullMinMax.Max - FullMinMax.Min;
  if coeff <> 0 then begin
    dr.a.X:= (MinMax.Min - FullMinMax.Min) / coeff;
    dr.b.X:= (MinMax.Max - FullMinMax.Min) / coeff;
  end;

  LineSerie.ParentChart.LogicalExtent:= dr;
end;

procedure CurveName(LineSerie: TLineSeries; Title: String);
var YMax, YMin: String;
    YMinMax: TminMax;
begin
  //if LineSerie.Count > 0 then
     LineSerie.GetAxisY.Title.Caption:= Title + Line + YMin + '                                    ' + YMax
  //else begin
  //  LineSerie.GetAxisY.Title.Caption:= 'Click here to add curve' + Line + '                     ';
  //  LineSerie.GetAxisY.Title.LabelFont.Color:= clGray;
  //  LineSerie.GetAxisY.AxisPen.Color:= clGray;
  //end;
end;

procedure CurveTitle(LineSerie: TLineSeries; Title: String);
var YMax, YMin: String;
    YMinMax: TminMax;
begin
  if LineSerie.Count > 0 then begin
    YMinMax:= GetExtentMinMax(LineSerie);

    if YMinMax.Max < 1000000 then YMax:= FloatToStrF(YMinMax.Max, ffFixed, 10, 1)
    else YMax:= FloatToStrF(YMinMax.Max, ffExponent, 1,0);
    if YMinMax.Min < 1000000 then YMin:= FloatToStrF(YMinMax.Min, ffFixed, 10, 1)
    else YMin:= FloatToStrF(YMinMax.Min, ffExponent, 1,0);
    LineSerie.GetAxisY.Title.Caption:= Title + Line + YMin + '                                    ' + YMax;
  end
  else begin
    LineSerie.GetAxisY.Title.Caption:= 'Click here to add curve' + Line + '                     ';
    LineSerie.GetAxisY.Title.LabelFont.Color:= clGray;
    LineSerie.GetAxisY.AxisPen.Color:= clGray;
  end;
end;

procedure DrawCurveFromPane(CurrentCurve: TLineSeries; Pane: TPane; PaneNum, CurveNum: Byte);
begin
  CurrentCurve.ParentChart.ZoomFull();
  CurrentCurve.ParentChart.AxisList[CurveNum + 1].Title.LabelFont.Color:= Pane.Curves[CurveNum].SerieColor;
  CurrentCurve.ParentChart.AxisList[CurveNum + 1].AxisPen.Color:= Pane.Curves[CurveNum].SerieColor;
  CurrentCurve.LinePen.Style:= Pane.Curves[CurveNum].PenStyle;
  CurrentCurve.LinePen.Width:= Pane.Curves[CurveNum].PenWidth;
  CurrentCurve.SeriesColor:= Pane.Curves[CurveNum].SerieColor;
  CurrentCurve.Pointer.Brush.Color:= Pane.Curves[CurveNum].SerieColor;
  CurrentCurve.Pointer.Pen.Color:= Pane.Curves[CurveNum].SerieColor;
  CurrentCurve.Pointer.Style := psCircle;
  CurrentCurve.Pointer.VertSize:= 2;
  CurrentCurve.Pointer.HorizSize:= 2;
  DrawCurve(CurrentCurve, Pane.Curves[CurveNum].Parameter);
  CurveName(CurrentCurve, Pane.Curves[CurveNum].ParameterTitle);
end;

procedure SetDateTimeVisible;
var i: Byte;
    LastPane: String;
begin
  HideRightAxises;
  for i:=1 to 10 do begin
     if TChart(CSV.FindComponent('Pane' + IntToStr(i))).Visible = true then LastPane:= 'Pane' + IntToStr(i);
  end;
  TChart(CSV.FindComponent(LastPane)).AxisList[0].Marks.Visible:= True;
end;

procedure PaneSetInit;
var i, j: byte;
begin
  for i:= 0 to 9 do
    for j:= 0 to 3 do
        CurvesPanel.PaneSet.Panes[i].Curves[j].Parameter:= '';
end;

procedure PanesVisible(visible: Boolean; n: Byte);
var i: byte;
begin
 for i:=n to 10 do TChart(CSV.FindComponent('Pane' + IntToStr(i))).Visible:= visible;
end;

procedure PanesResetZoom;
var i: byte;
    dr: TDoubleRect;
begin
 for i:=1 to 10 do begin
   TChart(CSV.FindComponent('Pane' + IntToStr(i))).ZoomFull();
 end;
end;

procedure PanesResetSeries;
var i, j: byte;
begin
 for i:=1 to 10 do
   for j:=1 to 4 do TLineSeries(CSV.FindComponent('Pane' + IntToStr(i) + 'Curve' + IntToStr(j))).Clear;
end;

procedure HideRightAxises;
var i, j: byte;
begin
 for i:=1 to 10 do
   for j:=1 to 4 do TChart(CSV.FindComponent('Pane' + IntToStr(i))).AxisList[0].Marks.Visible:= false;
end;

procedure PanesResetAxises;
var i, j: byte;
begin
 for i:=1 to 10 do
   for j:=1 to 4 do begin
     TChart(CSV.FindComponent('Pane' + IntToStr(i))).AxisList[j].Title.Caption:= 'Click here to add curve' + Line + '                     ';
     TChart(CSV.FindComponent('Pane' + IntToStr(i))).AxisList[j].Title.LabelFont.Color:= clGray;
     TChart(CSV.FindComponent('Pane' + IntToStr(i))).AxisList[j].AxisPen.Color:= clGray;
   end;
end;

procedure PanesResetAxisesFont;
var i, j: byte;
begin
 for i:=1 to 10 do
   for j:=1 to 4 do begin
     TChart(CSV.FindComponent('Pane' + IntToStr(i))).AxisList[j].Title.LabelFont.Bold:= True;
   end;
end;

procedure CurveInvert(invert: boolean);
var i, j: byte;
begin
 for i:=1 to 10 do
     TChart(CSV.FindComponent('Pane' + IntToStr(i))).AxisList[0].Inverted:= invert;
end;

procedure InitTransformations;
var i, j: byte;
    T: TChartAxisTransformations;
    transf: TAxisTransform;
begin
 for i:=1 to 10 do
   for j:=1 to 4 do begin
     T := TChartAxisTransformations.Create(TChart(CSV.FindComponent('Pane' + IntToStr(i))));
     TChart(CSV.FindComponent('Pane' + IntToStr(i))).AxisList[j].Transformations:= T;
     transf := TAutoscaleAxisTransform.Create(T);
     transf.Transformations:= T;
   end;
end;

procedure InitPanelColors;
begin
  CurvesPanel.ChartBGColor:= clWhite;
  CurvesPanel.ChartColor:= clForm;
  CurvesPanel.GridColor:= clSilver;
  CurvesPanel.ShowTime:= false;
  SetOptions(CurvesPanel.ChartBGColor, CurvesPanel.ChartColor, CurvesPanel.GridColor);
end;

procedure ResetPanes(n: Byte);
begin
  InitPanelColors;
  PanesResetAxises;
  HideRightAxises;
  PaneSetInit;
  PanesVisible(false, n);
  PanesResetZoom;
  PanesResetAxisesFont;
  PanesResetSeries;
  FitPanesToWindow;
end;

end.

