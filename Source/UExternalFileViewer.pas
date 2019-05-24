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
unit UExternalFileViewer;

interface

uses
  System.SysUtils, System.Classes, FMX.Forms;

type
  TExternalFileViewer = class(TComponent)
  protected
    FForm: TCommonCustomForm;

    constructor Create(AOwner: TComponent); reintroduce; virtual;
  public
    class function Factory(AOwner: TComponent): TExternalFileViewer;

    procedure OpenFile(Path: string); virtual; abstract;
    procedure OpenURL(URL: string); virtual; abstract;
  end;

  TDummyExternalFileViewer = class(TExternalFileViewer)
  public
    procedure OpenFile(Path: string); override;
    procedure OpenURL(URL: string); override;
  end;

implementation

{$IF DEFINED(ANDROID)}

uses
  UExternalFileViewer.Android;
{$ELSEIF DEFINED(IOS)}

uses
  UExternalFileViewer.iOS;
{$ELSEIF DEFINED(MSWINDOWS)}

uses
  UExternalFileViewer.Windows;
{$ENDIF}
{ TExternalFileViewer }

constructor TExternalFileViewer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if (AOwner is TCommonCustomForm) then
  begin
    self.FForm := (AOwner as TCommonCustomForm)
  end
  else
  begin
    self.FForm := Application.MainForm;
  end;

end;

class function TExternalFileViewer.Factory(AOwner: TComponent)
  : TExternalFileViewer;
begin
{$IF DEFINED(MSWINDOWS)}
  Result := TWindowsExternalFileViewer.Create(AOwner);
{$ELSEIF DEFINED(ANDROID)}
  Result := TAndroidExternalFileViewer.Create(AOwner);
{$ELSEIF DEFINED(IOS)}
  Result := TiOSExternalFileViewer.Create(AOwner);
{$ELSE}
  Result := TDummyExternalFileViewer.Create(AOwner);
{$ENDIF}
end;

{ TDummyExternalFileViewer }

procedure TDummyExternalFileViewer.OpenFile(Path: string);
begin

end;

procedure TDummyExternalFileViewer.OpenURL(URL: string);
begin

end;

end.
