unit uPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, Menus, uAviso, IniFiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnTempoSalvar: TButton;
    Label2: TLabel;
    Label3: TLabel;
    labelV: TLabel;
    MenuItem1: TMenuItem;
    PopupMenu1: TPopupMenu;
    txtTempo: TEdit;
    Label1: TLabel;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    procedure btnTempoSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     TrayIcon1.ShowBalloonHint();
     Form2.Show;
     labelV.Caption:= TimeToStr(now);
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   Form1.Hide;
   Abort;
end;

procedure TForm1.btnTempoSalvarClick(Sender: TObject);
  var PosturaINI : TIniFile;
  var minuto : String;
  var calculo: Integer;
begin
  PosturaINI := TIniFile.Create('./config.ini');
  minuto:= txtTempo.Text;
  calculo := StrToInt(minuto)*60000;
  PosturaINI.WriteString('Config', 'Time', IntToStr(calculo));
  Timer1.Interval := calculo;

end;

procedure TForm1.FormCreate(Sender: TObject);
  var PosturaINI : TIniFile;
  var minuto : Integer;
  var calculo: double;
begin
  PosturaINI := TIniFile.Create('./config.ini');
  minuto:= StrToInt(PosturaINI.ReadString('Config', 'Time', ''));
  calculo := minuto/60000;
  //txtTempo.Text := PosturaINI.ReadString('Config', 'Time', '');
  txtTempo.Text := FloatToStr(calculo);
  Timer1.Interval:= StrToInt(PosturaINI.ReadString('Config', 'Time', ''));
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  Form1.Visible:=True;
end;

end.

