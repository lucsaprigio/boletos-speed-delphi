object frm_visualizador_pix: Tfrm_visualizador_pix
  Left = 0
  Top = 0
  Caption = 'Visualizador Pix'
  ClientHeight = 635
  ClientWidth = 1110
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object WebBrowser: TWebBrowser
    Left = 0
    Top = 0
    Width = 1110
    Height = 635
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 240
    ExplicitTop = 248
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000B9720000A14100000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Timer: TTimer
    Interval = 3000
    OnTimer = TimerTimer
    Left = 1036
    Top = 40
  end
end
