unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, MaskEdit, DateUtils,
  StrUtils, LConvEncoding, TAGraph, TACustomSource,
  TASeries, TATools, TAIntervalSources, DateTimePicker, Unit2, Types,
  TAChartUtils, TADataTools, TAChartExtentLink, LCLType;


type

  { TCSV }

  TCSV = class(TForm)
    App: TPageControl;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    ChartPoints: TCheckBox;
    ChartToolset1ZoomMouseWheelTool2: TZoomMouseWheelTool;
    ChartToolset1ZoomMouseWheelTool3: TZoomMouseWheelTool;
    Draw: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1LineSeries5: TLineSeries;
    Chart2: TChart;
    Chart3: TChart;
    Chart4: TChart;
    Chart5: TChart;
    ChartExtentLink1: TChartExtentLink;
    ChartHeightControl: TTrackBar;
    ChartPanel: TPanel;
    ChartsLink: TCheckBox;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1DataPointHintTool1: TDataPointHintTool;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1ZoomDragTool1: TZoomDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    ComputedChannels: TListBox;
    CSVFileSize: TLabel;
    Duration: TLabel;
    DurationT: TLabel;
    EndTime: TEdit;
    EStatusLo: TRadioButton;
    EstimateFast: TButton;
    FileSizeT: TLabel;
    FullRange: TButton;
    Generate: TButton;
    Graphs: TTabSheet;
    GroupBox1: TGroupBox;
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
    OpenedFile: TLabel;
    Panel1: TPanel;
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
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ChartHeightControlChange(Sender: TObject);
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
    procedure Label25Click(Sender: TObject);
    procedure RawChannelsDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure RawChannelsSelectionChange(Sender: TObject; User: boolean);
    procedure StatusHiChange(Sender: TObject);
    procedure StatusLoChange(Sender: TObject);
    procedure SWListDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure Button3Click(Sender: TObject);
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
            CurrentTime:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)));
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
              CurrentTime:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i])));
              if (YearOf(CurrentTime) <> 1970) and (SecondsBetween(PrevTime,CurrentTime) >= Rate )
                  and (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
                 NumOfLines:=  NumOfLines + 1;
                 FSize:= FSize + Length(CSVContent[i]);
                 PrevTime:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i])));
              end;
          end;
          RecordsT.Caption:= IntToStr(NumOfLines);
          FileSizeT.Caption:= IntToStr(Round(FSize/1000))+' KB';
          Generate.Enabled:= True;
      end else ShowMessage('Start Time should be earlier than End Time');
    end else ShowMessage('Plese put correct value of Record Rate in sec. (1...)');
  end else ShowMessage('Open CSV file first.');
end;

procedure DrawChart(Chart1LineSeries: TLineSeries; SelectedParamName: String);
var i: Longint;
    ParamPos, TimePos: Integer;
    wStr:String;
    PowerReset: boolean;
    y: Single;
    x: TDateTime;
    ChartColor: TColor;
begin
  PowerReset:= false;
  TimePos:= GetParamPosition('RTCs');
  ParamPos:= GetParamPosition(SelectedParamName);
  Chart1LineSeries.Clear;
  Chart1LineSeries.ParentChart.Title.Text[0]:=SelectedParamName;
  ChartColor:= GetLineColor;
  Chart1LineSeries.ParentChart.Title.Font.Color:= ChartColor;
  Chart1LineSeries.ParentChart.Height:= ChartHeight;
  Chart1LineSeries.SeriesColor:= ChartColor;
  Chart1LineSeries.Pointer.Pen.Color:= ChartColor;
  Chart1LineSeries.Pointer.Brush.Color:= ChartColor;

  for i:=1 to CSVContent.Count-1 do begin
    if YearOf(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i])))) > 2020 then begin

      if FindPart('AR?T?F', SelectedParamName) > 0 then y:= Amplitude(NameToInt(SelectedParamName), i)
      else if FindPart('PR?T?F', SelectedParamName) > 0 then y:= PhaseShift(NameToInt(SelectedParamName), i)
           else y:= StrToFloat(GetParamValue(ParamPos, CSVContent[i]));

        x:= UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i])));

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

procedure TCSV.ChartPointsChange(Sender: TObject);
begin
  Chart1LineSeries1.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries2.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries3.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries4.Pointer.Visible:= ChartPoints.Checked;
  Chart1LineSeries5.Pointer.Visible:= ChartPoints.Checked;
end;

