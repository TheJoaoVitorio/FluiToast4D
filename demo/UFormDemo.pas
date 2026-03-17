unit UFormDemo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FluiToast, FluiToast.Types;

type
  TFormDemo = class(TForm)
    btnSuccess: TButton;
    btnError: TButton;
    btnInfo: TButton;
    btnWarning: TButton;
    btnFluent: TButton;
    FluiToast1: TFluiToast;
    Button1: TButton;
    procedure btnSuccessClick(Sender: TObject);
    procedure btnErrorClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure btnWarningClick(Sender: TObject);
    procedure btnFluentClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDemo: TFormDemo;

implementation

{$R *.dfm}

procedure TFormDemo.btnSuccessClick(Sender: TObject);
begin
  TFluiToast.New
            .Title('Title')
            .Message('Message')
            .Duration(3500)
            .ToastType(ftSuccess)
            .OnClick(procedure
             begin
              ShowMessage('Toast Clicked')
             end)
            .Show;
end;

procedure TFormDemo.btnErrorClick(Sender: TObject);
begin
  TFluiToast.New
            .Title('Error')
            .Message('Error ao executar.')
            .Duration(3500)
            .ToastType(ftError)
            .OnClick(procedure
             begin
              ShowMessage('Toast Clicked');
             end)
            .Show;
end;

procedure TFormDemo.btnInfoClick(Sender: TObject);
begin
  TFluiToast.New
            .Title('Title')
            .Message('Message')
            .Duration(3500)
            .ToastType(ftInfo)
            .OnClick(procedure
             begin
              ShowMessage('Toast Clicked')
             end)
            .Show;
end;

procedure TFormDemo.btnWarningClick(Sender: TObject);
begin
  TFluiToast.New
            .Title('Title')
            .Message('Message')
            .Duration(3500)
            .ToastType(ftWarning)
            .OnClick(procedure
             begin
              ShowMessage('Toast Clicked')
             end)
            .Show;
end;

procedure TFormDemo.Button1Click(Sender: TObject);
begin
  TFluiToast.New
            .Title('Título Customizado')
            .TitleColor(clWhite)
            .Message('MYou can access and use theme colors throughout your components. For example, you might want to use colors defined in the theme for different parts of your app.')
            .MessageColor(clSilver)
            .Rounding(38)
            .BackgroundColor(clBlack)
            .BorderColor(clGray)
            .FontName('Google Sans')
            .Show;
end;

procedure TFormDemo.btnFluentClick(Sender: TObject);
begin
  TFluiToast.New
            .Title('Advanced Toast')
            .Message('This toast was created using the Fluent API and has a custom duration.')
            .ToastType(ftInfo)
            .Duration(6000)
            .OnClick(procedure
             begin
              ShowMessage('You clicked the advanced toast!');
             end)
            .Show;
end;

end.
