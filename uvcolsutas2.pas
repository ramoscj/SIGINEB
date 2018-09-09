unit uvcolsutas2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Grids, ExtCtrls, ComCtrls, Buttons, uvbd;

type

  { Tvconsultas2 }

  Tvconsultas2 = class(TForm)
    btnbuscar: TBitBtn;
    combobd: TComboBox;
    comboindice: TComboBox;
    editbuscar: TEdit;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    statusbar1: TStatusBar;
    statusmatri: TStatusBar;
    statusnecarti: TStatusBar;
    statusneceinfra: TStatusBar;
    statusneceperso: TStatusBar;
    statusppp: TStatusBar;
    stgmatricula: TStringGrid;
    stgnecarti: TStringGrid;
    stgneceinfra: TStringGrid;
    stgneceperso: TStringGrid;
    stgplanteles: TStringGrid;
    stgppp: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnbuscarClick(Sender: TObject);
    procedure combobdChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure consultaxcdgadm(columna: String);
    procedure datosextras();
    procedure selectschema();
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vconsultas2: Tvconsultas2;
  esquema: array [1..99999] of String;

implementation

{$R *.lfm}

{ Tvconsultas2 }

procedure Tvconsultas2.FormShow(Sender: TObject);
var
  i:integer;
begin
  //PARA SELECCIONAR LA BD
  i:=1;
  combobd.Items.Clear;
  combobd.AddItem(' ---SELECCIONE BD--- ',nil);
  combobd.ItemIndex:=0;
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  dbmodule.sqlconsultas.SQL.Text:='select * from tools.esquemas order by id asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          combobd.AddItem(dbmodule.sqlconsultas.Fields[1].Text,nil);
          esquema[i]:=dbmodule.sqlconsultas.Fields[2].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  dbmodule.sqlconsultas.Close;
  dbmodule.pgcnx.Connected:=false;
end;


procedure Tvconsultas2.selectschema();
begin
 dbmodule.pgcnx.Connected:=true;
 try
   dbmodule.sqlconsultas.SQL.Text:='alter user postgres set search_path to '+esquema[combobd.ItemIndex]+'';
   dbmodule.SQLTransaction.Active:=false;
   dbmodule.SQLTransaction.StartTransaction;
   dbmodule.sqlconsultas.ExecSQL;
   dbmodule.SQLTransaction.Commit;
   except
     MessageDlg('Error al seleccionar esquema',mtError,[mbOK],0);
     dbmodule.pgcnx.Connected:=False;
   end;
 dbmodule.pgcnx.Connected:=False;
end;

procedure Tvconsultas2.btnbuscarClick(Sender: TObject);
begin
  if editbuscar.Text<>'' then
  begin
    if comboindice.ItemIndex=1 then
      begin
        consultaxcdgadm('cod_administrativo');
      end;
    if comboindice.ItemIndex=2 then
      begin
        consultaxcdgadm('cod_estadistico');
      end;
  end
else
  begin
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;

procedure Tvconsultas2.BitBtn1Click(Sender: TObject);
begin

end;

procedure Tvconsultas2.combobdChange(Sender: TObject);
begin
  statusbar1.Panels[3].Text:=combobd.Text;
  try
    dbmodule.pgcnx.Connected:=true;
    statusbar1.Panels[5].Text:='[+] OnLine';
    GroupBox1.Enabled:=true;
    dbmodule.pgcnx.Connected:=false;
  except
    statusbar1.Panels[5].Text:='[-] OffLine';
    GroupBox1.Enabled:=false;
    editbuscar.Text:='';
    Panel2.Enabled:=False;
    stgmatricula.RowCount:=0;
    stgmatricula.Clean;
    stgppp.RowCount:=0;
    stgppp.Clean;
    stgneceperso.RowCount:=0;
    stgneceperso.Clean;
    stgnecarti.RowCount:=0;
    stgnecarti.Clean;
    stgneceinfra.RowCount:=0;
    stgneceinfra.Clean;

  end;
