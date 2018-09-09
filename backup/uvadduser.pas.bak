unit uvadduser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Grids, StdCtrls, Buttons, uvbd;

type

  { Tvadduser }

  Tvadduser = class(TForm)
    btninsertar: TBitBtn;
    combolvl: TComboBox;
    combopregunta: TComboBox;
    editrespuesta: TEdit;
    editnombre: TEdit;
    editclave: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    procedure btninsertarClick(Sender: TObject);
    procedure editnombreExit(Sender: TObject);
    procedure editnombreKeyPress(Sender: TObject; var Key: char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vadduser: Tvadduser;

implementation

{$R *.lfm}

{ Tvadduser }

procedure Tvadduser.btninsertarClick(Sender: TObject);
begin
  if (editnombre.Text<>'') and (editclave.Text<>'') and (combolvl.Text<>'') then
    begin
      dbmodule.pgcnx.Connected:=false;
      dbmodule.pgcnx.Connected:=true;
      try
        dbmodule.sqlconsultas.SQL.Text:='insert into tools.usuarios (id_usuario,usuario,clave,nivel,pregunta,respuesta) values (default,'''+editnombre.Text+''',md5('''+editclave.Text+'''),'''+IntToStr(combolvl.ItemIndex)+''','''+combopregunta.Text+''',,'''+editrespuesta.Text+''')';
        dbmodule.SQLTransaction.Active:=false;
        dbmodule.SQLTransaction.StartTransaction;
        dbmodule.sqlconsultas.ExecSQL;
        dbmodule.SQLTransaction.Commit;
        MessageDlg('Registro correcto',mtInformation,[mbOK],0);
        editnombre.Text:='';
        editclave.Text:='';
        combolvl.ItemIndex:=-1;
      except
        MessageDlg('Error al registrar',mtError,[mbOK],0);
      end;
    end
  else
    begin
      MessageDlg('No debe dejar campos vacios',mtWarning,[mbOK],0);
    end;
  dbmodule.pgcnx.Connected:=false;
end;

procedure Tvadduser.editnombreExit(Sender: TObject);
begin
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.DatabaseName:='zona_db';
  dbmodule.pgcnx.Connected:=true;
  dbmodule.sqlconsultas.SQL.Text:='select count(*) as cuantos from tools.usuarios where usuario='''+editnombre.Text+'''';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
  if dbmodule.sqlconsultas.Fields[0].AsInteger>=1 then
    begin
      MessageDlg('El usuario ingresado ya se encuentra en uso',mtWarning,[mbOK],0);
      editnombre.Text:='';
      editnombre.SetFocus;
    end;
  dbmodule.pgcnx.Connected:=false;
end;

procedure Tvadduser.editnombreKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['A'..'Z',#7, #8, #13]) then
  begin
    Key := #0;
    Beep;
  end;
end;

procedure Tvadduser.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

end.

