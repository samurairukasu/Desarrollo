Attribute VB_Name = "Module2"
'* Este módulo contiene el código a disposición por parte de IFDRIVERS
'* en una base TAL CUAL. Todo receptor del  Módulo se considera
'* bajo licencia de los derechos de autor de IFDRIVERS para utilizar el
'* código fuente siempre en modo que él o ella considere conveniente,
'* incluida la copia, la compilación, su modificacion Y la redistribución,
'* con o sin modificaciones. Ninguna licencia o patentes de IFDRivers
'* está implícita en la presente licencia.
'*
'* El usuario del codigo fuente debera entender que IFDRIVERS no puede
'* Proporcionar apoyo técnico para el módulo y no sera Responsable
'* de las consecuencias del uso del programa.
'*
'* Todas las comunicaciones, incluida ésta, no deben ser removidos
'* del módulo sin el consentimiento previo por escrito de IFDRIVERS

Public IFiscal As Object

'**************************************
'*** Syntax: ESTADO(byVar1)
'**************************************
Function ESTADO(byVar1 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@ESTADO" & "|" + byVar1

nError = IFiscal.IF_WRITE(strBuff)

ESTADO = nError

End Function

'**************************************
'*** Syntax: CIERRE(byVar1, byVar2)
'**************************************
Function CIERRE(byVar1 As String, byVar2 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@CIERRE" & "|" + byVar1 & "|" + byVar2

nError = IFiscal.IF_WRITE(strBuff)

CIERRE = nError

End Function

'**************************************
'*** Syntax: CIERREZ()
'**************************************
Function CIERREZ() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@CIERREZ"

nError = IFiscal.IF_WRITE(strBuff)

CIERREZ = nError

End Function

'**************************************
'*** Syntax: CIERREX()
'**************************************
Function CIERREX() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@CIERREX"

nError = IFiscal.IF_WRITE(strBuff)

CIERREX = nError

End Function

'**************************************
'*** Syntax: AUDITORIAF(strVar1, strVar2, byVar3)
'**************************************
Function AUDITORIAF(strVar1 As String, strVar2 As String, byVar3 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@AUDITORIAF" & "|" + strVar1 & "|" + strVar2 & "|" + byVar3

nError = IFiscal.IF_WRITE(strBuff)

AUDITORIAF = nError

End Function

'**************************************
'*** Syntax: AUDITORIAZ(nVar1, nVar2, byVar3)
'**************************************
Function AUDITORIAZ(nVar1 As Integer, nVar2 As Integer, byVar3 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@AUDITORIAZ" & "|" + CStr(nVar1) & "|" + CStr(nVar2) & "|" + byVar3

nError = IFiscal.IF_WRITE(strBuff)

AUDITORIAZ = nError

End Function

'**************************************
'*** Syntax: TIQUEABRE(byVar1)
'**************************************
Function TIQUEABRE(byVar1 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@TIQUEABRE" & "|" + byVar1

nError = IFiscal.IF_WRITE(strBuff)

TIQUEABRE = nError

End Function

'**************************************
'*** Syntax: TIQUETEXTO(strVar1)
'**************************************
Function TIQUETEXTO(strVar1 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@TIQUETEXTO" & "|" + strVar1

nError = IFiscal.IF_WRITE(strBuff)

TIQUETEXTO = nError

End Function

'**************************************
'*** Syntax: TIQUEITEM(strVar1, dblVar2, dblVar3, dblVar4, byVar5, nVar6, dblVar7, dblVar8)
'**************************************
Function TIQUEITEM(strVar1 As String, dblVar2 As Double, dblVar3 As Double, dblVar4 As Double, _
  byVar5 As String, nVar6 As Integer, dblVar7 As Double, dblVar8 As Double) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@TIQUEITEM" & "|" + strVar1 & "|" + CStr(dblVar2) & "|" + CStr(dblVar3) & "|" + _
 CStr(dblVar4) & "|" + byVar5 & "|" + CStr(nVar6) & "|" + CStr(dblVar7) & "|" + CStr(dblVar8)

nError = IFiscal.IF_WRITE(strBuff)

TIQUEITEM = nError

End Function

'**************************************
'*** Syntax: TIQUESUBTOTAL(byVar1, strVar2)
'**************************************
Function TIQUESUBTOTAL(byVar1 As String, strVar2 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@TIQUESUBTOTAL" & "|" + byVar1 & "|" + strVar2

nError = IFiscal.IF_WRITE(strBuff)

TIQUESUBTOTAL = nError

End Function

'**************************************
'*** Syntax: TIQUEPAGO(strVar1, dblVar2, byVar3)
'**************************************
Function TIQUEPAGO(strVar1 As String, dblVar2 As Double, byVar3 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@TIQUEPAGO" & "|" + strVar1 & "|" + CStr(dblVar2) & "|" + byVar3

nError = IFiscal.IF_WRITE(strBuff)

TIQUEPAGO = nError

End Function

'**************************************
'*** Syntax: TIQUECIERRA(byVar1)
'**************************************
Function TIQUECIERRA(byVar1 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@TIQUECIERRA" & "|" + byVar1

nError = IFiscal.IF_WRITE(strBuff)

TIQUECIERRA = nError

End Function

'**************************************
'*** Syntax: TIQUECANCEL()
'**************************************
Function TIQUECANCEL() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@TIQUECANCEL"

nError = IFiscal.IF_WRITE(strBuff)

TIQUECANCEL = nError

End Function

'**************************************
'*** Syntax: NOFISABRE()
'**************************************
Function NOFISABRE() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@NOFISABRE"

nError = IFiscal.IF_WRITE(strBuff)

NOFISABRE = nError

End Function

'**************************************
'*** Syntax: NOFISITEM(strVar1)
'**************************************
Function NOFISITEM(strVar1 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@NOFISITEM" & "|" + strVar1

nError = IFiscal.IF_WRITE(strBuff)

NOFISITEM = nError

End Function

'**************************************
'*** Syntax: NOFISCIERRA(byVar1)
'**************************************
Function NOFISCIERRA(byVar1 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@NOFISCIERRA" & "|" + byVar1

nError = IFiscal.IF_WRITE(strBuff)

NOFISCIERRA = nError

End Function

'**************************************
'*** Syntax: DNFHTARJETADECREDITO(strVar1, strVar2, strVar3, strVar4, strVar5, strVar6, strVar7, strVar8, strVar9, dblVar10, strVar11, strVar12, strVar13, strVar14, strVar15, strVar16, strVar17, strVar18, byVar19, byVar20, byVar21)
'**************************************
Function DNFHTARJETADECREDITO(strVar1 As String, strVar2 As String, strVar3 As String, strVar4 As String, _
 strVar5 As String, strVar6 As String, strVar7 As String, strVar8 As String, strVar9 As String, _
 dblVar10 As Double, strVar11 As String, strVar12 As String, strVar13 As String, strVar14 As String, _
  strVar15 As String, strVar16 As String, strVar17 As String, strVar18 As String, byVar19 As String, _
   byVar20 As String, byVar21 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@DNFHTARJETADECREDITO" & "|" + strVar1 & "|" + strVar2 & "|" + strVar3 & "|" + strVar4 & "|" + strVar5 & "|" + strVar6 & "|" + strVar7 & "|" + strVar8 & "|" + strVar9 & "|" + CStr(dblVar10) & "|" + strVar11 & "|" + strVar12 & "|" + strVar13 & "|" + strVar14 & "|" + strVar15 & "|" + strVar16 & "|" + strVar17 & "|" + strVar18 & "|" + byVar19 & "|" + byVar20 & "|" + byVar21

nError = IFiscal.IF_WRITE(strBuff)

DNFHTARJETADECREDITO = nError

End Function

'**************************************
'*** Syntax: DNFHOBRASOCIAL(strVar1, strVar2, strVar3, strVar4, strVar5, strVar6, strVar7, strVar8, strVar9, strVar10, strVar11, strVar12, strVar13, byVar14, byVar15, byVar16, byVar17, byVar18)
'**************************************
Function DNFHOBRASOCIAL(strVar1 As String, strVar2 As String, strVar3 As String, strVar4 As String, strVar5 As String, strVar6 As String, strVar7 As String, strVar8 As String, strVar9 As String, strVar10 As String, strVar11 As String, strVar12 As String, strVar13 As String, byVar14 As String, byVar15 As String, byVar16 As String, byVar17 As String, byVar18 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@DNFHOBRASOCIAL" & "|" + strVar1 & "|" + strVar2 & "|" + strVar3 & "|" + strVar4 & "|" + strVar5 & "|" + strVar6 & "|" + strVar7 & "|" + strVar8 & "|" + strVar9 & "|" + strVar10 & "|" + strVar11 & "|" + strVar12 & "|" + strVar13 & "|" + byVar14 & "|" + byVar15 & "|" + byVar16 & "|" + byVar17 & "|" + byVar18

nError = IFiscal.IF_WRITE(strBuff)

DNFHOBRASOCIAL = nError

End Function

'**************************************
'*** Syntax: PONEPREFERENCIA(byVar1, byVar2, byVar3, byVar4, strVar5, strVar6)
'**************************************
Function PONEPREFERENCIA(byVar1 As String, byVar2 As String, byVar3 As String, byVar4 As String, strVar5 As String, strVar6 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@PONEPREFERENCIA" & "|" + byVar1 & "|" + byVar2 & "|" + byVar3 & "|" + byVar4 & "|" + strVar5 & "|" + strVar6

nError = IFiscal.IF_WRITE(strBuff)

PONEPREFERENCIA = nError

End Function

'**************************************
'*** Syntax: LEEPREFERENCIA(byVar1, byVar2, byVar3)
'**************************************
Function LEEPREFERENCIA(byVar1 As String, byVar2 As String, byVar3 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@LEEPREFERENCIA" & "|" + byVar1 & "|" + byVar2 & "|" + byVar3

nError = IFiscal.IF_WRITE(strBuff)

LEEPREFERENCIA = nError

End Function

'**************************************
'*** Syntax: ESTACIONPPAL(byVar1, byVar2, byVar3, byVar4, byVar5)
'**************************************
Function ESTACIONPPAL(byVar1 As String, byVar2 As String, byVar3 As String, byVar4 As String, byVar5 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@ESTACIONPPAL" & "|" + byVar1 & "|" + byVar2 & "|" + byVar3 & "|" + byVar4 & "|" + byVar5

nError = IFiscal.IF_WRITE(strBuff)

ESTACIONPPAL = nError

End Function

'**************************************
'*** Syntax: NOFISDOC(byVar1, byVar2)
'**************************************
Function NOFISDOC(byVar1 As String, byVar2 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@NOFISDOC" & "|" + byVar1 & "|" + byVar2

nError = IFiscal.IF_WRITE(strBuff)

NOFISDOC = nError

End Function

'**************************************
'*** Syntax: CORTAPAPEL()
'**************************************
Function CORTAPAPEL() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@CORTAPAPEL"

nError = IFiscal.IF_WRITE(strBuff)

CORTAPAPEL = nError

End Function

'**************************************
'*** Syntax: AVANZATIQUE(nVar1)
'**************************************
Function AVANZATIQUE(nVar1 As Integer) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@AVANZATIQUE" & "|" + CStr(nVar1)

nError = IFiscal.IF_WRITE(strBuff)

AVANZATIQUE = nError

End Function

'**************************************
'*** Syntax: AVANZAAUDIT(nVar1)
'**************************************
Function AVANZAAUDIT(nVar1 As Integer) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@AVANZAAUDIT" & "|" + CStr(nVar1)

nError = IFiscal.IF_WRITE(strBuff)

AVANZAAUDIT = nError

End Function

'**************************************
'*** Syntax: AVANZAAMBOS(nVar1)
'**************************************
Function AVANZAAMBOS(nVar1 As Integer) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@AVANZAAMBOS" & "|" + CStr(nVar1)

nError = IFiscal.IF_WRITE(strBuff)

AVANZAAMBOS = nError

End Function

'**************************************
'*** Syntax: AVANZAHOJA(nVar1)
'**************************************
Function AVANZAHOJA(nVar1 As Integer) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@AVANZAHOJA" & "|" + CStr(nVar1)

nError = IFiscal.IF_WRITE(strBuff)

AVANZAHOJA = nError

End Function

'**************************************
'*** Syntax: PONEFECHORA(strVar1, strVar2)
'**************************************
Function PONEFECHORA(strVar1 As String, strVar2 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@PONEFECHORA" & "|" + strVar1 & "|" + strVar2

nError = IFiscal.IF_WRITE(strBuff)

PONEFECHORA = nError

End Function

'**************************************
'*** Syntax: PIDEFECHORA()
'**************************************
Function PIDEFECHORA() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@PIDEFECHORA"

nError = IFiscal.IF_WRITE(strBuff)

PIDEFECHORA = nError

End Function

'**************************************
'*** Syntax: PONEENCABEZADO(nVar1, strVar2)
'**************************************
Function PONEENCABEZADO(nVar1 As Integer, strVar2 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@PONEENCABEZADO" & "|" + CStr(nVar1) & "|" + strVar2

nError = IFiscal.IF_WRITE(strBuff)

PONEENCABEZADO = nError

End Function

'**************************************
'*** Syntax: PIDEENCABEZADO(nVar1)
'**************************************
Function PIDEENCABEZADO(nVar1 As Integer) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@PIDEENCABEZADO" & "|" + CStr(nVar1)

nError = IFiscal.IF_WRITE(strBuff)

PIDEENCABEZADO = nError

End Function

'**************************************
'*** Syntax: ABRECAJON1()
'**************************************
Function ABRECAJON1() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@ABRECAJON1"

nError = IFiscal.IF_WRITE(strBuff)

ABRECAJON1 = nError

End Function

'**************************************
'*** Syntax: ABRECAJON2()
'**************************************
Function ABRECAJON2() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@ABRECAJON2"

nError = IFiscal.IF_WRITE(strBuff)

ABRECAJON2 = nError

End Function

'**************************************
'*** Syntax: FACTABRE(byVar1, byVar2, byVar3, byVar4, byVar5, strVar6, byVar7, byVar8, strVar9, strVar10, strVar11, strVar12, byVar13, strVar14, strVar15, strVar16, strVar17, strVar18, byVar19)
'**************************************
Function FACTABRE(byVar1 As String, byVar2 As String, byVar3 As String, byVar4 As String, byVar5 As String, strVar6 As String, byVar7 As String, byVar8 As String, strVar9 As String, strVar10 As String, strVar11 As String, strVar12 As String, byVar13 As String, strVar14 As String, strVar15 As String, strVar16 As String, strVar17 As String, strVar18 As String, byVar19 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@FACTABRE" & "|" + byVar1 & "|" + byVar2 & "|" + byVar3 & "|" + byVar4 & "|" + byVar5 & "|" + strVar6 & "|" + byVar7 & "|" + byVar8 & "|" + strVar9 & "|" + strVar10 & "|" + strVar11 & "|" + strVar12 & "|" + byVar13 & "|" + strVar14 & "|" + strVar15 & "|" + strVar16 & "|" + strVar17 & "|" + strVar18 & "|" + byVar19

nError = IFiscal.IF_WRITE(strBuff)

FACTABRE = nError

End Function

'**************************************
'*** Syntax: FACTITEM(strVar1, dblVar2, dblVar3, dblVar4, byVar5, nVar6, dblVar7, strVar8, strVar9, strVar10, dblVar11, dblVar12)
'**************************************
Function FACTITEM(strVar1 As String, dblVar2 As Double, dblVar3 As Double, dblVar4 As Double, byVar5 As String, nVar6 As Integer, dblVar7 As Double, strVar8 As String, strVar9 As String, strVar10 As String, dblVar11 As Double, dblVar12 As Double) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@FACTITEM" & "|" + strVar1 & "|" + CStr(dblVar2) & "|" + CStr(dblVar3) & "|" + CStr(dblVar4) & "|" + byVar5 & "|" + CStr(nVar6) & "|" + CStr(dblVar7) & "|" + strVar8 & "|" + strVar9 & "|" + strVar10 & "|" + CStr(dblVar11) & "|" + CStr(dblVar12)

nError = IFiscal.IF_WRITE(strBuff)

FACTITEM = nError

End Function

'**************************************
'*** Syntax: FACTSUBTOTAL(byVar1, strVar2)
'**************************************
Function FACTSUBTOTAL(byVar1 As String, strVar2 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@FACTSUBTOTAL" & "|" + byVar1 & "|" + strVar2

nError = IFiscal.IF_WRITE(strBuff)

FACTSUBTOTAL = nError

End Function

'**************************************
'*** Syntax: FACTPAGO(strVar1, dblVar2, byVar3)
'**************************************
Function FACTPAGO(strVar1 As String, dblVar2 As Double, byVar3 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@FACTPAGO" & "|" + strVar1 & "|" + CStr(dblVar2) & "|" + byVar3

nError = IFiscal.IF_WRITE(strBuff)

FACTPAGO = nError

End Function

'**************************************
'*** Syntax: FACTPERCEP(strVar1, byVar2, dblVar3)
'**************************************
Function FACTPERCEP(strVar1 As String, byVar2 As String, dblVar3 As Double) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@FACTPERCEP" & "|" + strVar1 & "|" + byVar2 & "|" + CStr(dblVar3)

nError = IFiscal.IF_WRITE(strBuff)

FACTPERCEP = nError

End Function

'**************************************
'*** Syntax: FACTCIERRA(byVar1, byVar2, strVar3)
'**************************************
Function FACTCIERRA(byVar1 As String, byVar2 As String, strVar3 As String) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@FACTCIERRA" & "|" + byVar1 & "|" + byVar2 & "|" + strVar3

nError = IFiscal.IF_WRITE(strBuff)

FACTCIERRA = nError

End Function

'**************************************
'*** Syntax: FACTCANCEL()
'**************************************
Function FACTCANCEL() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@FACTCANCEL"

nError = IFiscal.IF_WRITE(strBuff)

FACTCANCEL = nError

End Function

'**************************************
'*** Syntax: PAUSA(nVar1)
'**************************************
Function PAUSA(nVar1 As Integer) As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@PAUSA" & "|" + CStr(nVar1)

nError = IFiscal.IF_WRITE(strBuff)

PAUSA = nError

End Function

'**************************************
'*** Syntax: SINCRO()
'**************************************
Function SINCRO() As Long

Dim nError  As Long
Dim strBuff As String

strBuff = "@SINCRO"

nError = IFiscal.IF_WRITE(strBuff)

SINCRO = nError

End Function
