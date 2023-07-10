program SIBR_CSV_tool;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, datetimectrls, lazcontrols, Unit1, Unit2, Unit3,
  Unit4, Parameters, Unit5, Unit6, Unit7, Panel, Options
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TCSV, CSV);
  Application.CreateForm(TTool, Tool);
  Application.CreateForm(TPaneEdit, PaneEdit);
  Application.CreateForm(TPanelsLib, PanelsLib);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.Run;
end.

