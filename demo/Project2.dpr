program Project2;

uses
  Vcl.Forms,
  UFormDemo in 'UFormDemo.pas' {FormDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormDemo, FormDemo);
  Application.Run;
end.
