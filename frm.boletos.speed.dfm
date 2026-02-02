object frm_boletos_speed: Tfrm_boletos_speed
  Left = 0
  Top = 0
  Caption = 'Boletos Speed'
  ClientHeight = 483
  ClientWidth = 964
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 964
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 72
    ExplicitTop = 48
    ExplicitWidth = 185
    object BitBtn1: TBitBtn
      Left = 1
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Listar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 41
    Width = 964
    Height = 442
    Align = alClient
    BevelOuter = bvSpace
    TabOrder = 1
    ExplicitLeft = 327
    ExplicitTop = 264
    ExplicitWidth = 185
    ExplicitHeight = 41
    object dbGridDados: TDBGrid
      Left = 1
      Top = 1
      Width = 962
      Height = 440
      Align = alClient
      DataSource = ds_boletos
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDrawColumnCell = dbGridDadosDrawColumnCell
    end
  end
  object ds_boletos: TDataSource
    Left = 864
    Top = 97
  end
end
