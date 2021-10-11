object Form1: TForm1
  Left = 371
  Top = 354
  BorderStyle = bsSingle
  Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' Balloon'
  ClientHeight = 259
  ClientWidth = 603
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 209
    Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' Balloon'
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 101
      Height = 13
      Caption = #1047#1085#1072#1095#1086#1082' '#1074' '#1079#1072#1075#1086#1083#1086#1074#1082#1077
    end
    object Label2: TLabel
      Left = 8
      Top = 72
      Width = 54
      Height = 13
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
    end
    object Label3: TLabel
      Left = 8
      Top = 120
      Width = 58
      Height = 13
      Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077
    end
    object ComboBox1: TComboBox
      Left = 24
      Top = 40
      Width = 265
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'NIIF_NONE'
      Items.Strings = (
        'NIIF_NONE'
        'NIIF_INFO'
        'NIIF_WARNING'
        'NIIF_ERROR'
        'NIIF_QUEST')
    end
    object CheckBox1: TCheckBox
      Left = 56
      Top = 176
      Width = 201
      Height = 17
      Alignment = taLeftJustify
      Caption = #1055#1086#1103#1074#1083#1077#1085#1080#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1073#1077#1079' '#1097#1077#1083#1095#1082#1072
      Enabled = False
      TabOrder = 1
    end
    object Edit1: TEdit
      Left = 24
      Top = 88
      Width = 265
      Height = 21
      MaxLength = 64
      TabOrder = 2
    end
    object Edit2: TEdit
      Left = 24
      Top = 136
      Width = 265
      Height = 21
      MaxLength = 254
      TabOrder = 3
      Text = 'Hello'
    end
  end
  object Button1: TButton
    Left = 248
    Top = 224
    Width = 81
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 160
    Top = 224
    Width = 81
    Height = 25
    Caption = #1059#1073#1088#1072#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object GroupBox2: TGroupBox
    Left = 336
    Top = 8
    Width = 257
    Height = 241
    Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
    TabOrder = 3
    object Memo1: TMemo
      Left = 8
      Top = 16
      Width = 241
      Height = 217
      TabOrder = 0
    end
  end
  object dpTrayIcon1: TdpTrayIcon
    Enabled = True
    ShowHint = True
    Seen = 'Example'
    OnMessage = dpTrayIcon1Message
    Left = 8
    Top = 224
  end
end
