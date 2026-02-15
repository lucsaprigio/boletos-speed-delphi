unit ApiBoletos.Model.PagamentosMP;

interface

uses
  System.JSON, FIREDAC.Comp.Client, System.SysUtils,
  DataSet.Serialize, ApiBoletos.Infra.Connection;

type
  TPagamentorRecord = record
    Id: Int64;
    Status : String;
    TicketUrl : string;
    Duplicata : string;
  end;

  TModelPagamento = class
    class function  BuscarPagamento(aDup: string): TPagamentorRecord;
    class procedure SalvarPagamento(aDados: TPagamentorRecord);
  end;

implementation

{ TModelPagamento }

class function TModelPagamento.BuscarPagamento(aDup: string): TPagamentorRecord;
var
  lConnection : iInfraConnection;
  lQry        : TFDQuery;
begin
   Result.Id := 0;
   lConnection := TInfraConnectionSQLServer.New;
   lQry        := TFDQuery.Create(nil);

   try
     lQry.Connection := lConnection.Connection;
     lQry.SQL.Add('SELECT ID, STATUS, TICKET_URL, DUPLICATA FROM DB_PAGAMENTOS_MP ');
     lQry.SQL.Add('WHERE DUPLICATA = :pDuplicata');

     lQry.ParamByName('pDuplicata').AsString := aDup;
     lQry.Open;

     if not lQry.IsEmpty then begin
      Result.Id         := lQry.FieldByName('ID').AsLargeInt;
      Result.Status     := lQry.FieldByName('STATUS').AsString;
      Result.TicketUrl  := lQry.FieldByName('TICKET_URL').AsString;
      Result.Duplicata  := lQry.FieldByName('DUPLICATA').AsString;
     end;
   finally
     lQry.Free;
   end;
end;

class procedure TModelPagamento.SalvarPagamento(aDados: TPagamentorRecord);
var
  lConnection : iInfraConnection;
  lQry        : TFDQuery;
begin
   lConnection := TInfraConnectionSQLServer.New;
   lQry        := TFDQuery.Create(nil);

   try
     lQry.Connection := lConnection.Connection;

     lQry.SQL.Text :=
      'IF NOT EXISTS (SELECT 1 FROM DB_PAGAMENTOS_MP WHERE ID = :ID) '+
      'BEGIN '+
      ' INSERT INTO DB_PAGAMENTOS_MP (ID, STATUS, TICKET_URL, DUPLICATA, CREATED_AT) '+
      ' VALUES (:ID, :STATUS, :TICKET_URL, :DUPLICATA, GETDATE()); '+
      'END '+
      'ELSE '+
      'BEGIN '+
      '  UPDATE DB_PAGAMENTOS_MP SET STATUS = :STATUS WHERE ID = :ID ' +
      'END ';

      lQry.ParamByName('ID').AsLargeInt       := aDados.Id;
      lQry.ParamByName('STATUS').AsString     := aDados.Status;
      lQry.ParamByName('TICKET_URL').AsString := aDados.TicketUrl;
      lQry.ParamByName('DUPLICATA').AsString  := aDados.Duplicata;

      lQry.ExecSQL;
   finally
     lQry.Free;
   end;
end;

end.
