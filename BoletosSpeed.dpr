program BoletosSpeed;

uses
  Vcl.Forms,
  frm.boletos.speed in 'frm.boletos.speed.pas' {frm_boletos_speed},
  dao.retorno.speed.boletos in 'dao.retorno.speed.boletos.pas',
  uDTOBoletos in 'uDTOBoletos.pas',
  controller.boletos.speed in 'controller.boletos.speed.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_boletos_speed, frm_boletos_speed);
  Application.Run;
end.
