object FormDemo: TFormDemo
  Left = 0
  Top = 0
  Caption = 'FluiToast4D Demo'
  ClientHeight = 338
  ClientWidth = 569
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poMainFormCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 15
  object btnSuccess: TButton
    Left = 40
    Top = 40
    Width = 150
    Height = 35
    Caption = 'Show Success'
    TabOrder = 0
    OnClick = btnSuccessClick
  end
  object btnError: TButton
    Left = 40
    Top = 90
    Width = 150
    Height = 35
    Caption = 'Show Error'
    TabOrder = 1
    OnClick = btnErrorClick
  end
  object btnInfo: TButton
    Left = 40
    Top = 139
    Width = 150
    Height = 35
    Caption = 'Show Info'
    TabOrder = 2
    OnClick = btnInfoClick
  end
  object btnWarning: TButton
    Left = 40
    Top = 186
    Width = 150
    Height = 35
    Caption = 'Show Warning'
    TabOrder = 3
    OnClick = btnWarningClick
  end
  object btnFluent: TButton
    Left = 40
    Top = 236
    Width = 150
    Height = 35
    Caption = 'Fluent API Advanced'
    TabOrder = 4
    OnClick = btnFluentClick
  end
  object Button1: TButton
    Left = 40
    Top = 284
    Width = 150
    Height = 35
    Caption = 'Custom'
    TabOrder = 5
    OnClick = Button1Click
  end
  object FluiToast1: TFluiToast
    DefaultTitle = 'Default Title'
    DefaultMessage = 'This is a default message'
    DefaultPosition = ftpTopCenter
    DefaultRounding = 20
    DefaultBackgroundColor = clHighlight
    DefaultTitleColor = clLime
    DefaultMessageColor = clLime
    DefaultBorderColor = clBlue
    DefaultFontName = 'Segoe UI'
    Left = 504
    Top = 20
  end
end
