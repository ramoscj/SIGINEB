program uvindex;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tachartlazaruspkg, memdslaz, lazreportpdfexport, index, uvpricipal,
  uvimportar, uvbd, uvimportar2, uvftp, uvcargaftp, uvconsultas, uvcolsutas2,
  uvreportes, uvgraficos, uvusuarios, uvadduser, uvupdateuser, uvrestaurar,
  uvbdsalvar, uscaledpi
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(Tvcinicio, vcinicio);
  Application.CreateForm(Tdbmodule, dbmodule);
  Application.CreateForm(Tvcargaftp, vcargaftp);
  Application.Run;
end.

