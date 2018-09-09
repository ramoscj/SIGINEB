unit uvrestaurar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, Buttons, Grids,uvbd;

type

  { Tvrestaurar }

  Tvrestaurar = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    btneliminar: TBitBtn;
    btneditar: TBitBtn;
    btnschema: TBitBtn;
    editdirpg: TEdit;
    editnshema: TEdit;
    editdir: TEdit;
    edittshema: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    abrirfile: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Process1: TProcess;
    ScrollBar1: TScrollBar;
    abrirdir: TSelectDirectoryDialog;
    stgesquemas: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btneditarClick(Sender: TObject);
    procedure btneliminarClick(Sender: TObject);
    procedure btnschemaClick(Sender: TObject);
    procedure editnshemaKeyPress(Sender: TObject; var Key: char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure stgesquemasSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure listaresquemas();
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vrestaurar: Tvrestaurar;
  fila:Integer;
  select:Boolean;

implementation

{$R *.lfm}

{ Tvrestaurar }

procedure Tvrestaurar.btnschemaClick(Sender: TObject);
var
  UnProceso:TProcess;
begin
  if (edittshema.Text<>'') and (editnshema.Text<>'') and (editdir.Text<>'') and (editdirpg.Text<>'') then
    begin
     btnschema.Enabled:=true;
     UnProceso:=TProcess.Create(nil);
     try
     UnProceso.CurrentDirectory:=editdirpg.Text;
     UnProceso.Executable:='pg_restore';
     with UnProceso.Parameters do
       begin
          Add('-U');
          Add('postgres');
          Add('-h');
          Add('localhost');
          Add('-d');
          Add('zona_db');
          Add('-v');
          Add('-c');
          Add(editdir.Text);
       end;
     UnProceso.Options:=UnProceso.Options + [poWaitOnExit];
     UnProceso.WindowTop:=250;
     UnProceso.WindowLeft:=400;
     UnProceso.WindowHeight:=250;
     UnProceso.WindowWidth:=650;
     UnProceso.StartupOptions:=[suoUsePosition];
     UnProceso.Execute;
     UnProceso.Free;
     dbmodule.pgcnx.Connected:=true;
     //CAMBIAR NOMBRE AL ESQUEMA EN LA BD
     dbmodule.sqlconsultas.SQL.Text:='alter schema public rename to '+editnshema.Text+'';
     dbmodule.SQLTransaction.Active:=False;
     dbmodule.SQLTransaction.StartTransaction;
     dbmodule.sqlconsultas.ExecSQL;
     dbmodule.SQLTransaction.Commit;

     //INGRESAR TITULO Y NOMBRE EN LA TABLA DE ESQUEMAS
     dbmodule.sqlconsultas.SQL.Text:='insert into tools.esquemas (id, nombre, esquema) values (default,'''+edittshema.Text+''','''+editnshema.Text+''')';
     dbmodule.SQLTransaction.Active:=False;
     dbmodule.SQLTransaction.StartTransaction;
     dbmodule.sqlconsultas.ExecSQL;
     dbmodule.SQLTransaction.Commit;

     MessageDlg('Se ha creado el esquema con exito',mtInformation,[mbOK],0);
       dbmodule.pgcnx.Connected:=false;
     except
       MessageDlg('Error al crear el esquema',mtError,[mbOK],0);
       dbmodule.pgcnx.Connected:=false;
     end;
   end
  else
    begin
      MessageDlg('No dejar campos  vacios',mtWarning,[mbOK],0);
    end;
end;

procedure Tvrestaurar.editnshemaKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['a'..'z','0'..'9','_',#7, #8, #13]) then
  begin
    Key := #0;
    Beep;
  end;
end;

procedure Tvrestaurar.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvrestaurar.listaresquemas();
var
  i:integer;
begin
  stgesquemas.Clean;
  stgesquemas.RowCount:=1;
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=True;
  try
    i:=1;
    dbmodule.sqlconsultas.SQL.Text:='select * from tools.esquemas order by fecha asc';
    dbmodule.SQLTransaction.Active:=false;
    dbmodule.SQLTransaction.StartTransaction;
    dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
      begin
        stgesquemas.RowCount:=stgesquemas.RowCount+1;
        stgesquemas.Cells[0,0]:='*';
        stgesquemas.Cells[0,i]:=IntToStr(i);
        stgesquemas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[0].Text;
        stgesquemas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
        stgesquemas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
        stgesquemas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
        i:=i+1;
        dbmodule.sqlconsultas.Next;
      end;
  except
     MessageDlg('Error al conectar con la BD',mtError,[mbOK],0);
  end;
  stgesquemas.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  dbmodule.pgcnx.Connected:=false;
end;

procedure Tvrestaurar.FormShow(Sender: TObject);
begin
  listaresquemas();
end;

procedure Tvrestaurar.stgesquemasSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  fila:=aRow;
end;

procedure Tvrestaurar.BitBtn2Click(Sender: TObject);
begin
  if abrirdir.Execute then
    begin
      editdirpg.Text:='';
      editdirpg.Text:=abrirdir.FileName;
      editdirpg.SetFocus;
    end;
end;

procedure Tvrestaurar.BitBtn5Click(Sender: TObject);
begin
  listaresquemas();
end;

procedure Tvrestaurar.btneditarClick(Sender: TObject);
var
  nombre:String;
  opcion:Boolean;
begin
  btneditar.Enabled:=true;
  opcion:=InputQuery('Cambiar nombre de esquema en sistema','Ingrese el nuevo nombre',False,nombre);
  if opcion=true then
    begin;
      dbmodule.pgcnx.Connected:=false;
      dbmodule.pgcnx.Connected:=true;
      if nombre<>'' then
        begin
          try
            dbmodule.sqlconsultas.SQL.Text:='update tools.esquemas set nombre='''+nombre+''' where id='''+stgesquemas.Cells[4,fila]+'''';
            dbmodule.SQLTransaction.Active:=false;
            dbmodule.SQLTransaction.StartTransaction;
            dbmodule.sqlconsultas.ExecSQL;
            dbmodule.SQLTransaction.Commit;
            MessageDlg('Actalización correcta',mtInformation,[mbOK],0);
          except
             MessageDlg('Error al modificar esquema',mtError,[mbOK],0);
             dbmodule.pgcnx.Connected:=false;
          end;
        end
      else
        begin
          MessageDlg('No debe dejar el campo vacio',mtWarning,[mbOK],0);
        end;
    end;
end;

procedure Tvrestaurar.btneliminarClick(Sender: TObject);
begin
  beep;
  if mrYes=MessageDlg('¿Esta seguro que desea elimina el esquema?',mtConfirmation,[mbYes,mbNo,mbCancel],0) then
    begin
      dbmodule.pgcnx.Connected:=false;
      dbmodule.pgcnx.Connected:=true;
      if mrOK=MessageDlg('¿El esquema "'+stgesquemas.Cells[2,fila]+'" se eliminara de la BD esta seguro?',mtWarning,[mbOK,mbCancel],0) then
        begin
          try
          //borrar de la tabla esquemas
          dbmodule.sqlconsultas.SQL.Text:='delete from tools.esquemas where id='''+stgesquemas.Cells[4,fila]+'''';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;

          //eliminar esquema
          dbmodule.sqlconsultas.SQL.Text:='drop schema '+stgesquemas.Cells[2,fila]+' cascade';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;

          MessageDlg('Se elimino el esquema correctamente',mtInformation,[mbOK],0);
          dbmodule.pgcnx.Connected:=false;
          except
             MessageDlg('Error al eliminar el esquema: '+stgesquemas.Cells[2,fila],mtError,[mbOK],0);
             dbmodule.pgcnx.Connected:=false;
          end;
        end;
    end;
end;

procedure Tvrestaurar.BitBtn1Click(Sender: TObject);
begin
  if abrirfile.Execute then
    begin
      editdir.Text:='';
      editdir.Text:=abrirfile.FileName;
      editdir.SetFocus;
    end;
end;

end.

