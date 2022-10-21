unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, DateUtils, StrUtils, csvdataset, LConvEncoding, TAGraph,
  TASources, TACustomSource, TASeries, TATools, TAIntervalSources,
  DateTimePicker, Unit2, Types;

type

  { TCSV }

  TCSV = class(TForm)
    App: TPageControl;
    ChartToolset1: TChartToolset;
    ChartToolset1PanDragTool1: TPanDragTool;
    ChartToolset1ZoomDragTool1: TZoomDragTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    ChartPoints: TCheckBox;
    DateTimeIntervalChartSource1: TDateTimeIntervalChartSource;
    Draw: TButton;
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Parameters: TComboBox;
    SaveReport: TButton;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1UserDrawnSeries1: TUserDrawnSeries;
    CSVFileSize: TLabel;
    TestDate: TDateTimePicker;
    Duration: TLabel;
    DurationT: TLabel;
    EndTime: TEdit;
    GroupBox3: TGroupBox;
    EstimateFast: TButton;
    FileSizeT: TLabel;
    FullRange: TButton;
    Generate: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
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
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListChartSource1: TListChartSource;
    OpenCSVFast: TButton;
    OpenDialog1: TOpenDialog;
    ProgressBar: TProgressBar;
    RecordRate: TEdit;
    Records: TLabel;
    RecordsT: TLabel;
    Report: TButton;
    ReportEndTime: TEdit;
    ReportStartTime: TEdit;
    SerialNumber: TEdit;
    ReportText: TMemo;
    RunEnd: TLabel;
    RunEndT: TLabel;
    RunStart: TLabel;
    RunStartT: TLabel;
    StartTime: TEdit;
    MainTab: TTabSheet;
    ReportTab: TTabSheet;
    Graphs: TTabSheet;
    UserDefinedChartSource1: TUserDefinedChartSource;
    procedure ChartPointsChange(Sender: TObject);
    procedure DateTimeIntervalChartSource1DateTimeStepChange(Sender: TObject;
      ASteps: TDateTimeStep);
    procedure DrawClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SaveReportClick(Sender: TObject);
    procedure EstimateFastClick(Sender: TObject);
    procedure FullRangeClick(Sender: TObject);
    procedure GenerateClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure OpenCSVFastClick(Sender: TObject);
    procedure ReportClick(Sender: TObject);
    procedure UserDefinedChartSource1GetChartDataItem(
      ASource: TUserDefinedChartSource; AIndex: Integer;
      var AItem: TChartDataItem);
  private
  public
  end;

type TChartData = record
   Data: Double;
   Time: TDateTime;
end;

Function Amplitude(nParam, n: Integer): Single;
function PhaseShift(nParam, n: Integer): Single;

Const LN = #13#10;

var
  CSV: TCSV;
  CSVFileName, DrawParameter: String;
  CSVContent: TStringList;
  DataSource: array of TChartData;
  ParamList: array of String;
  ParameterCount: Integer;

implementation

{$R *.lfm}

{ TCSV }

function GetParamPosition(Param: String): Integer;
var i: Integer;
begin
  for i:= 0 to Length(ParamList)-1 do begin
     if ParamList[i] = Param then begin
        GetParamPosition:= i+1;
        break
     end
  end
end;

function GetParamValue(ParamNum: Integer; TextLine: String): String;
var LineLength, i, Counter, ParamStart: Integer;
    SubStr: String;
begin
  LineLength:= Length(TextLine);
  Counter:= 1;
  SubStr:= '';
  for i:= 1 to LineLength do begin
     if ParamNum = Counter then begin
        ParamStart:= i;
        break;
     end;
     if TextLine[i] = ';' then Counter:= Counter + 1;
  end;
  i:= ParamStart;
  repeat
    SubStr:= SubStr + TextLine[i];
    i:= i + 1;
  until ( TextLine[i] = ';' ) OR ( i > LineLength );
  GetParamValue:= Trim(SubStr);
end;

function FileSize(FileName:string):Integer;
var
FS: TFileStream;
begin
  try
    FS:=TFilestream.Create(FileName, fmOpenRead);
  except
  Result := -1;
  end;
  if Result <> -1 then Result :=FS.Size;
  FS.Free;
end;

procedure TCSV.GenerateClick(Sender: TObject);
  var CSVFile, NewCSVFile: TextFile;
      TextLine, FileName: String;
      ParamPos, Rate: Integer;
      PrevTime, CurrentTime, StartTimeDT, EndTimeDT: TDateTime;
  begin
        FileName:= ReplaceText(CSVFileName,'.csv','') + '_generated.csv';
        ProgressBar.Position:= 0;
        Rate:= StrToInt(RecordRate.Text);
        AssignFile(CSVFile, CSVFileName);
        AssignFile(NewCSVFile, FileName);
        StartTimeDT:= StrToDateTime(StartTime.Text);
        EndTimeDT:= StrToDateTime(EndTime.Text);
        try
          Reset(CSVFile);
          ReWrite(NewCSVFile);
          Readln(CSVFile, TextLine);
          WriteLn(NewCSVFile,TextLine);
          ParamPos:= GetParamPosition('RTCs');
          PrevTime:= 0;
          while not eof(CSVFile) do begin
            Readln(CSVFile, TextLine);
            CurrentTime:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)));
            if (YearOf(CurrentTime) <> 1970) and (SecondsBetween(PrevTime,CurrentTime) >= Rate ) and
                 (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin;
               PrevTime:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)));
               WriteLn(NewCSVFile,TextLine);
            end;
            ProgressBar.Position:= ProgressBar.Position + 1;
          end;
          CloseFile(CSVFile);
          CloseFile(NewCSVFile);
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
      end else ShowMessage('Start Time should be earlier than End Time');
    end else ShowMessage('Plese put correct value of Record Rate in sec. (1...)');
  end else ShowMessage('Open CSV file first.');
