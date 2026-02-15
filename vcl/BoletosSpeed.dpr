program BoletosSpeed;

uses
  Vcl.Forms,
  frm.boletos.speed in 'frm.boletos.speed.pas' {frm_boletos_speed},
  dao.retorno.speed.boletos in 'dao.retorno.speed.boletos.pas',
  uDTOBoletos in 'uDTOBoletos.pas',
  controller.boletos.speed in 'controller.boletos.speed.pas',
  Boletos.Utils.Configuracao in '..\utils\Boletos.Utils.Configuracao.pas',
  ApiBoletos.DTO.Payment in '..\backend\DTO\ApiBoletos.DTO.Payment.pas',
  ApiBoletos.DTO.Payment.Response in '..\backend\DTO\ApiBoletos.DTO.Payment.Response.pas',
  frm.visualizador.pix in 'frm.visualizador.pix.pas' {frm_visualizador_pix};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_boletos_speed, frm_boletos_speed);
  Application.Run;
end.
