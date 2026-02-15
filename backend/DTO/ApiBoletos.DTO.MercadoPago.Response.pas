unit ApiBoletos.DTO.MercadoPago.Response;

interface

uses
  REST.Json;

type
  // Responsável por ler o retorno do Mercado Pago
  // Uso o JSONName para conseguir transformar o camelCase para a forma que vem com _
  // Se usar nas properties lá em baixo, ele entende como se fosse colocar direto na propriedade da classe, não a utilizada fora que é o de escrita
  TDTOMPTransactionData = class
  private
    [JSONName('ticket_url')]
    FTicketUrl: string;
    [JSONName('qr_code')]
    FQRCode: string;
  public
    property QRCode: string read FQRCode write FQRCode;
    property TicketUrl: string read FTicketUrl write FTicketUrl;
  end;

  TDTOMPPointOfInteraction = class
    private
    [JSONName('transaction_data')]
    FTransactionData: TDTOMPTransactionData;
    public
      constructor Create;
      destructor destroy; override;
      property TransactionData : TDTOMPTransactionData read FTransactionData write FTransactionData;
  end;

  TDTOMercadoPagoResponse  = class
    private
      [JSONName('id')]
      FId: Int64;
      [JSONName('status')]
      FStatus: string;
      [JSONName('point_of_interaction')]
      FTDTOMPPointOfInteraction: TDTOMPPointOfInteraction;
    public
      constructor Create;
      destructor destroy; override;

      property Id: Int64 read FId write FId;
      property Status: string read FStatus write FStatus;
      property PointOfInteraction : TDTOMPPointOfInteraction read FTDTOMPPointOfInteraction write FTDTOMPPointOfInteraction;
  end;

implementation

{ TDTOMercadoPagoResponse }

constructor TDTOMercadoPagoResponse.Create;
begin
    FTDTOMPPointOfInteraction := TDTOMPPointOfInteraction.Create;
end;

destructor TDTOMercadoPagoResponse.destroy;
begin
    FTDTOMPPointOfInteraction.Free;
  inherited;
end;

{ TDTOMPPointOfInteraction }

constructor TDTOMPPointOfInteraction.Create;
begin
    // Lembrar de dar o Create pois estamos usando outra classe como tipo.
    FTransactionData := TDTOMPTransactionData.Create;
end;

destructor TDTOMPPointOfInteraction.destroy;
begin
    FTransactionData.Free;
  inherited;
end;

end.
