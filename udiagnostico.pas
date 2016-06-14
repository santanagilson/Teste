unit udiagnostico;

{$mode objfpc}{$H+}

interface

uses
 Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
 Grids, StdCtrls, ExtCtrls, LCLType, ComCtrls;

type

 { TFormDiagnostico }

 TFormDiagnostico = class(TForm)
  BitBtn1 : TBitBtn;
  Label1 : TLabel;
  Label2 : TLabel;
  Label3 : TLabel;
  Label4 : TLabel;
  Label5 : TLabel;
  LBLDiagnostico : TLabel;
  PageControl1 : TPageControl;
  PageControl2 : TPageControl;
  Panel1 : TPanel;
  PanelDiagnostico : TPanel;
  PanelGrau : TPanel;
  PanelImportancia : TPanel;
  PanelInterno : TPanel;
  PanelInterno1 : TPanel;
  SGForcas : TStringGrid;
  SGFraquezas : TStringGrid;
  StaticText3 : TStaticText;
  StaticText4 : TStaticText;
  STGrau1 : TStaticText;
  STGrau2 : TStaticText;
  STGrau3 : TStaticText;
  STGrau4 : TStaticText;
  STGrau5 : TStaticText;
  STImportancia1 : TStaticText;
  STImportancia2 : TStaticText;
  STImportancia3 : TStaticText;
  STTotalForacas : TStaticText;
  STTotalFraquezas : TStaticText;
  TabSheet1 : TTabSheet;
  TabSheet2 : TTabSheet;
  TabSheet3 : TTabSheet;
  TabSheet4 : TTabSheet;
  procedure BitBtn1Click(Sender : TObject);
  procedure FormActivate(Sender : TObject);
  procedure FormCreate(Sender : TObject);
  procedure SGForcasClick(Sender : TObject);
  procedure SGForcasDrawCell(Sender : TObject; aCol, aRow : Integer;
   aRect : TRect; aState : TGridDrawState);
  procedure SGForcasKeyPress(Sender : TObject; var Key : char);
  procedure SGForcasSelectCell(Sender : TObject; aCol, aRow : Integer;
   var CanSelect : Boolean);
  procedure SGForcasUTF8KeyPress(Sender : TObject; var UTF8Key : TUTF8Char);
  procedure SGFraquezasClick(Sender : TObject);
  procedure SGFraquezasDrawCell(Sender : TObject; aCol, aRow : Integer;
   aRect : TRect; aState : TGridDrawState);
  procedure STGrau4Click(Sender : TObject);
  procedure STGrau5Click(Sender : TObject);
  procedure STGrau3Click(Sender : TObject);
  procedure STGrau2Click(Sender : TObject);
  procedure STGrau1Click(Sender : TObject);
  procedure STImportancia1Click(Sender : TObject);
  procedure STImportancia2Click(Sender : TObject);
  procedure STImportancia3Click(Sender : TObject);
  procedure CalculaNota(Linha : integer);
 private
  { private declarations }
 public
  { public declarations }
 end;

var
 FormDiagnostico : TFormDiagnostico;
 CorGrauForcas, CorImportForcas : array[1..200] of TColor;
 TextoGrauForcas, TextoImportForcas : array[1..200] of string;
 NotaGrauForcas, NotaImportForcas  : array[1..200] of real;

 CorGrauFraquezas, CorImportFraquezas : array[1..200] of TColor;
 TextoGrauFraquezas, TextoImportFraquezas : array[1..200] of string;
 NotaGrauFraquezas, NotaImportFraquezas  : array[1..200] of real;


implementation

uses Principal;

{$R *.lfm}

{ TFormDiagnostico }

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.FormActivate(Sender : TObject);
begin
 FormDiagnostico.Left:= FormPrincipal.PanelBotoes.Width + 10;
 FormDiagnostico.Top:= FormPrincipal.PanelSuperior.Height + 30;
 FormDiagnostico.Width:= FormPrincipal.Width - FormPrincipal.PanelBotoes.Width - 30;
 FormDiagnostico.Height:= FormPrincipal.Height - FormPrincipal.PanelSuperior.Height - FormPrincipal.PanelInferior.Height - 50;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.BitBtn1Click(Sender : TObject);
begin
 Close;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.FormCreate(Sender : TObject);
