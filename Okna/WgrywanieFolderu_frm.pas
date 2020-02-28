unit WgrywanieFolderu_frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.ComCtrls;

type
  TWgrywanieFolderu = class(TForm)
    Panel2: TPanel;
    Label9: TLabel;
    Image3: TImage;
    Image6: TImage;
    Panel1: TPanel;
    lbl_nazwa_folderu: TLabel;
    Label1: TLabel;
    edt_nowy_folder: TEdit;
    btn_open: TButton;
    lview_pliki: TListView;
    btn_wgraj: TButton;
    ProgressBar: TProgressBar;
    procedure SzukajPlikow(katalog_do_przeszukania: String);
    procedure Przetwarzaj_wybrany_folder;

    procedure btn_openClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_wgrajClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WgrywanieFolderu: TWgrywanieFolderu;

implementation

{$R *.dfm}

uses AOknoGl_frm, ownCLOUDunit_frm;

procedure TWgrywanieFolderu.Przetwarzaj_wybrany_folder;
Begin
 lview_pliki.Items.BeginUpdate;
 lview_pliki.Items.Clear;
 lview_pliki.Items.EndUpdate;
 SzukajPlikow(edt_nowy_folder.Text);
 if lview_pliki.Items.Count>0 then btn_wgraj.Enabled:=True
 else btn_wgraj.Enabled:=False;
End;

procedure TWgrywanieFolderu.btn_openClick(Sender: TObject);
begin
 with TFileOpenDialog.Create(nil) do
  try
    Title := 'Wybierz folder ze swojego komputera';
    Options := [fdoPickFolders];
    if Execute then
     Begin
      edt_nowy_folder.Text:=Trim(FileName);
      edt_nowy_folder.Font.Color:=clBlack;
      Przetwarzaj_wybrany_folder;
     End;
  finally
    Free;
  end;
end;

procedure TWgrywanieFolderu.btn_wgrajClick(Sender: TObject);
var
  p, poz, i: Integer;
  root : String;
  folder : String;
  nazwa_folderu_wybranego : String;
  obiekt: string;
  rozsz: string;
  typ: string;
begin
 btn_wgraj.Enabled:=False;
 Application.ProcessMessages;

 root:=lbl_nazwa_folderu.Caption;
 folder:=edt_nowy_folder.Text;
 for p := 1 to Length(folder) do
  Begin
   if folder[p]='\' then poz:=p;
  End;
 nazwa_folderu_wybranego:=Copy(folder,poz+1,Length(folder));

 //Tu zak³adamy nowy folder
 ownCLOUDunit.UtworzFolder(root,Trim(nazwa_folderu_wybranego));

 root:=root+'/'+nazwa_folderu_wybranego;
 root:=Trim(StringReplace(root,'//','/',[rfReplaceAll]));

 ProgressBar.Position:=0;
 ProgressBar.Max:=lview_pliki.Items.Count-1;
 for i := 0 to lview_pliki.Items.Count-1 do
  Begin
   obiekt:=lview_pliki.Items[i].SubItems.Text;
   obiekt:=Trim(StringReplace(obiekt,edt_nowy_folder.Text,'',[rfReplaceAll]));
   obiekt:=Trim(StringReplace(obiekt,'\','/',[rfReplaceAll]));

   for p := 1 to Length(obiekt) do
    Begin
     if obiekt[p]='/' then poz:=p;
    End;
   folder:=root+Trim(Copy(obiekt,1,poz));
   obiekt:=Trim(Copy(obiekt,poz+1,Length(obiekt)));

   rozsz:=Trim(ExtractFileExt(obiekt));
   if rozsz<>'' then typ:='plik' else typ:='folder';

   //ShowMessage(folder+' - '+obiekt+' - '+typ);
   if typ='folder' then ownCLOUDunit.UtworzFolder(folder,obiekt);
   if typ='plik' then ownCLOUDunit.UploadNoDialog(folder,Trim(lview_pliki.Items[i].SubItems.Text));

   lview_pliki.Items[i].ImageIndex:=9;
   lview_pliki.Items[i].Caption:='przeniesiony';
   ProgressBar.Position:=ProgressBar.Position+1;
   Application.ProcessMessages;
  End;
 ProgressBar.Position:=0;
 Close;
 AOknoGl.btn_dir_wyb_kataloguClick(Self);
end;

procedure TWgrywanieFolderu.FormCreate(Sender: TObject);
 Var
  NewColumn: TListColumn;
begin
 lview_pliki.Items.BeginUpdate;
 lview_pliki.Items.Clear;
 NewColumn := lview_pliki.Columns.Add;
 NewColumn.Caption := 'Stan';
 NewColumn.Width:=200;
 NewColumn := lview_pliki.Columns.Add;
 NewColumn.Caption := 'Nazwa obiektu';
 NewColumn.Width:=700;
 lview_pliki.Items.EndUpdate;
end;

procedure TWgrywanieFolderu.FormShow(Sender: TObject);
begin
 lview_pliki.Items.BeginUpdate;
 lview_pliki.Items.Clear;
 lview_pliki.Items.EndUpdate;
 ProgressBar.Position:=0;
 btn_wgraj.Enabled:=False;
 edt_nowy_folder.Text:='nie wybrano folderu do kopiowania...';
 edt_nowy_folder.Font.Color:=clSilver;
end;

procedure TWgrywanieFolderu.SzukajPlikow(katalog_do_przeszukania: String);
var
  SearchRec: TSearchRec;  Folders: array of string;  Folder: string;  I: Integer;  Last: Integer;  ListItem: TListItem;  plik : String;begin  SetLength(Folders, 1);  Folders[0] := katalog_do_przeszukania;  I := 0;  while (I < Length(Folders)) do  begin    Folder := IncludeTrailingBackslash(Folders[I]);    Inc(I);    { Collect child folders first. }    if (FindFirst(Folder + '*.*', faDirectory, SearchRec) = 0) then    begin      repeat        if not ((SearchRec.Name = '.') or (SearchRec.Name = '..')) then        begin          Last := Length(Folders);          SetLength(Folders, Succ(Last));          Folders[Last] := Folder + SearchRec.Name;          plik := Folder + SearchRec.Name;          ListItem:=lview_pliki.Items.Add;          ListItem.Caption:='oczekuje';
          ListItem.SubItems.Add(plik);
          ListItem.ImageIndex:=8;        end;      until (FindNext(SearchRec) <> 0);      FindClose(SearchRec);    end;  end;end;

end.
