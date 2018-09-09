unit uvconsultas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, Forms, Controls, Graphics,
  Dialogs, Grids, ExtCtrls, StdCtrls, Buttons, ComCtrls, Menus, uvbd, LR_DSet,
  XMLRead, XMLWrite, DOM;

type

  { Tvconsultas }

  Tvconsultas = class(TForm)
    btnxml: TBitBtn;
    btnbuscar: TBitBtn;
    btnbuscar2: TBitBtn;
    combobd: TComboBox;
    comboindice: TComboBox;
    comboindice2: TComboBox;
    editbuscar: TEdit;
    editbuscar2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    guardarxml: TSaveDialog;
    segundo: TPopupMenu;
    statusbar1: TStatusBar;
    statusbar2: TStatusBar;
    stgpersonal1: TStringGrid;
    stgpersonal2: TStringGrid;
    procedure btnxmlClick(Sender: TObject);
    procedure btnbuscar2Click(Sender: TObject);
    procedure btnbuscarClick(Sender: TObject);
    procedure combobdChange(Sender: TObject);
    procedure comboindice2Change(Sender: TObject);
    procedure comboindiceChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure buscarxcodadm(columna: String);
    procedure buscarxlike(columna: String);
    procedure buscarxcodadm2(columna: String);
    procedure buscarxlike2(columna: String);
    procedure buscardatosgenerales1();
    procedure buscardatosgenerales2();
    procedure MenuItem2Click(Sender: TObject);
    procedure segundoPopup(Sender: TObject);
    procedure selectschema();
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vconsultas: Tvconsultas;
  esquema: array [1..99999] of String;
  frow:LongInt;

implementation

{$R *.lfm}

{ Tvconsultas }

procedure Tvconsultas.FormCreate(Sender: TObject);
var
  i:integer;
begin

 //PARA SELECCIONAR LA BD
 i:=1;
  combobd.Items.Clear;
  combobd.AddItem(' ---SELECCIONE BD--- ',nil);
  combobd.ItemIndex:=0;
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
end;

procedure Tvconsultas.btnbuscarClick(Sender: TObject);
begin

if editbuscar.Text<>'' then
  begin

    if comboindice.ItemIndex=1 then
      begin
        buscarxcodadm('cod_administrativo');
      end;
    if comboindice.ItemIndex=2 then
      begin
        buscarxcodadm('cedula');
      end;
    if comboindice.ItemIndex=3 then
      begin
        buscarxlike('tipo');
      end;
    if comboindice.ItemIndex=4 then
      begin
        buscarxlike('nombre');
      end;
    if comboindice.ItemIndex=5 then
     begin
       buscardatosgenerales1();
     end;
  end
else
  begin
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;

procedure Tvconsultas.combobdChange(Sender: TObject);
begin
  statusbar1.Panels[5].Text:=combobd.Text;
  statusbar2.Panels[5].Text:=combobd.Text;
  try
    dbmodule.pgcnx.Connected:=true;
    statusbar1.Panels[7].Text:='[+] OnLine';
    statusbar2.Panels[7].Text:='[+] OnLine';
    GroupBox1.Enabled:=true;
    GroupBox2.Enabled:=true;
    dbmodule.pgcnx.Connected:=false;
  except
    statusbar1.Panels[7].Text:='[-] OffLine';
    statusbar2.Panels[7].Text:='[-] OffLine';
    GroupBox1.Enabled:=false;
    GroupBox2.Enabled:=false;
    stgpersonal1.RowCount:=1;
    stgpersonal1.Clean;
    stgpersonal2.RowCount:=1;
    comboindice.ItemIndex:=0;
    comboindice2.ItemIndex:=0;
    editbuscar.Text:='';
    editbuscar2.Text:='';
  end;
end;

procedure Tvconsultas.comboindice2Change(Sender: TObject);
begin
    if comboindice2.ItemIndex=3 then
    begin
      editbuscar2.Text:='Nómina general';
    end;
end;

procedure Tvconsultas.comboindiceChange(Sender: TObject);
begin
  if comboindice.ItemIndex=5 then
    begin
      editbuscar.Text:='Nómina general';
    end;
