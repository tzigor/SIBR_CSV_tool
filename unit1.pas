unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, MaskEdit, DateUtils, lazutf8sysutils, Clipbrd,
  StrUtils, LConvEncoding, TAGraph, TACustomSource, LazSysUtils,
  TASeries, TATools, TAIntervalSources, DateTimePicker, Unit2, Unit4, Types,
  TAChartUtils, TADataTools, TAChartExtentLink, LCLType, Spin;

type

  { TCSV }

  TCSV = class(TForm)
    App: TPageControl;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    ShowTool: TButton;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1LineSeries5: TLineSeries;
    Chart1LineSeries6: TLineSeries;
    Chart1LineSeries7: TLineSeries;
    Chart1LineSeries8: TLineSeries;
    Chart1LineSeries1: TLineSeries;
    Chart2: TChart;
    Chart3: TChart;
    Chart4: TChart;
    Chart5: TChart;
    Chart6: TChart;
    Chart7: TChart;
    Chart8: TChart;
    Chart1: TChart;
    ChartPoints: TCheckBox;
    ChartToolset1DataPointClickTool2: TDataPointClickTool;
    ChartToolset1ZoomMouseWheelTool2: TZoomMouseWheelTool;
    ChartToolset1ZoomMouseWheelTool3: TZoomMouseWheelTool;
    ChartExtentLink1: TChartExtentLink;
    ChartHeightControl: TTrackBar;
    ChartsLink: TCheckBox;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1DataPointHintTool1: TDataPointHintTool;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1ZoomDragTool1: TZoomDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    Comment: TEdit;
    Label34: TLabel;
    TestType: TComboBox;
    RPTOnly: TCheckBox;
    Label33: TLabel;
    mVolts: TCheckBox;
    ComputedChannels: TListBox;
    CSVFileSize: TLabel;
    Duration: TLabel;
    DurationT: TLabel;
    Label27: TLabel;
    TabSheet3: TTabSheet;
    ToolTime: TLabel;
    LocalTime: TSpinEdit;
    OpenedFile: TEdit;
    ExtentDuration: TStaticText;
    GroupBox9: TGroupBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    LeftExtent: TStaticText;
    RightExtent: TStaticText;
    ScrollBox1: TScrollBox;
    ZoneDuration: TLabel;
    EndTime: TEdit;
    EStatusLo: TRadioButton;
    EstimateFast: TButton;
    FileSizeT: TLabel;
    FullRange: TButton;
    Generate: TButton;
    Graphs: TTabSheet;
    CSVFileBox: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MainTab: TTabSheet;
    OpenCSVFast: TButton;
    PowerResets: TCheckBox;
    ProgressBar: TProgressBar;
    ReportProgress: TProgressBar;
    RawChannels: TListBox;
    RecordRate: TEdit;
    Records: TLabel;
    RecordsT: TLabel;
    Report: TButton;
    ReportEndTime: TEdit;
    ReportStartTime: TEdit;
    ReportTab: TTabSheet;
    ReportText: TMemo;
    RunEnd: TLabel;
    RunEndT: TLabel;
    RunStart: TLabel;
    RunStartT: TLabel;
    SaveDialog1: TSaveDialog;
    DateTimeIntervalChartSource1: TDateTimeIntervalChartSource;
    Chart1UserDrawnSeries1: TUserDrawnSeries;
    OpenDialog1: TOpenDialog;
    SaveReport: TButton;
    SelectedChannels: TListBox;
    SerialNumber: TEdit;
    StartTime: TEdit;
    StatusHi: TRadioButton;
    StatusLo: TRadioButton;
    SWDec: TEdit;
    SWHex: TEdit;
    SWList: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TestDate: TDateTimePicker;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ShowToolClick(Sender: TObject);
    procedure Chart6ExtentChanged(ASender: TChart);
    procedure Chart7ExtentChanged(ASender: TChart);
    procedure Chart8ExtentChanged(ASender: TChart);
    procedure ChartHeightControlChange(Sender: TObject);
    procedure ChartToolset1DataPointClickTool2AfterMouseUp(ATool: TChartTool;
      APoint: TPoint);
    procedure ChartToolset1DataPointClickTool2PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure ChartToolset1DataPointHintTool1Hint(ATool: TDataPointHintTool;
      const APoint: TPoint; var AHint: String);
    procedure DrawClick(Sender: TObject);
    procedure Chart1ExtentChanged(ASender: TChart);
    procedure Chart2ExtentChanged(ASender: TChart);
    procedure Chart3ExtentChanged(ASender: TChart);
    procedure Chart4ExtentChanged(ASender: TChart);
    procedure Chart5ExtentChanged(ASender: TChart);
    procedure ChartPointsChange(Sender: TObject);
    procedure ChartsLinkChange(Sender: TObject);
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure ComputedChannelsDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure ComputedChannelsSelectionChange(Sender: TObject; User: boolean);
    procedure EStatusLoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure LocalTimeChange(Sender: TObject);
    procedure mVoltsChange(Sender: TObject);
    procedure RawChannelsDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure RawChannelsSelectionChange(Sender: TObject; User: boolean);
    procedure StatusHiChange(Sender: TObject);
    procedure StatusLoChange(Sender: TObject);
    procedure SWListDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure SaveReportClick(Sender: TObject);
    procedure EstimateFastClick(Sender: TObject);
    procedure FullRangeClick(Sender: TObject);
    procedure GenerateClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OpenCSVFastClick(Sender: TObject);
    procedure ReportClick(Sender: TObject);
  private
  public
  end;


var
  CSV: TCSV;

implementation

{$R *.lfm}

{ TCSV }

