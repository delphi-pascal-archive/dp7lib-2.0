unit dpSpectrs;

  {*******************************************************}
  {                                                       }
  {       Dp7Lib                                          }
  {                                                       }
  {       Copyright © 2008-2009, Roenko Ivan              }
  {                                                       }
  {       The version of the module 1.2                   }
  {                                                       }
  {*******************************************************}

interface

uses
  Windows, Classes, SysUtils, Messages, Graphics, Controls, dpGraph;

type
  TShapeStyle = (ssSquare, ssRoundSquare, ssCircle, ssPaint);

  TShapePaintEvent = procedure (Sender: TObject; Canvas: TCanvas; Rect: TRect) of object;

  TdpCustomSpectr = class;

  TdpCustomPipetteShape = class(TGraphicControl)
  private
    FOnPaint: TShapePaintEvent;
    FStyle: TShapeStyle;
    FRoundSquare: Integer;
    FSpectr: TdpCustomSpectr;
    function GetPipetteColor: TColor;
    procedure SetPipetteColor(Value: TColor);
    procedure SetRoundSquare(Value: Integer);
    procedure SetSpectr(Value: TdpCustomSpectr);
    procedure SetStyle(Value: TShapeStyle);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoPaint(Canvas: TCanvas; Rect: TRect); virtual;
    procedure Paint; override;
    property  OnPaint: TShapePaintEvent read FOnPaint write FOnPaint;
    property  Style: TShapeStyle read FStyle write SetStyle;
    property  RoundSquare: Integer read FRoundSquare write SetRoundSquare;
    property  Spectr: TdpCustomSpectr read FSpectr write SetSpectr;
    property  PipetteColor: TColor read GetPipetteColor write SetPipetteColor stored false;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure SetShapePixel(X, Y: Integer);
  end;

  TdpPipetteShape = class(TdpCustomPipetteShape)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property  PipetteColor;
    property  Spectr;
    property  Style;
    property  RoundSquare;
    property  OnPaint;
    property  Visible;
    property  ParentShowHint;
    property  ShowHint;
    property  OnResize;
  end;

  TClipCursorEvent = procedure (Sender: TObject; var Rect: TRect) of object;

  TdpCustomSpectr = class(TCustomControl)
  private
    FOnPipettePixel: TNotifyEvent;
    FPalette: TPicture;
    FOnClipCursor: TClipCursorEvent;
    FPipetteScan, FClipPipette, FClipCursor,
    FClipPalette, FClipParent,
    FPipetteChange: Boolean;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMFontChange(var Message: TMessage); message CM_FONTCHANGE;
    function GetPipettePixelX: Integer;
    function GetPipettePixelY: Integer;
    procedure SetPipettePixelX(Value: Integer);
    procedure SetPipettePixelY(Value: Integer);
    procedure SetPipetteColor(Value: TColor);
    procedure SetCenter(Value: Boolean);
    procedure SetDefaultColor(Value: TColor);
    procedure SetPipetteShape(Value: TdpCustomPipetteShape);
    procedure SetProportional(Value: Boolean);
    procedure SetStretch(Value: Boolean);
  protected
    FPipetteShape: TdpCustomPipetteShape;
    FCustomPalette: TBitmap;
    FPipettePixel: TPoint;
    FCenter: Boolean;
    FProportional: Boolean;
    FStretch: Boolean;
    FDefaultColor: TColor;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure UpDateCustomPalette; virtual;
    procedure Loaded; override;
    function  IsPalette: Boolean;
    procedure SetPipettePixel(Value: TPoint); virtual;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DoClipCursor(var Rect: TRect); virtual;
    procedure NewPipetteShapePoint(X, Y: Integer); virtual;
    function GetPipetteColor: TColor; virtual;
    procedure DoPipettePixel; virtual;
    procedure SetPalette(Value: TPicture); virtual;
    property  PipetteShape: TdpCustomPipetteShape read FPipetteShape write SetPipetteShape;
    property  Palette: TPicture read FPalette write SetPalette;
    property  Center: Boolean read FCenter write SetCenter;
    property  Proportional: Boolean read FProportional write SetProportional;
    property  Stretch: Boolean read FStretch write SetStretch;
    property  PipettePixelX: Integer read GetPipettePixelX write SetPipettePixelX;
    property  PipettePixelY: Integer read GetPipettePixelY write SetPipettePixelY;
    property  ClipPalette: Boolean read FClipPalette write FClipPalette;
    property  ClipCursor: Boolean read FClipCursor write FClipCursor;
    property  ClipParent: Boolean read FClipParent write FClipParent;
    property  OnClipCursor: TClipCursorEvent read FOnClipCursor write FOnClipCursor;
    property  DefaultColor: TColor read FDefaultColor write SetDefaultColor;
    property  PipetteChange: Boolean read FPipetteChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpDatePalette; virtual;
    function GetPaletteRect: TRect; virtual;
    property  PipettePixel: TPoint read FPipettePixel write SetPipettePixel;
    property  PipetteColor: TColor read GetPipetteColor write SetPipetteColor stored false;
    property  PipetteScan: Boolean read FPipetteScan;
  published
    property  OnPipettePixel: TNotifyEvent read FOnPipettePixel write FOnPipettePixel;
  end;

  TdpChoiceSpectr = class(TdpCustomSpectr)
  published
    property  PipetteShape;
    property  Palette;
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

  TdpColorItem = class(TCollectionItem)
  private
    FColor: TColor;
    procedure SetColor(Value: TColor);
  published
    property Color: TColor read FColor write SetColor;
  end;

  TdpCustomGradSpectr = class;

  TdpColorList = class(TCollection)
  private
    FOwner: TdpCustomGradSpectr;
    function GetItem(Index: Integer): TdpColorItem;
    procedure SetItem(Index: Integer; Value: TdpColorItem);
  protected
    procedure Update(Item: TCollectionItem); override;
    function GetOwner: TPersistent; override;
  public
    constructor Create(AOwner: TdpCustomGradSpectr);
    function Add: TdpColorItem;
    property Items[Index: Integer]: TdpColorItem read GetItem write SetItem; default;
  end;

  TdpCustomGradSpectr = class(TdpCustomSpectr)
  private
    FColorList: TdpColorList;
    procedure SetColorList(Value: TdpColorList);
    procedure SetFillStyle(Value: TFillStyle);
    procedure SetPaletteHeight(Value: Integer);
    procedure SetPaletteWidth(Value: Integer);
  protected
    FFillStyle: TFillStyle;
    FPaletteHeight: Integer;
    FPaletteWidth: Integer;
    property  PaletteHeight: Integer read FPaletteHeight write SetPaletteHeight;
    property  PaletteWidth: Integer read FPaletteWidth write SetPaletteWidth;
    property  FillStyle: TFillStyle read FFillStyle write SetFillStyle;
  public
    procedure UpDatePalette; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property  ColorList: TdpColorList read FColorList write SetColorList;
  end;

  TdpGradSpectr = class(TdpCustomGradSpectr)
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
    property  FillStyle;
    property  PaletteWidth;
    property  PaletteHeight;
    property  DefaultColor; 
  published
    property  Align;
    property  Anchors;
    property  AutoSize;
    property  Caption;
    property  Font;
    property  ParentFont;
    property  Visible;
    property  OnClick;
    property  OnDblClick;
    property  Color;
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

