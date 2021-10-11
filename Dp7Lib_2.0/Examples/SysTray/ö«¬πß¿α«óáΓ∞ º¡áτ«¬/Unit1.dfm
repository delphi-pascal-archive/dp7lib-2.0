object Form1: TForm1
  Left = 416
  Top = 411
  BorderStyle = bsSingle
  Caption = #1060#1086#1082#1091#1089#1080#1088#1086#1074#1072#1090#1100' '#1079#1085#1072#1095#1086#1082
  ClientHeight = 136
  ClientWidth = 502
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 200
    Top = 56
    Width = 97
    Height = 25
    Caption = #1060#1086#1082#1091#1089#1080#1088#1086#1074#1072#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object dpTrayIcon1: TdpTrayIcon
    Enabled = True
    ShowHint = True
    Seen = 'Example'
    Left = 8
    Top = 8
  end
end
