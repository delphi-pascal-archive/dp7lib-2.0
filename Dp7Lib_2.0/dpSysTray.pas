unit dpSysTray;

  {*******************************************************}
  {                                                       }
  {       Dp7Lib                                          }
  {                                                       }
  {       Copyright © 2005-2009, Roenko Ivan              }
  {                                                       }
  {       The version of the module 5.0                   }
  {                                                       }
  {*******************************************************}

interface

uses
  Windows, Classes, Messages, Controls, Menus, Graphics,
  ImgList, ShellApi;

const
  NIM_ADD                 = $0000;
  NIM_MODIFY              = $0001;
  NIM_DELETE              = $0002;
  NIM_SETFOCUS            = $0003;
  NIM_SETVERSION          = $0004;

  NIF_MESSAGE             = $0001;
  NIF_ICON                = $0002;
  NIF_TIP                 = $0004;
  NIF_STATE               = $0008;
  NIF_INFO                = $0010;
  NIF_GUID                = $0020;
  NIF_REALTIME            = $0040;
  NIF_SHOWTIP             = $0080;

  NIS_HIDDEN              = $0001;
  NIS_SHAREDICON          = $0002;

  NIIF_NONE               = $0000;
  NIIF_INFO               = $0001;
  NIIF_WARNING            = $0002;
  NIIF_ERROR              = $0003;
  NIIF_QUEST              = $0007;
  NIIF_USER               = $0004;
  NIIF_ICON_MASK          = $000F;
  NIIF_NOSOUND            = $0010;
  NIIF_LARGE_ICON         = $0020;
  NIIF_RESPECT_QUIET_TIME = $0080;

  NIN_SELECT              = $0400;
  NINF_KEY                = $0001;
  NIN_KEYSELECT           = $0401;
  NIN_BALLOONSHOW         = $0402;
  NIN_BALLOONHIDE         = $0403;
  NIN_BALLOONTIMEOUT      = $0404;
  NIN_BALLOONUSERCLICK    = $0405;
  //  NIN_BALLOONADVERTISEMENTEXPIRED
  NIN_POPUPOPEN           = $0406;
  NIN_POPUPCLOSE          = $0407;

  NOTIFYICONDATA_V1_SIZE  = $0058;
  NOTIFYICONDATA_V2_SIZE  = $01E8;
  NOTIFYICONDATA_V3_SIZE  = $01F8;
  NOTIFYICONDATA_V4_SIZE  = $01FC;

  NOTIFYICON_VERSION      = $0003;
  NOTIFYICON_VERSION_4    = $0004;

type
  PNotifyIconData = ^TNotifyIconData;
  TNotifyIconData = record
    cbSize: DWORD;
    hWnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..63] of AnsiChar;
  end;

  TDummyUnionName = record
  case Integer of
    0: (uTimeout: UINT);
    1: (uVersion: UINT);
  end;

  PNotifyIconData2 = ^TNotifyIconData2;
  TNotifyIconData2 = record
    cbSize: DWORD;
    hWnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array[0..127] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array[0..255] of AnsiChar;
    DummyUnionName: TDummyUnionName;
    szInfoTitle: array[0..63] of AnsiChar;
    dwInfoFlags: DWORD;
  end;

  PNotifyIconData3 = ^TNotifyIconData3;
  TNotifyIconData3 = record
    cbSize: DWORD;
    hWnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array[0..127] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array[0..255] of AnsiChar;
    DummyUnionName: TDummyUnionName;
    szInfoTitle: array[0..63] of AnsiChar;
    dwInfoFlags: DWORD;
    guidItem: TGUID;
  end;

  PNotifyIconData4 = ^TNotifyIconData4;
  TNotifyIconData4 = record
    cbSize: DWORD;
    hWnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array[0..127] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array[0..255] of AnsiChar;
    DummyUnionName: TDummyUnionName;
    szInfoTitle: array[0..63] of AnsiChar;
    dwInfoFlags: DWORD;
    guidItem: TGUID;
    hBalloonIcon: HICON;
  end;

