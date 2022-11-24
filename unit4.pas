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
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    T1R1F1: TStaticText;
    T1R1F2: TStaticText;
    T1R2F1: TStaticText;
    T1R2F2: TStaticText;
    T2R1F1: TStaticText;
    T2R1F2: TStaticText;
    T2R2F1: TStaticText;
    T2R2F2: TStaticText;
    T3R1F1: TStaticText;
    T3R1F2: TStaticText;
    T3R2F1: TStaticText;
    T3R2F2: TStaticText;
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