procedure TCSV.GenerateClick(Sender: TObject);
  var WorkingFile, NewCSVFile: TextFile;
      TextLine, FileName: String;
      ParamPos, Rate: Integer;
      PrevTime, CurrentTime, StartTimeDT, EndTimeDT: TDateTime;
  begin
        FileName:= ReplaceText(CSVFileName,'.csv','') + '_generated.csv';
        ProgressBar.Position:= 0;
        Rate:= StrToInt(RecordRate.Text);
        AssignFile(WorkingFile, CSVFileName);
        AssignFile(NewCSVFile, FileName);
        StartTimeDT:= StrToDateTime(StartTime.Text);
        EndTimeDT:= StrToDateTime(EndTime.Text);
        try
          Reset(WorkingFile);
          ReWrite(NewCSVFile);
          Readln(WorkingFile, TextLine);
          WriteLn(NewCSVFile,TextLine);
          ParamPos:= GetParamPosition('RTCs');
          PrevTime:= 0;
          while not eof(WorkingFile) do begin
            Readln(WorkingFile, TextLine);
            CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine))), hrsPlus);
            if (YearOf(CurrentTime) <> 1970) and (SecondsBetween(PrevTime,CurrentTime) >= Rate ) and
                 (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin;
               PrevTime:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)));
               WriteLn(NewCSVFile,TextLine);
            end;
            ProgressBar.Position:= ProgressBar.Position + 1;
          end;
          CloseFile(WorkingFile);
          CloseFile(NewCSVFile);
          ShowMessage('Completed');
          ProgressBar.Position:= 0;
        except
        on E: EInOutError do
          ShowMessage('Error: ' + E.Message);
        end;
end;

procedure TCSV.Button2Click(Sender: TObject);
begin
  FreeAndNil(CSVContent);
  CSV.Close;
end;

procedure TCSV.FullRangeClick(Sender: TObject);
begin
  StartTime.Text:= RunStart.Caption;
  EndTime.Text:= RunEnd.Caption;
end;

procedure TCSV.EstimateFastClick(Sender: TObject);
var ParamPos, Rate: Integer;
    NumOfLines, FSize, DurationInMinutes, i: Longint;
    PrevTime, CurrentTime, StartTimeDT, EndTimeDT: TDateTime;
begin
  if CSVFileName<>'' then begin
    try
       Rate:= StrToInt(RecordRate.Text);
    except
    on Exception : EConvertError do
       RecordRate.Text:= '0';
    end;
    if RecordRate.Text <> '0' then begin
      try
        DurationInMinutes:= MinutesBetween(StrToDateTime(StartTime.Text), StrToDateTime(EndTime.Text));
      except
        on E: EConvertError do begin
          ShowMessage('Error: ' + E.Message);
          StartTime.Text:= RunStart.Caption;
          EndTime.Text:= RunEnd.Caption;
        end;
      end;
      StartTimeDT:= StrToDateTime(StartTime.Text);
      EndTimeDT:= StrToDateTime(EndTime.Text);
      if CompareDateTime(EndTimeDT, StartTimeDT) = 1 then begin
          RunStartT.Caption:= StartTime.Text;
          RunEndT.Caption:= EndTime.Text;
          DurationT.Caption:= IntToStr(Round(DurationInMinutes/60)) + ' h ' + IntToStr(DurationInMinutes mod 60) + ' m';
          ParamPos:= GetParamPosition('RTCs');
          PrevTime:= 0;
          FSize:= 0;
          NumOfLines:= 0;
          for i:=1 to CSVContent.Count-1 do begin
              CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i]))), hrsPlus);
              if (YearOf(CurrentTime) <> 1970) and (SecondsBetween(PrevTime,CurrentTime) >= Rate )
                  and (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
                 NumOfLines:=  NumOfLines + 1;
                 FSize:= FSize + Length(CSVContent[i]);
                 PrevTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i]))), hrsPlus);
              end;
          end;
          RecordsT.Caption:= IntToStr(NumOfLines);
          FileSizeT.Caption:= IntToStr(Round(FSize/1000))+' KB';
          Generate.Enabled:= True;
      end else ShowMessage('Start Time should be earlier than End Time');
    end else ShowMessage('Plese put correct value of Record Rate in sec. (1...)');
  end else ShowMessage('Open CSV file first.');
end;


procedure TCSV.ChartPointsChange(Sender: TObject);
begin
  Chart1LineSeries1.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries2.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries3.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries4.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries5.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries6.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries7.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries8.Pointer.Visible:= ChartPoints.Checked;
end;

procedure DeleteLabels(Chart1LineSeries: TLineSeries);
var i, count: Longint;
begin
   count:= Chart1LineSeries.Count;
   for i:=0 to count-1 do Chart1LineSeries.ListSource.Item[i]^.text:= '';
   Chart1LineSeries.ParentChart.Repaint;
end;

procedure TCSV.Button5Click(Sender: TObject);
var i, StatusW: Integer;
begin
  if SWDec.Text<>'' then
    try
       StatusW:= StrToInt(SWDec.Text);
    except
    on Exception : EConvertError do
       SWDec.Text:= '';
    end
  else if SWHex.Text<>'' then begin
    try
       StatusW:= Hex2Dec(SWHex.Text);
    except
    on Exception : EConvertError do
       SWHex.Text:= '';
    end
  end;

  SWDec.Text:= IntToStr(StatusW);
  if StatusW > 65535 then SWDec.Text:= '';
  if SWDec.Text <> '' then begin
    SWHex.Text:= Dec2Numb(StatusW, 4, 16);
    for i:=0 to 15 do begin
      if (StatusW and expon2(i)) > 0 then SWList.Cells[0, i]:= '1'
      else SWList.Cells[0, i]:= '0';
      if StatusLo.Checked then SWList.Cells[1, i]:= SWLo[i];
      if StatusHi.Checked then SWList.Cells[1, i]:= SWHi[i];
      if EStatusLo.Checked then SWList.Cells[1, i]:= ESWLo[i];
    end;
  end;
end;

procedure TCSV.Button1Click(Sender: TObject);
begin
  ReportStartTime.Caption:= RunStart.Caption;
  ReportEndTime.Caption:= RunEnd.Caption;
  ZoneDuration.Caption:= IntToStr(MinutesBetween(StrToDateTime(ReportStartTime.Caption), StrToDateTime(ReportEndTime.Caption))) + ' min';
end;

procedure TCSV.Button3Click(Sender: TObject);
begin
  if StartZone = EndZone then ShowMessage('Time zone is not defined')
  else begin
    ReportStartTime.Caption:= DateTimeToStr(StartZone);
    ReportEndTime.Caption:= DateTimeToStr(EndZone);
    ZoneDuration.Caption:= IntToStr(MinutesBetween(StartZone, EndZone)) + ' min';
  end;
