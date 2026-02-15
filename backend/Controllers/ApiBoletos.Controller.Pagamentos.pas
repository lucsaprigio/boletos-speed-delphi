unit ApiBoletos.Controller.Pagamentos;

interface

uses
  Horse, System.JSON, REST.JSON, ApiBoletos.DTO.Payment, System.SysUtils,
  ApiBoletos.Service.MercadoPago;

type
  TControllerPagamentos = class
  public
    class procedure EfetuarPagamento(Req: THorseRequest; Res: THorseResponse;
      Next: TProc);
  end;

implementation

{ TControllerPagamentos }

class procedure TControllerPagamentos.EfetuarPagamento(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LDTOPagamento: TDTOPaymentBody;
  LRetornoMP: string;
begin

  // Já faz o .Create
  LDTOPagamento := TJson.JsonToObject<TDTOPaymentBody>(Req.Body);
  try
    try
      // Chamar o Service do MercadoPago para processar o pagamento.
      LDTOPagamento .ValidaDados;

      LRetornoMP := TServiceMercadoPago.New.ProcessarPagamento(LDTOPagamento);

      Res.Status(201).Send(LRetornoMP);
    except
      on E: Exception do
      begin
        Res.Status(400).Send('{"erro" : "' + E.Message + '"');
      end;
    end;
  finally
    LDTOPagamento.Free;
  end;
end;

end.
