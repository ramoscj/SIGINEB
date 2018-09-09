unit uvimportar2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  Buttons, StdCtrls, ExtCtrls, ComCtrls, EditBtn, ButtonPanel, FileCtrl, Menus,
  XMLRead, XMLWrite, DOM, uvbd;

type

  { Tvimportar2 }

  Tvimportar2 = class(TForm)
    btnactualizar: TBitBtn;
    btndirectorio: TBitBtn;
    btneliminar: TBitBtn;
    btninsertar: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Button1: TButton;
    combobd: TComboBox;
    editdirectorio: TEdit;
    GroupBox3: TGroupBox;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    deletefila: TMenuItem;
    savexml: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    segundo: TPopupMenu;
    ScrollBar1: TScrollBar;
    direccion: TSelectDirectoryDialog;
    statusbar1: TStatusBar;
    statusbar2: TStatusBar;
    stgbd: TStringGrid;
    stgimportar: TStringGrid;
    stgnuevos: TStringGrid;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure btndirectorioClick(Sender: TObject);
    procedure btninsertarClick(Sender: TObject);
    procedure btneliminarClick(Sender: TObject);
    procedure btnactualizarClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure combobdChange(Sender: TObject);
    procedure deletefilaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure savexmlClick(Sender: TObject);
    procedure stgbdSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure stgimportarSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure stgnuevosSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure savexmlpersonal(xml:String);
    procedure selectschema();
  private
    { private declarations }
    procedure updatedoc1();
    procedure insertarddoc1();
    procedure updatedoc2();
    procedure insertardoc2();
    procedure insertaradmobr1();
    procedure updateadmobr1();
    procedure insertaradmobr2();
    procedure updateadmobr2();
  public
    { public declarations }
  end;

var
  vimportar2: Tvimportar2;
  fila,fila1,fila2,sql,conteo:integer;
  esquema: array [1..99999] of String;

implementation

{$R *.lfm}

{ Tvimportar2 }

procedure Tvimportar2.BitBtn6Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=2;
  stgimportar.Clean;
  // NOMINA DOCENTES SEGUNDA
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/doc_2.xml');
   with Doc.DocumentElement.ChildNodes do
        begin
            for i:=0 to (Count-1) do
                begin
                stgimportar.RowCount:=Count;
                    for j:=0 to (Item[i].ChildNodes.Count-1) do
                        Begin
                            with Item[i].ChildNodes do
                                 begin
                                     with stgimportar do
                                          begin
                                             Cells[j,i]:=Item[j].FirstChild.NodeValue;
                                          end;
                                 end;
                        end;
                end;
        Doc.Free;
        end;
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
   statusbar2.Panels[3].Text:=editdirectorio.Text;
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
   segundo.Items.Items[0].Enabled:=true;
   segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar2.BitBtn7Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=4;
  stgimportar.Clean;
  // NOMINA ADMINISTRATIVO Y OBRERO SEGUNDA
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/adm_obr_2.xml');
   with Doc.DocumentElement.ChildNodes do
        begin
            for i:=0 to (Count-1) do
                begin
                stgimportar.RowCount:=Count;
                    for j:=0 to (Item[i].ChildNodes.Count-1) do
                        Begin
                            with Item[i].ChildNodes do
                                 begin
                                     with stgimportar do
                                          begin
                                             Cells[j,i]:=Item[j].FirstChild.NodeValue;
                                          end;
                                 end;
                        end;
                end;
        Doc.Free;
        end;
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
   statusbar2.Panels[3].Text:=editdirectorio.Text;
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
   segundo.Items.Items[0].Enabled:=true;
   segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar2.Button1Click(Sender: TObject);
begin
  stgimportar.DeleteRow(fila);
end;

procedure Tvimportar2.combobdChange(Sender: TObject);
begin
  statusbar1.Panels[3].Text:=combobd.Text;
  statusbar2.Panels[5].Text:=combobd.Text;
  try
    dbmodule.pgcnx.Connected:=true;
    statusbar1.Panels[5].Text:='[+] OnLine';
    statusbar2.Panels[7].Text:='[+] OnLine';
    dbmodule.pgcnx.Connected:=false;
    btninsertar.Enabled:=true;
    ToolBar1.Buttons[16].Enabled:=true;
  except
    statusbar1.Panels[5].Text:='[-] OffLine';
    statusbar2.Panels[7].Text:='[-] OffLine';
    stgbd.Clean;
    stgbd.RowCount:=1;
    stgnuevos.Clean;
    stgnuevos.RowCount:=1;
    btninsertar.Enabled:=false;
    btnactualizar.Enabled:=false;
    btneliminar.Enabled:=false;
    stgnuevos.Clean;
    stgnuevos.RowCount:=1;
    stgbd.Clean;
    stgbd.RowCount:=1;
    ToolBar1.Buttons[16].Enabled:=false;
  end;
end;

procedure Tvimportar2.deletefilaClick(Sender: TObject);
begin
  if stgimportar.RowCount<=1 then
   begin
     segundo.Items.Items[0].Enabled:=false;
     segundo.Items.Items[1].Enabled:=false;
   end;

  if stgimportar.RowCount>1 then
   begin
    if stgimportar.Cells[0,fila]<>'' then
      begin
         Beep;
         if mrYes=MessageDlg('Eliminara una Celda con Registros ¿Esta Seguro?',mtConfirmation,[mbYes,mbNo],0) then
           begin
            stgimportar.DeleteRow(fila);
           end;
      end
    else
      stgimportar.DeleteRow(fila);
   end;
end;

procedure Tvimportar2.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvimportar2.FormCreate(Sender: TObject);
var
  i:integer;
begin

 //PARA SELECCIONAR EL ESQUEMA
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

procedure Tvimportar2.savexmlClick(Sender: TObject);
begin
  if sql=1 then
    begin
        savexmlpersonal('doc_1.xml');
    end;
  if sql=2 then
    begin
        savexmlpersonal('doc_2.xml');
    end;
  if sql=3 then
    begin
        savexmlpersonal('adm_obr_1.xml');
    end;
  if sql=4 then
    begin
        savexmlpersonal('adm_obr_2.xml');
    end;
