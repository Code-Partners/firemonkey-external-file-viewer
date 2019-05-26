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
unit UExternalFileViewer.iOS;

interface

{$IFDEF IOS}

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Forms, UExternalFileViewer,
  Macapi.Helpers,
  iOSAPI.Foundation,
  iOSAPI.Helpers,
  iOSAPI.UIKit,
  iOSAPI.CoreGraphics,
  FMX.Helpers.iOS,
  FMX.Platform.iOS,
  Macapi.ObjectiveC,
  Macapi.ObjCRuntime,
  UOpenUrlUtils;

type
  TiOSExternalFileViewer = class;

  TUIDocumentInteractionControllerDelegate = class(TOCLocal,
    UIDocumentInteractionControllerDelegate)
  private
    [Weak]
    FViewer: TiOSExternalFileViewer;
  public
    constructor Create(AViewer: TiOSExternalFileViewer);

    function documentInteractionControllerViewControllerForPreview
      (controller: UIDocumentInteractionController): UIViewController; cdecl;
    function documentInteractionControllerRectForPreview
      (controller: UIDocumentInteractionController): CGRect; cdecl;
    function documentInteractionControllerViewForPreview
      (controller: UIDocumentInteractionController): UIView; cdecl;
    procedure documentInteractionControllerWillBeginPreview
      (controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerDidEndPreview
      (controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerWillPresentOptionsMenu
      (controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerDidDismissOptionsMenu
      (controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerWillPresentOpenInMenu
      (controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerDidDismissOpenInMenu
      (controller: UIDocumentInteractionController); cdecl;
    [MethodName('documentInteractionController:willBeginSendingToApplication:')]
    procedure documentInteractionControllerWillBeginSendingToApplication
      (controller: UIDocumentInteractionController;
      willBeginSendingToApplication: NSString); cdecl;
    [MethodName('documentInteractionController:didEndSendingToApplication:')]
    procedure documentInteractionControllerDidEndSendingToApplication
      (controller: UIDocumentInteractionController;
      didEndSendingToApplication: NSString); cdecl;
    [MethodName('documentInteractionController:canPerformAction:')]
    function documentInteractionControllerCanPerformAction
      (controller: UIDocumentInteractionController; canPerformAction: SEL)
      : Boolean; cdecl;
    [MethodName('documentInteractionController:performAction:')]
    function documentInteractionControllerPerformAction
      (controller: UIDocumentInteractionController; performAction: SEL)
      : Boolean; cdecl;
  end;

  TiOSExternalFileViewer = class(TExternalFileViewer)
  private
    FController: UIDocumentInteractionController;
    FDelegate: TUIDocumentInteractionControllerDelegate;
  public
    constructor Create(AOwner: TComponent); override;

    procedure OpenFile(Path: string); override;
    procedure OpenURL(URL: string); override;
  end;

{$ENDIF}

implementation

{$IFDEF IOS}
{ TiOSExternalFileViewer }

constructor TiOSExternalFileViewer.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TiOSExternalFileViewer.OpenFile(Path: string);
var
  URL: NSUrl;
begin
  try
    URL := TNSUrl.Wrap(TNSUrl.OCClass.fileURLWithPath(StrToNSStr(Path)));

    self.FController := TUIDocumentInteractionController.Wrap
      (TUIDocumentInteractionController.OCClass.
      interactionControllerWithURL(URL));
    FDelegate := TUIDocumentInteractionControllerDelegate.Create(self);
    self.FController.setDelegate(self.FDelegate.GetObjectID);

    self.FController.presentPreviewAnimated(true);
  except
  end;
end;

procedure TiOSExternalFileViewer.OpenURL(URL: string);
begin
  UOpenUrlUtils.OpenURL(URL);
end;

{ TUIDocumentInteractionControllerDelegate }

constructor TUIDocumentInteractionControllerDelegate.Create
  (AViewer: TiOSExternalFileViewer);
begin
  inherited Create;

  self.FViewer := AViewer;
end;

function TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerCanPerformAction
  (controller: UIDocumentInteractionController; canPerformAction: SEL): Boolean;
begin
  Result := true;
end;

procedure TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerDidDismissOpenInMenu
  (controller: UIDocumentInteractionController);
begin

end;

procedure TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerDidDismissOptionsMenu
  (controller: UIDocumentInteractionController);
begin

end;

procedure TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerDidEndPreview(controller
  : UIDocumentInteractionController);
begin

end;

procedure TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerDidEndSendingToApplication
  (controller: UIDocumentInteractionController;
  didEndSendingToApplication: NSString);
begin

end;

function TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerPerformAction(controller
  : UIDocumentInteractionController; performAction: SEL): Boolean;
begin
  Result := true;
end;

function TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerRectForPreview
  (controller: UIDocumentInteractionController): CGRect;
begin

end;

function TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerViewControllerForPreview
  (controller: UIDocumentInteractionController): UIViewController;
var
  h: TiOSWindowHandle;
  w: UIWindow;
  v: UIViewController;
begin

  h := WindowHandleToPlatform(self.FViewer.FForm.Handle);
  w := h.Wnd;
  v := w.rootViewController;

  Result := v;
end;

function TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerViewForPreview
  (controller: UIDocumentInteractionController): UIView;
begin

end;

procedure TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerWillBeginPreview
  (controller: UIDocumentInteractionController);
begin

end;

procedure TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerWillBeginSendingToApplication
  (controller: UIDocumentInteractionController;
  willBeginSendingToApplication: NSString);
begin

end;

procedure TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerWillPresentOpenInMenu
  (controller: UIDocumentInteractionController);
begin

end;

procedure TUIDocumentInteractionControllerDelegate.
  documentInteractionControllerWillPresentOptionsMenu
  (controller: UIDocumentInteractionController);
begin

end;

{$ENDIF}

end.
