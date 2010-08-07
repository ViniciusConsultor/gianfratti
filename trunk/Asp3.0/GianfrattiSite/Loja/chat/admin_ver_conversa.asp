<%
'******************************************************************
'  Suporte Online SuperAsp 1.0 - SuperASP.com.br - Ano 2003
'  Autor: Fabiano Dias - fdmail@ibest.com.br
'******************************************************************
'
'       DIREITOS AUTORIAIS DO SUPORTE ONLINE SUPERASP
'
'  Voc� n�o pode revender este script, alugar, disponibilizar  para
'  download ou fazer qualquer outro tipo  de  redistribui��o  sem a
'  nossa autoriza��o.
'
'  Este c�digo de programa��o usa uma t�cnica de criptografia,  que
'  identifica sua autoria, ou seja, alterar este c�digo ou revender
'  o mesmo sem contatar o autor significa estar infrigindo todas as
'  leis de direitos autorais e intelectuais,  e como tal passivo de
'  todas as aplica��es na forma da lei.
'
'******************************************************************
If Session("SOS_admin") = "" And Session("SOS_ipadmin") <> Request.ServerVariables("REMOTE_ADDR") Then
  Response.Redirect "admin_login.asp"
Else
%>

<html>
<head>
<title><%=Application("SOS_titulo")%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="copyright" content="SuperAsp">
<meta name="keywords" content="sos, suporte online, suporteonline, superasp, suporte, online">
<meta name="robots" content="ALL">
<style type="text/css">
<!--
.texto{
font-family: Tahoma, Arial;
font-size: 11px;
}
-->
</style>
</head>
<body class="texto" bgcolor="#ffffff">

<%
Dim Conexao, objRS_atendimentos, ComandoSQL

Set Conexao = Server.CreateObject("ADODB.Connection")
Conexao.Open Application("SOS_conexao")
ComandoSQL = " SELECT * FROM historico WHERE atendente = " & Request("id")

Select Case Request("nota")
Case 0 : Response.Write "<font color=gray><b>ATENDIMENTOS ""<font color=skyblue>N�O AVALIADOS</font>""</b></font>" : ComandoSQL = ComandoSQL & "AND nota = 0"
Case 1 : Response.Write "<font color=gray><b>ATENDIMENTOS AVALIADOS COMO ""<font color=red>P�SSIMO ATENDIMENTO</font>""</b></font>" : ComandoSQL = ComandoSQL & "AND nota = 1"
Case 2 : Response.Write "<font color=gray><b>ATENDIMENTOS AVALIADOS COMO ""<font color=darkorange>ATENDIMENTO REGULAR</FONT>""</b></font>" : ComandoSQL = ComandoSQL & "AND nota = 2"
Case 3 : Response.Write "<font color=gray><b>ATENDIMENTOS AVALIADOS COMO ""<font color=yellow>BOM ATENDIMENTO</font>""</b></font>" : ComandoSQL = ComandoSQL & "AND nota = 3"
Case 4 : Response.Write "<font color=gray><b>ATENDIMENTOS AVALIADOS COMO ""<font color=green>�TIMO ATENDIMENTO</font>""</b></font>" : ComandoSQL = ComandoSQL & "AND nota = 4"
Case Else : Response.Write "<font color=gray><b>ATENDIMENTOS</b></font>"
End Select


Set objRS_atendimentos = Server.CreateObject("ADODB.Recordset")
objRS_atendimentos.CursorLocation = 2
objRS_atendimentos.CursorType = 0
objRS_atendimentos.LockType = 1
objRS_atendimentos.Open ComandoSQL, Conexao,,, &H0001

Response.Write "<table width=100% cellpadding=5 cellspacing=0 style='border-top:2px solid gainsboro'><tr><td bgcolor='whitesmoke' class=texto>"

If Not objRS_atendimentos.EOF Then
  While Not objRS_atendimentos.EOF
    Response.Write objRS_atendimentos("usuario") & "<br>"
	objRS_atendimentos.MoveNext
  Wend
End If
Response.Write "</td></tr></table>"

Conexao.Close
Set ComandoSQL = Nothing
Set objRS_atendimentos = Nothing
Set Conexao = Nothing


%>

</body>
</html>

<%
End If
%>