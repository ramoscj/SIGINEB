unit uvimportar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, XMLRead,
  Buttons, StdCtrls, ExtCtrls, ComCtrls, Menus, XMLWrite, DOM, uvbd;

type

  { Tvimportar }

  Tvimportar = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    btndirectorio: TBitBtn;
    btninsert: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    btntodo: TBitBtn;
    combobd: TComboBox;
    editdirectorio: TEdit;
    GroupBox3: TGroupBox;
    imgmenu: TImageList;
    borrarfila: TMenuItem;
    guardarxml: TMenuItem;
    Panel1: TPanel;
    direccion: TSelectDirectoryDialog;
    Panel2: TPanel;
    segundo: TPopupMenu;
    statusbar1: TStatusBar;
    stgimportar: TStringGrid;
    cabecera: TToolBar;
    contador: TTimer;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton25: TToolButton;
    ToolButton29: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton9: TToolButton;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure borrarfilaClick(Sender: TObject);
    procedure btndirectorioClick(Sender: TObject);
    procedure btninsertClick(Sender: TObject);
    procedure btntodoClick(Sender: TObject);
    procedure combobdChange(Sender: TObject);
    procedure contadorTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure guardarxmlClick(Sender: TObject);
    procedure stgimportarSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure savexmldatos();
    procedure savexmlmatricula();
    procedure savexmlppp();
    procedure savexmlneceperso();
    procedure savexmlnecemate();
    procedure savexmlneceinfra();
    procedure selectschema();
  private
    { private declarations }
    procedure cargadplantel();
    procedure cargamplantel();
    procedure cargapppplantel();
    procedure carganiplantel();
    procedure carganpplantel();
    procedure carganmplantel();
  public
    { public declarations }
  end;

var
  vimportar: Tvimportar;
  fila,columna,sql,conteo:Integer;
  esquema: array [1..99999] of String;

implementation

{$R *.lfm}

{ Tvimportar }