end;

procedure Tvimportar2.stgbdSelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  fila2:=aRow;
end;

procedure Tvimportar2.stgimportarSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  fila:=aRow;
end;


procedure Tvimportar2.stgnuevosSelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  fila1:=aRow;
  stgbd.Row:=fila1;
end;

procedure Tvimportar2.Timer1Timer(Sender: TObject);
begin
  conteo:=conteo+1;
  if conteo=100 then
    begin
      statusbar1.Panels[1].Text:='';
      statusbar2.Panels[1].Text:='';
    end;
end;

procedure Tvimportar2.BitBtn4Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=1;
  stgimportar.Clean;
  // NOMINA DOCENTES PRIMERA
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/doc_1.xml');
   with Doc.DocumentElement.ChildNodes do
        begin
            for i:=0 to (Count-1) do
                begin
                stgimportar.RowCount:=Count;
                    for j:=0 to (Item[i].ChildNodes.Count-1) do
                        Begin
                            with Item[i].ChildNodes do
                                 begin
                                     with stgimportar do
                                          begin
                                             Cells[j,i]:=Item[j].FirstChild.NodeValue;
                                          end;
                                 end;
                        end;
                end;
        Doc.Free;
        end;
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
   statusbar2.Panels[3].Text:=editdirectorio.Text;
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
   segundo.Items.Items[0].Enabled:=true;
   segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar2.btninsertarClick(Sender: TObject);
begin
  if sql=1 then
    begin
        insertarddoc1();
    end;
  if sql=2 then
    begin
        insertardoc2();
    end;
  if sql=3 then
    begin
        insertaradmobr1();
    end;
  if sql=4 then
    begin
        insertaradmobr2();
    end;
  conteo:=0;
  Timer1.Enabled:=false;
  Timer1.Enabled:=true;
end;

procedure Tvimportar2.btndirectorioClick(Sender: TObject);
begin
  if direccion.Execute then
     begin
       editdirectorio.Text:=direccion.FileName;
       if editdirectorio.Text<>'' then
          begin
            ToolBar1.Enabled:=True;
          end;
     end;
end;

procedure Tvimportar2.btneliminarClick(Sender: TObject);
begin
    if stgnuevos.RowCount=1 then
   begin
     MessageDlg('No se Puede eliminar', mtWarning,[mbOK],0);
   end;

  if stgnuevos.RowCount>1 then
   begin
    if stgnuevos.Cells[1,fila1]<>'' then
    begin
       Beep;
       if mrYes=MessageDlg('Eliminara una Celda con Registros ¿Esta Seguro?',mtConfirmation,[mbYes,mbNo],0) then
         begin
          stgnuevos.DeleteRow(fila1);
         end;
    end
    else
      stgnuevos.DeleteRow(fila1);
   end;
end;

procedure Tvimportar2.btnactualizarClick(Sender: TObject);
begin

  if sql=1 then
    begin
      updatedoc1();
    end;
  if sql=2 then
    begin
      updatedoc2();
    end;
  if sql=3 then
    begin
      updateadmobr1();
    end;
  if sql=4 then
    begin
      updateadmobr2();
    end;
  conteo:=0;
  Timer1.Enabled:=false;
  Timer1.Enabled:=true;
end;

procedure Tvimportar2.BitBtn5Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=3;
  stgimportar.Clean;
  // NOMINA ADMINISTRATIVO Y OBRERO PRIMERA
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/adm_obr_1.xml');
   with Doc.DocumentElement.ChildNodes do
        begin
            for i:=0 to (Count-1) do
                begin
                stgimportar.RowCount:=Count;
                    for j:=0 to (Item[i].ChildNodes.Count-1) do
                        Begin
                            with Item[i].ChildNodes do
                                 begin
                                     with stgimportar do
                                          begin
                                             Cells[j,i]:=Item[j].FirstChild.NodeValue;
                                          end;
                                 end;
                        end;
                end;
        Doc.Free;
        end;
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
   statusbar2.Panels[3].Text:=editdirectorio.Text;
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
   segundo.Items.Items[0].Enabled:=true;
   segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar2.selectschema();
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