end;

procedure Tvconsultas.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvconsultas.btnbuscar2Click(Sender: TObject);
begin
  if editbuscar2.Text<>'' then
  begin

    if comboindice2.ItemIndex=1 then
      begin
        buscarxcodadm2('cedula');
      end;
    if comboindice2.ItemIndex=2 then
      begin
        buscarxlike2('nombre');
      end;
    if comboindice2.ItemIndex=3 then
      begin
        buscardatosgenerales2();
      end;
  end
else
  MessageDlg('Error al buscar datos',mtError,[mbOK],0);
end;

procedure Tvconsultas.btnxmlClick(Sender: TObject);
var
   Doc: TXMLDocument;
   RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
   i,j,control,control2: integer;
   nombrenodo:Array[0..50] of String;
 begin

 //NOMBRE DE LOS NODOS HIJOS
  nombrenodo[1]:='cedula';
  nombrenodo[2]:='nombre_apellido';
  nombrenodo[3]:='desc_dependencia';
  nombrenodo[4]:='cod_depen';
  nombrenodo[5]:='cod_cargo';
  nombrenodo[6]:='desc_cargo';
    if guardarxml.Execute then
      begin
       try
         // Crear el documento
         Doc := TXMLDocument.Create;
         // Crear el nodo raiz
         RootNode := Doc.CreateElement('nomina');
         Doc.Appendchild(RootNode);
         RootNode:= Doc.DocumentElement;
         control:=stgpersonal1.RowCount;
         control2:=7;
         // Crear los nodos
             for i := 1 to (control-2) do
               begin
                  if AnsiPos('DOCENTE',stgpersonal1.Cells[9,i]) or AnsiPos('PROF',stgpersonal1.Cells[9,i])<>0 then
                   begin
                     ElementNode:=Doc.CreateElement('recurso');
                      for j:=1 to (control2-1) do
                        begin
                             ItemNode:=Doc.CreateElement(nombrenodo[j]);
                             TextNode:=Doc.CreateTextNode(stgpersonal1.Cells[j,i]);
                             ItemNode.AppendChild(TextNode);
                             ElementNode.AppendChild(ItemNode);
                        end;
                     RootNode.AppendChild(ElementNode);

                   end;
               end;
           // Guardar el XML
           WriteXMLFile(Doc,guardarxml.FileName);
           Doc.Free;
           MessageDlg('Se ga guardado el archivo',mtInformation,[mbOK],0);
         Except
         MessageDlg('Error al guardar archivo', mtError,[mbOK],0);
         end;
      end;
end;


procedure Tvconsultas.selectschema();
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


procedure Tvconsultas.buscarxcodadm(columna: String);
var
  i,j:integer;
  id: array [1..99999] of String;
  x:String;
