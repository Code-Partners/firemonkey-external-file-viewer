unit FForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.IOUtils,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, UExternalFileViewer;

type
  TForm5 = class(TForm)
    Layout1: TLayout;
    Button1: TButton;
    Layout2: TLayout;
    Button2: TButton;
    Layout3: TLayout;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FViewer: TExternalFileViewer;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.fmx}

procedure TForm5.FormCreate(Sender: TObject);
begin
  self.FViewer := TExternalFileViewer.Factory(self, self);
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  self.FViewer.OpenFile(
    System.IOUtils.TPath.GetDocumentsPath() + PathDelim + 'svn-book.pdf'
  );
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  self.FViewer.OpenURL('https://github.com/progit/progit2/releases/download/2.1.45/progit.pdf');
end;

procedure TForm5.Button3Click(Sender: TObject);
begin
  self.FViewer.OpenURL('https://git-scm.com/images/logo@2x.png');
end;

end.