//INSERTAR DATOS DE DOCENTES 1
procedure Tvimportar2.insertarddoc1();
var
datos,existe: array [0..999999] of string;
cd,nom: array [0..999999] of string;
dep: array [0..9999] of string;
i,cantidad,insertados,faltan,j:integer;
begin
  cantidad:=stgimportar.RowCount-1;
  insertados:=0;
  faltan:=0;
  j:=0;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
  for i:=1 to (stgimportar.RowCount-1) do
    begin
     stgbd.RowCount:=1;
     stgnuevos.RowCount:=1;
     //CONSULTA PARA TRAER LOS ID DE NOMINA
     dbmodule.sqlconsultas.SQL.Text:='select id_nomina,nombre,cedula,descp_depen from '+esquema[combobd.ItemIndex]+'.nomina_general where cedula='''+stgimportar.Cells[0,i]+''' and cod_administrativo='''+stgimportar.Cells[3,i]+'''';
     dbmodule.SQLTransaction.Active:=false;
     dbmodule.SQLTransaction.StartTransaction;
     dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            existe[i]:=dbmodule.sqlconsultas.Fields[0].Text;
            cd[i]:=dbmodule.sqlconsultas.Fields[2].Text;
            nom[i]:=dbmodule.sqlconsultas.Fields[1].Text;
            dep[i]:=dbmodule.sqlconsultas.Fields[3].Text;
            dbmodule.sqlconsultas.Next;
         end;
     dbmodule.sqlconsultas.Close;
     //CONSULTA PARA TRAER LAS FUNCIONES
     dbmodule.sqlconsultas2.SQL.Text:='select funcion from '+esquema[combobd.ItemIndex]+'.datos_docente where id_nomina='''+existe[i]+'''';
     dbmodule.SQLTransaction2.Active:=false;
     dbmodule.SQLTransaction2.StartTransaction;
     dbmodule.sqlconsultas2.Open;
       while not dbmodule.sqlconsultas2.EOF do
         begin
            datos[i]:=dbmodule.sqlconsultas2.Fields[0].Text;
            dbmodule.sqlconsultas2.Next;
         end;
     dbmodule.sqlconsultas2.Close;
    end;

  for i:=1 to (stgimportar.RowCount-1) do
    begin
       //FUNCION PARA TRAER LOS DATOS DE LOS DOCENTES_1
       if (datos[i]<>'') or (datos[i]='SE DESCONOCE SU UBICACION')  then
           begin
           //DATOS EN LA BD
           j:=j+1;
           stgbd.Cells[0,0]:='*';
           stgbd.RowCount:=stgbd.RowCount+1;
           stgbd.Cells[0,i]:=IntToStr(j);
           stgbd.Cells[1,i]:=cd[i];
           stgbd.Cells[2,i]:=nom[i];
           stgbd.Cells[3,i]:=datos[i];
           stgbd.Cells[4,i]:=dep[i];
           faltan:=faltan+1;
           stgbd.AutoSizeColumns;
           //DATOS NUEVOS
           stgnuevos.Cells[0,0]:='*';
           stgnuevos.RowCount:=stgnuevos.RowCount+1;
           stgnuevos.Cells[0,i]:=IntToStr(j);
           stgnuevos.Cells[1,i]:=stgimportar.Cells[0,i];
           stgnuevos.Cells[2,i]:=stgimportar.Cells[1,i];
           stgnuevos.Cells[3,i]:=stgimportar.Cells[7,i];
           stgnuevos.Cells[4,i]:=stgimportar.Cells[11,i];
           stgnuevos.Cells[5,i]:=stgimportar.Cells[12,i];
           stgnuevos.AutoSizeColumns;
           end;
       //FUNCION PARA INSERTAR LOS DATOS DE LOS DOCENTES_1
       if datos[i]='' then
         try
           begin
            dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.insert_datosdoc('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[13,i]+''','''+stgimportar.Cells[14,i]+''','''+stgimportar.Cells[16,i]+''','''+stgimportar.Cells[17,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''')';
            dbmodule.SQLTransaction.Active:=false;
            dbmodule.SQLTransaction.StartTransaction;
            dbmodule.sqlconsultas.ExecSQL;
            dbmodule.SQLTransaction.Commit;
            insertados:=insertados+1;
           end;
         except
            MessageDlg('Error al Insertar',mtError,[mbOK],0);
         end;
    end;
   MessageDlg('Se Insertaron los datos de: '+IntToStr(insertados)+' Docentes, existiendo: '+IntToStr(cantidad)+' registros en la DATA',mtInformation,[mbOK],0);
   statusbar2.Panels[1].Text:=IntToStr(insertados)+' Registros';
   dbmodule.pgcnx.Connected:=false;

  except
    MessageDlg('Error al insertar verifique la BD seleccionada ',mtError,[mbOK],0);
  end;
  if faltan>=1 then
     begin
         MessageDlg('Para actualizar los siguientes datos verifique y compare la información exisente con la que se va a actualizar, recuerde que "NO" podra deshacer los cambios',mtWarning,[mbOK],0);
         btnactualizar.Enabled:=true;
         btneliminar.Enabled:=true;
     end;
end;

//ACTULIZAR DATOS DE DOCENTES 1
procedure Tvimportar2.updatedoc1();
var
i,actu:integer;
begin
  actu:=0;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  for i:=1 to (stgnuevos.RowCount-1) do
    begin
     try
       begin
        dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.update_datosdoc('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[13,i]+''','''+stgimportar.Cells[14,i]+''','''+stgimportar.Cells[16,i]+''','''+stgimportar.Cells[17,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''')';
        dbmodule.SQLTransaction.Active:=false;
        dbmodule.SQLTransaction.StartTransaction;
        dbmodule.sqlconsultas.ExecSQL;
        dbmodule.SQLTransaction.Commit;
        actu:=actu+1;

       end;
     except
        MessageDlg('Error al Actualizar los datos de: "'+stgimportar.Cells[1,i]+'"',mtError,[mbOK],0);
     end;
    end;
  MessageDlg('Se actualizaron los datos de: '+IntToStr(actu)+' Docentes',mtInformation,[mbOK],0);
  statusbar1.Panels[1].Text:=IntToStr(actu)+' Registros';
  dbmodule.pgcnx.Connected:=false;
  if actu>0 then
    begin
       stgnuevos.Clean;
       stgnuevos.RowCount:=1;
       stgbd.Clean;
       stgbd.RowCount:=1;
       btnactualizar.Enabled:=false;
       btneliminar.Enabled:=false;
    end;
end;

