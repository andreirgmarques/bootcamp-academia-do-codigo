object FormGeradorModeloOTAGeradorModelo: TFormGeradorModeloOTAGeradorModelo
  Left = 0
  Top = 0
  Caption = 'FormGeradorModeloOTAGeradorModelo'
  ClientHeight = 576
  ClientWidth = 452
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  DesignSize = (
    452
    576)
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 9
    Width = 25
    Height = 15
    Caption = 'Host'
  end
  object Label2: TLabel
    Left = 135
    Top = 9
    Width = 28
    Height = 15
    Caption = 'Porta'
  end
  object Label3: TLabel
    Left = 190
    Top = 9
    Width = 48
    Height = 15
    Caption = 'Database'
  end
  object Label4: TLabel
    Left = 8
    Top = 57
    Width = 40
    Height = 15
    Caption = 'Usu'#225'rio'
  end
  object Label5: TLabel
    Left = 135
    Top = 57
    Width = 50
    Height = 15
    Caption = 'Password'
  end
  object Label6: TLabel
    Left = 8
    Top = 153
    Width = 97
    Height = 23
    AutoSize = False
    Caption = 'TABELAS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object chklstTabelas: TCheckListBox
    Left = 8
    Top = 182
    Width = 431
    Height = 392
    Anchors = [akLeft, akTop, akBottom]
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    PopupMenu = pmMenuTabelas
    TabOrder = 0
  end
  object edtDataBase: TEdit
    Left = 190
    Top = 25
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'DBNEGOCIOSMT'
  end
  object edtPorta: TEdit
    Left = 135
    Top = 25
    Width = 50
    Height = 23
    TabOrder = 2
    Text = '5432'
  end
  object edtHost: TEdit
    Left = 8
    Top = 25
    Width = 121
    Height = 23
    TabOrder = 3
    Text = 'localhost'
  end
  object edtUsuario: TEdit
    Left = 8
    Top = 73
    Width = 121
    Height = 23
    TabOrder = 4
    Text = 'fontdata'
  end
  object edtSenha: TEdit
    Left = 135
    Top = 73
    Width = 121
    Height = 23
    PasswordChar = '*'
    TabOrder = 5
    Text = 'FDTI1252'
  end
  object btnOnOff: TButton
    Left = 8
    Top = 103
    Width = 97
    Height = 25
    Caption = 'Conectar'
    TabOrder = 6
    OnClick = btnOnOffClick
  end
  object rgDriver: TRadioGroup
    Left = 317
    Top = 8
    Width = 122
    Height = 120
    Caption = 'Driver'
    ItemIndex = 1
    Items.Strings = (
      'MySql'
      'Postgres'
      'Firebird'
      'SQLite')
    TabOrder = 7
  end
  object FDConn: TFDConnection
    Params.Strings = (
      'Database=DBNEGOCIOSMT'
      'User_Name=fontdata'
      'Password=FDTI1252'
      'DriverID=PG'
      'Server=localhost')
    LoginPrompt = False
    Left = 51
    Top = 206
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 51
    Top = 268
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\Public\Documents\Embarcadero\Studio\20.0\Bpl\libmysql.d' +
      'll'
    Left = 131
    Top = 206
  end
  object FDMetaInfoTable: TFDMetaInfoQuery
    Connection = FDConn
    TableKinds = [tkTable]
    Left = 132
    Top = 268
  end
  object FDMetaInfoPK: TFDMetaInfoQuery
    Connection = FDConn
    MetaInfoKind = mkPrimaryKeyFields
    TableKinds = [tkTable]
    Left = 133
    Top = 329
  end
  object fdqTable: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'select * from pedido where 1 = 2')
    Left = 49
    Top = 384
  end
  object pmMenuTabelas: TPopupMenu
    Left = 344
    Top = 208
    object MarcarTodos1: TMenuItem
      Caption = 'Marcar Todos'
      OnClick = MarcarTodos1Click
    end
    object DesmarcarTodos1: TMenuItem
      Caption = 'Desmarcar Todos'
      OnClick = DesmarcarTodos1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object GerarModelos1: TMenuItem
      Caption = 'Gerar Modelos'
      OnClick = GerarModelos1Click
    end
    object GerarController1: TMenuItem
      Caption = 'Gerar Controller'
      OnClick = GerarController1Click
    end
  end
  object PGDriver: TFDPhysPgDriverLink
    Left = 48
    Top = 328
  end
end
