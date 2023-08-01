unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, MaskEdit, DateUtils, Clipbrd, StrUtils, LConvEncoding,
  TAGraph, TACustomSource, LazSysUtils, TASeries, TATools, DateTimePicker,
  Unit2, Unit3, Unit4, Unit6, Unit7, Panel, Options, Types, TAChartUtils,
  TADataTools, TAChartExtentLink, TATransformations, SpinEx, SynHighlighterCpp,
  LCLType, Spin, IniPropStorage, Parameters, PQConnection, Math, uComplex,
  TAChartAxisUtils, TAChartAxis;

type

  { TCSV }

  TCSV = class(TForm)
    App: TPageControl;
    AutoFit: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    AddPane: TButton;
    Button4: TButton;
    ChartExtentLink3: TChartExtentLink;
    ChartToolset2: TChartToolset;
    ChartToolset2AxisClickTool1: TAxisClickTool;
    ChartToolset2DataPointHintTool1: TDataPointHintTool;
    ChartToolset2PanDragTool1: TPanDragTool;
    ChartToolset2ZoomDragTool1: TZoomDragTool;
    ChartToolset2ZoomMouseWheelTool1: TZoomMouseWheelTool;
    ChartToolset2ZoomMouseWheelTool2: TZoomMouseWheelTool;
    ChartToolset2ZoomMouseWheelTool3: TZoomMouseWheelTool;
    RemoveExtremes: TCheckBox;
    TimeOnBottom: TCheckBox;
    FastMode: TCheckBox;
    Image1: TImage;
    Image2: TImage;
    Fast: TLabel;
    PanelTitle: TLabel;
    Slow: TLabel;
    RecordCount: TLabel;
    OptionsBtn: TImage;
    Memo1: TMemo;
    Pane10: TChart;
    Pane3Curve2: TLineSeries;
    Pane3Curve3: TLineSeries;
    Pane3Curve4: TLineSeries;
    Pane4Curve1: TLineSeries;
    Pane4Curve2: TLineSeries;
    Pane4Curve3: TLineSeries;
    Pane4Curve4: TLineSeries;
    Pane5Curve1: TLineSeries;
    Pane5Curve2: TLineSeries;
    Pane5Curve3: TLineSeries;
    Pane5Curve4: TLineSeries;
    Pane6Curve1: TLineSeries;
    Pane6Curve2: TLineSeries;
    Pane6Curve3: TLineSeries;
    Pane6Curve4: TLineSeries;
    Pane7Curve1: TLineSeries;
    Pane7Curve2: TLineSeries;
    Pane7Curve3: TLineSeries;
    Pane7Curve4: TLineSeries;
    Pane8Curve1: TLineSeries;
    Pane8Curve2: TLineSeries;
    Pane8Curve3: TLineSeries;
    Pane8Curve4: TLineSeries;
    Pane9Curve1: TLineSeries;
    Pane9Curve2: TLineSeries;
    Pane9Curve3: TLineSeries;
    Pane9Curve4: TLineSeries;
    Pane10Curve1: TLineSeries;
    Pane10Curve2: TLineSeries;
    Pane10Curve3: TLineSeries;
    Pane10Curve4: TLineSeries;
    Pane2Curve1: TLineSeries;
    Pane2Curve2: TLineSeries;
    Pane2Curve3: TLineSeries;
    Pane2Curve4: TLineSeries;
    Pane3Curve1: TLineSeries;
    Pane2: TChart;
    Pane3: TChart;
    Pane4: TChart;
    Pane5: TChart;
    Pane6: TChart;
    Pane7: TChart;
    Pane8: TChart;
    Pane9: TChart;

    CurvesTab: TTabSheet;
    Image6: TImage;
    LDivider: TLabel;
    Label41: TLabel;
    GetRangeBtn: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Chart9: TChart;
    Chart9LineSeries1: TLineSeries;
    Chart9LineSeries2: TLineSeries;
    ChartExtentLink2: TChartExtentLink;
    ByTemperature: TRadioButton;
    Image4: TImage;
    Results: TMemo;
    Pane1: TChart;
    Pane1Curve1: TLineSeries;
    Pane1Curve2: TLineSeries;
    Pane1Curve3: TLineSeries;
    Pane1Curve4: TLineSeries;
    RTCBugs: TCheckBox;
    mVolts: TCheckBox;
    ParametersList: TTabSheet;
    ParamsGrid: TStringGrid;
    Divider: TSpinEdit;
    ScrollBox2: TScrollBox;
    ShowDateTime: TCheckBox;
    TabSheet5: TTabSheet;
    TimeScale: TRadioButton;
    ByDots: TRadioButton;
    NewPanel: TToggleBox;
    RecordsNumber: TTrackBar;
    ZoneFromChart: TCheckBox;
    CommonBar: TProgressBar;
    ComputedChannels: TListBox;
    GroupBox7: TGroupBox;
    DrawBtnReleased: TImage;
    DrawBtn: TImage;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    LocalTime: TSpinEdit;
    PowerResets: TCheckBox;
    RawChannels: TListBox;
    SelectedChannels: TListBox;
    ShowCSondes: TButton;
    ShowSondes: TButton;
    Sondes1: TChart;
    Sondes2: TChart;
    Sondes3: TChart;
    SondesLineSeries1: TLineSeries;
    Sondes: TChart;
    IniPropStorage1: TIniPropStorage;
    ShowTool: TButton;
    Chart2LineSeries1: TLineSeries;
    Chart3LineSeries1: TLineSeries;
    Chart4LineSeries1: TLineSeries;
    Chart5LineSeries1: TLineSeries;
    Chart6LineSeries1: TLineSeries;
    Chart7LineSeries1: TLineSeries;
    Chart8LineSeries1: TLineSeries;
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
    SondesLineSeries10: TLineSeries;
    SondesLineSeries11: TLineSeries;
    SondesLineSeries12: TLineSeries;
    SondesLineSeries13: TLineSeries;
    SondesLineSeries14: TLineSeries;
    SondesLineSeries15: TLineSeries;
    SondesLineSeries16: TLineSeries;
    SondesLineSeries17: TLineSeries;
    SondesLineSeries18: TLineSeries;
    SondesLineSeries19: TLineSeries;
    SondesLineSeries2: TLineSeries;
    SondesLineSeries20: TLineSeries;
    SondesLineSeries21: TLineSeries;
    SondesLineSeries22: TLineSeries;
    SondesLineSeries23: TLineSeries;
    SondesLineSeries24: TLineSeries;
    SondesLineSeries3: TLineSeries;
    SondesLineSeries4: TLineSeries;
    SondesLineSeries5: TLineSeries;
    SondesLineSeries6: TLineSeries;
    SondesChart: TTabSheet;
    SondesLineSeries7: TLineSeries;
    SondesLineSeries8: TLineSeries;
    SondesLineSeries9: TLineSeries;
    TabSheet4: TTabSheet;
    CSondes: TTabSheet;
    TestType: TComboBox;
    RPTOnly: TCheckBox;
    Label33: TLabel;
    CSVFileSize: TLabel;
    Duration: TLabel;
    DurationT: TLabel;
    TabSheet3: TTabSheet;
    ToolTime: TLabel;
    OpenedFile: TEdit;
    ExtentDuration: TStaticText;
    GroupBox9: TGroupBox;
    Image3: TImage;
    FitToWin: TImage;
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
    ProgressBar: TProgressBar;
    ReportProgress: TProgressBar;
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
    Chart1UserDrawnSeries1: TUserDrawnSeries;
    OpenDialog1: TOpenDialog;
    SaveReport: TButton;
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
    procedure AddPaneClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ByDotsChange(Sender: TObject);
    procedure ByTemperatureChange(Sender: TObject);
    procedure ChartToolset2AxisClickTool1Click(ASender: TChartTool;
      Axis: TChartAxis; AHitInfo: TChartAxisHitTests);
    procedure ChartToolset2DataPointHintTool1Hint(ATool: TDataPointHintTool;
      const APoint: TPoint; var AHint: String);
    procedure FastModeChange(Sender: TObject);
    procedure GetRangeBtnClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Chart1AxisList1GetMarkText(Sender: TObject; var AText: String;
      AMark: Double);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Label41Click(Sender: TObject);
    procedure NewPanelChange(Sender: TObject);
    procedure Pane1AxisList0GetMarkText(Sender: TObject; var AText: String;
      AMark: Double);
    procedure Pane1ExtentChanged(ASender: TChart);
    procedure RecordsNumberChange(Sender: TObject);
    procedure RemoveExtremesChange(Sender: TObject);
    procedure RTCBugsChange(Sender: TObject);
    procedure ShowCSondesClick(Sender: TObject);
    procedure ShowDateTimeChange(Sender: TObject);
    procedure ShowSondesClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ShowToolClick(Sender: TObject);
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
    procedure ChartPointsChange(Sender: TObject);
    procedure ChartsLinkChange(Sender: TObject);
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure ComputedChannelsDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure ComputedChannelsSelectionChange(Sender: TObject; User: boolean);
    procedure EStatusLoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OptionsBtnClick(Sender: TObject);
    procedure DrawBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DrawBtnMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3Click(Sender: TObject);
    procedure FitToWinClick(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure LocalTimeChange(Sender: TObject);
    procedure mVoltsChange(Sender: TObject);
    procedure RawChannelsDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure RawChannelsSelectionChange(Sender: TObject; User: boolean);
    procedure StatusHiChange(Sender: TObject);
    procedure StatusLoChange(Sender: TObject);
    procedure SWListDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect);
    procedure SaveReportClick(Sender: TObject);
    procedure EstimateFastClick(Sender: TObject);
    procedure FullRangeClick(Sender: TObject);
    procedure GenerateClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OpenCSVFastClick(Sender: TObject);
    procedure ReportClick(Sender: TObject);
    procedure TimeOnBottomChange(Sender: TObject);
    procedure TimeScaleChange(Sender: TObject);
  private
  public
  end;

