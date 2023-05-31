unit unitParam;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, unitMain,
  IniFiles;

type

  { TFormParam }

  TFormParam = class(TForm)
    BtSetKey: TButton;
    BtSaveKey: TButton;
    CheckBox1: TCheckBox;
    EditKey: TEdit;
    LabelKey: TLabel;
    SaveDialog1: TSaveDialog;
    procedure BtSaveKeyClick(Sender: TObject);
    procedure BtSetKeyClick(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormParam: TFormParam;

implementation

{$R *.lfm}

{ TFormParam }

procedure TFormParam.FormCreate(Sender: TObject);

begin

end;

procedure TFormParam.BtSetKeyClick(Sender: TObject);
begin
  unitMain.KeyG:= StrToInt(EditKey.Text);
  ShowMessage('Ключ установлен');
end;

procedure TFormParam.CheckBox1Change(Sender: TObject);
begin
  if CheckBox1.State = cbChecked then
     EditKey.PasswordChar:=#0
  else
     EditKey.PasswordChar:='*';
end;

procedure TFormParam.BtSaveKeyClick(Sender: TObject);
var
  key: Integer;
  FileName:WideString;
  F: TIniFile;
begin
  if SaveDialog1.Execute then begin
    FileName:=SaveDialog1.FileName;
    key:=StrToInt(EditKey.Text);
    F:=TIniFile.Create(FileName);
    F.WriteInteger('main','Key', key);
    F.Free;
  end;
end;

end.

