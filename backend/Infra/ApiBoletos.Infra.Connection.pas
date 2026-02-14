unit ApiBoletos.Infra.Connection;

interface
uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, System.SysUtils, FireDAC.DApt,
  Boletos.Utils.Configuracao;

type
  iInfraConnection = interface
  ['{CA7614AB-A94D-4DDC-B9AB-8E838B635646}']

    function Connection: TFDConnection;
  end;

  TInfraConnection = class(TInterfacedObject, iInfraConnection)
    private
      FConnection : TFDConnection;
    public
     constructor Create;
     destructor Destroy; override;
     class function New : iInfraConnection;

     function Connection: TFDConnection;
  end;

implementation

{ TInfraConnection }

constructor TInfraConnection.Create;
begin
    FConnection := TFDConnection.Create(nil);

    with FConnection do begin
      Connected := False;
      Params.Clear;
      Params.DriverID := TAppConfig.DriverID;

      Params.Values['Protocol']  := 'TCPIP';
      Params.Values['Port']      := TAppConfig.Port;
      Params.Values['Server']    := TAppConfig.Server;

      Params.Database            := TAppConfig.Database;
      Params.UserName            := TAppConfig.DBUser;
      Params.Password            := TAppConfig.DBPass;

       LoginPrompt := False;
    end;
    FConnection.Connected := True;
end;

destructor TInfraConnection.Destroy;
begin
    FConnection.Free;
  inherited;
end;

class function TInfraConnection.New: iInfraConnection;
begin
   Result := Self.Create;
end;

function TInfraConnection.Connection: TFDConnection;
begin
   Result := FConnection;
end;

end.