var
  CSV: TCSV;

procedure DrawChart(LineSerie: TLineSeries; SelectedParamName: String; ParameterNumber: Integer);
procedure ResetCharts;

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
            if (SecondsBetween(PrevTime,CurrentTime) >= Rate ) and
                 (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin;
               PrevTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine))), hrsPlus);
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
    if RecordRate.Text >= '0' then begin
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
              if (SecondsBetween(PrevTime,CurrentTime) >= Rate )
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
var i: Byte;
begin
  for i:=1 to 8 do TLineSeries(CSV.FindComponent('Chart'+ IntToStr(i) +'LineSeries1')).Pointer.Visible:= ChartPoints.Checked;
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
  var i, j: Byte;
begin
  Memo1.Text:= '';
    if FileExists('Panels.lib') then begin
       AssignFile(PanelsLibFile, 'Panels.lib');
       Reset(PanelsLibFile);
       try
         Seek(PanelsLibFile, GetLibIndex('Test'));
         Read(PanelsLibFile, CurvesPanel);
         CloseFile(PanelsLibFile);
         for i:= 0 to 9 do begin
           Memo1.Text:= Memo1.Text + 'Pane ' + IntToStr(i+1) + Line;
           for j:= 0 to 3 do begin
             Memo1.Text:= Memo1.Text + '    Parameter: ' + CurvesPanel.PaneSet.Panes[i].Curves[j].Parameter + Line;
             Memo1.Text:= Memo1.Text + '    ParameterTitle: ' + CurvesPanel.PaneSet.Panes[i].Curves[j].ParameterTitle + Line;
           end;
         end;

       except
         on E: EInOutError do ShowMessage('File read error: ' + E.Message);
       end;
    end
    else ShowMessage('Panels.lib');
end;

procedure TCSV.Button8Click(Sender: TObject);
var i: Integer;
    PoliCoeff: TDoubleArray;
    Step, X, Y: Double;
begin
  PoliCoeff:= Polinom(3, 8);
  for i:= 0 to 7 do begin
     Chart9LineSeries1.AddXY(Xi[i], Yi[i]);
  end;
  Step:= (1.85 - 0.215) / 50;
  X:= 0.1;
  for i:= 1 to 60 do begin
    X:= X + Step;
    Y:= PoliCoeff[0] + PoliCoeff[1]*X + PoliCoeff[2]*X*X + PoliCoeff[3]*X*X*X;
    Chart9LineSeries2.AddXY(X, Y);
  end;
end;

procedure TCSV.ByDotsChange(Sender: TObject);
begin
  ResetCharts;
end;

procedure TCSV.ByTemperatureChange(Sender: TObject);
begin
  ResetCharts;
end;

procedure TCSV.GetRangeBtnClick(Sender: TObject);
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
  ResetCharts;
  ParamsGrid.Clear;
  SelectedChannels.Clear;
  for i:=0 to CSV.RawChannels.Items.Count - 1 do CSV.RawChannels.Selected[i]:= false;
  for i:=0 to CSV.ComputedChannels.Items.Count - 1 do CSV.ComputedChannels.Selected[i]:= false;
end;

procedure TCSV.Button7Click(Sender: TObject);
begin
  Clipboard.AsText := OpenedFile.Text;
end;

procedure ZoomCurrentExtent(Chart1LineSeries: TLineSeries);
var i, start, count: Longint;
    dr: TDoubleRect;
    Max, Min: Double;
begin
 if Chart1LineSeries.Count > 0 then begin
   count:= Chart1LineSeries.Count;
   dr:= Chart1LineSeries.ParentChart.CurrentExtent;
   start:= 0;
   repeat
     start:= start + 1;
   until Chart1LineSeries.ListSource.Item[start]^.X >= dr.a.X;
   Max:= Chart1LineSeries.ListSource.Item[start]^.Y;
   Min:= Max;
   for i:=start to count-1 do begin
     if (Chart1LineSeries.ListSource.Item[i]^.X > dr.a.X) and (Chart1LineSeries.ListSource.Item[i]^.X < dr.b.X) then begin
        if Chart1LineSeries.ListSource.Item[i]^.Y < Min then Min:= Chart1LineSeries.ListSource.Item[i]^.Y;
        if Chart1LineSeries.ListSource.Item[i]^.Y > Max then Max:= Chart1LineSeries.ListSource.Item[i]^.Y;
     end;
   end;
   dr.a.Y:= Min;
   dr.b.Y:= Max;
   Chart1LineSeries.ParentChart.LogicalExtent:= dr;
 end;
end;

procedure TCSV.Chart1AxisList1GetMarkText(Sender: TObject; var AText: String; AMark: Double);
var DateTime: TDateTime;
    year, month, day: Word;
begin
   if ByDots.Checked then begin
     if (AMark >= 1) And (AMark < CSVContent.Count) then begin
       DateTime:= UnixToDateTime(StrToInt(GetParamValue(TimePosition, CSVContent[Trunc(AMark)])));
       AText:= TimeToStr(DateTime) + Line + FormatDateTime('DD MMM', DateTime);
     end
     else AText:= '';
   end
   else if TimeScale.Checked then begin
           AText:= TimeToStr(AMark) + Line + FormatDateTime('DD MMM', AMark);
        end
        else AText:= FloatToStrF(AMark, ffFixed, 3, 1);
end;

procedure TCSV.Image1Click(Sender: TObject);
var i, j: integer;
    PanelEmpty: boolean;
    Data: TPanel;
begin
  PanelEmpty:= true;
  for i:= 0 to 9 do begin
    for j:= 0 to 3 do
        if CurvesPanel.PaneSet.Panes[i].Curves[j].Parameter <> '' then PanelEmpty:= false;
  end;
  if Not PanelEmpty then begin
    if FileExists('Panels.lib') then begin
      PanelsLib.PanelList.Clear;
      AssignFile(PanelsLibFile, 'Panels.lib');
      Reset(PanelsLibFile);
      try
         while not eof(PanelsLibFile) do begin
            Read(PanelsLibFile, Data);
            PanelsLib.PanelList.Items.Add(Data.Name);
         end;
         CloseFile(PanelsLibFile);
      except
         on E: EInOutError do ShowMessage('File read error: ' + E.Message);
      end;
    end
    else begin
       AssignFile(PanelsLibFile, 'Panels.lib');
       ReWrite(PanelsLibFile);
       CloseFile(PanelsLibFile);
    end;
    PanelsLib.Label1.Visible:= true;
    PanelsLib.PanelName.Visible:= true;
    PanelsLib.SaveLib.Visible:= true;
    PanelsLib.LoadLib.Visible:= false;
    PanelsLib.PanelList.Height:= 320;
    PanelsLib.LoadProgress.Visible:= false;
    PanelsLib.Show;
  end
  else ShowMessage('Panel is empty');
