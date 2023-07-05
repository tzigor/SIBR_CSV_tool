unit Unit7;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Unit2;

type

  { TPanelsLib }

  TPanelsLib = class(TForm)
    Label1: TLabel;
    PanelName: TEdit;
    SaveLib: TButton;
    CloseLib: TButton;
    PanelList: TListBox;
    procedure CloseLibClick(Sender: TObject);
    procedure PanelListSelectionChange(Sender: TObject; User: boolean);
    procedure SaveLibClick(Sender: TObject);
  private

  public

  end;

var
  PanelsLib: TPanelsLib;

implementation

Uses Unit1;

{$R *.lfm}

{ TPanelsLib }

procedure TPanelsLib.CloseLibClick(Sender: TObject);
begin
  Close;
end;

procedure TPanelsLib.PanelListSelectionChange(Sender: TObject; User: boolean);
begin
   PanelName.Text:= PanelList.Items[PanelList.ItemIndex];
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

procedure TPanelsLib.SaveLibClick(Sender: TObject);
begin
  if PanelName.Text <> '' then begin
    AssignFile(PanelsLibFile, 'Panels.lib');
    try
       Reset(PanelsLibFile);
       CurvesPanel.Name:= PanelName.Text;
       CurvesPanel.PaneSet:= PaneSet;
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

