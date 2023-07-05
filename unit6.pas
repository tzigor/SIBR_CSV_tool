unit Unit6;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ColorBox,
  Grids, ComboEx, TAStyles, TAChartCombos, Types, Unit2, StrUtils, LCLType,
  TAGraph, TASeries;

type

  { TPaneEdit }

  TPaneEdit = class(TForm)
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
var PaneNum, CurveNum: Byte;
    CurrentCurve: TLineSeries;
begin
  if Parameter.Caption <> '' then begin
    PaneNum:= StrToInt(StringReplace(PaneNumber.Caption, 'Pane', '', [rfReplaceAll])) - 1;
    CurveNum:= StrToInt(StringReplace(AxisNumber.Caption, 'Curve: ', '', [rfReplaceAll])) - 1;
    if (CurveNum >= 0) And (CurveNum < 4) then begin
      Pane.Curves[CurveNum].Parameter:= Parameter.Caption;
      Pane.Curves[CurveNum].ParameterTitle:= ParameterTitle.Text;
      Pane.Curves[CurveNum].SerieColor:= ColorBox.Selected;
      Pane.Curves[CurveNum].PenWidth:= ChartComboBox2.PenWidth;
      Pane.Curves[CurveNum].PenStyle:= ChartComboBox1.PenStyle;
      PaneSet.Panes[PaneNum]:= Pane;
      CurrentCurve:= TLineSeries(CSV.FindComponent('Curve' + IntToStr(CurveNum + 1)));
      DrawCurveFromLib(CurrentCurve, PaneNum, CurveNum);
      PaneEdit.Close;
    end;
  end;
end;

end.

