unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dpSysTray, Menus;

type
  TForm1 = class(TForm)
    dpTrayIcon1: TdpTrayIcon;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure dpTrayIcon1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_MINIMIZE then Hide else
  inherited;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(
    Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
  Application.ShowMainForm := false;
  Application.Title := '';
  dpTrayIcon1.Hint := Caption;
  dpTrayIcon1.Icon := Application.Icon;
  dpTrayIcon1.Show;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  Show;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  Hide;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  N1.Enabled := false;
  N2.Enabled := true;
  dpTrayIcon1.Restore(Handle, BoundsRect, twIcon, true);
end;

procedure TForm1.FormHide(Sender: TObject);
begin
  N1.Enabled := true;
  N2.Enabled := false;
  dpTrayIcon1.Restore(Handle, BoundsRect, twIcon, false);
end;

procedure TForm1.dpTrayIcon1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbleft then
  begin
    if (ssDouble in Shift) then
    begin
      if Visible = false then
        Show
      else
        Hide;
    end
    else
    if Visible then
      SetForegroundWindow(Handle);
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if CanClose then
    dpTrayIcon1.Hide;
end;

end.
