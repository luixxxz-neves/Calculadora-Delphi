unit FormCalculadora;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, StrUtils, Math;

type
  TCalculadora = class(TForm)
    GBGeral: TGroupBox;
    MemoTerminal: TMemo;
    Porcentagem: TPanel;
    BackSpace: TPanel;
    Clear: TPanel;
    ClearUltimoNumero: TPanel;
    Fracao: TPanel;
    Divisao: TPanel;
    RaizQuadrada: TPanel;
    ElevaADois: TPanel;
    Sete: TPanel;
    Multiplicacao: TPanel;
    Nove: TPanel;
    Oito: TPanel;
    Quatro: TPanel;
    Subtracao: TPanel;
    Seis: TPanel;
    Cinco: TPanel;
    Um: TPanel;
    Adicao: TPanel;
    Tres: TPanel;
    Dois: TPanel;
    InverterSinal: TPanel;
    Resultado: TPanel;
    Virgula: TPanel;
    Zero: TPanel;
    header: TShape;
    Close: TLabel;
    Minimize: TLabel;
    Titulo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure MinimizeClick(Sender: TObject);
    procedure MinimizeMouseEnter(Sender: TObject);
    procedure MinimizeMouseLeave(Sender: TObject);
    procedure CloseMouseEnter(Sender: TObject);
    procedure CloseMouseLeave(Sender: TObject);
    procedure headerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClearClick(Sender: TObject);
    procedure ResultadoClick(Sender: TObject);
    procedure MemoTerminalKeyPress(Sender: TObject; var Key: Char);
    procedure BackSpaceClick(Sender: TObject);
    procedure ClearUltimoNumeroClick(Sender: TObject);
    procedure ElevaADoisClick(Sender: TObject);
    procedure RaizQuadradaClick(Sender: TObject);
    procedure FracaoClick(Sender: TObject);
    procedure PorcentagemClick(Sender: TObject);
  private
    { Private declarations }
    num, num2 : String;
    Resultados : Double;
    Procedure panelClickGenerico(Sender : TObject);
    Procedure LimpaCache;
  public
    { Public declarations }
  end;

var
  Calculadora: TCalculadora;

implementation

{$R *.dfm}

procedure TCalculadora.CloseMouseEnter(Sender: TObject);
begin
   Close.Color := clMaroon;
end;

procedure TCalculadora.CloseMouseLeave(Sender: TObject);
begin
   Close.Color := clRed;
end;

procedure TCalculadora.ElevaADoisClick(Sender: TObject);
begin
   Num := MemoTerminal.Text;
   Num := FloatToStr(Sqr(StrToFloat(num)));
   MemoTerminal.Text := num;
   LimpaCache;
end;

procedure TCalculadora.FormCreate(Sender: TObject);
var
   i : integer;
begin
   for I := 0 to pred(GBGeral.ControlCount) do
   begin
      if GBGeral.Controls[i] is TPanel then
      begin
         Tpanel(GBGeral.Controls[i]).OnClick := panelClickGenerico;
      end;
   end;
end;

procedure TCalculadora.FracaoClick(Sender: TObject);
begin
   Num := MemoTerminal.Text;
   Num := FloatToStr(1 / StrToFloat(Num));
   MemoTerminal.Text := Num;
   LimpaCache;
end;

procedure TCalculadora.BackSpaceClick(Sender: TObject);
begin
   MemoTerminal.SelStart := MemoTerminal.GetTextLen-1;
   MemoTerminal.SelLength := 1;
   MemoTerminal.SelText := '';
end;

procedure TCalculadora.ClearClick(Sender: TObject);
begin
   MemoTerminal.Clear;
   LimpaCache
end;

procedure TCalculadora.ClearUltimoNumeroClick(Sender: TObject);
var
   I : integer;
   Texto : String;
begin
   Texto := MemoTerminal.Text;

   for I := Length(text) Downto 1 do
   begin
      if Texto[i] in ['0' .. '9', ','] then
         Delete(Texto, I, 1)
      else
      begin
         if Length(Texto) < Length(MemoTerminal.Text) then
            Break;
      end;
   end;
   MemoTerminal.text := Texto;
   MemoTerminal.SelStart := Length(MemoTerminal.Text);
   LimpaCache
end;

procedure TCalculadora.CloseClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TCalculadora.MemoTerminalKeyPress(Sender: TObject; var Key: Char);
begin
   Key := #0;
end;

procedure TCalculadora.MinimizeClick(Sender: TObject);
begin
   Application.Minimize;
end;

procedure TCalculadora.MinimizeMouseEnter(Sender: TObject);
begin
   Minimize.Color := clHotLight;
end;

procedure TCalculadora.MinimizeMouseLeave(Sender: TObject);
begin
   Minimize.Color := clActiveCaption;
end;

procedure TCalculadora.panelClickGenerico(Sender: TObject);
var
   panelAtual : TPanel;
