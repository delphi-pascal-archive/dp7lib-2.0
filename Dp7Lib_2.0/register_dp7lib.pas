unit register_dp7lib;

interface

uses
  Classes;

procedure Register;

implementation

uses
 dpSpectrs, dpColorSpectr, dpPipette, dpSysTray;

{$R dp7lib.dcr}

procedure Register;
begin
 RegisterComponents('dp7lib', [TdpTrayIcon,
 TdpChoiceSpectr, TdpGradSpectr, TdpColorSpectr,
 TdpPipetteShape, TdpPipette]);
end;

end.
