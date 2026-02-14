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

  public
    class procedure Carregar;

    class property DriverID : string read FDriverID;
    class property Server: string read FServer;
    class property Port: string read FPort;
    class property Database: string read FDatabase;
    class property DBUser: string read FDBUser;
    class property DBPass: string read FDBPass;
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
    finally
      lIni.Free;
    end;

   end;

   lIni := TIniFile.Create(lCaminhoIni);

   try
    FDriverID          := lIni.ReadString('Banco', 'DriverID', 'FB');
    FServer            := lIni.ReadString('Banco', 'Server', '127.0.0.1');
    FPort              := lIni.ReadString('Banco', 'Port', '3050');
    FDatabase          := lIni.ReadString('Banco', 'Database', '');
    FDBUser            := lIni.ReadString('Banco', 'User', 'SYSDBA');
    FDBPass            := lIni.ReadString('Banco', 'Password', 'masterkey');
   finally
    lIni.Free;
   end;
end;

end.

