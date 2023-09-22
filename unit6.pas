unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ColorBox,
  TAChartCombos, Types, Unit2, Panel, StrUtils, LCLType,
  TAGraph, TASeries;

type

  { TPaneEdit }

  TPaneEdit = class(TForm)
    DeletePane: TButton;
    DeleteCurve: TButton;
    CloseEdit: TButton;
    AxisNumber: TLabel;
    Save: TButton;
    ChartComboBox1: TChartComboBox;
    ChartComboBox2: TChartComboBox;
    Label3: TLabel;
    ColorBox: TColorBox;
    ColorDialog1: TColorDialog;
    Label4: TLabel;
    Label5: TLabel;
    ParameterList: TListBox;
    ParameterTitle: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Parameter: TLabel;
    PaneNumber: TLabel;
    procedure CloseEditClick(Sender: TObject);
    procedure DeleteCurveClick(Sender: TObject);
    procedure DeletePaneClick(Sender: TObject);
    procedure ParameterListDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure ParameterListSelectionChange(Sender: TObject; User: boolean);
    procedure SaveClick(Sender: TObject);
  private

  public

  end;

var
  PaneEdit: TPaneEdit;

implementation

uses Unit1;

{$R *.lfm}

{ TPaneEdit }

procedure TPaneEdit.ParameterListDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
begin
   with PaneEdit.ParameterList do begin
     if FindPart('AR?T?F', Items[Index]) > 0 then Canvas.Font.Color:= clBlue
     else if FindPart('PR?T?F', Items[Index]) > 0 then Canvas.Font.Color:= RGBToColor(0, 100, 0)
          else if Items[Index] in VoltChannels then Canvas.Font.Color:= RGBToColor(255, 0, 0);

     if (odSelected in State) then begin
       Canvas.Brush.Color:=clBlue;
       Canvas.Font.Color:=clWhite;
     end;

     Canvas.FillRect(ARect);
     Canvas.TextOut(ARect.Left, ARect.Top, Items[Index]);
    end
end;

procedure TPaneEdit.CloseEditClick(Sender: TObject);
begin
  Close;
end;

procedure TPaneEdit.DeleteCurveClick(Sender: TObject);
var PaneNum, CurveNum: Byte;
    CurrentCurve: TLineSeries;
begin
  PaneNum:= StrToInt(StringReplace(PaneNumber.Caption, 'Track ', '', [rfReplaceAll])) - 1;
  CurveNum:= StrToInt(StringReplace(AxisNumber.Caption, 'Curve: ', '', [rfReplaceAll])) - 1;
  if (CurveNum >= 0) And (CurveNum < 4) then begin
      CurvesPanel.PaneSet.Panes[PaneNum].Curves[CurveNum].Parameter:= '';
      CurrentCurve:= TLineSeries(CSV.FindComponent('Pane' + IntToStr(PaneNum + 1) + 'Curve' + IntToStr(CurveNum + 1)));
      CurrentCurve.Clear;
      CurveTitle(CurrentCurve, '');
      PaneEdit.Close;
  end;
end;

procedure TPaneEdit.DeletePaneClick(Sender: TObject);
var PaneNum, i: Byte;
begin
  PaneNum:= StrToInt(StringReplace(PaneNumber.Caption, 'Track ', '', [rfReplaceAll])) - 1;
  for i:=1 to 4 do CurvesPanel.PaneSet.Panes[PaneNum].Curves[i].Parameter:= '';
  TChart(CSV.FindComponent('Pane' + IntToStr(PaneNum))).Visible:= false;
  PaneEdit.Close;
  FitPanesToWindow;
end;

procedure TPaneEdit.ParameterListSelectionChange(Sender: TObject; User: boolean);
  var Pos: TPoint;
    i:   Integer;
begin
  Pos:= Mouse.CursorPos;
  Pos:= ParameterList.ScreenToClient(Pos);
  i:= ParameterList.GetIndexAtXY(Pos.X, Pos.Y);
  Parameter.Caption:= ParameterList.Items[i];
  ParameterTitle.Text:= ParameterList.Items[i];
end;

procedure TPaneEdit.SaveClick(Sender: TObject);
var PaneNum, CurveNum: Integer;
    CurrentCurve: TLineSeries;
begin
  if Parameter.Caption <> '' then begin
    PaneNum:= StrToInt(StringReplace(PaneNumber.Caption, 'Track ', '', [rfReplaceAll])) - 1;
    CurveNum:= StrToInt(StringReplace(AxisNumber.Caption, 'Curve: ', '', [rfReplaceAll])) - 1;
    if (PaneNum >= 0) And (CurveNum >= 0) then begin
       CurvesPanel.PaneSet.Panes[PaneNum].Curves[CurveNum].Parameter:= Parameter.Caption;
       CurvesPanel.PaneSet.Panes[PaneNum].Curves[CurveNum].ParameterTitle:= ParameterTitle.Text;
       CurvesPanel.PaneSet.Panes[PaneNum].Curves[CurveNum].SerieColor:= ColorBox.Selected;
       CurvesPanel.PaneSet.Panes[PaneNum].Curves[CurveNum].PenWidth:= ChartComboBox2.PenWidth;
       CurvesPanel.PaneSet.Panes[PaneNum].Curves[CurveNum].PenStyle:= ChartComboBox1.PenStyle;
       CurrentCurve:= TLineSeries(CSV.FindComponent('Pane' + IntToStr(PaneNum + 1) + 'Curve' + IntToStr(CurveNum + 1)));
       DrawCurveFromPane(CurrentCurve, CurvesPanel.PaneSet.Panes[PaneNum], PaneNum, CurveNum);
       CSV.Pane1ExtentChanged(CurrentCurve.ParentChart);
       PaneEdit.Close;
    end
    else ShowMessage('Track or Curve number is incorrect');
  end;
end;

end.

