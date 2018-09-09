unit uvusuarios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  ComCtrls, StdCtrls, ExtCtrls, uvbd, uvadduser, uvupdateuser;

type

  { Tvusuarios }

  Tvusuarios = class(TForm)
    ImageList1: TImageList;
    Label1: TLabel;
    Panel1: TPanel;
    stgusuarios: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormShow(Sender: TObject);
    procedure stgusuariosSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure listarusuarios();
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vusuarios: Tvusuarios;
  vadduser:Tvadduser;
  vupdateuser:Tvupdateuser;
  fila:Integer;

implementation

{$R *.lfm}

{ Tvusuarios }

procedure Tvusuarios.listarusuarios();
var
  i:integer;
begin
  stgusuarios.Clean;
  stgusuarios.RowCount:=1;
  i:=1;
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
  dbmodule.sqlconsultas.SQL.Text:='select * from tools.usuarios order by nivel asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgusuarios.RowCount:=stgusuarios.RowCount+1;
          stgusuarios.Cells[0,0]:='*';
          stgusuarios.Cells[0,i]:=IntToStr(i);
          stgusuarios.Cells[4,i]:=dbmodule.sqlconsultas.Fields[0].Text;
          stgusuarios.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          stgusuarios.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgusuarios.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgusuarios.Cells[5,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          stgusuarios.Cells[6,i]:=dbmodule.sqlconsultas.Fields[5].Text;
          dbmodule.sqlconsultas.Next;
          i:=i+1;
       end;

  except
    MessageDlg('Error al conectar con la BD',mtError,[mbOK],0);
  end;
  stgusuarios.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  dbmodule.pgcnx.Connected:=false;
end;

procedure Tvusuarios.ToolButton6Click(Sender: TObject);
begin
   dbmodule.pgcnx.Connected:=false;
   dbmodule.pgcnx.Connected:=true;
    try
      Beep;
      if mrYes=MessageDlg('Desea eliminar el usuario de: '+stgusuarios.Cells[1,fila]+' recuerde que no podra desacer los cambios',mtConfirmation,[mbYes,mbNo],0) then
        begin
          dbmodule.sqlconsultas.SQL.Text:='delete from usuarios where id_usuario='''+stgusuarios.Cells[4,fila]+'''';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
          MessageDlg('Se elimino el usuario: '+stgusuarios.Cells[1,fila],mtInformation,[mbOK],0);
          listarusuarios();
        end;
      dbmodule.pgcnx.Connected:=false;
    except
      MessageDlg('Error al eliminar',mtError,[mbOK],0);
      dbmodule.pgcnx.Connected:=false;
    end;
end;

procedure Tvusuarios.ToolButton8Click(Sender: TObject);
begin
  listarusuarios();
end;

procedure Tvusuarios.FormShow(Sender: TObject);
begin
   listarusuarios();
end;

procedure Tvusuarios.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvusuarios.stgusuariosSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  fila:=aRow;
end;

procedure Tvusuarios.ToolButton1Click(Sender: TObject);
begin
  vadduser:=Tvadduser.Create(Self);
  vadduser.ShowModal;
end;

procedure Tvusuarios.ToolButton4Click(Sender: TObject);
begin
  vupdateuser:=Tvupdateuser.Create(Self);
  uvupdateuser.nivel:=StrToInt(stgusuarios.Cells[4,fila]);
  vupdateuser.editnombre.Text:=stgusuarios.Cells[1,fila];
  vupdateuser.combolvl.ItemIndex:=StrToInt(stgusuarios.Cells[3,fila]);
  vupdateuser.combopregunta.Items.Add(stgusuarios.Cells[5,fila]);
  vupdateuser.editrespuesta.Text:=stgusuarios.Cells[6,fila];
  vupdateuser.ShowModal;
end;

end.