uses
  dpUtils;

{ TdpCustomPipetteShape }

constructor TdpCustomPipetteShape.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csReplicatable];
  FStyle := ssCircle;
end;

procedure TdpCustomPipetteShape.DoPaint(Canvas: TCanvas; Rect: TRect);
begin
  if Assigned(FOnPaint) then FOnPaint(Self, Canvas, Rect);
end;

function TdpCustomPipetteShape.GetPipetteColor: TColor;
begin
  if FSpectr <> nil then
    Result := FSpectr.PipetteColor
  else
    Result := clNone;
end;

procedure TdpCustomPipetteShape.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (AComponent = FSpectr) and (Operation = opRemove) then
    FSpectr := nil;
  inherited;
end;

procedure TdpCustomPipetteShape.Paint;
var
  Rect: TRect;
begin
  Rect := GetClientRect;
  Canvas.Brush.Style := bsClear;
  Canvas.Pen.Style := psSolid;
  Canvas.Pen.Mode := pmNot;
  case FStyle of
    ssSquare: Canvas.Rectangle(Rect);
    ssRoundSquare: Canvas.RoundRect(Rect.Left, Rect.Top, Rect.Right, Rect.Bottom, FRoundSquare, FRoundSquare);
    ssCircle: Canvas.Ellipse(Rect);
    ssPaint: DoPaint(Canvas, Rect);
  end;
end;

procedure TdpCustomPipetteShape.SetBounds(ALeft, ATop, AWidth,
  AHeight: Integer);
begin
  inherited;
  if FSpectr <> nil then
    FSpectr.NewPipetteShapePoint(Left + Round(Width / 2), Top + Round(Height / 2));
end;

