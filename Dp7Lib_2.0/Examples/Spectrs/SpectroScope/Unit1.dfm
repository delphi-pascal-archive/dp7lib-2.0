object Form1: TForm1
  Left = 478
  Top = 131
  BorderStyle = bsSingle
  Caption = 'SpectroScope'
  ClientHeight = 368
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 10
    Top = 10
    Width = 327
    Height = 352
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Color'
      OnShow = TabSheet1Show
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 319
        Height = 321
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object dpColorSpectr1: TdpColorSpectr
          Left = 1
          Top = 1
          Width = 315
          Height = 315
          Cursor = -5
          OnPipettePixel = dpColorSpectr1PipettePixel
          PipetteShape = dpPipetteShape1
          Center = True
          Proportional = False
          Stretch = False
          PipettePixelX = 102
          PipettePixelY = 72
          ClipPalette = True
          ClipCursor = True
          ClipParent = False
          DefaultColor = clNone
          object dpPipetteShape1: TdpPipetteShape
            Left = 98
            Top = 69
            Width = 7
            Height = 6
            Spectr = dpColorSpectr1
            Style = ssCircle
            RoundSquare = 0
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Saturation'
      ImageIndex = 1
      OnShow = TabSheet2Show
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 318
        Height = 318
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object dpGradSpectr1: TdpGradSpectr
          Left = 1
          Top = 1
          Width = 315
          Height = 315
          Cursor = -5
          OnPipettePixel = dpGradSpectr1PipettePixel
          ColorList = <
            item
              Color = clWhite
            end
            item
              Color = 6809706
            end>
          PipetteShape = dpPipetteShape2
          Center = True
          Proportional = False
          Stretch = False
          PipettePixelX = 210
          PipettePixelY = 131
          ClipPalette = True
          ClipCursor = True
          ClipParent = False
          FillStyle = fsHorizontal
          PaletteWidth = 256
          PaletteHeight = 256
          DefaultColor = clNone
          object dpPipetteShape2: TdpPipetteShape
            Left = 207
            Top = 128
            Width = 6
            Height = 6
            Spectr = dpGradSpectr1
            Style = ssCircle
            RoundSquare = 0
          end
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Brightness'
      ImageIndex = 2
      OnShow = TabSheet3Show
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 318
        Height = 318
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object dpGradSpectr2: TdpGradSpectr
          Left = 1
          Top = 1
          Width = 315
          Height = 315
          Cursor = -5
          OnPipettePixel = dpGradSpectr2PipettePixel
          ColorList = <
            item
              Color = clWhite
            end
            item
              Color = 6809706
            end
            item
              Color = clBlack
            end>
          PipetteShape = dpPipetteShape3
          Center = True
          Proportional = False
          Stretch = False
          PipettePixelX = 121
          PipettePixelY = 151
          ClipPalette = True
          ClipCursor = True
          ClipParent = False
          FillStyle = fsHorizontal
          PaletteWidth = 256
          PaletteHeight = 256
          DefaultColor = clNone
          object dpPipetteShape3: TdpPipetteShape
            Left = 118
            Top = 148
            Width = 6
            Height = 6
            Spectr = dpGradSpectr2
            Style = ssCircle
            RoundSquare = 0
          end
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Custom'
      ImageIndex = 3
      OnHide = TabSheet4Hide
      OnShow = TabSheet4Show
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 318
        Height = 318
        Align = alClient
        BevelOuter = bvLowered
        TabOrder = 0
        object dpChoiceSpectr1: TdpChoiceSpectr
          Left = 1
          Top = 1
          Width = 315
          Height = 315
          Cursor = -5
          OnPipettePixel = dpChoiceSpectr1PipettePixel
          PipetteShape = dpPipetteShape4
          Center = True
          Proportional = True
          Stretch = False
          PipettePixelX = 259
          PipettePixelY = 180
          ClipPalette = True
          ClipCursor = True
          ClipParent = False
          DefaultColor = clNone
          object dpPipetteShape4: TdpPipetteShape
            Left = 256
            Top = 177
            Width = 6
            Height = 6
            Spectr = dpChoiceSpectr1
            Style = ssCircle
            RoundSquare = 0
          end
        end
      end
    end
  end
  object Panel5: TPanel
    Left = 350
    Top = 12
    Width = 99
    Height = 90
    BevelOuter = bvLowered
    TabOrder = 1
  end
  object Button1: TButton
    Left = 348
    Top = 108
    Width = 100
    Height = 31
    Caption = #1054#1073#1079#1086#1088
    TabOrder = 2
    Visible = False
    OnClick = Button1Click
  end
  object dpPipette1: TdpPipette
    Left = 336
    Top = 264
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Left = 280
    Top = 128
  end
end
