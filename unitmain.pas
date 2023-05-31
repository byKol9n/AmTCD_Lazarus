unit unitMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  StdCtrls;

type

  { TFormMain }

  TFormMain = class(TForm)
    MainMenu1: TMainMenu;
    Memo1: TMemo;
    Memo2: TMemo;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Separator2: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator1: TMenuItem;
    StatusBar1: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure Separator1Click(Sender: TObject);
  private

  public
       function Code(S:WideString; Key: Integer):WideString;
       function DeCode(S:WideString; Key: Integer):WideString;
  end;

var
  FormMain: TFormMain;
  KeyG: Integer;

implementation

uses unitAbout, IniFiles, LazUTF8, unitParam, StrUtils;

{$R *.lfm}

{ TFormMain }

procedure TFormMain.FormCreate(Sender: TObject);
begin

end;

procedure TFormMain.Memo1Change(Sender: TObject);
begin

end;

procedure TFormMain.MenuItem10Click(Sender: TObject);
begin

end;

procedure TFormMain.MenuItem11Click(Sender: TObject);
begin
  FormParam.ShowModal;
end;

procedure TFormMain.MenuItem12Click(Sender: TObject);
begin
  FormAbout.ShowModal;
end;

procedure TFormMain.MenuItem2Click(Sender: TObject);
var
  FileName:WideString;
  F: LongWord;
begin
  if SaveDialog1.Execute then begin
    FileName:=SaveDialog1.FileName;
    Memo1.Lines.SaveToFile(FileName)
  end;
end;

procedure TFormMain.MenuItem3Click(Sender: TObject);
var
tfile: TStringList;
str, FileNameOpen: string;
Key: Integer;
F: TIniFile;
SS:WideString;
begin
  if OpenDialog1.Execute then begin
  tfile:= TStringList.Create; // создать список строк
  // загрузить текст из файла в список  строк
  FileNameOpen:=OpenDialog1.FileName;
  tfile.LoadFromFile(FileNameOpen);
  str:= tfile.Text;
  F:=TIniFile.Create(FileNameOpen);
  Key:=F.ReadInteger('main','Key', Key);
  SS:=F.ReadString('main','Text', SS);
  str:=DeCode(SS, KeyG);
  // загрузить текст из списка в memo-поле
  FormMain.Memo1.Lines.Add(str);
  tfile.Free;
end;
end;

procedure TFormMain.MenuItem4Click(Sender: TObject);
begin
  Application.terminate;
end;

procedure TFormMain.MenuItem5Click(Sender: TObject);
var
  FileName, S, SS:WideString;
  F: TIniFile;
begin
  if SaveDialog1.Execute then begin
     FileName:=SaveDialog1.FileName;
     Memo1.Lines.SaveToFile(FileName);
     S:=Memo1.Text;
     SS:=Code(S, KeyG);
     F:=TIniFile.Create(FileName);
     F.WriteInteger('main','Key', KeyG);
     F.WriteString('main','Text', SS);
     //Key:=F.ReadInteger();
     //SS:=F.ReadString();
     F.Free;
     //Memo2.Text:=SS;
     //Memo2.Lines.SaveToFile(FileName);
  end;
end;

procedure TFormMain.Separator1Click(Sender: TObject);
begin

end;

function TFormMain.Code(S: WideString; Key: Integer): WideString;
var
  ss:String;
  KeyS:String;
  //ss, S_:WideString;
  //C:WideChar;
  //i,K:Integer;
begin
  KeyS:=IntToStr(Key);
  ss:=XorEncode(KeyS, S);
  //ss:=' ';
  //for i:=1 to Length(S) do begin
    //C:=S[i];
    //K:=Ord(C);
    //K:=K xor Key;
    //S_:=UnicodeToUTF8(K);
    //ss:=ss+S_;
  //end;
  Result:=ss;
end;

function TFormMain.DeCode(S: WideString; Key: Integer): WideString;
var
  ss:String;
  KeyS:String;
begin
 KeyS:=IntToStr(Key);
 ss:=XorDecode(KeyS, S);
 Result:=ss;
end;

end.

