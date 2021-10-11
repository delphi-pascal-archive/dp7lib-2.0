unit dpColorSpectr;

  {*******************************************************}
  {                                                       }
  {       Dp7Lib                                          }
  {                                                       }
  {       Copyright © 2008, Roenko Ivan                   }
  {                                                       }
  {       The version of the module 1.1                   }
  {                                                       }
  {*******************************************************}

interface

uses
  Windows, Classes, Graphics, dpSpectrs;

type
  TdpCustomColorSpectr = class(TdpCustomSpectr)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TdpColorSpectr = class(TdpCustomColorSpectr)
  public
    property  Palette;
  published
    property  PipetteShape;
    property  Center;
    property  Proportional;
    property  Stretch;
    property  PipetteColor;
    property  PipettePixelX;
    property  PipettePixelY;
    property  ClipPalette;
    property  ClipCursor;
    property  ClipParent;
    property  OnClipCursor;
    property  DefaultColor; 
  published
    property  Align;
    property  Anchors;
    property  AutoSize;
    property  Caption;
    property  Visible;
    property  OnClick;
    property  OnDblClick;
    property  Color;
    property  Font;
    property  ParentFont;
    property  ParentShowHint;
    property  ParentColor;
    property  PopupMenu;
    property  ShowHint;
    property  Enabled;
    property  OnContextPopup;
    property  OnMouseDown;
    property  OnMouseMove;
    property  OnMouseUp;
    property  OnResize;
  end;

implementation

{$R dpColorSpectr.res}

{ TdpCustomColorSpectr }

constructor TdpCustomColorSpectr.Create(AOwner: TComponent);
var
  B: TBitmap;
begin
  inherited;
  FCenter := true;
  B := TBitmap.Create;
  try
    B.LoadFromResourceName(hinstance, 'PL_COLORS');
    Palette.Assign(B);
  finally
    B.Free;
  end;
end;

end.