//INSERTAR DATOS DE DOCENTES 2
procedure Tvimportar2.insertardoc2();
var
datos,existe: array [0..999999] of string;
cd,nom: array [0..999999] of string;
dep,entrar: array [0..9999] of string;
cantidad,insertados,faltan,j:integer;
i:integer;
begin
  cantidad:=stgimportar.RowCount-1;
  insertados:=0;
  faltan:=0;
  j:=0;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  for i:=1 to (stgimportar.RowCount-1) do
    begin
     stgbd.RowCount:=1;
     stgnuevos.RowCount:=1;
     dbmodule.sqlconsultas.SQL.Text:='select id_nomina from '+esquema[combobd.ItemIndex]+'.nomina_general where cedula='''+stgimportar.Cells[0,i]+'''';
     dbmodule.SQLTransaction.Active:=false;
     dbmodule.SQLTransaction.StartTransaction;
     dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            entrar[i]:=dbmodule.sqlconsultas.Fields[0].Text;
            dbmodule.sqlconsultas.Next;
         end;
     dbmodule.sqlconsultas.Close;
     end;

  for i:=1 to (stgimportar.RowCount-1) do
    begin
     //DECIDIR A DONDE ENTRAR***************__1
     if entrar[i]<>'' then
       begin
           //CONSULTA PARA TRAER LOS ID DE NOMINA
           dbmodule.sqlconsultas.SQL.Text:='select id_nomina,nombre,cedula,descp_depen from '+esquema[combobd.ItemIndex]+'.nomina_general where cedula='''+stgimportar.Cells[0,i]+'''';
           dbmodule.SQLTransaction.Active:=false;
           dbmodule.SQLTransaction.StartTransaction;
           dbmodule.sqlconsultas.Open;
             while not dbmodule.sqlconsultas.EOF do
               begin
                  existe[i]:=dbmodule.sqlconsultas.Fields[0].Text;
                  cd[i]:=dbmodule.sqlconsultas.Fields[2].Text;
                  nom[i]:=dbmodule.sqlconsultas.Fields[1].Text;
                  dep[i]:=dbmodule.sqlconsultas.Fields[3].Text;
                  dbmodule.sqlconsultas.Next;

               end;
           dbmodule.sqlconsultas.Close;
           //CONSULTA PARA TRAER LAS FUNCIONES
           dbmodule.sqlconsultas2.SQL.Text:='select funcion from '+esquema[combobd.ItemIndex]+'.datos_docente where id_nomina='''+existe[i]+'''';
           dbmodule.SQLTransaction2.Active:=false;
           dbmodule.SQLTransaction2.StartTransaction;
           dbmodule.sqlconsultas2.Open;
             while not dbmodule.sqlconsultas2.EOF do
               begin
                  datos[i]:=dbmodule.sqlconsultas2.Fields[0].Text;
                  dbmodule.sqlconsultas2.Next;
               end;
           dbmodule.sqlconsultas2.Close;
             //FUNCION PARA TRAER LOS DATOS DE LOS DOCENTES_1
             if (datos[i]<>'') or (datos[i]='SE DESCONOCE SU UBICACION')  then
                 begin
                 //DATOS EN LA BD
                 j:=j+1;
                 stgbd.Cells[0,0]:='*';
                 stgbd.RowCount:=stgbd.RowCount+1;
                 stgbd.Cells[0,i]:=IntToStr(j);
                 stgbd.Cells[1,i]:=cd[i];
                 stgbd.Cells[2,i]:=nom[i];
                 stgbd.Cells[3,i]:=datos[i];
                 stgbd.Cells[4,i]:=dep[i];
                 faltan:=faltan+1;
                 stgbd.AutoSizeColumns;

                 //DATOS NUEVOS
                 stgnuevos.Cells[0,0]:='*';
                 stgnuevos.RowCount:=stgnuevos.RowCount+1;
                 stgnuevos.Cells[0,i]:=IntToStr(j);
                 stgnuevos.Cells[1,i]:=stgimportar.Cells[0,i];
                 stgnuevos.Cells[2,i]:=stgimportar.Cells[1,i];
                 stgnuevos.Cells[3,i]:=stgimportar.Cells[7,i];
                 stgnuevos.Cells[4,i]:=stgimportar.Cells[11,i];
                 stgnuevos.Cells[5,i]:=stgimportar.Cells[12,i];
                 stgnuevos.AutoSizeColumns;
                 end;
             //FUNCION PARA INSERTAR LOS DATOS EN LOS DOCENTES_1
             if datos[i]='' then
               try
                 begin
                  dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.insert_datosdoc('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[13,i]+''','''+stgimportar.Cells[14,i]+''','''+stgimportar.Cells[16,i]+''','''+stgimportar.Cells[17,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''')';
                  dbmodule.SQLTransaction.Active:=false;
                  dbmodule.SQLTransaction.StartTransaction;
                  dbmodule.sqlconsultas.ExecSQL;
                  dbmodule.SQLTransaction.Commit;
                  insertados:=insertados+1;
                 end;
               except
                  MessageDlg('Error al Insertar',mtError,[mbOK],0);
               end;
         end;

      //DECIDIR A DONDE ENTRAR*******************__2
      if entrar[i]='' then
        begin
             //CONSULTA PARA TRAER LOS ID DE NOMINA
             dbmodule.sqlconsultas.SQL.Text:='select id_nomina,nombre,cedula,descp_depen from '+esquema[combobd.ItemIndex]+'.nomina_general2 where cedula='''+stgimportar.Cells[0,i]+'''';
             dbmodule.SQLTransaction.Active:=false;
             dbmodule.SQLTransaction.StartTransaction;
             dbmodule.sqlconsultas.Open;
               while not dbmodule.sqlconsultas.EOF do
                 begin
                    existe[i]:=dbmodule.sqlconsultas.Fields[0].Text;
                    cd[i]:=dbmodule.sqlconsultas.Fields[2].Text;
                    nom[i]:=dbmodule.sqlconsultas.Fields[1].Text;
                    dep[i]:=dbmodule.sqlconsultas.Fields[3].Text;
                    dbmodule.sqlconsultas.Next;

                 end;
             dbmodule.sqlconsultas.Close;

             if existe[i]<>'' then
               begin
                 //CONSULTA PARA TRAER LAS FUNCIONES
                 dbmodule.sqlconsultas2.SQL.Text:='select funcion from '+esquema[combobd.ItemIndex]+'.datos_docente2 where id_nomina='''+existe[i]+'''';
                 dbmodule.SQLTransaction2.Active:=false;
                 dbmodule.SQLTransaction2.StartTransaction;
                 dbmodule.sqlconsultas2.Open;
                   while not dbmodule.sqlconsultas2.EOF do
                     begin
                        datos[i]:=dbmodule.sqlconsultas2.Fields[0].Text;
                        dbmodule.sqlconsultas2.Next;
                     end;
                 dbmodule.sqlconsultas2.Close;
               end;

               //FUNCION PARA TRAER LOS DATOS DE LOS DOCENTES_2
               if (datos[i]<>'') or (datos[i]='SE DESCONOCE SU UBICACION')  then
                   begin
                   //DATOS EN LA BD
                   j:=j+1;
                   stgbd.Cells[0,0]:='*';
                   stgbd.RowCount:=stgbd.RowCount+1;
                   stgbd.Cells[0,i]:=IntToStr(j);
                   stgbd.Cells[1,i]:=cd[i];
                   stgbd.Cells[2,i]:=nom[i];
                   stgbd.Cells[3,i]:=datos[i];
                   stgbd.Cells[4,i]:=dep[i];
                   faltan:=faltan+1;
                   stgbd.AutoSizeColumns;

                   //DATOS NUEVOS
                   stgnuevos.Cells[0,0]:='*';
                   stgnuevos.RowCount:=stgnuevos.RowCount+1;
                   stgnuevos.Cells[0,i]:=IntToStr(j);
                   stgnuevos.Cells[1,i]:=stgimportar.Cells[0,i];
                   stgnuevos.Cells[2,i]:=stgimportar.Cells[1,i];
                   stgnuevos.Cells[3,i]:=stgimportar.Cells[7,i];
                   stgnuevos.Cells[4,i]:=stgimportar.Cells[11,i];
                   stgnuevos.Cells[5,i]:=stgimportar.Cells[12,i];
                   stgnuevos.AutoSizeColumns;
                   end;
               //FUNCION PARA INSERTAR LOS DATOS DE LOS DOCENTES_2
               if datos[i]='' then
                 try
                   begin
                    dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.insert_datosdoc2('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[13,i]+''','''+stgimportar.Cells[14,i]+''','''+stgimportar.Cells[16,i]+''','''+stgimportar.Cells[17,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''','''+stgimportar.Cells[1,i]+''','''+stgimportar.Cells[4,i]+''','''+stgimportar.Cells[5,i]+''','''+stgimportar.Cells[2,i]+''')';
                    dbmodule.SQLTransaction.Active:=false;
                    dbmodule.SQLTransaction.StartTransaction;
                    dbmodule.sqlconsultas.ExecSQL;
                    dbmodule.SQLTransaction.Commit;
                    insertados:=insertados+1;
                   end;
                 except
                    MessageDlg('Error al Insertar',mtError,[mbOK],0);
                 end;
          end;
        end;

  MessageDlg('Se Insertaron los datos de: '+IntToStr(insertados)+' Docentes, existiendo: '+IntToStr(cantidad)+' registros en la DATA',mtInformation,[mbOK],0);
  statusbar2.Panels[1].Text:=IntToStr(insertados)+' Registros';
  dbmodule.pgcnx.Connected:=false;
  if faltan>=1 then
    begin
      MessageDlg('Para actualizar los siguientes datos verifique y compare la información exisente con la que se va a actualizar, recuerde que "NO" podra deshacer los cambios',mtWarning,[mbOK],0);
      btnactualizar.Enabled:=true;
      btneliminar.Enabled:=true;
    end;

