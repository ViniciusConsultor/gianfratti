<%
'MYSUPPORT - ALGUNS DIREITOS RESERVADOS
'http://www.mysupport.com.br
'
'TERMOS DE LICEN�A DESTE SISTEMA
'
'Voc� pode:
'
'- Copiar, distribuir, exibir e executar a obra;
'- Criar obras derivadas.
'
'Sob as seguintes condi��es:
'
'- Atribui��o. Voc� deve dar cr�dito ao autor original.
'- Uso N�o-Comercial. Voc� n�o pode utilizar esta obra com finalidades comerciais.
'- Compartilhamento pela mesma Licen�a. Se voc� alterar, transformar, ou criar outra obra com base nesta, voc� somente poder� distribuir a obra resultante sob uma licen�a id�ntica a esta.
'
'Para cada novo uso ou distribui��o, voc� deve deixar claro para outros os termos da licen�a desta obra.
'Qualquer uma destas condi��es podem ser renunciadas, desde que voc� obtenha permiss�o do autor.
'Qualquer direito de uso leg�timo (ou "fair use") concedido por lei, ou qualquer outro direito protegido pela legisla��o local, n�o s�o em hip�tese alguma afetados pelo disposto acima.
'
'Este � um sum�rio para leigos da Licen�a Jur�dica (na �ntegra).
'
'LICENSE
'
'You are free:
'
'to copy, distribute, display, and perform the work;
'to make derivative works.
'
'Under the following conditions:
'
'- Attribution. You must give the original author credit.
'- Noncommercial. You may not use this work for commercial purposes.
'- Share Alike. If you alter, transform, or build upon this work, you may distribute the resulting work only under a license identical to this one. 
'
'For any reuse or distribution, you must make clear to others the license terms of this work.
'Any of these conditions can be waived if you get permission from the copyright holder.
'Your fair use and other rights are in no way affected by the above.
'
'This is a human-readable summary of the Legal Code (the full license).
%>
<%
	Session.LCID = 1033
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	If NOT Session("mysAdmin") Then Response.Redirect "mysAdmSair.asp"
%>
<!--#include file="db.asp"-->
<html>
<head>
<title>MySupport - Atendimento Online</title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; }

body 			{ scrollbar-face-color: #E2E5EA;}
body 			{ scrollbar-shadow-color: #687888;}
body 			{ scrollbar-highlight-color: #ffffff;}
body 			{ scrollbar-3dlight-color: #687888;}
body 			{ scrollbar-darkshadow-color: #E2E5EA;}
body 			{ scrollbar-track-color: #bcbfc0;}
body 			{ scrollbar-arrow-color: #6e7e88;}

td		{ font-family: Tahoma, Verdana; font-size: 8pt; }
.campo{				
		font-family: Arial, Verdana; 
		font-size: 11px; 
		background-color: #FFFFFF;	
		border-left: 1 solid #68A4C8; 
		border-right: 1 solid #B8D0D8; 
		border-top: 1 solid #68A4C8; 
		border-bottom: 1 solid #B8D0D8;
		}
				
.botao 	{
			background-color: #E8E8E8; 
			color: black; 
			border-color: #FFFFFF; 
			border-width: 1px; 
			font-family: Tahoma, Verdana; 
			font-size: 8pt;
		}
</style>
</head>
<body topmargin="0" leftmargin="0" bottommargin="0">
<table width="95%" cellpadding="1" align="center">
	<tr><td colspan="2" height="15"></td></tr>
	<td valign="top"><img src="img/t_departamentos.gif" alt="" border="0">
	</td><td align="right"><a href="mysAdmDepartamentosForm.asp"><img title="Adicionar Comando"  src="img/t_adicionar.gif" alt="" border="0"></a></td></tr>
	<tr><td colspan="2" height="1" bgcolor="EDEDED"></td></tr>
	<tr><td colspan="2" height="15"></td></tr>
</table>
<%
If Ok(Request.QueryString("msg_erro")) <> "" Then
	Response.Write "<center><FONT COLOR=""#FF0000"">" & Ok(Request.QueryString("msg_erro")) & "</FONT></center><br><br>"
End If
If Ok(Request.QueryString("msg_ok")) <> "" Then
	Response.Write "<center><FONT COLOR=""#009900"">" & Ok(Request.QueryString("msg_ok")) & "</FONT></center><br><br>"
End If
%>	
<table width="95%" cellpadding="1" align="center" style="border: 1 solid #F2F2F2">
<tr bgcolor="#F5F5F5">
	<td align="center" width="5%" height="20">&nbsp;<b>#</b></td>
	<td width="35%">&nbsp;<b>Nome</b></td>
	<td align="center" width="15%">&nbsp;<b>Op��o</b></td>
</tr>
<%
Call AbreDB

Dim intContador

strSQL = "SELECT id, nome FROM departamentos ORDER BY nome"

Set rs = Conexao.Execute(strSQL)
If NOT rs.EOF Then
	intContador = 0
	While Not rs.EOF
		intContador = intContador + 1
		Response.Write "<tr onMouseOver=""this.bgColor='#F5F5F5'"" onMouseOut=""this.bgColor='#FFFFFF'"">"
		Response.Write "<td align=""right"">"& intContador &".&nbsp;</td>"
		Response.Write "<td>&nbsp;"& rs("nome") &"</td>"
		Response.Write "<td align=""center"">&nbsp;<a  href=""mysAdmDepartamentosForm.asp?acao=Editar&ID="&rs("id")&""">Editar</a> | <a  href=""mysAdmDepartamentosForm.asp?acao=Deletar&ID="&rs("id")&""">Deletar</a></td></tr>"
		Response.Write "<tr><td bgcolor=""#EDEDED"" colspan=""6"" height=""1""></td></tr>"
		rs.movenext
	Wend
Else
	Response.Write "<tr><td colspan=""6"" align=""center"">Nenhum departamento cadastrado</td></tr>"
End If

rs.close
Call FechaDB
%>
<tr><td colspan="6" height="2"></td></tr>
</table>
</body>
</html>
