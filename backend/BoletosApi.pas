unit BoletosApi;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.ExtCtrls,

  Horse, Horse.Jhonson;

type
  Tfrm_principal = class(TForm)
    TrayIcon: TTrayIcon;
    PopupMenu: TPopupMenu;
    memoLog: TMemo;
    Fechar1: TMenuItem;
    pnlPrincipal: TPanel;
    Timer1: TTimer;
    procedure Fechar1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
   FIniciando : Boolean;
   procedure Iniciar;
  public
    { Public declarations }
  end;

var
  frm_principal: Tfrm_principal;

implementation

{$R *.dfm}

procedure Tfrm_principal.Fechar1Click(Sender: TObject);
begin
     THorse.StopListen;
     Application.Terminate;
end;

procedure Tfrm_principal.FormCreate(Sender: TObject);
begin
    Iniciar;
end;

procedure Tfrm_principal.FormShow(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure Tfrm_principal.Iniciar;
begin
     // Criar o Horse dentro de uma Thread

     TThread.CreateAnonymousThread(procedure
     begin
        THorse.Use(Jhonson());

        THorse.Get('/spdboleto',
          procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
          begin
            Res.Send('Api Rodando...');

            TThread.Synchronize(nil, procedure
            begin
              frm_principal.memoLog.Lines.Add('Requisição recebida em ' + DateTimeToStr(Now));
            end);
          end);

          TThread.Synchronize(nil, procedure
              begin
                frm_principal.MemoLog.Lines.Add('--------------------------------');
                frm_principal.MemoLog.Lines.Add('SERVIDOR INICIADO EM: ' + DateTimeToStr(Now));
                frm_principal.MemoLog.Lines.Add('Porta: 9000');
                frm_principal.MemoLog.Lines.Add('Aguardando conexões...');
                frm_principal.MemoLog.Lines.Add('--------------------------------');
              end);

          THorse.Listen(9000);
     end).Start;
end;

procedure Tfrm_principal.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;

  Self.Hide;

  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure Tfrm_principal.TrayIconDblClick(Sender: TObject);
begin
    // Ao clicar duas vezes no ícone, mostra/esconde a janela de logs
  if Self.Visible then
    Self.Hide
  else
  begin
    Self.Show;
    Self.WindowState := wsNormal;
  end;
end;

end.