end;

procedure TCSV.Image2Click(Sender: TObject);
begin
  if FileExists('Panels.lib') then begin
     PanelsLib.PanelList.Clear;
     AssignFile(PanelsLibFile, 'Panels.lib');
     Reset(PanelsLibFile);
     try
       while not eof(PanelsLibFile) do begin
          Read(PanelsLibFile, CurvesPanel);
          PanelsLib.PanelList.Items.Add(CurvesPanel.Name);
       end;
       CloseFile(PanelsLibFile);
     except
       on E: EInOutError do ShowMessage('File read error: ' + E.Message);
     end;
     PanelsLib.PanelList.ItemIndex:= 0;
     PanelsLib.Label1.Visible:= false;
     PanelsLib.PanelName.Visible:= false;
     PanelsLib.SaveLib.Visible:= false;
     PanelsLib.LoadLib.Visible:= true;
     PanelsLib.PanelList.Height:= 336;
     PanelsLib.LoadProgress.Visible:= true;
     PanelsLib.Show;
  end
  else ShowMessage('Panels.lib not found');
end;

procedure TCSV.Image4Click(Sender: TObject);
var i: Byte;
begin
  for i:=1 to 8 do ZoomCurrentExtent(TLineSeries(CSV.FindComponent('Chart'+ IntToStr(i) +'LineSeries1')));
end;

procedure TCSV.Label41Click(Sender: TObject);
var i: Byte;
begin
  for i:=1 to 4 do ZoomCurrentExtent(TLineSeries(CSV.FindComponent('Curve'+ IntToStr(i))));
end;

procedure TCSV.NewPanelChange(Sender: TObject);
begin
  ResetPanes(2);
end;

procedure TCSV.Pane1AxisList0GetMarkText(Sender: TObject; var AText: String;
  AMark: Double);
var DateTime: TDateTime;
begin
  if CSVContent is TStringList  then begin
     if (AMark >= 1) And (AMark < CSVContent.Count) then begin
       DateTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePosition, CSVContent[Trunc(AMark)]))), hrsPlus);
       AText:= TimeToStr(DateTime) + Line + DateToStr(DateTime);
     end
     else AText:= '';
  end;
end;

procedure TCSV.RTCBugsChange(Sender: TObject);
begin
  ResetCharts;
end;

procedure TCSV.FormResize(Sender: TObject);
begin
  if AutoFit.Checked then FitToWinClick(Sender);
  Sondes.Height:= (CSV.Height - 50) div 2;
  Sondes1.Height:= (CSV.Height - 50) div 2;
  Sondes2.Height:= (CSV.Height - 50) div 2;
  Sondes3.Height:= (CSV.Height - 50) div 2;
  FitPanesToWindow;
end;

procedure TCSV.ShowToolClick(Sender: TObject);
begin
  Tool.Show;
end;

procedure TCSV.ChartHeightControlChange(Sender: TObject);
var i: Byte;
begin
  for i:=1 to 8 do TChart(CSV.FindComponent('Chart'+ IntToStr(i))).Height:= ChartHeightControl.Position;
end;

procedure SondesVisible(visible: Boolean);
begin
  CSV.Sondes.Visible:= visible;
  CSV.Sondes1.Visible:= visible;
end;

procedure CSondesVisible(visible: Boolean);
begin
  CSV.Sondes2.Visible:= visible;
  CSV.Sondes3.Visible:= visible;
end;

procedure ResetZoomSondes;
begin
  CSV.Sondes.ZoomFull;
  CSV.Sondes1.ZoomFull;
end;

procedure ResetZoomCSondes;
begin
  CSV.Sondes2.ZoomFull;
  CSV.Sondes3.ZoomFull;
end;

procedure ResetSondesSeries;
begin
  CSV.SondesLineSeries1.Clear;
  CSV.SondesLineSeries2.Clear;
  CSV.SondesLineSeries3.Clear;
  CSV.SondesLineSeries4.Clear;
  CSV.SondesLineSeries5.Clear;
  CSV.SondesLineSeries6.Clear;
  CSV.SondesLineSeries7.Clear;
  CSV.SondesLineSeries8.Clear;
  CSV.SondesLineSeries9.Clear;
  CSV.SondesLineSeries10.Clear;
  CSV.SondesLineSeries11.Clear;
  CSV.SondesLineSeries12.Clear;
end;

procedure ResetCSondesSeries;
begin
  CSV.SondesLineSeries13.Clear;
  CSV.SondesLineSeries14.Clear;
  CSV.SondesLineSeries15.Clear;
  CSV.SondesLineSeries16.Clear;
  CSV.SondesLineSeries17.Clear;
  CSV.SondesLineSeries18.Clear;
  CSV.SondesLineSeries19.Clear;
  CSV.SondesLineSeries20.Clear;
  CSV.SondesLineSeries21.Clear;
  CSV.SondesLineSeries22.Clear;
  CSV.SondesLineSeries23.Clear;
  CSV.SondesLineSeries24.Clear;
end;

procedure ResetSondes;
begin
  ResetSondesSeries;
  ResetZoomSondes;
  SondesVisible(false);
end;

procedure ResetCSondes;
begin
  ResetCSondesSeries;
  ResetZoomCSondes;
  CSondesVisible(false);
end;

