unit UnitLinearAndPolynomialRegression;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Series, TeEngine, ExtCtrls, TeeProcs, Chart, DBChart, StdCtrls,
  DBCtrls, Buttons, Grids;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    DBChart1: TDBChart;
    Series1: TPointSeries;
    Label2: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Series2: TLineSeries;
    Chart1: TChart;
    BitBtn2: TBitBtn;
    Series3: TLineSeries;
    Series4: TPointSeries;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ListBox3: TListBox;
    StringGrid3: TStringGrid;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Filename, filesimpan : TextFile;
  ndata : Integer;
  datax, datay : array [0..1000] of Real;
  order : Extended;

implementation
{$R *.dfm}
procedure SwapColumnsInStringGrid(StringGrid: TStringGrid; column1, column2: Integer);
var
  i: Integer;
  temp: string;
begin
  if (column1 < 0) or (column1 >= StringGrid.ColCount) or
     (column2 < 0) or (column2 >= StringGrid.ColCount) then
     Exit;

  for i := 0 to StringGrid.RowCount - 1 do
  begin
    temp := StringGrid.Cells[column1, i];
    StringGrid.Cells[column1, i] := StringGrid.Cells[column2, i];
    StringGrid.Cells[column2, i] := temp;
  end;
end;

function Cube(x: Double): Double;
begin
  Result := x * x * x;
end;

function Quartic(x: Double): Double;
begin
  Result := x * x * x * x;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
n : Integer;
s1, s2 : string;
x,y: Real;
begin
  Series1.Clear;
  Series2.Clear;
  ListBox1.Clear;
  ListBox2.Clear;
  ListBox3.Clear;

  if OpenDialog1.Execute then
  begin
    AssignFile(Filename, OpenDialog1.FileName);
    Reset(Filename);
    n := 0;
    while not Eof(Filename) do
    begin
      Readln(Filename,datax[n],datay[n]);
      n:=n+1;
    end;
    ndata := n;
    Edit1.Text := IntToStr(ndata);
    CloseFile(Filename);

    for n := 0 to ndata-1 do
    begin
      Series1.AddXY(datax[n],datay[n]);
      x:= datax[n] ;
      y:= datay[n];
      Str(x:2:3, s1);
      Str(y:2:3, s2);
      ListBox1.Items.Add('x = ' +s1 +' ;' +'y = ' +s2  );
    end;
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
n : Integer;
s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15 : string;
Lsf : array [0..1000] of Extended;
l_sum_xy, l_sum_x, l_sum_y, l_sum_x_sqr, a0, a1, st, stdev, varian, Cv, sr, syx, r2 : Extended;
x_mean, y_mean : Extended;
begin
l_sum_x:= 0;
l_sum_y:= 0;
l_sum_xy:= 0;
l_sum_x_sqr:= 0;
st := 0; stdev := 0; varian := 0; Cv := 0; sr := 0; syx := 0; r2 := 0;
for n := 0 to ndata-1 do
  begin
  l_sum_x:= l_sum_x + datax[n];
  l_sum_y:= l_sum_y + datay[n];
  l_sum_xy := l_sum_xy + datax[n] * datay[n];
  l_sum_x_sqr := l_sum_x_sqr + datax[n] * datax[n];

  end;
  x_mean := l_sum_x / ndata;
  y_mean := l_sum_y / ndata;
  l_sum_xy := l_sum_xy;
  l_sum_x_sqr := l_sum_x_sqr;

  a1 := (n * l_sum_xy - l_sum_x * l_sum_y)/(n * l_sum_x_sqr - l_sum_x * l_sum_x);
  a0 := y_mean - a1 * x_mean;

  Str(x_mean:2:2, s3);
  Str(y_mean:2:2, s4);
  Str(l_sum_xy:2:2, s5);
  Str(l_sum_x_sqr:2:2, s6);
  Str(a1:2:2, s7);
  Str(a0:2:2, s8);

  ListBox2.Items.Add('Average of x = ' + s3 +' ;    ' +' Average of y = ' +s4 +' ; ');
  ListBox2.Items.Add('Sum of x*y = ' + s5 +' ;   ' +' sum of x^2 = ' +s6  +' ; ');
  ListBox2.Items.Add('Slope = ' + s7 +' ;    ' +' Intercept = ' + s8);
  begin
  for n:= 0 to ndata-1 do
    begin
    st := st + Sqr((datay[n] - y_mean));
    sr := sr + Sqr(datay[n] - a1 * datax[n] - a0);
    Lsf[n]:= a0 + a1 * datax[n];
    Series2.AddXY(datax[n], Lsf[n]);
    Str(st:2:2, s9);
    Str(sr:2:2, s10);

    end;
    syx := sqrt(sr / (n-2));
    r2 := (st-sr) / st;
    stdev := Sqrt(st / (n-1));
    varian := (st / (n-1));
    Cv := (stdev / y_mean) * 100;
    Str(syx:2:2, s11);
    Str(r2:2:2, s12);
    Str(stdev:2:2, s13);
    Str(varian:2:2, s14);
    Str(Cv:2:2, s15);
    ListBox2.Items.Add('Sum of the square of the residuals (st) = ' + s9);
    ListBox2.Items.Add('Square of Residual Error (Sr) = ' + s10);
    ListBox2.Items.Add('Standard error of the estimate (S y/x) = ' + s11 );
    ListBox2.Items.Add('Coefficient of determination (r^2) : = ' + s12);
    ListBox2.Items.Add('Standar Deviation (stdev) : = ' + s13);
    ListBox2.Items.Add('Varian (varian) : = ' + s14);
    ListBox2.Items.Add('Coefficient of variation (Cv) : = ' + s15);
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
const
  Rows = 3;
  Cols = 4;
