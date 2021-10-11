object Form1: TForm1
  Left = 228
  Top = 135
  Width = 431
  Height = 202
  Caption = #1055#1072#1088#1077#1085#1080#1077' '#1084#1099#1096#1080' '#1085#1072' '#1079#1085#1072#1095#1082#1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 176
    Top = 91
    Width = 189
    Height = 16
    Caption = #1052#1099#1096#1100' '#1079#1072' '#1087#1088#1077#1076#1077#1083#1072#1084#1080' '#1079#1085#1072#1095#1082#1072
  end
  object dpTrayIcon1: TdpTrayIcon
    Enabled = True
    ShowHint = True
    Seen = 'Example'
    OnMouseEnter = dpTrayIcon1MouseEnter
    OnMouseExit = dpTrayIcon1MouseExit
    Left = 8
    Top = 8
  end
end
