library KeyHook;

uses Windows, Messages, Dialogs, Graphics, SysUtils, ClipBrd, Jpeg, Registry;

var
  SysHook: HHook = 0;
  Wnd: Hwnd = 0;

// ======================= UTILS =========================================

// возвращает путь к системной папке
function GetSystemPath(folder: String): String;
var reg: TRegIniFile;
begin
  reg := TRegIniFile.Create;
  reg.RootKey := HKEY_CURRENT_USER;
  reg.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Explorer\');
  Result := reg.ReadString('Shell folders', folder, '');
  reg.CloseKey;
  reg.Free;
end;

procedure SnapShoot();
var
  BufBmp: TBitmap;
  BufJpg: TJPEGImage;
  DesktopPath: String;
  Counter: Integer;
begin
  // проверяем, есть ли в буфере обмена картинка
  if Clipboard.HasFormat(CF_BITMAP) then
  begin
    // создаем объекты bmp и jpg
    BufBmp := TBitmap.Create;
    BufJpg := TJPEGImage.Create;
    // берём битмапку из буфера обмена
    BufBmp.LoadFromClipboardFormat(CF_BITMAP, Clipboard.GetAsHandle(CF_BITMAP), 0);
    // bmp -> jpg
    BufJpg.Assign(BufBmp);

    // сохраняем jpg
    Counter := 0;
    DesktopPath := GetSystemPath('Desktop');
    while FileExists(DesktopPath + '\Clipboard' + IntToStr(Counter) + '.jpg') do
      Inc(Counter);
    BufJpg.SaveToFile(DesktopPath + '\Clipboard' + IntToStr(Counter) + '.jpg');
  end
  else ShowMessage('EPIC FAIL');
end;

// ======================== HOOKS ========================================

function KeyboardHook(code: Integer; wParam: Word;
  lParam: Longint): Longint; stdcall;
begin
  if (code = HC_ACTION) and (wParam = VK_SNAPSHOT) then
  begin
    SnapShoot;
    Result := 0;
  end
  else
    Result := CallNextHookEx(SysHook, code, wParam, lParam);
end;

procedure SwitchHook(State: Boolean) export; stdcall;
begin
  if State = True then
    SysHook := SetWindowsHookEx(WH_KEYBOARD, @KeyboardHook, HInstance, 0)
  else
  begin
    UnhookWindowsHookEx(SysHook);
    SysHook := 0;
  end;
end;

exports SwitchHook;

begin

end.