end;

//ACTUALIZAR DOCENTES 2
procedure Tvimportar2.updatedoc2;
var
i,actu:integer;
begin
  actu:=0;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  for i:=1 to (stgnuevos.RowCount-1) do
    begin
     try
       begin
        dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.update_datosdoc2('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[13,i]+''','''+stgimportar.Cells[14,i]+''','''+stgimportar.Cells[16,i]+''','''+stgimportar.Cells[17,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''')';
        dbmodule.SQLTransaction.Active:=false;
        dbmodule.SQLTransaction.StartTransaction;
        dbmodule.sqlconsultas.ExecSQL;
        dbmodule.SQLTransaction.Commit;
        actu:=actu+1;
       end;
     except
        MessageDlg('Error al Actualizar los datos de: "'+stgimportar.Cells[1,i]+'"',mtError,[mbOK],0);
     end;
    end;
  MessageDlg('Se actualizaron los datos de: '+IntToStr(actu)+' Docentes',mtInformation,[mbOK],0);
  statusbar1.Panels[1].Text:=IntToStr(actu)+' Registros';
  dbmodule.pgcnx.Connected:=false;
  if actu>0 then
    begin
       stgnuevos.Clean;
       stgnuevos.RowCount:=1;
       stgbd.Clean;
       stgbd.RowCount:=1;
       btnactualizar.Enabled:=false;
       btneliminar.Enabled:=false;
    end;
end;

