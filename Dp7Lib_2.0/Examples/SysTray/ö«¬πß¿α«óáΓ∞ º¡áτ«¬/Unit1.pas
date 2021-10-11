unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellApi, dpSysTray, StdCtrls;

type
  TForm1 = class(TForm)
    dpTrayIcon1: TdpTrayIcon;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  svi: TShellVersionInfo;
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
    MessageBox(0, 'Версия библиотеки не поддерживает фокусирование значка', PChar(Caption), MB_OK);
    Application.Terminate;
  end;
  dpTrayIcon1.Hint := Caption;
  dpTrayIcon1.Icon := Application.Icon;
  dpTrayIcon1.Show;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Data: TNotifyIconData;
begin
  ZeroMemory(@Data, NOTIFYICONDATA_V1_SIZE);
  Data.cbSize := NOTIFYICONDATA_V1_SIZE;
  Data.hWnd := dpTrayIcon1.Handle;
  Data.uID := dpTrayIcon1.Perform(NI_PIDEL, 0, 0);
  Shell_NotifyIcon(NIM_SETFOCUS, @Data);
  // Результат в этом случае может быть всегда True
end;

end.
