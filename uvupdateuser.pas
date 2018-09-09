unit uvupdateuser;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons, uvbd;

type

  { Tvupdateuser }

  Tvupdateuser = class(TForm)
    btninsertar: TBitBtn;
    combolvl: TComboBox;
    combopregunta: TComboBox;
    editnombre: TEdit;
    editrespuesta: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    procedure btninsertarClick(Sender: TObject);
    procedure editnombreKeyPress(Sender: TObject; var Key: char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vupdateuser: Tvupdateuser;
  nivel:Integer;
  control:String;


implementation

{$R *.lfm}

{ Tvupdateuser }

procedure Tvupdateuser.btninsertarClick(Sender: TObject);
begin
  if (editnombre.Text<>'') and (combolvl.Text<>'') then
    begin
      dbmodule.pgcnx.Connected:=false;
      dbmodule.pgcnx.Connected:=true;
      dbmodule.sqlconsultas.SQL.Text:='select count(*) as cuantos from tools.usuarios where usuario='''+editnombre.Text+'''';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
      if (dbmodule.sqlconsultas.Fields[0].AsInteger>=1) and (editnombre.Text<>control) then
        begin
          MessageDlg('El usuario ingresado ya se encuentra en uso',mtWarning,[mbOK],0);
          editnombre.Text:='';
          editnombre.SetFocus;
        end
      else
        begin
          try
            dbmodule.sqlconsultas.SQL.Text:='update tools.usuarios set usuario='''+editnombre.Text+''',nivel='''+IntToStr(combolvl.ItemIndex)+''', pregunta='''+combopregunta.Text+''',respuesta='''+editrespuesta.Text+''' where id_usuario='''+IntToStr(nivel)+'''';
            dbmodule.SQLTransaction.Active:=false;
            dbmodule.SQLTransaction.StartTransaction;
            dbmodule.sqlconsultas.ExecSQL;
            dbmodule.SQLTransaction.Commit;
            MessageDlg('Actualización correcta',mtInformation,[mbOK],0);
          except
            MessageDlg('Error al actualizar',mtError,[mbOK],0);
          end;
        end;
    end
  else
    begin
      MessageDlg('No debe dejar campos vacios',mtWarning,[mbOK],0);
    end;
  dbmodule.pgcnx.Connected:=false;
end;

procedure Tvupdateuser.editnombreKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['A'..'Z',#7, #8, #13]) then
  begin
    Key := #0;
    Beep;
  end;
end;

procedure Tvupdateuser.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvupdateuser.FormShow(Sender: TObject);
begin
  btninsertar.SetFocus;
  control:=editnombre.Text;
  combopregunta.ItemIndex:=8;
end;

procedure Tvupdateuser.Label5Click(Sender: TObject);
var
  clave:String;
  opcion:Boolean;
begin
  opcion:=InputQuery('Cambio de contrseña','Ingrese la nueva contraseña',false,clave);
  if opcion=true then
    begin
      dbmodule.pgcnx.Connected:=false;
      dbmodule.pgcnx.Connected:=true;
      if clave<>'' then
        begin
          try
            dbmodule.sqlconsultas.SQL.Text:='update tools.usuarios set clave=md5('''+clave+''') where id_usuario='''+IntToStr(nivel)+'''';
            dbmodule.SQLTransaction.Active:=false;
            dbmodule.SQLTransaction.StartTransaction;
            dbmodule.sqlconsultas.ExecSQL;
            dbmodule.SQLTransaction.Commit;
            MessageDlg('Actualización correcta',mtInformation,[mbOK],0);
          except
            MessageDlg('Error al actualizar',mtError,[mbOK],0);
          end;
        end
      else
        begin
          MessageDlg('No debe dejar el campo vacio, no se actuaizo la contraseña',mtWarning,[mbOK],0);
        end;
    end;
end;

end.

