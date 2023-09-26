unit AddCurveToChart;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Types,
  StrUtils, Unit2, LCLType;

type

  { TAddCurveForm }

  TAddCurveForm = class(TForm)
    CloseAddForm: TButton;
    ComputedChannelsExt: TListBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    RawChannelsExt: TListBox;
    SelectedChannelsExt: TListBox;
    procedure CloseAddFormClick(Sender: TObject);
    procedure ComputedChannelsExtDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure ComputedChannelsExtSelectionChange(Sender: TObject; User: boolean
      );
    procedure RawChannelsExtDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure RawChannelsExtSelectionChange(Sender: TObject; User: boolean);
  private

  public

  end;

procedure FillExtSelectedChannels;

var
  AddCurveForm: TAddCurveForm;

implementation

uses Unit1;

{$R *.lfm}

{ TAddCurveForm }

procedure TAddCurveForm.CloseAddFormClick(Sender: TObject);
begin
  AddCurveForm.Close;
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
  if ComputedChannelsExt.Selected[i] and (ComputedChannelsExt.SelCount + RawChannelsExt.SelCount > NumOsCharts) then ComputedChannelsExt.Selected[i]:= false
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
  if RawChannelsExt.Selected[i] and (ComputedChannelsExt.SelCount + RawChannelsExt.SelCount > NumOsCharts) then RawChannelsExt.Selected[i]:= false
  else FillExtSelectedChannels;
end;


end.