procedure Tvimportar.BitBtn1Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=1;
  // DATOS DEL PLANTEL
  try
  stgimportar.Clean;
  stgimportar.ColCount:=37;
  ReadXMLFile(Doc,editdirectorio.Text+'/datos_plantel.xml');
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
    //TITULOS DE LAS COLUMNAS
    stgimportar.Cells[0,0]:='PLANTEL';
    stgimportar.Cells[1,0]:='N.E.R.';
    stgimportar.Cells[2,0]:='MUNICIPIO';
    stgimportar.Cells[3,0]:='DEPENDENCIA';
    stgimportar.Cells[4,0]:='DESCRIP DEPENDENCIA';
    stgimportar.Cells[5,0]:='TIPO DE MODALIDAD';
    stgimportar.Cells[6,0]:='CODIGO ADM';
    stgimportar.Cells[7,0]:='CODIGO DEA';
    stgimportar.Cells[8,0]:='CODIGO EST';
    stgimportar.Cells[9,0]:='TELEFONO';
    stgimportar.Cells[10,0]:='CORREO';
    stgimportar.Cells[11,0]:='HORARIO';
    stgimportar.Cells[12,0]:='PARROQUIA';
    stgimportar.Cells[13,0]:='DIRECCIÓN';
    stgimportar.Cells[14,0]:='UBICACIÓN GEOGRAF.';
    stgimportar.Cells[15,0]:='LONGITUD';
    stgimportar.Cells[16,0]:='LATITUD';
    stgimportar.Cells[17,0]:='RESEÑA HISTORICA';
    stgimportar.Cells[18,0]:='ACTIVIDAD SOC. ECONOMICA';
    stgimportar.Cells[19,0]:='ACTIVIDAD SOC. PRODUCTIVA';
    stgimportar.Cells[20,0]:='INFRAESTRUCTURA';
    stgimportar.Cells[21,0]:='TENENCIA';
    stgimportar.Cells[22,0]:='MTS DEL TERRENO';
    stgimportar.Cells[23,0]:='PLANTEL EN CONSTRUCCIÓN';
    stgimportar.Cells[24,0]:='N° AULAS';
    stgimportar.Cells[25,0]:='N° BAÑOS';
    stgimportar.Cells[26,0]:='N° OFICINAS';
    stgimportar.Cells[27,0]:='AREA DE COCINA';
    stgimportar.Cells[28,0]:='CANCHA DEPORTIVA';
    stgimportar.Cells[29,0]:='BIBLIOTECA';
    stgimportar.Cells[30,0]:='COMEDOR';
    stgimportar.Cells[31,0]:='CERCA PERIMETRAL';
    stgimportar.Cells[32,0]:='SALA DE COMPUTACION';
    stgimportar.Cells[33,0]:='N° PISOS';
    stgimportar.Cells[34,0]:='AGUAS BLANCAS';
    stgimportar.Cells[35,0]:='AGUAS NEGRAS';
    stgimportar.Cells[36,0]:='FECHA DE INGRE. H. INTEGRAL';
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
    segundo.Items.Items[0].Enabled:=true;
    segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar.BitBtn10Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=5;
  stgimportar.Clean;
  stgimportar.ColCount:=5;
  // NECESIDAD DE PERSONAL
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/nece_material.xml');
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
   stgimportar.Cells[0,0]:='PLANTEL';
   stgimportar.Cells[1,0]:='NECESIDAD';
   stgimportar.Cells[2,0]:='DESCRIPCION';
   stgimportar.Cells[3,0]:='IDENTIFICADOR';
   stgimportar.Cells[4,0]:='COD_EST';
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
   segundo.Items.Items[0].Enabled:=true;
   segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar.BitBtn2Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=3;
  stgimportar.Clean;
  stgimportar.ColCount:=5;
  // PLANES PROYECTOS Y PROGRMAS DEL PLANTEL
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/plantel_ppp.xml');
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
   //TITULOS DE LAS COLUMNAS
   stgimportar.Cells[0,0]:='PLANTEL';
   stgimportar.Cells[1,0]:='PLAN EJECUTADO';
   stgimportar.Cells[2,0]:='FORMADOS';
   stgimportar.Cells[3,0]:='COD_EST';
   stgimportar.Cells[4,0]:='COD_PPP';
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
    segundo.Items.Items[0].Enabled:=true;
    segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar.BitBtn3Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=2;
  stgimportar.Clean;
  stgimportar.ColCount:=8;
  // MATRICULA DEL PLANTEL
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/matricula_plantel.xml');
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
    //TITULOS DE LAS COLUMNAS
    stgimportar.Cells[0,0]:='PLANTEL';
    stgimportar.Cells[1,0]:='GRADO';
    stgimportar.Cells[2,0]:='SECCIÓN';
    stgimportar.Cells[3,0]:='MATRICULA M';
    stgimportar.Cells[4,0]:='MATRICULA F';
    stgimportar.Cells[5,0]:='TURNO';
    stgimportar.Cells[6,0]:='NIVEL';
    stgimportar.Cells[7,0]:='COD_EST';
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
   segundo.Items.Items[0].Enabled:=true;
   segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar.BitBtn8Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=6;
  stgimportar.Clean;
  stgimportar.ColCount:=7;
  // NECESIDAD DE INFRAESTRUCTURA
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/nece_infra.xml');
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
   stgimportar.Cells[0,0]:='PLANTEL';
   stgimportar.Cells[1,0]:='UNIDAD';
   stgimportar.Cells[2,0]:='NECESIDAD';
   stgimportar.Cells[3,0]:='CANTIDAD';
   stgimportar.Cells[4,0]:='DESCRIPCION';
   stgimportar.Cells[5,0]:='IDENTIFICADOR';
   stgimportar.Cells[6,0]:='COD_EST';
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
   segundo.Items.Items[0].Enabled:=true;
   segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar.BitBtn9Click(Sender: TObject);
var
   Doc: TXMLDocument;
   i,j: Integer;