//INSERTAR DATOS ADM_OBR_1
procedure Tvimportar2.insertaradmobr1();
var
datos,existe: array [0..999999] of string;
cd,nom: array [0..999999] of string;
dep: array [0..9999] of string;
i,cantidad,insertados,faltan,j:integer;
begin
  cantidad:=stgimportar.RowCount-1;
  insertados:=0;
  faltan:=0;
  j:=0;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
  for i:=1 to (stgimportar.RowCount-1) do
    begin
     stgbd.RowCount:=1;
     stgnuevos.RowCount:=1;
     //CONSULTA PARA TRAER LOS ID DE NOMINA
     dbmodule.sqlconsultas.SQL.Text:='select id_nomina,nombre,cedula,descp_depen from '+esquema[combobd.ItemIndex]+'.nomina_general where cedula='''+stgimportar.Cells[0,i]+''' and cod_administrativo='''+stgimportar.Cells[3,i]+'''';
     dbmodule.SQLTransaction.Active:=false;
     dbmodule.SQLTransaction.StartTransaction;
     dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            existe[i]:=dbmodule.sqlconsultas.Fields[0].Text;
            cd[i]:=dbmodule.sqlconsultas.Fields[2].Text;
            nom[i]:=dbmodule.sqlconsultas.Fields[1].Text;
            dep[i]:=dbmodule.sqlconsultas.Fields[3].Text;
            dbmodule.sqlconsultas.Next;

         end;
     dbmodule.sqlconsultas.Close;

     //CONSULTA PARA TRAER LAS FUNCIONES
     dbmodule.sqlconsultas2.SQL.Text:='select funcion from '+esquema[combobd.ItemIndex]+'.datos_adm_obr where id_nomina='''+existe[i]+'''';
     dbmodule.SQLTransaction2.Active:=false;
     dbmodule.SQLTransaction2.StartTransaction;
     dbmodule.sqlconsultas2.Open;
       while not dbmodule.sqlconsultas2.EOF do
         begin
            datos[i]:=dbmodule.sqlconsultas2.Fields[0].Text;
            dbmodule.sqlconsultas2.Next;
         end;
     dbmodule.sqlconsultas2.Close;
    end;

  for i:=1 to (stgimportar.RowCount-1) do
    begin
       //FUNCION PARA TRAER LOS DATOS DE LOS ADM_OBR_1
       if (datos[i]<>'') or (datos[i]='SE DESCONOCE SU UBICACION')  then
           begin
           //DATOS EN LA BD
           j:=j+1;
           stgbd.Cells[0,0]:='*';
           stgbd.RowCount:=stgbd.RowCount+1;
           stgbd.Cells[0,i]:=IntToStr(j);
           stgbd.Cells[1,i]:=cd[i];
           stgbd.Cells[2,i]:=nom[i];
           stgbd.Cells[3,i]:=datos[i];
           stgbd.Cells[4,i]:=dep[i];
           faltan:=faltan+1;
           stgbd.AutoSizeColumns;

           //DATOS NUEVOS
           stgnuevos.Cells[0,0]:='*';
           stgnuevos.RowCount:=stgnuevos.RowCount+1;
           stgnuevos.Cells[0,i]:=IntToStr(j);
           stgnuevos.Cells[1,i]:=stgimportar.Cells[0,i];
           stgnuevos.Cells[2,i]:=stgimportar.Cells[1,i];
           stgnuevos.Cells[3,i]:=stgimportar.Cells[7,i];
           stgnuevos.Cells[4,i]:=stgimportar.Cells[11,i];
           stgnuevos.Cells[5,i]:=stgimportar.Cells[12,i];
           stgnuevos.AutoSizeColumns;
           end;
       //FUNCION PARA INSERTAR LOS DATOS DE LOS ADM_OBR_1
       if datos[i]='' then
         try
           begin
            dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.insert_datosadmobr('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''')';
            dbmodule.SQLTransaction.Active:=false;
            dbmodule.SQLTransaction.StartTransaction;
            dbmodule.sqlconsultas.ExecSQL;
            dbmodule.SQLTransaction.Commit;
            insertados:=insertados+1;
           end;
         except
            MessageDlg('Error al Insertar',mtError,[mbOK],0);
         end;
    end;
   MessageDlg('Se Insertaron los datos de: '+IntToStr(insertados)+' Administrativos u Obreros, existiendo: '+IntToStr(cantidad)+' registros en la DATA',mtInformation,[mbOK],0);
   statusbar2.Panels[1].Text:=IntToStr(insertados)+' Registros';
   dbmodule.pgcnx.Connected:=false;

  except
    MessageDlg('Error al insertar verifique la BD seleccionada',mtError,[mbOK],0);
  end;
  if faltan>=1 then
     begin
         MessageDlg('Para actualizar los siguientes datos verifique y compare la información exisente con la que se va a actualizar, recuerde que "NO" podra deshacer los cambios',mtWarning,[mbOK],0);
         btnactualizar.Enabled:=true;
         btneliminar.Enabled:=true;
     end;
end;

//ACTUALIZAR DATOS DE ADM_OBR_1
procedure Tvimportar2.updateadmobr1();
var
i,actu:integer;
begin
  actu:=0;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  for i:=1 to (stgnuevos.RowCount-1) do
    begin
     try
       begin
        dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.update_datosadmobr('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''')';
        dbmodule.SQLTransaction.Active:=false;
        dbmodule.SQLTransaction.StartTransaction;
        dbmodule.sqlconsultas.ExecSQL;
        dbmodule.SQLTransaction.Commit;
        actu:=actu+1;

       end;
     except
        MessageDlg('Error al Actualizar los datos de: "'+stgimportar.Cells[1,i]+'"',mtError,[mbOK],0);
     end;
    end;
  MessageDlg('Se actualizaron los datos de: '+IntToStr(actu)+' Administrativos y Obreros',mtInformation,[mbOK],0);
  statusbar1.Panels[1].Text:=IntToStr(actu)+' Registros';
  dbmodule.pgcnx.Connected:=false;
  if actu>0 then
    begin
       stgnuevos.Clean;
       stgnuevos.RowCount:=1;
       stgbd.Clean;
       stgbd.RowCount:=1;
       btnactualizar.Enabled:=false;
       btneliminar.Enabled:=false;
    end;
end;

