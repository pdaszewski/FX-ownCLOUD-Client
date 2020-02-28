program ownCLOUDClientFX;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  AOknoGl_frm in 'ProjectForms\AOknoGl_frm.pas' {AOknoGl},
  ownCLOUDunit_frm in 'ProjectForms\ownCLOUDunit_frm.pas' {ownCLOUDunit},
  WgrywanieFolderu_frm in 'ProjectForms\WgrywanieFolderu_frm.pas' {WgrywanieFolderu};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'ownCLOUD client';
  Application.CreateForm(TAOknoGl, AOknoGl);
  Application.CreateForm(TownCLOUDunit, ownCLOUDunit);
  Application.CreateForm(TWgrywanieFolderu, WgrywanieFolderu);
  Application.Run;
end.