end;

procedure TCSV.Button4Click(Sender: TObject);
begin
  if StartZone = EndZone then ShowMessage('Time zone is not defined')
  else begin
    StartTime.Text:= DateTimeToStr(StartZone);
    EndTime.Text:= DateTimeToStr(EndZone);
  end;
end;

procedure TCSV.Button6Click(Sender: TObject);
var i: Integer;
begin
  SelectedChannels.Clear;
  for i:=0 to CSV.RawChannels.Items.Count - 1 do CSV.RawChannels.Selected[i]:= false;
  for i:=0 to CSV.ComputedChannels.Items.Count - 1 do CSV.ComputedChannels.Selected[i]:= false;
end;

procedure TCSV.Button7Click(Sender: TObject);
begin
  Clipboard.AsText := OpenedFile.Text;
end;

procedure TCSV.ShowToolClick(Sender: TObject);
begin
  Tool.Show;
end;

procedure TCSV.ChartHeightControlChange(Sender: TObject);
begin
  Chart1.Height:= ChartHeightControl.Position;
  Chart2.Height:= ChartHeightControl.Position;
  Chart3.Height:= ChartHeightControl.Position;
  Chart4.Height:= ChartHeightControl.Position;
  Chart5.Height:= ChartHeightControl.Position;
  Chart6.Height:= ChartHeightControl.Position;
  Chart7.Height:= ChartHeightControl.Position;
  Chart8.Height:= ChartHeightControl.Position;
end;

procedure StickLabel(ChartLineSerie: TLineSeries);
var y: Double;
    x: TDateTime;
begin
  if ChartLineSerie.Count > 0 then begin
     x:= ChartLineSerie.GetXValue(ChartPointIndex);
     y:= ChartLineSerie.GetYValue(ChartPointIndex);
     ChartLineSerie.ListSource.Item[ChartPointIndex]^.Text := FloatToStrF(y, ffFixed, 12, 3) + LN + DateTimeToStr(x);
     ChartLineSerie.ParentChart.Repaint;
  end;
end;

procedure TCSV.ChartToolset1DataPointClickTool2AfterMouseUp(ATool: TChartTool;
  APoint: TPoint);
begin
 if LabelSticked then begin
    StickLabel(Chart1LineSeries1);
    StickLabel(Chart1LineSeries2);
    StickLabel(Chart1LineSeries3);
    StickLabel(Chart1LineSeries4);
    StickLabel(Chart1LineSeries5);
    StickLabel(Chart1LineSeries6);
    StickLabel(Chart1LineSeries7);
    StickLabel(Chart1LineSeries8);
    LabelSticked:= false;
  end;
end;

procedure TCSV.ChartToolset1DataPointClickTool2PointClick(ATool: TChartTool;
  APoint: TPoint);
var y: Double;
    x: TDateTime;
begin
  with ATool as TDatapointClickTool do begin
    if (Series is TLineSeries) then
      with TLineSeries(Series) do begin
        ChartPointIndex:= PointIndex;
        x:= GetXValue(PointIndex);
        y:= GetYValue(PointIndex);
        if ListSource.Item[PointIndex]^.Text = '' then ListSource.Item[PointIndex]^.Text := FloatToStrF(y, ffFixed, 12, 3) + LN + DateTimeToStr(x)
        else ListSource.Item[PointIndex]^.Text := '';
        ParentChart.Repaint;
        LabelSticked:= true;
      end;
  end;
end;

function SWHint(SW: Integer; SWDecr: array of String70; DT: TDateTime): String;
var i: Integer;
    wStr: String;
    zero: Boolean;
begin
   wStr:= DateTimeToStr(DT) + LN;
   zero:= true;
   for i:=0 to 15 do begin
     if (SW and expon2(i)) > 0 then begin
       wStr:= wStr + '1 - ' + SWDecr[i] + LN;
       zero:= false;
     end;
   end;
   if zero then SWHint:= wStr + '0'
   else SWHint:= wStr;
end;

procedure TCSV.ChartToolset1DataPointHintTool1Hint(ATool: TDataPointHintTool;
  const APoint: TPoint; var AHint: String);
var y: Double;
    x: TDateTime;

begin
   x:= TLineSeries(ATool.Series).GetXValue(ATool.PointIndex);
   y:= TLineSeries(ATool.Series).GetYValue(ATool.PointIndex);
   if TLineSeries(ATool.Series).ParentChart.Title.Text[0] = 'STATUS.SIBR.HI' then AHint:= SWHint(Round(y), SWHi, x)
   else if TLineSeries(ATool.Series).ParentChart.Title.Text[0] = 'STATUS.SIBR.LO' then AHint:= SWHint(Round(y), SWLo, x)
        else if TLineSeries(ATool.Series).ParentChart.Title.Text[0] = 'ESTATUS.SIBR.LO' then AHint:= SWHint(Round(y), ESWLo, x)
             else AHint:= FloatToStrF(y, ffFixed, 12, 3) + LN + DateTimeToStr(x);
end;

procedure DrawChart(Chart1LineSeries: TLineSeries; SelectedParamName: String);
var i: Longint;
    ParamPos, TimePos: Integer;
    PowerReset: boolean;
    y: Single;
    x: TDateTime;
begin
  PowerReset:= false;
  TimePos:= GetParamPosition('RTCs');
  ParamPos:= GetParamPosition(SelectedParamName);
  Chart1LineSeries.Clear;
  Chart1LineSeries.ParentChart.Title.Text[0]:=SelectedParamName;
  Chart1LineSeries.ParentChart.Title.Font.Color:= Chart1LineSeries.SeriesColor;
  Chart1LineSeries.ParentChart.Height:= ChartHeight;
  Chart1LineSeries.Pointer.Pen.Color:= Chart1LineSeries.SeriesColor;
  Chart1LineSeries.Pointer.Brush.Color:= Chart1LineSeries.SeriesColor;

  for i:=1 to CSVContent.Count-1 do begin
    if YearOf(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i])))) > 2020 then begin

      if FindPart('AR?T?F', SelectedParamName) > 0 then y:= Amplitude(NameToInt(SelectedParamName), i)
      else if FindPart('PR?T?F', SelectedParamName) > 0 then y:= PhaseShift(NameToInt(SelectedParamName), i)
           else y:= StrToFloat(GetParamValue(ParamPos, CSVContent[i]));

        x:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i]))), hrsPlus);

        if PowerReset then begin
          if ShowPR then Chart1LineSeries.AddXY(x, y, 'P')
          else Chart1LineSeries.AddXY(x, y);
          PowerReset:= false;
        end
        else begin
          Chart1LineSeries.AddXY(x, y);
        end;

    end
    else begin
      if (StrToInt(GetParamValue(GetParamPosition('STATUS.SIBR.LO'), CSVContent[i])) and 1024) > 0 then PowerReset:= true;
    end;

  end;
  Chart1LineSeries.ParentChart.Visible:= True;
