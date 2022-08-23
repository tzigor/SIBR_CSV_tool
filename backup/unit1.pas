unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, DateUtils, StrUtils, csvdataset, LConvEncoding;

type

  { TCSV }

  TCSV = class(TForm)
    Button1: TButton;
    OpenCSVFast: TButton;
    FullRange: TButton;
    EndTime: TEdit;
    Label14: TLabel;
    StartTime: TEdit;
    Generate: TButton;
    Label13: TLabel;
    OpenCSV: TButton;
    Button2: TButton;
    Estimate: TButton;
    DurationT: TLabel;
    Label12: TLabel;
    ProgressBar: TProgressBar;
    RecordRate: TEdit;
    FileSizeT: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label3: TLabel;
    Duration: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CSVFileSize: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Records: TLabel;
    RecordsT: TLabel;
    RunEnd: TLabel;
    RunEndT: TLabel;
    RunStart: TLabel;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    RunStartT: TLabel;
    StaticText1: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure FullRangeClick(Sender: TObject);
    procedure GenerateClick(Sender: TObject);
    procedure GroupBox2Click(Sender: TObject);
    procedure OpenCSVClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EstimateClick(Sender: TObject);
    procedure OpenCSVFastClick(Sender: TObject);
  private
  public
  end;

var
  CSV: TCSV;
  CSVFileName: String;
  CSVContent: TStringList;

implementation

{$R *.lfm}

{ TCSV }

function GetParamPosition(Param, TextLine: String): Integer;
var LineLength, i, Counter: Integer;
    SubStr: String;
begin
  LineLength:= Length(TextLine);
  Counter:= 1;
  SubStr:= '';
  for i:= 1 to LineLength do begin
     if TextLine[i] = ';' then begin
        Counter:= Counter + 1;
        SubStr:= '';
     end
     else SubStr:= SubStr+TextLine[i];
     if Trim(SubStr) = Trim(Param) then begin
        GetParamPosition:= Counter;
        break;
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

procedure TCSV.OpenCSVClick(Sender: TObject);
var CSVFile: TextFile;
    TextLine: String;
    ParamPos: Integer;
    NumOfLines, FSize, DurationInMinutes: Longint;
    StartRun: Boolean;
    EndRun: String;
    StartRunDT, EndRunDT: TDateTime;
begin
  if OpenDialog1.Execute then
   begin
      CSVFileName:= OpenDialog1.FileName;
      AssignFile(CSVFile, CSVFileName);
      try
        Generate.Enabled:= False;
        ProgressBar.Position:= 0;
        RecordsT.Caption:= '';
        FileSizeT.Caption:= '';
        RunStartT.Caption:= '';
        RunEndT.Caption:= '';
        DurationT.Caption:= '';
        Reset(CSVFile);
        Readln(CSVFile, TextLine);
        ParamPos:= GetParamPosition('RTCs',TextLine);
        //FSize2:= FileSize(CSVFileName);
        //ShowMessage(IntToStr(FSize2));
        FSize:= Length(TextLine);
        NumOfLines:= 0;
        StartRun:= false;

        while not eof(CSVFile) do begin
            Readln(CSVFile, TextLine);
            if not StartRun then begin
               if YearOf(UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)))) <> 1970 then begin
                  StartRunDT:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)));
                  RunStart.Caption:= DateTimeToStr(StartRunDT);
                  StartTime.Text:= DateTimeToStr(StartRunDT);
                  StartRun:= true;
               end
            end
            else begin
               if (YearOf(UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)))) <> 1970) then begin
                  EndRun:= GetParamValue(ParamPos, TextLine);
               end
            end;
            NumOfLines:=  NumOfLines + 1;
            FSize:= FSize + Length(TextLine);
        end;
        EndRunDT:= UnixToDateTime(StrToInt(EndRun));
        RunEnd.Caption:= DateTimeToStr(EndRunDT);
        EndTime.Text:= DateTimeToStr(EndRunDT);
        CloseFile(CSVFile);
        Records.Caption:= IntToStr(NumOfLines);
        ProgressBar.Max:= NumOfLines;
        CSVFileSize.Caption:= IntToStr(Round(FSize/1000))+' KB';
        DurationInMinutes:= MinutesBetween(StartRunDT, EndRunDT);
        Duration.Caption:= IntToStr(Round(DurationInMinutes/60)) + ' h ' + IntToStr(DurationInMinutes mod 60) + ' m';
      except
      on E: EInOutError do
        ShowMessage('Error: ' + E.Message);
      end;
   end;
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
          ParamPos:= GetParamPosition('RTCs',TextLine);
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