procedure TdpCustomPipetteShape.SetPipetteColor(Value: TColor);
begin

end;

procedure TdpCustomPipetteShape.SetRoundSquare(Value: Integer);
begin
  if FRoundSquare <> Value then
  begin
    FRoundSquare := Value;
    Invalidate;
  end;
end;

procedure TdpCustomPipetteShape.SetShapePixel(X, Y: Integer);
begin
  SetBounds(X - Round(Width / 2), Y - Round(Height / 2), Width, Height);
end;

procedure TdpCustomPipetteShape.SetSpectr(Value: TdpCustomSpectr);
begin
  if FSpectr <> Value then
  begin
    if (Value = nil) and (FSpectr <> nil) then
      FSpectr.FPipetteShape := nil
    else
    if (FSpectr = nil) and (Value <> nil) then
      Value.FPipetteShape := Self;
    FSpectr := Value;
    if FSpectr <> nil then
      FSpectr.NewPipetteShapePoint(Left + Round(Width / 2),
      Top + Round(Height / 2));
  end;
end;

procedure TdpCustomPipetteShape.SetStyle(Value: TShapeStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

{ TdpPipetteShape }

constructor TdpPipetteShape.Create(AOwner: TComponent);
begin
  inherited;
  Height := 17;
  Width := 17;
end;

{ TdpCustomSpectr }

function TdpCustomSpectr.CanAutoSize(var NewWidth,
  NewHeight: Integer): Boolean;
var
  Rect: TRect;
begin
  Result := true;
  if not (csDesigning in ComponentState) or IsPalette then
  begin
    Rect := GetPaletteRect;
    if Align in [alNone, alLeft, alRight] then
      NewWidth := Rect.Right - Rect.Left;
    if Align in [alNone, alTop, alBottom] then
      NewHeight := Rect.Bottom - Rect.Top;
  end;
end;

procedure TdpCustomSpectr.CMColorChanged(var Message: TMessage);
begin
  invalidate;
end;

procedure TdpCustomSpectr.CMFontChange(var Message: TMessage);
begin
  invalidate;
end;

procedure TdpCustomSpectr.CMTextChanged(var Message: TMessage);
begin
  invalidate;
end;

constructor TdpCustomSpectr.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable];
  FCustomPalette := TBitmap.Create;
  FPalette := TPicture.Create;
  Cursor := crHandPoint;
  FPipettePixel := Point(2, 2);
  FDefaultColor := clNone;
  DoubleBuffered := true;
end;

destructor TdpCustomSpectr.Destroy;
begin
  FCustomPalette.Free;
  FPalette.Free;
  inherited;
end;

procedure TdpCustomSpectr.DoClipCursor(var Rect: TRect);
begin
  if Assigned(FOnClipCursor) then FOnClipCursor(Self, Rect);
end;

procedure TdpCustomSpectr.DoPipettePixel;
begin
  if Assigned(FOnPipettePixel) then FOnPipettePixel(Self);
end;

function TdpCustomSpectr.GetPaletteRect: TRect;
var
  Flags: Word;
begin
  Flags := CALC_RT_DEFAULT;
  if FStretch then
    Flags := Flags or CALC_RT_STRETCH;
  if FCenter then
    Flags := Flags or CALC_RT_CENTER;
  if FProportional then
    Flags := Flags or CALC_RT_PROPORTIONAL;
  GetCalcRect(Width, Height, FPalette.Width, FPalette.Height, Result, Flags);
end;

function TdpCustomSpectr.GetPipetteColor: TColor;
var
  Rect: TRect;
begin
  Result := FDefaultColor;
  if IsPalette then
  begin
    Rect := GetPaletteRect;
    if (FPipettePixel.X >= Rect.Left) and (FPipettePixel.Y >= Rect.Top)
    and (FPipettePixel.X < Rect.Right) and (FPipettePixel.Y < Rect.Bottom) then  // 1 Pixel  
    Result := FCustomPalette.Canvas.Pixels[FPipettePixel.X - Rect.Left, FPipettePixel.Y - Rect.Top];
  end;
end;

function TdpCustomSpectr.GetPipettePixelX: Integer;
begin
  Result := FPipettePixel.X;
end;

function TdpCustomSpectr.GetPipettePixelY: Integer;
begin
  Result := FPipettePixel.Y;
end;

function TdpCustomSpectr.IsPalette: Boolean;
begin
  Result := (FPalette.Width > 0) and (FPalette.Height > 0);
end;

procedure TdpCustomSpectr.Loaded;
begin
  inherited;
  FPipetteChange := true;
  if IsPalette then
    UpDateCustomPalette;
  DoPipettePixel;
