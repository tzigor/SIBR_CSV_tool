unit Unit4;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

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

end.

