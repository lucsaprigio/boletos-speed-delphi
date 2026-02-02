program ApiBoleto;

uses
  Vcl.Forms,
  BoletosApi in 'BoletosApi.pas' {frm_principal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ShowMainForm      := False;
  Application.CreateForm(Tfrm_principal, frm_principal);
  Application.Run;
end.