end;

procedure Tvconsultas2.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvconsultas2.FormCreate(Sender: TObject);
begin
  stgplanteles.AutoSizeColumns;
  stgmatricula.AutoSizeColumns;
end;

//TRAER LOS DATOS DE LOS PLANTELES
procedure Tvconsultas2.consultaxcdgadm(columna: String);
var
  i,j:integer;
  codest: array [1..9999] of String;
  x:String;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgplanteles.RowCount:=1;
  stgplanteles.Clean;
  try
  i:=1;
  //planteles
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.planteles where '+columna+'='''+editbuscar.Text+''' order by municipio asc, dependencia asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgplanteles.RowCount:=stgplanteles.RowCount+1;
          stgplanteles.Cells[0,i]:=IntToStr(i);
          stgplanteles.Cells[1,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgplanteles.Cells[2,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          stgplanteles.Cells[3,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgplanteles.Cells[4,i]:=dbmodule.sqlconsultas.Fields[5].Text;
          stgplanteles.Cells[5,i]:=dbmodule.sqlconsultas.Fields[8].Text;
          stgplanteles.Cells[6,i]:=dbmodule.sqlconsultas.Fields[9].Text;
          stgplanteles.Cells[7,i]:=dbmodule.sqlconsultas.Fields[6].Text;
          stgplanteles.Cells[8,i]:=dbmodule.sqlconsultas.Fields[7].Text;
          stgplanteles.Cells[9,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  stgplanteles.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS 1 DE PLANTEL
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_plantel';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgplanteles.RowCount-1) do
          begin
          //PARA BUSCAR CODEST QUE PERTENECE
            if stgplanteles.Cells[9,j]=dbmodule.sqlconsultas.Fields[1].Text then
              begin
                stgplanteles.Cells[10,j]:=dbmodule.sqlconsultas.Fields[2].AsString;
                stgplanteles.Cells[11,j]:=dbmodule.sqlconsultas.Fields[3].AsString;
                stgplanteles.Cells[12,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgplanteles.Cells[13,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgplanteles.Cells[14,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgplanteles.Cells[15,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgplanteles.Cells[16,j]:=dbmodule.sqlconsultas.Fields[8].Text;
                stgplanteles.Cells[17,j]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgplanteles.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS 2 DE PLANTEL
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos2_plantel';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgplanteles.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if stgplanteles.Cells[9,j]=dbmodule.sqlconsultas.Fields[1].Text then
              begin
                stgplanteles.Cells[18,j]:=dbmodule.sqlconsultas.Fields[2].AsString;
                stgplanteles.Cells[19,j]:=dbmodule.sqlconsultas.Fields[3].AsString;
                stgplanteles.Cells[20,j]:=dbmodule.sqlconsultas.Fields[4].AsString;
                stgplanteles.Cells[21,j]:=dbmodule.sqlconsultas.Fields[5].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgplanteles.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  dbmodule.pgcnx.Connected:=false;
  datosextras();
  statusbar1.Panels[1].Text:=IntToStr(i-1)+' Fila(s)';
  except
    MessageDlg('Error al buscar datos, verifique que los parametros de busqueda sean correctos',mtWarning,[mbOK],0);
    editbuscar.SetFocus;
  end;
end;


procedure Tvconsultas2.datosextras();
var
  j,i,matriculam,matriculaf,total,pf,pnf:Integer;
  doc,adm,obr,totalperso:integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgmatricula.RowCount:=1;
  stgmatricula.Clean;
  stgppp.RowCount:=1;
  stgppp.Clean;
  stgneceperso.RowCount:=1;
  stgneceperso.Clean;
  stgnecarti.RowCount:=1;
  stgnecarti.Clean;
  stgneceinfra.RowCount:=1;
  stgneceinfra.Clean;
  i:=1;
  matriculam:=0;
  matriculaf:=0;
  total:=0;
  pf:=0;
  pnf:=0;
  doc:=0;
  adm:=0;
  obr:=0;
  totalperso:=0;
  try
    //MATRICULA
    for j:=1 to (stgplanteles.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.matricula where cod_estadistico='''+stgplanteles.Cells[9,j]+'''';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            stgmatricula.RowCount:=stgmatricula.RowCount+1;
            stgmatricula.Cells[0,i]:=stgplanteles.Cells[0,j];
            stgmatricula.Cells[1,i]:=stgplanteles.Cells[3,j];
            stgmatricula.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
            stgmatricula.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
            stgmatricula.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].Text;
            stgmatricula.Cells[5,i]:=dbmodule.sqlconsultas.Fields[5].Text;
            stgmatricula.Cells[6,i]:=dbmodule.sqlconsultas.Fields[6].Text;
            stgmatricula.Cells[7,i]:=dbmodule.sqlconsultas.Fields[7].Text;
            i:=i+1;
            dbmodule.sqlconsultas.Next;
          end;
     end;
     for j:=1 to (stgmatricula.RowCount-1) do
     begin
       matriculam:=matriculam+StrToInt(stgmatricula.Cells[2,j]);
       matriculaf:=matriculaf+StrToInt(stgmatricula.Cells[3,j]);
     end;
     statusmatri.Panels[1].Text:=IntToStr(matriculam);
     statusmatri.Panels[3].Text:=IntToStr(matriculaf);
     total:=matriculaf+matriculam;
     statusmatri.Panels[5].Text:=IntToStr(total);
     stgmatricula.AutoSizeColumns;

    //PLANES PROYECTOS Y PROGRAMAS
    i:=1;
    for j:=1 to (stgplanteles.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_ppp where cod_estadistico='''+stgplanteles.Cells[9,j]+'''';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            stgppp.RowCount:=stgppp.RowCount+1;
            stgppp.Cells[0,i]:=stgplanteles.Cells[0,j];
            stgppp.Cells[1,i]:=stgplanteles.Cells[3,j];
            stgppp.Cells[2,i]:=dbmodule.sqlconsultas.Fields[1].Text;
            stgppp.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
            stgppp.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].Text;
            i:=i+1;
            if dbmodule.sqlconsultas.Fields[4].Text='SI' then
             begin
               pf:=pf+1;
             end
            else
              begin
                pnf:=pnf+1;
              end;
            dbmodule.sqlconsultas.Next;
          end;
     end;
    stgppp.AutoSizeColumns;
    statusppp.Panels[1].Text:=IntToStr(pf);
    statusppp.Panels[3].Text:=IntToStr(pnf);
    statusppp.Panels[5].Text:=IntToStr(stgppp.RowCount-1);

    //NECESIDAD DE PERSONAL
    i:=1;
    for j:=1 to (stgplanteles.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_necperso where id_ctl=id_necs and cod_estadistico='''+stgplanteles.Cells[9,j]+'''';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            stgneceperso.RowCount:=stgneceperso.RowCount+1;
            stgneceperso.Cells[0,i]:=stgplanteles.Cells[0,j];
            stgneceperso.Cells[1,i]:=stgplanteles.Cells[3,j];
            stgneceperso.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
            stgneceperso.Cells[3,i]:=dbmodule.sqlconsultas.Fields[5].Text;
            stgneceperso.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].AsString;
            i:=i+1;
            if dbmodule.sqlconsultas.Fields[1].AsInteger=0 then
               begin
                 adm:=adm+1;
               end;
            if dbmodule.sqlconsultas.Fields[1].AsInteger=2 then
               begin
                 doc:=doc+1;
               end;
            if dbmodule.sqlconsultas.Fields[1].AsInteger=1 then
               begin
                 obr:=obr+1;
               end;
            dbmodule.sqlconsultas.Next;
          end;
     end;
     stgneceperso.AutoSizeColumns;
     totalperso:=adm+doc+obr;
     statusneceperso.Panels[1].Text:=IntToStr(doc);
     statusneceperso.Panels[3].Text:=IntToStr(adm);
     statusneceperso.Panels[5].Text:=IntToStr(obr);
     statusneceperso.Panels[7].Text:=IntToStr(totalperso)+' Recursos';

     //NECESIDAD DE ARTICULOS
    i:=1;
    statusnecarti.Panels[2].Text:='NO';
    statusnecarti.Panels[4].Text:='NO';
    statusnecarti.Panels[6].Text:='NO';
    statusnecarti.Panels[8].Text:='NO';
    for j:=1 to (stgplanteles.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_necarti where id_ctl=id_necs and cod_estadistico='''+stgplanteles.Cells[9,j]+'''';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            stgnecarti.RowCount:=stgnecarti.RowCount+1;
            stgnecarti.Cells[0,i]:=stgplanteles.Cells[0,j];
            stgnecarti.Cells[1,i]:=stgplanteles.Cells[3,j];
            stgnecarti.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
            stgnecarti.Cells[3,i]:=dbmodule.sqlconsultas.Fields[4].AsString;
            i:=i+1;
            if dbmodule.sqlconsultas.Fields[3].AsInteger=7 then
               begin
                 statusnecarti.Panels[2].Text:='SI';
               end;
            if dbmodule.sqlconsultas.Fields[3].AsInteger=8 then
               begin
                 statusnecarti.Panels[4].Text:='SI';
               end;
            if dbmodule.sqlconsultas.Fields[3].AsInteger=10 then
               begin
                 statusnecarti.Panels[6].Text:='SI';
               end;
            if dbmodule.sqlconsultas.Fields[3].AsInteger=11 then
               begin
                 statusnecarti.Panels[8].Text:='SI';
               end;
            dbmodule.sqlconsultas.Next;
          end;
     end;
     stgnecarti.AutoSizeColumns;

    //NECESIDAD DE INSFRAESTRUCTURA
    i:=1;
    statusneceinfra.Panels[2].Text:='NO';
    statusneceinfra.Panels[4].Text:='NO';
    statusneceinfra.Panels[6].Text:='NO';
    for j:=1 to (stgplanteles.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_necinfra where id_ctl=id_necs and cod_estadistico='''+stgplanteles.Cells[9,j]+''' and cod_estp='''+stgplanteles.Cells[9,j]+'''';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            stgneceinfra.RowCount:=stgneceinfra.RowCount+1;
            stgneceinfra.Cells[0,i]:=stgplanteles.Cells[0,j];
            stgneceinfra.Cells[1,i]:=stgplanteles.Cells[3,j];
            stgneceinfra.Cells[2,i]:=dbmodule.sqlconsultas.Fields[8].Text;
            stgneceinfra.Cells[3,i]:=dbmodule.sqlconsultas.Fields[11].Text;
            stgneceinfra.Cells[4,i]:=dbmodule.sqlconsultas.Fields[13].Text;
            stgneceinfra.Cells[5,i]:=dbmodule.sqlconsultas.Fields[10].AsString;
            i:=i+1;
            if dbmodule.sqlconsultas.Fields[9].AsInteger=4 then
               begin
                 statusneceinfra.Panels[2].Text:='SI';
               end;
            if dbmodule.sqlconsultas.Fields[9].AsInteger=5 then
               begin
                 statusneceinfra.Panels[4].Text:='SI';
               end;
            if dbmodule.sqlconsultas.Fields[9].AsInteger=6 then
               begin
                 statusneceinfra.Panels[6].Text:='SI';
               end;
            dbmodule.sqlconsultas.Next;
          end;
     end;
    stgneceinfra.AutoSizeColumns;
    Panel2.Enabled:=true;
  except
     MessageDlg('Error al buscar datos',mtError,[mbOK],0);
     Panel2.Enabled:=true;
  end;
  dbmodule.pgcnx.Connected:=false;
end;

end.

