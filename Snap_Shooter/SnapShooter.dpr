program SnapShooter;

uses Forms, Windows, uMain in 'uMain.pas' {fMain};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;
  ShowWindow(Application.Handle, SW_HIDE);

  Application.Title := 'SnapShooter. Программа для скоростного скриншотинга :)';
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