procedure FillZondes(x: TDateTime; i: Integer; zType: Byte; time: boolean);
var A16L_UNC, A22L_UNC, A34L_UNC, P16L_UNC, P22L_UNC, P34L_UNC, A16H_UNC, A22H_UNC, A34H_UNC, P16H_UNC, P22H_UNC, P34H_UNC: Double;
begin
  FillCoplexParams(i, 0);
  FillCoplexParams(i, 1);
  if Not SondeError then
  begin
    A16L_UNC:= -20*Log10(cMod(T1F1_UNC));
    A22L_UNC:= -20*Log10(cMod(T2F1_UNC));
    A34L_UNC:= -20*Log10(cMod(T3F1_UNC));
    A16H_UNC:= -20*Log10(cMod(T1F2_UNC));
    A22H_UNC:= -20*Log10(cMod(T2F2_UNC));
    A34H_UNC:= -20*Log10(cMod(T3F2_UNC));

    P16L_UNC:= angle(T1F1_UNC) * 180/Pi;
    P22L_UNC:= angle(T2F1_UNC) * 180/Pi;
    P34L_UNC:= angle(T3F1_UNC) * 180/Pi;
    P16H_UNC:= angle(T1F2_UNC) * 180/Pi;
    P22H_UNC:= angle(T2F2_UNC) * 180/Pi;
    P34H_UNC:= angle(T3F2_UNC) * 180/Pi;

    if zType = 0 then begin
      if time then begin
        CSV.SondesLineSeries1.AddXY(x, A16L_UNC);
        CSV.SondesLineSeries2.AddXY(x, A22L_UNC);
        CSV.SondesLineSeries3.AddXY(x, A34L_UNC);
        CSV.SondesLineSeries4.AddXY(x, A16H_UNC);
        CSV.SondesLineSeries5.AddXY(x, A22H_UNC);
        CSV.SondesLineSeries6.AddXY(x, A34H_UNC);
        CSV.SondesLineSeries7.AddXY(x, P16L_UNC);
        CSV.SondesLineSeries8.AddXY(x, P22L_UNC);
        CSV.SondesLineSeries9.AddXY(x, P34L_UNC);
        CSV.SondesLineSeries10.AddXY(x, P16H_UNC);
        CSV.SondesLineSeries11.AddXY(x, P22H_UNC);
        CSV.SondesLineSeries12.AddXY(x, P34H_UNC);
      end
      else begin
        CSV.SondesLineSeries1.AddXY(i, A16L_UNC);
        CSV.SondesLineSeries2.AddXY(i, A22L_UNC);
        CSV.SondesLineSeries3.AddXY(i, A34L_UNC);
        CSV.SondesLineSeries4.AddXY(i, A16H_UNC);
        CSV.SondesLineSeries5.AddXY(i, A22H_UNC);
        CSV.SondesLineSeries6.AddXY(i, A34H_UNC);
        CSV.SondesLineSeries7.AddXY(i, P16L_UNC);
        CSV.SondesLineSeries8.AddXY(i, P22L_UNC);
        CSV.SondesLineSeries9.AddXY(i, P34L_UNC);
        CSV.SondesLineSeries10.AddXY(i, P16H_UNC);
        CSV.SondesLineSeries11.AddXY(i, P22H_UNC);
        CSV.SondesLineSeries12.AddXY(i, P34H_UNC);
      end;
    end
    else begin
      if time then begin
        CSV.SondesLineSeries13.AddXY(x, Abs(A16L_UNC * a[1,1] + A22L_UNC * a[1,2] + A34L_UNC * a[1,3]));
        CSV.SondesLineSeries14.AddXY(x, Abs(A16L_UNC * a[2,1] + A22L_UNC * a[2,2] + A34L_UNC * a[2,3]));
        CSV.SondesLineSeries15.AddXY(x, Abs(A16L_UNC * a[3,1] + A22L_UNC * a[3,2] + A34L_UNC * a[3,3]));
        CSV.SondesLineSeries16.AddXY(x, Abs(A16H_UNC * a[1,1] + A22H_UNC * a[1,2] + A34H_UNC * a[1,3]));
        CSV.SondesLineSeries17.AddXY(x, Abs(A16H_UNC * a[2,1] + A22H_UNC * a[2,2] + A34H_UNC * a[2,3]));
        CSV.SondesLineSeries18.AddXY(x, Abs(A16H_UNC * a[3,1] + A22H_UNC * a[3,2] + A34H_UNC * a[3,3]));
        CSV.SondesLineSeries19.AddXY(x, Abs(P16L_UNC * a[1,1] + P22L_UNC * a[1,2] + P34L_UNC * a[1,3]));
        CSV.SondesLineSeries20.AddXY(x, Abs(P16L_UNC * a[2,1] + P22L_UNC * a[2,2] + P34L_UNC * a[2,3]));
        CSV.SondesLineSeries21.AddXY(x, Abs(P16L_UNC * a[3,1] + P22L_UNC * a[3,2] + P34L_UNC * a[3,3]));
        CSV.SondesLineSeries22.AddXY(x, Abs(P16H_UNC * a[1,1] + P22H_UNC * a[1,2] + P34H_UNC * a[1,3]));
        CSV.SondesLineSeries23.AddXY(x, Abs(P16H_UNC * a[2,1] + P22H_UNC * a[2,2] + P34H_UNC * a[2,3]));
        CSV.SondesLineSeries24.AddXY(x, Abs(P16H_UNC * a[3,1] + P22H_UNC * a[1,2] + P34H_UNC * a[3,3]));
      end
      else begin
        CSV.SondesLineSeries13.AddXY(i, Abs(A16L_UNC * a[1,1] + A22L_UNC * a[1,2] + A34L_UNC * a[1,3]));
        CSV.SondesLineSeries14.AddXY(i, Abs(A16L_UNC * a[2,1] + A22L_UNC * a[2,2] + A34L_UNC * a[2,3]));
        CSV.SondesLineSeries15.AddXY(i, Abs(A16L_UNC * a[3,1] + A22L_UNC * a[3,2] + A34L_UNC * a[3,3]));
        CSV.SondesLineSeries16.AddXY(i, Abs(A16H_UNC * a[1,1] + A22H_UNC * a[1,2] + A34H_UNC * a[1,3]));
        CSV.SondesLineSeries17.AddXY(i, Abs(A16H_UNC * a[2,1] + A22H_UNC * a[2,2] + A34H_UNC * a[2,3]));
        CSV.SondesLineSeries18.AddXY(i, Abs(A16H_UNC * a[3,1] + A22H_UNC * a[3,2] + A34H_UNC * a[3,3]));
        CSV.SondesLineSeries19.AddXY(i, Abs(P16L_UNC * a[1,1] + P22L_UNC * a[1,2] + P34L_UNC * a[1,3]));
        CSV.SondesLineSeries20.AddXY(i, Abs(P16L_UNC * a[2,1] + P22L_UNC * a[2,2] + P34L_UNC * a[2,3]));
        CSV.SondesLineSeries21.AddXY(i, Abs(P16L_UNC * a[3,1] + P22L_UNC * a[3,2] + P34L_UNC * a[3,3]));
        CSV.SondesLineSeries22.AddXY(i, Abs(P16H_UNC * a[1,1] + P22H_UNC * a[1,2] + P34H_UNC * a[1,3]));
        CSV.SondesLineSeries23.AddXY(i, Abs(P16H_UNC * a[2,1] + P22H_UNC * a[2,2] + P34H_UNC * a[2,3]));
        CSV.SondesLineSeries24.AddXY(i, Abs(P16H_UNC * a[3,1] + P22H_UNC * a[1,2] + P34H_UNC * a[3,3]));
      end;
    end;
  end;
end;

procedure ShowSonde(Sonde1, Sonde2: TChart; zType: Byte);
var x, Time: TDateTime;
    i, j, TimePos, StepCoefficient, MiliSecPos: Integer;
    MiliSec: LongInt;
begin
  if CSV.ZoneFromChart.Checked and (StartZone = EndZone) then ShowMessage('Time zone is not defined')
  else begin
      TimePos:= GetParamPosition('RTCs');
      MiliSecPos:= GetParamPosition('RTCms');
      if zType = 0 then begin
        ResetSondes;
        Sonde1.Title.Text[0]:='Uncompensated Sondes - Amplitudes';
        Sonde2.Title.Text[0]:='Uncompensated Sondes - Phases';
      end
      else begin
        ResetCSondes;
        Sonde1.Title.Text[0]:='Compensated Sondes - Amplitudes';
        Sonde2.Title.Text[0]:='Compensated Sondes - Phases';
      end;
      CSV.CommonBar.Max:= CSVContent.Count-1;
      CSV.CommonBar.Position:= 0;
      i:= 1;
      StepCoefficient:= Trunc(CSVContent.Count / CSV.RecordsNumber.Position);
      if StepCoefficient = 0 then StepCoefficient:= 1;
      if Not CSV.FastMode.Checked then StepCoefficient:= 1;
      //for i:=1 to CSVContent.Count-1 do begin
      while i < CSVContent.Count do begin
        if CSV.FastMode.Checked then begin
          for j:=1 to StepCoefficient do begin
            i:= i + 1;
          end;
          if i >= CSVContent.Count then i:= CSVContent.Count-1;
          CSV.CommonBar.Position:= CSV.CommonBar.Position + StepCoefficient;
        end;
        MiliSec:= StrToInt(GetParamValue(MiliSecPos, CSVContent[i]));
        Time:= UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i])));
        Time:= IncMilliSecond(Time, MiliSec);
        if (YearOf(Time) > 2020) or (Not CSV.TimeScale.Checked) or (Not CSV.RTCBugs.Checked) then begin
           if CSV.TimeScale.Checked then x:= IncHour(Time, hrsPlus);
           if CSV.ZoneFromChart.Checked then begin
             if (CompareDateTime(x, StartZone) = 1) and (CompareDateTime(x, EndZone) = -1) then begin
               FillZondes(x, i, zType, CSV.TimeScale.Checked)
             end;
           end
           else FillZondes(x, i, zType, CSV.TimeScale.Checked);
        end;
        CSV.CommonBar.Position:= CSV.CommonBar.Position + 1;
        i:= i + 1;
      end;
      CSV.CommonBar.Position:= 0;
      Sonde1.Height:= (CSV.Height - 50) div 2;
      Sonde2.Height:= (CSV.Height - 50) div 2;
      Sonde1.Visible:= True;
      Sonde2.Visible:= True;
      if zType = 0 then CSV.App.ActivePage:= CSV.SondesChart
      else CSV.App.ActivePage:= CSV.CSondes;
  end;
end;

procedure TCSV.ShowSondesClick(Sender: TObject);
begin
  ShowSonde(Sondes, Sondes1, 0);
end;

procedure TCSV.ShowCSondesClick(Sender: TObject);
begin
  ShowSonde(Sondes2, Sondes3, 1);
end;

procedure TCSV.ShowDateTimeChange(Sender: TObject);
begin
  if CSV.ShowDateTime.Checked then SetDateTimeVisible
  else HideRightAxises;
