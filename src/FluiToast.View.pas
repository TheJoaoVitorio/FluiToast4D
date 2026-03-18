unit FluiToast.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.ExtCtrls, FluiToast.Types, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TFluiToastView = class(TCustomControl)
  private
    FOnClose: TNotifyEvent;
    FTitle: string;
    FMessage: string;
    FType: TFluiToastType;
    FDuration: Integer;
    FOnClick: TFluiToastAction;
    FTimer: TTimer;
    FBackgroundColor: TColor;
    FTitleColor: TColor;
    FMessageColor: TColor;
    FBorderColor: TColor;
    FRounding: Integer;
    FFontName: string;
    FAlpha: Byte;
    FImage: TPicture;
    procedure SetImage(const Value: TPicture);
    procedure OnTimer(Sender: TObject);
    procedure DoClose;
    procedure ApplyTheme;
  protected
    procedure Paint; override;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ShowToast;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property Title: string read FTitle write FTitle;
    property Message: string read FMessage write FMessage;
    property ToastType: TFluiToastType read FType write FType;
    property Duration: Integer read FDuration write FDuration;
    property OnToastClick: TFluiToastAction read FOnClick write FOnClick;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor;
    property TitleColor: TColor read FTitleColor write FTitleColor;
    property MessageColor: TColor read FMessageColor write FMessageColor;
    property BorderColor: TColor read FBorderColor write FBorderColor;
    property Rounding: Integer read FRounding write FRounding;
    property FontName: string read FFontName write FFontName;
    property Image: TPicture read FImage write SetImage;
  end;

implementation

uses
  Winapi.GDIPOBJ, Winapi.GDIPAPI;

{ TFluiToastView }

constructor TFluiToastView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 340;
  Height := 75;
  DoubleBuffered := True;
  FDuration := 3000;
  FRounding := 38;
  FFontName := 'Segoe UI';
  FAlpha := 255;
  
  FBackgroundColor := clWhite;
  FTitleColor := COLOR_TEXT_TITLE;
  FMessageColor := COLOR_TEXT_MESSAGE;
  FBorderColor := COLOR_BORDER_DEFAULT;
  
  FTimer := TTimer.Create(Self);
  FTimer.Enabled := False;
  FTimer.OnTimer := OnTimer;
  
  FImage := TPicture.Create;
end;

destructor TFluiToastView.Destroy;
begin
  FImage.Free;
  inherited;
end;

procedure TFluiToastView.SetImage(const Value: TPicture);
begin
  FImage.Assign(Value);
end;

procedure TFluiToastView.Click;
begin
  inherited;
  if Assigned(FOnClick) then
    FOnClick();
  DoClose;
end;

procedure TFluiToastView.DoClose;
begin
  if Assigned(FOnClose) then
    FOnClose(Self);
  Free;
end;

procedure TFluiToastView.OnTimer(Sender: TObject);
begin
  DoClose;
end;

procedure TFluiToastView.Paint;
var
  LRect: TRect;
  LGraphics: TGPGraphics;
  LPath: TGPGraphicsPath;
  LBrush: TGPSolidBrush;
  LPen: TGPPen;
  LRound: Single;
  LImgRect: TRect;
  LTextOffset: Integer;

  function GetTGPColor(AColor: TColor; AAlpha: Byte = 255): TGPColor;
  var
    LColor: COLORREF;
  begin
    LColor := ColorToRGB(AColor);
    Result := MakeColor(AAlpha, GetRValue(LColor), GetGValue(LColor), GetBValue(LColor));
  end;

