program DelphiExternalFileViewerSample;

uses
  System.StartUpCopy,
  FMX.Forms,
  FForm in 'FForm.pas' {Form5},
  UExternalFileViewer in '..\Source\UExternalFileViewer.pas',
  Androidapi.JNI.Environment in '..\Source\Android\Androidapi.JNI.Environment.pas',
  UExternalFileViewer.Android in '..\Source\Android\UExternalFileViewer.Android.pas',
  UOpenURLUtils in '..\Source\UOpenURLUtils.pas',
  UExternalFileViewer.iOS in '..\Source\iOS\UExternalFileViewer.iOS.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