const
  NI_NOTIFYTRAY           = $0464;
  NI_NOTIFYICON           = $0465;

  NI_MOUSEMOVE            = $0200;
  NI_LBUTTONDOWN          = $0201;
  NI_LBUTTONUP            = $0202;
  NI_LBUTTONDBLCLK        = $0203;
  NI_RBUTTONDOWN          = $0204;
  NI_RBUTTONUP            = $0205;
  NI_RBUTTONDBLCLK        = $0206;
  NI_MBUTTONDOWN          = $0207;
  NI_MBUTTONUP            = $0208;
  NI_MBUTTONDBLCLK        = $0209;

  NI_ENTERSIZEMOVE        = $0231;
  NI_EXITSIZEMOVE         = $0232;
  NI_MOUSEENTEREXIT       = $0440;
  NI_MOUSEHOVER           = $0421;

  NI_MODIFICATION         = $0442;
  NI_ENABLED              = $0426;

  NI_SETHINT              = $000C;
  NI_GETHINT              = $000D;
  NI_HINTSTRLEN           = $000E;
  NI_HINTLENGTH           = $0445;
  NI_SHOWHINT             = $041D;

  NI_MAINHANDLE           = $0444;
  NI_INFO                 = $040A;

  NI_INDEX                = $044B;
  NI_PIDEL                = $045C;

  NI_SETICON              = $041C;
  NI_GETICON              = $041B;

  NI_IMAGES               = $0432;
  NI_IMAGEINDEX           = $042C;

  NI_SHOWONCE             = $041F;
  NI_HIDE                 = $0414;
  NI_SHOW                 = $0415;
  NI_REFRESH              = $0413;

  NI_MENUPOPUP            = $0447;

