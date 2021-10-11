unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dpSysTray, StdCtrls;

type
  TForm1 = class(TForm)
    dpTrayIcon1: TdpTrayIcon;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ComboBox1: TComboBox;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dpTrayIcon1Message(var Message: TMessage);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

type
  TOsVersionInfoEx = packed record
    old : TOsVersionInfo;
    wServicePackMajor : Word;
    wServicePackMinor : Word;
    wSuiteMask : Word;
    wProductType : Byte;
    wReserved  : Byte;
  end;

var
  BalloonMsg: Boolean;
  BalloonUserIcon: Boolean;
  BalloonNoSound: Boolean;

implementation

uses
  ShellApi;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  svi: TShellVersionInfo;
  OsInfo: TOsVersionInfoEx;
begin
  Application.Title := Caption;
  svi.cbSize := SizeOf(svi);
  if GetShellVersionInfo(svi) <> NOERROR then
  begin
    MessageBox(0, 'Не удалось узнать версию библиотеки Shell32.DLL', PChar(Caption), MB_OK);
    Application.Terminate;
  end
  else
  if svi.dwMajorVersion < 5 then
  begin
    MessageBox(0, 'Версия библиотеки не поддерживает сообщение Balloon', PChar(Caption), MB_OK);
    Application.Terminate;
  end;
  BalloonMsg := ((svi.dwMajorVersion = 5) and (svi.dwMinorVersion >= 1)) or
  (svi.dwMajorVersion >= 6);
  BalloonNoSound := svi.dwMajorVersion >= 6;
  OSInfo.old.dwOSVersionInfoSize := Sizeof(TOsVersionInfoEx);
  if Not GetVersionEx(OSInfo.old) then
    MessageBox(0, 'Не удалось узнать сервис пак операционной системы', PChar(Caption), MB_OK)
  else
    BalloonUserIcon := ((OSInfo.wServicePackMajor >= 2) and (svi.dwMajorVersion = 6)) or
     ((svi.dwMajorVersion > 6) and (svi.dwMinorVersion >= 6));
  dpTrayIcon1.Hint := Caption;
  dpTrayIcon1.Icon := Application.Icon;
  dpTrayIcon1.Show;
  if BalloonUserIcon then
    ComboBox1.Items.Add('NIIF_USER');
  if BalloonNoSound then
    CheckBox1.Enabled := true;
  Edit1.Text := Caption;
  ComboBox1.ItemIndex := 0;
end;

procedure TForm1.Button1Click(Sender: TObject);
const
  dwIcon: array [0..5] of Integer = (NIIF_NONE, NIIF_INFO, NIIF_WARNING,
  NIIF_ERROR, NIIF_QUEST, NIIF_USER);
var
  Data: TNotifyIconData2;
begin
  if Edit2.Text = '' then Exit;
  ZeroMemory(@Data, NOTIFYICONDATA_V2_SIZE);
  Data.cbSize := NOTIFYICONDATA_V2_SIZE;
  Data.hWnd := dpTrayIcon1.Handle;
  Data.uID := dpTrayIcon1.Perform(NI_PIDEL, 0, 0);
  Data.uFlags := NIF_INFO;
  StrLCopy(Data.szInfo, PChar(Edit2.Text), SizeOf(Data.szInfo) -1);
  StrLCopy(Data.szInfoTitle, PChar(Edit1.Text), SizeOf(Data.szInfoTitle) -1);
  Data.DummyUnionName.uTimeout := 1000;
  Data.dwInfoFlags := dwIcon[ComboBox1.ItemIndex];
  if CheckBox1.Checked then
    Data.dwInfoFlags := Data.dwInfoFlags or NIIF_NOSOUND;
  Shell_NotifyIcon(NIM_MODIFY, @Data);
  // Результат в этом случае может быть всегда True
end;

procedure TForm1.dpTrayIcon1Message(var Message: TMessage);
begin
  with Message do
  begin
    if (Msg = NI_NOTIFYTRAY) and BalloonMsg then
      case LParam of
        NIN_BALLOONSHOW:
           Memo1.Lines.Add('Сообщение запущено');

        NIN_BALLOONHIDE:
           Memo1.Lines.Add('Сообщение закрыто');

        NIN_BALLOONTIMEOUT:
           Memo1.Lines.Add('Сообщение закрыто по окончанию времени или была нажата кнопка закрыть');

        NIN_BALLOONUSERCLICK:
           Memo1.Lines.Add('Сообщение закрыто по нажатию мыши на него');
      end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Data: TNotifyIconData2;
begin
  ZeroMemory(@Data, NOTIFYICONDATA_V2_SIZE);
  Data.cbSize := NOTIFYICONDATA_V2_SIZE;
  Data.hWnd := dpTrayIcon1.Handle;
  Data.uID := dpTrayIcon1.Perform(NI_PIDEL, 0, 0);
  Data.uFlags := NIF_INFO;
  Shell_NotifyIcon(NIM_MODIFY, @Data);
  // Результат в этом случае может быть всегда True
end;

end.
