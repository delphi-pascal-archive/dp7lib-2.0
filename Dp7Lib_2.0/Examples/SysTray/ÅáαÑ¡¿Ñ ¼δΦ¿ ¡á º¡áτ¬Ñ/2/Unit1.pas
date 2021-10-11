unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dpSysTray, StdCtrls, ImgList;

type
  TForm1 = class(TForm)
    dpTrayIcon1: TdpTrayIcon;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure dpTrayIcon1MouseExit(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure dpTrayIcon1MouseEnter(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
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
begin
  Application.Title := Caption;
  dpTrayIcon1.Hint := Caption;
  dpTrayIcon1.MouseEnterExit := true;
  dpTrayIcon1.Show;
end;

procedure TForm1.dpTrayIcon1MouseExit(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  dpTrayIcon1.ImageIndex := 0;
end;

procedure TForm1.dpTrayIcon1MouseEnter(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  dpTrayIcon1.ImageIndex := 1;
end;

end.
