unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Unit2;

type

  { TTool }

  TTool = class(TForm)
    Button1: TButton;
    Image6: TImage;
    Image8: TImage;
    Warning: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    AR1T1F1: TStaticText;
    AR1T1F2: TStaticText;
    AR2T1F1: TStaticText;
    AR2T1F2: TStaticText;
    AR1T2F1: TStaticText;
    AR1T2F2: TStaticText;
    AR2T2F1: TStaticText;
    AR2T2F2: TStaticText;
    AR1T3F1: TStaticText;
    AR1T3F2: TStaticText;
    AR2T3F1: TStaticText;
    AR2T3F2: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Tool: TTool;

implementation

{$R *.lfm}

{ TTool }

procedure ToolAmplsWidth(wdth: Byte);
begin
  Tool.AR1T1F1.Width:= wdth;
  Tool.AR1T1F2.Width:= wdth;
  Tool.AR2T1F1.Width:= wdth;
  Tool.AR2T1F2.Width:= wdth;
  Tool.AR1T2F1.Width:= wdth;
  Tool.AR1T2F2.Width:= wdth;
  Tool.AR2T2F1.Width:= wdth;
  Tool.AR2T2F2.Width:= wdth;
  Tool.AR1T3F1.Width:= wdth;
  Tool.AR1T3F2.Width:= wdth;
  Tool.AR2T3F1.Width:= wdth;
  Tool.AR2T3F2.Width:= wdth;
end;

procedure TTool.Button1Click(Sender: TObject);
begin
  Tool.Close;
end;

procedure TTool.FormActivate(Sender: TObject);
begin
  if AmplsInmVolts then ToolAmplsWidth(48)
  else ToolAmplsWidth(77);
end;

procedure TTool.FormCreate(Sender: TObject);
begin

end;

end.

