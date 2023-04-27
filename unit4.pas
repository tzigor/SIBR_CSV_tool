unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TTool }

  TTool = class(TForm)
    AR1T1F1: TStaticText;
    AR1T1F2: TStaticText;
    AR1T2F1: TStaticText;
    AR1T2F2: TStaticText;
    AR1T3F1: TStaticText;
    AR1T3F2: TStaticText;
    AR2T1F1: TStaticText;
    AR2T1F2: TStaticText;
    AR2T2F1: TStaticText;
    AR2T2F2: TStaticText;
    AR2T3F1: TStaticText;
    AR2T3F2: TStaticText;
    Button1: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Image1: TImage;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    StaticText16: TStaticText;
    StaticText17: TStaticText;
    StaticText18: TStaticText;
    StaticText19: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    Warning: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private

  public

  end;

var
  Tool: TTool;

implementation

{$R *.lfm}

{ TTool }

procedure TTool.Button1Click(Sender: TObject);
begin
  Tool.Close;
end;

procedure TTool.Image1Click(Sender: TObject);
begin

end;


end.

