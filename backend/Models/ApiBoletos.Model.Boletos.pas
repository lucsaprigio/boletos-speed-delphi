unit ApiBoletos.Model.Boletos;

interface
uses
  System.JSON, FIREDAC.Comp.Client, System.SysUtils,
  DataSet.Serialize, ApiBoletos.Infra.Connection;

type
  TModelBoleto = class
    class function BuscarBoletosPorID(aCodEmpresa: Integer): TJSONArray;

  end;

implementation

{ TModelBoleto }

class function TModelBoleto.BuscarBoletosPorID(
  aCodEmpresa: Integer): TJSONArray;
var
  lConnection : iInfraConnection;
  lQry        : TFDQuery;
begin
   // Criar Conexão
   lConnection := TInfraConnection.New;
   lQry        := TFDQuery.Create(nil);

   // Fazer a Query no banco retornando JSONArray
   try
      lQry.Connection := lConnection.Connection;
      lQry.SQL.Add('SELECT SP_DOCUMENTO, SP_PARCELA, SP_VENCIMENTO, SP_EMISSAO, SP_VALOR, SP_ATRZ,');
      lQry.SQL.Add(' SP_DIAS, SP_PIX FROM SP_RETORNO_SITE_SPEED(:cliente, :date)');

      lQry.ParamByName('cliente').AsInteger  := aCodEmpresa;
      lQry.ParamByName('date').AsDateTime    := now;

      lQry.Open;

      Result := lQry.ToJSONArray;
    finally
      lQry.Free;
   end;
end;

end.