end;

procedure DrawChart(LineSerie: TLineSeries; SelectedParamName: String; ParameterNumber: Integer);
var i, j, n, CtrlTempPos, ParamPos, ParamLine, MiliSec: Longint;
    TimePos, MiliSecPos, StepCoefficient: Integer;
    PowerReset: boolean;
    y, yRaw, xCtrlTemp: Double;
    x, Time, PrevTime: TDateTime;
    Sticker: String;
begin
  PowerReset:= false;
  TimePos:= GetParamPosition('RTCs');
  MiliSecPos:= GetParamPosition('RTCms');
  CtrlTempPos:= GetParamPosition('TEMP_CTRL');
  ParamPos:= GetParamPosition(SelectedParamName);
  LineSerie.Clear;
  //ShowMessage(LineSerie.Name);
  LineSerie.ParentChart.Title.Text[0]:=SelectedParamName;
  LineSerie.ParentChart.Title.Font.Color:= LineSerie.SeriesColor;
  LineSerie.ParentChart.Height:= ChartHeight;
  LineSerie.Pointer.Pen.Color:= LineSerie.SeriesColor;
  LineSerie.Pointer.Brush.Color:= LineSerie.SeriesColor;
  PrevTime:= UnixToDateTime(0);
  CSV.CommonBar.Max:= CSVContent.Count - 1;
  CSV.CommonBar.Position:= 0;
  StepCoefficient:= Trunc(CSVContent.Count / CSV.RecordsNumber.Position);
  if StepCoefficient = 0 then StepCoefficient:= 1;
  if Not CSV.FastMode.Checked then StepCoefficient:= 1;
  i:= 0;
  n:= 1;
  ParamLine:= 1;
  while i < CSVContent.Count do begin
    if CSV.FastMode.Checked then begin
      for j:=1 to StepCoefficient do begin
        i:= i + 1;
      end;
      CSV.CommonBar.Position:= CSV.CommonBar.Position + StepCoefficient;
    end
    else i:= i + 1;
    if i >= CSVContent.Count then break;
    MiliSec:= StrToInt(GetParamValue(MiliSecPos, CSVContent[i]));
    Time:= UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i])));
    Time:= IncMilliSecond(Time, MiliSec);
    if (YearOf(Time) > 2020) or (Not CSV.TimeScale.Checked) or (Not CSV.RTCBugs.Checked) then begin
       if  SelectedParamName in CondChannels then y:= GetSonde(SelectedParamName, i)
       else if SelectedParamName in CondCompChannels then y:= GetCompSonde(SelectedParamName, i)
            else
                if FindPart('AR?T?F', SelectedParamName) > 0 then y:= Amplitude(NameToInt(SelectedParamName), i)
                else if FindPart('PR?T?F', SelectedParamName) > 0 then y:= PhaseShift(NameToInt(SelectedParamName), i)
                     else begin
                        TryStrToFloat(GetParamValue(ParamPos, CSVContent[i]), yRaw);
                        y:= yRaw;
                        if not TryStrToFloat(GetParamValue(ParamPos, CSVContent[i]), y) then y:= ParameterError;
                        if yRaw = +infinity then y:= 100000;
                        if yRaw = -infinity then y:= -100000;
                        if CSV.RemoveExtremes.Checked then begin
                           if (SelectedParamName = 'BHP') and ((y > 500) or (y < -50)) then y:= ParameterError;
                           if ((SelectedParamName = 'BHT') or (SelectedParamName = 'TEMP_CTRL')) and ((y > 300) or (y < -50)) then y:= ParameterError;
                        end;
                     end;
       Sticker:= '';
       if CSV.TimeScale.Checked then x:= IncHour(Time, hrsPlus);
       if CSV.ByTemperature.Checked then xCtrlTemp:= StrToFloat(GetParamValue(CtrlTempPos, CSVContent[i]));
       if Time < PrevTime then Sticker:= 'Back shift in time';
       if ShowPR and PowerReset then Sticker:= 'P';
       if y <> ParameterError then begin
          if CSV.TimeScale.Checked then begin
             LineSerie.AddXY(x, y, Sticker)
          end
          else if CSV.ByDots.Checked then LineSerie.AddXY(i, y, Sticker)
               else LineSerie.AddXY(xCtrlTemp, y, Sticker);
       end;
       PowerReset:= false;
       PrevTime:= Time;
    end
    else begin
      if (StrToInt(GetParamValue(GetParamPosition('STATUS.SIBR.LO'), CSVContent[i])) and 1024) > 0 then PowerReset:= true;
    end;

    if ParameterNumber > 0 then begin
      CSV.ParamsGrid.Cells[0, ParamLine]:= FormatDateTime('DD-MMM-YY hh:mm',IncHour(Time, hrsPlus));
      CSV.ParamsGrid.Cells[ParameterNumber, ParamLine]:= FloatToStrF(yRaw, ffFixed, 10, 3);
      ParamLine:= ParamLine + 1;
    end;

    CSV.CommonBar.Position:= CSV.CommonBar.Position + 1;
    //i:= i + 1;
    n:= n + 1;
  end;
  CSV.CommonBar.Position:= 0;
  LineSerie.ParentChart.Top:= 10000;
  LineSerie.ParentChart.Visible:= True;
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
     if TChart(CSV.FindComponent('Chart' + IntToStr(i))).Visible AND (TChart(CSV.FindComponent('Chart' + IntToStr(i))).Top > MaxTop) then begin
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
 for i:=1 to 8 do TLineSeries(CSV.FindComponent('Chart' + IntToStr(i) +'LineSeries1')).Clear;
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

// ***************** DRAW ******************************************************
procedure TCSV.DrawClick(Sender: TObject);
  var i, n: Integer;
begin
    LabelSticked:= false;
    DrawClicked:= true;
    ReDraw:= true;
    ShowPR:= PowerResets.Checked;
    ChartHeight:= ChartHeightControl.Position;
    ResetPanes(2);
    //ResetCharts;
    //ParamsGrid.Clear;
    ParamsGrid.ColCount:= 9;
    ParamsGrid.RowCount:= CSVContent.Count;
    ParamsGrid.ColWidths[0]:= 110;
    ParamsGrid.Cells[0, 0]:= 'Date/Time';
    ParamsGrid.Visible:= true;
    if SelectedChannels.Items.Count > 0 then begin

       for i:= 1 to 8 do begin
         if Not ChartInList(TChart(CSV.FindComponent('Chart' + IntToStr(i)))) then begin
            TLineSeries(CSV.FindComponent('Chart' + IntToStr(i) +'LineSeries1')).Clear;
            TChart(CSV.FindComponent('Chart' + IntToStr(i))).Visible:= false;
         end;
       end;

       for i:= 1 to SelectedChannels.Items.Count do begin
          ParamsGrid.Cells[i, 0]:= SelectedChannels.Items[i-1];
          if Not ListItemDrawed(SelectedChannels.Items[i-1]) then begin
             n:= GetFreeChart;
             DrawChart(TLineSeries(CSV.FindComponent('Chart' + IntToStr(n) +'LineSeries1')), SelectedChannels.Items[i-1], n);
          end;
       end;

       App.ActivePage:= Graphs;
       if NewChart then ChartsCurrentExtent:= Chart1.GetFullExtent;
       if ChartsLink.Checked and Not NewChart and DrawClicked then begin
         for i:=1 to 8 do SetHorizontalExtent(TChart(CSV.FindComponent('Chart' + IntToStr(i))));
       end;
       if AutoFit.Checked then FitToWinClick(Sender);
       CSV.TimeOnBottomChange(Sender);
       NewChart:= false;
    end
    else ShowMessage('No parameters selected.');
end;