end;

procedure TdpCustomSpectr.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  R, R2: TRect;
begin
  inherited;
  if Button = mbLeft then
  begin
    FPipetteScan := true;
    SetPipettePixel(Point(X, Y));
    if FClipCursor then
    begin
      if FClipParent and Not FClipPalette then
      begin
        if Not GetWindowRect(Parent.Handle, R) then
          RaiseLastOSError;
      end
      else
      if Not GetWindowRect(Handle, R) then
        RaiseLastOSError;
      if IsPalette and FClipPalette then
      begin
        R2 := GetPaletteRect;
        R := Rect(R.Left + R2.Left, R.Top + R2.Top,
        R.Left + R2.Right, R.Top + R2.Bottom);
      end;
      DoClipCursor(R);
      FClipPipette := Windows.ClipCursor(@R);
      if Not FClipPipette then
        RaiseLastOSError;
   end;
  end;
end;

procedure TdpCustomSpectr.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FPipetteScan then
    SetPipettePixel(Point(X, Y));
end;

procedure TdpCustomSpectr.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  FPipetteScan := false;
  if FClipPipette then
  begin
    FClipPipette := false;
    if Not Windows.ClipCursor(nil) then
      RaiseLastOSError;
  end;
end;

procedure TdpCustomSpectr.NewPipetteShapePoint(X, Y: Integer);
begin
  if (FPipettePixel.X <> X) or (FPipettePixel.Y <> Y) then
  begin
    FPipettePixel := Point(X, Y);
    if FPipetteChange then DoPipettePixel;
  end;
end;

procedure TdpCustomSpectr.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (AComponent = FPipetteShape) and (Operation = opRemove) then
    FPipetteShape := nil;
end;

procedure TdpCustomSpectr.Paint;
var
  FontHeight: Integer;
  R: TRect;
begin
  Canvas.Brush.Color := Color;
  R := GetClientRect;
  Canvas.FillRect(R);
  if IsPalette then
    Canvas.StretchDraw(GetPaletteRect, FPalette.Graphic);
  Canvas.Brush.Style := bsClear;
  Canvas.Font := Font;
  FontHeight := Canvas.TextHeight('W');
  with R do
  begin
    Top := ((Bottom + Top) - FontHeight) div 2;
    Bottom := Top + FontHeight;
  end;
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_CENTER);
end;

procedure TdpCustomSpectr.SetCenter(Value: Boolean);
begin
  if FCenter <> Value then
  begin
    FCenter := Value;
    if IsPalette then
      UpDateCustomPalette;
    if FPipetteChange then DoPipettePixel;
    Invalidate;
  end;
end;

procedure TdpCustomSpectr.SetDefaultColor(Value: TColor);
begin
  if FDefaultColor <> Value then
  begin
    FDefaultColor := Value;
    if IsPalette then
      UpDateCustomPalette;
    if FPipetteChange then DoPipettePixel;
    Invalidate;
  end;
end;

procedure TdpCustomSpectr.SetPalette(Value: TPicture);
begin
  if FPalette <> Value then
  begin
    FPalette.Assign(Value);
    UpDateCustomPalette;
    if FPipetteChange then DoPipettePixel;
    Invalidate;
  end;
end;

procedure TdpCustomSpectr.SetPipetteColor(Value: TColor);
begin
end;

procedure TdpCustomSpectr.SetPipettePixel(Value: TPoint);
begin
  if (FPipettePixel.X <> Value.X) or (FPipettePixel.Y <> Value.Y) then
  begin
    FPipettePixel := Value;
    if FPipetteShape <> nil then
      FPipetteShape.SetShapePixel(FPipettePixel.X, FPipettePixel.Y);
    if FPipetteChange then DoPipettePixel;
  end;
end;

procedure TdpCustomSpectr.SetPipettePixelX(Value: Integer);
begin
  SetPipettePixel(Point(Value, FPipettePixel.Y));
end;

procedure TdpCustomSpectr.SetPipettePixelY(Value: Integer);
begin
  SetPipettePixel(Point(FPipettePixel.X, Value));
end;

procedure TdpCustomSpectr.SetPipetteShape(Value: TdpCustomPipetteShape);
begin
  if FPipetteShape <> Value then
  begin
    if (Value = nil) and (FPipetteShape <> nil) then
      FPipetteShape.FSpectr := nil
    else
    if (FPipetteShape = nil) and (Value <> nil) then
      Value.FSpectr := Self;
    FPipetteShape := Value;
    if FPipetteShape <> nil then
      FPipetteShape.SetShapePixel(FPipettePixel.X, FPipettePixel.Y);
  end;
