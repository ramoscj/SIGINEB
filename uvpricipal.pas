unit uvpricipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls, ComCtrls, Menus, StdCtrls, Calendar, IdFTP, uvimportar, uvbd,
  uvimportar2, uvftp, uvconsultas, uvcolsutas2, uvreportes, uvgraficos, IdComponent,
  uvcargaftp, uvusuarios,uvrestaurar, uvbdsalvar;

type

  { Tvprincipal }

  Tvprincipal = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    btnsincronizar: TBitBtn;
    btnup: TToolButton;
    FTPsearch: TIdFTP;
    Image1: TImage;
    Image2: TImage;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    Label1: TLabel;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem9: TMenuItem;
    usuario: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblfecha: TLabel;
    lblhora: TLabel;
    lblhora1: TLabel;
    lblhora2: TLabel;
    listaarnewnac: TListView;
    listaarnewest: TListView;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    MainMenu1: TMainMenu;
    carga: TMenuItem;
    consultas: TMenuItem;
    ftp: TMenuItem;
    cargaplantel: TMenuItem;
    consuplanteles: TMenuItem;
    MenuItem1: TMenuItem;
    cargapersonal: TMenuItem;
    consupersonal: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlfoot: TPanel;
    pnlcentral: TPanel;
    Panel5: TPanel;
    reportes: TMenuItem;
    reloj: TTimer;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
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
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure btnsincronizarClick(Sender: TObject);
    procedure btnupClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure listaarnewestColumnClick(Sender: TObject; Column: TListColumn);
    procedure listaarnewestCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure listaarnewnacColumnClick(Sender: TObject; Column: TListColumn);
    procedure listaarnewnacCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure relojTimer(Sender: TObject);
    procedure listarftp();

  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vprincipal: Tvprincipal;
  vimportar:Tvimportar;
  vimportar2:Tvimportar2;
  vftp:Tvftp;
  vconsultas:Tvconsultas;
  vconsultas2:Tvconsultas2;
  vreportes:Tvreportes;
  vgraficos:Tvgraficos;
  vusuarios:Tvusuarios;
  vrestaurar:Tvrestaurar;
  vbdsalvar:Tvbdsalvar;
  Descending,mostrar: Boolean;
  SortedColumn: Integer;

implementation

{$R *.lfm}

uses index;

{ Tvprincipal }



procedure Tvprincipal.BitBtn1Click(Sender: TObject);
begin
  vimportar:=Tvimportar.Create(Self);
  vimportar.Show;
end;

procedure Tvprincipal.BitBtn2Click(Sender: TObject);
begin
  vimportar2:=Tvimportar2.Create(Self);
  vimportar2.Show;
end;

procedure Tvprincipal.BitBtn3Click(Sender: TObject);
begin
  vftp:=Tvftp.Create(Self);
  vftp.Show;
end;

procedure Tvprincipal.BitBtn4Click(Sender: TObject);
begin
  vconsultas:=Tvconsultas.Create(Self);
  vconsultas.Show;
end;

procedure Tvprincipal.BitBtn5Click(Sender: TObject);
begin
  vconsultas2:=Tvconsultas2.Create(Self);
  vconsultas2.Show;
end;

procedure Tvprincipal.BitBtn6Click(Sender: TObject);
begin
  vreportes:=Tvreportes.Create(Self);
  vreportes.Show;
end;

procedure Tvprincipal.BitBtn7Click(Sender: TObject);
begin
  vgraficos:=Tvgraficos.Create(Self);
  vgraficos.Show;
end;

procedure Tvprincipal.btnsincronizarClick(Sender: TObject);
begin
  listaarnewnac.Items.Clear;
  listaarnewest.Items.Clear;
  ListBox1.Items.Clear;
  ListBox2.Items.Clear;
  ListBox3.Items.Clear;
  ListBox4.Items.Clear;
  btnsincronizar.Cursor:=crHourGlass;
  listarftp();
   btnsincronizar.Cursor:=crDefault;
end;

procedure Tvprincipal.btnupClick(Sender: TObject);
begin
  if mostrar then
     begin
       pnlfoot.Height:=40;
       mostrar:=false;
       Image2.Top:=350;
       pnlcentral.Height:=350;
       Label5.Visible:=false;
       Label6.Visible:=false;
     end
  else
    begin
      pnlfoot.Height:=158;
      mostrar:=true;
      Image2.Top:=240;
      pnlcentral.Height:=258;
      Label5.Visible:=true;
      Label6.Visible:=true;
    end;

end;

procedure Tvprincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FTPsearch.Disconnect;
  vcinicio.Show;
end;

procedure Tvprincipal.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la aplicación?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk;
  vimportar.Free;
  vimportar2.Free;
  vftp.Free;
  vconsultas.Free;
  vconsultas2.Free;
  vreportes.Free;
  vgraficos.Free;
end;

procedure Tvprincipal.FormCreate(Sender: TObject);
begin
   lblfecha.Caption:=DateToStr(now);
   pnlfoot.Height:=40;
   mostrar:=false;
   Image2.Top:=300;
   pnlcentral.Height:=300;
   Label5.Visible:=false;
   Label6.Visible:=false;
end;

procedure Tvprincipal.FormShow(Sender: TObject);
begin
  if index.nivel[0]='2' then
     begin
       ToolBar1.Buttons[0].Enabled:=false;
       ToolBar1.Buttons[1].Enabled:=false;
       MainMenu1.Items.Items[1].Enabled:=false;
       MainMenu1.Items.Items[5].Enabled:=false;
     end;
  if index.nivel[0]='1' then
     begin
       MainMenu1.Items.Items[5].Enabled:=false;
     end;