end;

procedure ChartsVisible(visible: Boolean);
begin
  CSV.Chart1.Visible:= visible;
  CSV.Chart2.Visible:= visible;
  CSV.Chart3.Visible:= visible;
  CSV.Chart4.Visible:= visible;
  CSV.Chart5.Visible:= visible;
  CSV.Chart6.Visible:= visible;
  CSV.Chart7.Visible:= visible;
  CSV.Chart8.Visible:= visible;
end;

procedure ResetZoom;
begin
  CSV.Chart1.ZoomFull;
  CSV.Chart2.ZoomFull;
  CSV.Chart3.ZoomFull;
  CSV.Chart4.ZoomFull;
  CSV.Chart5.ZoomFull;
  CSV.Chart6.ZoomFull;
  CSV.Chart7.ZoomFull;
  CSV.Chart8.ZoomFull;
end;

procedure ResetSeries;
begin
  CSV.Chart1LineSeries1.Clear;
  CSV.Chart1LineSeries2.Clear;
  CSV.Chart1LineSeries3.Clear;
  CSV.Chart1LineSeries4.Clear;
  CSV.Chart1LineSeries5.Clear;
  CSV.Chart1LineSeries6.Clear;
  CSV.Chart1LineSeries7.Clear;
  CSV.Chart1LineSeries8.Clear;
end;

procedure ResetCharts;
begin
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

// ***************** DRAW ******************************************************
procedure TCSV.DrawClick(Sender: TObject);
  var i, counter: Integer;
begin
  LabelSticked:= false;
  DrawClicked:= true;
  ReDraw:= true;
  ShowPR:= PowerResets.Checked;
  ChartHeight:= ChartHeightControl.Position;
  ResetCharts;
  for i:=0 to NumOsCharts - 1 do SelectedParams[i]:= '';
  counter:= 0;
  if SelectedChannels.Items.Count > 0 then begin
     for i:=0 to SelectedChannels.Items.Count - 1 do begin
        SelectedParams[counter]:= SelectedChannels.Items[i];
        counter:= counter + 1;
     end;
     if SelectedParams[0] <> '' then DrawChart(Chart1LineSeries1, SelectedParams[0]);
     if SelectedParams[1] <> '' then DrawChart(Chart1LineSeries2, SelectedParams[1]);
     if SelectedParams[2] <> '' then DrawChart(Chart1LineSeries3, SelectedParams[2]);
     if SelectedParams[3] <> '' then DrawChart(Chart1LineSeries4, SelectedParams[3]);
     if SelectedParams[4] <> '' then DrawChart(Chart1LineSeries5, SelectedParams[4]);
     if SelectedParams[5] <> '' then DrawChart(Chart1LineSeries6, SelectedParams[5]);
     if SelectedParams[6] <> '' then DrawChart(Chart1LineSeries7, SelectedParams[6]);
     if SelectedParams[7] <> '' then DrawChart(Chart1LineSeries8, SelectedParams[7]);
     App.ActivePage:= Graphs;
     if NewChart then ChartsCurrentExtent:= Chart1.GetFullExtent;
     if ChartsLink.Checked and Not NewChart and DrawClicked then begin
        SetHorizontalExtent(Chart1);
        SetHorizontalExtent(Chart2);
        SetHorizontalExtent(Chart3);
        SetHorizontalExtent(Chart4);
        SetHorizontalExtent(Chart5);
        SetHorizontalExtent(Chart6);
        SetHorizontalExtent(Chart7);
        SetHorizontalExtent(Chart8);
     end;
     NewChart:= false;
  end
  else ShowMessage('No parameters selected.');
end;

procedure TCSV.Chart1ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  if Not ReDraw and DrawClicked then ChartsCurrentExtent:= Chart1.CurrentExtent;
  ReDraw:= false;
  dr:= Chart1.CurrentExtent;
  Chart1.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
  StartZone:= dr.a.X;
  EndZone:= dr.b.X;
  LeftExtent.Caption:= FormatDateTime('dd-mm-yy hh:mm:ss', StartZone);
  RightExtent.Caption:= FormatDateTime('dd-mm-yy hh:mm:ss', EndZone);
  ExtentDuration.Caption:= IntToStr(MinutesBetween(StartZone, EndZone)) + ' min';
end;

procedure TCSV.Chart2ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  dr:= Chart2.CurrentExtent;
  Chart2.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
end;

procedure TCSV.Chart3ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  dr:= Chart3.CurrentExtent;
  Chart3.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
end;

procedure TCSV.Chart4ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  dr:= Chart4.CurrentExtent;
  Chart4.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
end;

procedure TCSV.Chart5ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  dr:= Chart5.CurrentExtent;
  Chart5.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
end;

procedure TCSV.Chart6ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  dr:= Chart6.CurrentExtent;
  Chart6.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
end;

procedure TCSV.Chart7ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  dr:= Chart7.CurrentExtent;
  Chart7.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
end;

procedure TCSV.Chart8ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  dr:= Chart8.CurrentExtent;
  Chart8.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
end;

procedure TCSV.ChartsLinkChange(Sender: TObject);
begin
   ChartExtentLink1.Enabled:= ChartsLink.Checked;
end;

procedure TCSV.ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool; APoint: TPoint);
var y: Double;
    x: TDateTime;