procedure DeleteLabels(Chart1LineSeries: TLineSeries);
var i, count: Longint;
begin
   count:= Chart1LineSeries.Count;
   for i:=0 to count-1 do Chart1LineSeries.ListSource.Item[i]^.text:= '';
   Chart1LineSeries.ParentChart.Repaint;
end;

procedure TCSV.Button1Click(Sender: TObject);
begin
   DeleteLabels(Chart1LineSeries1);
   DeleteLabels(Chart1LineSeries2);
   DeleteLabels(Chart1LineSeries3);
   DeleteLabels(Chart1LineSeries4);
   DeleteLabels(Chart1LineSeries5);
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

procedure TCSV.Button6Click(Sender: TObject);
var i: Integer;
begin
  SelectedChannels.Clear;
  for i:=0 to CSV.RawChannels.Items.Count - 1 do CSV.RawChannels.Selected[i]:= false;
  for i:=0 to CSV.ComputedChannels.Items.Count - 1 do CSV.ComputedChannels.Selected[i]:= false;
end;

procedure TCSV.Button7Click(Sender: TObject);
begin
  if SelectedChannels.Items.Count > 0 then ChartHeightControl.Position:= (CSV.Height - 53) div SelectedChannels.Items.Count;
  Chart1.Height:= ChartHeightControl.Position;
  Chart2.Height:= ChartHeightControl.Position;
  Chart3.Height:= ChartHeightControl.Position;
  Chart4.Height:= ChartHeightControl.Position;
  Chart5.Height:= ChartHeightControl.Position;
end;

procedure TCSV.ChartHeightControlChange(Sender: TObject);
begin
  Chart1.Height:= ChartHeightControl.Position;
  Chart2.Height:= ChartHeightControl.Position;
  Chart3.Height:= ChartHeightControl.Position;
  Chart4.Height:= ChartHeightControl.Position;
  Chart5.Height:= ChartHeightControl.Position;
end;

procedure TCSV.ChartToolset1DataPointHintTool1Hint(ATool: TDataPointHintTool;
  const APoint: TPoint; var AHint: String);
var y: Double;
    x: TDateTime;
begin
   x:= TLineSeries(ATool.Series).GetXValue(ATool.PointIndex);
   y:= TLineSeries(ATool.Series).GetYValue(ATool.PointIndex);
   AHint := FloatToStrF(y, ffFixed, 12, 3) + LN + DateTimeToStr(x);
end;

procedure TCSV.DrawClick(Sender: TObject);
  var i, counter: Integer;
    wStr: String;
begin
  ShowPR:= PowerResets.Checked;
  ChartHeight:= ChartHeightControl.Position;
  Chart1.Visible:= False;
  Chart2.Visible:= False;
  Chart3.Visible:= False;
  Chart4.Visible:= False;
  Chart5.Visible:= False;
  Chart1.ZoomFull;
  Chart2.ZoomFull;
  Chart3.ZoomFull;
  Chart4.ZoomFull;
  Chart5.ZoomFull;
  for i:=0 to 4 do SelectedParams[i]:= '';
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
     App.ActivePage:= Graphs;
  end
  else ShowMessage('No parameters selected.');
end;

procedure TCSV.Chart1ExtentChanged(ASender: TChart);
  var dr: TDoubleRect;
begin
  dr:= Chart1.CurrentExtent;
  Chart1.Foot.Text[0]:= FormatDateTime('mmm-dd hh:mm', dr.a.X);
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

procedure TCSV.ChartsLinkChange(Sender: TObject);
begin
   ChartExtentLink1.Enabled:= ChartsLink.Checked;
end;

procedure TCSV.ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool; APoint: TPoint);
var y: Double;
    x: TDateTime;
begin
  with ATool as TDatapointClickTool do
    if (Series is TLineSeries) then
      with TLineSeries(Series) do begin
        x:= GetXValue(PointIndex);
        y:= GetYValue(PointIndex);
        if ListSource.Item[PointIndex]^.Text = '' then ListSource.Item[PointIndex]^.Text := FloatToStrF(y, ffFixed, 12, 3) + LN + DateTimeToStr(x)
        else ListSource.Item[PointIndex]^.Text := '';
        ParentChart.Repaint;
      end
    else
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
  if SWList.Cells[0, 0] <>'' then for i:=0 to 15 do SWList.Cells[1, i]:= ESWLo[i];
end;

