unit controller.boletos.speed;

interface

uses
  FireDAC.Comp.Client,
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  REST.Client,
  REST.Types,
  REST.Response.Adapter,
  RESTRequest4D;

type
  TControllerBoletosSpeed = class
    private
      FBaseURL: String;
    public
      constructor Create;
      procedure BuscarBoletos(aCliente: integer; aMemTable : TFDMemTable);
  end;

implementation

{ TControllerBoletosSpeed }

procedure TControllerBoletosSpeed.BuscarBoletos(aCliente: integer; aMemTable : TFDMemTable);
var
  LResponse : IResponse;
begin

  if aMemTable.FieldCount = 0 then
    begin
      aMemTable.FieldDefs.Add('sp_documento', ftInteger);
      aMemTable.FieldDefs.Add('sp_parcela', ftInteger);
      aMemTable.FieldDefs.Add('sp_valor', ftFloat);
      aMemTable.FieldDefs.Add('sp_vencimento', ftDateTime); // Avisa que é Data!
      aMemTable.FieldDefs.Add('sp_emissao', ftDateTime);    // Avisa que é Data!
      aMemTable.FieldDefs.Add('sp_atrz', ftString, 10);
      aMemTable.FieldDefs.Add('sp_dias', ftInteger);
      aMemTable.FieldDefs.Add('sp_pix', ftFloat);

      aMemTable.CreateDataSet;
    end;

  if aMemTable.Active then
    aMemTable.EmptyDataSet;

  try
    LResponse := TRequest.New.BaseURL(FBaseURL)
                 .Resource('/api/boletos/' + aCliente.ToString)
                 .DataSetAdapter(aMemTable)
                 .Get;
  except on E:Exception do begin
       raise Exception.Create('Erro ao buscar Dados : ' + E.Message);
    end;
  end;
end;

constructor TControllerBoletosSpeed.Create;
begin
  FBaseURL := 'http://localhost:9000';
end;

end.
