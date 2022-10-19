unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, DateUtils, StrUtils, csvdataset, LConvEncoding, TAGraph,
  TASources, TACustomSource, TASeries, Unit2;

type

  { TCSV }

  TCSV = class(TForm)
    App: TPageControl;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1UserDrawnSeries1: TUserDrawnSeries;
    CSVFileSize: TLabel;
    Duration: TLabel;
    DurationT: TLabel;
    EndTime: TEdit;
    ReportEndTime: TEdit;
    EstimateFast: TButton;
    FileSizeT: TLabel;
    FullRange: TButton;
    Generate: TButton;
    GenerateFast: TToggleBox;
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
    ReportText: TMemo;
    RunEnd: TLabel;
    RunEndT: TLabel;
    RunStart: TLabel;
    RunStartT: TLabel;
    StartTime: TEdit;
    ReportStartTime: TEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    UserDefinedChartSource1: TUserDefinedChartSource;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EstimateFastClick(Sender: TObject);
    procedure FullRangeClick(Sender: TObject);
    procedure GenerateClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GenerateFastChange(Sender: TObject);
    procedure OpenCSVFastClick(Sender: TObject);
    procedure ReportClick(Sender: TObject);
    procedure UserDefinedChartSource1GetChartDataItem(
      ASource: TUserDefinedChartSource; AIndex: Integer;
      var AItem: TChartDataItem);
  private
  public
  end;

Const LN = #13#10;

var
  CSV: TCSV;
  CSVFileName: String;
  CSVContent: TStringList;
  DataSource: array of Double;
  ParamList: array of String;

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

procedure TCSV.GenerateFastChange(Sender: TObject);
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
            ShowMessage('File generated');
          except
          on E: EInOutError do
            ShowMessage('Error: ' + E.Message);
          end;
end;

procedure TCSV.Button2Click(Sender: TObject);
begin
  FreeAndNil(CSVContent);
  //FreeAndNil(SibrParams);
  //FreeAndNil(ParamList);
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
          GenerateFast.Enabled:= True;
      end else ShowMessage('Start Time should be earlier than End Time');
    end else ShowMessage('Plese put correct value of Record Rate in sec. (1...)');
  end else ShowMessage('Open CSV file first.');
end;

procedure TCSV.Button1Click(Sender: TObject);
var i: Longint;
    ParamPos: Integer;
    wStr:String;
begin
  setLength(DataSource, CSVContent.Count);
  ParamPos:= GetParamPosition('BHT');
  for i:=1 to CSVContent.Count-1 do begin
     DataSource[i-1]:= StrToFloat(GetParamValue(ParamPos,CSVContent[i]));
  end;

  UserDefinedChartSource1.PointsNumber:= CSVContent.Count-1;
  UserDefinedChartSource1.Reset;
end;

procedure TCSV.Button3Click(Sender: TObject);
var ParamPos, LineLength, Counter, i: Integer;
    wStr: String;
begin
   ParamPos:= GetParamPosition('VR1C0F1r')-1;
   for i := ParamPos to ParamPos + 63 do begin
      wStr:= wStr + ParamList[i] + LN
   end;
   ReportText.Text:=wStr;
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

        setLength(ParamList, Counter);
        Counter:= 0;
        SubStr:= '';
        for i:= 0 to LineLength-1 do begin
           if CSVContent[0][i] = ';' then begin
              ParamList[Counter]:= Trim(SubStr);
              Counter:= Counter + 1;
              SubStr:= '';
           end
           else SubStr:= SubStr + CSVContent[0][i];
        end;

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

  wStr:= '';

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
    if (Avarage < SibrParams[j].min) or (Avarage < SibrParams[j].max) or (StdDiviation > SibrParams[j].stdDev) then PassFail:= 'Failed'
    else PassFail:= 'Passed';
    wStr:= wStr + ParamLine(SibrParams[j].name, Avarage, MinValue, MaxValue, StdDiviation, SibrParams[j].min,  SibrParams[j].max, SibrParams[j].stdDev, SibrParams[j].k, SibrParams[j].m, PassFail)+ LN;
  end;
  ReportText.Text:= wStr;

  ParamPos:= GetParamPosition('VR1C0F1r') + 4;
  AmplAvarage:= 0; AmplStdDiviation:= 0;
  PSAvarage:= 0; PSStdDiviation:= 0;

  Step:= 0;
  for j:=1 to 16 do begin
    RawR:= StrToFloat(GetParamValue(ParamPos + Step, CSVContent[1]));
    RawX:= StrToFloat(GetParamValue(ParamPos + Step + 1, CSVContent[1]));
    AmplValue:= Sqrt(Sqr(RawR)+Sqr(RawX));
    PSValue:= Arctan(-RawX/RawR);
    MinAmplValue:= AmplValue; MaxAmplValue:= AmplValue;
    MinPSValue:= PSValue; MaxPSValue:= PSValue;
    for i:=1 to CSVContent.Count-1 do begin

       RawR:= StrToFloat(GetParamValue(ParamPos + Step, CSVContent[i]));
       RawX:= StrToFloat(GetParamValue(ParamPos + Step + 1, CSVContent[i]));
       AmplValue:= Sqrt(Sqr(RawR)+Sqr(RawX));
       PSValue:= Arctan(-RawX/RawR);

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
       RawR:= StrToFloat(GetParamValue(ParamPos + Step, CSVContent[i]));
       RawX:= StrToFloat(GetParamValue(ParamPos + Step + 1, CSVContent[i]));
       AmplValue:= Sqrt(Sqr(RawR)+Sqr(RawX));
       PSValue:= Arctan(-RawX/RawR);
       AmplStdDiviation:= AmplStdDiviation + Sqr(AmplValue - AmplAvarage);
       PSStdDiviation:= PSStdDiviation + Sqr(PSValue - PSAvarage);
    end;
    AmplStdDiviation:= Sqrt(AmplStdDiviation/(CSVContent.Count-1));
    PSStdDiviation:= Sqrt(PSStdDiviation/(CSVContent.Count-1));
    wStr:= wStr +ParamLine(SibrParams[J+30].name, AmplAvarage, MinAmplValue, MaxAmplValue, AmplStdDiviation, SibrParams[J+30].min,  SibrParams[J+30].max, SibrParams[J+30].stdDev, SibrParams[J+30].k, SibrParams[J+30].m, PassFail) + LN;
    PSStrings[j-1]:= ParamLine(SibrParams[J+46].name, PSAvarage, MinPSValue, MaxPSValue, PSStdDiviation, SibrParams[J+46].min,  SibrParams[J+46].max, SibrParams[J+46].stdDev, SibrParams[J+46].k, SibrParams[J+46].m, PassFail) + LN;
    if (j mod 2) = 0 then Step:= Step + 6
    else Step:= Step + 2;
  end;
  for i:= 0 to 15 do wStr:= wStr + PSStrings[i];
  ReportText.Text:= wStr;
end;

procedure TCSV.UserDefinedChartSource1GetChartDataItem(
  ASource: TUserDefinedChartSource; AIndex: Integer; var AItem: TChartDataItem);
begin
  AItem.Y := DataSource[AIndex];
  AItem.X := AIndex;
end;

end.

