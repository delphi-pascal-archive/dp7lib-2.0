unit dpLongFont;

  {*******************************************************}
  {                                                       }
  {       Dp7Lib                                          }
  {                                                       }
  {       Copyright © 2005-2009, Roenko Ivan              }
  {                                                       }
  {       The version of the module 2.1                   }
  {                                                       }
  {*******************************************************}

interface

uses
  Windows, SysUtils;

type
  TFaceName = string[LF_FACESIZE - 1];

  TdpLongFont = object
  private
    FLogFont: TLogFont;
    FSelected: Boolean;
    FOldFont: HFONT;
    FDC: HDC;
    function GetFaceName: TFaceName;
    procedure SetFaceName(Value: TFaceName);
    function GetItalic: Boolean;
    procedure SetItalic(Value: Boolean);
    function GetUnderline: Boolean;
    procedure SetUnderline(Value: Boolean);
    function GetStrikeOut: Boolean;
    procedure SetStrikeOut(Value: Boolean);
  public
    procedure GetFont(Font: HFont);
    function CreateFont: HFont;
    function Select(DC: HDC): Boolean;
    function UnSelect: Boolean;
    procedure Init;
    property Selected: Boolean read FSelected;
    property FaceName: TFaceName read GetFaceName write SetFaceName;
    property Escapement: Longint read FLogFont.lfEscapement write FLogFont.lfEscapement;
    property Height: Longint read FLogFont.lfHeight write FLogFont.lfHeight;
    property Width: Longint read FLogFont.lfWidth write FLogFont.lfWidth;
    property PitchAndFamily: Byte read FLogFont.lfPitchAndFamily write FLogFont.lfPitchAndFamily;
    property Orientation: Longint read FLogFont.lfOrientation write FLogFont.lfOrientation;
    property Weight: Longint read FLogFont.lfWeight write FLogFont.lfWeight;
    property Italic: Boolean read GetItalic write SetItalic;
    property Underline: Boolean read GetUnderline write SetUnderline;
    property OutPrecision: Byte read FLogFont.lfOutPrecision write FLogFont.lfOutPrecision;
    property StrikeOut: Boolean read GetStrikeOut write SetStrikeOut;
    property CharSet: Byte read FLogFont.lfCharSet write FLogFont.lfCharSet;
    property ClipPrecision: Byte read FLogFont.lfClipPrecision write FLogFont.lfClipPrecision;
    property Quality: Byte read FLogFont.lfQuality write FLogFont.lfQuality;
  end;

implementation

{ TdpLongFont }

procedure TdpLongFont.Init;
begin
  FillChar(FLogFont, SizeOf(TLogFont), 0);
  FLogFont.lfFaceName := 'MS Sans Serif';
  FLogFont.lfClipPrecision := CLIP_DEFAULT_PRECIS;
  FLogFont.lfWeight := FW_NORMAL;
  FLogFont.lfQuality := DEFAULT_QUALITY;
  FLogFont.lfOutPrecision := OUT_DEFAULT_PRECIS;
  FLogFont.lfPitchAndFamily := DEFAULT_PITCH;
end;

function TdpLongFont.UnSelect: Boolean;
begin
  Result := FSelected;
  if FSelected then
  begin
    DeleteObject(SelectObject(FDC, FOldFont));
    FSelected := false;
  end;
end;

function TdpLongFont.Select(DC: HDC): Boolean;
begin
  Result := false;
  if Not FSelected then
  begin
    FOldFont := SelectObject(DC, CreateFont);
    FSelected := true;
    Result := true;
    FDC := DC;
  end;
end;

function TdpLongFont.CreateFont: HFont;
begin
  Result := CreateFontIndirect(FLogFont);
end;

procedure TdpLongFont.GetFont(Font: HFont);
begin
  GetObject(Font, SizeOf(TLogFont), @FLogFont);
end;

function TdpLongFont.GetFaceName: TFaceName;
begin
  Result := FLogFont.lfFaceName;
end;

procedure TdpLongFont.SetFaceName(Value: TFaceName);
begin
  StrPCopy(FLogFont.lfFaceName, Value);
end;

function TdpLongFont.GetItalic: Boolean;
begin
  Result := Boolean(FLogFont.lfItalic);
end;

procedure TdpLongFont.SetItalic(Value: Boolean);
begin
  FLogFont.lfItalic := Byte(Value);
end;

function TdpLongFont.GetUnderline: Boolean;
begin
  Result := Boolean(FLogFont.lfUnderline);
end;

procedure TdpLongFont.SetUnderline(Value: Boolean);
begin
  FLogFont.lfUnderline := Byte(Value);
end;

function TdpLongFont.GetStrikeOut: Boolean;
begin
  Result := Boolean(FLogFont.lfStrikeOut);
end;

procedure TdpLongFont.SetStrikeOut(Value: Boolean);
begin
  FLogFont.lfStrikeOut := Byte(Value);
end;

end.