begin
  LGraphics := TGPGraphics.Create(Canvas.Handle);
  try
    LGraphics.SetSmoothingMode(SmoothingModeAntiAlias);

    LRound := FRounding;
    if LRound > Height then LRound := Height;
    if LRound > Width then LRound := Width;

    LPath := TGPGraphicsPath.Create;
    try
      // Arcs for rounded corners
      LPath.AddArc(0.5, 0.5, LRound, LRound, 180, 90); // Top-left
      LPath.AddArc(Width - LRound - 0.5, 0.5, LRound, LRound, 270, 90); // Top-right
      LPath.AddArc(Width - LRound - 0.5, Height - LRound - 0.5, LRound, LRound, 0, 90); // Bottom-right
      LPath.AddArc(0.5, Height - LRound - 0.5, LRound, LRound, 90, 90); // Bottom-left
      LPath.CloseFigure;

      // Fill Background
      LBrush := TGPSolidBrush.Create(GetTGPColor(FBackgroundColor, FAlpha));
      try
        LGraphics.FillPath(LBrush, LPath);
      finally
        LBrush.Free;
      end;

      // Draw Border
      LPen := TGPPen.Create(GetTGPColor(FBorderColor, FAlpha), 1);
      try
        LGraphics.DrawPath(LPen, LPath);
      finally
        LPen.Free;
      end;
    finally
      LPath.Free;
    end;
  finally
    LGraphics.Free;
  end;

  LTextOffset := 16;

  if Assigned(FImage.Graphic) and not FImage.Graphic.Empty then
  begin
    LImgRect := Rect(16, (Height - 32) div 2, 16 + 32, ((Height - 32) div 2) + 32);
    Canvas.StretchDraw(LImgRect, FImage.Graphic);
    LTextOffset := LTextOffset + 32 + 12;
  end;

  // Title
  Canvas.Font.Name := FFontName;
  Canvas.Font.Size := 10;
  Canvas.Font.Style := [fsBold];
  Canvas.Font.Color := FTitleColor;
  Canvas.Brush.Style := bsClear;
  
  LRect := ClientRect;
  LRect.Left := LTextOffset;
  LRect.Top := 12;
  LRect.Right := LRect.Right - 16;
  LRect.Bottom := LRect.Bottom - 12;
  
  Canvas.TextRect(LRect, FTitle, [tfLeft, tfTop, tfSingleLine, tfEndEllipsis]);

  // Menssage
  if FMessage <> '' then
  begin
    Canvas.Font.Style := [];
    Canvas.Font.Size := 9;
    Canvas.Font.Color := FMessageColor;
    Canvas.Brush.Style := bsClear;
    LRect.Top := LRect.Top + 22;
    Canvas.TextRect(LRect, FMessage, [tfLeft, tfTop, tfWordBreak]);
  end;
end;

procedure TFluiToastView.ShowToast;
begin
  ApplyTheme;
  Visible := True;
  BringToFront;
  FTimer.Interval := FDuration;
  FTimer.Enabled := True;
end;

procedure TFluiToastView.ApplyTheme;
begin
  if FType <> ftCustom then
  begin
    case FType of
      ftSuccess:
      begin
        FBackgroundColor := COLOR_SUCCESS_BG;
        FBorderColor := COLOR_SUCCESS_BORDER;
        FTitleColor := COLOR_SUCCESS_TEXT;
        FMessageColor := COLOR_SUCCESS_TEXT;
      end;
      ftError:
      begin
        FBackgroundColor := COLOR_ERROR_BG;
        FBorderColor := COLOR_ERROR_BORDER;
        FTitleColor := COLOR_ERROR_TEXT;
        FMessageColor := COLOR_ERROR_TEXT;
      end;
      ftWarning:
      begin
        FBackgroundColor := COLOR_WARNING_BG;
        FBorderColor := COLOR_WARNING_BORDER;
        FTitleColor := COLOR_WARNING_TEXT;
        FMessageColor := COLOR_WARNING_TEXT;
      end;
      ftInfo:
      begin
        FBackgroundColor := COLOR_INFO_BG;
        FBorderColor := COLOR_INFO_BORDER;
        FTitleColor := COLOR_INFO_TEXT;
        FMessageColor := COLOR_INFO_TEXT;
      end;
    end;
  end;
end;

end.