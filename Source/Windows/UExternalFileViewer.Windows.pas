{ **************************************************** }
{ }
{ firemonkey-external-file-viewer }
{ }
{ Copyright (C) 2018 Code Partners Pty Ltd }
{ }
{ http://www.code-partners.com }
{ }
{ **************************************************** }
{ }
{ This Source Code Form is subject to the terms of }
{ the Mozilla Public License, v. 2.0. If a copy of }
{ the MPL was not distributed with this file, You }
{ can obtain one at }
{ }
{ http://mozilla.org/MPL/2.0/ }
{ }
{ **************************************************** }
unit UExternalFileViewer.Windows;

interface

{$IFDEF MSWINDOWS}

uses
  System.SysUtils, System.Classes, UExternalFileViewer,
  System.IOUtils;

type
  TWindowsExternalFileViewer = class(TExternalFileViewer)
  private
  public
    procedure OpenFile(Path: string); override;
    procedure OpenURL(URL: string); override;
  end;

{$ENDIF}

implementation

{$IFDEF MSWINDOWS}

uses
  Winapi.ShellAPI, Winapi.Windows;

procedure TWindowsExternalFileViewer.OpenFile(Path: string);
begin
  ShellExecute(0, 'OPEN', PChar(Path), '', '', SW_SHOWNORMAL);
end;

procedure TWindowsExternalFileViewer.OpenURL(URL: string);
begin
  ShellExecute(0, 'OPEN', PChar(URL), '', '', SW_SHOWNORMAL);
end;

{$ENDIF}

end.