procedure TCSV.GroupBox2Click(Sender: TObject);
begin

end;

procedure TCSV.FullRangeClick(Sender: TObject);
begin
  StartTime.Text:= RunStart.Caption;
  EndTime.Text:= RunEnd.Caption;
end;

procedure TCSV.Button1Click(Sender: TObject);
  var
    ss : TStringStream;
  begin

  end;

procedure TCSV.Button2Click(Sender: TObject);
begin
  FreeAndNil(CSVContent);
  CSV.Close;
end;

procedure TCSV.EstimateClick(Sender: TObject);
var CSVFile: TextFile;
    TextLine: String;
    ParamPos, Rate: Integer;
    NumOfLines, FSize, DurationInMinutes: Longint;
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
          ProgressBar.Position:= 0;
          RunStartT.Caption:= StartTime.Text;
          RunEndT.Caption:= EndTime.Text;
          DurationT.Caption:= IntToStr(Round(DurationInMinutes/60)) + ' h ' + IntToStr(DurationInMinutes mod 60) + ' m';
          Generate.Enabled:= True;
          AssignFile(CSVFile, CSVFileName);
          try
            Reset(CSVFile);
            Readln(CSVFile, TextLine);
            ParamPos:= GetParamPosition('RTCs',TextLine);
            FSize:= Length(TextLine);
            PrevTime:= 0;
            NumOfLines:= 0;
            while not eof(CSVFile) do begin
              Readln(CSVFile, TextLine);
              CurrentTime:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)));
              if (YearOf(CurrentTime) <> 1970) and (SecondsBetween(PrevTime,CurrentTime) >= Rate )
                  and (CompareDateTime(CurrentTime, StartTimeDT) = 1) and (CompareDateTime(CurrentTime, EndTimeDT) = -1) then begin
                 NumOfLines:=  NumOfLines + 1;
                 FSize:= FSize + Length(TextLine);
                 PrevTime:= UnixToDateTime(StrToInt(GetParamValue(ParamPos, TextLine)));
              end;
              ProgressBar.Position:= ProgressBar.Position + 1;
            end;
            CloseFile(CSVFile);
            RecordsT.Caption:= IntToStr(NumOfLines);
            FileSizeT.Caption:= IntToStr(Round(FSize/1000))+' KB';
          except
            on E: EInOutError do
            ShowMessage('Error: ' + E.Message);
          end;
      end else ShowMessage('Start Time should be earlier than End Time');
    end else ShowMessage('Plese put correct value of Record Rate in sec. (1...)');
  end else ShowMessage('Open CSV file first.');
end;

procedure TCSV.OpenCSVFastClick(Sender: TObject);
var ParamPos: Integer;
    NumOfLines, FSize, DurationInMinutes: Longint;
    StartRun: Boolean;
    EndRun: String;
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

        NumOfLines:= 0;
        StartRun:= false;

        if CSVContent is TStringList then ShowMessage('Del');
        CSVContent:= TStringList.Create;
        CSVContent.LoadFromFile(CSVFileName);
        //ShowMessage(CSVContent[0]);

        //EndRunDT:= UnixToDateTime(StrToInt(EndRun));
        //RunEnd.Caption:= DateTimeToStr(EndRunDT);
        //EndTime.Text:= DateTimeToStr(EndRunDT);

        Records.Caption:= IntToStr(CSVContent.Count);
        ProgressBar.Max:= CSVContent.Count;
        CSVFileSize.Caption:= IntToStr(Round(CSVContent.Count/1000))+' KB';
        DurationInMinutes:= MinutesBetween(StartRunDT, EndRunDT);
        Duration.Caption:= IntToStr(Round(DurationInMinutes/60)) + ' h ' + IntToStr(DurationInMinutes mod 60) + ' m';
      except
      on E: EInOutError do
        ShowMessage('Error: ' + E.Message);
      end;
   end;

end;


end.