//INSERTAR DATOS ADM_OBR 2
procedure Tvimportar2.insertaradmobr2();
var
datos,existe: array [0..999999] of string;
cd,nom: array [0..999999] of string;
dep,entrar: array [0..9999] of string;
cantidad,insertados,faltan,j:integer;
i:integer;
begin
  cantidad:=stgimportar.RowCount-1;
  insertados:=0;
  faltan:=0;
  j:=0;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
  for i:=1 to (stgimportar.RowCount-1) do
    begin
     stgbd.RowCount:=1;
     stgnuevos.RowCount:=1;
     dbmodule.sqlconsultas.SQL.Text:='select id_nomina from '+esquema[combobd.ItemIndex]+'.nomina_general where cedula='''+stgimportar.Cells[0,i]+'''';
     dbmodule.SQLTransaction.Active:=false;
     dbmodule.SQLTransaction.StartTransaction;
     dbmodule.sqlconsultas.Open;
       while not dbmodule.sqlconsultas.EOF do
         begin
            entrar[i]:=dbmodule.sqlconsultas.Fields[0].Text;
            dbmodule.sqlconsultas.Next;
         end;
     dbmodule.sqlconsultas.Close;
     end;

  for i:=1 to (stgimportar.RowCount-1) do
    begin
     //DECIDIR A DONDE ENTRAR***************__1
     if entrar[i]<>'' then
       begin
           //CONSULTA PARA TRAER LOS ID DE NOMINA
           dbmodule.sqlconsultas.SQL.Text:='select id_nomina,nombre,cedula,descp_depen from '+esquema[combobd.ItemIndex]+'.nomina_general where cedula='''+stgimportar.Cells[0,i]+'''';
           dbmodule.SQLTransaction.Active:=false;
           dbmodule.SQLTransaction.StartTransaction;
           dbmodule.sqlconsultas.Open;
             while not dbmodule.sqlconsultas.EOF do
               begin
                  existe[i]:=dbmodule.sqlconsultas.Fields[0].Text;
                  cd[i]:=dbmodule.sqlconsultas.Fields[2].Text;
                  nom[i]:=dbmodule.sqlconsultas.Fields[1].Text;
                  dep[i]:=dbmodule.sqlconsultas.Fields[3].Text;
                  dbmodule.sqlconsultas.Next;

               end;
           dbmodule.sqlconsultas.Close;
           //CONSULTA PARA TRAER LAS FUNCIONES
           dbmodule.sqlconsultas2.SQL.Text:='select funcion from '+esquema[combobd.ItemIndex]+'.datos_adm_obr where id_nomina='''+existe[i]+'''';
           dbmodule.SQLTransaction2.Active:=false;
           dbmodule.SQLTransaction2.StartTransaction;
           dbmodule.sqlconsultas2.Open;
             while not dbmodule.sqlconsultas2.EOF do
               begin
                  datos[i]:=dbmodule.sqlconsultas2.Fields[0].Text;
                  dbmodule.sqlconsultas2.Next;
               end;
           dbmodule.sqlconsultas2.Close;
             //FUNCION PARA TRAER LOS DATOS DE LOS ADM_OBR 1
             if (datos[i]<>'') or (datos[i]='SE DESCONOCE SU UBICACION')  then
                 begin
                 //DATOS EN LA BD
                 j:=j+1;
                 stgbd.Cells[0,0]:='*';
                 stgbd.RowCount:=stgbd.RowCount+1;
                 stgbd.Cells[0,i]:=IntToStr(j);
                 stgbd.Cells[1,i]:=cd[i];
                 stgbd.Cells[2,i]:=nom[i];
                 stgbd.Cells[3,i]:=datos[i];
                 stgbd.Cells[4,i]:=dep[i];
                 faltan:=faltan+1;
                 stgbd.AutoSizeColumns;

                 //DATOS NUEVOS
                 stgnuevos.Cells[0,0]:='*';
                 stgnuevos.RowCount:=stgnuevos.RowCount+1;
                 stgnuevos.Cells[0,i]:=IntToStr(j);
                 stgnuevos.Cells[1,i]:=stgimportar.Cells[0,i];
                 stgnuevos.Cells[2,i]:=stgimportar.Cells[1,i];
                 stgnuevos.Cells[3,i]:=stgimportar.Cells[7,i];
                 stgnuevos.Cells[4,i]:=stgimportar.Cells[11,i];
                 stgnuevos.Cells[5,i]:=stgimportar.Cells[12,i];
                 stgnuevos.AutoSizeColumns;
                 end;
             //FUNCION PARA INSERTAR LOS DATOS EN LOS ADM_OBR 1
             if datos[i]='' then
               try
                 begin
                  dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.insert_datosadmobr('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''')';
                  dbmodule.SQLTransaction.Active:=false;
                  dbmodule.SQLTransaction.StartTransaction;
                  dbmodule.sqlconsultas.ExecSQL;
                  dbmodule.SQLTransaction.Commit;
                  insertados:=insertados+1;
                 end;
               except
                  MessageDlg('Error al Insertar',mtError,[mbOK],0);
               end;
         end;

      //DECIDIR A DONDE ENTRAR*******************__2
      if entrar[i]='' then
        begin
             //CONSULTA PARA TRAER LOS ID DE NOMINA
             dbmodule.sqlconsultas.SQL.Text:='select id_nomina,nombre,cedula,descp_depen from '+esquema[combobd.ItemIndex]+'.nomina_general2 where cedula='''+stgimportar.Cells[0,i]+'''';
             dbmodule.SQLTransaction.Active:=false;
             dbmodule.SQLTransaction.StartTransaction;
             dbmodule.sqlconsultas.Open;
               while not dbmodule.sqlconsultas.EOF do
                 begin
                    existe[i]:=dbmodule.sqlconsultas.Fields[0].Text;
                    cd[i]:=dbmodule.sqlconsultas.Fields[2].Text;
                    nom[i]:=dbmodule.sqlconsultas.Fields[1].Text;
                    dep[i]:=dbmodule.sqlconsultas.Fields[3].Text;
                    dbmodule.sqlconsultas.Next;

                 end;
             dbmodule.sqlconsultas.Close;

             if existe[i]<>'' then
               begin
                 //CONSULTA PARA TRAER LAS FUNCIONES
                 dbmodule.sqlconsultas2.SQL.Text:='select funcion from '+esquema[combobd.ItemIndex]+'.datos_adm_obr2 where id_nomina='''+existe[i]+'''';
                 dbmodule.SQLTransaction2.Active:=false;
                 dbmodule.SQLTransaction2.StartTransaction;
                 dbmodule.sqlconsultas2.Open;
                   while not dbmodule.sqlconsultas2.EOF do
                     begin
                        datos[i]:=dbmodule.sqlconsultas2.Fields[0].Text;
                        dbmodule.sqlconsultas2.Next;
                     end;
                 dbmodule.sqlconsultas2.Close;
               end;

               //FUNCION PARA TRAER LOS DATOS DE LOS ADM_OBR 2
               if (datos[i]<>'') or (datos[i]='SE DESCONOCE SU UBICACION')  then
                   begin
                   //DATOS EN LA BD
                   j:=j+1;
                   stgbd.Cells[0,0]:='*';
                   stgbd.RowCount:=stgbd.RowCount+1;
                   stgbd.Cells[0,i]:=IntToStr(j);
                   stgbd.Cells[1,i]:=cd[i];
                   stgbd.Cells[2,i]:=nom[i];
                   stgbd.Cells[3,i]:=datos[i];
                   stgbd.Cells[4,i]:=dep[i];
                   faltan:=faltan+1;
                   stgbd.AutoSizeColumns;

                   //DATOS NUEVOS
                   stgnuevos.Cells[0,0]:='*';
                   stgnuevos.RowCount:=stgnuevos.RowCount+1;
                   stgnuevos.Cells[0,i]:=IntToStr(j);
                   stgnuevos.Cells[1,i]:=stgimportar.Cells[0,i];
                   stgnuevos.Cells[2,i]:=stgimportar.Cells[1,i];
                   stgnuevos.Cells[3,i]:=stgimportar.Cells[7,i];
                   stgnuevos.Cells[4,i]:=stgimportar.Cells[11,i];
                   stgnuevos.Cells[5,i]:=stgimportar.Cells[12,i];
                   stgnuevos.AutoSizeColumns;
                   end;
               //FUNCION PARA INSERTAR LOS DATOS DE LOS ADM_OBR 2
               if datos[i]='' then
                 try
                   begin
                    dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.insert_datosadmobr2('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''','''+stgimportar.Cells[1,i]+''','''+stgimportar.Cells[4,i]+''','''+stgimportar.Cells[5,i]+''','''+stgimportar.Cells[2,i]+''')';
                    dbmodule.SQLTransaction.Active:=false;
                    dbmodule.SQLTransaction.StartTransaction;
                    dbmodule.sqlconsultas.ExecSQL;
                    dbmodule.SQLTransaction.Commit;
                    insertados:=insertados+1;
                   end;
                 except
                    MessageDlg('Error al Insertar',mtError,[mbOK],0);
                 end;
          end;
        end;

  MessageDlg('Se Insertaron los datos de: '+IntToStr(insertados)+' Adm u Obr, existiendo: '+IntToStr(cantidad)+' registros en la DATA',mtInformation,[mbOK],0);
  statusbar2.Panels[1].Text:=IntToStr(insertados)+' Registros';
  dbmodule.pgcnx.Connected:=false;

  except
    MessageDlg('Error al insertar verifique la BD seleccionada',mtError,[mbOK],0);
  end;
  if faltan>=1 then
    begin
      MessageDlg('Para actualizar los siguientes datos verifique y compare la información exisente con la que se va a actualizar, recuerde que "NO" podra deshacer los cambios',mtWarning,[mbOK],0);
      btnactualizar.Enabled:=true;
      btneliminar.Enabled:=true;
    end;