var i : integer;
begin
 for i:= 1 to SGForcas.RowCount - 1 do
 begin
   CorGrauForcas[i]:= clWhite;
   CorImportForcas[i]:= clWhite;
   NotaGrauForcas[i]:= 0;
   NotaImportForcas[i]:= 0;
   CorGrauFraquezas[i]:= clWhite;
   CorImportFraquezas[i]:= clWhite;
   NotaGrauFraquezas[i]:= 0;
   NotaImportFraquezas[i]:= 0;
 end;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.SGForcasClick(Sender : TObject);
begin
 if SGForcas.Row < 13 then
 begin
  PanelGrau.Top:= SGForcas.Top + 22*SGForcas.Row;
  PanelImportancia.Top:= SGForcas.Top + 22*SGForcas.Row;
 end;
 if SGForcas.Row > 12 then
 begin
  PanelGrau.Top:= SGForcas.Top + 22*12;
  PanelImportancia.Top:= SGForcas.Top + 22*12;
 end;
 if SGForcas.Col = 2 then
   PanelGrau.Visible:= True
  else
   PanelGrau.Visible:= False;
 if SGForcas.Col = 3 then
   PanelImportancia.Visible:= True
  else
   PanelImportancia.Visible:= False;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.SGForcasDrawCell(Sender : TObject; aCol,
 aRow : Integer; aRect : TRect; aState : TGridDrawState);
var i : integer;
begin

 for i:= 1 to SGForcas.RowCount - 1 do
 begin
   if (Acol = 2) and (Arow = i) then
   begin
    SGForcas.Canvas.Brush.Color:= CorGrauForcas[i];
    SGForcas.Canvas.FillRect(aRect);
    SGForcas.Canvas.Pen.Color:= clBlack;
    SGForcas.Canvas.TextOut(aRect.Left+3,aRect.Top+2,TextoGrauForcas[Arow]);
   end;
   if (Acol = 3) and (Arow = i) then
   begin
    SGForcas.Canvas.Brush.Color:= CorImportForcas[i];
    SGForcas.Canvas.FillRect(aRect);
    SGForcas.Canvas.Pen.Color:= clBlack;
    SGForcas.Canvas.TextOut(aRect.Left+3,aRect.Top+2,TextoImportForcas[Arow]);
   end;
(*
   if (Acol = 1) and (Arow = i) then
   begin
    SGForcas.Canvas.Brush.Color:= CorLinha[i];
    SGForcas.Canvas.FillRect(aRect);
   end;
*)
 end;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.SGForcasKeyPress(Sender : TObject; var Key : char);
begin
 if Key = #13 then
 begin
   if SGForcas.Col = 2 then
   begin
    if SGForcas.Row < SGForcas.RowCount then
    begin
     SGForcas.Row:= SGForcas.Row + 1;
     SGForcas.Col:= 1;
    end;
   end
   else
    SGForcas.Col:= 2;
 end;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.SGForcasSelectCell(Sender : TObject; aCol,
 aRow : Integer; var CanSelect : Boolean);
begin

end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.SGForcasUTF8KeyPress(Sender : TObject;
 var UTF8Key : TUTF8Char);
begin
 if UTF8Key = #13 then
 begin
   if SGForcas.Col = 2 then
   begin
    if SGForcas.Row < SGForcas.RowCount then
    begin
     SGForcas.Row:= SGForcas.Row + 1;
     SGForcas.Col:= 1;
    end;
   end
   else
    SGForcas.Col:= 2;
 end;
end;

procedure TFormDiagnostico.SGFraquezasClick(Sender : TObject);
begin
  if SGFraquezas.Row < 13 then
 begin
  PanelGrau.Top:= SGForcas.Top + 22*SGFraquezas.Row;
  PanelImportancia.Top:= SGFraquezas.Top + 22*SGFraquezas.Row;
 end;
 if SGFraquezas.Row > 12 then
 begin
  PanelGrau.Top:= SGFraquezas.Top + 22*12;
  PanelImportancia.Top:= SGFraquezas.Top + 22*12;
 end;
 if SGFraquezas.Col = 2 then
   PanelGrau.Visible:= True
  else
   PanelGrau.Visible:= False;
 if SGFraquezas.Col = 3 then
   PanelImportancia.Visible:= True
  else
   PanelImportancia.Visible:= False;
end;

procedure TFormDiagnostico.SGFraquezasDrawCell(Sender : TObject; aCol,
 aRow : Integer; aRect : TRect; aState : TGridDrawState);