type
  TTrayWin = (twIcon, twNotify, twToolBar, twButton, twClock);

  TdpCustomTrayIcon = class(TComponent)
  private
    FOnMouseDown: TMouseEvent;
    FOnMouseUp: TMouseEvent;
    FOnMouseEnter: TMouseMoveEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseExit: TMouseMoveEvent;
    FModification: Boolean;
    FEnabled: Boolean;
    FHint: PChar;
    FShowHint: Boolean;
    FImagesChange: TChangeLink;
    FImages: TCustomImageList;
    FImageIndex: Integer;
    FHandle: HWND;
    FSeen: string;
    FMouseEnterExit: Boolean;
    FMouseHover: Boolean;
    FShowOnce: Boolean;
    FOSEnter, FOSExit: TPoint;
    FPopupMenu: TPopupMenu;
    FCursorPos: TPoint;
    procedure SetMouseEnterExit(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetHint(Value: string);
    function  GetHint: string;
    procedure SetShowHint(Value: Boolean);
    procedure DoMouseEnterExit(Move: Boolean);
    function  GetIndex: Integer;
    function  SaveIcon: Boolean;
    function  SaveImageIndex: Boolean;
    procedure SetImageIndex(Value: Integer);
    procedure SetSeen(Value: string);
  protected
    FData: Pointer;
    FIcon: TIcon;
    procedure DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure DoMouseMove(Shift: TShiftState; X, Y: Integer); virtual;
    procedure DoMouseEnter(Shift: TShiftState; X, Y: Integer); virtual;
    procedure DoMouseExit(Shift: TShiftState; X, Y: Integer); virtual;
    function  MenuPopup(X, Y: Integer): Boolean; virtual;
    function  ShowIcon: Boolean; virtual;
    function  RefrIcon: Boolean; virtual;
    function  HideIcon: Boolean; virtual;
    procedure DefaultWindowProc(var Message: TMessage);
    procedure ChangeData(nCmdShow: Integer); virtual;
    procedure Loaded; override;
    function  GetData: Pointer; virtual;
    procedure CreateHandle; virtual;
    procedure FreeHandle; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure BadgeImageChange; virtual;
    procedure ImagesChange(Sender: TObject); virtual;
    procedure SetImages(Value: TCustomImageList); virtual;
    procedure SetIcon(Value: TIcon); virtual;
    procedure WndProc(var Message: TMessage); virtual;
    procedure Modified;
    property  OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property  OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property  OnMouseEnter: TMouseMoveEvent read FOnMouseEnter write FOnMouseEnter;
    property  OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property  OnMouseExit: TMouseMoveEvent read FOnMouseExit write FOnMouseExit;
    property  Images: TCustomImageList read FImages write SetImages;
    property  ImageIndex: Integer read FImageIndex write SetImageIndex stored SaveImageIndex;
    property  MouseEnterExit: Boolean read FMouseEnterExit write SetMouseEnterExit;
    property  MouseHover: Boolean read FMouseHover;
    property  PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu;
  public
    function  Restore(hWnd: HWND; BoundsRect: TRect; TrayWin: TTrayWin; nShow: Boolean): Boolean;
    function  GetScreenRect(var Rect: TRect): Boolean; virtual;
    function  GetRect(var Rect: TRect): Boolean; virtual;
    class function GetNotifyWnd: HWND; virtual;
    class function GetToolBarWnd: HWND; virtual;
    class function GetToolTipWnd: HWND; virtual;
    class function GetBalloonWnd: HWND; virtual;
    class function GetButtonWnd: HWND; virtual;
    class function GetClockWnd: HWND; virtual;
    class function GetTrayWnd: HWND; virtual;
    function  Show: Boolean;
    function  Hide: Boolean;
    constructor Create(AOwner: TComponent); override;
    function  HandleAllocated: Boolean;
    destructor Destroy; override;
    function  GetHintLen: Integer;
    procedure SetHintBuf(Buffer: PChar);
    function  GetHintBuf(Buffer: PChar; BufSize: Integer): Integer;
    function  Perform(Msg: Cardinal; wParam: WPARAM; lParam: LPARAM): LRESULT;
    function  Refresh: Boolean;
    property  Hint: string read GetHint write SetHint;
    property  ShowHint: Boolean read FShowHint write SetShowHint;
    property  ShowOnce: Boolean read FShowOnce;
    property  Icon: TIcon read FIcon write SetIcon stored SaveIcon;
    property  Seen: string read FSeen write SetSeen;
    property  Index: Integer read GetIndex;
    property  Handle: HWND read FHandle;
  published
    property  Enabled: Boolean read FEnabled write SetEnabled;
  end;

  TdpTrayIcon = class(TdpCustomTrayIcon)
  private
    FIconData: TNotifyIconData;
    FOnMessage: TWndMethod;
  protected
    procedure DoMessage(var Message: TMessage); virtual;
    procedure ChangeData(nCmdShow: Integer); override;
    function  GetData: Pointer; override;
    procedure WndProc(var Message: TMessage); override;
  public
    property  MouseEnterExit;
    property  MouseHover;
  published
    property  Hint;
    property  ShowHint;
    property  Icon;
    property  Seen;
    property  ImageIndex;
    property  Images;
    property  PopupMenu;
    property  OnMouseDown;
    property  OnMouseUp;
    property  OnMouseMove;
    property  OnMouseEnter;
    property  OnMouseExit;
    property  OnMessage: TWndMethod read FOnMessage write FOnMessage;
  end;

type
  TShellVersionInfo = record
    cbSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformID: DWORD;
  end;

  function GetShellVersionInfo(var svi: TShellVersionInfo): HRESULT; stdcall; // Result = NOERROR

implementation

uses
  dpUtils, dpTrayUtils, CommCtrl, SysUtils, Consts;

function GetShellVersionInfo; external shell32 name 'DllGetVersion';

{ TdpCustomTrayIcon }

procedure TdpCustomTrayIcon.BadgeImageChange;
begin
  FIcon.Handle := 0;
  if FImages <> nil then
    FImages.GetIcon(FImageIndex, FIcon);
  Modified;
end;

procedure TdpCustomTrayIcon.ChangeData(nCmdShow: Integer);
begin
  if nCmdShow = NI_SHOW then
  begin
    PNotifyIconData(FData)^.uID := Perform(NI_PIDEL, 0, 0);
    PNotifyIconData(FData)^.hWnd := FHandle;
    PNotifyIconData(FData)^.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    PNotifyIconData(FData)^.uCallbackMessage := NI_NOTIFYTRAY;
  end;

  if (nCmdShow = NI_SHOW) or (nCmdShow = NI_REFRESH) then
  begin
    PNotifyIconData(FData)^.hIcon := Perform(NI_GETICON, 0, 0);
    if FShowHint and (FHint <> nil) then
      StrLCopy(PNotifyIconData(FData)^.szTip, FHint, Perform(NI_HINTLENGTH, 0, 0) - 1)
    else
      PNotifyIconData(FData)^.szTip := '';
  end;
end;

constructor TdpCustomTrayIcon.Create(AOwner: TComponent);
begin
  inherited;
  FIcon := TIcon.Create;
  FEnabled := true;
  FImageIndex := -1;
  FData := GetData;
end;

var
  UtilWindowClass: TWndClass =
  (
    style: 0;
    lpfnWndProc: @ClassWindowProc;
    cbClsExtra: 0;
    cbWndExtra: SizeOf(TMethod);
    hInstance: 0;
    hIcon: 0;
    hCursor: 0;
    hbrBackground: 0;
    lpszMenuName: nil;
    lpszClassName: 'TrayIcon'
  );

procedure TdpCustomTrayIcon.CreateHandle;
var
  ClassRegistered: Boolean;
  TempClass: TWndClass;
begin
  ClassRegistered := GetClassInfo(UtilWindowClass.hInstance, UtilWindowClass.lpszClassName, TempClass);
  if not ClassRegistered or (TempClass.lpfnWndProc <> @ClassWindowProc) then
  begin
    if ClassRegistered then
      if Not Windows.UnregisterClass(UtilWindowClass.lpszClassName, UtilWindowClass.hInstance) then
        RaiseLastOSError;
    if Windows.RegisterClass(UtilWindowClass) = 0 then RaiseLastOSError;
  end;
  FHandle := CreateWindowEx(WS_EX_TOOLWINDOW, UtilWindowClass.lpszClassName, PChar(FSeen),
  WS_POPUP, 0, 0, 0, 0, 0, 0, UtilWindowClass.hInstance, nil);
  if Not HandleAllocated then RaiseLastOSError;
  ClassObjectInstance(FHandle, WndProc);
end;

procedure TdpCustomTrayIcon.DefaultWindowProc(var Message: TMessage);
begin
  with Message do
    if HandleAllocated then
      Result := DefWindowProc(FHandle, Msg, wParam, LParam)
    else
      Result := 0;
end;

destructor TdpCustomTrayIcon.Destroy;
begin
  try
    if FShowOnce then Hide;
    if FMouseEnterExit then SetMouseEnterExit(false);
    if FImages <> nil then FImagesChange.Free;
    FIcon.Free;
    if FHint <> nil then StrDispose(FHint);
    FreeHandle;
  finally
    inherited;
  end;
end;

procedure TdpCustomTrayIcon.DoMouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseDown) then FOnMouseDown(Self, Button, Shift, X, Y);
end;

