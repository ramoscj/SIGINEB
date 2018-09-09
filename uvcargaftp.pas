unit uvcargaftp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Menus;

type

  { Tvcargaftp }

  Tvcargaftp = class(TForm)
    barra: TProgressBar;
    lblestado: TLabel;
    lblpeso: TLabel;
    lblpeso1: TLabel;
    lblproceso: TLabel;
    lblprogres: TLabel;
    lblprogres2: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    segundoclick: TPopupMenu;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vcargaftp: Tvcargaftp;

implementation

{$R *.lfm}

{ Tvcargaftp }



end.