var i : integer;
begin
 for i:= 1 to SGFraquezas.RowCount - 1 do
 begin
   if (Acol = 2) and (Arow = i) then
   begin
    SGFraquezas.Canvas.Brush.Color:= CorGrauFraquezas[i];
    SGFraquezas.Canvas.FillRect(aRect);
    SGFraquezas.Canvas.Pen.Color:= clBlack;
    SGFraquezas.Canvas.TextOut(aRect.Left+3,aRect.Top+2,TextoGrauFraquezas[Arow]);
   end;
   if (Acol = 3) and (Arow = i) then
   begin
    SGFraquezas.Canvas.Brush.Color:= CorImportFraquezas[i];
    SGFraquezas.Canvas.FillRect(aRect);
    SGFraquezas.Canvas.Pen.Color:= clBlack;
    SGFraquezas.Canvas.TextOut(aRect.Left+3,aRect.Top+2,TextoImportFraquezas[Arow]);
   end;
 end;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.STGrau4Click(Sender : TObject);
begin
 if ActiveControl = SGForcas then
 begin
  CorGrauForcas[SGForcas.Row]:= STGrau4.Color;
  TextoGrauForcas[SGForcas.Row]:= STGrau4.Caption;
  NotaGrauForcas[SGForcas.Row]:= 4;
  CalculaNota(SGForcas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGForcas;
  SGForcas.Col:= 1;
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  CorGrauFraquezas[SGFraquezas.Row]:= STGrau4.Color;
  TextoGrauFraquezas[SGFraquezas.Row]:= STGrau4.Caption;
  PanelGrau.Visible:= False;
  NotaGrauFraquezas[SGFraquezas.Row]:= 4;
  CalculaNota(SGFraquezas.Row);
  ActiveControl:= SGFraquezas;
  SGFraquezas.Col:= 1;
 end
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.STGrau5Click(Sender : TObject);
begin
 if ActiveControl = SGForcas then
 begin
  CorGrauForcas[SGForcas.Row]:= STGrau5.Color;
  TextoGrauForcas[SGForcas.Row]:= STGrau5.Caption;
  NotaGrauForcas[SGForcas.Row]:= 5;
  CalculaNota(SGForcas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGForcas;
  SGForcas.Col:= 1;
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  CorGrauFraquezas[SGFraquezas.Row]:= STGrau5.Color;
  TextoGrauFraquezas[SGFraquezas.Row]:= STGrau5.Caption;
  PanelGrau.Visible:= False;
  NotaGrauFraquezas[SGFraquezas.Row]:= 5;
  CalculaNota(SGFraquezas.Row);
  ActiveControl:= SGFraquezas;
  SGFraquezas.Col:= 1;
 end
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.STGrau2Click(Sender : TObject);
begin
 if ActiveControl = SGForcas then
 begin
  CorGrauForcas[SGForcas.Row]:= STGrau2.Color;
  TextoGrauForcas[SGForcas.Row]:= STGrau2.Caption;
  NotaGrauForcas[SGForcas.Row]:= 2;
  CalculaNota(SGForcas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGForcas;
  SGForcas.Col:= 1;
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  CorGrauFraquezas[SGFraquezas.Row]:= STGrau1.Color;
  TextoGrauFraquezas[SGFraquezas.Row]:= STGrau1.Caption;
  PanelGrau.Visible:= False;
  NotaGrauFraquezas[SGFraquezas.Row]:= 2;
  CalculaNota(SGFraquezas.Row);
  ActiveControl:= SGFraquezas;
  SGFraquezas.Col:= 1;
 end
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.STGrau3Click(Sender : TObject);
begin
 if ActiveControl = SGForcas then
 begin
  CorGrauForcas[SGForcas.Row]:= STGrau3.Color;
  TextoGrauForcas[SGForcas.Row]:= STGrau3.Caption;
  NotaGrauForcas[SGForcas.Row]:= 3;
  CalculaNota(SGForcas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGForcas;
  SGForcas.Col:= 1;
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  CorGrauFraquezas[SGFraquezas.Row]:= STGrau3.Color;
  TextoGrauFraquezas[SGFraquezas.Row]:= STGrau3.Caption;
  PanelGrau.Visible:= False;
  NotaGrauFraquezas[SGFraquezas.Row]:= 3;
  CalculaNota(SGFraquezas.Row);
  ActiveControl:= SGFraquezas;
  SGFraquezas.Col:= 1;
 end
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.CalculaNota(Linha : integer);
var Nota,TotalForcas, TotalFraquezas : real;
    i : integer;
begin
 if ActiveControl = SGForcas then
 begin
  Nota:= NotaGrauForcas[Linha]*NotaImportForcas[Linha];
  SGForcas.Cells[4,Linha]:= FormPrincipal.Formata(Nota,2);
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  Nota:= NotaGrauFraquezas[Linha]*NotaImportFraquezas[Linha];
  SGFraquezas.Cells[4,Linha]:= FormPrincipal.Formata(Nota,2);
 end;
 TotalForcas:= 0;
 TotalFraquezas:= 0;
 for i:= 1 to SGForcas.RowCount -1 do
 begin
   TotalForcas:= TotalForcas + NotaGrauForcas[i]*NotaImportForcas[i];
   TotalFraquezas:= TotalFraquezas + NotaGrauFraquezas[i]*NotaImportFraquezas[i];
 end;
 STTotalForacas.Caption:= FormPrincipal.Formata(TotalForcas,2);
 STTotalFraquezas.Caption:= FormPrincipal.Formata(TotalFraquezas,2);
 if TotalForcas > TotalFraquezas then
 begin

 end;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.STGrau1Click(Sender : TObject);

begin
 if ActiveControl = SGForcas then
 begin
  CorGrauForcas[SGForcas.Row]:= STGrau1.Color;
  TextoGrauForcas[SGForcas.Row]:= STGrau1.Caption;
  PanelGrau.Visible:= False;
  NotaGrauForcas[SGForcas.Row]:= 0;
  CalculaNota(SGForcas.Row);
  ActiveControl:= SGForcas;
  SGForcas.Col:= 1;
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  CorGrauFraquezas[SGFraquezas.Row]:= STGrau1.Color;
  TextoGrauFraquezas[SGFraquezas.Row]:= STGrau1.Caption;
  PanelGrau.Visible:= False;
  NotaGrauFraquezas[SGFraquezas.Row]:= 0;
  CalculaNota(SGFraquezas.Row);
  ActiveControl:= SGFraquezas;
  SGFraquezas.Col:= 1;
 end
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.STImportancia1Click(Sender : TObject);
begin
 if ActiveControl = SGForcas then
 begin
  CorImportForcas[SGForcas.Row]:= STImportancia1.Color;
  TextoImportForcas[SGForcas.Row]:= STImportancia1.Caption;
  NotaImportForcas[SGForcas.Row]:= 1;
  CalculaNota(SGForcas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGForcas;
  SGForcas.Col:= 1;
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  CorImportFraquezas[SGFraquezas.Row]:= STImportancia1.Color;
  TextoImportFraquezas[SGFraquezas.Row]:= STImportancia1.Caption;
  NotaImportFraquezas[SGFraquezas.Row]:= 1;
  CalculaNota(SGFraquezas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGFraquezas;
  SGFraquezas.Col:= 1;
 end;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.STImportancia2Click(Sender : TObject);
begin
 if ActiveControl = SGForcas then
 begin
  CorImportForcas[SGForcas.Row]:= STImportancia2.Color;
  TextoImportForcas[SGForcas.Row]:= STImportancia2.Caption;
  NotaImportForcas[SGForcas.Row]:= 1.5;
  CalculaNota(SGForcas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGForcas;
  SGForcas.Col:= 1;
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  CorImportFraquezas[SGFraquezas.Row]:= STImportancia2.Color;
  TextoImportFraquezas[SGFraquezas.Row]:= STImportancia2.Caption;
  NotaImportFraquezas[SGFraquezas.Row]:= 1.5;
  CalculaNota(SGFraquezas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGFraquezas;
  SGFraquezas.Col:= 1;
 end;
end;

(*******************************************************************************)
(*                                                                             *)
(*******************************************************************************)
procedure TFormDiagnostico.STImportancia3Click(Sender : TObject);
begin
 if ActiveControl = SGForcas then
 begin
  CorImportForcas[SGForcas.Row]:= STImportancia3.Color;
  TextoImportForcas[SGForcas.Row]:= STImportancia3.Caption;
  NotaImportForcas[SGForcas.Row]:= 2;
  CalculaNota(SGForcas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGForcas;
  SGForcas.Col:= 1;
 end
 else
 if ActiveControl = SGFraquezas then
 begin
  CorImportFraquezas[SGFraquezas.Row]:= STImportancia3.Color;
  TextoImportFraquezas[SGFraquezas.Row]:= STImportancia3.Caption;
  NotaImportFraquezas[SGFraquezas.Row]:= 2;
  CalculaNota(SGFraquezas.Row);
  PanelGrau.Visible:= False;
  ActiveControl:= SGFraquezas;
  SGFraquezas.Col:= 1;
 end;
end;

end.

