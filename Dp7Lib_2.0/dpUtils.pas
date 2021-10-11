unit dpUtils;

  {*******************************************************}
  {                                                       }
  {       Dp7Lib                                          }
  {                                                       }
  {       Copyright © 2008-2009, Roenko Ivan              }
  {                                                       }
  {       The version of the module 1.1                   }
  {                                                       }
  {*******************************************************}

interface

uses
  Windows, Classes;

const
  CALC_RT_DEFAULT      = $00;
  CALC_RT_LEFT         = $01;
  CALC_RT_TOP          = $02;
  CALC_RT_RIGHT        = $04;
  CALC_RT_BOTTOM       = $08;
  CALC_RT_STRETCH      = $10;
  CALC_RT_PROPORTIONAL = $20;
  CALC_RT_CENTER       = $40;
  CALC_RT_ALIGN        = $80;

  procedure GetCalcRect(wDest, hDest, wSource, hSource: Integer; var Rect: TRect; Flags: Word);

  function KeysToShiftState: TShiftState;

  function MouseToShiftState: TShiftState;

implementation

function MouseToShiftState: TShiftState;
begin
  Result := [];

  if Not BOOL(GetSystemMetrics(SM_SWAPBUTTON)) then
  begin
    if GetAsyncKeyState(VK_LBUTTON) < 0 then
      Include(Result, ssLeft);
    if GetAsyncKeyState(VK_RBUTTON) < 0 then
      Include(Result, ssRight);
  end
  else
  begin
    if GetAsyncKeyState(VK_LBUTTON) < 0 then
      Include(Result, ssRight);
    if GetAsyncKeyState(VK_RBUTTON) < 0 then
      Include(Result, ssLeft);
  end;

  if GetAsyncKeyState(VK_MBUTTON) < 0 then
    Include(Result, ssMiddle);

end;

function KeysToShiftState: TShiftState;
begin
  Result := [];
  if GetAsyncKeyState(VK_SHIFT) < 0 then
    Include(Result, ssShift);
  if GetAsyncKeyState(VK_CONTROL) < 0 then
    Include(Result, ssCtrl);
  if GetAsyncKeyState(VK_MENU) < 0 then
    Include(Result, ssAlt);
end;

procedure GetCalcRect(wDest, hDest, wSource, hSource: Integer; var Rect: TRect; Flags: Word);
var
  A: Double;
begin

  if (Flags and CALC_RT_STRETCH = CALC_RT_STRETCH) or ((Flags and CALC_RT_PROPORTIONAL = CALC_RT_PROPORTIONAL)
  and ((wSource > wDest) or (hSource > hDest))) then
  begin
    if (Flags and CALC_RT_PROPORTIONAL = CALC_RT_PROPORTIONAL) and (wSource > 0) and (hSource > 0) then
    begin
      A := wSource / hSource;
      if wSource > hSource then
      begin
        wSource := wDest;
        hSource := Trunc(wDest / A);
        if hSource > hDest then
        begin
          hSource := hDest;
          wSource := Trunc(hDest * A);
        end;
      end
      else
      begin
        hSource := hDest;
        wSource := Trunc(hDest * A);
        if wSource > wDest then
        begin
          wSource := wDest;
          hSource := Trunc(wDest / A);
        end;
      end;
    end
    else
    begin
      wSource := wDest;
      hSource := hDest;
    end;
  end;

  with Rect do
  begin
    if Flags and CALC_RT_CENTER = CALC_RT_CENTER then
    begin
      if Flags and CALC_RT_RIGHT = CALC_RT_RIGHT then
      begin
        Left := wDest - wSource;
        Right := wDest;
        Top := Round((hDest - hSource) / 2);
        Bottom := Top + hSource;
      end
      else
      if Flags and CALC_RT_TOP = CALC_RT_TOP then
      begin
        Left := Round((wDest - wSource) / 2);
        Right := Left + wSource;
        Top := 0;
        Bottom := hSource;
      end
      else
      if Flags and CALC_RT_LEFT = CALC_RT_LEFT then
      begin
        Left := 0;
        Right := wSource;
        Top := Round((hDest - hSource) / 2);
        Bottom := Top + hSource;
      end
      else
      if Flags and CALC_RT_BOTTOM = CALC_RT_BOTTOM then
      begin
        Left := Round((wDest - wSource) / 2);
        Right := Left + wSource;
        Top := hDest - hSource;
        Bottom := hDest;
      end
      else
      begin
        Left := Round((wDest - wSource) / 2);
        Right := Left + wSource;
        Top := Round((hDest - hSource) / 2);
        Bottom := Top + hSource;
      end;
    end
    else
    if (Flags and CALC_RT_ALIGN = CALC_RT_ALIGN) then
    begin
      if Flags and CALC_RT_RIGHT = CALC_RT_RIGHT then
      begin
        Left := wDest - wSource;
        Right := wDest;
        Top := 0;
        Bottom := hDest;
      end
      else
      if Flags and CALC_RT_TOP = CALC_RT_TOP then
      begin
        Left := 0;
        Right := wDest;
        Top := 0;
        Bottom := hSource;
      end
      else
      if Flags and CALC_RT_LEFT = CALC_RT_LEFT then
      begin
        Left := 0;
        Right := wSource;
        Top := 0;
        Bottom := hDest;
      end
      else
      if Flags and CALC_RT_BOTTOM = CALC_RT_BOTTOM then
      begin
        Left := 0;
        Right := wDest;
        Top := hDest - hSource;
        Bottom := hDest;
      end;
    end
    else
    if Flags and CALC_RT_RIGHT = CALC_RT_RIGHT then
    begin
      Left := wDest - wSource;
      Right := wDest;
      Top := 0;
      Bottom := hSource;
      if Flags and CALC_RT_BOTTOM = CALC_RT_BOTTOM then
      begin
        Top := hDest - hSource;
        Bottom := hDest;
      end;
    end
    else
    begin
      Left := 0;
      Top :=  0;
      Right := wSource;
      Bottom := hSource;
      if Flags and CALC_RT_BOTTOM = CALC_RT_BOTTOM then
      begin
        Top := hDest - hSource;
        Bottom := hDest;
      end;
    end;
  end;
  
end;

end.