begin
  stgpersonal1.Clean;
  stgpersonal1.RowCount:=2;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
 try
  //TABLA DE PERSONAL 1
  i:=1;
  //nomina_general
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.nomina_general where '+columna+'='''+editbuscar.Text+''' order by cedula asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgpersonal1.RowCount:=stgpersonal1.RowCount+1;
          stgpersonal1.Cells[0,i]:=IntToStr(i);
          id[i]:=dbmodule.sqlconsultas.Fields[0].Text;
          //stgpersonal1.Cells[0,i]:=dbmodule.sqlconsultas.Fields[0].Text;
          stgpersonal1.Cells[1,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgpersonal1.Cells[2,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          stgpersonal1.Cells[3,i]:=dbmodule.sqlconsultas.Fields[11].Text;
          stgpersonal1.Cells[4,i]:=dbmodule.sqlconsultas.Fields[10].Text;
          stgpersonal1.Cells[5,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgpersonal1.Cells[6,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          //FORMATEAR PARA QUE TENGA 2 DECIMALES
          stgpersonal1.Cells[7,i]:=FormatFloat('0.00',StrToFloat(dbmodule.sqlconsultas.Fields[5].Text));
          stgpersonal1.Cells[8,i]:=dbmodule.sqlconsultas.Fields[6].Text;
          stgpersonal1.Cells[9,i]:=dbmodule.sqlconsultas.Fields[7].Text;
          stgpersonal1.Cells[10,i]:=dbmodule.sqlconsultas.Fields[8].Text;
          stgpersonal1.Cells[11,i]:=dbmodule.sqlconsultas.Fields[9].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS DOCENTES
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_docente';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal1.Cells[12,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[13,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal1.Cells[14,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal1.Cells[15,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal1.Cells[16,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal1.Cells[17,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal1.Cells[18,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal1.Cells[19,j]:=dbmodule.sqlconsultas.Fields[8].Text;
                stgpersonal1.Cells[20,j]:=dbmodule.sqlconsultas.Fields[9].Text;
                stgpersonal1.Cells[21,j]:=dbmodule.sqlconsultas.Fields[10].Text;
                stgpersonal1.Cells[22,j]:=dbmodule.sqlconsultas.Fields[11].Text;
                stgpersonal1.Cells[23,j]:=dbmodule.sqlconsultas.Fields[12].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS ADM Y OBR
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_adm_obr';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          x:=dbmodule.sqlconsultas.Fields[0].Text;
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal1.Cells[12,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[13,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal1.Cells[14,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal1.Cells[15,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal1.Cells[16,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal1.Cells[17,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal1.Cells[18,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal1.Cells[19,j]:=dbmodule.sqlconsultas.Fields[8].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE ESTUDIO
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.instruc_personal';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[2].Text then
              begin
                stgpersonal1.Cells[24,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[25,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                //CAMPO TIPO TEXT
                stgpersonal1.Cells[26,j]:=dbmodule.sqlconsultas.Fields[4].AsString;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  statusbar1.Panels[1].Text:=IntToStr(i-1)+' Fila(s)';
  statusbar1.Panels[3].Text:=comboindice.Text;
  dbmodule.pgcnx.Connected:=false;
 except
   MessageDlg('Error al buscar datos',mtError,[mbOK],0);
 end;
 if stgpersonal1.Cells[1,1]='' then
   begin
     MessageDlg('No se encontraron registros con esas espesificaciones',mtInformation,[mbOK],0);
     statusbar1.Panels[1].Text:='0 Filas';
   end;
end;

procedure Tvconsultas.buscarxlike(columna: String);
var
  i,j:integer;
  id: array [1..99999] of String;
  x:String;
begin
  stgpersonal1.Clean;
  stgpersonal1.RowCount:=2;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
 try
  //TABLA DE PERSONAL 1
  i:=1;
  //nomina_general
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.nomina_general where '+columna+' like ''%'+editbuscar.Text+'%'' order by descp_depen asc, cedula asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgpersonal1.RowCount:=stgpersonal1.RowCount+1;
          stgpersonal1.Cells[0,i]:=IntToStr(i);
          id[i]:=dbmodule.sqlconsultas.Fields[0].Text;
          //stgpersonal1.Cells[0,i]:=dbmodule.sqlconsultas.Fields[0].Text;
          stgpersonal1.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          stgpersonal1.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgpersonal1.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgpersonal1.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          //FORMATEAR PARA QUE TENGA 2 DECIMALES
          stgpersonal1.Cells[5,i]:=FormatFloat('0.00',StrToFloat(dbmodule.sqlconsultas.Fields[5].Text));
          stgpersonal1.Cells[6,i]:=dbmodule.sqlconsultas.Fields[6].Text;
          stgpersonal1.Cells[7,i]:=dbmodule.sqlconsultas.Fields[7].Text;
          stgpersonal1.Cells[8,i]:=dbmodule.sqlconsultas.Fields[8].Text;
          stgpersonal1.Cells[9,i]:=dbmodule.sqlconsultas.Fields[9].Text;
          stgpersonal1.Cells[10,i]:=dbmodule.sqlconsultas.Fields[10].Text;
          stgpersonal1.Cells[11,i]:=dbmodule.sqlconsultas.Fields[11].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS DOCENTES
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_docente';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal1.Cells[12,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[13,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal1.Cells[14,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal1.Cells[15,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal1.Cells[16,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal1.Cells[17,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal1.Cells[18,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal1.Cells[19,j]:=dbmodule.sqlconsultas.Fields[8].Text;
                stgpersonal1.Cells[20,j]:=dbmodule.sqlconsultas.Fields[9].Text;
                stgpersonal1.Cells[21,j]:=dbmodule.sqlconsultas.Fields[10].Text;
                stgpersonal1.Cells[22,j]:=dbmodule.sqlconsultas.Fields[11].Text;
                stgpersonal1.Cells[23,j]:=dbmodule.sqlconsultas.Fields[12].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS ADM Y OBR
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_adm_obr';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          x:=dbmodule.sqlconsultas.Fields[0].Text;
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal1.Cells[12,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[13,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal1.Cells[14,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal1.Cells[15,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal1.Cells[16,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal1.Cells[17,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal1.Cells[18,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal1.Cells[19,j]:=dbmodule.sqlconsultas.Fields[8].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE ESTUDIO
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.instruc_personal';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[2].Text then
              begin
                stgpersonal1.Cells[24,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[25,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                //CAMPO TIPO TEXT
                stgpersonal1.Cells[26,j]:=dbmodule.sqlconsultas.Fields[4].AsString;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  statusbar1.Panels[1].Text:=IntToStr(i-1)+' Fila(s)';
  statusbar1.Panels[3].Text:=comboindice.Text;
  dbmodule.pgcnx.Connected:=false;
 except
   MessageDlg('Error al buscar datos',mtError,[mbOK],0);
 end;
 if stgpersonal1.Cells[1,1]='' then
   begin
     MessageDlg('No se encontraron registros con esas espesificaciones',mtInformation,[mbOK],0);
     statusbar1.Panels[1].Text:='0 Filas';
   end;
end;


procedure Tvconsultas.buscarxcodadm2(columna: String);
var
  i,j:integer;
  id2: array [1..99999] of String;
  y:String;
begin
  stgpersonal2.Clean;
  stgpersonal2.RowCount:=2;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
 try
  //TABLA DE PERSONAL 2
  i:=1;
  //nomina_general
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.nomina_general2 where '+columna+'='''+editbuscar2.Text+'''';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgpersonal2.RowCount:=stgpersonal2.RowCount+1;
          stgpersonal2.Cells[0,i]:=IntToStr(i);
          id2[i]:=dbmodule.sqlconsultas.Fields[0].Text;
          //stgpersonal1.Cells[0,i]:=dbmodule.sqlconsultas.Fields[0].Text;
          stgpersonal2.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          stgpersonal2.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgpersonal2.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgpersonal2.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          stgpersonal2.Cells[5,i]:=dbmodule.sqlconsultas.Fields[5].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS DOCENTES
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_docente2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal2.Cells[6,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[7,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal2.Cells[8,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal2.Cells[9,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal2.Cells[10,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal2.Cells[11,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal2.Cells[12,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal2.Cells[13,j]:=dbmodule.sqlconsultas.Fields[8].Text;
                stgpersonal2.Cells[14,j]:=dbmodule.sqlconsultas.Fields[9].Text;
                stgpersonal2.Cells[15,j]:=dbmodule.sqlconsultas.Fields[10].Text;
                stgpersonal2.Cells[16,j]:=dbmodule.sqlconsultas.Fields[11].Text;
                stgpersonal2.Cells[17,j]:=dbmodule.sqlconsultas.Fields[12].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS ADM Y OBR
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_adm_obr2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          y:=dbmodule.sqlconsultas.Fields[0].Text;
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal2.Cells[6,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[7,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal2.Cells[8,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal2.Cells[9,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal2.Cells[10,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal2.Cells[11,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal2.Cells[12,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal2.Cells[13,j]:=dbmodule.sqlconsultas.Fields[8].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE ESTUDIO
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.instruc_personal2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[2].Text then
              begin
                stgpersonal2.Cells[18,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[19,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                //CAMPO TIPO TEXT
                stgpersonal2.Cells[20,j]:=dbmodule.sqlconsultas.Fields[4].AsString;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  statusbar2.Panels[1].Text:=IntToStr(i-1)+' Fila(s)';
  statusbar2.Panels[3].Text:=comboindice2.Text;
  dbmodule.pgcnx.Connected:=false;
 except
   MessageDlg('Error al buscar datos',mtError,[mbOK],0);
 end;
 if stgpersonal2.Cells[1,1]='' then
   begin
     MessageDlg('No se encontraron registros con esas espesificaciones',mtInformation,[mbOK],0);
     statusbar2.Panels[1].Text:='0 Filas';
   end;

end;

procedure Tvconsultas.buscarxlike2(columna: String);
var
  i,j:integer;
  id2: array [1..99999] of String;
  y:String;
begin
 stgpersonal2.Clean;
 stgpersonal2.RowCount:=2;
 selectschema();
 dbmodule.pgcnx.Connected:=false;
 dbmodule.pgcnx.Connected:=true;
 try
  //TABLA DE PERSONAL 2
  i:=1;
  //nomina_general
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.nomina_general2 where '+columna+' like ''%'+editbuscar2.Text+'%''order by cedula asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgpersonal2.RowCount:=stgpersonal2.RowCount+1;
          stgpersonal2.Cells[0,i]:=IntToStr(i);
          id2[i]:=dbmodule.sqlconsultas.Fields[0].Text;
          //stgpersonal1.Cells[0,i]:=dbmodule.sqlconsultas.Fields[0].Text;
          stgpersonal2.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          stgpersonal2.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgpersonal2.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgpersonal2.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          stgpersonal2.Cells[5,i]:=dbmodule.sqlconsultas.Fields[5].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS DOCENTES
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_docente2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal2.Cells[6,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[7,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal2.Cells[8,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal2.Cells[9,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal2.Cells[10,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal2.Cells[11,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal2.Cells[12,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal2.Cells[13,j]:=dbmodule.sqlconsultas.Fields[8].Text;
                stgpersonal2.Cells[14,j]:=dbmodule.sqlconsultas.Fields[9].Text;
                stgpersonal2.Cells[15,j]:=dbmodule.sqlconsultas.Fields[10].Text;
                stgpersonal2.Cells[16,j]:=dbmodule.sqlconsultas.Fields[11].Text;
                stgpersonal2.Cells[17,j]:=dbmodule.sqlconsultas.Fields[12].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS ADM Y OBR
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_adm_obr2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          y:=dbmodule.sqlconsultas.Fields[0].Text;
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal2.Cells[6,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[7,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal2.Cells[8,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal2.Cells[9,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal2.Cells[10,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal2.Cells[11,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal2.Cells[12,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal2.Cells[13,j]:=dbmodule.sqlconsultas.Fields[8].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE ESTUDIO
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.instruc_personal2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[2].Text then
              begin
                stgpersonal2.Cells[18,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[19,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                //CAMPO TIPO TEXT
                stgpersonal2.Cells[20,j]:=dbmodule.sqlconsultas.Fields[4].AsString;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  statusbar2.Panels[1].Text:=IntToStr(i-1)+' Fila(s)';
  statusbar2.Panels[3].Text:=comboindice2.Text;
  dbmodule.pgcnx.Connected:=false;
  except
   MessageDlg('Error al buscar datos',mtError,[mbOK],0);
 end;
 if stgpersonal2.Cells[1,1]='' then
   begin
     MessageDlg('No se encontraron registros con esas espesificaciones',mtInformation,[mbOK],0);
     statusbar2.Panels[1].Text:='0 Filas';
   end;
end;

procedure Tvconsultas.buscardatosgenerales1();
var
  i,j:integer;
  id: array [1..99999] of String;
  x:String;
begin
  stgpersonal1.Clean;
  stgpersonal1.RowCount:=2;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  //TABLA DE PERSONAL 1
  i:=1;
try
  //nomina_general
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.nomina_general order by cod_administrativo,cedula asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgpersonal1.RowCount:=stgpersonal1.RowCount+1;
          stgpersonal1.Cells[0,i]:=IntToStr(i);
          id[i]:=dbmodule.sqlconsultas.Fields[0].Text;
          //stgpersonal1.Cells[0,i]:=dbmodule.sqlconsultas.Fields[0].Text;
          stgpersonal1.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          stgpersonal1.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgpersonal1.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgpersonal1.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          stgpersonal1.Cells[5,i]:=dbmodule.sqlconsultas.Fields[5].Text;
          stgpersonal1.Cells[6,i]:=dbmodule.sqlconsultas.Fields[6].Text;
          stgpersonal1.Cells[7,i]:=dbmodule.sqlconsultas.Fields[7].Text;
          stgpersonal1.Cells[8,i]:=dbmodule.sqlconsultas.Fields[8].Text;
          stgpersonal1.Cells[9,i]:=dbmodule.sqlconsultas.Fields[9].Text;
          stgpersonal1.Cells[10,i]:=dbmodule.sqlconsultas.Fields[10].Text;
          stgpersonal1.Cells[11,i]:=dbmodule.sqlconsultas.Fields[11].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS DOCENTES
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_docente';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal1.Cells[12,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[13,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal1.Cells[14,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal1.Cells[15,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal1.Cells[16,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal1.Cells[17,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal1.Cells[18,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal1.Cells[19,j]:=dbmodule.sqlconsultas.Fields[8].Text;
                stgpersonal1.Cells[20,j]:=dbmodule.sqlconsultas.Fields[9].Text;
                stgpersonal1.Cells[21,j]:=dbmodule.sqlconsultas.Fields[10].Text;
                stgpersonal1.Cells[22,j]:=dbmodule.sqlconsultas.Fields[11].Text;
                stgpersonal1.Cells[23,j]:=dbmodule.sqlconsultas.Fields[12].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS ADM Y OBR
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_adm_obr';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          x:=dbmodule.sqlconsultas.Fields[0].Text;
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal1.Cells[12,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[13,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal1.Cells[14,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal1.Cells[15,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal1.Cells[16,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal1.Cells[17,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal1.Cells[18,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal1.Cells[19,j]:=dbmodule.sqlconsultas.Fields[8].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE ESTUDIO
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.instruc_personal';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal1.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[2].Text then
              begin
                stgpersonal1.Cells[24,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal1.Cells[25,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                //CAMPO TIPO TEXT
                stgpersonal1.Cells[26,j]:=dbmodule.sqlconsultas.Fields[4].AsString;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal1.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  dbmodule.pgcnx.Connected:=false;
  statusbar1.Panels[1].Text:=IntToStr(i-1)+' Fila(s)';
  statusbar1.Panels[3].Text:=comboindice2.Text;
  dbmodule.pgcnx.Connected:=false;
  except
   MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
 if stgpersonal1.Cells[1,1]='' then
   begin
     MessageDlg('No se encontraron registros con esas espesificaciones',mtInformation,[mbOK],0);
     statusbar2.Panels[1].Text:='0 Filas';
   end;
end;

procedure Tvconsultas.buscardatosgenerales2();
var
  i,j:integer;
  id2: array [1..99999] of String;
  y:String;
begin
  //TABLA DE PERSONAL 2
  i:=1;
  stgpersonal2.Clean;
  stgpersonal2.RowCount:=2;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=True;
  try
  //nomina_general
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.nomina_general2 order by cedula asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgpersonal2.RowCount:=stgpersonal2.RowCount+1;
          stgpersonal2.Cells[0,i]:=IntToStr(i);
          id2[i]:=dbmodule.sqlconsultas.Fields[0].Text;
          //stgpersonal1.Cells[0,i]:=dbmodule.sqlconsultas.Fields[0].Text;
          stgpersonal2.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          stgpersonal2.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgpersonal2.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgpersonal2.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          stgpersonal2.Cells[5,i]:=dbmodule.sqlconsultas.Fields[5].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS DOCENTES
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_docente2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal2.Cells[6,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[7,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal2.Cells[8,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal2.Cells[9,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal2.Cells[10,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal2.Cells[11,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal2.Cells[12,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal2.Cells[13,j]:=dbmodule.sqlconsultas.Fields[8].Text;
                stgpersonal2.Cells[14,j]:=dbmodule.sqlconsultas.Fields[9].Text;
                stgpersonal2.Cells[15,j]:=dbmodule.sqlconsultas.Fields[10].Text;
                stgpersonal2.Cells[16,j]:=dbmodule.sqlconsultas.Fields[11].Text;
                stgpersonal2.Cells[17,j]:=dbmodule.sqlconsultas.Fields[12].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS ADM Y OBR
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_adm_obr2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          y:=dbmodule.sqlconsultas.Fields[0].Text;
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgpersonal2.Cells[6,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[7,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgpersonal2.Cells[8,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgpersonal2.Cells[9,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgpersonal2.Cells[10,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgpersonal2.Cells[11,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgpersonal2.Cells[12,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgpersonal2.Cells[13,j]:=dbmodule.sqlconsultas.Fields[8].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE ESTUDIO
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.instruc_personal2';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgpersonal2.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id2[j]=dbmodule.sqlconsultas.Fields[2].Text then
              begin
                stgpersonal2.Cells[18,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgpersonal2.Cells[19,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                //CAMPO TIPO TEXT
                stgpersonal2.Cells[20,j]:=dbmodule.sqlconsultas.Fields[4].AsString;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgpersonal2.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;
  dbmodule.pgcnx.Connected:=false;

  except
   MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;

  if stgpersonal2.Cells[1,1]='' then
   begin
     MessageDlg('No se encontraron registros con esas espesificaciones',mtInformation,[mbOK],0);
     statusbar2.Panels[1].Text:='0 Filas';
   end;
end;

procedure Tvconsultas.MenuItem2Click(Sender: TObject);
var
   Doc: TXMLDocument;
   RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
   i,j,control,control2: integer;
   nombrenodo:Array[0..50] of String;
 begin

 //NOMBRE DE LOS NODOS HIJOS
  nombrenodo[1]:='cedula';
  nombrenodo[2]:='nombre_apellido';
  nombrenodo[3]:='desc_dependencia';
  nombrenodo[4]:='cod_depen';
  nombrenodo[5]:='cod_cargo';
  nombrenodo[6]:='desc_cargo';
    if guardarxml.Execute then
      begin
       try
         // Crear el documento
         Doc := TXMLDocument.Create;
         // Crear el nodo raiz
         RootNode := Doc.CreateElement('nomina');
         Doc.Appendchild(RootNode);
         RootNode:= Doc.DocumentElement;
         control:=stgpersonal1.RowCount;
         control2:=7;
         // Crear los nodos
             for i := 1 to (control-2) do
               begin
                  if AnsiPos('ADM.',stgpersonal1.Cells[9,i]) or AnsiPos('OBRERO',stgpersonal1.Cells[9,i])<>0 then
                   begin
                     ElementNode:=Doc.CreateElement('recurso');
                      for j:=1 to (control2-1) do
                        begin
                             ItemNode:=Doc.CreateElement(nombrenodo[j]);
                             TextNode:=Doc.CreateTextNode(stgpersonal1.Cells[j,i]);
                             ItemNode.AppendChild(TextNode);
                             ElementNode.AppendChild(ItemNode);
                        end;
                     RootNode.AppendChild(ElementNode);

                   end;
               end;
           // Guardar el XML
           WriteXMLFile(Doc,guardarxml.FileName);
           Doc.Free;
           MessageDlg('Se ga guardado el archivo',mtInformation,[mbOK],0);
         Except
         MessageDlg('Error al guardar archivo', mtError,[mbOK],0);
         end;
      end;
end;

procedure Tvconsultas.segundoPopup(Sender: TObject);
begin
  if stgpersonal1.RowCount>=3 then
    begin
     segundo.Items.Items[0].Enabled:=true;
     segundo.Items.Items[1].Enabled:=true;
    end
  else
    begin
      segundo.Items.Items[0].Enabled:=false;
      segundo.Items.Items[1].Enabled:=true;
    end;
end;

end.

