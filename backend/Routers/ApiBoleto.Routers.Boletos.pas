unit ApiBoleto.Routers.Boletos;

interface

uses
  Horse, ApiBoletos.Controller.Pagamentos;

procedure RegistrarRotas;

implementation

uses ApiBoletos.Controllers.Boletos;

procedure RegistrarRotas;
begin
  // Vamos chamar spdboleto/cd_cliente.
  // Vamos jogar o controller a aqui dentro.
  THorse.Get('/api/boletos/:id', TControllerBoletos.GetBoletosByClient);

  // Pagamentos MercadoPago
  THorse.Get('/api/pagamento/:id', TControllerPagamentos.BuscarPagamento);
  THorse.Post('/api/pagamento', TControllerPagamentos.EfetuarPagamento);
end;

end.
