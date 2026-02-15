unit ApiBoletos.DTO.Payment;

interface

uses
  REST.Json.Types, System.DateUtils, System.SysUtils, Boletos.Utils.Configuracao;

type
//            payer: {
//                first_name: string;
//            }
//  TDTOPayerAddicionalInfo = record
//     private
//     [JSONName('first_name')]
//      FFirstName: string;
//     public
//
//      property FirstName: string read FFirstName write FFirstName;
//  end;

//        additional_info: {
//            payer: {
//                first_name: string;
//            }
//        }
//  TDTOAdditionalInfo = class
//     private
//       FPayer : TDTOPayerAddicionalInfo;
//     public
//       property Payer : TDTOPayerAddicionalInfo read FPayer write FPayer;
//  end;

//        payer: {
//            email: string;
//        }
   TDTOPayer = class
     private
     [JSONName('first_name')]
       FFirstName: string;
       FEmail : String;
     public
       property Email : string read FEmail write FEmail;
       property FirstName: string read FFirstName write FFirstName;
  end;

//    body: {
//        transaction_amount: number;
//        description: string;
//        payment_method_id: string;
//        notification_url?: string;
//        date_of_expiration?: string;

  TDTOPaymentBody = class
   private
    [JSONName('transaction_amount')]
    FTransactionAmount: Double;
    FDescription: String;

    [JSONName('payment_method_id')]
    FPaymentMethodId : String;
    [JSONName('notification_url')]
    FNotificationUrl : String ;
    [JSONName('date_of_expiration')]
    FDateOfExpiration : String;
    [JSONName('payer')]
    FPayer : TDTOPayer;
    [JSONName('external_reference')]
    FExternalReference: String;
   public
   constructor Create;
   destructor Destroy; override;

   procedure ValidaDados;


   property TransactionAmount : Double read FTransactionAmount write FTransactionAmount;
   property Description : string read FDescription write FDescription;
   property PaymentMethodId : string read FPaymentMethodId write FPaymentMethodId;
   property NotificationUrl : string read FNotificationUrl write FNotificationUrl;
   property DateOfExpiration : string read FDateOfExpiration write FDateOfExpiration;
   property ExternalReference: String read FExternalReference write FExternalReference;
   property Payer: TDTOPayer read FPayer write FPayer;
  end;

implementation

constructor TDTOPaymentBody.Create;
begin
   FPayer          := TDTOPayer.Create;
end;

destructor TDTOPaymentBody.destroy;
begin
   FPayer.Free;
  inherited;
end;

procedure TDTOPaymentBody.ValidaDados;
begin
   if FDateOfExpiration = '' then
     FDateOfExpiration := DateToISO8601(now + 1, False);

   if FDescription = '' then
    FDescription := 'Pagamento via PIX';

   if FPaymentMethodId = '' then
     FPaymentMethodId := 'pix';

   if FNotificationUrl = '' then
    NotificationUrl := TAppConfig.MP_NOTIFICATION_URL;

end;

end.
