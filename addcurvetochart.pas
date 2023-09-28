unit AddCurveToChart;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Types,
  StrUtils, Unit2, LCLType, Buttons, ComCtrls, TASeries;

type

  { TAddCurveForm }

  TAddCurveForm = class(TForm)
    AddChannels: TBitBtn;
    CloseAddForm: TBitBtn;
    UnCheck: TButton;
    RemoveAll: TBitBtn;
    ComputedChannelsExt: TListBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    CommonBarExt: TProgressBar;
    RawChannelsExt: TListBox;
    SelectedChannelsExt: TListBox;
    procedure AddChannelsClick(Sender: TObject);
    procedure CloseAddFormClick(Sender: TObject);
    procedure ComputedChannelsExtDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure ComputedChannelsExtSelectionChange(Sender: TObject; User: boolean
      );
    procedure RawChannelsExtDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure RawChannelsExtSelectionChange(Sender: TObject; User: boolean);
    procedure RemoveAllClick(Sender: TObject);
    procedure UnCheckClick(Sender: TObject);
  private

  public

  end;

procedure FillExtSelectedChannels;

var
  AddCurveForm: TAddCurveForm;

implementation

uses Unit1, Utils;

{$R *.lfm}

{ TAddCurveForm }

procedure TAddCurveForm.CloseAddFormClick(Sender: TObject);
begin
  AddCurveForm.Close;
end;

function LineSerieInList(LineSerie: TLineSeries): Boolean;
var i      : Byte;
    InList : Boolean;
begin
  InList:= false;
  for i:=1 to AddCurveForm.SelectedChannelsExt.Items.Count do begin
     if (LineSerie.Count > 0) And (LineSerie.Title = AddCurveForm.SelectedChannelsExt.Items[i-1]) then begin
        InList:= true;
        Break;
     end;
  end;
  Result:= InList;
end;

function ListExtItemDrawed(Item: String): Boolean;
var i         : Byte;
    Drawed    : Boolean;
    LineSerie : TLineSeries;
begin
  Drawed:= false;
  for i:=2 to 8 do begin
     LineSerie:= GetLineSerie(SelectedChartToAdd, i);
     if (LineSerie.Count > 0) And (LineSerie.Title = Item ) then Drawed:= true;
  end;
  Result:= Drawed;
end;

procedure TAddCurveForm.AddChannelsClick(Sender: TObject);
var i, n: Integer;
    LineSerie : TLineSeries;
begin
  if SelectedChannelsExt.Items.Count > 0 then begin

     for i:= 2 to 8 do begin
        LineSerie:= GetLineSerie(SelectedChartToAdd, i);
        if Not LineSerieInList(LineSerie) then begin
           LineSerie.Clear;
           LineSerie.Title:= '';
           LineSerie.Legend.Visible:= False;
        end;
     end;

     for i:= 1 to SelectedChannelsExt.Items.Count do begin
        if Not ListExtItemDrawed(SelectedChannelsExt.Items[i-1]) then begin
           DrawChart(GetLineSerie(SelectedChartToAdd, GetFreeLineSerie(SelectedChartToAdd)), SelectedChannelsExt.Items[i-1], 0);
        end;
     end;
     if CSV.AutoFit.Checked then CSV.FitToWinClick(Sender);
     ResetZoom;
     AddCurveForm.Close;
  end
  else ShowMessage('No parameters selected.');
end;

procedure FillExtSelectedChannels;
var i: Integer;
begin
  AddCurveForm.SelectedChannelsExt.Clear;
  for i:=0 to AddCurveForm.RawChannelsExt.Items.Count - 1 do
     if AddCurveForm.RawChannelsExt.Selected[i] then AddCurveForm.SelectedChannelsExt.Items.Add(AddCurveForm.RawChannelsExt.Items[i]);

  for i:=0 to AddCurveForm.ComputedChannelsExt.Items.Count - 1 do
     if AddCurveForm.ComputedChannelsExt.Selected[i] then AddCurveForm.SelectedChannelsExt.Items.Add(AddCurveForm.ComputedChannelsExt.Items[i]);
end;

procedure TAddCurveForm.ComputedChannelsExtDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  with ComputedChannelsExt do begin
    if Items[Index] in AmplitudesChannels then Canvas.Font.Color:= clBlue
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

procedure TAddCurveForm.ComputedChannelsExtSelectionChange(Sender: TObject;
  User: boolean);
var
    Pos: TPoint;
    i:   Integer;
begin
  Pos:= Mouse.CursorPos;
  Pos:= ComputedChannelsExt.ScreenToClient(Pos);
  i:= ComputedChannelsExt.GetIndexAtXY(Pos.X, Pos.Y);
  if ComputedChannelsExt.Selected[i] and (ComputedChannelsExt.SelCount + RawChannelsExt.SelCount > NumOsCharts - 1) then ComputedChannelsExt.Selected[i]:= false
  else FillExtSelectedChannels;
end;

procedure TAddCurveForm.RawChannelsExtDrawItem(Control: TWinControl;
  Index: Integer; ARect: TRect; State: TOwnerDrawState);
begin
  with RawChannelsExt do begin
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

procedure TAddCurveForm.RawChannelsExtSelectionChange(Sender: TObject;
  User: boolean);
var
    Pos: TPoint;
    i:   Integer;
begin
  Pos:= Mouse.CursorPos;
  Pos:= RawChannelsExt.ScreenToClient(Pos);
  i:= RawChannelsExt.GetIndexAtXY(Pos.X, Pos.Y);
  if RawChannelsExt.Selected[i] and (ComputedChannelsExt.SelCount + RawChannelsExt.SelCount > NumOsCharts - 1) then RawChannelsExt.Selected[i]:= false
  else FillExtSelectedChannels;
end;

procedure TAddCurveForm.RemoveAllClick(Sender: TObject);
var i: Byte;
    LineSerie : TLineSeries;
begin
  for i:= 2 to 8 do begin
     LineSerie:= GetLineSerie(SelectedChartToAdd, i);
     LineSerie.Clear;
     LineSerie.Title:= '';
     LineSerie.Legend.Visible:= False;
  end;
  ResetZoom;
  AddCurveForm.Close;
end;

procedure TAddCurveForm.UnCheckClick(Sender: TObject);
begin
  AddCurveForm.SelectedChannelsExt.Clear;
  AddCurveForm.RawChannelsExt.ClearSelection;
  AddCurveForm.ComputedChannelsExt.ClearSelection;
end;


end.

