object frm_principal: Tfrm_principal
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'frm_principal'
  ClientHeight = 464
  ClientWidth = 625
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Visible = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 625
    Height = 464
    Align = alClient
    Caption = 'pnlPrincipal'
    TabOrder = 0
    object memoLog: TMemo
      Left = 1
      Top = 1
      Width = 623
      Height = 462
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
    object Minimizar1: TMenuItem
      Caption = 'Minimizar'
      OnClick = Minimizar1Click
    end
    object Fechar1: TMenuItem
      Caption = 'Fechar'
      OnClick = Fechar1Click
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 528
    Top = 144
  end
end
