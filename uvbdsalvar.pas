unit uvbdsalvar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, StdCtrls, Grids;

type

  { Tvbdsalvar }

  Tvbdsalvar = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    btnbd: TBitBtn;
    editdir: TEdit;
    editdir1: TEdit;
    editdirpg1: TEdit;
    editdirpg: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ventanafile: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Process1: TProcess;
    ventanadirr: TSelectDirectoryDialog;
    VentanaGuardar: TSaveDialog;
    ScrollBar1: TScrollBar;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnbdClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vbdsalvar: Tvbdsalvar;

implementation

{$R *.lfm}

{ Tvbdsalvar }

procedure Tvbdsalvar.BitBtn1Click(Sender: TObject);
begin
  if VentanaGuardar.Execute then
    begin
      editdir.Text:='';
      editdir.Text:=VentanaGuardar.FileName;
      editdir.SetFocus;
    end;
end;

procedure Tvbdsalvar.BitBtn2Click(Sender: TObject);
begin
  if ventanafile.Execute then
    begin
      editdir1.Text:='';
      editdir1.Text:=ventanafile.FileName;
      editdir1.SetFocus;
    end;
end;

procedure Tvbdsalvar.BitBtn3Click(Sender: TObject);
begin
  if ventanadirr.Execute then
    begin
      editdirpg1.Text:='';
      editdirpg1.Text:=ventanadirr.FileName;
      editdirpg1.SetFocus;
    end;
end;

procedure Tvbdsalvar.BitBtn4Click(Sender: TObject);
begin
  if ventanadirr.Execute then
    begin
      editdirpg.Text:='';
      editdirpg.Text:=ventanadirr.FileName;
      editdirpg.SetFocus;
    end;
end;

procedure Tvbdsalvar.BitBtn5Click(Sender: TObject);
var
  UnProceso:TProcess;
begin
  if (editdir1.Text<>'') and (editdirpg1.Text<>'') then
    begin
       UnProceso:=TProcess.Create(nil);
       try
       UnProceso.CurrentDirectory:=editdirpg1.Text;
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
            Add(editdir1.Text);
         end;
       UnProceso.Options:=UnProceso.Options + [poWaitOnExit];
       UnProceso.WindowTop:=250;
       UnProceso.WindowLeft:=400;
       UnProceso.WindowHeight:=250;
       UnProceso.WindowWidth:=650;
       UnProceso.StartupOptions:=[suoUsePosition];
       UnProceso.Execute;
       UnProceso.Free;
       MessageDlg('Se ha restaurado la BD',mtInformation,[mbOK],0);
       except
         MessageDlg('Error al restaurar la BD',mtError,[mbOK],0);
       end;
     end
   else
     begin
        MessageDlg('No puede dejar campos vacios',mtError,[mbOK],0);
      end;
end;

procedure Tvbdsalvar.btnbdClick(Sender: TObject);
var
  UnProceso:TProcess;
begin
   if (editdir.Text<>'') and (editdirpg.Text<>'') then
     begin
       UnProceso:=TProcess.Create(nil);
       try
       UnProceso.CurrentDirectory:=editdirpg.Text;
       UnProceso.Executable:='pg_dump';
       with UnProceso.Parameters do
         begin
            Add('-U');
            Add('postgres');
            Add('-h');
            Add('localhost');
            Add('-F');
            Add('c');
            Add('-b');
            Add('-v');
            Add('-f');
            Add(editdir.Text);
            Add('esquemas');
         end;
       UnProceso.Options:=UnProceso.Options + [poWaitOnExit];
       UnProceso.WindowTop:=250;
       UnProceso.WindowLeft:=400;
       UnProceso.WindowHeight:=250;
       UnProceso.WindowWidth:=650;
       UnProceso.StartupOptions:=[suoUsePosition];
       UnProceso.Execute;
       UnProceso.Free;
       MessageDlg('Se ha creado el respaldo',mtInformation,[mbOK],0);
       except
         MessageDlg('Error al crear respaldo de la BD',mtError,[mbOK],0);
       end;
     end
   else
     begin
        MessageDlg('No puede dejar campos vacios',mtError,[mbOK],0);
      end;
end;

procedure Tvbdsalvar.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;




end.

