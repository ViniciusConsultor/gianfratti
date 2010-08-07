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
<!--#include file="db.asp"-->
<%
	Session.LCID = 1033
	Response.Expires = 0
	Response.ExpiresAbsolute = Now() - 1
	Response.addHeader "pragma","no-cache"
	Response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
	
	If NOT Session("mysAdmin") Then Response.Redirect "mysAdmSair.asp"
%>
<html>
<head>
<title> &#9658;&#9658;&#9658; MySupport - Atendimento Online</title>
<style>
a:link	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:visited	{font-size:8pt; font-family: Tahoma, Verdana; color:000000; TEXT-DECORATION: none;}
a:hover	{font-size:8pt; font-family: Tahoma, Verdana; color:F4B511; TEXT-DECORATION: none;}
body	{ font-family: Tahoma, Verdana; font-size: 8pt; }
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
<table height="100%" width="100%" cellspacing="0">
	<tr bgcolor="F5F5F5">
		<td valign="middle" width="50%" height="60">
			<img src="img/mysupport.gif" alt="" border="0">
		</td>
		<td valign="middle" align="center"><font size="3"><b></b></font>
		</td>
		<td>&nbsp;&nbsp;</td>
	</tr>
	<tr bgcolor="#07435E">
		<td colspan="3"><font color="#FFFFFF">
		<a href="mysAdmDepartamentos.asp" target="meio">
		<img title="Departamentos" src="img/b_departamentos.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysAdmOperadores.asp" target="meio">
		<img title="Operadores" src="img/b_operadores.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysAdmStats.asp" target="meio">
		<img title="Estat�sticas" src="img/b_estatisticas.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysAdmComandos.asp" target="meio">
		<img title="Mensagens programadas" src="img/b_comandos.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysAdmHistorico.asp" target="meio">
		<img title="Historico de Atendimentos" src="img/b_historico.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysAdmConfiguracoes.asp" target="meio">
		<img title="Configura��es" src="img/b_configuracoes.gif" alt="" border="0"></a>
		<img src="img/b_1px.gif" alt="" border="0">
		<a href="mysAdmSair.asp" target="meio">
		<img title="Sair da Administra��o" src="img/b_sair.gif" alt="" border="0"></a>
		</font></td>
	</tr>
	<tr>
		<td colspan="3" height="2"></td>
	</tr>
	<tr bgcolor="#F4B511">
		<td colspan="3" height="1"></td>
	</tr>
	<tr>
		<td colspan="3" height="2"></td>
	</tr>
	<tr>
		<td colspan="3" height="75%" valign="top">
			<iframe src="mysAdmStats.asp" name="meio" id="meio" width="100%" height="100%" frameborder="0"></iframe>
		</td>
	</tr>
	<tr bgcolor="#DDDDDD">
		<td colspan="3" height="1"></td>
	</tr>
	<tr>
		<td colspan="3" height="5" bgcolor="F5F5F5"></td>
	</tr>
	<tr bgcolor="F5F5F5">
		<td valign="top" colspan="3" height="25" align="center"></td>
	</tr>
			<font size="1"></font>
		</td>
	</tr>
</table>
</body>
</html>
