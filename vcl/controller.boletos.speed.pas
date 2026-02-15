unit controller.boletos.speed;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  RESTRequest4D,
  DataSet.Serialize.Adapter.RESTRequest4D, ApiBoletos.DTO.Payment,
  ApiBoletos.DTO.Payment.Response, System.JSON, REST.Json,
  Boletos.Utils.Configuracao
  ;

type
  TControllerBoletosSpeed = class
  private
    FBaseURL: String;
  public
    procedure BuscarBoletos(aCliente: integer; aMemTable: TFDMemTable);
    class function CriarPix(Request: TDTOPaymentBody): TDTOPaymentResponse;
    class function ConsultarPagamento(AIdPagamento : Int64) : String;
  end;

implementation

{ TControllerBoletosSpeed }

procedure TControllerBoletosSpeed.BuscarBoletos(aCliente: integer;
  aMemTable: TFDMemTable);
var
  LResponse: IResponse;
begin

//  if aMemTable.FieldCount = 0 then
//  begin
//    aMemTable.FieldDefs.Add('sp_documento', ftInteger);
//    aMemTable.FieldDefs.Add('sp_parcela', ftInteger);
//    aMemTable.FieldDefs.Add('sp_valor', ftFloat);
//    aMemTable.FieldDefs.Add('sp_vencimento', ftDateTime); // Avisa que é Data!
//    aMemTable.FieldDefs.Add('sp_emissao', ftDateTime); // Avisa que é Data!
//    aMemTable.FieldDefs.Add('sp_atrz', ftString, 10);
//    aMemTable.FieldDefs.Add('sp_dias', ftInteger);
//    aMemTable.FieldDefs.Add('sp_pix', ftFloat);
//
//    aMemTable.CreateDataSet;
//  end;

  if aMemTable.Active then
    aMemTable.EmptyDataSet;

  try
    LResponse := TRequest.New.BaseURL(TAppConfig.API_URL)
      .Resource('/api/boletos/' + aCliente.ToString)
      .Adapters(TDataSetSerializeAdapter.New(aMemTable))
      .Get;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao buscar Dados : ' + E.Message);
    end;
  end;
end;

class function TControllerBoletosSpeed.ConsultarPagamento(
  AIdPagamento: Int64): String;
var
  LResponse     : IResponse;
  LJsonResponse : TJSONObject;
begin
  Result := '';

     LResponse := TRequest.New.BaseURL(TAppConfig.API_URL)
                .Resource('/api/pagamento/' + AIdPagamento.ToString)
                .Accept('application/json')
                .Get;

     if LResponse.StatusCode in [200, 201] then begin
       LJsonResponse := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONObject;  // Transformar string para JSON

       try
         if Assigned(LJsonResponse) then
          Result := LJsonResponse.GetValue<String>('status', 'pending'); // Abstrair somente o status para trazer como string
       finally
         LJsonResponse.Free;
       end;
     end;
end;

class function TControllerBoletosSpeed.CriarPix(
  Request: TDTOPaymentBody): TDTOPaymentResponse;
var
  LResponse     : IResponse;
  LJsonError    : TJSONObject;
  LErrorMessage : string ;
begin
   Result := nil;

   LResponse := TRequest.New.BaseURL(TAppConfig.API_URL)
                .Resource('/api/pagamento/')
                .Accept('application/json')
                .AddBody(TJson.ObjectToJsonString(Request))
                .Post;

   if LResponse.StatusCode in [200, 201] then begin
    Result := TJson.JsonToObject<TDTOPaymentResponse>(LResponse.Content);
   end
   else begin
     LErrorMessage := 'Erro HTTP : ' + LResponse.StatusCode.ToString;
     LJsonError    := TJSONObject.ParseJSONValue(LResponse.Content) as TJSONObject;
     try
       LErrorMessage := LJsonError.GetValue<string>('error', LErrorMessage);
     finally
       if Assigned(LJsonError) then LJsonError.Free;
     end;

     raise Exception.Create(LErrorMessage);
   end;
end;

end.