begin
  with ATool as TDatapointClickTool do begin
    if (Series is TLineSeries) then
      with TLineSeries(Series) do begin
        x:= GetXValue(PointIndex);
        y:= GetYValue(PointIndex);
        if ListSource.Item[PointIndex]^.Text = '' then ListSource.Item[PointIndex]^.Text := FloatToStrF(y, ffFixed, 12, 3) + LN + DateTimeToStr(x)
        else ListSource.Item[PointIndex]^.Text := '';
        ParentChart.Repaint;
      end;
  end;
end;

procedure TCSV.ComputedChannelsDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
begin
   with ComputedChannels do begin
     if FindPart('AR?T?F', Items[Index]) > 0 then Canvas.Font.Color:= clBlue;

     if (odSelected in State) then begin
       Canvas.Brush.Color:=clBlue;
       Canvas.Font.Color:=clWhite;
     end;

     Canvas.FillRect(ARect);
     Canvas.TextOut(ARect.Left, ARect.Top, Items[Index]);
    end
end;

procedure FillSelectedChannels;
var i: Integer;
begin
  CSV.SelectedChannels.Clear;
  for i:=0 to CSV.RawChannels.Items.Count - 1 do
     if CSV.RawChannels.Selected[i] then CSV.SelectedChannels.Items.Add(CSV.RawChannels.Items[i]);

  for i:=0 to CSV.ComputedChannels.Items.Count - 1 do
     if CSV.ComputedChannels.Selected[i] then CSV.SelectedChannels.Items.Add(CSV.ComputedChannels.Items[i]);
end;

procedure TCSV.ComputedChannelsSelectionChange(Sender: TObject; User: boolean);
var
    Pos: TPoint;
    i:   Integer;
begin
  Pos:= Mouse.CursorPos;
  Pos:= ComputedChannels.ScreenToClient(Pos);
  i:= ComputedChannels.GetIndexAtXY(Pos.X, Pos.Y);
  if ComputedChannels.Selected[i] and (ComputedChannels.SelCount + RawChannels.SelCount > NumOsCharts) then ComputedChannels.Selected[i]:= false
  else FillSelectedChannels;
end;

procedure TCSV.RawChannelsSelectionChange(Sender: TObject; User: boolean);
var
    Pos: TPoint;
    i:   Integer;
begin
  Pos:= Mouse.CursorPos;
  Pos:= RawChannels.ScreenToClient(Pos);
  i:= RawChannels.GetIndexAtXY(Pos.X, Pos.Y);
  if RawChannels.Selected[i] and (ComputedChannels.SelCount + RawChannels.SelCount > NumOsCharts) then RawChannels.Selected[i]:= false
  else FillSelectedChannels;
end;

procedure TCSV.EStatusLoChange(Sender: TObject);
  var i: Byte;
begin
  CurrentSW:= 'ESTATUS.SIBR.HI';
  if SWList.Cells[0, 0] <>'' then
    for i:=0 to 15 do begin
      SWList.Cells[1, i]:= ESWLo[i];
      SWList.Cells[0, i]:= SWList.Cells[0, i];
    end;
end;

procedure TCSV.FormCreate(Sender: TObject);
begin
  AmplsInmVolts:= true;
  CurrentSW:= 'STATUS.SIBR.LO';
  LocalTime.Value:= HoursBetween(nowUTC(), now());
  hrsPlus:= LocalTime.Value;
  prevHrsPlus:= hrsPlus;
  ToolTime.Caption:= 'Tool time + ' + IntToStr(hrsPlus) + ' hours';
  TestType.Items.Add('Air Test');
  TestType.Items.Add('Jack stand Test');
  TestType.Items.Add('Bench Test');
  TestType.Items.Add('Heat Test');
  TestType.Items.Add('Foil Test');
  TestType.ItemIndex:= 0;
  TestDate.Date:= Date;
end;

procedure TCSV.Image1Click(Sender: TObject);
begin
  DrawClick(Sender);
end;

procedure TCSV.Image2Click(Sender: TObject);
begin

end;

procedure TCSV.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Visible:= false;
end;

procedure TCSV.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Visible:= true;
  DrawClick(Sender);
end;

procedure TCSV.Image3Click(Sender: TObject);
begin
  ResetZoom
end;

procedure TCSV.Image4Click(Sender: TObject);
begin
  if SelectedChannels.Items.Count > 0 then ChartHeightControl.Position:= (CSV.Height - 90) div SelectedChannels.Items.Count;
  Chart1.Height:= ChartHeightControl.Position;
  Chart2.Height:= ChartHeightControl.Position;
  Chart3.Height:= ChartHeightControl.Position;
  Chart4.Height:= ChartHeightControl.Position;
  Chart5.Height:= ChartHeightControl.Position;
  Chart6.Height:= ChartHeightControl.Position;
  Chart7.Height:= ChartHeightControl.Position;
  Chart8.Height:= ChartHeightControl.Position;
end;

procedure TCSV.Image5Click(Sender: TObject);
begin
   DeleteLabels(Chart1LineSeries1);
   DeleteLabels(Chart1LineSeries2);
   DeleteLabels(Chart1LineSeries3);
   DeleteLabels(Chart1LineSeries4);
   DeleteLabels(Chart1LineSeries5);
   DeleteLabels(Chart1LineSeries6);
   DeleteLabels(Chart1LineSeries7);
   DeleteLabels(Chart1LineSeries8);
end;

procedure TCSV.LocalTimeChange(Sender: TObject);
begin
NewChart:= true;
  hrsPlus:= LocalTime.Value;
  ToolTime.Caption:= 'Tool time + ' + IntToStr(hrsPlus) + ' hours';
  RunStart.Caption:= DateTimePlusLocal(RunStart.Caption);
  RunEnd.Caption:= DateTimePlusLocal(RunEnd.Caption);
  StartTime.Text:= DateTimePlusLocal(StartTime.Text);
  EndTime.Text:= DateTimePlusLocal(EndTime.Text);
  ReportStartTime.Text:= DateTimePlusLocal(ReportStartTime.Text);
  ReportEndTime.Text:= DateTimePlusLocal(ReportEndTime.Text);
  prevHrsPlus:= hrsPlus;
end;

