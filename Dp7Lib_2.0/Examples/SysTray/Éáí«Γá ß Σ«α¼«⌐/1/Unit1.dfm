object Form1: TForm1
  Left = 445
  Top = 339
  Width = 448
  Height = 359
  Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1092#1086#1088#1084#1086#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dpTrayIcon1: TdpTrayIcon
    Enabled = True
    ShowHint = True
    Seen = 'Example'
    PopupMenu = PopupMenu1
    OnMouseDown = dpTrayIcon1MouseDown
    Left = 8
    Top = 8
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 8
    object N1: TMenuItem
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100
      OnClick = N4Click
    end
  end
end
