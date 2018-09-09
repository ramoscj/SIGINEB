unit index;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls, uvpricipal, uvbd;

type

  { Tvcinicio }

  Tvcinicio = class(TForm)
    BitBtn1: TBitBtn;
    combouser: TComboBox;
    editpass: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure cambiopass(pregunta:String;id:integer);
    procedure cambio(id:integer);
    { private declarations }
  public
    { public declarations }
  end;

var
  vcinicio: Tvcinicio;
  vprincipal:Tvprincipal;
  nivel: array [0..99999] of String;

implementation

{$R *.lfm}

{ Tvcinicio }

procedure Tvcinicio.BitBtn1Click(Sender: TObject);
var
  user: array [0..99999] of String;
  i:integer;
begin

 dbmodule.pgcnx.Connected:=true;

  i:=0;
  dbmodule.sqlconsultas.SQL.Text:='select * from tools.usuarios where usuario='''+combouser.Text+''' and clave=md5('''+editpass.Text+''') ';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
    while not dbmodule.sqlconsultas.EOF do
       begin
          user[i]:=dbmodule.sqlconsultas.Fields[1].Text;
          nivel[i]:=dbmodule.sqlconsultas.Fields[3].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  dbmodule.sqlconsultas.Close;

  if i>=1 then
    begin
      vprincipal:=Tvprincipal.Create(Self);
      vprincipal.Show;
      vcinicio.Hide;
      vprincipal.usuario.Caption:=user[i-1];
    end
  else
    begin
       MessageDlg('Error en usuario o contraseña',mtError,[mbOK],0);
       editpass.Text:='';
    end;

  dbmodule.pgcnx.Connected:=false;
end;

procedure Tvcinicio.FormShow(Sender: TObject);
begin
  combouser.Items.Clear;
  editpass.Text:='';
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  dbmodule.sqlconsultas.SQL.Text:='select * from tools.usuarios order by nivel asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          combouser.AddItem(dbmodule.sqlconsultas.Fields[1].Text,nil);
          dbmodule.sqlconsultas.Next;
       end;
  dbmodule.sqlconsultasSB.Close;
  dbmodule.pgcnx.Connected:=False;
end;

procedure Tvcinicio.cambiopass(pregunta:String;id:integer);
var
  opcion:Boolean;
  respuesta:String;
  cant:Integer;
begin

  //RESPONDER PREGUNTA SECRETA
  opcion:=InputQuery('Responda la pregunta','¿'+pregunta+'?',False,respuesta);
    if opcion=true then
      begin;
        dbmodule.pgcnx.Connected:=false;
        dbmodule.pgcnx.Connected:=true;
        dbmodule.sqlconsultas.SQL.Text:='select count(*) as cuantos from tools.usuarios where respuesta='''+respuesta+''' and id_usuario='''+IntToStr(id)+'''';
        dbmodule.SQLTransaction.Active:=false;
        dbmodule.SQLTransaction.StartTransaction;
        dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              cant:=dbmodule.sqlconsultas.Fields[0].AsInteger;
              dbmodule.sqlconsultas.Next;
           end;
        dbmodule.sqlconsultasSB.Close;
        dbmodule.pgcnx.Connected:=False;
          if cant>=1 then
            begin
               cambio(id);
            end
          else
            begin
               MessageDlg('Su respuesta no es la correcta',mtError,[mbOK],0);
            end;
      end;
end;

procedure Tvcinicio.cambio(id:integer);
var
  clave:String;
  modal:Boolean;
begin
  //CAMBIO DE CONTRASEÑA
  modal:=InputQuery('Restauración de contraseña','Igrese la nueva contraseña',False,clave);
    if modal=True then
      begin
        //VALIDAR CAMPO VACIO
        if clave<>'' then
          begin
           dbmodule.pgcnx.Connected:=false;
           dbmodule.pgcnx.Connected:=true;
           dbmodule.sqlconsultas.SQL.Text:='update tools.usuarios set clave=md5('''+clave+''') where id_usuario='''+IntToStr(id)+''' ';
           dbmodule.SQLTransaction.Active:=false;
           dbmodule.SQLTransaction.StartTransaction;
           dbmodule.sqlconsultas.ExecSQL;
           dbmodule.SQLTransaction.Commit;
           MessageDlg('Se ha actualizado la contraseña',mtInformation,[mbOK],0);
           dbmodule.pgcnx.Connected:=False;
          end
        else
          begin
            MessageDlg('Error al actualizar *Campo vacio',mtError,[mbOK],0);
          end;
      end;
end;

procedure Tvcinicio.Label3Click(Sender: TObject);
var
  pregunta,respuesta:String;
  cant,id:Integer;
  opcion:Boolean;
begin
  //PARA TRAER LA PREGUNTA
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  id:=0;
  try
  dbmodule.sqlconsultas.SQL.Text:='select id_usuario,pregunta from tools.usuarios where usuario='''+combouser.Text+'''';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          id:=dbmodule.sqlconsultas.Fields[0].AsInteger;
          pregunta:=dbmodule.sqlconsultas.Fields[1].Text;
          dbmodule.sqlconsultas.Next;
       end;
  dbmodule.sqlconsultasSB.Close;
  dbmodule.pgcnx.Connected:=False;
    if id>0 then
      begin
         cambiopass(pregunta,id);
      end
    else
      begin
        MessageDlg('Usuario no existe en los registros',mtError,[mbOK],0);
      end;

  except
     MessageDlg('Error al conectar',mtError,[mbOK],0);
  end;

end;


end.

