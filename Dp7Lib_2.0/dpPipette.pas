unit dpPipette;

  {*******************************************************}
  {                                                       }
  {       Dp7Lib                                          }
  {                                                       }
  {       Copyright © 2008, Roenko Ivan                   }
  {                                                       }
  {       The version of the module 1.0                   }
  {                                                       }
  {*******************************************************}

interface

uses
  Windows, Classes, Controls;

const
  crPipette = TCursor(-5);

type
  TdpPipette = class(TComponent);

implementation

uses
  Forms;

{$R dpPipette.dcr}

initialization
  Screen.Cursors[crPipette] := LoadCursor(hinstance, 'CR_PIPETTE');

end.
