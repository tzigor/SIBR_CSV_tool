unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls,
  ComCtrls, DateUtils, StrUtils, Types, FileUtil, TAGraph, TASeries, TATools,
  Unit2;

type

  { TMainForm }

  TMainForm = class(TForm)
    AddReport: TButton;
    AvarageGrid: TStringGrid;
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    Chart1LineSeries3: TLineSeries;
    Chart1LineSeries4: TLineSeries;
    Chart1LineSeries5: TLineSeries;
    Chart2: TChart;
    Chart2LineSeries1: TLineSeries;
    Chart3: TChart;
    Chart3LineSeries1: TLineSeries;
    Chart4: TChart;
    Chart4LineSeries1: TLineSeries;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointHintTool1: TDataPointHintTool;
    CloseBtn: TButton;
    FileList: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SelectedParam: TLabel;
    LoadFolder: TButton;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    ReportGrid: TStringGrid;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    Main: TTabSheet;
    Graph: TTabSheet;
    procedure AddReportClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ChartToolset1DataPointHintTool1Hint(ATool: TDataPointHintTool;
      const APoint: TPoint; var AHint: String);
    procedure FormResize(Sender: TObject);
    procedure LoadFolderClick(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ReportGridDrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure ReportGridHeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
    procedure ReportGridSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
  private

  public

  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

function PhaseShiftName(n: Integer):String;
begin
   PhaseShiftName:= 'PR' + IntToStr((n mod 2) + 1) + 'T' + IntToStr((n mod 16) div 4) + 'F' + IntToStr(((n div 2) mod 2) + 1);
end;

procedure PrintParams(n: integer);
var i, j, Row, nPS, indx: integer;
    Phases: array[0..15] of TSibrReportParam;
begin
  MainForm.ReportGrid.Cells[(n-1)*4 + 1, 0]:= 'Mean (' + IntToStr(n) + ')';
  MainForm.ReportGrid.Cells[(n-1)*4 + 2, 0]:= 'Min (' + IntToStr(n) + ')';
  MainForm.ReportGrid.Cells[(n-1)*4 + 3, 0]:= 'Max (' + IntToStr(n) + ')';
  MainForm.ReportGrid.Cells[(n-1)*4 + 4, 0]:= 'Std Dev (' + IntToStr(n) + ')';
  Row:= 1; nPS:= 0;
  for i:=0 to NumOfParameters - 1 do begin
     AvarageParams[i].name:= ReportParams[i].name;
     AvarageParams[i].k:= ReportParams[i].k;
     AvarageParams[i].m:= ReportParams[i].m;
     AvarageParams[i].mean:= AvarageParams[i].mean + ReportParams[i].mean;
     AvarageParams[i].min:= AvarageParams[i].min + ReportParams[i].min;
     AvarageParams[i].max:= AvarageParams[i].max + ReportParams[i].max;
     AvarageParams[i].stdDev:= AvarageParams[i].stdDev + ReportParams[i].stdDev;
     if FindPart('PR?T?F', ReportParams[i].name) > 0 then begin
        Phases[nPS]:= ReportParams[i];
        nPS:= nPS + 1;
     end
     else begin
       if n = 1 then MainForm.ReportGrid.Cells[0, Row]:= ReportParams[i].name;
       MainForm.ReportGrid.Cells[(n-1)*4 + 1, Row]:= FloatToStrF(ReportParams[i].mean, ffFixed, ReportParams[i].k, ReportParams[i].m);
       MainForm.ReportGrid.Cells[(n-1)*4 + 2, Row]:= FloatToStrF(ReportParams[i].min, ffFixed, ReportParams[i].k, ReportParams[i].m);
       MainForm.ReportGrid.Cells[(n-1)*4 + 3, Row]:= FloatToStrF(ReportParams[i].max, ffFixed, ReportParams[i].k, ReportParams[i].m);
       MainForm.ReportGrid.Cells[(n-1)*4 + 4, Row]:= FloatToStrF(ReportParams[i].stdDev, ffFixed, ReportParams[i].k, ReportParams[i].m);
       Row:= Row + 1;
     end;
  end;
  for i:=0 to 15 do begin
     MainForm.ReportGrid.Cells[0, i + 48]:= PhaseShiftName(i);
     MainForm.ReportGrid.Cells[(n-1)*4 + 1, i + 48]:= FloatToStrF(Phases[i].mean, ffFixed, Phases[i].k, Phases[i].m);
     MainForm.ReportGrid.Cells[(n-1)*4 + 2, i + 48]:= FloatToStrF(Phases[i].min, ffFixed, Phases[i].k, Phases[i].m);
     MainForm.ReportGrid.Cells[(n-1)*4 + 3, i + 48]:= FloatToStrF(Phases[i].max, ffFixed, Phases[i].k, Phases[i].m);
     MainForm.ReportGrid.Cells[(n-1)*4 + 4, i + 48]:= FloatToStrF(Phases[i].stdDev, ffFixed, Phases[i].k, Phases[i].m);
  end;
  for i:=1 to NumOfParameters do begin
     indx:= GetAvarage(MainForm.ReportGrid.Cells[0, i]);
     MainForm.AvarageGrid.Cells[0, i]:= MainForm.ReportGrid.Cells[0, i];
     MainForm.AvarageGrid.Cells[1, i]:= FloatToStrF(AvarageParams[indx].mean / NumOfFiles, ffFixed, AvarageParams[indx].k, AvarageParams[indx].m);
     MainForm.AvarageGrid.Cells[2, i]:= FloatToStrF(AvarageParams[indx].min / NumOfFiles, ffFixed, AvarageParams[indx].k, AvarageParams[indx].m);
     MainForm.AvarageGrid.Cells[3, i]:= FloatToStrF(AvarageParams[indx].max / NumOfFiles, ffFixed, AvarageParams[indx].k, AvarageParams[indx].m);
     MainForm.AvarageGrid.Cells[4, i]:= FloatToStrF(AvarageParams[indx].stdDev / NumOfFiles, ffFixed, AvarageParams[indx].k, AvarageParams[indx].m);
  end;
end;

procedure LoadFile(ReportFileName: String);
var DatReportFile: file of TSibrReportParam;
    i: integer;
begin
  AssignFile(DatReportFile, ReportFileName);
  try
     Reset(DatReportFile);
     i:= 0;
     while not eof(DatReportFile) do begin
        Read(DatReportFile, ReportParams[i]);
        i:= i + 1;
     end;
     CloseFile(DatReportFile);
  except
     on E: EInOutError do ShowMessage('File read error: ' + E.Message);
  end;
  if i > 0 then begin
    NumOfFiles:= NumOfFiles + 1;
    MainForm.FileList.Items.Add(IntToStr(NumOfFiles) + ' - ' + ExtractFileName(ReportFileName));
    MainForm.FileList.ItemIndex:= 0;
    if NumOfFiles > 1 then MainForm.ReportGrid.ColCount:= MainForm.ReportGrid.ColCount + 4;
    PrintParams(NumOfFiles);
  end;
end;

procedure TMainForm.AddReportClick(Sender: TObject);
begin
  if OpenDialog1.Execute then LoadFile(OpenDialog1.FileName);
end;

procedure TMainForm.Button1Click(Sender: TObject);
var i: integer;
begin
  for i:=0 to NumOfParameters-1 do begin
    AvarageParams[i].mean:= 0;
    AvarageParams[i].min:= 0;
    AvarageParams[i].max:= 0;
    AvarageParams[i].stdDev:= 0;
  end;
  ReportGrid.Clean;
  ReportGrid.ColCount:= 5;
  AvarageGrid.Clean;
  FileList.Clear;
  NumOfFiles:= 0;
  SelectedParam.Caption:= '';
  Chart1LineSeries1.Clear;
  Chart1LineSeries2.Clear;
  Chart1LineSeries3.Clear;
  Chart1LineSeries4.Clear;
  Chart1LineSeries5.Clear;
  Chart2LineSeries1.Clear;
  Chart3LineSeries1.Clear;
  Chart4LineSeries1.Clear;
end;

procedure TMainForm.ChartToolset1DataPointHintTool1Hint(
  ATool: TDataPointHintTool; const APoint: TPoint; var AHint: String);
begin
  AHint:= FileList.Items[ATool.PointIndex];
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  ChartHeight:= (MainForm.Height - 30) div 4;
  if ChartHeight < 100 then ChartHeight:= 100;
  Chart1.Height:= ChartHeight;
  Chart2.Height:= ChartHeight;
  Chart3.Height:= ChartHeight;
  Chart4.Height:= ChartHeight;
end;

procedure TMainForm.LoadFolderClick(Sender: TObject);
var
  L : TStringList;
  s : string;
begin
  if SelectDirectoryDialog1.Execute then begin
    L := TStringList.Create;
    try
      FindAllFiles(L, SelectDirectoryDialog1.FileName, '*.*', False);
      for s in L do begin
         if ExtractFileExt(s) = '.rpt' then LoadFile(s);
      end;
    finally
      L.Free;
    end;
  end;
end;

procedure TMainForm.CloseBtnClick(Sender: TObject);
begin
  MainForm.Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ChartHeight:= (MainForm.Height - 30) div 4;
  ReportGrid.ColWidths[0]:= 90;
  AvarageGrid.ColWidths[0]:= 90;
  ReportGrid.Cells[0, 0]:= 'Parameter';
  AvarageGrid.Cells[0, 0]:= 'Parameter';
  AvarageGrid.Cells[1, 0]:= 'Mean';
  AvarageGrid.Cells[2, 0]:= 'Min';
  AvarageGrid.Cells[3, 0]:= 'Max';
  AvarageGrid.Cells[4, 0]:= 'Std Dev';
end;

procedure TMainForm.ReportGridDrawCell(Sender: TObject; aCol,
  aRow: Integer; aRect: TRect; aState: TGridDrawState);
begin
  if ((((ACol - 1) DIV 4) MOD 2) > 0) and (ARow > 0) then ReportGrid.Canvas.Brush.Color:= RGBToColor(245, 255, 245);
  ReportGrid.Canvas.FillRect(aRect);
  ReportGrid.Canvas.TextOut(aRect.Left,aRect.Top,ReportGrid.Cells[Acol,Arow]);
end;

procedure DrawChart(Chart1LineSeries: TLineSeries; AvChart1LineSeries: TLineSeries; ParamType, ParamIndx: Integer; TitleText: string);
var i: integer;
begin
  Chart1LineSeries.Clear;
  AvChart1LineSeries.Clear;
  Chart1LineSeries.ParentChart.Title.Text[0]:= MainForm.ReportGrid.Cells[0, ParamIndx] + ' ' + TitleText;
  Chart1LineSeries.ParentChart.Title.Font.Color:= Chart1LineSeries.SeriesColor;
  Chart1LineSeries.Pointer.Pen.Color:= Chart1LineSeries.SeriesColor;
  Chart1LineSeries.Pointer.Brush.Color:= Chart1LineSeries.SeriesColor;
  Chart1LineSeries.ParentChart.Height:= ChartHeight;
  AvChart1LineSeries.LinePen.Color:= RGBToColor(50, 50, 50); ;
  for i:=1 to NumOfFiles do begin
     Chart1LineSeries.AddXY(i, StrToFloat(MainForm.ReportGrid.Cells[(i-1)*4 + 1 + ParamType, ParamIndx]));
     AvChart1LineSeries.AddXY(i, StrToFloat(MainForm.AvarageGrid.Cells[ParamType + 1, ParamIndx]));
  end;
end;

procedure TMainForm.ReportGridHeaderClick(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
begin
   if not IsColumn and (ReportGrid.Cells[0, Index] <> '') then begin
      SelectedParamIndx:= Index;
      SelectedParam.Caption:= ReportGrid.Cells[0, Index];

      DrawChart(Chart1LineSeries1, Chart1LineSeries5, 0, SelectedParamIndx, 'Mean');
      DrawChart(Chart1LineSeries2, Chart2LineSeries1,  1, SelectedParamIndx, 'Min');
      DrawChart(Chart1LineSeries3, Chart3LineSeries1,  2, SelectedParamIndx, 'Max');
      DrawChart(Chart1LineSeries4, Chart4LineSeries1,  3, SelectedParamIndx, 'Std Dev');

      PageControl1.ActivePage:= Graph;
   end;
end;

procedure TMainForm.ReportGridSelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
   if not (Sender as TStringGrid).Showing then Exit;
   ReportGrid.Cells[1,1]:= IntToStr(aCol) + '-' + IntToStr(aRow);
end;


end.

