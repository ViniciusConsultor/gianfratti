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
on error resume next
%>
<!--#include file="df.asp"-->
<html>
	  <head>
	  		<title><%=nomeloja%> - <%=slogan%></title>
			 <style type="text/css">
			 		<!--
					a:link       { color: <%=cor4%> }
					a:visited    { color: <%=cor4%> }
					a:hover      { color: <%=cor3%> }
					-->
			</style>
			   		</head>
							<body>
<%
'Valida o e-mail
strEmail = Request.querystring("email")
If strEmail = "" Or instr(strEmail, "@") = 0 Or instr(strEmail, ".") = 0 then%>
								 <table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><br><center><b><font style=font-size:13px;font-family:<%=fonte%>><%=strLg152%><br><br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><font style=font-size:11px><a href="javascript: window.close()" style="text-decoration:none;">:: <%=strLg153%> ::</a>
<%
response.end
end if



set abredb = Server.CreateObject("ADODB.Connection")
	abredb.Open(StringdeConexao)

'*******************************************************************************|
'ARQUIVO ALTERADO POR: HENRIQUE_METASUPRI EM 15/01/2004 �S 10:11h				|
'	IMPEDE DUPLICIDADE DE E-MAILS CADASTRADOS PARA NEWSLETTER					|
'_______________________________________________________________________________|
'http://www.metasupri/eshop				|			   henrique@metasupri.com.br|
'*******************************************************************************

IF request.queryString("Opcao") = "1" Then
'Grava e-mail no banco de dados
abredb.Execute("INSERT INTO newsletter (datacad, email) VALUES ('"&date&"', '"&strEmail&"');")
abredb.Close
set abredb = Nothing
if err.number <> 0 then%>
<basefont face="<%=fonte%>"><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><center><font style=font-size:13px; color=#000000><b>Oooops!</b></font></p><p align=center><font style=font-size:11px; color=#000000>Talvez voc� j� tenha cadastrado este e-mail em nosso site.<br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><center><font style=font-size:11px;><a href="javascript: window.close()" style="text-decoration:none;"><b>:: <%=strLg153%> ::</b></a></p>

<%else%> 

	<basefont face="<%=fonte%>"><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><center><font style=font-size:13px; color=#000000><b><%=strLg154%></b></font></p><p align=center><font style=font-size:11px; color=#000000><%=strLg155%> <%=nomeloja%>!<br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><center><font style=font-size:11px;><a href="javascript: window.close()" style="text-decoration:none;"><b>:: <%=strLg153%> ::</b></a></p>
<%end if%>

<% ELSE
'-----------------------------------
'##############################
'### --- ROGERIO SILVA  --- ###
'##############################
'-----------------------------------
'APAGA e-mail no banco de dados
abredb.Execute("DELETE FROM newsletter WHERE EMAIL = '"&strEmail&"'")
abredb.Close
set abredb = Nothing%> 
<basefont face="<%=fonte%>"><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><br><center><font style=font-size:13px; color=#000000><b><%=strLg268%></b></font></p><p align=center><font style=font-size:11px; color=#000000><%=strLg269%> <%=nomeloja%>!<br><br><table border=0 cellspacing=0 width=100% cellpadding=0><tr><td height=5></td></tr><tr><td height=1 bgcolor=<%=cor3%>></td></tr><tr><td height=5></td></tr></table><center><font style=font-size:11px;><a href="javascript: window.close()" style="text-decoration:none;"><b>:: <%=strLg153%> ::</b></a></p>
<%END IF%>