procedure TCSV.mVoltsChange(Sender: TObject);
begin
  AmplsInmVolts:= mVolts.Checked;
  with Tool do
    if mVolts.Checked then begin
      T1R1F1.Width:= 40;
      T1R2F1.Width:= 40;
      T2R1F1.Width:= 40;
      T2R2F1.Width:= 40;
      T3R1F1.Width:= 40;
      T3R2F1.Width:= 40;
      T1R1F2.Width:= 40;
      T1R2F2.Width:= 40;
      T2R1F2.Width:= 40;
      T2R2F2.Width:= 40;
      T3R1F2.Width:= 40;
      T3R2F2.Width:= 40;
    end
    else begin
      T1R1F1.Width:= 77;
      T1R2F1.Width:= 77;
      T2R1F1.Width:= 77;
      T2R2F1.Width:= 77;
      T3R1F1.Width:= 77;
      T3R2F1.Width:= 77;
      T1R1F2.Width:= 77;
      T1R2F2.Width:= 77;
      T2R1F2.Width:= 77;
      T2R2F2.Width:= 77;
      T3R1F2.Width:= 77;
      T3R2F2.Width:= 77;
    end;
end;

procedure TCSV.RawChannelsDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
begin
  with RawChannels do begin
     if FindPart('VR???F??', Items[Index]) > 0 then Canvas.Font.Color:= RGBToColor(0, 100, 0)
     else if Items[Index] in SystemChannels then Canvas.Font.Color:= clRed
          else if Items[Index] in VoltChannels then Canvas.Font.Color:= clBlue
               else Canvas.Font.Color:= clSilver;

      if (odSelected in State) then begin
        Canvas.Brush.Color:=clBlue;
        Canvas.Font.Color:=clWhite;
      end;

      Canvas.FillRect(ARect);
      Canvas.TextOut(ARect.Left, ARect.Top, Items[Index]);
   end
end;

procedure TCSV.StatusHiChange(Sender: TObject);
var i: Byte;
begin
  CurrentSW:= 'STATUS.SIBR.HI';
  if SWList.Cells[0, 0] <>'' then
    for i:=0 to 15 do begin
      SWList.Cells[1, i]:= SWHi[i];
      SWList.Cells[0, i]:= SWList.Cells[0, i];
    end;
end;

procedure TCSV.StatusLoChange(Sender: TObject);
var i: Byte;
begin
  CurrentSW:= 'STATUS.SIBR.LO';
  if SWList.Cells[0, 0] <>'' then
    for i:=0 to 15 do begin
      SWList.Cells[1, i]:= SWLo[i];
      SWList.Cells[0, i]:= SWList.Cells[0, i]
   end;
end;

procedure TCSV.SWListDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  if SWList.Cells[0, Arow]='1' then begin
     //SWList.Canvas.Brush.Color:=clRed;
     if (CurrentSW = 'ESTATUS.SIBR.HI') and (Arow = 5) then SWList.Canvas.Font.Color:=clBlue
     else SWList.Canvas.Font.Color:=clRed;
  end
  else SWList.Canvas.Font.Color:=clGreen;
  SWList.Canvas.FillRect(aRect);
  SWList.Canvas.TextOut(aRect.Left,aRect.Top,SWList.Cells[Acol,Arow]);
end;

procedure TCSV.SaveReportClick(Sender: TObject);
var  ReportFile: TextFile;
     DatReportFile: file of TSibrReportParam;
     wStr, FileName: String;
     i: Integer;
begin
  SaveDialog1.Filename:= 'SIB-R_#' + SerialNumber.Text + '_' + FormatDateTime('DD-MMM-YYYY', TestDate.Date) + '_Air_Test_Report.prn';
  if SaveDialog1.Execute then begin
    AssignFile(ReportFile, SaveDialog1.Filename);
    if not RPTOnly.Checked then begin
      try
        ReWrite(ReportFile);
        wStr:= ReportText.Text;
        Writeln(ReportFile, wStr);
        CloseFile(ReportFile);
      except
        on E: EInOutError do ShowMessage('File write error: ' + E.ClassName + '/' + E.Message)
      end;
    end;
    FileName:= StringReplace(SaveDialog1.Filename, '.prn', '', [rfReplaceAll, rfIgnoreCase]) + '.rpt';
    AssignFile(DatReportFile, FileName);
    try
      ReWrite(DatReportFile);
      for i:=0 to 62 do Write(DatReportFile, ReportParams[i]);
      CloseFile(DatReportFile);
    except
      on E: EInOutError do ShowMessage('File write error: ' + E.ClassName + '/' + E.Message)
    end;
  end;
end;

procedure TCSV.OpenCSVFastClick(Sender: TObject);
var ParamPos, LineLength, Counter: Integer;
    FSize, DurationInMinutes, i: Longint;
    StartRun: Boolean;
    EndRun, SubStr: String;
    StartRunDT, EndRunDT: TDateTime;