procedure TdpCustomTrayIcon.DoMouseEnter(Shift: TShiftState; X,
  Y: Integer);
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self, Shift, X, Y);
end;

procedure TdpCustomTrayIcon.DoMouseEnterExit(Move: Boolean);
begin
  if Move then
  begin
    if Not GetCursorPos(FOSExit) then
      RaiseLastOSError;
    if Not FMouseHover then
    begin
      FMouseHover := true;
      Perform(NI_NOTIFYICON, Perform(NI_PIDEL, 0, 0), NI_ENTERSIZEMOVE);
    end;
  end
  else
  begin
    if FMouseHover then
    begin
      if Not GetCursorPos(FOSEnter) then
        RaiseLastOSError;
      if (FOSEnter.X < FOSExit.X) or (FOSEnter.Y < FOSExit.Y) or (FOSEnter.X > FOSExit.X)
      or (FOSEnter.Y > FOSExit.Y) then
      begin
        FMouseHover := false;
        Perform(NI_NOTIFYICON, Perform(NI_PIDEL, 0, 0), NI_EXITSIZEMOVE);
      end;
    end;
  end;
end;

procedure TdpCustomTrayIcon.DoMouseExit(Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseExit) then FOnMouseExit(Self, Shift, X, Y);
end;

procedure TdpCustomTrayIcon.DoMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseMove) then FOnMouseMove(Self, Shift, X, Y);
end;

procedure TdpCustomTrayIcon.DoMouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(FOnMouseUp) then FOnMouseUp(Self, Button, Shift, X, Y);
end;

procedure TdpCustomTrayIcon.FreeHandle;
begin
  if HandleAllocated and Not DestroyWindow(FHandle) then
    RaiseLastOSError;
  FHandle := 0;
end;

class function TdpCustomTrayIcon.GetBalloonWnd: HWND;
var
  pidTaskBar, pidWnd: DWORD;
  nWnd: HWND;
begin
  Result := 0;
  if GetWindowThreadProcessId(GetTrayWnd, @pidTaskBar) <> 0 then
  begin
    nWnd := FindWindowEx(0, 0, TOOLTIPS_CLASS, nil);
    while nWnd <> 0 do
    begin
      if GetWindowThreadProcessId(nWnd, @pidWnd) <> 0 then
        if (pidTaskBar = pidWnd) and ((GetWindowLong(nWnd, GWL_STYLE) and TTS_NOPREFIX) <> 0) then
           Break;
      nWnd := FindWindowEx(0, nWnd, TOOLTIPS_CLASS, nil);
    end;
    Result := nWnd;
  end;
end;

class function TdpCustomTrayIcon.GetButtonWnd: HWND;
begin
  Result := FindWindowEx(GetNotifyWnd, 0, 'Button', nil);
end;

class function TdpCustomTrayIcon.GetClockWnd: HWND;
begin
  Result := FindWindowEx(GetNotifyWnd, 0, 'TrayClockWClass', nil);
end;

function TdpCustomTrayIcon.GetData: Pointer;
begin
  Result := nil;
end;

function TdpCustomTrayIcon.GetHint: string;
var
  Len: Integer;
begin
  Len := GetHintLen;
  SetString(Result, PChar(nil), Len);
  if Len <> 0 then GetHintBuf(Pointer(Result), Len + 1);
end;

function TdpCustomTrayIcon.GetHintBuf(Buffer: PChar;
  BufSize: Integer): Integer;
begin
  Result := Perform(NI_GETHINT, BufSize, LongInt(Buffer));
end;

function TdpCustomTrayIcon.GetHintLen: Integer;
begin
  Result := Perform(NI_HINTSTRLEN, 0, 0);
end;

function TdpCustomTrayIcon.GetIndex: Integer;
var
  Data: TNotifyStructData;
  Count: Integer;
  Bar32: HWND;
  I: Integer;
