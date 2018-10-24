object modulo: Tmodulo
  OldCreateOrder = False
  Left = 423
  Top = 138
  Height = 493
  Width = 673
  object conexion: TADOConnection
    LoginPrompt = False
    Provider = 'ADsDSOObject'
    Left = 32
    Top = 16
  end
  object sql_global: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 96
    Top = 16
  end
  object sql_usuario: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 216
    Top = 32
  end
  object dt_usuarios: TDataSource
    DataSet = sql_usuario
    Left = 280
    Top = 32
  end
  object sql_empresa: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 216
    Top = 96
  end
  object dt_empresa: TDataSource
    DataSet = sql_empresa
    Left = 296
    Top = 96
  end
  object sql_habilita_empresa: TADOQuery
    Connection = conexion
    Parameters = <>
    SQL.Strings = (
      'select empresa, nombre from empresas order by  empresa asc')
    Left = 272
    Top = 200
  end
  object dt_habilita_empresa: TDataSource
    DataSet = sql_habilita_empresa
    Left = 376
    Top = 200
  end
  object sql_planilla: TADOQuery
    Parameters = <>
    Left = 256
    Top = 272
  end
  object sql_buscA_por_fecha: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 40
    Top = 152
  end
  object dt_busca_fecha: TDataSource
    DataSet = sql_buscA_por_fecha
    Left = 120
    Top = 152
  end
  object sql_estados: TADOQuery
    Connection = conexion
    Parameters = <>
    SQL.Strings = (
      'select * from estados order by codestado asc')
    Left = 32
    Top = 216
  end
  object dt_estados: TDataSource
    DataSet = sql_estados
    Left = 96
    Top = 216
  end
  object sql_listado: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 184
    Top = 272
  end
  object dt_sql_copia: TDataSource
    DataSet = sql_copia
    Left = 560
    Top = 64
  end
  object sql_copia: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 504
    Top = 72
  end
  object sql_canti_copia: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 576
    Top = 144
  end
  object dt_canti_copia: TDataSource
    DataSet = sql_canti_copia
    Left = 496
    Top = 152
  end
  object sql_reporte_centros: TADOQuery
    Connection = conexion
    Parameters = <>
    SQL.Strings = (
      'select '
      'c.centro, '
      'c.nombre, '
      'r.fecha, '
      'r.patente,'
      ' r.nombre, '
      'r.apellido,'
      ' r.hora '
      
        'from centros c, reserva r where c.centro=r.centro order by c.cen' +
        'tro asc'
      ''
      ''
      '')
    Left = 56
    Top = 376
  end
  object sql_reporte_reserva: TADOQuery
    Connection = conexion
    Parameters = <>
    SQL.Strings = (
      'select '
      'c.centro as ccentro,'
      'c.nombre  as cnombre, '
      'r.fecha as rfecha,'
      'r.patente as rpatente,'
      ' r.nombre as rnombre,'
      'r.apellido as rapellido,'
      ' r.hora  as rhora'
      'from centros c, reserva r where c.centro=r.centro  '
      
        'group by c.centro, c.nombre, r.fecha, r.patente, r.nombre, r.ape' +
        'llido, r.hora'
      'order by c.centro, r.hora asc')
    Left = 360
    Top = 352
  end
  object sql_aux1: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 216
    Top = 352
  end
  object query_exportar1: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 376
    Top = 40
  end
  object QUERY_WEB: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 400
    Top = 128
  end
  object query_actualiza: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 512
    Top = 296
  end
  object QUERY_WEB2: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 456
    Top = 352
  end
  object QUERY_WEB3: TADOQuery
    Connection = conexion
    Parameters = <>
    Left = 528
    Top = 352
  end
end
