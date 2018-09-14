unit ownCLOUDunit_frm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.Response.Adapter,
  REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
  Data.Bind.ObjectScope, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, ShellApi, System.JSON, Vcl.ComCtrls, Vcl.StdCtrls,
  System.ImageList, Vcl.ImgList, IdWebDAV, HTTPApp, DateUtils;

type
  TownCLOUDunit = class(TForm)
    IdHTTP_ownCLOUD: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL_ownCLOUD: TIdSSLIOHandlerSocketOpenSSL;
    RESTClient_ownCLOUD: TRESTClient;
    RESTRequest_ownCLOUD: TRESTRequest;
    RESTResponse_ownCLOUD: TRESTResponse;
    HTTPBasicAuthenticator_ownCLOUD: THTTPBasicAuthenticator;
    SaveDialog_ownCLOUD: TSaveDialog;
    OpenDialog_ownCLOUD: TOpenDialog;
    ImageList: TImageList;
    IdWebDAV_ownCLOUD: TIdWebDAV;

    procedure KonfiguracjaOwnCLOUD(adres, uzytkownik, haslo : String);
    function JSONStringToList(json_in : String) : String;
    function GenerujListePlikow(json_in : String) : String;
    procedure PrzygotujListePlikow(lista_in : String; widok_listy : TListView; katalog_nadrzedny : TLabel);
    function EncryptStr(const S :WideString; Key: Word): String;
    function DecryptStr(const S: String; Key: Word): String;
    procedure Zapisz_konfiguracje(plik : String);
    function UtworzFolder(do_folderu, nowy_folder : String) : String;
    function ZmienNazwe(folder, stara_nazwa, nowa_nazwa : String) : String;
    function EncodeURI(const AURI: string): String;

    function Listowanie(folder : String) : String;
    function Kosz : String;
    function Download(folder, plik : String) : String;
    function DownloadNoDialog(plik_serwer, do_folderu : String) : String;
    function DeleteOnCloud(folder, plik : String) : String;
    function Upload(do_folderu : String) : String;
    function UploadNoDialog(do_folderu, plik : String) : String;

    procedure IdHTTP_ownCLOUDWorkBegin(ASender: TObject; AWorkMode: TWorkMode;AWorkCountMax: Int64);
    procedure IdHTTP_ownCLOUDWork(ASender: TObject; AWorkMode: TWorkMode;AWorkCount: Int64);
    procedure IdHTTP_ownCLOUDWorkEnd(ASender: TObject; AWorkMode: TWorkMode);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const CKEY1 = 53761;
      CKEY2 = 32618;

var
  ownCLOUDunit: TownCLOUDunit;
  ownCLOUD_user: String;
  ownCLOUD_password: String;
  ownCLOUD_address: String;

implementation

{$R *.dfm}

uses AOknoGl_frm;

procedure TownCLOUDunit.KonfiguracjaOwnCLOUD(adres, uzytkownik, haslo : String);
Begin
 ownCLOUD_user      :=Trim(uzytkownik);
 ownCLOUD_password  :=Trim(haslo);
 ownCLOUD_address   :=Trim(adres);
 HTTPBasicAuthenticator_ownCLOUD.Username  :=Trim(ownCLOUD_user);
 HTTPBasicAuthenticator_ownCLOUD.Password  :=Trim(ownCLOUD_password);
End;

function TownCLOUDunit.JSONStringToList(json_in : String) : String;
Var
 wynik : String;