begin
  Result := -1;
  if FShowOnce then
  begin
    Bar32 := GetToolBarWnd;
    if Bar32 = 0 then Exit;
    Count := GetNotifyIconCount(Bar32);
    if Count = 0 then Exit;
    for I := Count - 1 downto 0 do
    begin
      ZeroMemory(@Data, SizeOf(TNotifyStructData));
      if GetNotifyStructData(Bar32, I, @Data, SizeOf(TNotifyStructData)) then
        if Data.hWnd = FHandle then
        begin
          Result := I;
          Exit;
        end;
    end;
  end;
end;

class function TdpCustomTrayIcon.GetNotifyWnd: HWND;
begin
  Result := FindWindowEx(GetTrayWnd, 0, 'TrayNotifyWnd', nil);
end;

function TdpCustomTrayIcon.GetRect(var Rect: TRect): Boolean;
var
  nIndex: Integer;
  Bar32: HWND;
begin
  Result := false;
  if FShowOnce then
  begin
    Bar32 := GetToolBarWnd;
    if Bar32 = 0 then Exit;
    nIndex := GetIndex;
    if nIndex > -1 then
      Result := GetNotifyIconRect(Bar32, nIndex, Rect);
  end;
end;

function TdpCustomTrayIcon.GetScreenRect(var Rect: TRect): Boolean;
var
  nIndex: Integer;
  Bar32: HWND;
begin
  Result := false;
  if FShowOnce then
  begin
    Bar32 := GetToolBarWnd;
    if Bar32 = 0 then Exit;
    nIndex := GetIndex;
    if nIndex > -1 then
      Result := GetNotifyIconRect(Bar32, nIndex, Rect);
    if Result then
      MapWindowPoints(Bar32, HWND_DESKTOP, Rect.TopLeft, 2);
  end;
end;

class function TdpCustomTrayIcon.GetToolBarWnd: HWND;

  function Find(hWnd: HWnd; var Bar32: HWnd): BOOL; stdcall;
  var
    Buf: array [Byte] of Char;
  begin
    GetClassName(hWnd, Buf, SizeOf(Buf));
    Result := StrIComp(Buf, TOOLBARCLASSNAME) <> 0;
    if Not Result then
      Bar32 := hWnd;
  end;

begin
  Result := 0;
  EnumChildWindows(GetNotifyWnd, @Find, Longint(@Result));
end;

class function TdpCustomTrayIcon.GetToolTipWnd: HWND;
var
  pidTaskBar, pidWnd: DWORD;
  nWnd: HWND;
begin
  Result := 0;
  if GetWindowThreadProcessId(GetTrayWnd, @pidTaskBar) <> 0 then
  begin
    nWnd := FindWindowEx(0, 0, TOOLTIPS_CLASS, nil);
    while nWnd <> 0 do
    begin
      if GetWindowThreadProcessId(nWnd, @pidWnd) <> 0 then
        if (pidTaskBar = pidWnd) and ((GetWindowLong(nWnd, GWL_STYLE) and TTS_NOPREFIX) = 0) then
           Break;
      nWnd := FindWindowEx(0, nWnd, TOOLTIPS_CLASS, nil);
    end;
    Result := nWnd;
  end;
end;

class function TdpCustomTrayIcon.GetTrayWnd: HWND;
begin
  Result := FindWindow('Shell_TrayWnd', nil);
end;

function TdpCustomTrayIcon.HandleAllocated: Boolean;
begin
  Result := FHandle <> 0;
end;

function TdpCustomTrayIcon.Hide: Boolean;
begin
  Result := Boolean(Perform(NI_HIDE, 0, 0));
end;

function TdpCustomTrayIcon.HideIcon: Boolean;
begin
  Result := false;
  if Not FShowOnce then Exit;
  ChangeData(NI_HIDE);
  Result := Shell_NotifyIcon(NIM_DELETE, FData);
  FShowOnce := Not Result;  
end;

procedure TdpCustomTrayIcon.ImagesChange(Sender: TObject);
begin
  BadgeImageChange;
end;

function TdpCustomTrayIcon.SaveIcon: Boolean;
begin
  Result := FImages = nil;
end;

function TdpCustomTrayIcon.SaveImageIndex: Boolean;
begin
  Result := FImages <> nil;
end;

procedure TdpCustomTrayIcon.Loaded;
begin
  inherited;
  if Not (csDesigning in ComponentState) and Not HandleAllocated then
    CreateHandle;
end;

procedure TdpCustomTrayIcon.Modified;
begin
  if Not FModification then
    Refresh;
end;

procedure TdpCustomTrayIcon.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (AComponent = FPopupMenu) and (Operation = opRemove) then
    FPopupMenu := nil;
  if (AComponent = FImages) and (Operation = opRemove) then
    SetImages(nil);
  inherited;
