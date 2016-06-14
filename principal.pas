unit Principal;

{$mode objfpc}{$H+}

interface

uses
 Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
 Buttons, StdCtrls;

type

 { TFormPrincipal }

 TFormPrincipal = class(TForm)
  BitBtn1 : TBitBtn;
  BitBtn2 : TBitBtn;
  BitBtn3 : TBitBtn;
  BitBtn4 : TBitBtn;
  BitBtn5 : TBitBtn;
  ImageRural : TImage;
  PanelBotoes : TPanel;
  PanelSuperior : TPanel;
  PanelInferior : TPanel;
  procedure BitBtn1Click(Sender : TObject);
  procedure FormResize(Sender : TObject);
  function Formata(Numero:real;casas:integer) : string;
 private
  { private declarations }
 public
  { public declarations }
 end;

var
 FormPrincipal : TFormPrincipal;

implementation

uses udiagnostico;

{$R *.lfm}

{ TFormPrincipal }

(*******************************************************************************)
(*                    Formata Numeros Reais com vĂ­rgula                        *)
(*******************************************************************************)
function TFormPrincipal.Formata(Numero:real;casas:integer) : string;
var
 i : integer;
 n : integer;
 Inteira : integer;
 Fracionaria : integer;
 Multiplicador : integer;
 Texto : string;

begin
 if casas = 0 then
 begin
  Inteira:= Trunc(Numero);
  Result:= IntToStr(Inteira);
 end
 else
 begin
  Multiplicador:= 1;
  for i:= 1 to casas do
  begin
   Multiplicador:= Multiplicador*10;
  end;
  Inteira:= Trunc(Numero);
  Fracionaria:= Trunc(Abs((Numero-Inteira)*Multiplicador)+0.5);
  if Fracionaria >= Multiplicador then
  begin
   Inteira:= Inteira + 1;
   Fracionaria:= 0;
  end;
  Texto:= IntToStr(Fracionaria);
  n:= Length(Texto);
  if n < casas then
  begin
   for i:= 1 to casas - n do
   begin
    Texto:= '0'+Texto;
   end;
  end;
  Result:= IntToStr(Inteira)+','+Texto;
 end;
end;

procedure TFormPrincipal.FormResize(Sender : TObject);
begin
 ImageRural.Left:=  (PanelBotoes.Width div 2) +(FormPrincipal.Width - ImageRural.Width) div 2;
 ImageRural.Top:=  (FormPrincipal.Height - ImageRural.Height) div 2;
end;

procedure TFormPrincipal.BitBtn1Click(Sender : TObject);
begin
 FormDiagnostico.ShowModal;
end;

end.