Begin
 wynik:='';
 wynik:=StringReplace(json_in,'[','['+#13#10,[rfReplaceAll]);
 wynik:=StringReplace(wynik,'{','{'+#13#10,[rfReplaceAll]);
 wynik:=StringReplace(wynik,',',','+#13#10,[rfReplaceAll]);
 wynik:=StringReplace(wynik,'}',#13#10+'}',[rfReplaceAll]);
 wynik:=StringReplace(wynik,']',#13#10+']',[rfReplaceAll]);

 JSONStringToList:=wynik;
End;

function TownCLOUDunit.GenerujListePlikow(json_in : String) : String;
Var
  wynik : TStringList;
  lista : TStringList;
  poz, i: Integer;
  linia: String;
  dana: String;
  nazwa: string;
  rozmiar: string;
  typ: string;
  czas: string;

Begin
 wynik:=TStringList.Create;
 json_in:=StringReplace(json_in,'"','',[rfReplaceAll]);
 lista:=TStringList.Create;
 lista.Text:=json_in;
  for i := 0 to lista.Count-1 do
   Begin
    linia:=Trim(lista.Strings[i]);
    if Pos('directory:',linia)>0 then
     Begin
      poz:=Pos(':',linia); Delete(linia,1,poz);
      dana:=StringReplace(linia,',','',[rfReplaceAll]);
      wynik.Add('Katalog nadrzêdny: '+dana);
     End;

    if Pos('id:',linia)>0 then
     Begin
      linia:=Trim(lista.Strings[i+2]);
      poz:=Pos(':',linia); Delete(linia,1,poz);
      czas:=StringReplace(linia,',','',[rfReplaceAll]);
      czas:=StringReplace(czas,'000','',[rfReplaceAll]);
      czas:=DateTimeToStr(IncHour(DateUtils.UnixToDateTime(StrToInt64(czas)),2));

      linia:=Trim(lista.Strings[i+3]);
      poz:=Pos(':',linia); Delete(linia,1,poz);
      nazwa:=StringReplace(linia,',','',[rfReplaceAll]);

      linia:=Trim(lista.Strings[i+6]);
      poz:=Pos(':',linia); Delete(linia,1,poz);
      rozmiar:=StringReplace(linia,',','',[rfReplaceAll]);

      linia:=Trim(lista.Strings[i+7]);
      poz:=Pos(':',linia); Delete(linia,1,poz);
      typ:=StringReplace(linia,',','',[rfReplaceAll]);
      if Pos('dir',typ)>0 then typ:='katalog' else typ:='plik';

      wynik.Add(typ+';'+nazwa+';'+rozmiar+';'+czas);
     End;
   End;
 lista.Free;
 GenerujListePlikow:=wynik.Text;
 wynik.Free;
End;

procedure TownCLOUDunit.IdHTTP_ownCLOUDWork(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCount: Int64);
begin
 if AWorkMode=wmRead then
     AOknoGl.ProgressBar.Position := AWorkCount;
end;

procedure TownCLOUDunit.IdHTTP_ownCLOUDWorkBegin(ASender: TObject;
  AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
 if AWorkMode = wmRead then
   begin
      AOknoGl.ProgressBar.Max := AWorkCountMax;
      AOknoGl.ProgressBar.Position := 0;
   end;
end;

procedure TownCLOUDunit.IdHTTP_ownCLOUDWorkEnd(ASender: TObject;
  AWorkMode: TWorkMode);
begin
 AOknoGl.ProgressBar.Position := 0;
end;

function TownCLOUDunit.Listowanie(folder: string): String;
 Var
  jValue: TJSONValue;
  wynik: String;
begin
 wynik:='';
 folder:=Trim(folder);

 Restclient_ownCLOUD.BaseURL := 'https://'+ownCLOUD_address+'/index.php/apps/files/ajax/list.php?dir='+folder;
 RESTRequest_ownCLOUD.Execute;

 jValue := RESTResponse_ownCLOUD.JSONValue;
 wynik := JSONStringToList(jValue.ToString);

 listowanie := wynik;
end;

function TownCLOUDunit.Kosz : String;
Var
  jValue: TJSONValue;
  wynik: String;
begin
 wynik:='';

 Restclient_ownCLOUD.BaseURL := 'https://'+ownCLOUD_address+'/index.php/apps/files_trashbin/ajax/list.php?dir=/';
 RESTRequest_ownCLOUD.Execute;

 jValue := RESTResponse_ownCLOUD.JSONValue;
 wynik := JSONStringToList(jValue.ToString);

 Kosz := wynik;
end;

function TownCLOUDunit.Download(folder, plik : String) : String;
var
  Stream: TMemoryStream;
  Url, Filename : String;
  wynik : String;
begin
  wynik:='';
  folder:=Trim(folder);
  plik:=Trim(plik);

  IdHTTP_ownCLOUD.Request.UserName := ownCLOUD_user;
  IdHTTP_ownCLOUD.Request.Password := ownCLOUD_password;
  IdHTTP_ownCLOUD.Request.BasicAuthentication := true;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IdHTTP_ownCLOUD.IOHandler := IdSSLIOHandlerSocketOpenSSL_ownCLOUD;

  URL := 'https://'+ownCLOUD_address+'/index.php/apps/files/ajax/download.php?files='+plik+'&dir='+folder;
  URL := EncodeURI(URL);

  SaveDialog_ownCLOUD.FileName:=Trim(plik);
  if SaveDialog_ownCLOUD.Execute then
   Begin
    Filename := SaveDialog_ownCLOUD.FileName;
    if FileExists(Filename) then DeleteFile(Filename);

    Stream := TMemoryStream.Create;
    try
      IdHTTP_ownCLOUD.Get(URL, Stream);
      Stream.SaveToFile(FileName);
    finally
      Stream.Free;
    end;

    if FileExists(Filename) then wynik:='Plik pobrany: '+Filename
    else wynik:='Nie uda³o siê pobraæ pliku!';
   End;
 Download:=wynik;
End;

function TownCLOUDunit.DownloadNoDialog(plik_serwer, do_folderu : String) : String;
var
  Stream: TMemoryStream;
  Filename, Url, plik, folder : String;
  wynik : String;
  i, poz : Integer;
begin
  wynik:='';
  plik_serwer:=Trim(plik_serwer);
  do_folderu:=Trim(do_folderu);
  if do_folderu[Length(do_folderu)]<>'\' then do_folderu:=do_folderu+'\';

  for i := 0 to Length(plik_serwer) do
   Begin
    if plik_serwer[i]='/' then poz:=i;
   End;
  plik:=Trim(Copy(plik_serwer,poz+1,Length(plik_serwer)));
  folder:=Trim(StringReplace(plik_serwer,plik,'',[rfReplaceAll]));

  IdHTTP_ownCLOUD.Request.UserName := ownCLOUD_user;
  IdHTTP_ownCLOUD.Request.Password := ownCLOUD_password;
  IdHTTP_ownCLOUD.Request.BasicAuthentication := true;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IdHTTP_ownCLOUD.IOHandler := IdSSLIOHandlerSocketOpenSSL_ownCLOUD;

  URL := 'https://'+ownCLOUD_address+'/index.php/apps/files/ajax/download.php?files='+plik+'&dir='+folder;
  URL := EncodeURI(URL);

   Begin
    Filename := do_folderu+plik;
    if FileExists(Filename) then DeleteFile(Filename);

    Stream := TMemoryStream.Create;
    try
      IdHTTP_ownCLOUD.Get(URL, Stream);
      Stream.SaveToFile(FileName);
    finally
      Stream.Free;
    end;

    if FileExists(Filename) then wynik:='Plik pobrany: '+Filename
    else wynik:='Nie uda³o siê pobraæ pliku!';
   End;
 DownloadNoDialog:=wynik;
End;

function TownCLOUDunit.Upload(do_folderu : String) : String;
var
  Stream: TMemoryStream;
  Url, Filename : String;
  wynik : String;
  plik : String;
begin
  wynik:='';
  do_folderu:=Trim(do_folderu);

  IdHTTP_ownCLOUD.Request.UserName := ownCLOUD_user;
  IdHTTP_ownCLOUD.Request.Password := ownCLOUD_password;
  IdHTTP_ownCLOUD.Request.BasicAuthentication := true;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IdHTTP_ownCLOUD.IOHandler := IdSSLIOHandlerSocketOpenSSL_ownCLOUD;

  OpenDialog_ownCLOUD.FileName:=Trim(plik);
  if OpenDialog_ownCLOUD.Execute then
   Begin
    Filename := OpenDialog_ownCLOUD.FileName;
    plik:=ExtractFileName(Filename);

    URL:='https://'+ownCLOUD_address+'/remote.php/webdav'+do_folderu+'/'+plik;
    URL := EncodeURI(URL);

    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(FileName);
    try
      IdHTTP_ownCLOUD.Put(URL, Stream);
    finally
      Stream.Free;
    end;

    wynik:='Plik zosta³ zapisany do: '+do_folderu+'/'+plik
   End;
 Upload:=wynik;
end;

function TownCLOUDunit.UploadNoDialog(do_folderu, plik : String) : String;
var
  Stream: TMemoryStream;
  Url, Filename : String;
  wynik : String;
  plik_wew : String;
begin
  wynik:='';
  do_folderu:=Trim(do_folderu);

  IdHTTP_ownCLOUD.Request.UserName := ownCLOUD_user;
  IdHTTP_ownCLOUD.Request.Password := ownCLOUD_password;
  IdHTTP_ownCLOUD.Request.BasicAuthentication := true;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IdHTTP_ownCLOUD.IOHandler := IdSSLIOHandlerSocketOpenSSL_ownCLOUD;

    Filename := plik;
    plik_wew:=ExtractFileName(Filename);

    URL:='https://'+ownCLOUD_address+'/remote.php/webdav'+do_folderu+'/'+plik_wew;
    URL := EncodeURI(URL);

    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(FileName);
    try
      IdHTTP_ownCLOUD.Put(URL, Stream);
    finally
      Stream.Free;
    end;

    wynik:='Plik zosta³ zapisany do: '+do_folderu+'/'+plik;

 UploadNoDialog:=wynik;
end;

function TownCLOUDunit.DeleteOnCloud(folder, plik : String) : String;
var
  Stream: TMemoryStream;
  Url, Filename : String;
  wynik : String;
begin
  wynik:='';

  IdHTTP_ownCLOUD.Request.UserName := ownCLOUD_user;
  IdHTTP_ownCLOUD.Request.Password := ownCLOUD_password;
  IdHTTP_ownCLOUD.Request.BasicAuthentication := true;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IdHTTP_ownCLOUD.IOHandler := IdSSLIOHandlerSocketOpenSSL_ownCLOUD;

    URL:='https://'+ownCLOUD_address+'/remote.php/webdav'+folder+'/'+plik;
    URL := EncodeURI(URL);

    Stream := TMemoryStream.Create;
    try
      IdHTTP_ownCLOUD.Delete(URL,Stream);
    finally
      Stream.Free;
    end;

    wynik:='Plik zosta³ poprawnie usuniêty z: '+folder+'/'+plik;
 DeleteOnCloud:=wynik;
end;

function TownCLOUDunit.UtworzFolder(do_folderu, nowy_folder : String) : String;
var
  Stream: TMemoryStream;
  Url, Filename : String;
  wynik : String;
  plik : String;
begin
  wynik:='';
  do_folderu:=Trim(do_folderu);
  nowy_folder:=Trim(nowy_folder);

  IdWebDAV_ownCLOUD.Request.UserName := ownCLOUD_user;
  IdWebDAV_ownCLOUD.Request.Password := ownCLOUD_password;
  IdWebDAV_ownCLOUD.Request.BasicAuthentication := true;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IdWebDAV_ownCLOUD.IOHandler := IdSSLIOHandlerSocketOpenSSL_ownCLOUD;
  IdWebDAV_ownCLOUD.AllowCookies := True;
  IdWebDAV_ownCLOUD.HandleRedirects := True;
  IdWebDAV_ownCLOUD.Request.ContentType := 'application/x-www-form-urlencoded';

    URL:='https://'+ownCLOUD_address+'/remote.php/webdav'+do_folderu+'/'+nowy_folder;
    URL := EncodeURI(URL);

 IdWebDAV_ownCLOUD.DAVMakeCollection(URL);

 wynik:='Folder: '+do_folderu+'/'+nowy_folder+' zosta³ poprawnie utworzony!';
 UtworzFolder:=wynik;
end;

function TownCLOUDunit.ZmienNazwe(folder, stara_nazwa, nowa_nazwa : String) : String;
var
  Stream: TMemoryStream;
  URL, DESTURL : String;
  wynik : String;
  plik : String;
begin
  wynik:='';
  stara_nazwa:=Trim(stara_nazwa);
  nowa_nazwa:=Trim(nowa_nazwa);
  folder:=Trim(folder);

  IdWebDAV_ownCLOUD.Request.UserName := ownCLOUD_user;
  IdWebDAV_ownCLOUD.Request.Password := ownCLOUD_password;
  IdWebDAV_ownCLOUD.Request.BasicAuthentication := true;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocketOpenSSL_ownCLOUD.SSLOptions.SSLVersions := [sslvSSLv2, sslvSSLv3, sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  IdWebDAV_ownCLOUD.IOHandler := IdSSLIOHandlerSocketOpenSSL_ownCLOUD;
  IdWebDAV_ownCLOUD.AllowCookies := True;
  IdWebDAV_ownCLOUD.HandleRedirects := True;
  IdWebDAV_ownCLOUD.Request.ContentType := 'application/x-www-form-urlencoded';

    URL:='https://'+ownCLOUD_address+'/remote.php/webdav'+folder+'/'+stara_nazwa;
    URL := EncodeURI(URL);
    DESTURL:='https://'+ownCLOUD_address+'/remote.php/webdav'+folder+'/'+nowa_nazwa;
    DESTURL := EncodeURI(DESTURL);

  Stream := TMemoryStream.Create;
    try
      IdWebDAV_ownCLOUD.DAVMove(URL,DESTURL,Stream,True);
    finally
      Stream.Free;
    end;

 wynik:='Poprawnie zmieniono nazwê na: '+nowa_nazwa;
 ZmienNazwe:=wynik;
end;

procedure TownCLOUDunit.PrzygotujListePlikow(lista_in : String; widok_listy : TListView; katalog_nadrzedny : TLabel);
Var
 lista : TStringList;
  i: Integer;
  linia: string;
  poz: Integer;
  dana: string;
  ListItem: TListItem;
  nazwa: string;
  rozmiar: string;
  typ: string;
  rozmiarINT: Integer;
  jednostka: string;
  typ_pliku : string;
  czas: string;
Begin
 lista:=TStringList.Create;
 lista.Text:=lista_in;
 widok_listy.Items.BeginUpdate;
 widok_listy.Items.Clear;
 widok_listy.Items.EndUpdate;

 widok_listy.Items.BeginUpdate;
 for i := 0 to lista.Count-1 do
  Begin
   linia:=Trim(lista.Strings[i]);
   if Pos('Katalog nadrzêdny',linia)>0 then
    Begin
     poz:=Pos(':',linia); Delete(linia,1,poz); dana:=Trim(linia);
     katalog_nadrzedny.Caption:=dana;
    End
   else
    Begin
     poz:=Pos(';',linia); typ:=Trim(Copy(linia,1,poz-1)); Delete(linia,1,poz);
     poz:=Pos(';',linia); nazwa:=Trim(Copy(linia,1,poz-1)); Delete(linia,1,poz);
     poz:=Pos(';',linia); rozmiar:=Trim(Copy(linia,1,poz-1)); Delete(linia,1,poz);
     czas:=Trim(linia);
     jednostka:='  B';
     rozmiarINT:=StrToInt(rozmiar);

     if AOknoGl.cbox_jednostka.Text='Auto' then
      Begin
       if rozmiarINT>1024 then
        Begin
         rozmiarINT:=rozmiarINT div 1024;
         jednostka:='KB';
        End;
       if rozmiarINT>1024 then
        Begin
         rozmiarINT:=rozmiarINT div 1024;
         jednostka:='MB';
        End;
       if rozmiarINT>1024 then
        Begin
         rozmiarINT:=rozmiarINT div 1024;
         jednostka:='GB';
        End;
      End
     else
      Begin 
       if AOknoGl.cbox_jednostka.Text='KB' then rozmiarINT:=rozmiarINT div 1024;
       if AOknoGl.cbox_jednostka.Text='MB' then rozmiarINT:=(rozmiarINT div 1024) div 1024;
       if AOknoGl.cbox_jednostka.Text='GB' then rozmiarINT:=((rozmiarINT div 1024) div 1024) div 1024;
       jednostka:=AOknoGl.cbox_jednostka.Text;
      End;

     rozmiar:=IntToStr(rozmiarINT);

     ListItem:=widok_listy.Items.Add;
     ListItem.Caption:=typ;
     if typ='katalog' then ListItem.ImageIndex:=0
     else
      Begin
       ListItem.ImageIndex:=1;
       typ_pliku:=ExtractFileExt(AnsiLowerCase(nazwa));
       if typ_pliku='.pdf' then ListItem.ImageIndex:=2;
       if typ_pliku='.xls' then ListItem.ImageIndex:=3;
       if typ_pliku='.xlsx' then ListItem.ImageIndex:=3;
       if typ_pliku='.doc' then ListItem.ImageIndex:=4;
       if typ_pliku='.docx' then ListItem.ImageIndex:=4;
       if typ_pliku='.odt' then ListItem.ImageIndex:=4;
       if typ_pliku='.bmp' then ListItem.ImageIndex:=5;
       if typ_pliku='.jpg' then ListItem.ImageIndex:=5;
       if typ_pliku='.jpeg' then ListItem.ImageIndex:=5;
       if typ_pliku='.png' then ListItem.ImageIndex:=5;
       if typ_pliku='.gif' then ListItem.ImageIndex:=5;
       if typ_pliku='.zip' then ListItem.ImageIndex:=6;
       if typ_pliku='.rar' then ListItem.ImageIndex:=6;
       if typ_pliku='.7z' then ListItem.ImageIndex:=6;
       if typ_pliku='.exe' then ListItem.ImageIndex:=7;
      End;
     ListItem.SubItems.Add(nazwa);
     ListItem.SubItems.Add(FormatFloat('###,###,##0',StrToFloat(rozmiar))+' '+jednostka);
     ListItem.SubItems.Add(czas);
    End;
  End;

 widok_listy.Items.EndUpdate;
 lista.Free;
End;

function TownCLOUDunit.EncryptStr(const S :WideString; Key: Word): String;
var   i          :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
begin
  Result:= '';
  RStr:= UTF8Encode(S);
  for i := 0 to Length(RStr)-1 do begin
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (RStrB[i] + Key) * CKEY1 + CKEY2;
  end;
  for i := 0 to Length(RStr)-1 do begin
    Result:= Result + IntToHex(RStrB[i], 2);
  end;
end;

function TownCLOUDunit.DecryptStr(const S: String; Key: Word): String;
var   i, tmpKey  :Integer;
      RStr       :RawByteString;
      RStrB      :TBytes Absolute RStr;
      tmpStr     :string;
begin
  tmpStr:= UpperCase(S);
  SetLength(RStr, Length(tmpStr) div 2);
  i:= 1;
  try
    while (i < Length(tmpStr)) do begin
      RStrB[i div 2]:= StrToInt('$' + tmpStr[i] + tmpStr[i+1]);
      Inc(i, 2);
    end;
  except
    Result:= '';
    Exit;
  end;
  for i := 0 to Length(RStr)-1 do begin
    tmpKey:= RStrB[i];
    RStrB[i] := RStrB[i] xor (Key shr 8);
    Key := (tmpKey + Key) * CKEY1 + CKEY2;
  end;
  Result:= UTF8Decode(RStr);
end;

procedure TownCLOUDunit.Zapisz_konfiguracje(plik : String);
Var
 plik_fizyczny : TextFile;
Begin
 AssignFile(plik_fizyczny,plik);
 Rewrite(plik_fizyczny);
  Writeln(plik_fizyczny,'[address]='+ownCLOUD_address);
  Writeln(plik_fizyczny,'[user]='+ownCLOUD_user);
  Writeln(plik_fizyczny,'[password]='+EncryptStr(ownCLOUD_password,2018));
  Writeln(plik_fizyczny,'[theme]='+AOknoGl.cbxVclStyles.Text);
  Writeln(plik_fizyczny,'[menu_closing]='+IntToStr(AoknoGl.grpCloseStyle.ItemIndex));
  Writeln(plik_fizyczny,'[logs]='+BoolToStr(AOknoGl.cbox_logi.Checked));
  Writeln(plik_fizyczny,'[window_border]='+BoolToStr(AOknoGl.cbox_border_style.Checked));
  Writeln(plik_fizyczny,'[tray_setting]='+BoolToStr(AOknoGl.cbox_minimalizacja.Checked));
  Writeln(plik_fizyczny,'[files_size_in]='+AOknoGl.cbox_jednostka.Text);
  Writeln(plik_fizyczny,'[files_auto_open]='+BoolToStr(AOknoGl.cbox_auto_open.Checked));
 CloseFile(plik_fizyczny);
End;

function TownCLOUDunit.EncodeURI(const AURI: string): String;
Var
 wynik : String;
begin
 wynik:=AURI;
  wynik := StringReplace(wynik, ' ', '%20',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'ó', '%C3%B3',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'Ó', '%C3%93',[rfReplaceAll]);
  wynik := StringReplace(wynik, '¹', '%C4%85',[rfReplaceAll]);
  wynik := StringReplace(wynik, '¥', '%C4%84',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'ê', '%C4%99',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'Ê', '%C4%98',[rfReplaceAll]);
  wynik := StringReplace(wynik, '³', '%C5%82',[rfReplaceAll]);
  wynik := StringReplace(wynik, '£', '%C5%81',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'œ', '%C5%9B',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'Œ', '%C5%9A',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'ñ', '%C5%84',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'Ñ', '%C5%83',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'æ', '%C4%87',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'Æ', '%C4%86',[rfReplaceAll]);
  wynik := StringReplace(wynik, 'Ÿ', '%C5%BA',[rfReplaceAll]);
  wynik := StringReplace(wynik, '', '%C5%B9',[rfReplaceAll]);
  wynik := StringReplace(wynik, '¿', '%C5%BC',[rfReplaceAll]);
  wynik := StringReplace(wynik, '¯', '%C5%BB',[rfReplaceAll]);
 EncodeURI:=wynik;
end;

end.
