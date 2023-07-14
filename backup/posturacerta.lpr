program posturacerta;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, SysUtils, Windows,// this includes the LCL widgetset
  Forms, uPrincipal, uAviso
  { you can add units after this };

{$R *.res}

var
  MutexHandle: THandle;
  hwind:HWND;
begin
  MutexHandle := CreateMutex(nil, TRUE, 'PosturaCertaAppMutex');
  if MutexHandle <> 0 then
  begin
    if GetLastError = ERROR_ALREADY_EXISTS then
    begin
      MessageBox(0, 'Este programa já está em execução!','', mb_IconHand);
      Application.Terminate;
      CloseHandle(MutexHandle);
      hwind:=0;
      repeat
        hwind:=Windows.FindWindowEx(0,hwind,'TApplication','Postura Certa');
      until (hwind<>Application.Handle);
      if (hwind<>0) then
      begin
        Windows.ShowWindow(hwind,SW_SHOWNORMAL);
        Windows.SetForegroundWindow(hwind);
      end;
      Halt;
    end
  end;
    //RequireDerivedFormResource:=True;
    Application.Title:='Postura Certa';
    //Application.Scaled:=True;
    Application.Initialize;
    Application.CreateForm(TForm1, Form1);
    Application.CreateForm(TForm2, Form2);
    Application.Run;
end.

//begin
//  RequireDerivedFormResource:=True;
//  Application.Title:='Postura Certa';
//  Application.Scaled:=True;
//  Application.Initialize;
//  Application.CreateForm(TForm1, Form1);
//  Application.CreateForm(TForm2, Form2);
//  Application.Run;
//end.

