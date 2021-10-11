unit dpGraph;

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
  Windows, Classes, SysUtils, Messages, Graphics;

resourcestring
  sErrorGradFillColors = 'The quantity of colours should be more or equal to two';
  // Количество цветов должно быть больше или равняться двум

type
  TFillStyle = (fsVertical, fsHorizontal);
  TColors = array of TColor;

  procedure GradFillColors(DC: HDC; Fill: TFillStyle; Rect: TRect; Colors: array of TColor);

implementation

procedure GradFillColors(DC: HDC; Fill: TFillStyle; Rect: TRect; Colors: array of TColor);
var
  RGBDiff: array[0..2] of Integer;
  RGBFrom: array[0..2] of Byte;
  RGBTriple: TRGBTriple;
  LogBrush: TLogBrush;
  Brush: HBRUSH;
  wSource: Integer;
  hSource: Integer;
  ColorBand: TRect;
  I, J: Integer;
begin
  if High(Colors) < 1 then
    raise Exception.CreateRes(@sErrorGradFillColors);

  wSource := Rect.Right - Rect.Left;
  hSource := Rect.Bottom - Rect.Top;

  with ColorBand do
  begin
    Left := Rect.Left;
    Top := Rect.Top;
    Right := wSource;
    Bottom := hSource;
  end;

  for I := Low(Colors) to High(Colors) - 1 do
  begin
  
    for J := 0 to $ff do
    begin
      if Fill = fsHorizontal then
      begin
        ColorBand.Top :=  Rect.Top + MulDiv(J, Round(hSource / High(Colors)), $100);
        ColorBand.Bottom := Rect.Top + MulDiv(J + 1, Round(hSource / High(Colors)), $100);
      end
      else
      begin
        ColorBand.Left :=  Rect.Left + MulDiv(J, Round(wSource / High(Colors)), $100);
        ColorBand.Right := Rect.Left + MulDiv(J + 1, Round(wSource / High(Colors)), $100);
      end;

      RGBFrom[0] := GetRValue(ColorToRGB(Colors[I]));
      RGBFrom[1] := GetGValue(ColorToRGB(Colors[I]));
      RGBFrom[2] := GetBValue(ColorToRGB(Colors[I]));

      RGBDiff[0] := GetRValue(ColorToRGB(Colors[I + 1])) - RGBFrom[0];
      RGBDiff[1] := GetGValue(ColorToRGB(Colors[I + 1])) - RGBFrom[1];
      RGBDiff[2] := GetBValue(ColorToRGB(Colors[I + 1])) - RGBFrom[2];

      with RGBTriple do
      begin
        rgbtRed := RGBFrom[0] + MulDiv(J, RGBDiff[0], $ff);
        rgbtGreen := RGBFrom[1] + MulDiv(J, RGBDiff[1], $ff);
        rgbtBlue := RGBFrom[2] + MulDiv(J, RGBDiff[2], $ff);
      end;

      with LogBrush, RGBTriple  do
      begin
       lbHatch := 0;
       lbStyle := BS_SOLID;
       lbColor := RGB(rgbtRed, rgbtGreen, rgbtBlue);
      end;

      Brush := CreateBrushIndirect(LogBrush);
      if Brush = 0 then RaiseLastOSError;

      if FillRect(DC, ColorBand, Brush) = 0 then
      begin
        DeleteObject(Brush);
        RaiseLastOSError;
      end
      else
        DeleteObject(Brush);
      
    end;

    if Fill = fsHorizontal then
      Rect.Top := ColorBand.Bottom
    else
      Rect.Left := ColorBand.Right;
  end;
  
end;

end.
