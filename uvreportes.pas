unit uvreportes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LR_Class, LR_DBSet, LR_DSet, LR_E_TXT, lr_e_pdf,
  Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, Buttons, ExtCtrls,
  BarChart, Calendar, ComCtrls, uvbd;

type

  { Tvreportes }

  Tvreportes = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn23: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn25: TBitBtn;
    BitBtn26: TBitBtn;
    BitBtn27: TBitBtn;
    BitBtn28: TBitBtn;
    BitBtn29: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn30: TBitBtn;
    BitBtn31: TBitBtn;
    BitBtn32: TBitBtn;
    BitBtn33: TBitBtn;
    BitBtn34: TBitBtn;
    BitBtn35: TBitBtn;
    BitBtn36: TBitBtn;
    BitBtn37: TBitBtn;
    BitBtn38: TBitBtn;
    BitBtn39: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn40: TBitBtn;
    BitBtn43: TBitBtn;
    BitBtn45: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    combobd: TComboBox;
    datados: TfrUserDataset;
    editbuscar: TEdit;
    filtropdf: TfrTNPDFExport;
    filtrotxt: TfrTextExport;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel19: TPanel;
    Panel2: TPanel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel25: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    Panel29: TPanel;
    Panel3: TPanel;
    Panel30: TPanel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel4: TPanel;
    Panel40: TPanel;
    Panel41: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel9: TPanel;
    panelinformatica: TPanel;
    panelinfra: TPanel;
    panelnecearti: TPanel;
    panelplanteles: TPanel;
    panelpormuni: TPanel;
    panelprimero: TPanel;
    rdgreportes: TRadioGroup;
    rpmatriplantel: TfrReport;
    rpdirectorio: TfrReport;
    datauno: TfrUserDataset;
    rpplantelmod: TfrReport;
    rpnecartimob: TfrReport;
    rpnecartilimpi: TfrReport;
    rpnecartidep: TfrReport;
    rpneccontru: TfrReport;
    rpdirecplantel: TfrReport;
    rpnecperso: TfrReport;
    rpnecartiofi: TfrReport;
    rpneceperso2: TfrReport;
    rpinformatica: TfrReport;
    statusbar1: TStatusBar;
    VentanaGuardar: TSaveDialog;
    stgconsultas: TStringGrid;
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn23Click(Sender: TObject);
    procedure BitBtn27Click(Sender: TObject);
    procedure BitBtn28Click(Sender: TObject);
    procedure BitBtn29Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn32Click(Sender: TObject);
    procedure BitBtn33Click(Sender: TObject);
    procedure BitBtn34Click(Sender: TObject);
    procedure BitBtn38Click(Sender: TObject);
    procedure BitBtn39Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn40Click(Sender: TObject);
    procedure BitBtn45Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure combobdChange(Sender: TObject);
    procedure datacincoCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure datacincoFirst(Sender: TObject);
    procedure datacincoNext(Sender: TObject);
    procedure datacuatroCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure datacuatroFirst(Sender: TObject);
    procedure datacuatroNext(Sender: TObject);
    procedure datadosCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure datadosFirst(Sender: TObject);
    procedure datadosNext(Sender: TObject);
    procedure dataseisCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure dataseisFirst(Sender: TObject);
    procedure dataseisNext(Sender: TObject);
    procedure datasieteCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure datasieteFirst(Sender: TObject);
    procedure datasieteNext(Sender: TObject);
    procedure datatresCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure datatresFirst(Sender: TObject);
    procedure datatresNext(Sender: TObject);
    procedure dataunoCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure dataunoFirst(Sender: TObject);
    procedure dataunoNext(Sender: TObject);
    procedure editbuscarChange(Sender: TObject);
    procedure editbuscarKeyPress(Sender: TObject; var Key: char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rdgreportesChangeBounds(Sender: TObject);
    procedure rdgreportesClick(Sender: TObject);
    procedure rpdirecplantelGetValue(const ParName: String;
      var ParValue: Variant);
    procedure rpdirectorioGetValue(const ParName: String; var ParValue: Variant);
    procedure listardirectorio();
    procedure listarneceperso();
    procedure listarneceartiofi();
    procedure listarneceartilim();
    procedure listarneceartdep();
    procedure listarnecemob();
    procedure listardirecplanteles();
    procedure listarmatriplantel();
    procedure listarplantelmod();
    procedure listarnecepersomuni();
    procedure listardatosdoc();
    procedure listarneceinfra(tipo:integer);
    procedure rpmatriplantelGetValue(const ParName: String;
      var ParValue: Variant);
    procedure rpnecartidepGetValue(const ParName: String; var ParValue: Variant
      );
    procedure rpnecartilimpiGetValue(const ParName: String;
      var ParValue: Variant);
    procedure rpnecartimobGetValue(const ParName: String; var ParValue: Variant
      );
    procedure rpnecartiofiGetValue(const ParName: String; var ParValue: Variant);
    procedure rpneccontruGetValue(const ParName: String; var ParValue: Variant);
    procedure rpneceperso2GetValue(const ParName: String; var ParValue: Variant
      );
    procedure rpnecpersoGetValue(const ParName: String; var ParValue: Variant);
    procedure rpinformaticaGetValue(const ParName: String; var ParValue: Variant
      );
    procedure rpplantelmodGetValue(const ParName: String; var ParValue: Variant
      );
    procedure selectschema();
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  vreportes: Tvreportes;
  esquema: array [1..99999] of String;
  frow:LongInt;

implementation

{$R *.lfm}

{ Tvreportes }

procedure Tvreportes.FormShow(Sender: TObject);
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
end;

procedure Tvreportes.selectschema();
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

procedure Tvreportes.rdgreportesChangeBounds(Sender: TObject);
begin

end;

procedure Tvreportes.rdgreportesClick(Sender: TObject);
begin
  if rdgreportes.ItemIndex=0 then
    begin
      panelnecearti.Visible:=true;
      panelnecearti.Enabled:=true;
      //desabilitar
      panelinfra.Visible:=false;
      panelinfra.Enabled:=false;
      panelinformatica.Visible:=false;
      panelinformatica.Enabled:=false;
      panelplanteles.Visible:=false;
      panelplanteles.Enabled:=false;
      panelpormuni.Visible:=false;
      panelpormuni.Enabled:=false;
    end;
  if rdgreportes.ItemIndex=1 then
    begin
      panelinfra.Visible:=true;
      panelinfra.Enabled:=true;
      //desabilitar
      panelnecearti.Visible:=false;
      panelnecearti.Enabled:=false;
      panelinformatica.Visible:=false;
      panelinformatica.Enabled:=false;
      panelplanteles.Visible:=false;
      panelplanteles.Enabled:=false;
      panelpormuni.Visible:=false;
      panelpormuni.Enabled:=false;
    end;
  if rdgreportes.ItemIndex=2 then
    begin
      panelplanteles.Visible:=true;
      panelplanteles.Enabled:=true;
      //desabilitar
      panelnecearti.Visible:=false;
      panelnecearti.Enabled:=false;
      panelinformatica.Visible:=false;
      panelinformatica.Enabled:=false;
      panelinfra.Visible:=false;
      panelinfra.Enabled:=false;
      panelpormuni.Visible:=false;
      panelpormuni.Enabled:=false;
    end;
  if rdgreportes.ItemIndex=3 then
    begin
      panelpormuni.Visible:=true;
      panelpormuni.Enabled:=true;
      //desabilitar
      panelnecearti.Visible:=false;
      panelnecearti.Enabled:=false;
      panelinformatica.Visible:=false;
      panelinformatica.Enabled:=false;
      panelinfra.Visible:=false;
      panelinfra.Enabled:=false;
      panelplanteles.Visible:=false;
      panelplanteles.Enabled:=false;
    end;
  if rdgreportes.ItemIndex=4 then
    begin
      panelinformatica.Visible:=true;
      panelinformatica.Enabled:=true;
      //desabilitar
      panelnecearti.Visible:=false;
      panelnecearti.Enabled:=false;
      panelpormuni.Visible:=false;
      panelpormuni.Enabled:=false;
      panelinfra.Visible:=false;
      panelinfra.Enabled:=false;
      panelplanteles.Visible:=false;
      panelplanteles.Enabled:=false;
    end
  else
    begin
       panelprimero.Visible:=false;
    end;
  statusbar1.Panels[1].Text:=rdgreportes.Items.Strings[rdgreportes.ItemIndex];
end;

procedure Tvreportes.rpdirecplantelGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
  if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[2,frow];
  if ParName='plantel' then
    ParValue:=stgconsultas.Cells[1,frow];
  if ParName='direccion' then
    ParValue:=stgconsultas.Cells[3,frow];
  if ParName='ubi_geo' then
    ParValue:=stgconsultas.Cells[4,frow];
  if ParName='longitud' then
    ParValue:=stgconsultas.Cells[5,frow];
  if ParName='latitud' then
    ParValue:=stgconsultas.Cells[6,frow];
  if ParName='ner' then
    ParValue:=stgconsultas.Cells[7,frow];
end;

procedure Tvreportes.rpdirectorioGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='municipio' then
    ParValue:=stgconsultas.Cells[1,frow];
  if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[2,frow];
  if ParName='plantel' then
    ParValue:=stgconsultas.Cells[0,frow];
  if ParName='director' then
    ParValue:=stgconsultas.Cells[3,frow];
  if ParName='telefono' then
    ParValue:=stgconsultas.Cells[4,frow];
  if ParName='correo' then
    ParValue:=stgconsultas.Cells[5,frow];
end;

//REPORTE DE DIRECTORIO DE PLANTELES
procedure Tvreportes.listardirectorio();
var
  i:Integer;
begin

  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  //planteles
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_direcplant where cod_admp=cod_admn and id_ng=id_nd order by municipio asc,cod_admp asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        stgconsultas.RowCount:=stgconsultas.RowCount+1;
        stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[0].Text;
        stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
        stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
        stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
        stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[8].Text;
        stgconsultas.Cells[5,i]:=dbmodule.sqlconsultas.Fields[9].Text;
        i:=i+1;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;

end;

//REPORTE DE NECESIDAD DE PERSONAL
procedure Tvreportes.listarneceperso();
var
  i,j:Integer;
begin

  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  j:=3;
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_neceperso where cod_estp=cod_estadistico and id_necp=id_necg order by municipio asc, cod_estp asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        if  dbmodule.sqlconsultas.Fields[0].Text=stgconsultas.Cells[1,i-1] then
          begin
            i:=i-1;
            if dbmodule.sqlconsultas.Fields[8].Text='14' then
              begin
                stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='15' then
              begin
                stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='16' then
              begin
                stgconsultas.Cells[5,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='17' then
              begin
                stgconsultas.Cells[6,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='18' then
              begin
                stgconsultas.Cells[7,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='19' then
              begin
                stgconsultas.Cells[8,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='20' then
              begin
                stgconsultas.Cells[9,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='21' then
              begin
                stgconsultas.Cells[10,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='22' then
              begin
                stgconsultas.Cells[11,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='23' then
              begin
                stgconsultas.Cells[12,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='24' then
              begin
                stgconsultas.Cells[13,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='25' then
              begin
                stgconsultas.Cells[14,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='26' then
              begin
                stgconsultas.Cells[15,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='27' then
              begin
                stgconsultas.Cells[16,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='28' then
              begin
                stgconsultas.Cells[17,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='29' then
              begin
                stgconsultas.Cells[18,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='30' then
              begin
                stgconsultas.Cells[19,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='31' then
              begin
                stgconsultas.Cells[20,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='32' then
              begin
                stgconsultas.Cells[21,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='12' then
              begin
                stgconsultas.Cells[22,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='13' then
              begin
                stgconsultas.Cells[23,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='33' then
              begin
                stgconsultas.Cells[24,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='34' then
              begin
                stgconsultas.Cells[25,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='35' then
              begin
                stgconsultas.Cells[26,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='36' then
              begin
                stgconsultas.Cells[27,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='37' then
              begin
                stgconsultas.Cells[28,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
            if dbmodule.sqlconsultas.Fields[8].Text='38' then
              begin
                stgconsultas.Cells[29,i]:=dbmodule.sqlconsultas.Fields[9].Text;
              end;
          end
        else
          begin
           stgconsultas.RowCount:=stgconsultas.RowCount+1;
           stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
           stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[0].Text;
           stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[5].Text;
           if dbmodule.sqlconsultas.Fields[8].Text='14' then
            begin
              stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='15' then
            begin
              stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='16' then
            begin
              stgconsultas.Cells[5,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='17' then
            begin
              stgconsultas.Cells[6,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='18' then
            begin
              stgconsultas.Cells[7,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='19' then
            begin
              stgconsultas.Cells[8,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='20' then
            begin
              stgconsultas.Cells[9,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='21' then
            begin
              stgconsultas.Cells[10,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='22' then
            begin
              stgconsultas.Cells[11,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='23' then
            begin
              stgconsultas.Cells[12,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='24' then
            begin
              stgconsultas.Cells[13,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='25' then
            begin
              stgconsultas.Cells[14,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='26' then
            begin
              stgconsultas.Cells[15,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='27' then
            begin
              stgconsultas.Cells[16,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='28' then
            begin
              stgconsultas.Cells[17,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='29' then
            begin
              stgconsultas.Cells[18,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='30' then
            begin
              stgconsultas.Cells[19,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='31' then
            begin
              stgconsultas.Cells[20,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='32' then
            begin
              stgconsultas.Cells[21,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='12' then
            begin
              stgconsultas.Cells[22,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='13' then
            begin
              stgconsultas.Cells[23,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='33' then
            begin
              stgconsultas.Cells[24,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='34' then
            begin
              stgconsultas.Cells[25,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='35' then
            begin
              stgconsultas.Cells[26,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='36' then
            begin
              stgconsultas.Cells[27,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='37' then
            begin
              stgconsultas.Cells[28,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          if dbmodule.sqlconsultas.Fields[8].Text='38' then
            begin
              stgconsultas.Cells[29,i]:=dbmodule.sqlconsultas.Fields[9].Text;
            end;
          end;

        if dbmodule.sqlconsultas.Fields[3].Text='SI' then
          begin
            stgconsultas.Cells[30,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
          end
        else
          begin
             stgconsultas.Cells[30,i]:='';
          end;
        i:=i+1;
        dbmodule.sqlconsultas.Next;
     end;
   //RRELLENAR DE 0 LOS DEMAS CAMPOS
   {for i:=1 to (stgconsultas.RowCount-1) do
     begin
        for j:=3 to 29 do
          begin
             if stgconsultas.Cells[j,i]='' then
               begin
                 stgconsultas.Cells[j,i]:='0';
               end;
          end;
     end; }
  dbmodule.pgcnx.Connected:=false;
  stgconsultas.AutoSizeColumns;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;

end;


//NECESIDAD DE ARTC. DED OFICINA
procedure Tvreportes.listarneceartiofi();
var
  i:Integer;
begin

  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_neceofi where id_necg=id_necp and cod_estp=cod_estadistico';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        if dbmodule.sqlconsultas.Fields[8].Text='7' then
          begin
            stgconsultas.RowCount:=stgconsultas.RowCount+1;
            stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
            stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[5].Text;
            stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[0].Text;
            stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[9].AsString;
            if dbmodule.sqlconsultas.Fields[3].Text='SI' then
              begin
                stgconsultas.Cells[4,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
              end;
             i:=i+1;
          end;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;

//NECECIDAD DE ART. DE LIMPIEZA
procedure Tvreportes.listarneceartilim();
var
  i:Integer;
begin

  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_neceofi where id_necg=id_necp and cod_estp=cod_estadistico';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        if dbmodule.sqlconsultas.Fields[8].Text='8' then
          begin
            stgconsultas.RowCount:=stgconsultas.RowCount+1;
            stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
            stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[5].Text;
            stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[0].Text;
            stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[9].AsString;
            if dbmodule.sqlconsultas.Fields[3].Text='SI' then
              begin
                stgconsultas.Cells[4,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
              end;
             i:=i+1;
          end;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;

//NECESIDAD DE ARTICULO DE DEPORTIVO
procedure Tvreportes.listarneceartdep();
var
  i:Integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_neceofi where id_necg=id_necp and cod_estp=cod_estadistico';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        if dbmodule.sqlconsultas.Fields[8].Text='9' then
          begin
            stgconsultas.RowCount:=stgconsultas.RowCount+1;
            stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
            stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[5].Text;
            stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[0].Text;
            stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[9].AsString;
            if dbmodule.sqlconsultas.Fields[3].Text='SI' then
              begin
                stgconsultas.Cells[4,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
              end;
             i:=i+1;
          end;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;

//NECESIDAD DE MOBILIARIO Y MESAS SISLLAS
procedure Tvreportes.listarnecemob();
var
  i:Integer;
begin

  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_neceofi where id_necg=id_necp and cod_estp=cod_estadistico';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        //MOBILIARIO
        if dbmodule.sqlconsultas.Fields[8].Text='10'  then
          begin
            if  dbmodule.sqlconsultas.Fields[0].Text= stgconsultas.Cells[2,i-1] then
             begin
              i:=i-1;
              stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[5].Text;
              stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[0].Text;
              stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[9].AsString;
                if dbmodule.sqlconsultas.Fields[3].Text='SI' then
                begin
                  stgconsultas.Cells[5,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
                end;
             end
            else
              begin
                stgconsultas.RowCount:=stgconsultas.RowCount+1;
                stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[0].Text;
                stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[9].AsString;
                  if dbmodule.sqlconsultas.Fields[3].Text='SI' then
                  begin
                    stgconsultas.Cells[5,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
                  end;
                i:=i+1;
              end;
            end;
        //MESASS SILLAS
        if dbmodule.sqlconsultas.Fields[8].Text='11'  then
          begin
            if  dbmodule.sqlconsultas.Fields[0].Text= stgconsultas.Cells[2,i-1] then
             begin
              i:=i-1;
              stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
              stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[5].Text;
              stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[0].Text;
              stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[9].AsString;
                if dbmodule.sqlconsultas.Fields[3].Text='SI' then
                begin
                  stgconsultas.Cells[5,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
                end;
             end
            else
              begin
                stgconsultas.RowCount:=stgconsultas.RowCount+1;
                stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[0].Text;
                stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[9].AsString;
                  if dbmodule.sqlconsultas.Fields[3].Text='SI' then
                  begin
                    stgconsultas.Cells[5,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
                  end;
                i:=i+1;
              end;
            end;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  stgconsultas.AutoSizeColumns;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;

procedure Tvreportes.listarneceinfra(tipo:integer);
var
  i:Integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  //NECESIDAD DE CONSTRUCCION, AMPLIIACION Y REHABILITACION
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_necinfra where id_necs=id_ctl and cod_estp=cod_estadistico and id_ctl='+IntToStr(tipo)+'';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        if  dbmodule.sqlconsultas.Fields[0].Text=stgconsultas.Cells[1,i-1] then
          begin
            i:=i-1;
            stgconsultas.Cells[17,i]:=stgconsultas.Cells[17,i]+', '+dbmodule.sqlconsultas.Fields[10].AsString;
            if dbmodule.sqlconsultas.Fields[13].Text='AULAS' then
              begin
                stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='BA#OS' then
              begin
                stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='OFICINA' then
              begin
                stgconsultas.Cells[5,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='AREA DE COCINA' then
              begin
                stgconsultas.Cells[6,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='CERCA PERIMETRAL' then
              begin
                stgconsultas.Cells[7,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='CANCHA DEPORTIVA' then
              begin
                stgconsultas.Cells[8,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='SALA DE COMPUTACION' then
              begin
                stgconsultas.Cells[9,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='ESCENARIO' then
              begin
                stgconsultas.Cells[10,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='BIBLIOTECA' then
              begin
                stgconsultas.Cells[11,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='ELECTRICIDAD' then
              begin
                stgconsultas.Cells[12,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='AGUAS BLANCAS' then
              begin
                stgconsultas.Cells[13,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='AGUAS NEGRAS' then
              begin
                stgconsultas.Cells[14,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='PLANTA FISICA' then
              begin
                stgconsultas.Cells[15,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
          end
        else
          begin
           stgconsultas.RowCount:=stgconsultas.RowCount+1;
           stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
           stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[0].Text;
           stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[5].Text;
           stgconsultas.Cells[17,i]:=dbmodule.sqlconsultas.Fields[10].AsString;
           if dbmodule.sqlconsultas.Fields[13].Text='AULAS' then
              begin
                stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='BA#OS' then
              begin
                stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='OFICINA' then
              begin
                stgconsultas.Cells[5,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='AREA DE COCINA' then
              begin
                stgconsultas.Cells[6,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='CERCA PERIMETRAL' then
              begin
                stgconsultas.Cells[7,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='CANCHA DEPORTIVA' then
              begin
                stgconsultas.Cells[8,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='SALA DE COMPUTACION' then
              begin
                stgconsultas.Cells[9,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='ESCENARIO' then
              begin
                stgconsultas.Cells[10,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='BIBLIOTECA' then
              begin
                stgconsultas.Cells[11,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='ELECTRICIDAD' then
              begin
                stgconsultas.Cells[12,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='AGUAS BLANCAS' then
              begin
                stgconsultas.Cells[13,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='AGUAS NEGRAS' then
              begin
                stgconsultas.Cells[14,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
            if dbmodule.sqlconsultas.Fields[13].Text='PLANTA FISICA' then
              begin
                stgconsultas.Cells[15,i]:=dbmodule.sqlconsultas.Fields[11].Text;
              end;
          end;

        if dbmodule.sqlconsultas.Fields[3].Text='SI' then
          begin
            stgconsultas.Cells[16,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
          end
        else
          begin
             stgconsultas.Cells[16,i]:='';
          end;
        i:=i+1;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  stgconsultas.AutoSizeColumns;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;


//LISTAR DIRECCIONES DE LOS PLANTELES
procedure Tvreportes.listardirecplanteles();
var
  i:Integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_direcplantel where cod_estp=cd_est2 order by municipio asc, cod_estp asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        stgconsultas.RowCount:=stgconsultas.RowCount+1;
        stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
        stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[0].Text;
        stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[5].Text;
        stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[6].AsString;
        stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[7].AsString;
        stgconsultas.Cells[5,i]:=dbmodule.sqlconsultas.Fields[8].Text;
        stgconsultas.Cells[6,i]:=dbmodule.sqlconsultas.Fields[9].Text;
        if dbmodule.sqlconsultas.Fields[3].Text='SI' then
          begin
            stgconsultas.Cells[7,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
          end
        else
          begin
             stgconsultas.Cells[7,i]:='';
          end;
        i:=i+1;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  stgconsultas.AutoSizeColumns;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;

end;

//LISTAR MATRICULA DE LOS PLANTELES
procedure Tvreportes.listarmatriplantel();
var
  i:Integer;
begin
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_matriplantel order by municipio asc, cod_estp asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        stgconsultas.RowCount:=stgconsultas.RowCount+1;
        stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
        stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[0].Text;
        stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[5].Text;
        stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[7].Text;
        stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[8].Text;
        stgconsultas.Cells[5,i]:=dbmodule.sqlconsultas.Fields[9].Text;
        if dbmodule.sqlconsultas.Fields[3].Text='SI' then
          begin
            stgconsultas.Cells[6,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
          end
        else
          begin
             stgconsultas.Cells[6,i]:='';
          end;
        i:=i+1;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  stgconsultas.AutoSizeColumns;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;

//LISTAR PLANTELES POR MODALIDAD
procedure Tvreportes.listarplantelmod();
var
  i:Integer;
begin

  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  try
  i:=1;
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_plantemodalidad where cod_estp=cod_estdp order by municipio asc, cod_estp asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        stgconsultas.RowCount:=stgconsultas.RowCount+1;
        stgconsultas.Cells[0,i]:=dbmodule.sqlconsultas.Fields[1].Text;
        stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[0].Text;
        stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[5].Text;
        stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[6].Text;
        stgconsultas.Cells[4,i]:='PRIMARIA';
        stgconsultas.Cells[5,i]:=dbmodule.sqlconsultas.Fields[7].Text;
        if dbmodule.sqlconsultas.Fields[3].Text='SI' then
          begin
            stgconsultas.Cells[6,i]:='('+dbmodule.sqlconsultas.Fields[4].Text+')';
          end
        else
          begin
             stgconsultas.Cells[6,i]:='';
          end;
        i:=i+1;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  stgconsultas.AutoSizeColumns;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
end;

//NECESIDAD DE PERSONAL POR MUNICIPIO
procedure Tvreportes.listarnecepersomuni();
var
  i,j,contar,x:Integer;
begin

  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
  stgconsultas.RowCount:=1;
  stgconsultas.Clean;
  stgconsultas.RowCount:=14;
  stgconsultas.Cells[0,1]:='ALBERTO ARBELO TORREALBA';
  stgconsultas.Cells[0,2]:='ANTONIO JOSE DE SUCRE';
  stgconsultas.Cells[0,3]:='ANDRES ELOY BLANCO';
  stgconsultas.Cells[0,4]:='ARISMENDI';
  stgconsultas.Cells[0,5]:='BOLIVAR';
  stgconsultas.Cells[0,6]:='BARINAS';
  stgconsultas.Cells[0,7]:='CRUZ PAREDES';
  stgconsultas.Cells[0,8]:='EZEQUIEL ZAMORA';
  stgconsultas.Cells[0,9]:='OBISPOS';
  stgconsultas.Cells[0,10]:='PEDRAZA';
  stgconsultas.Cells[0,11]:='PEDRO FELIPE SOSA';
  stgconsultas.Cells[0,12]:='PEDRO MANUEL ROJAS';
  try
  i:=1;
  j:=1;
  for i:=1 to (stgconsultas.RowCount-2) do
  begin
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.vista_necpersomuni where municipio='''+stgconsultas.Cells[0,i]+'''';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
   while not dbmodule.sqlconsultas.EOF do
     begin
        for j:=1 to (stgconsultas.RowCount-2) do
          begin
            if  dbmodule.sqlconsultas.Fields[0].Text=stgconsultas.Cells[0,j] then
              begin
                if dbmodule.sqlconsultas.Fields[1].Text='14' then
                  begin
                    stgconsultas.Cells[3,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='15' then
                  begin
                    stgconsultas.Cells[4,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='16' then
                  begin
                    stgconsultas.Cells[5,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='17' then
                  begin
                    stgconsultas.Cells[6,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='18' then
                  begin
                    stgconsultas.Cells[7,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='19' then
                  begin
                    stgconsultas.Cells[8,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='20' then
                  begin
                    stgconsultas.Cells[9,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='21' then
                  begin
                    stgconsultas.Cells[10,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='22' then
                  begin
                    stgconsultas.Cells[11,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='23' then
                  begin
                    stgconsultas.Cells[12,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='24' then
                  begin
                    stgconsultas.Cells[13,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='25' then
                  begin
                    stgconsultas.Cells[14,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='26' then
                  begin
                    stgconsultas.Cells[15,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='27' then
                  begin
                    stgconsultas.Cells[16,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='28' then
                  begin
                    stgconsultas.Cells[17,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='29' then
                  begin
                    stgconsultas.Cells[18,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='30' then
                  begin
                    stgconsultas.Cells[19,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='31' then
                  begin
                    stgconsultas.Cells[20,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='32' then
                  begin
                    stgconsultas.Cells[21,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='12' then
                  begin
                    stgconsultas.Cells[22,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='13' then
                  begin
                    stgconsultas.Cells[23,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='33' then
                  begin
                    stgconsultas.Cells[24,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='34' then
                  begin
                    stgconsultas.Cells[25,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='35' then
                  begin
                    stgconsultas.Cells[26,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='36' then
                  begin
                    stgconsultas.Cells[27,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='37' then
                  begin
                    stgconsultas.Cells[28,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
                if dbmodule.sqlconsultas.Fields[1].Text='38' then
                  begin
                    stgconsultas.Cells[29,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                  end;
              end;
          end;
        dbmodule.sqlconsultas.Next;
     end;
  dbmodule.pgcnx.Connected:=false;
  stgconsultas.AutoSizeColumns;
  end;
  except
    MessageDlg('Error al buscar datos',mtError,[mbOK],0);
  end;
   //RELLENAR DE 0 LOS DEMAS CAMPOS
   for i:=1 to (stgconsultas.RowCount-2) do
     begin
        for j:=3 to 29 do
          begin
             if stgconsultas.Cells[j,i]='' then
               begin
                 stgconsultas.Cells[j,i]:='0';
               end;
          end;
     end;
  contar:=0;
  for i:=3 to 29 do
     begin
       contar:=0;
        for j:=1 to (stgconsultas.RowCount-2) do
          begin
             contar:=contar+StrToInt(stgconsultas.Cells[i,j]);
          end;
        stgconsultas.Cells[i,13]:=IntToStr(contar);
     end;
  //VACIAR LOS CAMPOS CON CEROS
  for i:=1 to (stgconsultas.RowCount-2) do
     begin
        for j:=3 to 29 do
          begin
             if stgconsultas.Cells[j,i]='0' then
               begin
                 stgconsultas.Cells[j,i]:='';
               end;
          end;
     end;
end;

//LISTAR DATOS DE DOCENTES
procedure Tvreportes.listardatosdoc();
var
  i,j:integer;
  id: array [1..99999] of String;
  x:String;
begin
  stgconsultas.Clean;
  stgconsultas.RowCount:=1;
  selectschema();
  dbmodule.pgcnx.Connected:=false;
  dbmodule.pgcnx.Connected:=true;
 try
  //TABLA DE PERSONAL 1
  i:=1;
  //nomina_general
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.nomina_general where cod_administrativo='''+editbuscar.Text+''' and tipo=''DOCENTE'' order by cedula asc';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          stgconsultas.RowCount:=stgconsultas.RowCount+1;
          stgconsultas.Cells[0,i]:=IntToStr(i);
          id[i]:=dbmodule.sqlconsultas.Fields[0].Text;
          stgconsultas.Cells[1,i]:=dbmodule.sqlconsultas.Fields[1].Text;
          stgconsultas.Cells[2,i]:=dbmodule.sqlconsultas.Fields[2].Text;
          stgconsultas.Cells[3,i]:=dbmodule.sqlconsultas.Fields[3].Text;
          stgconsultas.Cells[4,i]:=dbmodule.sqlconsultas.Fields[4].Text;
          //FORMATEAR PARA QUE TENGA 2 DECIMALES
          stgconsultas.Cells[5,i]:=FormatFloat('0.00',StrToFloat(dbmodule.sqlconsultas.Fields[5].Text));
          stgconsultas.Cells[6,i]:=dbmodule.sqlconsultas.Fields[6].Text;
          stgconsultas.Cells[7,i]:=dbmodule.sqlconsultas.Fields[7].Text;
          stgconsultas.Cells[8,i]:=dbmodule.sqlconsultas.Fields[8].Text;
          stgconsultas.Cells[9,i]:=dbmodule.sqlconsultas.Fields[9].Text;
          stgconsultas.Cells[10,i]:=dbmodule.sqlconsultas.Fields[10].Text;
          stgconsultas.Cells[11,i]:=dbmodule.sqlconsultas.Fields[11].Text;
          i:=i+1;
          dbmodule.sqlconsultas.Next;
       end;
  stgconsultas.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

  //DATOS DE LOS DOCENTES
  dbmodule.sqlconsultas.SQL.Text:='select * from '+esquema[combobd.ItemIndex]+'.datos_docente';
  dbmodule.SQLTransaction.Active:=false;
  dbmodule.SQLTransaction.StartTransaction;
  dbmodule.sqlconsultas.Open;
     while not dbmodule.sqlconsultas.EOF do
       begin
          for j:=1 to (stgconsultas.RowCount-1) do
          begin
          //PARA BUSCAR EL ID_NOMINA QUE PERTENECE
            if id[j]=dbmodule.sqlconsultas.Fields[0].Text then
              begin
                stgconsultas.Cells[12,j]:=dbmodule.sqlconsultas.Fields[1].Text;
                stgconsultas.Cells[13,j]:=dbmodule.sqlconsultas.Fields[2].Text;
                stgconsultas.Cells[14,j]:=dbmodule.sqlconsultas.Fields[3].Text;
                stgconsultas.Cells[15,j]:=dbmodule.sqlconsultas.Fields[4].Text;
                stgconsultas.Cells[16,j]:=dbmodule.sqlconsultas.Fields[5].Text;
                stgconsultas.Cells[17,j]:=dbmodule.sqlconsultas.Fields[6].Text;
                stgconsultas.Cells[18,j]:=dbmodule.sqlconsultas.Fields[7].Text;
                stgconsultas.Cells[19,j]:=dbmodule.sqlconsultas.Fields[8].Text;
                stgconsultas.Cells[20,j]:=dbmodule.sqlconsultas.Fields[9].Text;
                stgconsultas.Cells[21,j]:=dbmodule.sqlconsultas.Fields[10].Text;
                stgconsultas.Cells[22,j]:=dbmodule.sqlconsultas.Fields[11].Text;
                stgconsultas.Cells[23,j]:=dbmodule.sqlconsultas.Fields[12].Text;
              end;
            end;
          dbmodule.sqlconsultas.Next;
       end;
  stgconsultas.AutoSizeColumns;
  dbmodule.sqlconsultas.Close;

 except
   MessageDlg('Error al buscar datos',mtError,[mbOK],0);
 end;

end;

procedure Tvreportes.rpmatriplantelGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
   if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[2,frow];
   if ParName='plantel' then
    ParValue:=stgconsultas.Cells[1,frow];
   if ParName='matri_m' then
    ParValue:=stgconsultas.Cells[3,frow];
   if ParName='matri_f' then
    ParValue:=stgconsultas.Cells[4,frow];
   if ParName='total' then
    ParValue:=stgconsultas.Cells[5,frow];
   if ParName='ner' then
    ParValue:=stgconsultas.Cells[6,frow];
end;

procedure Tvreportes.rpnecartidepGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
   if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[1,frow];
   if ParName='plantel' then
    ParValue:=stgconsultas.Cells[2,frow];
   if ParName='articulo_deportivo' then
    ParValue:=stgconsultas.Cells[3,frow];
   if ParName='ner' then
    ParValue:=stgconsultas.Cells[4,frow];
end;

procedure Tvreportes.rpnecartilimpiGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
   if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[1,frow];
   if ParName='plantel' then
    ParValue:=stgconsultas.Cells[2,frow];
   if ParName='articulo_limpieza' then
    ParValue:=stgconsultas.Cells[3,frow];
   if ParName='ner' then
    ParValue:=stgconsultas.Cells[4,frow];
end;

procedure Tvreportes.rpnecartimobGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
   if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[1,frow];
   if ParName='plantel' then
    ParValue:=stgconsultas.Cells[2,frow];
   if ParName='mobiliario' then
    ParValue:=stgconsultas.Cells[3,frow];
   if ParName='mesas_sillas' then
    ParValue:=stgconsultas.Cells[4,frow];
   if ParName='ner' then
    ParValue:=stgconsultas.Cells[5,frow];
end;

procedure Tvreportes.rpnecartiofiGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
   if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[1,frow];
   if ParName='plantel' then
    ParValue:=stgconsultas.Cells[2,frow];
   if ParName='articulo_oficina' then
    ParValue:=stgconsultas.Cells[3,frow];
   if ParName='ner' then
    ParValue:=stgconsultas.Cells[4,frow];
end;

procedure Tvreportes.rpneccontruGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
  if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[2,frow];
  if ParName='plantel' then
    ParValue:=stgconsultas.Cells[1,frow];
  if ParName='ner' then
    ParValue:=stgconsultas.Cells[16,frow];
  if ParName='c1' then
    ParValue:=stgconsultas.Cells[3,frow];
  if ParName='c2' then
    ParValue:=stgconsultas.Cells[4,frow];
  if ParName='c3' then
    ParValue:=stgconsultas.Cells[5,frow];
  if ParName='c4' then
    ParValue:=stgconsultas.Cells[6,frow];
  if ParName='c5' then
    ParValue:=stgconsultas.Cells[7,frow];
  if ParName='c6' then
    ParValue:=stgconsultas.Cells[8,frow];
  if ParName='c7' then
    ParValue:=stgconsultas.Cells[9,frow];
  if ParName='c8' then
    ParValue:=stgconsultas.Cells[10,frow];
  if ParName='c9' then
    ParValue:=stgconsultas.Cells[11,frow];
  if ParName='c10' then
    ParValue:=stgconsultas.Cells[12,frow];
  if ParName='c11' then
    ParValue:=stgconsultas.Cells[13,frow];
  if ParName='c12' then
    ParValue:=stgconsultas.Cells[14,frow];
  if ParName='c13' then
    ParValue:=stgconsultas.Cells[15,frow];
  if ParName='observaciones' then
    ParValue:=stgconsultas.Cells[17,frow];
end;

procedure Tvreportes.rpneceperso2GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
  if ParName='c1' then
    ParValue:=stgconsultas.Cells[3,frow];
  if ParName='c2' then
    ParValue:=stgconsultas.Cells[4,frow];
  if ParName='c3' then
    ParValue:=stgconsultas.Cells[5,frow];
  if ParName='c4' then
    ParValue:=stgconsultas.Cells[6,frow];
  if ParName='c5' then
    ParValue:=stgconsultas.Cells[7,frow];
  if ParName='c6' then
    ParValue:=stgconsultas.Cells[8,frow];
  if ParName='c7' then
    ParValue:=stgconsultas.Cells[9,frow];
  if ParName='c8' then
    ParValue:=stgconsultas.Cells[10,frow];
  if ParName='c9' then
    ParValue:=stgconsultas.Cells[11,frow];
  if ParName='c10' then
    ParValue:=stgconsultas.Cells[12,frow];
  if ParName='c11' then
    ParValue:=stgconsultas.Cells[13,frow];
  if ParName='c12' then
    ParValue:=stgconsultas.Cells[14,frow];
  if ParName='c13' then
    ParValue:=stgconsultas.Cells[15,frow];
  if ParName='c14' then
    ParValue:=stgconsultas.Cells[16,frow];
  if ParName='c15' then
    ParValue:=stgconsultas.Cells[17,frow];
  if ParName='c16' then
    ParValue:=stgconsultas.Cells[18,frow];
  if ParName='c17' then
    ParValue:=stgconsultas.Cells[19,frow];
  if ParName='c18' then
    ParValue:=stgconsultas.Cells[20,frow];
  if ParName='c19' then
    ParValue:=stgconsultas.Cells[21,frow];
  if ParName='c20' then
    ParValue:=stgconsultas.Cells[22,frow];
  if ParName='c21' then
    ParValue:=stgconsultas.Cells[23,frow];
  if ParName='c22' then
    ParValue:=stgconsultas.Cells[24,frow];
  if ParName='c23' then
    ParValue:=stgconsultas.Cells[25,frow];
  if ParName='c24' then
    ParValue:=stgconsultas.Cells[26,frow];
  if ParName='c25' then
    ParValue:=stgconsultas.Cells[27,frow];
  if ParName='c26' then
    ParValue:=stgconsultas.Cells[28,frow];
  if ParName='c27' then
    ParValue:=stgconsultas.Cells[29,frow];
  //TOTALTES
  if ParName='t1' then
    ParValue:=stgconsultas.Cells[3,13];
  if ParName='t2' then
    ParValue:=stgconsultas.Cells[4,13];
  if ParName='t3' then
    ParValue:=stgconsultas.Cells[5,13];
  if ParName='t4' then
    ParValue:=stgconsultas.Cells[6,13];
  if ParName='t5' then
    ParValue:=stgconsultas.Cells[7,13];
  if ParName='t6' then
    ParValue:=stgconsultas.Cells[8,13];
  if ParName='t7' then
    ParValue:=stgconsultas.Cells[9,13];
  if ParName='t8' then
    ParValue:=stgconsultas.Cells[10,13];
  if ParName='t9' then
    ParValue:=stgconsultas.Cells[11,13];
  if ParName='sirve' then
    ParValue:=stgconsultas.Cells[12,13];
  if ParName='t11' then
    ParValue:=stgconsultas.Cells[13,13];
  if ParName='t12' then
    ParValue:=stgconsultas.Cells[14,13];
  if ParName='t13' then
    ParValue:=stgconsultas.Cells[15,13];
  if ParName='t14' then
    ParValue:=stgconsultas.Cells[16,13];
  if ParName='t15' then
    ParValue:=stgconsultas.Cells[17,13];
  if ParName='t16' then
    ParValue:=stgconsultas.Cells[18,13];
  if ParName='t17' then
    ParValue:=stgconsultas.Cells[19,13];
  if ParName='t18' then
    ParValue:=stgconsultas.Cells[20,13];
  if ParName='t19' then
    ParValue:=stgconsultas.Cells[21,13];
  if ParName='t20' then
    ParValue:=stgconsultas.Cells[22,13];
  if ParName='t21' then
    ParValue:=stgconsultas.Cells[23,13];
  if ParName='t22' then
    ParValue:=stgconsultas.Cells[24,13];
  if ParName='t23' then
    ParValue:=stgconsultas.Cells[25,13];
  if ParName='t24' then
    ParValue:=stgconsultas.Cells[26,13];
  if ParName='t25' then
    ParValue:=stgconsultas.Cells[27,13];
  if ParName='t26' then
    ParValue:=stgconsultas.Cells[28,13];
  if ParName='t27' then
    ParValue:=stgconsultas.Cells[29,13];
end;

procedure Tvreportes.rpnecpersoGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
  if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[2,frow];
  if ParName='plantel' then
    ParValue:=stgconsultas.Cells[1,frow];
  if ParName='ner' then
    ParValue:=stgconsultas.Cells[30,frow];
  if ParName='c1' then
    ParValue:=stgconsultas.Cells[3,frow];
  if ParName='c2' then
    ParValue:=stgconsultas.Cells[4,frow];
  if ParName='c3' then
    ParValue:=stgconsultas.Cells[5,frow];
  if ParName='c4' then
    ParValue:=stgconsultas.Cells[6,frow];
  if ParName='c5' then
    ParValue:=stgconsultas.Cells[7,frow];
  if ParName='c6' then
    ParValue:=stgconsultas.Cells[8,frow];
  if ParName='c7' then
    ParValue:=stgconsultas.Cells[9,frow];
  if ParName='c8' then
    ParValue:=stgconsultas.Cells[10,frow];
  if ParName='c9' then
    ParValue:=stgconsultas.Cells[11,frow];
  if ParName='c10' then
    ParValue:=stgconsultas.Cells[12,frow];
  if ParName='c11' then
    ParValue:=stgconsultas.Cells[13,frow];
  if ParName='c12' then
    ParValue:=stgconsultas.Cells[14,frow];
  if ParName='c13' then
    ParValue:=stgconsultas.Cells[15,frow];
  if ParName='c14' then
    ParValue:=stgconsultas.Cells[16,frow];
  if ParName='c15' then
    ParValue:=stgconsultas.Cells[17,frow];
  if ParName='c16' then
    ParValue:=stgconsultas.Cells[18,frow];
  if ParName='c17' then
    ParValue:=stgconsultas.Cells[19,frow];
  if ParName='c18' then
    ParValue:=stgconsultas.Cells[20,frow];
  if ParName='c19' then
    ParValue:=stgconsultas.Cells[21,frow];
  if ParName='c20' then
    ParValue:=stgconsultas.Cells[22,frow];
  if ParName='c21' then
    ParValue:=stgconsultas.Cells[23,frow];
  if ParName='c22' then
    ParValue:=stgconsultas.Cells[24,frow];
  if ParName='c23' then
    ParValue:=stgconsultas.Cells[25,frow];
  if ParName='c24' then
    ParValue:=stgconsultas.Cells[26,frow];
  if ParName='c25' then
    ParValue:=stgconsultas.Cells[27,frow];
  if ParName='c26' then
    ParValue:=stgconsultas.Cells[28,frow];
  if ParName='c27' then
    ParValue:=stgconsultas.Cells[29,frow];
end;

procedure Tvreportes.rpinformaticaGetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName='cedula' then
    ParValue:=stgconsultas.Cells[2,frow];
  if ParName='nombre_apellidos' then
    ParValue:=stgconsultas.Cells[1,frow];
  if ParName='cod_cargo' then
    ParValue:=stgconsultas.Cells[3,frow];
  if ParName='descrip_cargo' then
    ParValue:=stgconsultas.Cells[4,frow];
  if ParName='año_ser' then
    ParValue:=stgconsultas.Cells[8,frow];
  if ParName='mes_ser' then
    ParValue:=stgconsultas.Cells[9,frow];
  if ParName='funcion_docente' then
    ParValue:=stgconsultas.Cells[12,frow];
      if ParName='plantel' then
    ParValue:=stgconsultas.Cells[11,1];
  if ParName='matricula' then
    ParValue:=stgconsultas.Cells[20,frow];
  if ParName='seccion' then
    ParValue:=stgconsultas.Cells[23,frow];
  if ParName='grado' then
    ParValue:=stgconsultas.Cells[22,frow];
  if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[10,1];
end;

procedure Tvreportes.rpplantelmodGetValue(const ParName: String;
  var ParValue: Variant);
begin
   if ParName='municipio' then
    ParValue:=stgconsultas.Cells[0,frow];
  if ParName='cod_adm' then
    ParValue:=stgconsultas.Cells[2,frow];
  if ParName='plantel' then
    ParValue:=stgconsultas.Cells[1,frow];
  if ParName='parroquia' then
    ParValue:=stgconsultas.Cells[3,frow];
  if ParName='nivel' then
    ParValue:=stgconsultas.Cells[4,frow];
  if ParName='modalidad' then
    ParValue:=stgconsultas.Cells[5,frow];
  if ParName='ner' then
    ParValue:=stgconsultas.Cells[6,frow];
end;


procedure Tvreportes.BitBtn1Click(Sender: TObject);
begin
  listardirectorio();
  rpdirectorio.LoadFromFile('reportes/direc_formato.lrf');
  rpdirectorio.ShowReport;
end;

procedure Tvreportes.BitBtn20Click(Sender: TObject);
begin
  listarneceartiofi();
  if VentanaGuardar.Execute then
    begin
    rpnecartiofi.LoadFromFile('reportes/nece_arti.lrf');
      if rpnecartiofi.PrepareReport then
        begin
          rpnecartiofi.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn21Click(Sender: TObject);
begin
  listarneceartilim();
  if VentanaGuardar.Execute then
    begin
    rpnecartilimpi.LoadFromFile('reportes/nece_artilim.lrf');
      if rpnecartilimpi.PrepareReport then
        begin
          rpnecartilimpi.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn22Click(Sender: TObject);
begin
  listarneceartdep();
  if VentanaGuardar.Execute then
    begin
    rpnecartidep.LoadFromFile('reportes/nece_artidep.lrf');
      if rpnecartidep.PrepareReport then
        begin
          rpnecartidep.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn23Click(Sender: TObject);
begin
  listarnecemob();
  if VentanaGuardar.Execute then
    begin
    rpnecartimob.LoadFromFile('reportes/nece_mob.lrf');
      if rpnecartimob.PrepareReport then
        begin
          rpnecartimob.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn27Click(Sender: TObject);
begin
   listarneceinfra(4);
   if VentanaGuardar.Execute then
    begin
    rpneccontru.LoadFromFile('reportes/nece_contruc.lrf');
      if rpneccontru.PrepareReport then
        begin
          rpneccontru.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn28Click(Sender: TObject);
begin
  listarneceinfra(5);
  if VentanaGuardar.Execute then
    begin
    rpneccontru.LoadFromFile('reportes/nece_ampli.lrf');
      if rpneccontru.PrepareReport then
        begin
          rpneccontru.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn29Click(Sender: TObject);
begin
  listarneceinfra(6);
  if VentanaGuardar.Execute then
    begin
    rpneccontru.LoadFromFile('reportes/nece_reha.lrf');
      if rpneccontru.PrepareReport then
        begin
          rpneccontru.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn32Click(Sender: TObject);
begin
   listardirectorio();
   if VentanaGuardar.Execute then
    begin
    rpdirectorio.LoadFromFile('reportes/direc_formato.lrf');
      if rpdirectorio.PrepareReport then
        begin
          rpdirectorio.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn33Click(Sender: TObject);
begin
  listardirecplanteles();
  if VentanaGuardar.Execute then
    begin
    rpdirecplantel.LoadFromFile('reportes/direcciones_planteles.lrf');
      if rpdirecplantel.PrepareReport then
        begin
          rpdirecplantel.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn34Click(Sender: TObject);
begin
  listarmatriplantel();
  if VentanaGuardar.Execute then
    begin
    rpmatriplantel.LoadFromFile('reportes/matri_plantel.lrf');
      if rpmatriplantel.PrepareReport then
        begin
          rpmatriplantel.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn38Click(Sender: TObject);
begin
  listarplantelmod();
  if VentanaGuardar.Execute then
    begin
    rpplantelmod.LoadFromFile('reportes/plantel_moda.lrf');
      if rpplantelmod.PrepareReport then
        begin
          rpplantelmod.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn39Click(Sender: TObject);
begin
  listarnecepersomuni();
  if VentanaGuardar.Execute then
    begin
    rpneceperso2.LoadFromFile('reportes/nece_perso_muni.lrf');
      if rpneceperso2.PrepareReport then
        begin
          rpneceperso2.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn45Click(Sender: TObject);
begin
  listardatosdoc();
  if VentanaGuardar.Execute then
    begin
    rpinformatica.LoadFromFile('reportes/info_formato.lrf');
      if rpinformatica.PrepareReport then
        begin
          rpinformatica.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn40Click(Sender: TObject);
begin
  listarneceperso();
  if VentanaGuardar.Execute then
    begin
    rpnecperso.LoadFromFile('reportes/nece_perso.lrf');
      if rpnecperso.PrepareReport then
        begin
          rpnecperso.ExportTo(TfrTNPDFExportFilter,VentanaGuardar.FileName);
          MessageDlg('Archivo guardado exitosamente',mtInformation,[mbOK],0);
        end
      else
          MessageDlg('Error al generar archivo',mtError,[mbOK],0);
      end;
end;

procedure Tvreportes.BitBtn10Click(Sender: TObject);
begin
  listardirecplanteles();
  rpdirecplantel.LoadFromFile('reportes/direcciones_planteles.lrf');
  rpdirecplantel.ShowReport;
end;

procedure Tvreportes.BitBtn11Click(Sender: TObject);
begin
  listarmatriplantel();
  rpmatriplantel.LoadFromFile('reportes/matri_plantel.lrf');
  rpmatriplantel.ShowReport;
end;

procedure Tvreportes.BitBtn12Click(Sender: TObject);
begin
  listarplantelmod();
  rpplantelmod.LoadFromFile('reportes/plantel_moda.lrf');
  rpplantelmod.ShowReport;
end;

procedure Tvreportes.BitBtn13Click(Sender: TObject);
begin
  listarnecepersomuni();
  rpneceperso2.LoadFromFile('reportes/nece_perso_muni.lrf');
  rpneceperso2.ShowReport;
end;

procedure Tvreportes.BitBtn14Click(Sender: TObject);
begin
 listardatosdoc();
 if  stgconsultas.RowCount<>1 then
   begin;
    rpinformatica.LoadFromFile('reportes/info_formato.lrf');
    rpinformatica.ShowReport;
    BitBtn45.Enabled:=true;
   end
 else
   begin
     MessageDlg('No se encontron datos',mtInformation,[mbOK],0);
   end;
end;

procedure Tvreportes.BitBtn2Click(Sender: TObject);
begin
  listarneceperso();
  rpnecperso.LoadFromFile('reportes/nece_perso.lrf');
  rpnecperso.ShowReport;
end;

procedure Tvreportes.BitBtn3Click(Sender: TObject);
begin
  listarneceartiofi();
  rpnecartiofi.LoadFromFile('reportes/nece_arti.lrf');
  rpnecartiofi.ShowReport;
end;

procedure Tvreportes.BitBtn4Click(Sender: TObject);
begin
  listarneceartilim();
  rpnecartilimpi.LoadFromFile('reportes/nece_artilim.lrf');
  rpnecartilimpi.ShowReport;
end;

procedure Tvreportes.BitBtn5Click(Sender: TObject);
begin
  listarneceartdep();
  rpnecartidep.LoadFromFile('reportes/nece_artidep.lrf');
  rpnecartidep.ShowReport;
end;

procedure Tvreportes.BitBtn6Click(Sender: TObject);
begin
  listarnecemob();
  rpnecartimob.LoadFromFile('reportes/nece_mob.lrf');
  rpnecartimob.ShowReport;
end;

procedure Tvreportes.BitBtn7Click(Sender: TObject);
begin
  listarneceinfra(4);
  rpneccontru.LoadFromFile('reportes/nece_contruc.lrf');
  rpneccontru.ShowReport;
end;

procedure Tvreportes.BitBtn8Click(Sender: TObject);
begin
  listarneceinfra(5);
  rpneccontru.LoadFromFile('reportes/nece_ampli.lrf');
  rpneccontru.ShowReport;
end;

procedure Tvreportes.BitBtn9Click(Sender: TObject);
begin
  listarneceinfra(6);
  rpneccontru.LoadFromFile('reportes/nece_reha.lrf');
  rpneccontru.ShowReport;
end;

procedure Tvreportes.combobdChange(Sender: TObject);
begin
  try
    dbmodule.pgcnx.Connected:=true;
    statusbar1.Panels[3].Text:='[+] OnLine';
    rdgreportes.Enabled:=true;
    dbmodule.pgcnx.Connected:=false;
  except
    statusbar1.Panels[3].Text:='[-] OffLine';
    rdgreportes.Enabled:=false;
    panelprimero.Visible:=true;
    panelnecearti.Visible:=false;
    panelnecearti.Enabled:=false;
    panelinfra.Visible:=false;
    panelinfra.Enabled:=false;
    panelinformatica.Visible:=false;
    panelinformatica.Enabled:=false;
    panelplanteles.Visible:=false;
    panelplanteles.Enabled:=false;
    panelpormuni.Visible:=false;
    panelpormuni.Enabled:=false;
    statusbar1.Panels[1].Text:='';
  end;
end;

procedure Tvreportes.datacincoCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=frow>(stgconsultas.RowCount-1);
end;

procedure Tvreportes.datacincoFirst(Sender: TObject);
begin
  frow:=1;
end;

procedure Tvreportes.datacincoNext(Sender: TObject);
begin
  Inc(frow);
end;

procedure Tvreportes.datacuatroCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=frow>(stgconsultas.RowCount-1);
end;

procedure Tvreportes.datacuatroFirst(Sender: TObject);
begin
  frow:=1;
end;

procedure Tvreportes.datacuatroNext(Sender: TObject);
begin
  Inc(frow);
end;

procedure Tvreportes.datadosCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=frow>(stgconsultas.RowCount-2);
end;

procedure Tvreportes.datadosFirst(Sender: TObject);
begin
  frow:=1;
end;

procedure Tvreportes.datadosNext(Sender: TObject);
begin
  Inc(frow);
end;

procedure Tvreportes.dataseisCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=frow>(stgconsultas.RowCount-1);
end;

procedure Tvreportes.dataseisFirst(Sender: TObject);
begin
   frow:=1;
end;

procedure Tvreportes.dataseisNext(Sender: TObject);
begin
   Inc(frow);
end;

procedure Tvreportes.datasieteCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=frow>(stgconsultas.RowCount-1);
end;

procedure Tvreportes.datasieteFirst(Sender: TObject);
begin
  frow:=1;
end;

procedure Tvreportes.datasieteNext(Sender: TObject);
begin
  Inc(frow);
end;

procedure Tvreportes.datatresCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=frow>(stgconsultas.RowCount-1);
end;

procedure Tvreportes.datatresFirst(Sender: TObject);
begin
  frow:=1;
end;

procedure Tvreportes.datatresNext(Sender: TObject);
begin
  Inc(frow);
end;

procedure Tvreportes.dataunoCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof:=frow>(stgconsultas.RowCount-1);
end;

procedure Tvreportes.dataunoFirst(Sender: TObject);
begin
  frow:=1;
end;

procedure Tvreportes.dataunoNext(Sender: TObject);
begin
  Inc(frow);
end;

procedure Tvreportes.editbuscarChange(Sender: TObject);
begin
  if editbuscar.Text<>'' then
    begin
      BitBtn43.Enabled:=true;
      BitBtn45.Enabled:=true;
    end
  else
    begin
      BitBtn43.Enabled:=false;
      BitBtn45.Enabled:=false;
    end;
   BitBtn45.Enabled:=false;
end;

procedure Tvreportes.editbuscarKeyPress(Sender: TObject; var Key: char);
begin
  if not (key in ['0'..'9',#7, #8, #13]) then
  begin
    Key := #0;
    Beep;
  end;
end;

procedure Tvreportes.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  beep;
  CanClose := MessageDlg('¿Realmente desea salir de la ventana?', mtConfirmation, [mbOK, mbCancel], 0) = mrOk
end;

procedure Tvreportes.FormCreate(Sender: TObject);
begin

end;

end.

