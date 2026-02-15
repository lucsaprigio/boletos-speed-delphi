unit Boletos.Utils.Configuracao;

interface

uses
  System.SysUtils, System.IniFiles, System.IOUtils;

type
  TAppConfig = class
  private
    class var FDBPass: string;
    class var FDBUser: string;
    class var FPort: string;
    class var FDatabase: string;
    class var FServer: string;
    class var FDriverID: string;
    class var FDBUserMSSQL: string;
    class var FPortMSSQL: string;
    class var FDatabaseMSSQL: string;
    class var FServerMSSQL: string;
    class var FDriverMSSQL: string;
    class var FDBPassMSSQL: string;
    class var FMP_ACCESS_TOKEN: string;
    class var FMP_NOTIFICATION_URL: string;
    class var FAPI_URL: String;

  public
    class procedure Carregar;

    class property DriverID : string read FDriverID;
    class property Server: string read FServer;
    class property Port: string read FPort;
    class property Database: string read FDatabase;
    class property DBUser: string read FDBUser;
    class property DBPass: string read FDBPass;

    class property DriverMSSQL : string read FDriverMSSQL;
    class property ServerMSSQL: string read FServerMSSQL;
    class property PortMSSQL: string read FPortMSSQL;
    class property DatabaseMSSQL: string read FDatabaseMSSQL;
    class property DBUserMSSQL: string read FDBUserMSSQL;
    class property DBPassMSSQL: string read FDBPassMSSQL;

    class property MP_ACCESS_TOKEN : string read FMP_ACCESS_TOKEN write FMP_ACCESS_TOKEN;
    class property MP_NOTIFICATION_URL : string read FMP_NOTIFICATION_URL write FMP_NOTIFICATION_URL;

    class property API_URL: String read FAPI_URL write FAPI_URL;
  end;

implementation

{ TAppConfig }

class procedure TAppConfig.Carregar;
var
  lIni: TIniFile;
  lCaminhoIni: string;
begin
   lCaminhoIni := TPath.Combine(ExtractFilePath(ParamStr(0)), 'config.ini');

   if not FileExists(lCaminhoIni) then  begin
    // Criar o arquivo com as informações

    lIni := TIniFile.Create(lCaminhoIni);

    try
      lIni.WriteString('Banco', 'DriverID', 'FB');
      lIni.WriteString('Banco', 'Server', '127.0.0.1');
      lIni.WriteString('Banco', 'Port', '3050');
      lIni.WriteString('Banco', 'Database', '');
      lIni.WriteString('Banco', 'User', 'SYSDBA');
      lIni.WriteString('Banco', 'Password', 'masterkey');

      lIni.WriteString('BancoMSSQL', 'Server', 'localhost\SQLEXPRESS');
      lIni.WriteString('BancoMSSQL', 'Database', 'PAG_API_MERC_PAGO');
      lIni.WriteString('BancoMSSQL', 'User', 'sa');
      lIni.WriteString('BancoMSSQL', 'Password', '123456');

      lIni.WriteString('MercadoPagoServices', 'MP_ACCESS_TOKEN', '');
      lIni.WriteString('MercadoPagoServices', 'MP_NOTIFICATION_URL', '');

      lIni.WriteString('API', 'API_URL', 'http://localhost:9000');
    finally
      lIni.Free;
    end;

   end;

   lIni := TIniFile.Create(lCaminhoIni);

   try
    FDriverID            := lIni.ReadString('Banco', 'DriverID', 'FB');
    FServer              := lIni.ReadString('Banco', 'Server', '127.0.0.1');
    FPort                := lIni.ReadString('Banco', 'Port', '3050');
    FDatabase            := lIni.ReadString('Banco', 'Database', '');
    FDBUser              := lIni.ReadString('Banco', 'User', 'SYSDBA');
    FDBPass              := lIni.ReadString('Banco', 'Password', 'masterkey');

    FServerMSSQL         := lIni.ReadString('BancoMSSQL', 'Server', 'localhost\SQLEXPRESS');
    FDatabaseMSSQL       := lIni.ReadString('BancoMSSQL', 'Database', '');
    FDBUserMSSQL         := lIni.ReadString('BancoMSSQL', 'User', 'sa');
    FDBPassMSSQL         := lIni.ReadString('BancoMSSQL', 'Password', '123456');

    FMP_ACCESS_TOKEN     := lIni.ReadString('MercadoPagoServices', 'MP_ACCESS_TOKEN', '');
    FMP_NOTIFICATION_URL := lIni.ReadString('MercadoPagoServices', 'MP_NOTIFICATION_URL', '');

    API_URL              := lIni.ReadString('API', 'API_URL', 'http://localhost:9000');
   finally
    lIni.Free;
   end;
end;

end.

