object frm_principal: Tfrm_principal
  Left = 0
  Top = 0
  Caption = 'frm_principal'
  ClientHeight = 454
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 615
    Height = 454
    Align = alClient
    Caption = 'pnlPrincipal'
    TabOrder = 0
    object memoLog: TMemo
      Left = 1
      Top = 1
      Width = 613
      Height = 452
      Align = alClient
      PopupMenu = PopupMenu
      ReadOnly = True
      TabOrder = 0
    end
  end
  object TrayIcon: TTrayIcon
    PopupMenu = PopupMenu
    Visible = True
    OnDblClick = TrayIconDblClick
    Left = 528
    Top = 16
  end
  object PopupMenu: TPopupMenu
    Left = 528
    Top = 88
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
  end
end
