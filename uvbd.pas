unit uvbd;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, pqconnection, sqldb, FileUtil;

type

  { Tdbmodule }

  Tdbmodule = class(TDataModule)
    pgcnx: TPQConnection;
    pgsaberbd: TPQConnection;
    sqlconsultas: TSQLQuery;
    sqlconsultasSB: TSQLQuery;
    sqlconsultas2: TSQLQuery;
    SQLTransaction: TSQLTransaction;
    SQLTransactionSB: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  dbmodule: Tdbmodule;

implementation

{$R *.lfm}

end.

