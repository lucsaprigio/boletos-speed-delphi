program ApiBoleto;

uses
  Vcl.Forms,
  BoletosApi in 'BoletosApi.pas' {frm_principal},
  ApiBoleto.Routers.Boletos in 'Routers\ApiBoleto.Routers.Boletos.pas',
  ApiBoletos.Controllers.Boletos in 'Controllers\ApiBoletos.Controllers.Boletos.pas',
  ApiBoletos.Model.Boletos in 'Models\ApiBoletos.Model.Boletos.pas',
  ApiBoletos.Infra.Connection in 'Infra\ApiBoletos.Infra.Connection.pas',
  Boletos.Utils.Configuracao in '..\utils\Boletos.Utils.Configuracao.pas',
  ApiBoletos.DTO.Payment in 'DTO\ApiBoletos.DTO.Payment.pas',
  ApiBoletos.Controller.Pagamentos in 'Controllers\ApiBoletos.Controller.Pagamentos.pas',
  ApiBoletos.Service.MercadoPago in 'Services\ApiBoletos.Service.MercadoPago.pas',
  ApiBoletos.DTO.MercadoPago.Response in 'DTO\ApiBoletos.DTO.MercadoPago.Response.pas',
  ApiBoletos.DTO.Payment.Response in 'DTO\ApiBoletos.DTO.Payment.Response.pas',
  ApiBoletos.Model.PagamentosMP in 'Models\ApiBoletos.Model.PagamentosMP.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_principal, frm_principal);
  Application.ShowMainForm      := False;
  Application.Run;
end.
