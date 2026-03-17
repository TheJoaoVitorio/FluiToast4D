unit FluiToast.Register;

interface

uses
  System.Classes, FluiToast;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FLUI', [TFluiToast]);
end;

end.
