unit Unit7;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Unit2, TAGraph, TASeries;

type

  { TPanelsLib }

  TPanelsLib = class(TForm)
    LoadLib: TButton;
    Label1: TLabel;
    PanelName: TEdit;
    SaveLib: TButton;
    CloseLib: TButton;
    PanelList: TListBox;
    procedure CloseLibClick(Sender: TObject);
    procedure LoadLibClick(Sender: TObject);
    procedure PanelListSelectionChange(Sender: TObject; User: boolean);
    procedure SaveLibClick(Sender: TObject);
  private

  public

  end;

  function GetLibIndex(Name: String): Integer;

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

function GetLibIndex(Name: String): Integer;
var FilePos: Integer;
    Data: TPanel;
begin
   FilePos:= 0;
   while not eof(PanelsLibFile) do begin
      Read(PanelsLibFile, Data);
      if Name = Data.Name then break;
      FilePos:= FilePos + 1;
   end;
   GetLibIndex:= FilePos;
end;

procedure TPanelsLib.LoadLibClick(Sender: TObject);
var i, j: Byte;
begin
  if PanelList.Items.Count > 0 then
    if FileExists('Panels.lib') then begin
       AssignFile(PanelsLibFile, 'Panels.lib');
       Reset(PanelsLibFile);
       ResetPanes(1);
       try
         Seek(PanelsLibFile, GetLibIndex(PanelList.Items[PanelList.ItemIndex]));
         Read(PanelsLibFile, CurvesPanel);
         CloseFile(PanelsLibFile);

         CSV.Memo1.Text:= '';
         for i:= 0 to 9 do begin
           CSV.Memo1.Text:= CSV.Memo1.Text + 'Pane ' + IntToStr(i+1) + Line;
           for j:= 0 to 3 do begin
             CSV.Memo1.Text:= CSV.Memo1.Text + '    Parameter: ' + CurvesPanel.PaneSet.Panes[i].Curves[j].Parameter + Line;
             CSV.Memo1.Text:= CSV.Memo1.Text + '    ParameterTitle: ' + CurvesPanel.PaneSet.Panes[i].Curves[j].ParameterTitle + Line;
           end;
         end;

         for i:= 1 to 10 do
           for j:= 1 to 4 do
             if CurvesPanel.PaneSet.Panes[i-1].Curves[j-1].Parameter <> '' then begin
                TChart(CSV.FindComponent('Pane' + IntToStr(i))).Left:= 10000;
                TChart(CSV.FindComponent('Pane' + IntToStr(i))).Visible:= true;
                DrawCurveFromPane(TLineSeries(CSV.FindComponent('Pane' + IntToStr(i) + 'Curve' + IntToStr(j))), CurvesPanel.PaneSet.Panes[i-1], i-1, j-1);
             end;
       except
         on E: EInOutError do ShowMessage('File read error: ' + E.Message);
       end;
    end
    else ShowMessage('Panels.lib');
    PanelsLib.Close;
    FitPanesToWindow;
end;

procedure TPanelsLib.PanelListSelectionChange(Sender: TObject; User: boolean);
begin
   PanelName.Text:= PanelList.Items[PanelList.ItemIndex];
end;

procedure TPanelsLib.SaveLibClick(Sender: TObject);
begin
  if PanelName.Text <> '' then begin
    AssignFile(PanelsLibFile, 'Panels.lib');
    try
      Reset(PanelsLibFile);
      CurvesPanel.Name:= PanelName.Text;
      //CurvesPanel.CurvesPanel.PaneSet:= CurvesPanel.PaneSet;
      Seek(PanelsLibFile, GetLibIndex(PanelName.Text));
      Write(PanelsLibFile, CurvesPanel);
      CloseFile(PanelsLibFile);
    except
      on E: EInOutError do ShowMessage('File write error: ' + E.ClassName + '/' + E.Message)
    end;
    Close;
  end;
end;


end.

