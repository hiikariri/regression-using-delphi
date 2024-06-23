object Form1: TForm1
  Left = 324
  Top = 225
  Width = 1179
  Height = 505
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 176
    Top = 232
    Width = 59
    Height = 13
    Caption = 'Jumlah Data'
  end
  object Label2: TLabel
    Left = 16
    Top = 304
    Width = 50
    Height = 13
    Caption = 'Parameter'
  end
  object Label3: TLabel
    Left = 464
    Top = 264
    Width = 140
    Height = 13
    Caption = 'Simultaneous Linear Equation'
  end
  object Label4: TLabel
    Left = 464
    Top = 368
    Width = 82
    Height = 13
    Caption = 'Gauss Elimination'
  end
  object Label5: TLabel
    Left = 768
    Top = 16
    Width = 50
    Height = 13
    Caption = 'Parameter'
  end
  object Label6: TLabel
    Left = 736
    Top = 368
    Width = 38
    Height = 13
    Caption = 'Solution'
  end
  object Button1: TButton
    Left = 16
    Top = 224
    Width = 73
    Height = 25
    Caption = 'Input Data'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 256
    Width = 145
    Height = 25
    Caption = 'Calculate Linear Regression'
    TabOrder = 1
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 176
    Top = 256
    Width = 81
    Height = 25
    TabOrder = 2
    Kind = bkClose
  end
  object Edit1: TEdit
    Left = 240
    Top = 224
    Width = 89
    Height = 21
    TabOrder = 3
  end
  object DBChart1: TDBChart
    Left = 16
    Top = 16
    Width = 313
    Height = 201
    Title.Text.Strings = (
      'Linear Regression')
    Legend.Visible = False
    View3D = False
    TabOrder = 4
    object Series1: TPointSeries
      Marks.ArrowLength = 0
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 0
      Marks.Visible = False
      SeriesColor = clRed
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object ListBox1: TListBox
    Left = 336
    Top = 16
    Width = 121
    Height = 201
    ItemHeight = 13
    TabOrder = 5
  end
  object ListBox2: TListBox
    Left = 16
    Top = 320
    Width = 441
    Height = 201
    ItemHeight = 13
    TabOrder = 6
  end
  object Chart1: TChart
    Left = 464
    Top = 16
    Width = 297
    Height = 201
    Title.Text.Strings = (
      'Polynomial Regression')
    View3D = False
    TabOrder = 7
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
    object Series4: TPointSeries
      Marks.ArrowLength = 0
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Length = 0
      Marks.Visible = False
      SeriesColor = clGreen
      ClickableLine = False
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
    end
  end
  object BitBtn2: TBitBtn
    Left = 464
    Top = 224
    Width = 161
    Height = 25
    Caption = 'Calculate Polynomial Regression'
    TabOrder = 8
    OnClick = BitBtn2Click
  end
  object StringGrid1: TStringGrid
    Left = 464
    Top = 280
    Width = 329
    Height = 81
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    TabOrder = 9
  end
  object StringGrid2: TStringGrid
    Left = 464
    Top = 384
    Width = 265
    Height = 81
    ColCount = 4
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    TabOrder = 10
  end
  object ListBox3: TListBox
    Left = 768
    Top = 32
    Width = 385
    Height = 185
    ItemHeight = 13
    TabOrder = 11
  end
  object StringGrid3: TStringGrid
    Left = 736
    Top = 384
    Width = 89
    Height = 105
    ColCount = 1
    FixedCols = 0
    RowCount = 3
    FixedRows = 0
    TabOrder = 12
  end
  object OpenDialog1: TOpenDialog
    Left = 272
    Top = 256
  end
end