end;

function TdpCustomTrayIcon.Perform(Msg: Cardinal; wParam: WPARAM;
  lParam: LPARAM): LRESULT;
var
  Message: TMessage;
begin
  Message.Msg := Msg;
  Message.wParam := wParam;
  Message.lParam := lParam;
  Message.Result := 0;
  if Self <> nil then WndProc(Message);
  Result := Message.Result;
end;

function TdpCustomTrayIcon.Refresh: Boolean;
begin
  Result := Boolean(Perform(NI_REFRESH, 0, 0));
end;

function TdpCustomTrayIcon.RefrIcon: Boolean;
begin
  Result := false;
  if Not FShowOnce then Exit;
  ChangeData(NI_REFRESH);
  Result := Shell_NotifyIcon(NIM_MODIFY, FData);
end;

function TdpCustomTrayIcon.Restore(hWnd: HWND; BoundsRect: TRect;
  TrayWin: TTrayWin; nShow: Boolean): Boolean;
var
  Info: TAnimationInfo;
  Rect: TRect;
begin
  Result := false;
  Info.cbSize := SizeOf(TAnimationInfo);
  if SystemParametersInfo(SPI_GETANIMATION, SizeOf(Info), @Info, 0)
    and (Info.iMinAnimate <> 0) then
  case TrayWin of
    twToolBar: if Not GetWindowRect(GetToolBarWnd, Rect) then Exit;
    twNotify: if Not GetWindowRect(GetNotifyWnd, Rect) then Exit;
    twButton: if Not GetWindowRect(GetButtonWnd, Rect) then Exit;
    twClock: if Not GetWindowRect(GetClockWnd, Rect) then Exit;
  else
    if Not GetScreenRect(Rect) then Exit;
  end;
  if nShow then
    Result := DrawAnimatedRects(hWnd, IDANI_CAPTION, Rect, BoundsRect)
  else
    Result := DrawAnimatedRects(hWnd, IDANI_CAPTION, BoundsRect, Rect);
end;

procedure TdpCustomTrayIcon.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
    Perform(NI_ENABLED, 1, LongInt(Value));
end;

procedure TdpCustomTrayIcon.SetHint(Value: string);
begin
  if GetHint <> Value then SetHintBuf(PChar(Value));
end;

procedure TdpCustomTrayIcon.SetHintBuf(Buffer: PChar);
begin
  Perform(NI_SETHINT, 0, LongInt(Buffer));
end;

procedure TdpCustomTrayIcon.SetIcon(Value: TIcon);
begin
  if FIcon <> Value then
  begin
    if FImages <> nil then
      raise Exception.Create('Images <> nil')
    else
    begin
      FIcon.Assign(Value);
      Modified;
    end;
  end;
end;

procedure TdpCustomTrayIcon.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
    Perform(NI_IMAGEINDEX, 1, Value);
end;

procedure TdpCustomTrayIcon.SetImages(Value: TCustomImageList);
begin
  if FImages <> Value then
  begin
    if Value <> nil then
    begin
      FImages := Value;
      FImagesChange := TChangeLink.Create;
      FImagesChange.OnChange := ImagesChange;
      FImagesChange.Sender := FImages;
      FImages.RegisterChanges(FImagesChange);
    end
    else
    begin
      FImagesChange.Free;
      FImages := Value;
    end;
    BadgeImageChange;
  end;
end;

procedure TdpCustomTrayIcon.SetMouseEnterExit(Value: Boolean);
begin
  if FMouseEnterExit <> Value then
  begin
    if Value then
    begin
      FMouseEnterExit := SetTimer(FHandle, NI_MOUSEENTEREXIT, 1, nil) <> 0;
      if Not FMouseEnterExit then
        raise EOutOfResources.Create(SNoTimers);
    end
    else
    begin
      FMouseEnterExit := Not KillTimer(FHandle, NI_MOUSEENTEREXIT);
      if FMouseEnterExit then
        RaiseLastOSError;
    end;
  end;
end;

procedure TdpCustomTrayIcon.SetSeen(Value: string);
begin
  if Not HandleAllocated then
    FSeen := Value;
end;

procedure TdpCustomTrayIcon.SetShowHint(Value: Boolean);
begin
  if FShowHint <> Value then
    Perform(NI_SHOWHINT, 1, LongInt(Value));
end;

function TdpCustomTrayIcon.Show: Boolean;
begin
  Result := Boolean(Perform(NI_SHOW, 0, 0));
end;

function TdpCustomTrayIcon.ShowIcon: Boolean;
begin
  Result := false;
  if FShowOnce or Not HandleAllocated or (FData = nil) then Exit;
  ChangeData(NI_SHOW);
  Result := Shell_NotifyIcon(NIM_ADD, FData);
  FShowOnce := Result;