begin
   if Sender is TPanel then
   begin
      panelAtual := TPanel(Sender);

      panelAtual.BevelInner := BvNone;
      panelAtual.BevelKind := BkNone;
      panelAtual.Repaint;
      Sleep(150);
      panelAtual.BevelInner := BvRaised;
      panelAtual.BevelKind := BkSoft;

      if panelAtual.Name = 'Clear' then
         ClearClick(Sender);

      if panelAtual.Name = 'BackSpace' then
         BackSpaceClick(Sender);

      if panelAtual.Name = 'ClearUltimoNumero' then
         ClearUltimoNumeroClick(Sender);

      if panelAtual.Name = 'ElevaADois' then
         ElevaADoisClick(Sender);

      if panelAtual.Name = 'RaizQuadrada' then
         RaizQuadradaClick(Sender);

      if panelAtual.Name = 'Fracao' then
         FracaoClick(Sender);

      if panelAtual.Name = 'Porcentagem' then
         PorcentagemClick(Sender);

      if MemoTerminal.Text <> '' then
         if panelAtual.Name = 'Resultado' then
            ResultadoClick(Sender);

      if not MatchStr(panelAtual.Name, ['Clear', 'ClearUltimoNumero', 'BackSpace',
      'RaizQuadrada','ElevaADois', 'Fracao', 'InverterSinal', 'Resultado', 'Porcentagem'])
      then
      begin
         MemoTerminal.Text := MemoTerminal.Text + panelAtual.Caption;
      end;
   end;
end;

procedure TCalculadora.PorcentagemClick(Sender: TObject);
begin
   Num := MemoTerminal.Text;
   Num := FloatToStr(StrToFloat(Num) / 100);
   MemoTerminal.Text := Num;
   LimpaCache;
end;

procedure TCalculadora.RaizQuadradaClick(Sender: TObject);
begin
   Num := MemoTerminal.Text;
   Num := FloatToStr(Sqrt(StrToFloat(num)));
   MemoTerminal.Text := num;
   LimpaCache;
end;

procedure TCalculadora.ResultadoClick(Sender: TObject);
var
   Texto: string;
   I: Integer;
   Caractere: Char;
   NumeroAtualStr: string;

   PilhaNumeros: array of Double;
   PilhaOperadores: array of Char;

   procedure PushNumero(V: Double);
   begin
      SetLength(PilhaNumeros, Length(PilhaNumeros) + 1);
      PilhaNumeros[High(PilhaNumeros)] := V;
   end;

   function PopNumero: Double;
   begin
      Result := PilhaNumeros[High(PilhaNumeros)];
      SetLength(PilhaNumeros, Length(PilhaNumeros) - 1);
   end;

   procedure PushOperador(O: Char);
   begin
      SetLength(PilhaOperadores, Length(PilhaOperadores) + 1);
      PilhaOperadores[High(PilhaOperadores)] := O;
   end;

   function PopOperador: Char;
   begin
      Result := PilhaOperadores[High(PilhaOperadores)];
      SetLength(PilhaOperadores, Length(PilhaOperadores) - 1);
   end;

   function ObterPrecedencia(Op: Char): Integer;
   begin
      if (Op = '+') or (Op = '-') then Result := 1
      else if (Op = 'X') or (Op = '÷') then Result := 2
      else Result := 0;
   end;

   procedure ExecutarOperacaoTopo;
   var
      NumDireita, NumEsquerda: Double;
      Op: Char;
      SubTotal: Double;
   begin
      if (Length(PilhaNumeros) < 2) or (Length(PilhaOperadores) < 1) then Exit;

      NumDireita := PopNumero;
      NumEsquerda := PopNumero;
      Op := PopOperador;
      SubTotal := 0;

   case Op of
      '+': SubTotal := NumEsquerda + NumDireita;
      '-': SubTotal := NumEsquerda - NumDireita;
      'X': SubTotal := NumEsquerda * NumDireita;
      '÷': if NumDireita <> 0 then SubTotal := NumEsquerda / NumDireita;
   end;
      PushNumero(SubTotal);
   end;
begin
   Texto := Trim(MemoTerminal.Text);
   if Texto = '' then Exit;

   NumeroAtualStr := '';
   SetLength(PilhaNumeros, 0);
   SetLength(PilhaOperadores, 0);

   for I := 1 to Length(Texto) do
   begin
      Caractere := Texto[I];

      if Caractere in ['0'..'9', ',', '.'] then
      begin
         if Caractere = '.' then Caractere := ',';
         NumeroAtualStr := NumeroAtualStr + Caractere;
      end
      else if Caractere in ['+', '-', 'X', '÷'] then
      begin
         if NumeroAtualStr <> '' then
         begin
            PushNumero(StrToFloat(NumeroAtualStr));
            NumeroAtualStr := '';
         end;

         while (Length(PilhaOperadores) > 0) and
            (ObterPrecedencia(PilhaOperadores[High(PilhaOperadores)]) >=
             ObterPrecedencia(Caractere)) do
         begin
            ExecutarOperacaoTopo;
         end;
         PushOperador(Caractere);
      end;
   end;

   if NumeroAtualStr <> '' then
      PushNumero(StrToFloat(NumeroAtualStr));

   while Length(PilhaOperadores) > 0 do
   begin
      ExecutarOperacaoTopo;
   end;

   if Length(PilhaNumeros) > 0 then
      Resultados := PilhaNumeros[0]
   else
      Resultados := 0;

   MemoTerminal.Clear;
   MemoTerminal.Text := FloatToStr(Resultados);
   LimpaCache;
end;

procedure TCalculadora.headerMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   SC_DRAGMOVE = $F012;
begin
   if Button = mbLeft then
   begin
      ReleaseCapture;
      Perform(WM_SYSCOMMAND, SC_DRAGMOVE, 0);
   end;
end;

procedure TCalculadora.LimpaCache;
begin
   Num := '';
   Num2 := '';
   Resultados := 0;
end;

end.