begin
  sql:=4;
  stgimportar.Clean;
  stgimportar.ColCount:=8;
  // NECESIDAD DE PERSONAL
  try
   ReadXMLFile(Doc,editdirectorio.Text+'/nece_personal.xml');
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
      //TITULOS DE LAS COLUMNAS
   stgimportar.Cells[0,0]:='PLANTEL';
   stgimportar.Cells[1,0]:='FUNCION';
   stgimportar.Cells[2,0]:='CANTIDAD';
   stgimportar.Cells[3,0]:='DESCRIPCION';
   stgimportar.Cells[4,0]:='IDENTIFICADOR';
   stgimportar.Cells[5,0]:='TIPO';
   stgimportar.Cells[6,0]:='COD_EST';
   stgimportar.Cells[7,0]:='PERSONAL ESCOGIDO';
   stgimportar.AutoSizeColumns;
   MessageDlg('Carga Exitosa de los Datos',mtInformation,[mbOK],0);
    Except
       MessageDlg('Error al Cargar DATA, Verifique si se encuentra el archivo en el directorio seleccionado',mtError,[mbOK],0);
     end;
   segundo.Items.Items[0].Enabled:=true;
   segundo.Items.Items[1].Enabled:=true;
end;

procedure Tvimportar.borrarfilaClick(Sender: TObject);
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

procedure Tvimportar.guardarxmlClick(Sender: TObject);
begin
  if sql=1 then
     begin
       savexmldatos();
     end;
  if sql=2 then
     begin
       savexmlmatricula();
     end;
  if sql=3 then
     begin
       savexmlppp();
     end;
  if sql=4 then
     begin
       savexmlneceperso();
     end;
  if sql=5 then
     begin
       savexmlnecemate();
     end;
  if sql=6 then
     begin
       savexmlneceinfra();
     end;
end;

procedure Tvimportar.btndirectorioClick(Sender: TObject);
begin
  if direccion.Execute then
     begin
       editdirectorio.Text:=direccion.FileName;
       if editdirectorio.Text<>'' then
          begin
            cabecera.Enabled:=True;
          end;
     end;
end;