end;

procedure TCSV.DrawClick(Sender: TObject);
var i: Longint;
    ParamPos, TimePos: Integer;
    wStr:String;
begin
  TimePos:= GetParamPosition('RTCs');
  setLength(DataSource, 0);
  setLength(DataSource, CSVContent.Count);
  ParamPos:= GetParamPosition(Parameters.Text);
  for i:=1 to CSVContent.Count-1 do begin
    if YearOf(UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i])))) > 2020 then begin
       if Parameters.ItemIndex < ParameterCount then DataSource[i-1].Data:= StrToFloat(GetParamValue(ParamPos, CSVContent[i]))
       else
         if Parameters.ItemIndex - ParameterCount < 16 then DataSource[i-1].Data:= Amplitude(Parameters.ItemIndex - ParameterCount, i)
         else DataSource[i-1].Data:= PhaseShift(Parameters.ItemIndex - ParameterCount - 16, i);
         DataSource[i-1].Time:= UnixToDateTime(StrToInt(GetParamValue(TimePos, CSVContent[i])));
         wStr:= wStr + DataSource[i-1].Time + ' - ' + FloatToStr(DataSource[i-1].Data) + LN;
    end;
  end;

  ReportText.Text:= wStr;

  UserDefinedChartSource1.PointsNumber:= CSVContent.Count-1;
  UserDefinedChartSource1.Reset;
end;

procedure TCSV.DateTimeIntervalChartSource1DateTimeStepChange(Sender: TObject;
  ASteps: TDateTimeStep);
begin

end;

procedure TCSV.ChartPointsChange(Sender: TObject);
begin
  Chart1LineSeries1.Pointer.Visible:= ChartPoints.Checked;
end;

procedure TCSV.Button3Click(Sender: TObject);
var i, Step: integer;
    wStr: String;
begin
   for i:=0 to 15 do begin
      wStr:= wStr + FloatToStr(Amplitude(i,1)) + LN;
   end;
   ReportText.Text:= wStr;
end;

procedure TCSV.SaveReportClick(Sender: TObject);
var  ReportFile: TextFile;
     FileName, wStr: String;
begin
  FileName:= 'SIB-R xxx Air Test Report.prn';
  AssignFile(ReportFile, FileName);
  ReWrite(ReportFile);
  wStr:= ReportText.Text;
  Writeln(ReportFile, wStr);
  CloseFile(ReportFile);
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
      CSVFileName:= OpenDialog1.FileName;
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
              Parameters.Items.Add(Trim(SubStr));
              Counter:= Counter + 1;
              SubStr:= '';
           end
           else SubStr:= SubStr + CSVContent[0][i];
        end;

        for i:= 0 to 15 do Parameters.Items.Add(AmplitudeName(i));
        for i:= 0 to 15 do Parameters.Items.Add(PhaseShiftName(i));

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
        Duration.Caption:= IntToStr(Round(DurationInMinutes/60)) + ' h ' + IntToStr(DurationInMinutes mod 60) + ' m';
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

procedure GetResParameters(var Amplitude, PhaseShift: Double; nParam, n: Integer);
var StartParamPos, Step: Integer;
    RawR, RawX: Double;
begin
  StartParamPos:= GetParamPosition('VR1T0F1r');
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  Amplitude:= Sqrt(Sqr(RawR)+Sqr(RawX));
  PhaseShift:= Arctan(-RawX/RawR);
end;

function Amplitude(nParam, n: Integer): Single;
var StartParamPos, Step: Integer;
    RawR, RawX: Double;
begin
  StartParamPos:= GetParamPosition('VR1T0F1r');
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  Amplitude:= Sqrt(Sqr(RawR)+Sqr(RawX))
end;

function PhaseShift(nParam, n: Integer): Single;
var StartParamPos, Step: Integer;
    RawR, RawX: Single;
begin
  StartParamPos:= GetParamPosition('VR1T0F1r');
  if (nParam mod 2) = 0 then Step:= (nParam div 2) * 8
  else Step:= ((nParam div 2) * 8) + 2;
  RawR:= StrToFloat(GetParamValue(StartParamPos + Step, CSVContent[n]));
  RawX:= StrToFloat(GetParamValue(StartParamPos + Step + 1, CSVContent[n]));
  PhaseShift:= Arctan(-RawX/RawR);
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

  wStr:= '';

  wStr:= wStr + 'SIB-R S/N: ' + SerialNumber.Text + LN;
  wStr:= wStr + 'Test Date: ' + DateToStr(TestDate.Date) + LN;

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
  end;
  for i:= 0 to 15 do wStr:= wStr + PSStrings[i];
  ReportText.Text:= wStr;
end;

procedure TCSV.UserDefinedChartSource1GetChartDataItem(
  ASource: TUserDefinedChartSource; AIndex: Integer; var AItem: TChartDataItem);
begin
  AItem.Y := DataSource[AIndex].Data;
  AItem.X := DataSource[AIndex].Time;
end;

end.

