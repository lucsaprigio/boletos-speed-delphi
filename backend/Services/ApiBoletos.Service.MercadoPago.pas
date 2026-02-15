unit ApiBoletos.Service.MercadoPago;

interface

uses
  System.SysUtils, System.Classes, System.Net.HttpClient, System.Net.URLClient,
  REST.Json, ApiBoletos.DTO.Payment, Winapi.Windows;

type
  iServicePagamentos = interface
    ['{BD2B77FA-0861-45F7-A33A-2BED31E1C7D9}']
    function ProcessarPagamento(aDados : TDTOPaymentBody): string;
  end;

  TServiceMercadoPago = class(TInterfacedObject, iServicePagamentos)
    public
    class function New: iServicePagamentos;
    function ProcessarPagamento(aDados : TDTOPaymentBody): string;
  end;

implementation

uses
  Boletos.Utils.Configuracao;

{ TServiceMercadoPago }

class function TServiceMercadoPago.New: iServicePagamentos;
begin
     Result := Self.Create;
end;

function TServiceMercadoPago.ProcessarPagamento(
  aDados: TDTOPaymentBody): string;
var
 LHttpClient : THTTPClient;
 LStreamBody : TStringStream;
 LJsonResponse : IHTTPResponse;
 LJsonEnvio    : string;
 LIdPotencyKey : string; // Chave de cada pagamento
begin
   // Utilizando o Request do front
   LJsonEnvio := TJson.ObjectToJsonString(aDados);

   LHttpClient := THTTPClient.Create;
   LStreamBody := TStringStream.Create(LJsonEnvio, TEncoding.UTF8);

   OutputDebugString(PWideChar('--- JSON ENVIADO PARA O MP ---'));
   OutputDebugString(PWideChar(LJsonEnvio));

   try
     try
      // O GUID trás o hash { hashaqui }, por isso o replace
      LIdPotencyKey := TGUID.NewGuid.ToString.Replace('{', '').Replace('}', '');

       LHttpClient.CustomHeaders['Content-Type']      := 'application.json';
       LHttpClient.CustomHeaders['Authorization']     := 'Bearer ' + TAppConfig.MP_ACCESS_TOKEN;
       LHttpClient.CustomHeaders['X-Idempotency-Key'] := LIdPotencyKey;

       LJsonResponse := LHttpClient.Post('https://api.mercadopago.com/v1/payments', LStreamBody);

       Result := LJsonResponse.ContentAsString(TEncoding.UTF8);
     except on E: Exception do begin
         raise Exception.Create('Erro na comunicação com a API do Mercado Pago: ' + E.Message);
       end;
     end;
   finally
     LHttpClient.Free;
     LStreamBody.Free;
   end;
end;

end.