end;

procedure TdpCustomSpectr.SetProportional(Value: Boolean);
begin
  if FProportional <> Value then
  begin
    FProportional := Value;
    if IsPalette then
      UpDateCustomPalette;
    if FPipetteChange then DoPipettePixel;
    Invalidate;
  end;
end;

procedure TdpCustomSpectr.SetStretch(Value: Boolean);
begin
  if FStretch <> Value then
  begin
    FStretch := Value;
    if IsPalette then
      UpDateCustomPalette;
    if FPipetteChange then DoPipettePixel;
    Invalidate;
  end;
end;

procedure TdpCustomSpectr.UpDateCustomPalette;
var
  R: TRect;
begin
  if IsPalette then
  begin
    R := GetPaletteRect;
    FCustomPalette.Height := R.Bottom - R.Top;
    FCustomPalette.Width := R.Right - R.Left;
    FCustomPalette.Canvas.StretchDraw(Rect(0, 0, FCustomPalette.Width,
    FCustomPalette.Height), FPalette.Graphic);
  end
  else
  begin
    FCustomPalette.Width := 0;
    FCustomPalette.Height := 0;
  end;
end;

procedure TdpCustomSpectr.UpDatePalette;
begin
  UpDateCustomPalette;
  if FPipetteChange then DoPipettePixel;
  invalidate;
end;

procedure TdpCustomSpectr.WMSize(var Message: TWMSize);
begin
  inherited;
  if IsPalette then
    UpDateCustomPalette;
  if FPipetteChange then DoPipettePixel;
end;

{ TdpColorItem }

procedure TdpColorItem.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Changed(false);
  end;
end;

{ TdpColorList }

function TdpColorList.Add: TdpColorItem;
begin
  Result := TdpColorItem(inherited Add);
end;

constructor TdpColorList.Create(AOwner: TdpCustomGradSpectr);
begin
  inherited Create(TdpColorItem);
  FOwner := AOwner;
end;

function TdpColorList.GetItem(Index: Integer): TdpColorItem;
begin
  Result := TdpColorItem(inherited GetItem(Index));
end;

function TdpColorList.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TdpColorList.SetItem(Index: Integer; Value: TdpColorItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TdpColorList.Update(Item: TCollectionItem);
begin
  inherited;
  FOwner.UpDatePalette;
end;

{ TdpCustomGradSpectr }

constructor TdpCustomGradSpectr.Create(AOwner: TComponent);
begin
  inherited;
  FColorList := TdpColorList.Create(Self);
  FFillStyle := fsHorizontal;
  FPaletteWidth := 256;
  FPaletteHeight := 256;
  FCenter := true;
end;

destructor TdpCustomGradSpectr.Destroy;
begin
  FColorList.Free;
  inherited;
end;

procedure TdpCustomGradSpectr.SetColorList(Value: TdpColorList);
begin
  FColorList.Assign(Value);
end;

procedure TdpCustomGradSpectr.SetFillStyle(Value: TFillStyle);
begin
  if FFillStyle <> Value then
  begin
    FFillStyle := Value;
    if (FPaletteWidth > 0) and (FPaletteHeight > 0) then
      UpDatePalette;
  end;
end;

procedure TdpCustomGradSpectr.SetPaletteHeight(Value: Integer);
begin
  if FPaletteHeight <> Value then
  begin
    FPaletteHeight := Value;
    UpDatePalette;
  end;
end;

procedure TdpCustomGradSpectr.SetPaletteWidth(Value: Integer);
begin
  if FPaletteWidth <> Value then
  begin
    FPaletteWidth := Value;
    UpDatePalette;
  end;
end;

procedure TdpCustomGradSpectr.UpDatePalette;
var
  Colors: TColors;
  B: TBitmap;
  I: Integer;
begin
  B := TBitmap.Create;
  if (FPaletteWidth > 0) and (FPaletteHeight > 0) and (FColorList.Count > 1) then
  begin
    B.Height := FPaletteHeight;
    B.Width := FPaletteWidth;
    SetLength(Colors, FColorList.Count);
    for I := Low(Colors) to High(Colors) do
      Colors[I] := FColorList.Items[I].Color;
    GradFillColors(B.Canvas.Handle, FFillStyle, Rect(0, 0, FPaletteWidth, FPaletteHeight), Colors);
  end;
  FPalette.Assign(B);
  B.Free;
  inherited;
end;

end.
