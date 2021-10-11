unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Menus;

const
  // событие трей-иконки
  WM_MYICONNOTIFY = WM_USER + 123;

type
  TfMain = class(TForm)
    InfoText: TRichEdit;
    bOK: TButton;
    TrayMenu: TPopupMenu;
    mAbout: TMenuItem;
    mQuit: TMenuItem;
    procedure mAboutClick(Sender: TObject);
    procedure mQuitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bOKClick(Sender: TObject);
  private
    { Private declarations }
    ShownOnce: Boolean;
  public
    { Public declarations }
    procedure WMICON(var msg: TMessage); message WM_MYICONNOTIFY;
    procedure WMSYSCOMMAND(var msg: TMessage); message WM_SYSCOMMAND;
    procedure AddTrayIcon(id: Integer);
    procedure DeleteTrayIcon(id: Integer);
    procedure RestoreForm();
    procedure HideForm();
  end;

var
  fMain: TfMain;

// переключатель хука клавиатуры
procedure SwitchHook(state: Boolean) stdcall; external 'KeyHook.dll';

implementation

{$R *.dfm}

uses ShellAPI;

// ============= Обработчик событий трей-иконки ===========================
procedure TfMain.WMICON(var msg: TMessage);
var P: TPoint;
begin
  case msg.LParam of
    WM_LBUTTONDOWN,
    WM_RBUTTONDOWN:
    begin
      GetCursorPos(P);
      SetForegroundWindow(Application.MainForm.Handle);
      TrayMenu.Popup(P.X, P.Y);
    end;
    WM_LBUTTONDBLCLK: RestoreForm;
  end;
end;

// ============ Сворачивание в трей по Minimize ==========================
procedure TfMain.WMSYSCOMMAND(var msg: TMessage);
begin
  inherited;
  if msg.WParam = SW_MINIMIZE then HideForm;
end;

// ============= Добавляет иконку в трей ===================================
procedure TfMain.AddTrayIcon(id: Integer);
var NIData: TNotifyIconData;
begin
  NIData.cbSize := SizeOf(TNotifyIconData);
  NIData.Wnd := Self.Handle;
  NIData.uID := id;
  NIData.uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
  NIData.uCallbackMessage := WM_MYICONNOTIFY;
  NIData.hIcon := Application.Icon.Handle;
  StrPCopy(NIData.szTip, Application.Title);
  Shell_NotifyIcon(NIM_ADD, @NIData);
end;

// ============= Убирает иконку из трея ==============================
procedure TfMain.DeleteTrayIcon(id: Integer);
var NIData: TNotifyIconData;
begin
  NIData.cbSize := SizeOf(TNotifyIconData);
  NIData.Wnd := Self.Handle;
  NIData.uID := id;
  Shell_NotifyIcon(NIM_DELETE, @NIData);
end;

// ================ Разворачивает окно ==============================
procedure TfMain.RestoreForm;
var
  i: Integer;
begin
  Application.ShowMainForm := True;
  ShowWindow(Application.Handle, SW_RESTORE);
  ShowWindow(Application.MainForm.Handle, SW_RESTORE);
  mAbout.Enabled := False;

  // если форма еще ни разу не разворачивалась, нужно сделать все компоненты
  // видимыми вручную, т.к. приложение создаётся с флагом  ShowMainForm = False
  if not ShownOnce then
  begin
    for i := 0 to Application.MainForm.ComponentCount - 1 do
      if Application.MainForm.Components[i] is TWinControl then
        with Application.MainForm.Components[i] as TWinControl do
          if Visible then ShowWindow(Handle, SW_SHOWDEFAULT);
    ShownOnce := true;
  end;
end;

// ================ Прячет окно =====================================
procedure TfMain.HideForm;
begin
  Application.ShowMainForm := False;
  ShowWindow(Application.Handle, SW_HIDE);
  ShowWindow(Application.MainForm.Handle, SW_HIDE);
  mAbout.Enabled := True;
end;

// ******************************* UI ******************************** //

procedure TfMain.FormCreate(Sender: TObject);
begin
  ShownOnce := False;
  AddTrayIcon(1);
  SwitchHook(True);
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  DeleteTrayIcon(1);
  SwitchHook(False);
end;

procedure TfMain.mAboutClick(Sender: TObject);
begin
  RestoreForm;
  DeleteTrayIcon(1);
end;

procedure TfMain.bOKClick(Sender: TObject);
begin
  HideForm;
  AddTrayIcon(1);
end;

procedure TfMain.mQuitClick(Sender: TObject);
begin
  Close;
end;

end.