begin
  if OpenDialog1.Execute then
   begin
      ResetCharts;
      NewChart:= true;
      RawChannels.Clear;
      ComputedChannels.Clear;
      SelectedChannels.Clear;
      ReportText.Text:= '';
      ShowTool.Enabled:= false;
      CSVFileName:= OpenDialog1.FileName;
      OpenedFile.Text:= CSVFileName;
      try
        Generate.Enabled:= False;
        ProgressBar.Position:= 0;
        RecordsT.Caption:= '';
        FileSizeT.Caption:= '';
        RunStartT.Caption:= '';
        RunEndT.Caption:= '';
        DurationT.Caption:= '';

        StartRun:= false;
        FSize:= 0;

        if CSVContent is TStringList then FreeAndNil(CSVContent);
        CSVContent:= TStringList.Create;
        CSVContent.LoadFromFile(CSVFileName);
        LineLength:= Length(CSVContent[0]);

        Counter:= 0;
        for i:= 0 to LineLength-1 do begin
           if CSVContent[0][i] = ';' then Counter:= Counter + 1;
        end;
        setLength(ParamList, 0);
        setLength(ParamList, Counter);
        ParameterCount:= Counter;
        Counter:= 0;
        SubStr:= '';
        for i:= 0 to LineLength-1 do begin
           if CSVContent[0][i] = ';' then begin
              ParamList[Counter]:= Trim(SubStr);
              RawChannels.Items.Add(Trim(SubStr));
              Counter:= Counter + 1;
              SubStr:= '';
           end
           else SubStr:= SubStr + CSVContent[0][i];
        end;

        for i:= 0 to 15 do ComputedChannels.Items.Add(AmplitudeName(i));
        for i:= 0 to 15 do ComputedChannels.Items.Add(PhaseShiftName(i));

        ParamPos:= GetParamPosition('RTCs');
        hrsPlus:= LocalTime.Value;

        for i:=1 to CSVContent.Count-1 do begin
            FSize:= FSize + Length(CSVContent[i]);
            if not StartRun then begin
               if YearOf(UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i])))) <> 1970 then begin
                  StartRunDT:= IncHour(UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i]))), hrsPlus);
                  RunStart.Caption:= DateTimeToStr(StartRunDT);
                  StartTime.Text:= RunStart.Caption;
                  StartRun:= true;
               end
            end
            else begin
               if (YearOf(UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i])))) <> 1970) then begin
                  EndRun:= GetParamValue(ParamPos, CSVContent[i]);
               end
            end;
        end;

        EndRunDT:= IncHour(UnixToDateTime(StrToInt(EndRun)), hrsPlus);
        RunEnd.Caption:= DateTimeToStr(EndRunDT);
        EndTime.Text:= DateTimeToStr(EndRunDT);

        Records.Caption:= IntToStr(CSVContent.Count);
        ProgressBar.Max:= CSVContent.Count;
        CSVFileSize.Caption:= IntToStr(Round(FSize/1000))+' KB';
        DurationInMinutes:= MinutesBetween(StartRunDT, EndRunDT);
        Duration.Caption:= IntToStr(DurationInMinutes div 60) + ' h ' + IntToStr(DurationInMinutes mod 60) + ' m';
        EstimateFast.Enabled:= True;
        ReportTab.Enabled:= True;

        ReportStartTime.Text:= StartTime.Text;
        ReportEndTime.Text:= EndTime.Text;
        ZoneDuration.Caption:= IntToStr(DurationInMinutes) + ' min';

        FillParams;
      except
      on E: EInOutError do
        ShowMessage('Error: ' + E.Message);
      end;
   end;
end;

function SWString(SWName: String; exptd: Longint; TimePos: Integer; StartTimeDT, EndTimeDT: TDateTime): String;
var i, SW: Longint;
    PassFail: String;
    ParamPos: Integer;
    CurrentTime: TDateTime;
