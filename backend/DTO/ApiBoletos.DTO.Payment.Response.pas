unit ApiBoletos.DTO.Payment.Response;

interface

uses
  REST.Json;

type
  // Classe responsável pelo retorno de pagamento para o Front-End
  TDTOPaymentResponse = class
    private
    [JSONName('id_pagamento')]
    FIdPagamento: Int64;
    [JSONName('status')]
    FStatus: string;
    [JSONName('ticket_url')]
    FTicketUrl: string;
    [JSONName('qr_code')]
    FQRCode: string;
    [JSONName('external_reference')]
    FExternalReference: String;

    public
     property IdPagamento: Int64 read FIdPagamento write FIdPagamento;
     property Status: string read FStatus write FStatus;
     property QRCode: string read FQRCode write FQRCode;
     property TicketUrl: string read FTicketUrl write FTicketUrl;
     property ExternalReference: String read FExternalReference write FExternalReference;
  end;

  TDTOGetPaymentResponse = class
  private
    [JSONName('id')]
    FId: Int64;
    [JSONName('status')]
    FStatus: String;
    [JSONName('description')]
    FDescription: String;
  published
     property Id: Int64 read FId write FId;
     property Status: String read FStatus write FStatus;
     property Description: String read FDescription write FDescription;
  end;
implementation

end.
