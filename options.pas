unit Options;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ColorBox,
  Unit2, TAGraph, TASeries;

type

  { TOptionsForm }

  TOptionsForm = class(TForm)
    Apply: TButton;
    DefaultColors: TButton;
    CloseOptions: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ChartBGColor: TColorBox;
    ChartColor: TColorBox;
    GridColor: TColorBox;
    procedure ApplyClick(Sender: TObject);
    procedure CloseOptionsClick(Sender: TObject);
    procedure DefaultColorsClick(Sender: TObject);
  private

  public

  end;

var
  OptionsForm: TOptionsForm;

procedure SetOptions(ChartBGColor, ChartColor, GridColor: TColor);

implementation

uses Unit1;
{$R *.lfm}

{ TOptionsForm }

procedure SetOptions(ChartBGColor, ChartColor, GridColor: TColor);
var i, j: byte;
begin
  for i:=1 to 10 do begin
    TChart(CSV.FindComponent('Pane' + IntToStr(i))).Color:= ChartColor;
    TChart(CSV.FindComponent('Pane' + IntToStr(i))).BackColor:= ChartBGColor;
  end;
  for i:=1 to 10 do
   for j:=0 to 4 do begin
     TChart(CSV.FindComponent('Pane' + IntToStr(i))).AxisList[j].Grid.Color:= GridColor;
   end;
end;

procedure TOptionsForm.CloseOptionsClick(Sender: TObject);
begin
  Close;
end;

procedure TOptionsForm.DefaultColorsClick(Sender: TObject);
begin
  ChartBGColor.Selected:= clWhite;
  ChartColor.Selected:= clForm;
  GridColor.Selected:= clSilver;
end;

procedure TOptionsForm.ApplyClick(Sender: TObject);
begin
  CurvesPanel.ChartBGColor:= ChartBGColor.Selected;
  CurvesPanel.ChartColor:= ChartColor.Selected;
  CurvesPanel.GridColor:= GridColor.Selected;
  SetOptions(CurvesPanel.ChartBGColor, CurvesPanel.ChartColor, CurvesPanel.GridColor);
end;

end.