procedure TCSV.Chart1ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  if CSV.ByTemperature.Checked or TimeOnBottom.Checked then ASender.Foot.Visible:= false
  else ASender.Foot.Visible:= true;
  if Not ReDraw and DrawClicked then ChartsCurrentExtent:= Chart1.CurrentExtent;
  ReDraw:= false;
  dr:= Chart1.CurrentExtent;
  if dr.a.X < 1 then dr.a.X:= 1;
  if CSV.TimeScale.Checked then ASender.Foot.Text[0]:= FormatDateTime('yyyy-mmm-dd hh:mm', dr.a.X)
  else if CSV.ByDots.Checked then ASender.Foot.Text[0]:= FormatDateTime('yyyy-mmm-dd hh:mm', UnixToDateTime(StrToInt(GetParamValue(TimePosition, CSVContent[Trunc(dr.a.X)]))));
  StartZone:= dr.a.X;
  EndZone:= dr.b.X;
  if TimeScale.Checked then begin
    LeftExtent.Caption:= FormatDateTime('dd-mm-yy hh:mm:ss', StartZone);
    RightExtent.Caption:= FormatDateTime('dd-mm-yy hh:mm:ss', EndZone);
    ExtentDuration.Caption:= IntToStr(MinutesBetween(StartZone, EndZone)) + ' min';
  end
  else begin
    LeftExtent.Caption:= '';
    RightExtent.Caption:= '';
    ExtentDuration.Caption:= '';
  end;
end;

procedure TCSV.Chart2ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
      LastChart: Byte;
begin
  if CSV.ByTemperature.Checked or TimeOnBottom.Checked then begin
     ASender.Foot.Visible:= false;
     LastChart:= GetLastChart;
     if LastChart > 0 then TChart(CSV.FindComponent('Chart' + IntToStr(LastChart))).Foot.Visible:= true;
  end
  else ASender.Foot.Visible:= true;
  dr:= ASender.CurrentExtent;
  if dr.a.X < 1 then dr.a.X:= 1;
  if CSV.TimeScale.Checked then ASender.Foot.Text[0]:= FormatDateTime('yyyy-mmm-dd hh:mm', dr.a.X)
  else if CSV.ByDots.Checked then ASender.Foot.Text[0]:= FormatDateTime('yyyy-mmm-dd hh:mm', UnixToDateTime(StrToInt(GetParamValue(TimePosition, CSVContent[Trunc(dr.a.X)]))));
end;

procedure TCSV.ChartsLinkChange(Sender: TObject);
begin
   ChartExtentLink1.Enabled:= ChartsLink.Checked;
end;

function GetSticker(x, y: Double): String;
begin
  if CSV.TimeScale.Checked then GetSticker:= FloatToStrF(y, ffFixed, 12, 6) + Line + DateTimeToStr(x)
        else if CSV.ByDots.Checked then GetSticker:= FloatToStrF(y, ffFixed, 12, 6) + Line + DateTimeToStr(UnixToDateTime(StrToInt(GetParamValue(TimePosition, CSVContent[Trunc(x)]))))
             else GetSticker:= FloatToStrF(y, ffFixed, 12, 3) + Line + FloatToStrF(x, ffFixed, 3, 2) + ' C deg';
end;

// Ctrl
procedure TCSV.ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool; APoint: TPoint);
var y: Double;
    x: TDateTime;
begin
  with ATool as TDatapointClickTool do begin
    if (Series is TLineSeries) then
      with TLineSeries(Series) do begin
        x:= GetXValue(PointIndex);
        y:= GetYValue(PointIndex);
        ChartPointIndex:= PointIndex;
        ListSource.Item[PointIndex]^.Text:= GetSticker(x, y);
        ParentChart.Repaint;
      end;
  end;
end;

// Alt
procedure TCSV.ChartToolset1DataPointClickTool2PointClick(ATool: TChartTool;
  APoint: TPoint);
var y: Double;
    x: TDateTime;
begin
  with ATool as TDatapointClickTool do begin
    if (Series is TLineSeries) then
      with TLineSeries(Series) do begin
        x:= GetXValue(PointIndex);
        y:= GetYValue(PointIndex);
        ChartPointIndex:= PointIndex;
        ListSource.Item[PointIndex]^.Text:= GetSticker(x, y);
        ParentChart.Repaint;
        LabelSticked:= true;
      end;
  end;
end;

procedure StickLabel(ChartLineSerie: TLineSeries);
var y: Double;
    x: TDateTime;
begin
  if ChartLineSerie.Count > 0 then begin
     x:= ChartLineSerie.GetXValue(ChartPointIndex);
     y:= ChartLineSerie.GetYValue(ChartPointIndex);
     ChartLineSerie.ListSource.Item[ChartPointIndex]^.Text:= GetSticker(x, y);
     ChartLineSerie.ParentChart.Repaint;
  end;
end;

procedure TCSV.ChartToolset1DataPointClickTool2AfterMouseUp(ATool: TChartTool;
  APoint: TPoint);
var i: Byte;
begin
 if LabelSticked then begin
   for i:=1 to 8 do StickLabel(TLineSeries(CSV.FindComponent('Chart'+ IntToStr(i) +'LineSeries1')));
   LabelSticked:= false;
  end;
end;

function SWHint(SW: Integer; SWDecr: array of String70; DT: TDateTime): String;
var i: Byte;
    wStr: String;
    zero: Boolean;
begin
   wStr:= DateTimeToStr(DT) + Line;
   zero:= true;
   for i:=0 to 15 do begin
     if (SW and expon2(i)) > 0 then begin
       wStr:= wStr + '1 - ' + SWDecr[i] + Line;
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
             else AHint:= GetSticker(x, y)
end;

procedure TCSV.ComputedChannelsDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
begin
   with ComputedChannels do begin
     if FindPart('AR?T?F', Items[Index]) > 0 then Canvas.Font.Color:= clBlue
     else if Items[Index] in CondChannels then Canvas.Font.Color:= RGBToColor(0, 100, 0)
          else if Items[Index] in CondCompChannels then Canvas.Font.Color:= RGBToColor(255, 0, 0);

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
var Pos: TPoint;
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
var i: Byte;
begin
  AmplsInmVolts:= mVolts.Checked;
  if AmplsInmVolts then begin
    Divider.Visible:= False;
    LDivider.Visible:= False;
  end
  else begin
    Divider.Visible:= True;
    LDivider.Visible:= True;
  end;
  if FastMode.Checked then begin
    RecordCount.Visible:= true;
    RecordsNumber.Enabled:= true;
    Fast.Font.Color:= clNavy;
    Slow.Font.Color:= clNavy;
  end;
  if CSV.TimeOnBottom.Checked then SetDateTimeOnBottom
  else ShowTimeAxises;
  CurrentSW:= 'STATUS.SIBR.LO';
  LocalTime.Value:= HoursBetween(nowUTC(), now());
  hrsPlus:= LocalTime.Value;
  prevHrsPlus:= hrsPlus;
  ToolTime.Caption:= 'Tool time + ' + IntToStr(hrsPlus) + ' hours';
  TestType.Items.Add('Air Test');
  TestType.Items.Add('Jack stand Test');
  //TestType.Items.Add('Bench Test');
  //TestType.Items.Add('Heat Test');
  TestType.Items.Add('Foil Test');
  TestType.ItemIndex:= 0;
  TestDate.Date:= Date;
  ChartHeightControl.Max:= CSV.Height - 30;
  for i:=1 to 8 do TLineSeries(CSV.FindComponent('Chart'+ IntToStr(i) +'LineSeries1')).Pointer.Visible:= ChartPoints.Checked;
  CSV.Pane1.Width:= CSV.Width Div 2;
  InitTransformations;
end;

procedure TCSV.OptionsBtnClick(Sender: TObject);
begin
  OptionsForm.DefaultColorsClick(Sender);
  OptionsForm.Show;
end;

procedure TCSV.DrawBtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawBtn.Visible:= false;
end;

procedure TCSV.DrawBtnMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  DrawBtn.Visible:= true;
  DrawClick(Sender);
end;

procedure TCSV.Image3Click(Sender: TObject);
begin
  ResetZoom;
end;

procedure TCSV.FitToWinClick(Sender: TObject);
var i: Byte;
begin
  if SelectedChannels.Items.Count > 1 then ChartHeightControl.Position:= (CSV.Height - 90) div SelectedChannels.Items.Count;
  if SelectedChannels.Items.Count = 1 then ChartHeightControl.Position:= CSV.Height - 30;
  for i:=1 to 8 do TChart(CSV.FindComponent('Chart'+ IntToStr(i))).Height:= ChartHeightControl.Position;
end;

