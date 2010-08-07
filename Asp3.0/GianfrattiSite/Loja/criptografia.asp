<% 
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
'#
'#  C�DIGO: VirtuaStore Vers�o OPEN - Copyright 2001-2004 VirtuaStore
'#  URL: http://comunidade.virtuastore.com.br
'#  E-MAIL: comunidade@virtuastore.com.br
'#  AUTORES: Ot�vio Dias(Desenvolvedor)
'# 
'#     Este programa � um software livre; voc� pode redistribu�-lo e/ou 
'#     modific�-lo sob os termos do GNU General Public License como 
'#     publicado pela Free Software Foundation.
'#     � importante lembrar que qualquer altera��o feita no programa 
'#     deve ser informada e enviada para os criadores, atrav�s de e-mail 
'#     ou da p�gina de onde foi baixado o c�digo.
'#
'#  //-------------------------------------------------------------------------------------
'#  // LEIA COM ATEN��O: O software VirtuaStore OPEN deve conter as frases
'#  // "Powered by VirtuaStore OPEN" ou "Software derivado de VirtuaStore 1.2" e 
'#  // o link para o site http://comunidade.virtuastore.com.br no cr�ditos da 
'#  // sua loja virtual para ser utilizado gratuitamente. Se o link e/ou uma das 
'#  // frases n�o estiver presentes ou visiveis este software deixar� de ser
'#  // considerado Open-source(gratuito) e o uso sem autoriza��o ter� 
'#  // penalidades judiciais de acordo com as leis de pirataria de software.
'#  //--------------------------------------------------------------------------------------
'#      
'#     Este programa � distribu�do com a esperan�a de que lhe seja �til,
'#     por�m SEM NENHUMA GARANTIA. Veja a GNU General Public License
'#     abaixo (GNU Licen�a P�blica Geral) para mais detalhes.
'# 
'#     Voc� deve receber a c�pia da Licen�a GNU com este programa, 
'#     caso contr�rio escreva para
'#     Free Software Foundation, Inc., 59 Temple Place, Suite 330, 
'#     Boston, MA  02111-1307  USA
'# 
'#     Para enviar suas d�vidas, sugest�es e/ou contratar a VirtuaWorks 
'#     Internet Design entre em contato atrav�s do e-mail 
'#     contato@virtuaworks.com.br ou pelo endere�o abaixo: 
'#     Rua Ven�ncio Aires, 1001 - Niter�i - Canoas - RS - Brasil. Cep 92110-000.
'#
'#     Para ajuda e suporte acesse um dos sites abaixo:
'#     http://comunidade.virtuastore.com.br
'#     http://br.groups.yahoo.com/group/virtuastore
'#
'#     BOM PROVEITO!          
'#     Equipe VirtuaStore
'#     []'s
'#
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################

'IN�CIO DO C�DIGO

'Este c�digo est� otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP




'#############################
'Novo sistema utiliza criptografia extrema em 64 bits usando o algoritimo BASE64 da RSA
'#############################

Function Cripto(StrCripto, BolAcao) 'In�cio de da fun��o de criptografia. Aonde o par�metro String � o valor que ser� criptografado ou descriptografado. E o par�metro BolAcao � um valor booleano (True ou False) para indicar se deve ser criptografado (True) ou descriptografado (False).

if application("Cripto_Ativa") = "Sim" then
If BolAcao Then
Cripto = EncodeBase64(StrCripto)
       Else
Cripto = DecodeBase64(StrCripto)
End If
else
Cripto = StrCripto
end if

End Function


Function EncodeBase64(inData)
On Error Resume Next
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim cOut
  Dim sOut
  Dim I
  For I = 1 To Len(inData) Step 3
    Dim nGroup, pOut, sGroup
    nGroup = &H10000 * Asc(Mid(inData, I, 1)) + &H100 * MyASC(Mid(inData, I + 1, 1)) + MyASC(Mid(inData, I + 2, 1))
    nGroup = Oct(nGroup)
    nGroup = String(8 - Len(nGroup), "0") & nGroup
    pOut = Mid(Base64, CLng("&o" & Mid(nGroup, 1, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 3, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 5, 2)) + 1, 1) + _
      Mid(Base64, CLng("&o" & Mid(nGroup, 7, 2)) + 1, 1)
    sOut = sOut + pOut
    If (I + 2) Mod 57 = 0 Then sOut = sOut + vbCrLf
  Next
  Select Case Len(inData) Mod 3
    Case 1:
      sOut = Left(sOut, Len(sOut) - 2) + "=="
    Case 2:
      sOut = Left(sOut, Len(sOut) - 1) + "="
  End Select
  EncodeBase64 = sOut
End Function


Function MyASC(OneChar)
  If OneChar = "" Then MyASC = 0 Else MyASC = Asc(OneChar)
End Function
'==============================================================


'==============================================================
Function DecodeBase64(ByVal base64String)
On Error Resume Next
  Const Base64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  Dim dataLength
  Dim sOut
  Dim groupBegin
  base64String = Replace(base64String, vbCrLf, "")
  base64String = Replace(base64String, vbTab, "")
  base64String = Replace(base64String, " ", "")
  dataLength = Len(base64String)
  If dataLength Mod 4 <> 0 Then
    Err.Raise 1, "VirtuaStore OPEN", "String de criptografia com problemas. " & VBNewline & "Contate nosso suporte t�cnico pelo telefone (0xx51) 475-7545."
    Exit Function
  End If

  For groupBegin = 1 To dataLength Step 4
    Dim numDataBytes
    Dim CharCounter
    Dim thisChar
    Dim thisData
    Dim nGroup
    Dim pOut
    numDataBytes = 3
    nGroup = 0

    For CharCounter = 0 To 3
      thisChar = Mid(base64String, groupBegin + CharCounter, 1)
      If thisChar = "=" Then
        numDataBytes = numDataBytes - 1
        thisData = 0
      Else
        thisData = InStr(Base64, thisChar) - 1
      End If
      If thisData = -1 Then
        Err.Raise 2, "VirtuaStore OPEN", "String de criptografia com problemas. " & VBNewline & "Contate nosso suporte t�cnico pelo telefone (0xx51) 475-7545."
        Exit Function
      End If
      nGroup = 64 * nGroup + thisData
    Next
    nGroup = Hex(nGroup)
    nGroup = String(6 - Len(nGroup), "0") & nGroup
    pOut = Chr(CByte("&H" & Mid(nGroup, 1, 2))) + _
      Chr(CByte("&H" & Mid(nGroup, 3, 2))) + _
      Chr(CByte("&H" & Mid(nGroup, 5, 2)))
    sOut = sOut & Left(pOut, numDataBytes)
  Next
  DecodeBase64 = sOut
End Function


%>