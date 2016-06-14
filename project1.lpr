program project1;

{$mode objfpc}{$H+}

uses
 {$IFDEF UNIX}{$IFDEF UseCThreads}
 cthreads,
 {$ENDIF}{$ENDIF}
 Interfaces, // this includes the LCL widgetset
 Forms, Principal, udiagnostico
 { you can add units after this };

{$R *.res}

begin
 RequireDerivedFormResource := True;
 Application.Initialize;
 Application.CreateForm(TFormPrincipal, FormPrincipal);
 Application.CreateForm(TFormDiagnostico, FormDiagnostico);
 Application.Run;
end.