procedure TCSV.Image5Click(Sender: TObject);
var i: Byte;
begin
  for i:=1 to 8 do DeleteLabels(TLineSeries(CSV.FindComponent('Chart'+ IntToStr(i) +'LineSeries1')));
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
  ResetCharts;
  AmplsInmVolts:= mVolts.Checked;
  if AmplsInmVolts then begin
    Divider.Visible:= False;
    LDivider.Visible:= False;
  end
  else begin
    Divider.Visible:= True;
    LDivider.Visible:= True;
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
  aRect: TRect);
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
      DecimalSeparator  := '.';
      ResetCharts;
      NewChart:= true;
      RawChannels.Clear;
      ComputedChannels.Clear;
      SelectedChannels.Clear;
      ReportText.Text:= '';
      CurvesTab.Enabled:= false;
      ReportTab.Enabled:= false;
      ShowTool.Enabled:= false;
      ShowSondes.Enabled:= false;
      ShowCSondes.Enabled:= false;
      GetRangeBtn .Enabled:= false;
      CSVFileName:= OpenDialog1.FileName;
      OpenedFile.Text:= CSVFileName;
      ParamsGrid.ColCount:= 2;
      ParamsGrid.RowCount:= 2;
      ParamsGrid.Visible:= false;
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
        for i:= 0 to 15 do ComputedChannels.Items.Add(CondChannels[i]);
        for i:= 0 to 11 do ComputedChannels.Items.Add(CondCompChannels[i]);

        ParamPos:= GetParamPosition('RTCs');
        TimePosition:= ParamPos;
        hrsPlus:= LocalTime.Value;

        for i:=1 to CSVContent.Count-1 do begin
            FSize:= FSize + Length(CSVContent[i]);
            if not StartRun then begin
               StartRunDT:= IncHour(UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i]))), hrsPlus);
               RunStart.Caption:= DateTimeToStr(StartRunDT);
               StartTime.Text:= RunStart.Caption;
               StartRun:= true;
            end
            else EndRun:= GetParamValue(ParamPos, CSVContent[i]);
        end;

        EndRunDT:= IncHour(UnixToDateTime(StrToInt(EndRun)), hrsPlus);
        RunEnd.Caption:= DateTimeToStr(EndRunDT);
        EndTime.Text:= DateTimeToStr(EndRunDT);

        Records.Caption:= IntToStr(CSVContent.Count);
        ProgressBar.Max:= CSVContent.Count;
        CSVFileSize.Caption:= IntToStr(Round(FSize/1000))+' KB';
        DurationInMinutes:= MinutesBetween(StartRunDT, EndRunDT);
        Duration.Caption:= IntToStr(DurationInMinutes div 60) + ' h ' + IntToStr(DurationInMinutes mod 60) + ' m';
        if TimeScale.Checked And RTCBugs.Checked then begin
           ReportTab.Enabled:= True;
           GetRangeBtn .Enabled:= True;
        end;
        EstimateFast.Enabled:= True;
        ShowSondes.Enabled:= True;
        ShowCSondes.Enabled:= True;
        CurvesTab.Enabled:= True;
        DrawBtn.Visible:= True;
        DrawBtnReleased.Visible:= True;

        ReportStartTime.Text:= StartTime.Text;
        ReportEndTime.Text:= EndTime.Text;
        ZoneDuration.Caption:= IntToStr(DurationInMinutes) + ' min';
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

procedure PrintAmplitudes(AR1Tx, AR2Tx: TStaticText);
var TxR1, TxR2: Double;
    FontColor: TColor;
begin
   TxR1:= GetReportAmpl(AR1Tx.Name);
   TxR2:= GetReportAmpl(AR2Tx.Name);
   AR1Tx.Caption:= ' ' + FloatToStrF(TxR1, ffFixed, 10, 3);
   AR2Tx.Caption:= ' ' + FloatToStrF(TxR2, ffFixed, 10, 3);
   if (AR1Tx.Name = 'AR1T2F1') or (AR1Tx.Name = 'AR1T2F2') then
      if TxR2 > TxR1 then FontColor:= clRed
      else FontColor:= clGreen
   else
      if TxR1 > TxR2 then FontColor:= clRed
      else FontColor:= clGreen;
   AR1Tx.Font.Color:= FontColor;
   AR2Tx.Font.Color:= FontColor;
   if FontColor = clRed then begin
     Tool.Warning.Caption:= 'Warning! Check receivers and trunsmitters positions';
     Warning:= True;
   end;
end;

procedure TCSV.ReportClick(Sender: TObject);
var i, j, meanCount, start: Longint;
    ParamPos, TimePos, ParamCount: Integer;
    MinValue, MaxValue, Avarage, StdDiviation, Value: Double;
    AmplAvarage, PSAvarage, AmplValue, PSValue, MinAmplValue, MinPSValue, MaxAmplValue, MaxPSValue, AmplStdDiviation, PSStdDiviation: Double;
    wStr, PassFail, PSPassFail: String;
    PSStrings: array[0..15] of String;
    CurrentTime, StartTimeDT, EndTimeDT: TDateTime;
