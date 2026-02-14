unit ApiBoletos.Controllers.Boletos;

interface

uses
  Horse, System.JSON, ApiBoletos.Model.Boletos;

type

  TControllerBoletos = class
  public
    class procedure GetBoletosByClient(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

{ TControllerBoletos }

class procedure TControllerBoletos.GetBoletosByClient(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  LBoletos   : TJSONArray;
  LEmpresa : Integer;
begin
  LEmpresa      := Req.Params.Field('id').AsInteger;
  LBoletos      := TModelBoleto.BuscarBoletosPorID(LEmpresa);

  if Assigned(LBoletos) and (LBoletos.Count > 0) then begin
    // Quando passa pro Horse o TJSONArray ele da Free Sozinho
    Res.Send<TJSONArray>(LBoletos);
  end
  else begin
    if Assigned(LBoletos) then
      LBoletos.Free; // Temos que dar o Free, pois não chegou no Horse.

    Res.Status(404).Send('{"mensagem": "Não existem boletos para este cliente."}');
  end;
end;

end.
