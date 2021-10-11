object fMain: TfMain
  Left = 266
  Top = 117
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'SnapShooter'
  ClientHeight = 177
  ClientWidth = 436
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object InfoText: TRichEdit
    Left = 8
    Top = 8
    Width = 413
    Height = 105
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    Lines.Strings = (
      #1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1087#1077#1088#1077#1093#1074#1072#1090#1099#1074#1072#1077#1090' '#1085#1072#1078#1072#1090#1080#1077' '#1082#1083#1072#1074#1080#1096#1080' PrintScreen '#1080
      #1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1089#1086#1093#1088#1072#1085#1103#1077#1090' '#1089#1082#1088#1080#1085#1096#1086#1090' (jpeg) '#1085#1072' '#1088#1072#1073#1086#1095#1077#1084' '#1089#1090#1086#1083#1077'.'
      ''
      #1051#1102#1073#1091#1102' '#1082#1088#1080#1090#1080#1082#1091', '#1087#1086#1078#1077#1083#1072#1085#1080#1103' '#1080' '#1087#1088#1077#1076#1083#1086#1078#1077#1085#1080#1103' '#1089' '#1091#1076#1086#1074#1086#1083#1100#1089#1090#1074#1080#1077#1084
      #1074#1099#1089#1083#1091#1096#1072#1102' '#1087#1086' '#1072#1076#1088#1077#1089#1091': petroff.cat@gmail.com')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object bOK: TButton
    Left = 337
    Top = 127
    Width = 91
    Height = 34
    Caption = #1042' '#1090#1088#1077#1081'!'
    TabOrder = 1
    OnClick = bOKClick
  end
  object TrayMenu: TPopupMenu
    Left = 280
    Top = 128
    object mAbout: TMenuItem
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      OnClick = mAboutClick
    end
    object mQuit: TMenuItem
      Caption = #1047#1072#1082#1088#1099#1090#1100
      OnClick = mQuitClick
    end
  end
end
