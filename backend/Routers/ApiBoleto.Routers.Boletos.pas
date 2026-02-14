unit ApiBoleto.Routers.Boletos;

interface

uses
  Horse;

procedure RegistrarRotas;

implementation

uses ApiBoletos.Controllers.Boletos;

procedure RegistrarRotas;
begin
  // Vamos chamar spdboleto/cd_cliente.
  // Vamos jogar o controllera aqui dentro.
  THorse.Get('/api/boletos/:id', TControllerBoletos.GetBoletosByClient);
end;

end.