end;

var
  RM_TASKBARCREATE: UINT;

procedure TdpCustomTrayIcon.WndProc(var Message: TMessage);
var
  TempText: PChar;
begin
  with Message do
  begin
    case Msg of
      NI_MAINHANDLE: if (Owner <> nil) and (Owner is TWinControl) then
                       Result := (Owner as TWinControl).Handle
                     else
                       Result := 0;

      NI_MENUPOPUP: Result := Integer(MenuPopup(wParam, LParam));

      NI_MOUSEENTEREXIT: Result := Integer(FMouseEnterExit);
      NI_MOUSEHOVER: Result := Integer(FMouseHover);
      
      NI_MODIFICATION: if wParam = 1 then
                         FModification := Boolean(LParam)
                       else
                         Result := Integer(FModification);

      NI_ENABLED: if wParam = 1 then
                    FEnabled := Boolean(LParam)
                  else
                    Result := Integer(FEnabled);

      NI_GETHINT: begin
                    if FHint <> nil then
                      TempText := FHint
                    else
                      TempText := '';
                    Result := StrLen(StrLCopy(PChar(LParam), TempText, WParam - 1));
                  end;

      NI_SETHINT: begin
                    TempText := StrNew(PChar(LParam));
                    StrDispose(FHint);
                    Result := StrLen(TempText);
                    FHint := TempText;
                    Modified;
                  end;

      NI_HINTSTRLEN: if FHint <> nil then
                       Result := StrLen(FHint)
                     else
                       Result := 0;

      NI_PIDEL: Result := Integer(Self);

      NI_SHOWHINT: if wParam = 1 then
                   begin
                     FShowHint := Boolean(LParam);
                     Modified;
                   end
                   else
                     Result := Integer(FShowHint);

      NI_GETICON: Result := FIcon.Handle;

      NI_SETICON: begin
                    FIcon.Handle := LParam;
                    Modified;
                  end;

      NI_IMAGEINDEX: if wParam = 1 then
                     begin
                       FImageIndex := LParam;
                       BadgeImageChange;
                     end
                     else
                       Result := FImageIndex;

      NI_IMAGES: if FImages <> nil then
                   Result := FImages.Handle
                 else
                   Result := 0;

      WM_TIMER: if FMouseEnterExit and (wParam = NI_MOUSEENTEREXIT) then
                  DoMouseEnterExit(false);

      NI_HINTLENGTH: if FData <> nil then
                       Result := SizeOf(PNotifyIconData(FData)^.szTip)
                     else
                       Result := 0;

      NI_REFRESH: Result := Integer(RefrIcon);

      NI_SHOW: Result := Integer(ShowIcon);

      NI_HIDE: Result := Integer(HideIcon);

      NI_NOTIFYTRAY: case LParam of
                       NI_MOUSEMOVE: if FMouseEnterExit then
                                     begin
                                       Perform(NI_NOTIFYICON, Perform(NI_PIDEL, 0, 0), NI_MOUSEMOVE);
                                       DoMouseEnterExit(true);
                                     end
                                     else
                                       Perform(NI_NOTIFYICON, Perform(NI_PIDEL, 0, 0), NI_MOUSEMOVE);

                       NI_LBUTTONDOWN, NI_RBUTTONDOWN, NI_MBUTTONDOWN,
                       NI_LBUTTONUP, NI_RBUTTONUP, NI_MBUTTONUP,
                       NI_LBUTTONDBLCLK, NI_RBUTTONDBLCLK,
                       NI_MBUTTONDBLCLK: Perform(NI_NOTIFYICON, Perform(NI_PIDEL, 0, 0), LParam);
                     end;

      NI_INFO: case LParam of
                 1: Result := 0; // <-- SUB
                 2: Result := 0; // <-- FORMAT (or)
                 // + Future
               else
                 Result := 5; // <-- VER
               end;

      NI_SHOWONCE: Result := Integer(FShowOnce);

      NI_INDEX: Result := GetIndex;

      NI_NOTIFYICON: case LParam of
                       NI_RBUTTONDOWN: if FEnabled then
                                       begin
                                         if Not GetCursorPos(FCursorPos) then
                                           RaiseLastOSError;
                                         DoMouseDown(mbRight, KeysToShiftState + [ssRight], FCursorPos.X, FCursorPos.Y);
                                       end;

                       NI_LBUTTONDOWN: if FEnabled then
                                       begin
                                         if Not GetCursorPos(FCursorPos) then
                                           RaiseLastOSError;
                                         DoMouseDown(mbLeft, KeysToShiftState + [ssLeft], FCursorPos.X, FCursorPos.Y);
                                       end;

                       NI_MBUTTONDOWN: if FEnabled then
                                       begin
                                         if Not GetCursorPos(FCursorPos) then
                                           RaiseLastOSError;
                                         DoMouseDown(mbMiddle, KeysToShiftState + [ssMiddle], FCursorPos.X, FCursorPos.Y);
                                       end;

                       NI_RBUTTONDBLCLK: if FEnabled then
                                         begin
                                           if Not GetCursorPos(FCursorPos) then
                                             RaiseLastOSError;
                                           DoMouseDown(mbRight, KeysToShiftState + [ssRight, ssDouble], FCursorPos.X, FCursorPos.Y);
                                         end;

                       NI_LBUTTONDBLCLK: if FEnabled then
                                         begin
                                           if Not GetCursorPos(FCursorPos) then
                                             RaiseLastOSError;
                                           DoMouseDown(mbLeft, KeysToShiftState + [ssLeft, ssDouble], FCursorPos.X, FCursorPos.Y);
                                         end;

                       NI_MBUTTONDBLCLK: if FEnabled then
                                         begin
                                           if Not GetCursorPos(FCursorPos) then
                                             RaiseLastOSError;
                                           DoMouseDown(mbMiddle, KeysToShiftState + [ssMiddle, ssDouble], FCursorPos.X, FCursorPos.Y);
                                         end;

                       NI_MOUSEMOVE: if FEnabled then
                                     begin
                                       if Not GetCursorPos(FCursorPos) then
                                         RaiseLastOSError;
                                       DoMouseMove(KeysToShiftState + MouseToShiftState, FCursorPos.X, FCursorPos.Y);
                                     end;

                       NI_ENTERSIZEMOVE: if FEnabled then
                                         begin
                                           if Not GetCursorPos(FCursorPos) then
                                             RaiseLastOSError;
                                           DoMouseEnter(KeysToShiftState + MouseToShiftState, FCursorPos.X, FCursorPos.Y);
                                         end;

                       NI_EXITSIZEMOVE: if FEnabled then
                                        begin
                                          if Not GetCursorPos(FCursorPos) then
                                            RaiseLastOSError;
                                          DoMouseExit(KeysToShiftState + MouseToShiftState, FCursorPos.X, FCursorPos.Y);
                                        end;

                       NI_RBUTTONUP: if FEnabled then
                                     begin
                                       if Not GetCursorPos(FCursorPos) then
                                         RaiseLastOSError;
                                       DoMouseUp(mbRight, KeysToShiftState + [ssRight], FCursorPos.X, FCursorPos.Y);
                                       Perform(NI_MENUPOPUP, FCursorPos.X, FCursorPos.Y);
                                     end;

                       NI_LBUTTONUP: if FEnabled then
                                     begin
                                       if Not GetCursorPos(FCursorPos) then
                                         RaiseLastOSError;
                                       DoMouseUp(mbLeft, KeysToShiftState + [ssLeft], FCursorPos.X, FCursorPos.Y);
                                     end;

                       NI_MBUTTONUP: if FEnabled then
                                     begin
                                       if Not GetCursorPos(FCursorPos) then
                                         RaiseLastOSError;
                                       DoMouseUp(mbMiddle, KeysToShiftState + [ssMiddle], FCursorPos.X, FCursorPos.Y);
                                     end;
                     end;
    else
      if (RM_TASKBARCREATE <> 0) and (Msg = RM_TASKBARCREATE) then
      begin
        if FShowOnce then
        begin
          FShowOnce := false;
          ShowIcon;
        end;
      end
      else
        DefaultWindowProc(Message);
    end;
  end;
end;

function TdpCustomTrayIcon.MenuPopup(X, Y: Integer): Boolean;
begin
  Result := false;
  if (FPopupMenu <> nil) and FPopupMenu.AutoPopup then
  begin
    if HandleAllocated then
                      SetForegroundWindow(FHandle);
    FPopupMenu.PopupComponent := Self;
    FPopupMenu.Popup(X, Y);

    Result := true;
  end;
end;

{ TdpTrayIcon }

procedure TdpTrayIcon.ChangeData(nCmdShow: Integer);
begin
  inherited;
  if nCmdShow = NI_SHOW then
    PNotifyIconData(FData)^.cbSize := NOTIFYICONDATA_V1_SIZE;
end;

procedure TdpTrayIcon.DoMessage(var Message: TMessage);
begin
  if Assigned(FOnMessage) then FOnMessage(Message);
end;

function TdpTrayIcon.GetData: Pointer;
begin
  Result := @FIconData;
end;

procedure TdpTrayIcon.WndProc(var Message: TMessage);
begin
  inherited;
  DoMessage(Message);
end;

initialization
  UtilWindowClass.hInstance := hInstance;
  RM_TASKBARCREATE := RegisterWindowMessage('TaskbarCreated');

end.
