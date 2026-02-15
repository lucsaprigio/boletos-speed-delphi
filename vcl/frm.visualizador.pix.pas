unit frm.visualizador.pix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Winapi.WebView2, Winapi.ActiveX,
  Vcl.ExtCtrls, Vcl.Edge, controller.boletos.speed, Vcl.OleCtrls, SHDocVw;

type
  Tfrm_visualizador_pix = class(TForm)
    Timer: TTimer;
    WebBrowser: TWebBrowser;
    procedure TimerTimer(Sender: TObject);
  private
    FIdPagamento: Int64;
  public
      procedure AbrirPagamento(AUrl: String; AId: Int64);
  end;

var
  frm_visualizador_pix: Tfrm_visualizador_pix;

implementation

{$R *.dfm}

{ Tfrm_visualizador_pix }

procedure Tfrm_visualizador_pix.AbrirPagamento(AUrl: String; AId: Int64);
begin
  FIdPagamento := AId;
  WebBrowser.Navigate(AUrl);
  Timer.Enabled := True; // Inicia o monitoramento aqui
  Self.Show; // Exibe sem travar o form anterior
end;

procedure Tfrm_visualizador_pix.TimerTimer(Sender: TObject);
var
  LStatus : String;
begin
  Timer.Enabled := False;
  try
   LStatus := TControllerBoletosSpeed.ConsultarPagamento(FIdPagamento) ;

   if LStatus = 'approved' then begin
      ShowMessage('Pagamento confirmado');
      Self.Close;
   end
   else begin
      Timer.Enabled := True;
   end;
    except on E: Exception do begin
       raise Exception.Create('Error Message');
    end;
  end;
end;

end.
