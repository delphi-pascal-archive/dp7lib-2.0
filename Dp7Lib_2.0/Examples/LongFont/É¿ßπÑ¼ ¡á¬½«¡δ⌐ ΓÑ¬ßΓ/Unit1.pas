unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dpLongFont, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;  
  LongFont: TdpLongFont;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  LongFont.GetFont(Font.Handle);
  LongFont.FaceName := 'Arial';
  LongFont.Escapement := 3600;
  LongFont.Height := 72;
  DoubleBuffered := true;
  Application.Title := Caption;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  RePaint;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  if LongFont.Escapement < 0  then
    LongFont.Escapement := LongFont.Escapement - 100
  else
    LongFont.Escapement := -3500;

  SetTextColor(Canvas.Handle, clGreen);
  SetBkMode(Canvas.Handle, TRANSPARENT);

  LongFont.Select(Canvas.Handle);
  Canvas.TextOut(Round(Width / 2), Round(Height / 2), 'Dp7Lib');
  LongFont.UnSelect;
end;

end.
