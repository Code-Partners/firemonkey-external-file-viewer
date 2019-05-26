{****************************************************}
{                                                    }
{ firemonkey-external-file-viewer                    }
{                                                    }
{ Copyright (C) 2018 Code Partners Pty Ltd           }
{                                                    }
{ http://www.code-partners.com                       }
{                                                    }
{****************************************************}
{                                                    }
{ This Source Code Form is subject to the terms of   }
{ the Mozilla Public License, v. 2.0. If a copy of   }
{ the MPL was not distributed with this file, You    }
{ can obtain one at                                  }
{                                                    }
{ http://mozilla.org/MPL/2.0/                        }
{                                                    }
{****************************************************}
unit UExternalFileViewer.Android;

interface

{$IFDEF ANDROID}

uses
  System.SysUtils, System.Classes, FMX.Forms, FMX.ExternalFileViewer,
  System.IOUtils,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Os,
  Androidapi.JNI.Util,
  Androidapi.Helpers,
  Androidapi.JNI.Environment,
  Androidapi.JNI.Webkit,
  FMX.Helpers.Android;

type
  TAndroidExternalFileViewer = class(TExternalFileViewer)
  private
    function GetMimeType(Uri: Jnet_Uri): JString;
  public
    procedure OpenFile(Path: string); override;
    procedure OpenURL(URL: string); override;
  end;

{$ENDIF}

implementation

{$IFDEF ANDROID}

uses
  FMX.Dialogs;

{ TAndroidExternalFileViewer }

procedure TAndroidExternalFileViewer.OpenFile(Path: string);
var
  Uri: Jnet_Uri;
  Intent: JIntent;
begin
  inherited;

  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);

  Uri := TAndroidHelper.JFileToJURI
    (TJFile.JavaClass.init(StringToJString(Path)));

  Intent.setDataAndType(Uri, self.GetMimeType(Uri));
  Intent.setFlags(TJIntent.JavaClass.FLAG_GRANT_READ_URI_PERMISSION);

  TAndroidHelper.Activity.startActivity(Intent);
end;

procedure TAndroidExternalFileViewer.OpenURL(URL: string);
var
  Intent: JIntent;
  Uri: Jnet_Uri;
begin
  inherited;

  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW);

  Uri := TJnet_Uri.JavaClass.parse(StringToJString(URL));
  Intent.setDataAndType(Uri, self.GetMimeType(Uri));

  Intent.setFlags(TJIntent.JavaClass.FLAG_ACTIVITY_NO_HISTORY);

  TAndroidHelper.Activity.startActivity(Intent);
end;

function TAndroidExternalFileViewer.GetMimeType(Uri: Jnet_Uri): JString;
var
  MimeType: JString;
  ContentResolver: JContentResolver;
  FileExtension: JString;
begin
  // https://stackoverflow.com/a/31691791/2899073

  MimeType := nil;
  if (Uri.getScheme.equals(TJContentResolver.JavaClass.SCHEME_CONTENT)) then
  begin
    ContentResolver := TAndroidHelper.Context.getContentResolver();
    MimeType := ContentResolver.getType(Uri);
  end
  else
  begin
    FileExtension := TJMimeTypeMap.JavaClass.getFileExtensionFromUrl
      (Uri.toString());

    MimeType := TJMimeTypeMap.JavaClass.getSingleton().getMimeTypeFromExtension
      (FileExtension.toLowerCase());
  end;

  Result := MimeType;
end;

{$ENDIF}

end.
