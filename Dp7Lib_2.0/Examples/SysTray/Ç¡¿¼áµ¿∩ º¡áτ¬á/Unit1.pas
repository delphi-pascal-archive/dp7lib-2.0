unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dpSysTray, StdCtrls, ImgList, ExtCtrls;

type
  TForm1 = class(TForm)
    dpTrayIcon1: TdpTrayIcon;
    ImageList1: TImageList;
    Timer1: TTimer;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
  dpTrayIcon1.Show;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if dpTrayIcon1.ImageIndex < dpTrayIcon1.Images.Count - 1 then
    dpTrayIcon1.ImageIndex := dpTrayIcon1.ImageIndex + 1
  else
    dpTrayIcon1.ImageIndex := 0;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Timer1.Enabled := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Timer1.Enabled := false;
  dpTrayIcon1.ImageIndex := 0;
end;

end.