procedure Tvimportar.btninsertClick(Sender: TObject);
begin
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
    dbmodule.sqlconsultas.SQL.Text:='INSERT INTO '''+esquema[combobd.ItemIndex]+'''.planteles (id_plantel, cod_estadistico, nom_plantel, municipio, parroquia,dependencia, cod_administrativo, cod_dea, ner, nom_dependencia) VALUES (DEFAULT,'''+stgimportar.Cells[8,fila]+''','''+stgimportar.Cells[0,fila]+''','''+stgimportar.Cells[2,fila]+''','''+stgimportar.Cells[12,fila]+''','''+stgimportar.Cells[3,fila]+''','''+stgimportar.Cells[6,fila]+''','''+stgimportar.Cells[7,fila]+''','''+stgimportar.Cells[1,fila]+''','''+stgimportar.Cells[4,fila]+''')';
    dbmodule.SQLTransaction.Active:=false;
    dbmodule.SQLTransaction.StartTransaction;
    dbmodule.sqlconsultas.ExecSQL;
    dbmodule.SQLTransaction.Commit;
    statusbar1.Panels[1].Text:='[+] Registro correcto';
  except
    statusbar1.Panels[1].Text:='[-] Error';
  end;
  dbmodule.pgcnx.Connected:=false;
end;

procedure Tvimportar.btntodoClick(Sender: TObject);
begin

  if sql=1 then
     begin
       cargadplantel();
     end;
  if sql=2 then
     begin
       cargamplantel();
     end;
  if sql=3 then
     begin
       cargapppplantel();
     end;
  if sql=4 then
     begin
       carganpplantel();
     end;
  if sql=5 then
     begin
       carganmplantel();
     end;
  if sql=6 then
     begin
       carganiplantel();
     end;
  conteo:=0;
  contador.Enabled:=false;
  contador.Enabled:=true;
end;

procedure Tvimportar.combobdChange(Sender: TObject);
begin
  statusbar1.Panels[3].Text:=combobd.Text;
  try
    dbmodule.pgcnx.Connected:=true;
    statusbar1.Panels[5].Text:='[+] OnLine';
    dbmodule.pgcnx.Connected:=false;
    btntodo.Enabled:=true;
    btninsert.Enabled:=true;
    cabecera.Buttons[19].Enabled:=true;
  except
    statusbar1.Panels[5].Text:='[-] OffLine';
    btntodo.Enabled:=false;
    btninsert.Enabled:=false;
    cabecera.Buttons[19].Enabled:=false;
  end;
end;

procedure Tvimportar.contadorTimer(Sender: TObject);
begin
  conteo:=conteo+1;
  if conteo=100 then
     begin
       statusbar1.Panels[1].Text:='';
     end;
end;

procedure Tvimportar.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvimportar.FormCreate(Sender: TObject);
begin
  sql:=0;
  conteo:=0;
end;

//SELECCIONAR ESQUEMA
procedure Tvimportar.selectschema();
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

//CARGA DE DATOS DEL PLANTEL
procedure Tvimportar.cargadplantel();
var
i:integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
   //TABLA PLANTELES
   for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.update_insert('''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[0,i]+''','''+stgimportar.Cells[2,i]+''','''+stgimportar.Cells[12,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[6,i]+''','''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[1,i]+''','''+stgimportar.Cells[4,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
          statusbar1.Panels[1].Text:='[+] Registro correcto';
       end;
   //TABLA DATOS
   for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.upin_datosp('''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[13,i]+''','''+stgimportar.Cells[14,i]+''','''+stgimportar.Cells[11,i]+''','''+stgimportar.Cells[5,i]+''','''+stgimportar.Cells[9,i]+''','''+stgimportar.Cells[10,i]+''','''+stgimportar.Cells[15,i]+''','''+stgimportar.Cells[16,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
       end;
   //TABLA DATO_2
   for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.upin_datosp2('''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[17,i]+''','''+stgimportar.Cells[18,i]+''','''+stgimportar.Cells[19,i]+''','''+stgimportar.Cells[36,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
       end;
   //TABLA INFRAESCTRUCTURA
   for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.upin_infrap('''+stgimportar.Cells[8,i]+''','''+stgimportar.Cells[20,i]+''','''+stgimportar.Cells[21,i]+''','''+stgimportar.Cells[22,i]+''','''+stgimportar.Cells[24,i]+''','''+stgimportar.Cells[25,i]+''','''+stgimportar.Cells[28,i]+''','''+stgimportar.Cells[31,i]+''','''+stgimportar.Cells[29,i]+''','''+stgimportar.Cells[30,i]+''','''+stgimportar.Cells[32,i]+''','''+stgimportar.Cells[33,i]+''','''+stgimportar.Cells[26,i]+''','''+stgimportar.Cells[27,i]+''','''+stgimportar.Cells[34,i]+''','''+stgimportar.Cells[35,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
       end;
  except
    statusbar1.Panels[1].Text:='[-] Error';
  end;
  dbmodule.pgcnx.Connected:=false;
end;

//CARGA DE LA MATRICULA
procedure Tvimportar.cargamplantel();
var
i:integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
     for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.upin_matricula('''+stgimportar.Cells[7,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[4,i]+''','''+stgimportar.Cells[2,i]+''','''+stgimportar.Cells[1,i]+''','''+stgimportar.Cells[6,i]+''','''+stgimportar.Cells[5,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
          statusbar1.Panels[1].Text:='[+] Registro correcto';
       end;
  except
    statusbar1.Panels[1].Text:='[-] Error';
  end;
  dbmodule.pgcnx.Connected:=false;
end;

//CARGA DE LAS NECESIDADES DE INFRAESTRUCTURA
procedure Tvimportar.carganiplantel();
var
i:integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
   try
     for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.upin_neceinfra('''+stgimportar.Cells[4,i]+''','''+stgimportar.Cells[5,i]+''','''+stgimportar.Cells[6,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[1,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
          statusbar1.Panels[1].Text:='[+] Registro correcto';
       end;
  except
    statusbar1.Panels[1].Text:='[-] Error';
  end;
  dbmodule.pgcnx.Connected:=false;
end;

//CARGA DEE NECESIDAD DE PERSONAL
procedure Tvimportar.carganpplantel();
var
i:integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
   try
     for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.upin_neceperso('''+stgimportar.Cells[4,i]+''','''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[6,i]+''','''+stgimportar.Cells[2,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
          statusbar1.Panels[1].Text:='[+] Registro correcto';
       end;
  except
    statusbar1.Panels[1].Text:='[-] Error';
  end;
  dbmodule.pgcnx.Connected:=false;
end;

//CARGA DE NECESIDAD DE MATERIALES
procedure Tvimportar.carganmplantel();
var
i:integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
     for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.upin_necemat('''+stgimportar.Cells[3,i]+''','''+stgimportar.Cells[2,i]+''','''+stgimportar.Cells[4,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
          statusbar1.Panels[1].Text:='[+] Registro correcto';
       end;
  except
    statusbar1.Panels[1].Text:='[-] Error';
  end;
  dbmodule.pgcnx.Connected:=false;
end;

//CARGA DE PPP
procedure Tvimportar.cargapppplantel();
var
i:integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  try
     for i:=1 to (stgimportar.RowCount-1) do
       begin
          dbmodule.sqlconsultas.SQL.Text:='SELECT '+esquema[combobd.ItemIndex]+'.upin_ppp('''+stgimportar.Cells[4,i]+''',''SI'','''+stgimportar.Cells[2,i]+''','''+stgimportar.Cells[3,i]+''')';
          dbmodule.SQLTransaction.Active:=false;
          dbmodule.SQLTransaction.StartTransaction;
          dbmodule.sqlconsultas.ExecSQL;
          dbmodule.SQLTransaction.Commit;
          statusbar1.Panels[1].Text:='[+] Registro correcto';
       end;
  except
    statusbar1.Panels[1].Text:='[-] Error';
  end;
  dbmodule.pgcnx.Connected:=false;
end;

procedure Tvimportar.FormShow(Sender: TObject);
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

procedure Tvimportar.stgimportarSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
begin
  fila:=aRow;
  columna:=aCol;
end;

procedure Tvimportar.savexmldatos();
var
 Doc: TXMLDocument;
 RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
 i,control,control2,j: integer;
 nombrenodo:Array[0..50] of String;
begin

//NOMBRE DE LOS NODOS HIJOS
  nombrenodo[0]:='plantel';
  nombrenodo[1]:='ner';
  nombrenodo[2]:='municipio';
  nombrenodo[3]:='dependencia';
  nombrenodo[4]:='des_cdep';
  nombrenodo[5]:='tipo';
  nombrenodo[6]:='cod_adm';
  nombrenodo[7]:='cod_dea';
  nombrenodo[8]:='cod_est';
  nombrenodo[9]:='telefono';
  nombrenodo[10]:='correo';
  nombrenodo[11]:='horario';
  nombrenodo[12]:='parroquia';
  nombrenodo[13]:='direccion';
  nombrenodo[14]:='ubic_geograf';
  nombrenodo[15]:='longitud';
  nombrenodo[16]:='latitud';
  nombrenodo[17]:='resena';
  nombrenodo[18]:='act_soce';
  nombrenodo[19]:='act_socp';
  nombrenodo[20]:='infraestructura';
  nombrenodo[21]:='tenencia';
  nombrenodo[22]:='medidas_terreno';
  nombrenodo[23]:='plantel_constr';
  nombrenodo[24]:='n_aulas';
  nombrenodo[25]:='n_banos';
  nombrenodo[26]:='n_oficina';
  nombrenodo[27]:='area_cocina';
  nombrenodo[28]:='cancha_dep';
  nombrenodo[29]:='bilioteca';
  nombrenodo[30]:='comedor';
  nombrenodo[31]:='cerca_perime';
  nombrenodo[32]:='sala_compu';
  nombrenodo[33]:='n_pisos';
  nombrenodo[34]:='agua_blanca';
  nombrenodo[35]:='agua_negra';
  nombrenodo[36]:='feha_hinte';

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
   //GUARDAR XML DE DATOS
   try
     // Crear el documento
     Doc:= TXMLDocument.Create;
     // Crear el nodo raiz
     RootNode := Doc.CreateElement('plantel');
     Doc.Appendchild(RootNode);
     RootNode:= Doc.DocumentElement;
     control:=stgimportar.RowCount;
     control2:=stgimportar.ColCount;
     // Crear los nodos
     for i := 0 to (control-1) do
       begin
         ElementNode:=Doc.CreateElement('datos_plantel');
          for j:=0 to  (control2-1) do
            begin
             ItemNode:=Doc.CreateElement(nombrenodo[j]);
             TextNode:=Doc.CreateTextNode(stgimportar.Cells[j,i]);
             ItemNode.AppendChild(TextNode);
             ElementNode.AppendChild(ItemNode);
            end;
         RootNode.AppendChild(ElementNode);
       end;
       // Guardar el XML
       WriteXMLFile(Doc,editdirectorio.Text+'/datos_plantel.xml');
       Doc.Free;
       MessageDlg('Se ha guardado el archivo',mtInformation,[mbOK],0);
     Except
        MessageDlg('Error al guardar', mtError,[mbOK],0);
     end;
end;

procedure Tvimportar.savexmlmatricula();
var
 Doc2: TXMLDocument;
 RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
 i,control,control2,j: integer;
 nombrenodo2:Array[0..50] of String;
begin

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

  //NOMBRE DE LOS NODOS HIJOS
  nombrenodo2[0]:='plantel';
  nombrenodo2[1]:='grado';
  nombrenodo2[2]:='seccion';
  nombrenodo2[3]:='matricula_m';
  nombrenodo2[4]:='matricula_f';
  nombrenodo2[5]:='turno';
  nombrenodo2[6]:='nivel';
  nombrenodo2[7]:='cod_est';
   //GUARDAR XML DE MATRICULA
   try
     // Crear el documento
     Doc2 := TXMLDocument.Create;
     // Crear el nodo raiz
     RootNode := Doc2.CreateElement('plantel');
     Doc2.Appendchild(RootNode);
     RootNode:= Doc2.DocumentElement;
     control:=stgimportar.RowCount;
     control2:=stgimportar.ColCount;
     // Crear los nodos
     for i := 0 to (control-1) do
       begin
         ElementNode:=Doc2.CreateElement('matricula_plantel');
          for j:=0 to (control2-1) do
           begin
             ItemNode:=Doc2.CreateElement(nombrenodo2[j]);
             TextNode:=Doc2.CreateTextNode(stgimportar.Cells[j,i]);
             ItemNode.AppendChild(TextNode);
             ElementNode.AppendChild(ItemNode);
           end;
         RootNode.AppendChild(ElementNode);
       end;
       // Guardar el XML
       WriteXMLFile(Doc2,editdirectorio.Text+'/matricula_plantel.xml');
       Doc2.Free;
       MessageDlg('Se ha guardado el archivo',mtInformation,[mbOK],0);
   Except
       MessageDlg('Error al guardar', mtError,[mbOK],0);
   end;
end;

procedure Tvimportar.savexmlppp();
var
Doc: TXMLDocument;
RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
i,control,control2,j: integer;
nombrenodo:Array[0..50] of String;
begin

  //NOMBRE DE LOS NODOS HIJOS
  nombrenodo[0]:='plantel';
  nombrenodo[1]:='ejecutado';
  nombrenodo[2]:='formado';
  nombrenodo[3]:='cod_est';
  nombrenodo[4]:='cod_ppp';

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

 //GUARDAR XML DE PLANES PROYECTOS Y PROGRAMAS
 try
   // Crear el documento
   Doc := TXMLDocument.Create;
   // Crear el nodo raiz
   RootNode := Doc.CreateElement('plantel');
   Doc.Appendchild(RootNode);
   RootNode:= Doc.DocumentElement;
   control:=stgimportar.RowCount;
   control2:=stgimportar.ColCount;
   //CREAR LOS NODOS
   for i := 0 to (control-1) do
     begin
       ElementNode:=Doc.CreateElement('p_p_p');
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
     WriteXMLFile(Doc,editdirectorio.Text+'/plantel_ppp.xml');
     Doc.Free;
     MessageDlg('Se ha guardado el archivo',mtInformation,[mbOK],0);
 Except
     MessageDlg('No se guardo el archivo', mtError,[mbOK],0);
 end;
end;

procedure Tvimportar.savexmlneceperso();
var
Doc: TXMLDocument;
RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
i,control,control2,j: integer;
nombrenodo:Array[0..50] of String;
begin
  //NOMBRE DE LOS NODOS HIJOS
  nombrenodo[0]:='plantel';
  nombrenodo[1]:='funcion';
  nombrenodo[2]:='cantidad';
  nombrenodo[3]:='descripcion';
  nombrenodo[4]:='identificador';
  nombrenodo[5]:='tipo';
  nombrenodo[6]:='cod_est';
  nombrenodo[7]:='escogido';

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
  //GUARDAR XML DE NECESIDAD DE PERSONAL
   try
     // Crear el documento
     Doc := TXMLDocument.Create;
     // Crear el nodo raiz
     RootNode := Doc.CreateElement('plantel');
     Doc.Appendchild(RootNode);
     RootNode:= Doc.DocumentElement;
     control:=stgimportar.RowCount;
     control2:=stgimportar.ColCount;
     // Crear los nodos
     for i := 0 to (control-1) do
       begin
         ElementNode:=Doc.CreateElement('necesidad_personal');
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
       WriteXMLFile(Doc,editdirectorio.Text+'/nece_personal.xml');
       Doc.Free;
       MessageDlg('Se ha guardado el archivo',mtInformation,[mbOK],0);
   Except
       MessageDlg('Error al guardar archivo', mtError,[mbOK],0);
   end;
end;

procedure Tvimportar.savexmlnecemate();
var
Doc: TXMLDocument;
RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
i,control,control2,j: integer;
nombrenodo:Array[0..50] of String;
begin
  //NOMBRE DE LOS NODOS HIJOS
  nombrenodo[0]:='plantel';
  nombrenodo[1]:='necesidad';
  nombrenodo[2]:='descripcion';
  nombrenodo[3]:='identificador';
  nombrenodo[4]:='cod_est';

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

 //GUARDAR XML DE NECESIDAD DE MATERIAL
   try
     // Crear el documento
     Doc := TXMLDocument.Create;
     // Crear el nodo raiz
     RootNode := Doc.CreateElement('plantel');
     Doc.Appendchild(RootNode);
     RootNode:= Doc.DocumentElement;
     control:=stgimportar.RowCount;
     control2:=stgimportar.ColCount;
     // Crear los nodos
     for i := 0 to (control-1) do
       begin
         ElementNode:=Doc.CreateElement('necesidad_material');
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
       WriteXMLFile(Doc,editdirectorio.Text+'/nece_material.xml');
       Doc.Free;
       MessageDlg('Se ha guardado el archivo',mtInformation,[mbOK],0);
   Except
       MessageDlg('No se guardo el archivo', mtError,[mbOK],0);
   end;
end;

procedure Tvimportar.savexmlneceinfra();
var
Doc: TXMLDocument;
RootNode, ElementNode,ItemNode,TextNode: TDOMNode;
i,control,control2,j: integer;
nombrenodo:Array[0..50] of String;
begin
  //NOMBRE DE LOS NODOS HIJOS
  nombrenodo[0]:='plantel';
  nombrenodo[1]:='unidad';
  nombrenodo[2]:='necesidad';
  nombrenodo[3]:='cantidad';
  nombrenodo[4]:='descripcion';
  nombrenodo[5]:='identificador';
  nombrenodo[6]:='tipo';
  nombrenodo[7]:='cod_est';

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
 //GUARDAR XML DE NECESIDAD DE INFRAESTRUCTURA
   try
     // Crear el documento
     Doc := TXMLDocument.Create;
     // Crear el nodo raiz
     RootNode := Doc.CreateElement('plantel');
     Doc.Appendchild(RootNode);
     RootNode:= Doc.DocumentElement;
     control:=stgimportar.RowCount;
     control2:=stgimportar.ColCount;
     // Crear los nodos
     for i := 0 to (control-1) do
       begin
         ElementNode:=Doc.CreateElement('necesidad_infra');
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
       WriteXMLFile(Doc,editdirectorio.Text+'/nece_infra.xml');
       Doc.Free;
       MessageDlg('Se ha Guardado el archivo',mtInformation,[mbOK],0);
   Except
       MessageDlg('No se guardo el archivo', mtError,[mbOK],0);
   end;
end;

end.