end;

//ACUTALIZAR ADM_OBR 2
procedure Tvimportar2.updateadmobr2();
var
i,actu:integer;
begin
  actu:=0;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  for i:=1 to (stgnuevos.RowCount-1) do
    begin
     try
       begin
        dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.update_datosadmobr2('''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''')';
        dbmodule.SQLTransaction.Active:=false;
        dbmodule.SQLTransaction.StartTransaction;
        dbmodule.sqlconsultas.ExecSQL;
        dbmodule.SQLTransaction.Commit;
        actu:=actu+1;

       end;
     except
        MessageDlg('Error al Actualizar los datos de: "'+stgimportar.Cells[1,i]+'"',mtError,[mbOK],0);
     end;
    end;
  MessageDlg('Se actualizaron los datos de: '+IntToStr(actu)+' Administrativos y Obreros',mtInformation,[mbOK],0);
  statusbar1.Panels[1].Text:=IntToStr(actu)+' Registros';
  dbmodule.pgcnx.Connected:=false;
  if actu>0 then
    begin
       stgnuevos.Clean;
       stgnuevos.RowCount:=1;
       stgbd.Clean;
       stgbd.RowCount:=1;
       btnactualizar.Enabled:=false;
       btneliminar.Enabled:=false;
    end;
end;

procedure Tvimportar2.savexmlpersonal(xml:String);
var
   Doc: TXMLDocument;
   RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
   i,j,control,control2: integer;
   nombrenodo:Array[0..50] of String;
 begin

 //NOMBRE DE LOS NODOS HIJOS
  nombrenodo[0]:='cedula';
  nombrenodo[1]:='nombre_apellido';
  nombrenodo[2]:='desc_dependencia';
  nombrenodo[3]:='cod_depen';
  nombrenodo[4]:='cod_cargo';
  nombrenodo[5]:='desc_cargo';
  nombrenodo[6]:='dependencia';
  nombrenodo[7]:='funcion';
  nombrenodo[8]:='otra_funcion';
  nombrenodo[9]:='telefono';
  nombrenodo[10]:='correo';
  nombrenodo[11]:='labora_plant';
  nombrenodo[12]:='donde_labora';
  nombrenodo[13]:='matricula_m';
  nombrenodo[14]:='matricula_f';
  nombrenodo[15]:='sexo';
  nombrenodo[16]:='grado';
  nombrenodo[17]:='seccion';
  nombrenodo[18]:='fcha_ingplant';
  nombrenodo[19]:='nivel_instru';
  nombrenodo[20]:='estudia';
  nombrenodo[21]:='detalle_estudio';
  nombrenodo[22]:='nivel_select';

   for i:=0 to (stgimportar.RowCount-1) do
     begin
        for j:=0 to (stgimportar.ColCount-1) do
          begin
               if stgimportar.Cells[j,i]='' then
               begin
                 stgimportar.Cells[j,i]:='0';
               end;
          end;

     end;
   try

     // Crear el documento
     Doc := TXMLDocument.Create;
     // Crear el nodo raiz
     RootNode := Doc.CreateElement('nomina');
     Doc.Appendchild(RootNode);
     RootNode:= Doc.DocumentElement;
     control:=stgimportar.RowCount;
     control2:=stgimportar.ColCount;
     // Crear los nodos
     for i := 0 to (control-1) do
       begin
         ElementNode:=Doc.CreateElement('recurso');
          for j:=0 to (control2-1) do
            begin
             ItemNode:=Doc.CreateElement(nombrenodo[j]);
             TextNode:=Doc.CreateTextNode(stgimportar.Cells[j,i]);
             ItemNode.AppendChild(TextNode);
             ElementNode.AppendChild(ItemNode);
            end;
         RootNode.AppendChild(ElementNode);
       end;
       // Guardar el XML
       WriteXMLFile(Doc,editdirectorio.Text+'/'+xml);
       Doc.Free;
       MessageDlg('Se ga guardado el archivo',mtInformation,[mbOK],0);
     Except
     MessageDlg('Error al guardar archivo', mtError,[mbOK],0);
     end;
end;

end.

