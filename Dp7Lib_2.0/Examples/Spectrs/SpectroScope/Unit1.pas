unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dpSpectrs, dpPipette, dpColorSpectr, ExtCtrls, ComCtrls,
  ExtDlgs, StdCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    dpColorSpectr1: TdpColorSpectr;
    Panel5: TPanel;
    dpPipette1: TdpPipette;
    dpPipetteShape1: TdpPipetteShape;
    dpGradSpectr1: TdpGradSpectr;
    dpGradSpectr2: TdpGradSpectr;
    dpChoiceSpectr1: TdpChoiceSpectr;
    dpPipetteShape2: TdpPipetteShape;
    dpPipetteShape3: TdpPipetteShape;
    dpPipetteShape4: TdpPipetteShape;
    Button1: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure dpColorSpectr1PipettePixel(Sender: TObject);
    procedure dpGradSpectr1PipettePixel(Sender: TObject);
    procedure dpGradSpectr2PipettePixel(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure dpChoiceSpectr1PipettePixel(Sender: TObject);
    procedure TabSheet4Show(Sender: TObject);
    procedure TabSheet4Hide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.dpColorSpectr1PipettePixel(Sender: TObject);
begin
  if Visible then
  begin
    Panel5.Color := dpColorSpectr1.PipetteColor;
    dpGradSpectr1.ColorList.Items[1].Color := dpColorSpectr1.PipetteColor;
    dpGradSpectr2.ColorList.Items[1].Color := dpColorSpectr1.PipetteColor;
  end;
end;

procedure TForm1.dpGradSpectr1PipettePixel(Sender: TObject);
begin
  if Visible then
    Panel5.Color := dpGradSpectr1.PipetteColor;
end;

procedure TForm1.dpGradSpectr2PipettePixel(Sender: TObject);
begin
  if Visible then
    Panel5.Color := dpGradSpectr2.PipetteColor;
end;

procedure TForm1.TabSheet1Show(Sender: TObject);
begin
  Panel5.Color := dpColorSpectr1.PipetteColor;
end;

procedure TForm1.TabSheet2Show(Sender: TObject);
begin
  Panel5.Color := dpGradSpectr1.PipetteColor;
end;

procedure TForm1.TabSheet3Show(Sender: TObject);
begin
  Panel5.Color := dpGradSpectr2.PipetteColor;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if Not OpenPictureDialog1.Execute then Exit;
  dpChoiceSpectr1.Palette.LoadFromFile(OpenPictureDialog1.FileName);
  dpChoiceSpectr1.UpDatePalette;
end;

procedure TForm1.dpChoiceSpectr1PipettePixel(Sender: TObject);
begin
  if Visible and (dpChoiceSpectr1.Palette.Width > 0) and
  (dpChoiceSpectr1.Palette.Height > 0) then
  begin
    Panel5.Color := dpChoiceSpectr1.PipetteColor;
    dpGradSpectr1.ColorList.Items[1].Color := dpChoiceSpectr1.PipetteColor;
    dpGradSpectr2.ColorList.Items[1].Color := dpChoiceSpectr1.PipetteColor;
  end;
end;

procedure TForm1.TabSheet4Show(Sender: TObject);
begin
  Panel5.Color := dpChoiceSpectr1.PipetteColor;
  Button1.Visible := true;
end;

procedure TForm1.TabSheet4Hide(Sender: TObject);
begin
  Button1.Visible := false;
end;

end.
