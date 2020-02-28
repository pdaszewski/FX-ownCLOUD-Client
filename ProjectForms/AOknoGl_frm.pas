unit AOknoGl_frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.CategoryButtons, Vcl.WinXCtrls,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Imaging.jpeg,
  Vcl.WinXPanels, Vcl.Buttons, ShellAPI, Vcl.Menus, IdBaseComponent, IdCoder,
  IdCoder3to4, IdCoderMIME, System.Hash;

type
  TAOknoGl = class(TForm)
    imlIcons: TImageList;
    ActionList1: TActionList;
    actHome: TAction;
    actLayout: TAction;
    actUpload: TAction;
    pnlToolbar: TPanel;
    imgMenu: TImage;
    lblTitle: TLabel;
    SV: TSplitView;
    catMenuItems: TCategoryButtons;
    CardPanel: TCardPanel;
    Card1: TCard;
    Card2: TCard;
    lbl_katalog: TLabel;
    pnl_czekaj: TPanel;
    img_next: TImage;
    img_prev: TImage;
    Panel1: TPanel;
    Label8: TLabel;
    Image4: TImage;
    Image5: TImage;
    Panel2: TPanel;
    Label9: TLabel;
    Image3: TImage;
    Image6: TImage;
    Panel3: TPanel;
    Splitter1: TSplitter;
    pnl_logi: TPanel;
    lview_pliki: TListView;
    Label5: TLabel;
    edt_plik: TEdit;
    Label4: TLabel;
    edt_katalog: TEdit;
    memo_logi: TMemo;
    AutoHideCzyUruchomic: TTimer;
    ProgressBar: TProgressBar;
    PopupMenuListyPlikow: TPopupMenu;
    Odwielist1: TMenuItem;
    gbox_uruchamianie: TGroupBox;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    AutoRun: TTimer;
    N1: TMenuItem;
    Usuplik1: TMenuItem;
    actBack: TAction;
    GroupBox1: TGroupBox;
    Label6: TLabel;
    edt_adres: TEdit;
    Label1: TLabel;
    edt_user: TEdit;
    Label2: TLabel;
    edt_password: TEdit;
    btn_ustaw_konfiguracje: TButton;
    grpCloseStyle: TRadioGroup;
    lblVclStyle: TLabel;
    cbxVclStyles: TComboBox;
    actEnd: TAction;
    CategoryButtons1: TCategoryButtons;
    actCreateCatalog: TAction;
    pnl_edycja_nazwy: TPanel;
    lbl_edycja_nazwy: TLabel;
    edt_edycja_nazwy: TEdit;
    btn_anuluj_edycje_nazwy: TButton;
    btn_zatwierdz_edycje_nazwy: TButton;
    Zmienazw1: TMenuItem;
    lbl_stara_nazwa: TLabel;
    actUploadFolder: TAction;
    cbox_logi: TCheckBox;
    ZapiszlistdoplikuCSV1: TMenuItem;
    N2: TMenuItem;
    SaveDialogCSV: TSaveDialog;
    Image2: TImage;
    img_maksymalizacja: TImage;
    img_max: TImage;
    img_norm: TImage;
    cbox_border_style: TCheckBox;
    img_minimalizacja: TImage;
    TrayIcon1: TTrayIcon;
    cbox_minimalizacja: TCheckBox;
    Label7: TLabel;
    cbox_jednostka: TComboBox;
    cbox_auto_open: TCheckBox;
    actTrash: TAction;
    Label10: TLabel;
    Label11: TLabel;
    SearchBox1: TSearchBox;
    lbl_info: TLabel;
    lbl_info_fx: TLabel;

    procedure Uruchom_folder_domowy;
    procedure Wczytaj_konfiguracje;

    procedure btn_ustaw_konfiguracjeClick(Sender: TObject);
    procedure btn_dir_wyb_kataloguClick(Sender: TObject);
    procedure btn_sciagnij_restClick(Sender: TObject);
    procedure lview_plikiDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure catMenuItemsCategories0Items0Click(Sender: TObject);
    procedure actHomeExecute(Sender: TObject);
    procedure img_nextClick(Sender: TObject);
    procedure img_prevClick(Sender: TObject);
    procedure grpCloseStyleClick(Sender: TObject);
    procedure actLayoutExecute(Sender: TObject);
    procedure actUploadExecute(Sender: TObject);
    procedure cbxVclStylesChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure AutoHideCzyUruchomicTimer(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Odwielist1Click(Sender: TObject);
    procedure AutoRunTimer(Sender: TObject);
    procedure Usuplik1Click(Sender: TObject);
    procedure actBackExecute(Sender: TObject);
    procedure actEndExecute(Sender: TObject);
    procedure actCreateCatalogExecute(Sender: TObject);
    procedure btn_anuluj_edycje_nazwyClick(Sender: TObject);
    procedure btn_zatwierdz_edycje_nazwyClick(Sender: TObject);
    procedure PopupMenuListyPlikowPopup(Sender: TObject);
    procedure Zmienazw1Click(Sender: TObject);
    procedure actUploadFolderExecute(Sender: TObject);
    procedure cbox_logiClick(Sender: TObject);
    procedure lview_plikiColumnClick(Sender: TObject; Column: TListColumn);
    procedure lview_plikiCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure ZapiszlistdoplikuCSV1Click(Sender: TObject);
    procedure img_maksymalizacjaClick(Sender: TObject);
    procedure cbox_border_styleClick(Sender: TObject);
    procedure img_minimalizacjaClick(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure pnlToolbarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure actTrashExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SearchBox1InvokeSearch(Sender: TObject);
  private
   procedure WMNCHitTest(var Msg: TWMNCHitTest) ; message WM_NCHitTest;
  public
   Var
    czy_wartosci_w_bajtach : Boolean;
  end;

const
 wersja = '0.7.0';
 data_kompilacji = '2018-04-28';
 nazwa_aplikacji = 'FX Systems ownCLOUD Client';

var
  AOknoGl: TAOknoGl;
  plik_konfiguracji : String;
  SortedColumn : Integer;
  Descending : Boolean;
  czy_aplikacja_juz_uruchomiona : Boolean;
  jestem_w_kosztu : Boolean;

implementation

{$R *.dfm}

uses ownCLOUDunit_frm, Vcl.Themes, WgrywanieFolderu_frm;

function AttachConsole(dwProcessID: Integer): Boolean; stdcall; external 'kernel32.dll';

procedure TAOknoGl.WMNCHitTest(var Msg: TWMNCHitTest) ;
begin
   inherited;
   if Msg.Result = htClient then Msg.Result := htCaption;
end;

procedure TAOknoGl.actBackExecute(Sender: TObject);
Var
 poprzedni_folder : String;
 poz, i : Integer;
begin
 poprzedni_folder:=Trim(edt_katalog.Text);
 if poprzedni_folder<>'/' then
  Begin
   for i := 1 to Length(poprzedni_folder) do
    Begin
     if poprzedni_folder[i]='/' then poz:=i;
    End;
   Delete(poprzedni_folder,poz,Length(poprzedni_folder));
   edt_katalog.Text:=poprzedni_folder;
   btn_dir_wyb_kataloguClick(Self);
   jestem_w_kosztu:=False;
  End;
end;

procedure TAOknoGl.actCreateCatalogExecute(Sender: TObject);
begin
 if jestem_w_kosztu=False then
  Begin
   pnl_edycja_nazwy.Visible:=True;
   edt_edycja_nazwy.Clear;
   lbl_edycja_nazwy.Caption:='Tworzenie nowego folderu:';
   edt_edycja_nazwy.SetFocus;
  End
 else ShowMessage('W koszu nie mo¿esz tworzyæ katalogów!');
end;

procedure TAOknoGl.actEndExecute(Sender: TObject);
begin
 Close;
end;

procedure TAOknoGl.actHomeExecute(Sender: TObject);
begin
 jestem_w_kosztu:=False;
 Uruchom_folder_domowy;
 Card1.Show;
end;

procedure TAOknoGl.actLayoutExecute(Sender: TObject);
begin
 Card2.Show;
end;

procedure TAOknoGl.actTrashExecute(Sender: TObject);
begin
 pnl_czekaj.Visible:=True;
 Application.ProcessMessages;
 memo_logi.Text:=ownCLOUDunit.Kosz;
 ownCLOUDunit.PrzygotujListePlikow(ownCLOUDunit.GenerujListePlikow(memo_logi.Text),lview_pliki,lbl_katalog);
 jestem_w_kosztu:=True;
 edt_katalog.Text:='/Trash';
 edt_plik.Clear;
 pnl_czekaj.Visible:=False;
 Application.ProcessMessages;
end;

procedure TAOknoGl.actUploadExecute(Sender: TObject);
begin
 if jestem_w_kosztu=False then
  Begin
   pnl_czekaj.Visible:=True;
   ProgressBar.Visible:=True;
   Application.ProcessMessages;
   memo_logi.Text:=ownCLOUDunit.Upload(edt_katalog.Text);
   pnl_czekaj.Visible:=False;
   ProgressBar.Visible:=False;
   Application.ProcessMessages;
   btn_dir_wyb_kataloguClick(Self);
  End
 else ShowMessage('Do kosza nie mo¿esz wgrywaæ plików z Twojego komputera!');
end;

procedure TAOknoGl.actUploadFolderExecute(Sender: TObject);
begin
 if jestem_w_kosztu=False then
  Begin
   WgrywanieFolderu.Show;
   WgrywanieFolderu.lbl_nazwa_folderu.Caption:=edt_katalog.Text;
  End
 else ShowMessage('Do kosza nie mo¿esz wgraæ folderu z Twojego komputera!'+#13+'To nie ten kosz!!!');
end;

procedure TAOknoGl.AutoHideCzyUruchomicTimer(Sender: TObject);
begin
 AutoHideCzyUruchomic.Enabled:=False;
 gbox_uruchamianie.Visible:=False;
end;

procedure TAOknoGl.AutoRunTimer(Sender: TObject);
Var
 i : Integer;
 debugowanie, tryb, komenda, katalog_roboczy, obiekt : String;
 output : String;
begin
 AutoRun.Enabled:=False;
 Wczytaj_konfiguracje;
 btn_ustaw_konfiguracjeClick(Self);
 czy_aplikacja_juz_uruchomiona:=True;

 if ParamCount>0 then
  Begin
   tryb:=''; komenda:=''; katalog_roboczy:=''; obiekt:='';
   for i := 1 to ParamCount do
    Begin
     if i=1 then tryb           :=AnsiLowerCase(Trim(paramstr(i)));
     if i=2 then debugowanie    :=AnsiLowerCase(Trim(paramstr(i)));
     if i=3 then komenda        :=AnsiUpperCase(Trim(paramstr(i)));
     if i=4 then katalog_roboczy:=paramstr(i);
     if i=5 then obiekt         :=paramstr(i);
    End;

   if (tryb<>'') and (debugowanie<>'') and (katalog_roboczy<>'') and (obiekt<>'') then
   Begin
   if tryb='-auto' then
    Begin
     try
     if komenda='MKDIR' then
      Begin
       edt_katalog.Text:=katalog_roboczy;
       btn_dir_wyb_kataloguClick(Self);
       actCreateCatalogExecute(Self);
       edt_edycja_nazwy.Text:=Trim(obiekt);
       btn_zatwierdz_edycje_nazwyClick(Self);
      End;
     if komenda='DOWNLOAD' then
      Begin
       ownCLOUDunit.DownloadNoDialog(katalog_roboczy,obiekt);
      End;
     if komenda='UPLOAD' then
      Begin
       pnl_czekaj.Visible:=True;
       Application.ProcessMessages;
       ownCLOUDunit.UploadNoDialog(katalog_roboczy,obiekt);
      End;
     if komenda='DELETE' then
      Begin
       pnl_czekaj.Visible:=True;
       Application.ProcessMessages;
       ownCLOUDunit.DeleteOnCloud(katalog_roboczy,obiekt);
      End;
     if komenda='UPLOAD_DIR' then
      Begin
       pnl_czekaj.Visible:=True;
       Application.ProcessMessages;
       edt_katalog.Text:=katalog_roboczy;
       actUploadFolderExecute(Self);
       WgrywanieFolderu.edt_nowy_folder.Text:=obiekt;
       WgrywanieFolderu.Przetwarzaj_wybrany_folder;
       if WgrywanieFolderu.lview_pliki.Items.Count>0 then
       WgrywanieFolderu.btn_wgrajClick(Self);
      end;
     output:='Polecenie wykonane poprawnie!';
     except
       on E : Exception do output:='B³¹d operacji '+komenda+': '+E.Message;
      end;
    End
   else output:='Nie uruchomiono programu w trybie autonomicznym (prze³¹cznik -auto)!';
   End
   else output:='Nie podano wszystkich wymaganych parametrów (tryb, debudowanie, katalog_roboczy, obiekt)';

    if debugowanie='-debug' then
     Begin
      AttachConsole(-1);
      Writeln('');
      Writeln(output);
     End;
   Close;
  End;
end;

procedure TAOknoGl.btn_anuluj_edycje_nazwyClick(Sender: TObject);
begin
 pnl_edycja_nazwy.Visible:=False;
end;

procedure TAOknoGl.btn_dir_wyb_kataloguClick(Sender: TObject);
begin
 pnl_czekaj.Visible:=True;
 Application.ProcessMessages;
 memo_logi.Text:=ownCLOUDunit.Listowanie(Trim(edt_katalog.Text));
 ownCLOUDunit.PrzygotujListePlikow(ownCLOUDunit.GenerujListePlikow(memo_logi.Text),lview_pliki,lbl_katalog);
 pnl_czekaj.Visible:=False;
 Application.ProcessMessages;
end;

procedure TAOknoGl.btn_sciagnij_restClick(Sender: TObject);
begin
 pnl_czekaj.Visible:=True;
 ProgressBar.Visible:=True;
 Application.ProcessMessages;
 memo_logi.Text:=ownCLOUDunit.Download(edt_katalog.Text, edt_plik.Text);
 pnl_czekaj.Visible:=False;
 ProgressBar.Visible:=False;
 Application.ProcessMessages;
end;

procedure TAOknoGl.btn_zatwierdz_edycje_nazwyClick(Sender: TObject);
begin
 if lbl_edycja_nazwy.Caption='Tworzenie nowego folderu:' then
  Begin
   ownCLOUDunit.UtworzFolder(edt_katalog.Text,Trim(edt_edycja_nazwy.Text));
   pnl_edycja_nazwy.Visible:=False;
   btn_dir_wyb_kataloguClick(Self);
  End;
 if lbl_edycja_nazwy.Caption='Zmiana nazwy:' then
  Begin
   ownCLOUDunit.ZmienNazwe(edt_katalog.Text,lbl_stara_nazwa.Caption,edt_edycja_nazwy.Text);
   pnl_edycja_nazwy.Visible:=False;
   btn_dir_wyb_kataloguClick(Self);
  End;
end;

procedure TAOknoGl.btn_ustaw_konfiguracjeClick(Sender: TObject);
begin
 if (Trim(edt_user.Text)<>'') and (Trim(edt_password.Text)<>'') and (Trim(edt_adres.Text)<>'') then
  Begin
   ownCLOUDunit.KonfiguracjaOwnCLOUD(edt_adres.Text, edt_user.Text, edt_password.Text);
   memo_logi.Text:='Konfiguracja ustawiona!';

   ownCLOUDunit.Zapisz_konfiguracje(plik_konfiguracji);

   pnl_czekaj.Visible:=False;
   Application.ProcessMessages;

   Card1.Show;
   SV.Visible       :=True;
   imgMenu.Enabled  :=True;
   img_prev.Enabled :=True;
   img_next.Enabled :=True;
   imgMenuClick(Self);
   SV.Close;
   Application.ProcessMessages;

   Uruchom_folder_domowy;
  End
 else ShowMessage('Nale¿y podaæ u¿ytkownika, has³o i adres serwera ownCLOUD!');
end;

procedure TAOknoGl.catMenuItemsCategories0Items0Click(Sender: TObject);
begin
 Uruchom_folder_domowy;
end;

procedure TAOknoGl.cbox_border_styleClick(Sender: TObject);
begin
 if cbox_border_style.Checked then
  Begin
   AOknoGl.BorderStyle:=bsSizeable;
   img_minimalizacja.Visible:=False;
   img_maksymalizacja.Visible:=False;
   img_prev.Left:=img_minimalizacja.Left;
   img_next.Left:=img_maksymalizacja.Left;
  End
 else
  Begin
   AOknoGl.BorderStyle:=bsNone;
   img_minimalizacja.Visible:=True;
   img_maksymalizacja.Visible:=True;
   img_prev.Left:=img_maksymalizacja.Left-(3*40);
   img_next.Left:=img_maksymalizacja.Left-(2*40);
  End;
end;

procedure TAOknoGl.cbox_logiClick(Sender: TObject);
begin
 pnl_logi.Visible :=cbox_logi.Checked;
 Splitter1.Visible:=cbox_logi.Checked;
end;

procedure TAOknoGl.cbxVclStylesChange(Sender: TObject);
begin
 if czy_aplikacja_juz_uruchomiona=True then
  Begin
   ownCLOUDunit.Zapisz_konfiguracje(plik_konfiguracji);
  End;

 TStyleManager.SetStyle(cbxVclStyles.Text);
 czy_aplikacja_juz_uruchomiona:=False;
end;

procedure TAOknoGl.FormCreate(Sender: TObject);
var
  StyleName: string;
  NewColumn: TListColumn;
begin
 Caption:=nazwa_aplikacji+' - wersja: '+wersja;
 lbl_info.Caption:=nazwa_aplikacji+' - wersja: '+wersja;
 lbl_info_fx.Caption:='FX Systems Piotr Daszewski - Ró¿an ''2018';
 lblTitle.Caption:='Klient ownCLOUD';

 jestem_w_kosztu:=False;
 czy_aplikacja_juz_uruchomiona:=False;
 czy_wartosci_w_bajtach:=False;
 cbox_border_styleClick(Self);
 SortedColumn:=0;
 pnl_edycja_nazwy.Visible:=False;
 ProgressBar.Visible:=False;
 gbox_uruchamianie.Visible:=False;
 pnl_czekaj.Visible:=False;
 pnl_czekaj.Top:=300;
 SV.Visible:=False;
 imgMenu.Enabled:=False;
 img_prev.Enabled:=False;
 img_next.Enabled:=False;
 Splitter1.Visible:=False;
 pnl_logi.Visible:=False;

 lview_pliki.Items.BeginUpdate;
 lview_pliki.Items.Clear;
 NewColumn := lview_pliki.Columns.Add;
 NewColumn.Caption := 'Typ';
 NewColumn.Width:=150;
 NewColumn := lview_pliki.Columns.Add;
 NewColumn.Caption := 'Nazwa';
 NewColumn.Width:=600;
 NewColumn := lview_pliki.Columns.Add;
 NewColumn.Caption := 'Rozmiar';
 NewColumn.Width:=200;
 NewColumn.Alignment:=taRightJustify;
 NewColumn := lview_pliki.Columns.Add;
 NewColumn.Caption := 'Data';
 NewColumn.Width:=220;
 NewColumn.Alignment:=taRightJustify;
 lview_pliki.Items.EndUpdate;

 for StyleName in TStyleManager.StyleNames do cbxVclStyles.Items.Add(StyleName);
 SV.CloseStyle := TSplitViewCloseStyle(grpCloseStyle.ItemIndex);
 cbxVclStyles.ItemIndex := cbxVclStyles.Items.IndexOf(TStyleManager.ActiveStyle.Name);

 plik_konfiguracji:=ExtractFilePath(Application.ExeName)+'Data\';
 if DirectoryExists(plik_konfiguracji)=False then CreateDir(plik_konfiguracji);
 plik_konfiguracji:=plik_konfiguracji+'Configuration.txt';
 Card2.Show;
 Application.ProcessMessages;
end;

procedure TAOknoGl.FormResize(Sender: TObject);
begin
 if (cbox_border_style.Checked=True) and (WindowState=wsMinimized) then
  Begin
   if cbox_minimalizacja.Checked then
    Begin
     Hide();
     WindowState := wsMinimized;
     TrayIcon1.Visible := True;
     TrayIcon1.ShowBalloonHint;
    End;
  End;
end;

procedure TAOknoGl.FormShow(Sender: TObject);
begin
 if czy_aplikacja_juz_uruchomiona=False then
  Begin
   if FileExists(plik_konfiguracji)=True then AutoRun.Enabled:=True;
  End;
end;

procedure TAOknoGl.grpCloseStyleClick(Sender: TObject);
begin
 SV.CloseStyle := TSplitViewCloseStyle(grpCloseStyle.ItemIndex);
end;

procedure TAOknoGl.img_minimalizacjaClick(Sender: TObject);
begin
 if cbox_minimalizacja.Checked then
  Begin
   Hide();
   WindowState := wsMinimized;
   TrayIcon1.Visible := True;
   TrayIcon1.ShowBalloonHint;
   czy_aplikacja_juz_uruchomiona:=False;
  End
 else WindowState:=wsMinimized;
end;

procedure TAOknoGl.img_maksymalizacjaClick(Sender: TObject);
begin
 if img_maksymalizacja.Hint='Maksymalizuj okno' then
  Begin
   img_maksymalizacja.Hint:='Zmniejsz okno';
   img_maksymalizacja.Picture:=img_norm.Picture;
   WindowState:=wsMaximized;
  End
 else
  Begin
   img_maksymalizacja.Hint:='Maksymalizuj okno';
   img_maksymalizacja.Picture:=img_max.Picture;
   WindowState:=wsNormal;
  End;
end;

procedure TAOknoGl.img_nextClick(Sender: TObject);
begin
 CardPanel.NextCard;
end;

procedure TAOknoGl.img_prevClick(Sender: TObject);
begin
 CardPanel.PreviousCard;
end;

procedure TAOknoGl.imgMenuClick(Sender: TObject);
begin
 if SV.Opened then
    SV.Close
  else
    SV.Open;
end;

procedure TAOknoGl.lview_plikiColumnClick(Sender: TObject; Column: TListColumn);
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

procedure TAOknoGl.lview_plikiCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
 if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)
 else
 if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
 if Descending then Compare := -Compare;
end;

procedure TAOknoGl.lview_plikiDblClick(Sender: TObject);
Var
  typ   : String;
  plik  : string;
begin
 if (lview_pliki.ItemIndex>-1) and (jestem_w_kosztu=False) then
  Begin
   typ  :=Trim(lview_pliki.Items[lview_pliki.ItemIndex].Caption);
   plik :=Trim(lview_pliki.Items[lview_pliki.ItemIndex].SubItems.Strings[0]);
   if typ='plik' then
    Begin
     edt_katalog.Text :=lbl_katalog.Caption;
     edt_plik.Text    :=Trim(plik);
     btn_sciagnij_restClick(Self);

     if Pos('Plik pobrany:',memo_logi.Text)>0 then
      Begin

       if cbox_auto_open.Checked then
        Begin
         plik:=Trim(StringReplace(memo_logi.Text,'Plik pobrany:','',[rfReplaceAll]));
         if FileExists(plik) then ShellExecute(Handle, 'open', PWideChar(plik), nil, nil, SW_SHOWNORMAL);
        End
       else
        Begin
         gbox_uruchamianie.Visible:=True;
         AutoHideCzyUruchomic.Enabled:=True;
        End;

      End
     else gbox_uruchamianie.Visible:=False;
    End;
   if typ='katalog' then
    Begin
     edt_katalog.Text :=Trim(StringReplace(lbl_katalog.Caption+'/'+Trim(plik),'//','/',[rfReplaceAll]));
     edt_plik.Text    :='';
     btn_dir_wyb_kataloguClick(Self);
    End;
  End;
end;

procedure TAOknoGl.Odwielist1Click(Sender: TObject);
begin
 btn_dir_wyb_kataloguClick(Self);
end;

procedure TAOknoGl.pnlToolbarMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ReleaseCapture;
 SendMessage(AOknoGl.Handle, WM_SYSCOMMAND, 61458, 0) ;
end;

procedure TAOknoGl.PopupMenuListyPlikowPopup(Sender: TObject);
var
  typ: string;
begin
 if jestem_w_kosztu=False then
  Begin
   Odwielist1.Enabled:=True;
   Zmienazw1.Enabled:=True;
   Usuplik1.Enabled:=True;

   if lview_pliki.ItemIndex>-1 then
    Begin
     typ  :=Trim(lview_pliki.Items[lview_pliki.ItemIndex].Caption);
     if typ='plik' then Usuplik1.Caption:='Usuñ plik'
     else Usuplik1.Caption:='Usuñ folder';
    End;
  End
 else
  Begin
   Odwielist1.Enabled:=False;
   Zmienazw1.Enabled:=False;
   Usuplik1.Enabled:=False;
  End;
end;

procedure TAOknoGl.SearchBox1InvokeSearch(Sender: TObject);
var
  nazwa, szukaj: string;
  lista_do_usuniecia : TStringList;
  i : Integer;
begin
 szukaj:=Trim(AnsiLowerCase(SearchBox1.Text));
 if szukaj<>'' then
  Begin
   lista_do_usuniecia:=TStringList.Create;
   for i := lview_pliki.Items.Count-1 downto 0 do
    Begin
     nazwa:=Trim(AnsiLowerCase(lview_pliki.Items[i].SubItems.Strings[0]));
     if Pos(szukaj,nazwa)=0 then lview_pliki.Items[i].Delete;
    End;
   lista_do_usuniecia.Free;
  End
 else actHomeExecute(Self);
end;

procedure TAOknoGl.SpeedButton1Click(Sender: TObject);
var
  plik: string;
begin
 gbox_uruchamianie.Visible:=False;
 plik:=Trim(StringReplace(memo_logi.Text,'Plik pobrany:','',[rfReplaceAll]));
 if FileExists(plik) then ShellExecute(Handle, 'open', PWideChar(plik), nil, nil, SW_SHOWNORMAL);
end;

procedure TAOknoGl.SpeedButton2Click(Sender: TObject);
begin
 gbox_uruchamianie.Visible:=False;
end;

procedure TAOknoGl.TrayIcon1DblClick(Sender: TObject);
begin
 TrayIcon1.Visible := False;
 Show();
 WindowState := wsNormal;
 Application.BringToFront();
 if cbox_border_style.Checked=False then
  Begin
   img_maksymalizacja.Hint:='Maksymalizuj okno';
   img_maksymalizacja.Picture:=img_max.Picture;
  End;
end;

procedure TAOknoGl.Uruchom_folder_domowy;
Begin
 pnl_czekaj.Visible:=True;
 Application.ProcessMessages;
 memo_logi.Text:=ownCLOUDunit.Listowanie('/');
 ownCLOUDunit.PrzygotujListePlikow(ownCLOUDunit.GenerujListePlikow(memo_logi.Text),lview_pliki,lbl_katalog);
 edt_katalog.Text:='/';
 edt_plik.Clear;
 pnl_czekaj.Visible:=False;
 Application.ProcessMessages;
End;

procedure TAOknoGl.Usuplik1Click(Sender: TObject);
Var
  typ, typ_pom : String;
  plik: string;
  wyb : Integer;
begin
 if lview_pliki.ItemIndex>-1 then
  Begin
   typ  :=Trim(lview_pliki.Items[lview_pliki.ItemIndex].Caption);
   typ_pom:=AnsiUpperCase(typ); Delete(typ_pom,2,Length(typ_pom));
   typ_pom:=typ_pom+Copy(typ,2,Length(typ));
   plik :=Trim(lview_pliki.Items[lview_pliki.ItemIndex].SubItems.Strings[0]);
     edt_katalog.Text :=lbl_katalog.Caption;
     edt_plik.Text    :=Trim(plik);
     wyb := MessageBox(Handle,
     PWideChar('Czy na pewno chcesz usun¹æ '+typ+':'+#13+'"'+edt_plik.Text+'" ?'+#13+typ_pom+' trafi do kosza i bêdzie mo¿na go przywróciæ!'), 'Usuwanie pliku/folderu z serwera', MB_YESNO + MB_ICONQUESTION);
     if wyb = mrYes then
      Begin
       ownCLOUDunit.DeleteOnCloud(edt_katalog.Text,edt_plik.Text);
       btn_dir_wyb_kataloguClick(Self);
      End;
  End;
end;

procedure TAOknoGl.Wczytaj_konfiguracje;
Var
 plik : TextFile;
 linia : String;
 poz : Integer;
 dana : String;
Begin
 AssignFile(plik,plik_konfiguracji);
 Reset(plik);
  Repeat
   Readln(plik,linia);
   if Pos('address',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     edt_adres.Text:=dana;
    End;
   if Pos('user',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     edt_user.Text:=dana;
    End;
   if Pos('password',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     edt_password.Text:=ownCLOUDunit.DecryptStr(dana,2018);
    End;
   if Pos('theme',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     cbxVclStyles.ItemIndex:=cbxVclStyles.Items.IndexOf(dana);
     cbxVclStylesChange(Self);
    End;
   if Pos('menu_closing',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     grpCloseStyle.ItemIndex:=StrToInt(dana);
    End;
   if Pos('logs',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     cbox_logi.Checked:=StrToBool(dana);
    End;
   if Pos('window_border',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     cbox_border_style.Checked:=StrToBool(dana);
    End;
   if Pos('tray_setting',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     cbox_minimalizacja.Checked:=StrToBool(dana);
    End;
   if Pos('files_size_in',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     cbox_jednostka.ItemIndex:=cbox_jednostka.Items.IndexOf(dana);
    End;
   if Pos('files_auto_open',linia)>0 then
    Begin
     poz:=Pos('=',linia); Delete(linia,1,poz);
     dana:=Trim(linia);
     cbox_auto_open.Checked:=StrToBool(dana);
    End;
  Until eof(plik);
 CloseFile(plik);

 SV.Close;
End;

procedure TAOknoGl.ZapiszlistdoplikuCSV1Click(Sender: TObject);
Var
  plik : TextFile;
  linia : String;
  i, ip: Integer;
begin
 if SaveDialogCSV.Execute then
  Begin
   AssignFile(plik,SaveDialogCSV.FileName);
   Rewrite(plik);
    Writeln(plik,'Typ obiektu;Nazwa;Œcie¿ka;Rozmiar;Data utworzenia');
    for i := 0 to lview_pliki.Items.Count-1 do
     Begin
      linia:='';
      linia:=lview_pliki.Items[i].Caption;
      for ip := 0 to lview_pliki.Items[i].SubItems.Count-1 do
       Begin
        linia:=linia+';'+lview_pliki.Items[i].SubItems.Strings[ip];
        if ip=0 then
        linia:=linia+';'+StringReplace(edt_katalog.Text+'/'+lview_pliki.Items[i].SubItems.Strings[ip],'//','/',[rfReplaceAll]);
       End;
      Writeln(plik,linia);
     End;
   CloseFile(plik);
   ShowMessage('Lista poprawnie zapisana do pliku: '+SaveDialogCSV.FileName);
  End;
end;

procedure TAOknoGl.Zmienazw1Click(Sender: TObject);
Var
  typ : String;
  plik: string;
begin
 if lview_pliki.ItemIndex>-1 then
  Begin
   typ  :=Trim(lview_pliki.Items[lview_pliki.ItemIndex].Caption);
   plik :=Trim(lview_pliki.Items[lview_pliki.ItemIndex].SubItems.Strings[0]);
   pnl_edycja_nazwy.Visible:=True;
   lbl_edycja_nazwy.Caption:='Zmiana nazwy:';
   lbl_stara_nazwa.Caption:=plik;
   edt_edycja_nazwy.Text:=plik;
   edt_edycja_nazwy.SetFocus;
  End;
end;

end.