procedure TCSV.Label25Click(Sender: TObject);
begin

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
  if SWList.Cells[0, 0] <>'' then for i:=0 to 15 do SWList.Cells[1, i]:= SWHi[i];
end;

procedure TCSV.StatusLoChange(Sender: TObject);
var i: Byte;
begin
  if SWList.Cells[0, 0] <>'' then for i:=0 to 15 do SWList.Cells[1, i]:= SWLo[i];
end;

procedure TCSV.SWListDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
begin
  if SWList.Cells[0,Arow]='1' then begin
     //SWList.Canvas.Brush.Color:=clRed;
     SWList.Canvas.Font.Color:=clRed;
  end
  else SWList.Canvas.Font.Color:=clGreen;
  SWList.Canvas.FillRect(aRect);
  SWList.Canvas.TextOut(aRect.Left,aRect.Top,SWList.Cells[Acol,Arow]);
end;

procedure TCSV.Button3Click(Sender: TObject);
begin
  Chart1.ZoomFull;
  Chart2.ZoomFull;
  Chart3.ZoomFull;
  Chart4.ZoomFull;
  Chart5.ZoomFull;
end;

procedure TCSV.SaveReportClick(Sender: TObject);
var  ReportFile: TextFile;
     FileName, wStr: String;
begin
  SaveDialog1.Filename:= 'SIB-R_#' + SerialNumber.Text + '_' + FormatDateTime('DD-MMM-YYYY', TestDate.Date) + '_Air_Test_Report.prn';
  if SaveDialog1.Execute then begin
    AssignFile(ReportFile, SaveDialog1.Filename);
    ReWrite(ReportFile);
    wStr:= ReportText.Text;
    Writeln(ReportFile, wStr);
    CloseFile(ReportFile);
  end;
end;

procedure TCSV.OpenCSVFastClick(Sender: TObject);
var ParamPos, LineLength, Counter: Integer;
    FSize, DurationInMinutes, i: Longint;
    StartRun: Boolean;
    EndRun, SubStr, wStr: String;
    StartRunDT, EndRunDT: TDateTime;