begin
  SW:= 0;
  ParamPos:= GetParamPosition(SWName);
  for i:=1 to CSVContent.Count-1 do begin
      CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i]))), hrsPlus);
      if (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
         SW:= SW or StrToInt(GetParamValue(ParamPos, CSVContent[i]));
      end;
  end;
  if SW <> exptd then PassFail:= 'Failed'
  else PassFail:= 'Passed';
  SWString:= SWLine(SWName, SW, exptd, PassFail);
end;

procedure TCSV.ReportClick(Sender: TObject);
var i, j, meanCount: Longint;
    ParamPos, TimePos, ParamCount: Integer;
    MinValue, MaxValue, Avarage, StdDiviation, Value: Double;
    AmplAvarage, PSAvarage, AmplValue, PSValue, MinAmplValue, MinPSValue, MaxAmplValue, MaxPSValue, AmplStdDiviation, PSStdDiviation: Double;
    wStr, PassFail: String;
    PSStrings: array[0..15] of String;
    CurrentTime, StartTimeDT, EndTimeDT: TDateTime;
begin
  if SerialNumber.Text <> '' then begin
      TimePos:= GetParamPosition('RTCs');
      StartTimeDT:= StrToDateTime(ReportStartTime.Text);
      EndTimeDT:= StrToDateTime(ReportEndTime.Text);
      ReportProgress.Max:= 46;
      ReportProgress.Position:= 0;
      wStr:= '';
      ParamCount:= 0;
      ZoneDuration.Caption:= IntToStr(MinutesBetween(StartTimeDT, EndTimeDT)) + ' min';

      wStr:= wStr + 'SIB-R S/N: ' + SerialNumber.Text + LN;
      wStr:= wStr + 'Test Date: ' + FormatDateTime('DD-MMM-YYYY', TestDate.Date) + LN;
      wStr:= wStr +  'Test Duration: ' + ZoneDuration.Caption + LN;
      wStr:= wStr +  'Test Comment: ' + Comment.Text + LN;

      wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + LN;
      wStr:= wStr + '                                                   ' + TestType.Text + LN;
      wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + LN;

      wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + LN;
      wStr:= wStr + 'Status Word     Dec   Hex    Bin              | Exptd   | Result' + LN;
      wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + LN;

      wStr:= wStr +  SWString('STATUS.SIBR.LO', 0, TimePos, StartTimeDT, EndTimeDT) + LN;
      wStr:= wStr +  SWString('STATUS.SIBR.HI', 0, TimePos, StartTimeDT, EndTimeDT) + LN;
      wStr:= wStr +  SWString('ESTATUS.SIBR.LO', 32, TimePos, StartTimeDT, EndTimeDT) + LN + LN;

      wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + LN;
      wStr:= wStr + '                                                                |              Tolerances              |' + LN;
      wStr:= wStr + 'Param          Mean        Min         Max         S.D.         | Minimum     Maximum     MaxS.D.      | Result' + LN;
      wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + LN;
      Avarage:= 0; StdDiviation:= 0; meanCount:= 0;
      for j:=0 to 30 do begin
        ParamPos:= GetParamPosition(SibrParams[j].name);
        Value:= StrToFloat(GetParamValue(ParamPos,CSVContent[1]));
        MinValue:= Value; MaxValue:= Value;
        meanCount:= 0;
        for i:=1 to CSVContent.Count-1 do begin
           CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i]))), hrsPlus);
           if (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
             Value:= StrToFloat(GetParamValue(ParamPos,CSVContent[i]));
             if Value < MinValue then MinValue:=Value;
             if Value > MaxValue then MaxValue:=Value;
             Avarage:= Avarage + Value;
             meanCount:= meanCount + 1;
           end
        end;
        Avarage:= Avarage/meanCount;
        for i:=1 to CSVContent.Count-1 do begin
          CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i]))), hrsPlus);
          if (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
             Value:= StrToFloat(GetParamValue(ParamPos,CSVContent[i]));
             StdDiviation:= StdDiviation + Sqr(Value-Avarage);
          end
        end;
        StdDiviation:= Sqrt(StdDiviation/meanCount);
        if (Avarage < SibrParams[j].min) or (Avarage > SibrParams[j].max) or (StdDiviation > SibrParams[j].stdDev) then PassFail:= 'Failed'
        else PassFail:= 'Passed';
        ReportParams[ParamCount].name:= SibrParams[j].name;
        ReportParams[ParamCount].min:= MinValue;
        ReportParams[ParamCount].max:= MaxValue;
        ReportParams[ParamCount].mean:= Avarage;
        ReportParams[ParamCount].stdDev:= StdDiviation;
        ReportParams[ParamCount].k:= SibrParams[j].k;
        ReportParams[ParamCount].m:= SibrParams[j].m;
        ParamCount:= ParamCount + 1;
        wStr:= wStr + ParamLine(SibrParams[j].name, Avarage, MinValue, MaxValue, StdDiviation, SibrParams[j].min,  SibrParams[j].max, SibrParams[j].stdDev, SibrParams[j].k, SibrParams[j].m, PassFail)+ LN;
        ReportProgress.Position:= ReportProgress.Position + 1;
      end;
      ReportText.Text:= wStr;

      // *************   Amplitudes & Phases   *************************
      AmplAvarage:= 0; AmplStdDiviation:= 0;
      PSAvarage:= 0; PSStdDiviation:= 0;

      for j:=1 to 16 do begin
        GetResParameters(AmplValue, PSValue, j-1, i);
        MinAmplValue:= AmplValue; MaxAmplValue:= AmplValue;
        MinPSValue:= PSValue; MaxPSValue:= PSValue;
        for i:=1 to CSVContent.Count-1 do begin
           CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i]))), hrsPlus);
           if (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
             GetResParameters(AmplValue, PSValue, j-1, i);
             if AmplValue < MinAmplValue then MinAmplValue:= AmplValue;
             if AmplValue > MaxAmplValue then MaxAmplValue:= AmplValue;
             if PSValue < MinPSValue then MinPSValue:= PSValue;
             if PSValue > MaxPSValue then MaxPSValue:= PSValue;
             AmplAvarage:= AmplAvarage + AmplValue;
             PSAvarage:= PSAvarage + PSValue;
           end;
        end;
        AmplAvarage:=AmplAvarage/meanCount;
        PSAvarage:=PSAvarage/meanCount;
        for i:=1 to CSVContent.Count-1 do begin
           CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i]))), hrsPlus);
           if (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
             GetResParameters(AmplValue, PSValue, j-1, i);
             AmplStdDiviation:= AmplStdDiviation + Sqr(AmplValue - AmplAvarage);
             PSStdDiviation:= PSStdDiviation + Sqr(PSValue - PSAvarage);
           end;
        end;
        AmplStdDiviation:= Sqrt(AmplStdDiviation/meanCount);
        PSStdDiviation:= Sqrt(PSStdDiviation/meanCount);

        ReportParams[ParamCount].name:= SibrParams[J+30].name;
        ReportParams[ParamCount].min:= MinAmplValue;
        ReportParams[ParamCount].max:= MaxAmplValue;
        ReportParams[ParamCount].mean:= AmplAvarage;
        ReportParams[ParamCount].k:= SibrParams[J+30].k;
        ReportParams[ParamCount].m:= SibrParams[J+30].m;
        ReportParams[ParamCount].stdDev:= AmplStdDiviation;
        ParamCount:= ParamCount + 1;

        ReportParams[ParamCount].name:= SibrParams[J+46].name;
        ReportParams[ParamCount].min:= MinPSValue;
        ReportParams[ParamCount].max:= MaxPSValue;
        ReportParams[ParamCount].mean:= PSAvarage;
        ReportParams[ParamCount].stdDev:= PSStdDiviation;
        ReportParams[ParamCount].k:= SibrParams[J+46].k;
        ReportParams[ParamCount].m:= SibrParams[J+46].m;
        ParamCount:= ParamCount + 1;

        wStr:= wStr + ParamLine(SibrParams[J+30].name, AmplAvarage, MinAmplValue, MaxAmplValue, AmplStdDiviation, SibrParams[J+30].min,  SibrParams[J+30].max, SibrParams[J+30].stdDev, SibrParams[J+30].k, SibrParams[J+30].m, PassFail) + LN;
        PSStrings[j-1]:= ParamLine(SibrParams[J+46].name, PSAvarage, MinPSValue, MaxPSValue, PSStdDiviation, SibrParams[J+46].min,  SibrParams[J+46].max, SibrParams[J+46].stdDev, SibrParams[J+46].k, SibrParams[J+46].m, PassFail) + LN;
        ReportProgress.Position:= ReportProgress.Position + 1;
      end;
      for i:= 0 to 15 do wStr:= wStr + PSStrings[i];
      ReportText.Text:= wStr;

      Tool.T1R1F1.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR1T1F1'), ffFixed, 10, 3);
      Tool.T1R2F1.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR2T1F1'), ffFixed, 10, 3);
      Tool.T2R1F1.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR1T2F1'), ffFixed, 10, 3);
      Tool.T2R2F1.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR2T2F1'), ffFixed, 10, 3);
      Tool.T3R1F1.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR1T3F1'), ffFixed, 10, 3);
      Tool.T3R2F1.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR2T3F1'), ffFixed, 10, 3);
      Tool.T1R1F2.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR1T1F2'), ffFixed, 10, 3);
      Tool.T1R2F2.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR2T1F2'), ffFixed, 10, 3);
      Tool.T2R1F2.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR1T2F2'), ffFixed, 10, 3);
      Tool.T2R2F2.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR2T2F2'), ffFixed, 10, 3);
      Tool.T3R1F2.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR1T3F2'), ffFixed, 10, 3);
      Tool.T3R2F2.Caption:= ' ' + FloatToStrF(GetReportAmpl('AR2T3F2'), ffFixed, 10, 3);
      ShowTool.Enabled:= true;
   end
   else ShowMessage('Please enter a Seral Number');
end;
end.

