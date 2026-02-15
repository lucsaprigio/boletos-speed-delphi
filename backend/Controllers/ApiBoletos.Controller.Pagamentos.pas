unit ApiBoletos.Controller.Pagamentos;

interface

uses
  Horse, System.JSON, REST.JSON, ApiBoletos.DTO.Payment, System.SysUtils,
  ApiBoletos.Service.MercadoPago, ApiBoletos.DTO.Payment.Response,
  ApiBoletos.DTO.MercadoPago.Response, Winapi.Windows,
  ApiBoletos.Model.PagamentosMP;

type
  TControllerPagamentos = class
  public
    class procedure EfetuarPagamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure BuscarPagamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

{ TControllerPagamentos }

class procedure TControllerPagamentos.BuscarPagamento(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LPaymentParam       : Int64;
  LRetornoMP          : string;
  LGetPaymentResponse : TDTOGetPaymentResponse;

  LJsonResponse       : TJSONObject;
begin
  LPaymentParam := Req.Params.Field('id').AsInt64;

  LRetornoMP    := TServiceMercadoPago.New.BuscarPagemento(LPaymentParam);


  LJsonResponse := TJSONObject.ParseJSONValue(LRetornoMP) as TJSONObject;
  try
  LGetPaymentResponse := TDTOGetPaymentResponse.Create;
   try
   LGetPaymentResponse.Id := LJsonResponse.GetValue<Int64>('id', 0);
   LGetPaymentResponse.Status := LJsonResponse.GetValue<String>('status', '');
   LGetPaymentResponse.Description := LJsonResponse.GetValue<String>('description', '');

   Res.Status(201).Send(TJson.ObjectToJsonString(LGetPaymentResponse));
  finally
   LGetPaymentResponse.Free;
  end;
  finally
    LJsonResponse.Free;
  end;
end;

class procedure TControllerPagamentos.EfetuarPagamento(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LPaymentBody: TDTOPaymentBody;
  LRetornoMP: string;
  LPaymentResponse : TDTOPaymentResponse;

  LPaymentData : TPagamentorRecord;

  LJsonMP : TJSONObject;
  LPoint, LTransaction : TJSONObject;
begin

  // Já faz o .Create
  LPaymentBody := TJson.JsonToObject<TDTOPaymentBody>(Req.Body);
  try
    try
      // Chamar o Service do MercadoPago para processar o pagamento.
      LPaymentBody.ValidaDados;

      // Buscar primeiramente no banco de Dados, se existe o pagamento
      LPaymentData := TModelPagamento.BuscarPagamento(LPaymentBody.ExternalReference);

      if LPaymentData.Id > 0 then begin
        LPaymentResponse := TDTOPaymentResponse.Create;
        try
          LPaymentResponse.IdPagamento := LPaymentData.Id;
          LPaymentResponse.Status := LPaymentData.Status;
          LPaymentResponse.TicketUrl := LPaymentData.TicketUrl;
          LPaymentResponse.ExternalReference := LPaymentData.Duplicata;
          LPaymentResponse.QRCode := '';

          Res.Status(201).Send(TJson.ObjectToJsonString(LPaymentResponse));
          Exit; // Para não continuar o código abaixo
        finally
          LPaymentResponse.Free;
        end;
      end;

      LRetornoMP := TServiceMercadoPago.New.ProcessarPagamento(LPaymentBody);

      LJsonMP := TJSONObject.ParseJSONValue(LRetornoMP) as TJSONObject;
      try
      LPaymentResponse := TDTOPaymentResponse.Create;
        try
           LPaymentResponse.IdPagamento := LJsonMP.GetValue<Int64>('id', 0);
           LPaymentResponse.Status      := LJsonMP.GetValue<string>('status', '');
           LPaymentResponse.ExternalReference := LJsonMP.GetValue<string>('external_reference', '');

           if LJsonMP.TryGetValue<TJSONObject>('point_of_interaction', LPoint) then begin
            if LPoint.TryGetValue<TJSONObject>('transaction_data', LTransaction) then
             begin
               LPaymentResponse.QRCode := LTransaction.GetValue<string>('qr_code', '');
               LPaymentResponse.TicketUrl := LTransaction.GetValue<string>('ticket_url', '');
             end;
           end;


           // Gravar o pagamento dentro do Banco de dados
             LPaymentData.Id        := LPaymentResponse.IdPagamento;
             LPaymentData.Status    := LPaymentResponse.Status;
             LPaymentData.TicketUrl := LPaymentResponse.TicketUrl;
             LPaymentData.Duplicata := LPaymentResponse.ExternalReference;

             TModelPagamento.SalvarPagamento(LPaymentData);

           Res.Status(201).Send(TJson.ObjectToJsonString(LPaymentResponse));
        finally
           LPaymentResponse.Free;
        end;
      finally
         LJsonMP.Free;
      end;
    except
      on E: Exception do
      begin
        Res.Status(400).Send('{"erro" : "' + E.Message + '"');
      end;
    end;
  finally
    LPaymentBody.Free;
  end;
end;

end.
