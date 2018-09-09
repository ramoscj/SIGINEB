unit uvesquemas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  Buttons;

type

  { Tvesquemas }

  Tvesquemas = class(TForm)
    BitBtn1: TBitBtn;
    Process1: TProcess;
    procedure BitBtn1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vesquemas: Tvesquemas;

implementation

{$R *.lfm}

{ Tvesquemas }

procedure Tvesquemas.BitBtn1Click(Sender: TObject);
var
  UnProceso: TProcess;

begin
  // Ahora creamos UnProceso.
  UnProceso := TProcess.Create(nil);

  // Asignamos a UnProceso la orden que debe ejecutar.
  // Vamos a lanzar el compilador de FreePascal
  UnProceso.CommandLine := 'ppc386 -h';

  // Definimos una opción de comportamiento de 'TProccess'
  // La opción poWaitOnExit hará que nuestro programa
  // se detenga hasta que termine el programa lanzado
  UnProceso.Options := UnProceso.Options + [poWaitOnExit];

  // Lanzamos la ejecución de 'ppc386 -h'.
  UnProceso.Execute;

  // Nuestro programa espera hasta que 'ppc386' finaliza.
  UnProceso.Free;
end.

end.