begin
  if OpenDialog1.Execute then
   begin
      RawChannels.Clear;
      ComputedChannels.Clear;
      SelectedChannels.Clear;
      ReportText.Text:= '';
      CSVFileName:= OpenDialog1.FileName;
      OpenedFile.Caption:= CSVFileName;
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

        for i:=1 to CSVContent.Count-1 do begin
            FSize:= FSize + Length(CSVContent[i]);
            if not StartRun then begin
               if YearOf(UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i])))) <> 1970 then begin
                  StartRunDT:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i])));
                  RunStart.Caption:= DateTimeToStr(StartRunDT);
                  StartTime.Text:= DateTimeToStr(StartRunDT);
                  StartRun:= true;
               end
            end
            else begin
               if (YearOf(UnixToDateTime(StrToInt(GetParamValue(ParamPos, CSVContent[i])))) <> 1970) then begin
                  EndRun:= GetParamValue(ParamPos, CSVContent[i]);
               end
            end;
        end;

        EndRunDT:= UnixToDateTime(StrToInt(EndRun));
        RunEnd.Caption:= DateTimeToStr(EndRunDT);
        EndTime.Text:= DateTimeToStr(EndRunDT);

        ReportStartTime.Text:= StartTime.Text;
        ReportEndTime.Text:= EndTime.Text;

        Records.Caption:= IntToStr(CSVContent.Count);
        ProgressBar.Max:= CSVContent.Count;
        CSVFileSize.Caption:= IntToStr(Round(FSize/1000))+' KB';
        DurationInMinutes:= MinutesBetween(StartRunDT, EndRunDT);
        Duration.Caption:= IntToStr(DurationInMinutes div 60) + ' h ' + IntToStr(DurationInMinutes mod 60) + ' m';
        EstimateFast.Enabled:= True;
        ReportTab.Enabled:= True;
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
      CurrentTime:= UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i])));
      if (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
         SW:= SW or StrToInt(GetParamValue(ParamPos, CSVContent[i]));
      end;
  end;
  if SW <> exptd then PassFail:= 'Failed'
  else PassFail:= 'Passed';
  SWString:= SWLine(SWName, SW, exptd, PassFail);
end;

procedure TCSV.ReportClick(Sender: TObject);
var i, j, SW: Longint;
    ParamPos, TimePos, Step: Integer;
    MinValue, MaxValue, Avarage, StdDiviation, Value: Double;
    AmplAvarage, PSAvarage, AmplValue, PSValue, MinAmplValue, MinPSValue, MaxAmplValue, MaxPSValue, RawR, RawX, AmplStdDiviation, PSStdDiviation: Double;
    wStr, PassFail: String;
    PSStrings: array[0..15] of String;
    CurrentTime, StartTimeDT, EndTimeDT: TDateTime;
begin
  TimePos:= GetParamPosition('RTCs');
  StartTimeDT:= StrToDateTime(ReportStartTime.Text);
  EndTimeDT:= StrToDateTime(ReportEndTime.Text);
  ReportProgress.Max:= 46;
  ReportProgress.Position:= 0;
  wStr:= '';

  wStr:= wStr + 'SIB-R S/N: ' + SerialNumber.Text + LN;
  //wStr:= wStr + 'Test Date: ' + DateToStr(TestDate.Date) + LN;
  wStr:= wStr + 'Test Date: ' + FormatDateTime('DD-MMM-YYYY', TestDate.Date) + LN;

  wStr:= wStr + '---------------------------------------------------------------------------------------------------------------' + LN;
  wStr:= wStr + '                                                   Air Test' + LN;
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
  Avarage:= 0; StdDiviation:= 0;
  for j:=0 to 30 do begin
    ParamPos:= GetParamPosition(SibrParams[j].name);
    Value:= StrToFloat(GetParamValue(ParamPos,CSVContent[1]));
    MinValue:= Value; MaxValue:= Value;
    for i:=1 to CSVContent.Count-1 do begin
       Value:= StrToFloat(GetParamValue(ParamPos,CSVContent[i]));
       if Value < MinValue then MinValue:=Value;
       if Value > MaxValue then MaxValue:=Value;
       Avarage:= Avarage+Value;
    end;
    Avarage:=Avarage/(CSVContent.Count-1);
    for i:=1 to CSVContent.Count-1 do begin
       Value:= StrToFloat(GetParamValue(ParamPos,CSVContent[i]));
       StdDiviation:= StdDiviation + Sqr(Value-Avarage);
    end;
    StdDiviation:= Sqrt(StdDiviation/(CSVContent.Count-1));
    if (Avarage < SibrParams[j].min) or (Avarage > SibrParams[j].max) or (StdDiviation > SibrParams[j].stdDev) then PassFail:= 'Failed'
    else PassFail:= 'Passed';
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
       GetResParameters(AmplValue, PSValue, j-1, i);
       if AmplValue < MinAmplValue then MinAmplValue:= AmplValue;
       if AmplValue > MaxAmplValue then MaxAmplValue:= AmplValue;
       if PSValue < MinPSValue then MinPSValue:= PSValue;
       if PSValue > MaxPSValue then MaxPSValue:= PSValue;
       AmplAvarage:= AmplAvarage + AmplValue;
       PSAvarage:= PSAvarage + PSValue;
    end;
    AmplAvarage:=AmplAvarage/(CSVContent.Count-1);
    PSAvarage:=PSAvarage/(CSVContent.Count-1);
    for i:=1 to CSVContent.Count-1 do begin
       GetResParameters(AmplValue, PSValue, j-1, i);
       AmplStdDiviation:= AmplStdDiviation + Sqr(AmplValue - AmplAvarage);
       PSStdDiviation:= PSStdDiviation + Sqr(PSValue - PSAvarage);
    end;
    AmplStdDiviation:= Sqrt(AmplStdDiviation/(CSVContent.Count-1));
    PSStdDiviation:= Sqrt(PSStdDiviation/(CSVContent.Count-1));
    wStr:= wStr +ParamLine(SibrParams[J+30].name, AmplAvarage, MinAmplValue, MaxAmplValue, AmplStdDiviation, SibrParams[J+30].min,  SibrParams[J+30].max, SibrParams[J+30].stdDev, SibrParams[J+30].k, SibrParams[J+30].m, PassFail) + LN;
    PSStrings[j-1]:= ParamLine(SibrParams[J+46].name, PSAvarage, MinPSValue, MaxPSValue, PSStdDiviation, SibrParams[J+46].min,  SibrParams[J+46].max, SibrParams[J+46].stdDev, SibrParams[J+46].k, SibrParams[J+46].m, PassFail) + LN;
    ReportProgress.Position:= ReportProgress.Position + 1;
  end;
  for i:= 0 to 15 do wStr:= wStr + PSStrings[i];
  ReportText.Text:= wStr;
end;

end.

