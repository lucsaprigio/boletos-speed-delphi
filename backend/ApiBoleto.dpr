program ApiBoleto;

uses
  Vcl.Forms,
  BoletosApi in 'BoletosApi.pas' {frm_principal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_principal, frm_principal);
  Application.ShowMainForm      := False;
  Application.Run;
end.