end;

procedure Tvprincipal.listaarnewestColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index<>SortedColumn then
    begin
      SortedColumn := Column.Index;
      Descending := False;
    end
  else
    Descending := not Descending;
    TListView(Sender).SortType := stText;
end;

procedure Tvprincipal.listaarnewestCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)

  else
    if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);

  if Descending then Compare := -Compare;
end;

procedure Tvprincipal.listaarnewnacColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index<>SortedColumn then
    begin
      SortedColumn := Column.Index;
      Descending := False;
    end
  else
    Descending := not Descending;
    TListView(Sender).SortType := stText;
end;

procedure Tvprincipal.listaarnewnacCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)

  else
    if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);

  if Descending then Compare := -Compare;
end;

procedure Tvprincipal.MenuItem11Click(Sender: TObject);
begin
   vrestaurar:=Tvrestaurar.Create(Self);
   vrestaurar.ShowModal;
end;

procedure Tvprincipal.MenuItem12Click(Sender: TObject);
begin
  vbdsalvar:=Tvbdsalvar.Create(Self);
  vbdsalvar.ShowModal;
end;

procedure Tvprincipal.MenuItem9Click(Sender: TObject);
begin
  vusuarios:=Tvusuarios.Create(Self);
  vusuarios.ShowModal;
end;

procedure Tvprincipal.relojTimer(Sender: TObject);
begin
  lblhora.Caption:=FormatDateTime('h:mm:ss',Now);
end;

procedure Tvprincipal.listarftp();
var
  i,j,k:Integer;
  MysList: TStringList;
  iLines, iPesoArchivo:Integer;
  sDir:String;
  listate2,listate: TListItem;
  dirnow:array [0..11] of String;
  dir2:array [0..1] of String;
  fecha:TDateTime;
  municipionac,municipioest: array [0..11] of String;
begin
   listaarnewnac.Items.Clear;
   dir2[0]:='NACIONAL';
   dir2[1]:='ESTADAL';
   dirnow[0]:='/planteles/A.A.T';
   dirnow[1]:='/planteles/A.E.B';
   dirnow[2]:='/planteles/A.J.S';
   dirnow[3]:='/planteles/ARISMENDI';
   dirnow[4]:='/planteles/BOLIVAR';
   dirnow[5]:='/planteles/BARINAS';
   dirnow[6]:='/planteles/CRUZ PAREDES';
   dirnow[7]:='/planteles/OBISPOS';
   dirnow[8]:='/planteles/PEDRAZA';
   dirnow[9]:='/planteles/SOSA';
   dirnow[10]:='/planteles/ROJAS';
   dirnow[11]:='/planteles/ZAMORA';
   FTPsearch.Username:='sistemazona@engineersworld.com.ve' ;
   FTPsearch.Password:='5325106';
   FTPsearch.Host:='ftp.engineersworld.com.ve';
  try
   FTPsearch.Connect;
   x:=0;
  //LISTAR ARCHIVOS EN DIRECTORIO NACIONALES
  for j:=0 to 11 do
    begin
      FTPsearch.ChangeDir(dirnow[j]+'/NACIONAL');
      MysList := TStringList.Create;
      FTPsearch.List(MysList,'',False);
      For iLines := 0 to MysList.Count -1 do
        begin
            sDir:= MysList[iLines];
            iPesoArchivo := FTPsearch.Size(sDir);
            fecha:=FTPsearch.FileDate(sDir);
            if iPesoArchivo > -1 then
               begin
                 ListBox1.Items.Add(sDir);
                 ListBox2.Items.Add(DateTimeToStr(fecha));
                 municipionac[x]:=dirnow[j]+'/NACIONAL';
                 x:=x+1;
               end;
        end;
      end;

  //LISTAR ARCHIVOS EN DIRECTORIO ESTADALES
  for j:=0 to 11 do
    begin
      FTPsearch.ChangeDir(dirnow[j]+'/ESTADAL');
      MysList := TStringList.Create;
      FTPsearch.List(MysList,'',False);
      For iLines := 0 to MysList.Count -1 do
        begin
            sDir:= MysList[iLines];
            iPesoArchivo := FTPsearch.Size(sDir);
            fecha:=FTPsearch.FileDate(sDir);
            if iPesoArchivo > -1 then
               begin
                 ListBox3.Items.Add(sDir);
                 ListBox4.Items.Add(DateTimeToStr(fecha));
                 municipioest[j]:=dirnow[j]+'/ESTADAL';
               end;
        end;
      end;
   FTPsearch.Disconnect;

  //LLENAR EL LISTVIEW NACIONAL
  for i := 0 to ListBox1.Count - 1 do
  begin
    with listaarnewnac do
      begin
        listate:= listaarnewnac.Items.Add;
        listate.Caption := ListBox1.Items[i];
        listate.SubItems.Add(ListBox2.Items[i]);
        listate.SubItems.Add(municipionac[i]);
        listate.ImageIndex :=0;
      end;
  end;

  //LLENAR EL LISTVIEW ESTADAL
  for i := 0 to ListBox3.Count - 1 do
  begin
    with listaarnewest do
      begin
        listate2:= listaarnewest.Items.Add;
        listate2.Caption := ListBox3.Items[i];
        listate2.SubItems.Add(ListBox4.Items[i]);
        listate2.SubItems.Add(municipionac[i]);
        listate2.ImageIndex :=0;
      end;
  end;
  vcargaftp.Close;
  except
    btnsincronizar.Cursor:=crDefault;
    MessageDlg('Error al sincronizar con servidor',mtError,[mbOK],0);
    FTPsearch.Disconnect;
  end;
end;



end.