var
  n, order, i, j, k : Integer;
  p_sum_x, p_sum_y, p_x_sqr_sum, p_x_cube_sum, p_x_quartic_sum, p_sum_xy, p_sum_x_sqr_y : Extended;
  a0, a1, a3 : Extended;
  p_std_error, p_coeff_of_determination, p_sr, p_st, factor : Extended;
  p_y_result : array [0..1000] of Extended;
  y_mean, x_mean : Extended;
  sle_matrix : array [0..2, 0..3] of Extended;
  solutions : array [0..2] of Extended;
begin
  Series3.Clear;
  Series4.Clear;
  order := 2;
  p_sum_x := 0;
  p_sum_y := 0;
  p_x_sqr_sum := 0;
  p_x_cube_sum := 0;
  p_x_quartic_sum := 0;
  p_sum_xy := 0;
  p_sum_x_sqr_y := 0;
  for n:=0 to ndata-1 do
    begin
      p_sum_x := p_sum_x + datax[n];
      p_sum_y := p_sum_y + datay[n];
      p_x_sqr_sum := p_x_sqr_sum + Sqr(datax[n]);
      p_x_cube_sum := p_x_cube_sum + Cube(datax[n]);
      p_x_quartic_sum := p_x_quartic_sum + Quartic(datax[n]);
      p_sum_xy := p_sum_xy + (datax[n] * datay[n]);
      p_sum_x_sqr_y := p_sum_x_sqr_y + (Sqr(datax[n]) * datay[n]);
    end;
  y_mean := p_sum_y / ndata;
  x_mean := p_sum_x / ndata;

  sle_matrix[0, 0] := ndata;
  sle_matrix[0, 1] := p_sum_x;
  sle_matrix[0, 2] := p_x_sqr_sum;
  sle_matrix[0, 3] := p_sum_y;

  sle_matrix[1, 0] := p_sum_x;
  sle_matrix[1, 1] := p_x_sqr_sum;
  sle_matrix[1, 2] := p_x_cube_sum;
  sle_matrix[1, 3] := p_sum_xy;

  sle_matrix[2, 0] := p_x_sqr_sum;
  sle_matrix[2, 1] := p_x_cube_sum;
  sle_matrix[2, 2] := p_x_quartic_sum;
  sle_matrix[2, 3] := p_sum_x_sqr_y;

  StringGrid1.Cells[4, 0] := 'a0';
  StringGrid1.Cells[4, 1] := 'a1';
  StringGrid1.Cells[4, 2] := 'a2';

  for i := 0 to 2 do
  begin
    for j := 0 to 3 do
    begin
        StringGrid1.Cells[j, i] := FloatToStr(sle_matrix[i, j]);
    end;
  end;

  SwapColumnsInStringGrid(StringGrid1, 3, 4);

  for i := 0 to Rows - 2 do
  begin
    for k := i + 1 to Rows - 1 do
    begin
      if Abs(sle_matrix[i, i]) < Abs(sle_matrix[k, i]) then
      begin
        for j := 0 to Cols - 1 do
        begin
          factor := sle_matrix[i, j];
          sle_matrix[i, j] := sle_matrix[k, j];
          sle_matrix[k, j] := factor;
        end;
      end;
    end;

    for k := i + 1 to Rows - 1 do
    begin
      factor := sle_matrix[k, i] / sle_matrix[i, i];
      for j := i to Cols - 1 do
        sle_matrix[k, j] := sle_matrix[k, j] - factor * sle_matrix[i, j];
    end;
  end;

  for i := 0 to 2 do
  begin
    for j := 0 to 3 do
    begin
        StringGrid2.Cells[j, i] := FloatToStr(sle_matrix[i, j]);
    end;
  end;

  solutions[Rows - 1] := sle_matrix[Rows - 1, Cols - 1] / sle_matrix[Rows - 1, Rows - 1];
  for i := Rows - 2 downto 0 do
  begin
    solutions[i] := sle_matrix[i, Cols - 1];
    for j := i + 1 to Rows - 1 do
      begin
      solutions[i] := solutions[i] - sle_matrix[i, j] * solutions[j];
      end;
    solutions[i] := solutions[i] / sle_matrix[i, i];
  end;

  for i := 0 to Rows-1 do
    begin
      StringGrid3.Cells[0, i] := FloatToStr(solutions[i]);
    end;

  for i := 0 to ndata-1 do
    begin
      p_st := p_st + Sqr(datay[i] - y_mean);
      p_sr := p_sr + Sqr((datay[i] - solutions[0] - solutions[1] * datax[i] - solutions[2] * Sqr(datax[i])));
      p_y_result[i] := solutions[0] + solutions[1] * datax[i] + solutions[2] * Sqr(datax[i]);
    end;
  p_std_error := Sqrt(p_sr / (ndata - (order + 1)));
  p_coeff_of_determination := (p_st - p_sr) / p_st;

  for i := 0 to ndata-1 do
    begin
      Series3.AddXY(datax[i], p_y_result[i]);
      Series4.AddXY(datax[i], datay[i]);
    end;

  ListBox3.Items.Add('Sum of x = ' + FloatToStr(p_sum_x) + ' sum of y = ' + FloatToStr(p_sum_y));
  ListBox3.Items.Add('Sum of xy = ' + FloatToStr(p_sum_xy) + ' sum of (x^2 * y) = ' + FloatToStr(p_sum_x_sqr_y));
  ListBox3.Items.Add('Average of x = ' + FloatToStr(x_mean) + ' Average of y = ' + FloatToStr(y_mean));
  ListBox3.Items.Add('a0 = ' + FloatToStr(solutions[0]));
  ListBox3.Items.Add('a1 = ' + FloatToStr(solutions[1]));
  ListBox3.Items.Add('a2 = ' + FloatToStr(solutions[2]));
  ListBox3.Items.Add('p_st = ' + FloatToStr(p_st));
  ListBox3.Items.Add('Standard error = ' + FloatToStr(p_std_error));
  ListBox3.Items.Add('Coefficient of determination = ' + FloatToStr(p_coeff_of_determination));
  ListBox3.Items.Add('Polynomial Regression Equation');
  ListBox3.Items.Add('y = ' + FloatToStr(solutions[0]) + ' + ' + FloatToStr(solutions[1]) + 'x + ' + FloatToStr(solutions[2]) + 'x^2');
end;

end.
