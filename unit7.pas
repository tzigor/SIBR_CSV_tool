unit Unit7;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Unit2, Options, TAGraph, TASeries, LCLType, Buttons, StrUtils;

type

  { TPanelsLib }

  TPanelsLib = class(TForm)
    DeleteRecord: TBitBtn;
    LoadLib: TButton;
    Label1: TLabel;
    PanelName: TEdit;
    LoadProgress: TProgressBar;
    SaveLib: TButton;
    CloseLib: TButton;
    PanelList: TListBox;
    procedure CloseLibClick(Sender: TObject);
    procedure DeleteRecordClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure LoadLibClick(Sender: TObject);
    procedure PanelListDblClick(Sender: TObject);
    procedure PanelListSelectionChange(Sender: TObject; User: boolean);
    procedure SaveLibClick(Sender: TObject);
  private

  public

  end;

  function GetLibIndex(Name: String; var RecordExist: Boolean): Integer;

var
  PanelsLib: TPanelsLib;

implementation

Uses Unit1, Panel;

{$R *.lfm}

{ TPanelsLib }

procedure TPanelsLib.CloseLibClick(Sender: TObject);
begin
  Close;
end;

procedure TPanelsLib.DeleteRecordClick(Sender: TObject);
var FilePos: Integer;
  RecordExist: Boolean;
  wStr: String;
begin
  if Application.MessageBox('Are you sure?','Warning', MB_ICONQUESTION + MB_YESNO) = IDYES then begin
     AssignFile(PanelsLibFile, 'Panels.lib');
     try
        CurvesPanel.Name:= '';
        Reset(PanelsLibFile);
        FilePos:= PanelList.ItemIndex;
        wStr:= PanelList.Items[PanelList.ItemIndex];
        FilePos:= GetLibIndex(PanelList.Items[PanelList.ItemIndex], RecordExist);
        Seek(PanelsLibFile, FilePos);
        Write(PanelsLibFile, CurvesPanel);
        CloseFile(PanelsLibFile);
     except
       on E: EInOutError do ShowMessage('File write error: ' + E.ClassName + '/' + E.Message)
     end;
     Close;
  end;
end;

procedure TPanelsLib.FormActivate(Sender: TObject);
begin
  PanelsLib.Left:= PanelsLib.Left + 150;
end;

function GetLibIndex(Name: String; var RecordExist: Boolean): Integer;
var FilePos: Integer;
    Data: TPanel;
begin
   FilePos:= 0;
   RecordExist:= false;
   Reset(PanelsLibFile);
   while not eof(PanelsLibFile) do begin
      Read(PanelsLibFile, Data);
      if Name = Data.Name then begin
        RecordExist:= true;
        break;
      end;
      FilePos:= FilePos + 1;
   end;
   GetLibIndex:= FilePos;
end;

function GetLibIndexForWrite(): Integer;
var FilePos: Integer;
    Data: TPanel;
begin
   FilePos:= 0;
   Reset(PanelsLibFile);
   while not eof(PanelsLibFile) do begin
      Read(PanelsLibFile, Data);
      if Data.Name = '' then break;
      FilePos:= FilePos + 1;
   end;
   GetLibIndexForWrite:= FilePos;
end;

procedure TPanelsLib.LoadLibClick(Sender: TObject);
var i, j, n: Byte;
    LastPane, TitleUp: String;
    RecordExist: Boolean;
begin
  if PanelList.Items.Count > 0 then
    if FileExists(LibFileName) then begin
       AssignFile(PanelsLibFile, LibFileName);
       Reset(PanelsLibFile);
       ResetPanes(1);
       try
         Seek(PanelsLibFile, GetLibIndex(PanelList.Items[PanelList.ItemIndex], RecordExist));
         Read(PanelsLibFile, CurvesPanel);
         CloseFile(PanelsLibFile);
         SetOptions(CurvesPanel.ChartBGColor, CurvesPanel.ChartColor, CurvesPanel.GridColor);
         n:=0 ;
         for i:= 1 to 10 do
           for j:= 1 to 4 do
             if CurvesPanel.PaneSet.Panes[i-1].Curves[j-1].Parameter <> '' then n:= n + 1;
         LoadProgress.Max:= n;
         LoadProgress.Position:= 0;
         for i:= 1 to 10 do
           for j:= 1 to 4 do begin
             if CurvesPanel.PaneSet.Panes[i-1].Curves[j-1].Parameter <> '' then begin
                TChart(CSV.FindComponent('Pane' + IntToStr(i))).Left:= 10000;
                TChart(CSV.FindComponent('Pane' + IntToStr(i))).Visible:= true;
                DrawCurveFromPane(TLineSeries(CSV.FindComponent('Pane' + IntToStr(i) + 'Curve' + IntToStr(j))), CurvesPanel.PaneSet.Panes[i-1], i-1, j-1);
                LastPane:= 'Pane' + IntToStr(i);
             end;
             LoadProgress.Position:= LoadProgress.Position + 1;
           end;
         if CSV.ShowDateTime.Checked then TChart(CSV.FindComponent(LastPane)).AxisList[0].Marks.Visible:= True;
         CSV.PanelTitle.Caption:= PanelList.Items[PanelList.ItemIndex];
       except
         on E: EInOutError do ShowMessage('File read error: ' + E.Message);
       end;
    end
    else ShowMessage('Panels.lib not found');
    PanelsLib.Close;
    FitPanesToWindow;
    PanesResetZoom;
    LibFileName:= 'Panels.lib';
end;

procedure TPanelsLib.PanelListDblClick(Sender: TObject);
var
  lb: TListBox;
begin
  lb := (Sender as TListBox);
  if ((lb = nil) or (lb.ItemIndex < 0)) then Exit;
  LoadLibClick(Sender);
end;

procedure TPanelsLib.PanelListSelectionChange(Sender: TObject; User: boolean);
begin
   PanelName.Text:= PanelList.Items[PanelList.ItemIndex];
end;

procedure TPanelsLib.SaveLibClick(Sender: TObject);
var FilePos: Integer;
    WriteAccept, RecordExist: Boolean;
begin
  if PanelName.Text <> '' then begin
    ShowMessage(PanelName.Text);
    AssignFile(PanelsLibFile, 'Panels.lib');
    try
      WriteAccept:= true;
      Reset(PanelsLibFile);
      CurvesPanel.Name:= PanelName.Text;
      CurvesPanel.ChartBGColor:= OptionsForm.ChartBGColor.Selected;
      CurvesPanel.ChartColor:= OptionsForm.ChartColor.Selected;
      CurvesPanel.GridColor:= OptionsForm.GridColor.Selected;
      FilePos:= GetLibIndex(PanelName.Text, RecordExist);
      if RecordExist then begin
         if Application.MessageBox('Do you really want to overwrite record?','Warning', MB_ICONQUESTION + MB_YESNO) = IDNO then WriteAccept:= false;
      end
      else FilePos:= GetLibIndexForWrite();
      if WriteAccept then begin
         Seek(PanelsLibFile, FilePos);
         Write(PanelsLibFile, CurvesPanel);
         CSV.PanelTitle.Caption:= PanelName.Text;
      end;
      CloseFile(PanelsLibFile);
    except
      on E: EInOutError do ShowMessage('File write error: ' + E.ClassName + '/' + E.Message)
    end;
    Close;
  end;
end;


end.

