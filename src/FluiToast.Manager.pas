unit FluiToast.Manager;

interface

uses
  System.Generics.Collections, Vcl.Forms, FluiToast.Types, FluiToast.View, 
  Vcl.Controls, Winapi.Windows, System.Classes, System.SysUtils;

type
  TFluiToastManager = class
  private
    class var FInstance: TFluiToastManager;
    FToasts: TList<TFluiToastView>;
    FPositions: TDictionary<TFluiToastView, TFluiToastPosition>;
    constructor Create;
    procedure RepositionToasts(AParent: TWinControl);
    procedure OnToastClose(Sender: TObject);
  public
    destructor Destroy; override;
    class function GetInstance: TFluiToastManager;
    procedure ShowToast(AView: TFluiToastView; APosition: TFluiToastPosition);
  end;

implementation

{ TFluiToastManager }

constructor TFluiToastManager.Create;
begin
  FToasts := TList<TFluiToastView>.Create;
  FPositions := TDictionary<TFluiToastView, TFluiToastPosition>.Create;
end;

destructor TFluiToastManager.Destroy;
begin
  FToasts.Free;
  FPositions.Free;
  inherited;
end;

class function TFluiToastManager.GetInstance: TFluiToastManager;
begin
  if not Assigned(FInstance) then
    FInstance := TFluiToastManager.Create;
  Result := FInstance;
end;

procedure TFluiToastManager.OnToastClose(Sender: TObject);
var
  LView: TFluiToastView;
  LParent: TWinControl;
begin
  LView := TFluiToastView(Sender);
  LParent := LView.Parent;
  
  FPositions.Remove(LView);
  FToasts.Remove(LView);
  
  if Assigned(LParent) then
    RepositionToasts(LParent);
end;

procedure TFluiToastManager.RepositionToasts(AParent: TWinControl);
var
  I: Integer;
  LView: TFluiToastView;
  LPos: TFluiToastPosition;
  LCounts: array[TFluiToastPosition] of Integer;
begin
  for LPos := Low(TFluiToastPosition) to High(TFluiToastPosition) do
    LCounts[LPos] := 0;

  for I := 0 to FToasts.Count - 1 do
  begin
    LView := FToasts[I];
    if (LView.Parent <> AParent) or not FPositions.TryGetValue(LView, LPos) then Continue;

    case LPos of
      ftpTopRight:
      begin
        LView.Left := AParent.ClientWidth - LView.Width - 20;
        LView.Top := 20 + (LCounts[LPos] * (LView.Height + 10));
      end;
      ftpTopLeft:
      begin
        LView.Left := 20;
        LView.Top := 20 + (LCounts[LPos] * (LView.Height + 10));
      end;
      ftpBottomRight:
      begin
        LView.Left := AParent.ClientWidth - LView.Width - 20;
        LView.Top := AParent.ClientHeight - LView.Height - 20 - (LCounts[LPos] * (LView.Height + 10));
      end;
      ftpBottomLeft:
      begin
        LView.Left := 20;
        LView.Top := AParent.ClientHeight - LView.Height - 20 - (LCounts[LPos] * (LView.Height + 10));
      end;
      ftpTopCenter:
      begin
        LView.Left := (AParent.ClientWidth div 2) - (LView.Width div 2);
        LView.Top := 20 + (LCounts[LPos] * (LView.Height + 10));
      end;
      ftpBottomCenter:
      begin
        LView.Left := (AParent.ClientWidth div 2) - (LView.Width div 2);
        LView.Top := AParent.ClientHeight - LView.Height - 20 - (LCounts[LPos] * (LView.Height + 10));
      end;
    end;
    Inc(LCounts[LPos]);
  end;
end;

procedure TFluiToastManager.ShowToast(AView: TFluiToastView; APosition: TFluiToastPosition);
var
  LActiveForm: TForm;
begin
  LActiveForm := Screen.ActiveForm;
  if not Assigned(LActiveForm) then 
  begin
    AView.Free;
    Exit;
  end;

  AView.Parent := LActiveForm;
  AView.OnClose := OnToastClose;
  
  FToasts.Add(AView);
  FPositions.Add(AView, APosition);
  
  RepositionToasts(LActiveForm);
  AView.ShowToast;
end;

initialization

finalization
  if Assigned(TFluiToastManager.FInstance) then
    TFluiToastManager.FInstance.Free;

end.
