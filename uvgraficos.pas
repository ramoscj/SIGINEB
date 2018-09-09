unit uvgraficos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, memds, db, FileUtil, TAGraph, TASources, TALegendPanel,
  TASeries, TADbSource, TAStyles, TAIntervalSources, TATransformations,
  TANavigation, Forms, Controls, Graphics, Dialogs, DBGrids, Buttons, Grids,
  StdCtrls, ExtCtrls, ComCtrls, uvbd, TALegend, types, TAFuncSeries;

type

  { Tvgraficos }

  Tvgraficos = class(TForm)
    btncolor: TColorButton;
    Chart1: TChart;
    Chart1AreaSeries1: TAreaSeries;
    Chart1BarSeries1: TBarSeries;
    Chart1LineSeries1: TLineSeries;
    img: TImageList;
    mininav: TChartNavPanel;
    ChartStyles1: TChartStyles;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    combobuscar: TComboBox;
    combobd: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    barra: TListChartSource;
    mostrarlineas: TCheckBox;
    Panel1: TPanel;
    Panel2: TPanel;
    probar: TListChartSource;
    RadioGroup1: TRadioGroup;
    rdbgeneral: TRadioButton;
    rdbtipo: TRadioButton;
    SaveDialog1: TSaveDialog;
    statusbar1: TStatusBar;
    stgdatos: TStringGrid;
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
    procedure btncolorColorChanged(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure CheckBox6Change(Sender: TObject);
    procedure combobdChange(Sender: TObject);
    procedure combobuscarChange(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure mostrarlineasChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure necepersomuni();
    procedure modplantelmuni();
    procedure neceartimuni();
    procedure neceinframuni();
    procedure matriculamuni();
    procedure rdbgeneralChange(Sender: TObject);
    procedure rdbtipoChange(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure listarneceperso();
    procedure listarnecepersocambio();
    procedure listarmodplantel();
    procedure listarmodplantelcambio();
    procedure listarnecesarti();
    procedure listarnecearticambio();
    procedure listarneceinfra();
    procedure listarneceinfracambio();
    procedure listarmatricula();
    procedure selectschema();
    procedure listarmatriculacambio();
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
  private
    { private declarations }
    function GetFileName(const AExt: String): String;
  public
    { public declarations }
  end;

var
  vgraficos: Tvgraficos;
  esquema: array [1..99999] of String;
  muni:array [0..11] of String;

implementation

{$R *.lfm}

{ Tvgraficos }

uses
  TADrawerSVG, TADrawUtils, TADrawerCanvas;

function Tvgraficos.GetFileName(const AExt: String): String;
begin
  with SaveDialog1 do begin
    FileName := '';
    DefaultExt := AExt;
    if not Execute then Abort;
    Result := FileName;
  end;
end;

procedure Tvgraficos.FormShow(Sender: TObject);
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
  dbmodule.pgcnx.Connected:=false;
  muni[0]:='A.A.T';
  muni[2]:='A.E.B.';
  muni[1]:='A.J.S';
  muni[3]:='ARISMENDI';
  muni[4]:='BOLIVAR';
  muni[5]:='BARINAS';
  muni[6]:='EZEQUIEL Z.';
  muni[7]:='CRUZ P.';
  muni[8]:='OBISPOS';
  muni[9]:='PEDRAZA';
  muni[10]:='SOSA';
  muni[11]:='ROJAS';
end;

procedure Tvgraficos.selectschema();
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


procedure Tvgraficos.FormCreate(Sender: TObject);
begin

end;

procedure Tvgraficos.btncolorColorChanged(Sender: TObject);
begin
  Chart1.BackColor:=btncolor.ButtonColor;
end;


procedure Tvgraficos.CheckBox1Change(Sender: TObject);
begin
  Chart1.BottomAxis.Visible:=CheckBox1.Checked;
end;

procedure Tvgraficos.CheckBox2Change(Sender: TObject);
begin
  Chart1.LeftAxis.Visible:=CheckBox2.Checked;
end;

procedure Tvgraficos.CheckBox3Change(Sender: TObject);
begin
  Chart1.Title.Visible:=CheckBox3.Checked;
end;

procedure Tvgraficos.CheckBox4Change(Sender: TObject);
begin
  Chart1.BottomAxis.Inverted := CheckBox4.Checked;
  Chart1.LeftAxis.Inverted := CheckBox4.Checked;
end;

procedure Tvgraficos.CheckBox5Change(Sender: TObject);
begin
  Chart1.Legend.Visible:=CheckBox5.Checked;
end;

procedure Tvgraficos.CheckBox6Change(Sender: TObject);
begin

end;

procedure Tvgraficos.combobdChange(Sender: TObject);
begin
  statusbar1.Panels[3].Text:=combobd.Text;
  try
    dbmodule.pgcnx.Connected:=true;
    statusbar1.Panels[5].Text:='[+] OnLine';
    Panel1.Enabled:=true;
    combobuscar.ItemIndex:=0;
    Chart1AreaSeries1.Clear;
    Chart1BarSeries1.Clear;
    Chart1LineSeries1.Clear;
    dbmodule.pgcnx.Connected:=false;
  except
    statusbar1.Panels[5].Text:='[-] OffLine';
    Panel1.Enabled:=false;
    combobuscar.ItemIndex:=0;
    Chart1AreaSeries1.Clear;
    Chart1BarSeries1.Clear;
    Chart1LineSeries1.Clear;
  end;

end;

procedure Tvgraficos.combobuscarChange(Sender: TObject);
begin
  statusbar1.Panels[1].Text:=combobuscar.Text;
  if combobuscar.ItemIndex=1 then
    begin
      listarmodplantel();
    end;
  if combobuscar.ItemIndex=2 then
    begin
      listarneceperso();
    end;
  if combobuscar.ItemIndex=3 then
    begin
      listarnecesarti();
    end;
  if combobuscar.ItemIndex=4 then
    begin
      listarneceinfra();
    end;
  if combobuscar.ItemIndex=5 then
    begin
      listarmatricula();
    end;
end;

procedure Tvgraficos.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

//NECESIDAD DE PERSONAL GENERAL
procedure Tvgraficos.listarneceperso();
var
  i:Integer;
begin
  barra.YCount:=1;
  necepersomuni();
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='%2:s';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='%2:s';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='%2:s';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  for i:=1 to (stgdatos.RowCount-1) do
  begin
    barra.Add(i,StrToFloat(stgdatos.Cells[1,i]),muni[i-1]);
  end;
  Chart1.Title.Text.Text:='Necesidad de Personal de las Escuelas Primarias del Estado Barinas '+combobd.Text;
end;

//NECESIDAD DE PERSONAL POR TIPO
procedure Tvgraficos.listarnecepersocambio();
var
  i:Integer;
begin
  barra.YCount:=3;
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  ChartStyles1.Styles.Style[0].Text:='ADMINISTRATIVO';
  ChartStyles1.Styles.Style[1].Text:='DOCENTE';
  ChartStyles1.Styles.Style[2].Text:='OBRERO';
  ChartStyles1.Styles.Style[3].Text:='';
  ChartStyles1.Styles.Style[4].Text:='';
  ChartStyles1.Styles.Style[2].Brush.Color:=clRed;
  ChartStyles1.Styles.Style[3].Brush.Color:=clWhite;
  ChartStyles1.Styles.Style[4].Brush.Color:=clWhite;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      barra.AddXYList(i,[StrToFloat(stgdatos.Cells[2,i]),StrToFloat(stgdatos.Cells[3,i]),StrToFloat(stgdatos.Cells[4,i])],muni[i-1]);
    end;
end;

//PLANTEL POR MODALIDAD
procedure Tvgraficos.listarmodplantel();
var
  i:Integer;
begin
  barra.YCount:=1;
  modplantelmuni();
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='%2:s';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='%2:s';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='%2:s';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  for i:=1 to (stgdatos.RowCount-1) do
  begin
    barra.Add(i,StrToFloat(stgdatos.Cells[1,i]),muni[i-1]);
  end;
  Chart1.Title.Text.Text:='Escuelas Primarias del Estado Barinas '+combobd.Text+' por Modalidad';
end;

//PLANTEL MODALIDAD POR TIPO
procedure Tvgraficos.listarmodplantelcambio();
var
  i:Integer;
begin
  barra.YCount:=4;
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  ChartStyles1.Styles.Style[0].Text:='CONCENTRADA';
  ChartStyles1.Styles.Style[1].Text:='BOLIVARIANA';
  ChartStyles1.Styles.Style[2].Text:='UNIDAD EDUCATIVA';
  ChartStyles1.Styles.Style[3].Text:='UNITARIA';
  ChartStyles1.Styles.Style[2].Brush.Color:=clRed;
  ChartStyles1.Styles.Style[3].Brush.Color:=clBlue;
  ChartStyles1.Styles.Style[4].Brush.Color:=clWhite;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      barra.AddXYList(i,[StrToFloat(stgdatos.Cells[2,i]),StrToFloat(stgdatos.Cells[3,i]),StrToFloat(stgdatos.Cells[4,i]),StrToFloat(stgdatos.Cells[5,i])],muni[i-1]);
    end;
end;

//NECESIDAD DE ARTICULOS
procedure Tvgraficos.listarnecesarti();
var
  i:Integer;
begin
  barra.YCount:=1;
  neceartimuni();
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='%2:s';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='%2:s';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='%2:s';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  for i:=1 to (stgdatos.RowCount-1) do
  begin
    barra.Add(i,StrToFloat(stgdatos.Cells[1,i]),muni[i-1]);
  end;
  Chart1.Title.Text.Text:='Necesidad de Materiales de las Escuelas Primarias del Estado Barinas '+combobd.Text;
end;

//NECESIDAD DE ARTICULOS POR TIPO
procedure Tvgraficos.listarnecearticambio();
var
  i:Integer;
begin
  barra.YCount:=5;
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  ChartStyles1.Styles.Style[0].Text:='Artc. Oficina';
  ChartStyles1.Styles.Style[1].Text:='Artc. Limpieza';
  ChartStyles1.Styles.Style[2].Text:='Artc. Deportivo';
  ChartStyles1.Styles.Style[3].Text:='Mobiliario';
  ChartStyles1.Styles.Style[4].Text:='Mesas-Sillas';
  ChartStyles1.Styles.Style[2].Brush.Color:=clRed;
  ChartStyles1.Styles.Style[3].Brush.Color:=clBlue;
  ChartStyles1.Styles.Style[4].Brush.Color:=clAqua;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      barra.AddXYList(i,[StrToFloat(stgdatos.Cells[2,i]),StrToFloat(stgdatos.Cells[3,i]),StrToFloat(stgdatos.Cells[4,i]),StrToFloat(stgdatos.Cells[5,i]),StrToFloat(stgdatos.Cells[6,i])],muni[i-1]);
    end;
end;

//NECESIDAD DE INFRAESTRUCTURA
procedure Tvgraficos.listarneceinfra();
var
  i:Integer;
begin
  barra.YCount:=1;
  neceinframuni();
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='%2:s';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='%2:s';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='%2:s';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  for i:=1 to (stgdatos.RowCount-1) do
  begin
    barra.Add(i,StrToFloat(stgdatos.Cells[1,i]),muni[i-1]);
  end;
  Chart1.Title.Text.Text:='Necesidad de Infraestructura de las Escuelas Primarias del Estado Barinas '+combobd.Text;
end;

//NECESIDAD DE INFRAESTRUCTURA POR TIPO
procedure Tvgraficos.listarneceinfracambio();
var
  i:Integer;
begin
  barra.YCount:=3;
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  ChartStyles1.Styles.Style[0].Text:='Construcción';
  ChartStyles1.Styles.Style[1].Text:='Ampliación';
  ChartStyles1.Styles.Style[2].Text:='Rehabilitación';
  ChartStyles1.Styles.Style[3].Text:='';
  ChartStyles1.Styles.Style[4].Text:='';
  ChartStyles1.Styles.Style[2].Brush.Color:=clRed;
  ChartStyles1.Styles.Style[3].Brush.Color:=clWhite;
  ChartStyles1.Styles.Style[4].Brush.Color:=clWhite;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      barra.AddXYList(i,[StrToFloat(stgdatos.Cells[2,i]),StrToFloat(stgdatos.Cells[3,i]),StrToFloat(stgdatos.Cells[4,i])],muni[i-1]);
    end;
end;

//MATRICULA POR MUNICIPIO
procedure Tvgraficos.listarmatricula();
var
  i:Integer;
begin
  barra.YCount:=1;
  matriculamuni();
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='%2:s';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='%2:s';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='%2:s';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmPoint);
  for i:=1 to (stgdatos.RowCount-1) do
  begin
    barra.Add(i,StrToFloat(stgdatos.Cells[1,i]),muni[i-1]);
  end;
  Chart1.Title.Text.Text:='Matricula de las Escuelas Primarias del Estado Barinas '+combobd.Text;
end;

//MARICULA POR TIPO
procedure Tvgraficos.listarmatriculacambio();
var
  i:Integer;
begin
  barra.YCount:=2;
  Chart1BarSeries1.Clear;
  Chart1BarSeries1.Legend.Format:='';
  Chart1BarSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1LineSeries1.Clear;
  Chart1LineSeries1.Legend.Format:='';
  Chart1LineSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  Chart1AreaSeries1.Clear;
  Chart1AreaSeries1.Legend.Format:='';
  Chart1AreaSeries1.Legend.Multiplicity:=TLegendMultiplicity(lmStyle);
  ChartStyles1.Styles.Style[0].Text:='Varones';
  ChartStyles1.Styles.Style[1].Text:='Hembras';
  ChartStyles1.Styles.Style[2].Text:='';
  ChartStyles1.Styles.Style[3].Text:='';
  ChartStyles1.Styles.Style[4].Text:='';
  ChartStyles1.Styles.Style[2].Brush.Color:=clWhite;
  ChartStyles1.Styles.Style[3].Brush.Color:=clWhite;
  ChartStyles1.Styles.Style[4].Brush.Color:=clWhite;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      barra.AddXYList(i,[StrToFloat(stgdatos.Cells[2,i]),StrToFloat(stgdatos.Cells[3,i])],muni[i-1]);
    end;
end;

procedure Tvgraficos.ToolButton10Click(Sender: TObject);
begin
  try
    Chart1.SaveToBitmapFile(GetFileName('jpg'));
    MessageDlg('Se guardo correctamente',mtInformation,[mbOK],0);
  except
    MessageDlg('Error al guardar',mtError,[mbOK],0);
  end;
end;

procedure Tvgraficos.ToolButton14Click(Sender: TObject);
  var
  fs: TFileStream;
  id: IChartDrawer;
begin
  fs := TFileStream.Create(GetFileName('svg'), fmCreate);
  try
    id := TSVGDrawer.Create(fs, true);
    id.DoChartColorToFPColor := @ChartColorSysToFPColor;
    with Chart1 do
      begin
      Draw(id, Rect(0, 0, Width, Height));
      end;
    MessageDlg('Se guardo correctamente',mtInformation,[mbOK],0);
  Except
    MessageDlg('Error al guardar',mtError,[mbOK],0);
  end;
  fs.Free;
end;

procedure Tvgraficos.ToolButton18Click(Sender: TObject);
begin
  Chart1.CopyToClipboardBitmap;
end;

procedure Tvgraficos.ToolButton1Click(Sender: TObject);
begin
  try
    Chart1.SaveToBitmapFile(GetFileName('bmp'));
    MessageDlg('Se guardo correctamente',mtInformation,[mbOK],0);
  except
    MessageDlg('Error al guardar',mtError,[mbOK],0);
  end;
end;

procedure Tvgraficos.ToolButton6Click(Sender: TObject);
begin
  try
    Chart1.SaveToBitmapFile(GetFileName('png'));
    MessageDlg('Se guardo correctamente',mtInformation,[mbOK],0);
  except
    MessageDlg('Error al guardar',mtError,[mbOK],0);
  end;
end;

//TRAER DATOS DE PLANTELES POR MODALIDAD
procedure Tvgraficos.modplantelmuni();
var
  i,j:Integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgdatos.Clean;
  stgdatos.RowCount:=13;
  stgdatos.Cells[0,1]:='ALBERTO ARBELO TORREALBA';
  stgdatos.Cells[0,2]:='ANTONIO JOSE DE SUCRE';
  stgdatos.Cells[0,3]:='ANDRES ELOY BLANCO';
  stgdatos.Cells[0,4]:='ARISMENDI';
  stgdatos.Cells[0,5]:='BOLIVAR';
  stgdatos.Cells[0,6]:='BARINAS';
  stgdatos.Cells[0,7]:='CRUZ PAREDES';
  stgdatos.Cells[0,8]:='EZEQUIEL ZAMORA';
  stgdatos.Cells[0,9]:='OBISPOS';
  stgdatos.Cells[0,10]:='PEDRAZA';
  stgdatos.Cells[0,11]:='PEDRO FELIPE SOSA';
  stgdatos.Cells[0,12]:='PEDRO MANUEL ROJAS';
  stgdatos.AutoSizeColumns;
  try
  i:=1;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select municipio,sum(cuantos) as total from '+esquema[combobd.ItemIndex]+'.vista_cantmoddplan where municipio='''+stgdatos.Cells[0,i]+''' group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //CONCENTRADA
      dbmodule.sqlconsultas.SQL.Text:='select municipio,modalidad,count(modalidad) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_modplantelgn where municipio='''+stgdatos.Cells[0,i]+''' and modalidad=''CONCENTRADA'' group by municipio,modalidad';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //BOLIVARIANA
      dbmodule.sqlconsultas.SQL.Text:='select municipio,modalidad,count(modalidad) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_modplantelgn where municipio='''+stgdatos.Cells[0,i]+''' and modalidad=''BOLIVARIANA'' group by municipio,modalidad';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[3,i]:=dbmodule.sqlconsultas.Fields[2].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //UNDAD EDUCATIVA
      dbmodule.sqlconsultas.SQL.Text:='select municipio,modalidad,count(modalidad) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_modplantelgn where municipio='''+stgdatos.Cells[0,i]+''' and modalidad=''UNIDAD EDUCATIVA'' group by municipio,modalidad';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[4,i]:=dbmodule.sqlconsultas.Fields[2].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //UNITARIA
      dbmodule.sqlconsultas.SQL.Text:='select municipio,modalidad,count(modalidad) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_modplantelgn where municipio='''+stgdatos.Cells[0,i]+''' and modalidad=''UNITARIA'' group by municipio,modalidad';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[5,i]:=dbmodule.sqlconsultas.Fields[2].Text;
              dbmodule.sqlconsultas.Next;
           end;
    end;
  dbmodule.pgcnx.Connected:=false;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      for j:=1 to 5 do
        begin
          if stgdatos.Cells[j,i]='' then
            begin
              stgdatos.Cells[j,i]:='0';
            end;
        end;
    end;

  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
    dbmodule.pgcnx.Connected:=False;
  end;

end;

procedure Tvgraficos.mostrarlineasChange(Sender: TObject);
begin
  Chart1.BottomAxis.Visible:=mostrarlineas.Checked;
  Chart1.LeftAxis.Visible:=mostrarlineas.Checked;
end;

//TRAER DATOS DE NECESIDAD DE PERSONAL
procedure Tvgraficos.necepersomuni();
var
  i,j:Integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgdatos.Clean;
  stgdatos.RowCount:=13;
  stgdatos.Cells[0,1]:='ALBERTO ARBELO TORREALBA';
  stgdatos.Cells[0,2]:='ANTONIO JOSE DE SUCRE';
  stgdatos.Cells[0,3]:='ANDRES ELOY BLANCO';
  stgdatos.Cells[0,4]:='ARISMENDI';
  stgdatos.Cells[0,5]:='BOLIVAR';
  stgdatos.Cells[0,6]:='BARINAS';
  stgdatos.Cells[0,7]:='CRUZ PAREDES';
  stgdatos.Cells[0,8]:='EZEQUIEL ZAMORA';
  stgdatos.Cells[0,9]:='OBISPOS';
  stgdatos.Cells[0,10]:='PEDRAZA';
  stgdatos.Cells[0,11]:='PEDRO FELIPE SOSA';
  stgdatos.Cells[0,12]:='PEDRO MANUEL ROJAS';
  stgdatos.AutoSizeColumns;
  try
  i:=1;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_grafnecperso where municipio='''+stgdatos.Cells[0,i]+'''';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //PERSONAL ADMINISTRATIVO
      dbmodule.sqlconsultas.SQL.Text:='select municipio,sum(total) from '+esquema[combobd.ItemIndex]+'.vista_necepersoadm where municipio='''+stgdatos.Cells[0,i]+''' group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[2,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //PERSONAL DOCENTE
      dbmodule.sqlconsultas.SQL.Text:='select municipio,sum(total) from vista_necepersodoc where municipio='''+stgdatos.Cells[0,i]+''' group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[3,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //PERSONAL OBRERO
      dbmodule.sqlconsultas.SQL.Text:='select municipio,sum(total) from vista_necepersoobr where municipio='''+stgdatos.Cells[0,i]+''' group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[4,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      dbmodule.pgcnx.Connected:=false;
      stgdatos.AutoSizeColumns;
    end;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      for j:=1 to 4 do
        begin
          if stgdatos.Cells[j,i]='' then
            begin
              stgdatos.Cells[j,i]:='0';
            end;
        end;
    end;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
    dbmodule.pgcnx.Connected:=false;
  end;

end;

//LISTAR NECESIDAD DE ARTICULOS POR MUNICIPIO
procedure Tvgraficos.neceartimuni();
var
  i,j:Integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgdatos.Clean;
  stgdatos.RowCount:=13;
  stgdatos.Cells[0,1]:='ALBERTO ARBELO TORREALBA';
  stgdatos.Cells[0,2]:='ANTONIO JOSE DE SUCRE';
  stgdatos.Cells[0,3]:='ANDRES ELOY BLANCO';
  stgdatos.Cells[0,4]:='ARISMENDI';
  stgdatos.Cells[0,5]:='BOLIVAR';
  stgdatos.Cells[0,6]:='BARINAS';
  stgdatos.Cells[0,7]:='CRUZ PAREDES';
  stgdatos.Cells[0,8]:='EZEQUIEL ZAMORA';
  stgdatos.Cells[0,9]:='OBISPOS';
  stgdatos.Cells[0,10]:='PEDRAZA';
  stgdatos.Cells[0,11]:='PEDRO FELIPE SOSA';
  stgdatos.Cells[0,12]:='PEDRO MANUEL ROJAS';
  stgdatos.AutoSizeColumns;
  try
  i:=1;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necp) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceartig where municipio='''+stgdatos.Cells[0,i]+''' group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //ARTIC. DE OFICINA
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necp) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceartig where municipio='''+stgdatos.Cells[0,i]+''' and id_necp=7 group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[2,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //ARTTC. DE LIMPIEZA
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necp) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceartig where municipio='''+stgdatos.Cells[0,i]+''' and id_necp=8 group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[3,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //ARTIC. DEPORTIVO
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necp) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceartig where municipio='''+stgdatos.Cells[0,i]+''' and id_necp=9 group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[4,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //MOBILIARIO
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necp) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceartig where municipio='''+stgdatos.Cells[0,i]+''' and id_necp=10 group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[5,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //MESAS-SILLAS
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necp) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceartig where municipio='''+stgdatos.Cells[0,i]+''' and id_necp=11 group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
         while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[6,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
    end;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      for j:=1 to 6 do
        begin
          if stgdatos.Cells[j,i]='' then
            begin
              stgdatos.Cells[j,i]:='0';
            end;
        end;
    end;
  dbmodule.pgcnx.Connected:=false;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
    dbmodule.pgcnx.Connected:=false;
  end;

end;

//TRAER DATOS DE NECESIDAD DE INFRAESTRUCTURA
procedure Tvgraficos.neceinframuni();
var
  i,j:Integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgdatos.Clean;
  stgdatos.RowCount:=13;
  stgdatos.Cells[0,1]:='ALBERTO ARBELO TORREALBA';
  stgdatos.Cells[0,2]:='ANTONIO JOSE DE SUCRE';
  stgdatos.Cells[0,3]:='ANDRES ELOY BLANCO';
  stgdatos.Cells[0,4]:='ARISMENDI';
  stgdatos.Cells[0,5]:='BOLIVAR';
  stgdatos.Cells[0,6]:='BARINAS';
  stgdatos.Cells[0,7]:='CRUZ PAREDES';
  stgdatos.Cells[0,8]:='EZEQUIEL ZAMORA';
  stgdatos.Cells[0,9]:='OBISPOS';
  stgdatos.Cells[0,10]:='PEDRAZA';
  stgdatos.Cells[0,11]:='PEDRO FELIPE SOSA';
  stgdatos.Cells[0,12]:='PEDRO MANUEL ROJAS';
  stgdatos.AutoSizeColumns;
  try
  i:=1;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necs) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceinfrag where municipio='''+stgdatos.Cells[0,i]+''' group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //CONTRUCCION
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necs) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceinfrag where municipio='''+stgdatos.Cells[0,i]+''' and id_control=3 group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[2,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //AMPLIACION
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necs) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceinfrag where municipio='''+stgdatos.Cells[0,i]+''' and id_control=4 group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[3,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
      //REHABILITACION
      dbmodule.sqlconsultas.SQL.Text:='select municipio,count(id_necs) as cuantos from '+esquema[combobd.ItemIndex]+'.vista_neceinfrag where municipio='''+stgdatos.Cells[0,i]+''' and id_control=5 group by municipio';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[4,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              dbmodule.sqlconsultas.Next;
           end;
    end;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      for j:=1 to 4 do
        begin
          if stgdatos.Cells[j,i]='' then
            begin
              stgdatos.Cells[j,i]:='0';
            end;
        end;
    end;
  dbmodule.pgcnx.Connected:=false;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
    dbmodule.pgcnx.Connected:=false;
  end;

end;

//TRAER DATOS DE MATRICULA
procedure Tvgraficos.matriculamuni();
var
  i,j:Integer;
begin
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgdatos.Clean;
  stgdatos.RowCount:=13;
  stgdatos.Cells[0,1]:='ALBERTO ARBELO TORREALBA';
  stgdatos.Cells[0,2]:='ANTONIO JOSE DE SUCRE';
  stgdatos.Cells[0,3]:='ANDRES ELOY BLANCO';
  stgdatos.Cells[0,4]:='ARISMENDI';
  stgdatos.Cells[0,5]:='BOLIVAR';
  stgdatos.Cells[0,6]:='BARINAS';
  stgdatos.Cells[0,7]:='CRUZ PAREDES';
  stgdatos.Cells[0,8]:='EZEQUIEL ZAMORA';
  stgdatos.Cells[0,9]:='OBISPOS';
  stgdatos.Cells[0,10]:='PEDRAZA';
  stgdatos.Cells[0,11]:='PEDRO FELIPE SOSA';
  stgdatos.Cells[0,12]:='PEDRO MANUEL ROJAS';
  stgdatos.AutoSizeColumns;
  try
  i:=1;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_matripormuni where municipio='''+stgdatos.Cells[0,i]+'''';
      dbmodule.SQLTransaction.Active:=false;
      dbmodule.SQLTransaction.StartTransaction;
      dbmodule.sqlconsultas.Open;
        while not dbmodule.sqlconsultas.EOF do
           begin
              stgdatos.Cells[1,i]:=dbmodule.sqlconsultas.Fields[3].Text;
              stgdatos.Cells[2,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              stgdatos.Cells[3,i]:=dbmodule.sqlconsultas.Fields[2].Text;
              dbmodule.sqlconsultas.Next;
           end;
    end;
  for i:=1 to (stgdatos.RowCount-1) do
    begin
      for j:=1 to 3 do
        begin
          if stgdatos.Cells[j,i]='' then
            begin
              stgdatos.Cells[j,i]:='0';
            end;
        end;
    end;
  dbmodule.pgcnx.Connected:=false;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
    dbmodule.pgcnx.Connected:=false;
  end;

end;

procedure Tvgraficos.rdbgeneralChange(Sender: TObject);
begin
  combobuscar.Enabled:=true;
  if combobuscar.ItemIndex=1 then
    begin
     listarmodplantel();
    end;
  if combobuscar.ItemIndex=2 then
    begin
      listarneceperso();
    end;
  if combobuscar.ItemIndex=3 then
    begin
      listarnecesarti();
    end;
  if combobuscar.ItemIndex=4 then
    begin
      listarneceinfra();
    end;
  if combobuscar.ItemIndex=5 then
    begin
      listarmatricula();
    end;
end;

procedure Tvgraficos.rdbtipoChange(Sender: TObject);
var
  i,j:Integer;
begin
  combobuscar.Enabled:=false;
  if combobuscar.ItemIndex=1 then
      begin
        listarmodplantelcambio();
      end;
    if combobuscar.ItemIndex=2 then
      begin
        listarnecepersocambio();
      end;
    if combobuscar.ItemIndex=3 then
      begin
        listarnecearticambio();
      end;
    if combobuscar.ItemIndex=4 then
      begin
        listarneceinfracambio();
      end;
    if combobuscar.ItemIndex=5 then
      begin
        listarmatriculacambio();
      end;
end;

procedure Tvgraficos.RadioGroup1Click(Sender: TObject);
var
  i:Integer;
begin
  i:=RadioGroup1.ItemIndex;
  Chart1BarSeries1.Active:=i=0;
  Chart1LineSeries1.Active:=i=1;
  Chart1AreaSeries1.Active:=i=2;

end;

end.