begin
  if SerialNumber.Text <> '' then begin
      if (TestType.Text = 'Air Test') or (TestType.Text = 'Jack stand Test') then FillParamsAir
      else FillParamsFoil;
      TimePos:= GetParamPosition('RTCs');
      StartTimeDT:= StrToDateTime(ReportStartTime.Text);
      EndTimeDT:= StrToDateTime(ReportEndTime.Text);
      ReportProgress.Max:= 43;
      ReportProgress.Position:= 0;
      wStr:= '';
      ParamCount:= 0;
      ZoneDuration.Caption:= IntToStr(MinutesBetween(StartTimeDT, EndTimeDT)) + ' min';

      //if MinutesBetween(StartTimeDT, EndTimeDT) >= 5 then begin
      if true then begin

          wStr:= wStr + 'SIB-R S/N: ' + SerialNumber.Text + Line;
          wStr:= wStr + 'Test Date: ' + FormatDateTime('DD-MMM-YYYY', TestDate.Date) + Line;
          wStr:= wStr +  'Test Duration: ' + ZoneDuration.Caption + Line;
          wStr:= wStr +  'Test Comment: ' + Comment.Text + Line;

          wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + Line;
          wStr:= wStr + '                                                   ' + TestType.Text + Line;
          wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + Line;

          wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + Line;
          wStr:= wStr + 'Status Word     Dec   Hex    Bin              | Exptd   | Result' + Line;
          wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + Line;

          wStr:= wStr +  SWString('STATUS.SIBR.LO', 0, TimePos, StartTimeDT, EndTimeDT) + Line;
          if (TestType.Text = 'Foil Test') then wStr:= wStr +  SWString('STATUS.SIBR.HI', 40960, TimePos, StartTimeDT, EndTimeDT) + Line
          else wStr:= wStr +  SWString('STATUS.SIBR.HI', 0, TimePos, StartTimeDT, EndTimeDT) + Line;
          wStr:= wStr +  SWString('ESTATUS.SIBR.LO', 32, TimePos, StartTimeDT, EndTimeDT) + Line + Line;

          wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + Line;
          wStr:= wStr + '                                                                |              Tolerances              |' + Line;
          wStr:= wStr + 'Param          Mean        Min         Max         S.D.         | Minimum     Maximum     MaxS.D.      | Result' + Line;
          wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + Line;
          i:= 1;
          repeat
            CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i]))), hrsPlus);
            i:= i + 1;
          until (CompareDateTime(CurrentTime, StartTimeDT) = 1) or (i = CSVContent.Count-1);
          start:= i;

          for j:=0 to 30 do begin
              Avarage:= 0; StdDiviation:= 0; meanCount:= 0;
              ParamPos:= GetParamPosition(SibrParams[j].name);
              Value:= StrToFloat(GetParamValue(ParamPos,CSVContent[start]));
              MinValue:= Value; MaxValue:= Value;
              for i:=start to CSVContent.Count-1 do begin
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
              for i:=start to CSVContent.Count-1 do begin
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
              if FindPart('RES?', SibrParams[j].name) = 0 then begin
                wStr:= wStr + ParamLine(SibrParams[j].name, Avarage, MinValue, MaxValue, StdDiviation, SibrParams[j].min,  SibrParams[j].max, SibrParams[j].stdDev, SibrParams[j].k, SibrParams[j].m, PassFail)+ Line;
              end;
              ReportProgress.Position:= ReportProgress.Position + 1;
          end;
          ReportText.Text:= wStr;

          // *************   Amplitudes & Phases   *************************
          for j:=1 to 16 do begin
            AmplAvarage:= 0; AmplStdDiviation:= 0;
            PSAvarage:= 0; PSStdDiviation:= 0;
            GetResParameters(AmplValue, PSValue, j-1, start);
            MinAmplValue:= AmplValue; MaxAmplValue:= AmplValue;
            MinPSValue:= PSValue; MaxPSValue:= PSValue;
            for i:=start to CSVContent.Count-1 do begin
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
            for i:=start to CSVContent.Count-1 do begin
               CurrentTime:= IncHour(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i]))), hrsPlus);
               if (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
                 GetResParameters(AmplValue, PSValue, j-1, i);
                 AmplStdDiviation:= AmplStdDiviation + Sqr(AmplValue - AmplAvarage);
                 PSStdDiviation:= PSStdDiviation + Sqr(PSValue - PSAvarage);
               end;
            end;
            AmplStdDiviation:= Sqrt(AmplStdDiviation/meanCount);
            PSStdDiviation:= Sqrt(PSStdDiviation/meanCount);

            if (AmplAvarage < SibrParams[j+30].min) or (AmplAvarage > SibrParams[j+30].max) or (AmplStdDiviation > SibrParams[j+30].stdDev) then PassFail:= 'Failed'
            else PassFail:= 'Passed';

            if (PSAvarage < SibrParams[j+46].min) or (PSAvarage > SibrParams[j+46].max) or (PSStdDiviation > SibrParams[j+46].stdDev) then PSPassFail:= 'Failed'
            else PSPassFail:= 'Passed';

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

            wStr:= wStr + ParamLine(SibrParams[J+30].name, AmplAvarage, MinAmplValue, MaxAmplValue, AmplStdDiviation, SibrParams[J+30].min,  SibrParams[J+30].max, SibrParams[J+30].stdDev, SibrParams[J+30].k, SibrParams[J+30].m, PassFail) + Line;
            PSStrings[j-1]:= ParamLine(SibrParams[J+46].name, PSAvarage, MinPSValue, MaxPSValue, PSStdDiviation, SibrParams[J+46].min,  SibrParams[J+46].max, SibrParams[J+46].stdDev, SibrParams[J+46].k, SibrParams[J+46].m, PSPassFail) + Line;
            ReportProgress.Position:= ReportProgress.Position + 1;
          end;
          for i:= 0 to 15 do wStr:= wStr + PSStrings[i];
          ReportText.Text:= wStr;

          Tool.Warning.Caption:= '';

          Warning:= False;
          PrintAmplitudes(Tool.AR1T1F1, Tool.AR2T1F1);
          PrintAmplitudes(Tool.AR1T2F1, Tool.AR2T2F1);
          PrintAmplitudes(Tool.AR1T3F1, Tool.AR2T3F1);
          PrintAmplitudes(Tool.AR1T1F2, Tool.AR2T1F2);
          PrintAmplitudes(Tool.AR1T2F2, Tool.AR2T2F2);
          PrintAmplitudes(Tool.AR1T3F2, Tool.AR2T3F2);
          if ((TestType.Text = 'Air Test') or (TestType.Text = 'Jack stand Test')) and Warning then begin
             Application.MessageBox('Warning! Check receivers and trunsmitters positions', 'Warning', MB_ICONWARNING + MB_OK);
             Warning:= False;
          end;
          ShowTool.Enabled:= true;
      end
      else ShowMessage('Test duration should be more or equal 5 minutes');

   end
   else ShowMessage('Please enter a Seral Number');
end;

procedure TCSV.TimeOnBottomChange(Sender: TObject);
begin
  if CSV.TimeOnBottom.Checked then SetDateTimeOnBottom
  else ShowTimeAxises;
end;

procedure TCSV.TimeScaleChange(Sender: TObject);
begin
   ResetCharts;
   if TimeScale.Checked then begin
      ReportTab.Enabled:= True;
      GetRangeBtn .Enabled:= True;
   end
   else begin
      ReportTab.Enabled:= false;
      GetRangeBtn .Enabled:= false;
   end;
end;

procedure TCSV.ChartToolset2AxisClickTool1Click(ASender: TChartTool;
  Axis: TChartAxis; AHitInfo: TChartAxisHitTests);
var i, TrackNumber: Integer;
begin
  TrackNumber:= StrToInt(StringReplace(ASender.Chart.Name, 'Pane', '', [rfReplaceAll]));
  if (TrackNumber > 0) And (Axis.Index > 0) then begin
    PaneEdit.ParameterList.Clear;
    PaneEdit.PaneNumber.Caption:= 'Track ' + StringReplace(ASender.Chart.Name, 'Pane', '', [rfReplaceAll]);
    PaneEdit.AxisNumber.Caption:= 'Curve: ' + IntToStr(Axis.Index);
    PaneEdit.Parameter.Caption:= '';
    PaneEdit.ParameterTitle.Text:= '';
    for i:=0 to Length(AmplitudesChannels)-1 do PaneEdit.ParameterList.Items.Add(AmplitudesChannels[i]);
    for i:=0 to Length(PhaseChannels)-1 do PaneEdit.ParameterList.Items.Add(PhaseChannels[i]);
    for i:=0 to Length(SystemChannels)-1 do PaneEdit.ParameterList.Items.Add(SystemChannels[i]);
    for i:=0 to Length(VoltChannels)-1 do PaneEdit.ParameterList.Items.Add(VoltChannels[i]);

    if TrackNumber > 1 then begin
        PaneEdit.ColorBox.Selected:= CurvesPanel.PaneSet.Panes[TrackNumber - 2].Curves[Axis.Index - 1].SerieColor;
        PaneEdit.ChartComboBox2.PenWidth:= CurvesPanel.PaneSet.Panes[TrackNumber - 2].Curves[Axis.Index - 1].PenWidth;
        PaneEdit.ChartComboBox1.PenStyle:= CurvesPanel.PaneSet.Panes[TrackNumber - 2].Curves[Axis.Index - 1].PenStyle;
    end;

    PaneEdit.Show;
  end;
end;

procedure TCSV.ChartToolset2DataPointHintTool1Hint(ATool: TDataPointHintTool;
  const APoint: TPoint; var AHint: String);
var y: Double;
    x: TDateTime;

begin
   x:= TLineSeries(ATool.Series).GetXValue(ATool.PointIndex);
   y:= TLineSeries(ATool.Series).GetYValue(ATool.PointIndex);
   AHint:= GetSticker(x, y);
end;

procedure TCSV.FastModeChange(Sender: TObject);
begin
  if FastMode.Checked then begin
    RecordCount.Visible:= true;
    RecordsNumber.Enabled:= true;
    Fast.Font.Color:= clNavy;
    Slow.Font.Color:= clNavy;
  end
  else begin
    RecordCount.Visible:= false;
    RecordsNumber.Enabled:= false;
    Fast.Font.Color:= clSilver;
    Slow.Font.Color:= clSilver;
  end;
end;

procedure TCSV.AddPaneClick(Sender: TObject);
var i: Byte;
begin
  for i:=1 to 10 do begin
     if TChart(CSV.FindComponent('Pane' + IntToStr(i))).Visible = false then begin
        TChart(CSV.FindComponent('Pane' + IntToStr(i))).Left:= 10000;
        TChart(CSV.FindComponent('Pane' + IntToStr(i))).Visible:= true;
        Break;
     end;
  end;
  if CSV.ShowDateTime.Checked then SetDateTimeVisible;
  FitPanesToWindow;
end;

procedure TCSV.Pane1ExtentChanged(ASender: TChart);
var i: Integer;
    TitleUp: String;
begin
 if ASender.SeriesCount > 0 then
   for i := 0 to ASender.SeriesCount-1 do begin
     TitleUp:= Copy2Symb(ASender.AxisList[i + 1].Title.Caption, chr(13));
     CurveTitle(TLineSeries(ASender.Series[i]), TitleUp);
   end;
end;

procedure TCSV.RecordsNumberChange(Sender: TObject);
begin
  RecordCount.Caption:= IntToStr(RecordsNumber.Position) + ' records';
end;

procedure TCSV.RemoveExtremesChange(Sender: TObject);
begin
  ResetCharts;
end;

end.

