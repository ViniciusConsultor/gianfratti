<!-- #include virtual="/MailMarketing/Shared/inc/logado.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Conn.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/Config.asp" -->
<!-- #include virtual="/MailMarketing/Shared/inc/functions.asp" -->
<%
	opcao		= request("opcao")
	acao		= request("acao")
	id			= REQUEST("id")
	
%>
<html>
<head>
	<Meta http-equiv='Pragma' content='no-cache'>
	<Meta http-equiv=expires content='Thu, 01 Jan 1970 00:00:00 GMT'>
	<Meta http-equiv='Cache-Control' content='no-store'>
	<Meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
	<link type="text/css" rel="stylesheet" href="../shared/css/style.css">
	
	<script language="Javascript" type="text/javascript" src="../shared/js/efeitos.js"></script>
	<script language="Javascript" type="text/javascript" src="../shared/js/funcoesCampos.js"></script>
	<script language="Javascript" type="text/javascript" src="../shared/js/geral.js"></script>
	<script	language='javascript' for='window' event='onLoad'>
		window.name='Eventos'
	</script>
	<Script language="JavaScript">
	function fnPiscar(){
		if(document.getElementById('pisca').style.color == '#000000'){
			document.getElementById('pisca').style.color = '#FF0000'
		}else{
			document.getElementById('pisca').style.color = '#000000'
		}
		tmpPiscar = setTimeout("fnPiscar()",500);
	}
	
	function fnStopPiscar(){
			tmpPiscar = setTimeout("fnPiscar()",500);
			clearTimeout(tmpPiscar);
	}
	</Script>
</head>
<body topmargin="0" bottommargin="0" leftmargin="0" rightmargin="0">
<div style="height:20px; width:100%; backGround-color:#FFFFE1; border:1px solid #666666; font-family:tahoma; font-size:10px; padding-left:10px; padding-top:2px; text-transform:uppercase; display:none;" id="Alerta"><img src="../shared/img/icones/atencao.gif" hspace="10"><span id="pisca" style="color:#FF0000;">O cancelamento desta a��o poder� ocasionar perca de informa��es!</span></div>
<table cellpadding="0" cellspacing="0" width="98%" height="100%" align="center" border="0" id="table1">
	<tr>
		<td height="10">&nbsp;</td>
	</tr>
	<tr>
		<td class="Font10Vinho"><b>GERENCIADOR DE EVENTOS</b></td>
	</tr>
	<tr>
		<td height="30" valign="bottom"><!--#include file="i_menu_titulo.asp"--></td>
	</tr>
	<tr>
		<td height="100%" class="BordaPretaTabela" valign="top" align="center"><br>
			<% Select Case (opcao) %>
				<% Case 1 %>
					<% Select Case (acao) %>
						<% Case 1 %>
							<!--#include file="i_cadastrar_form.asp"-->
						<% Case 2 %>
							<!--#include file="i_cadastrar_gravar.asp"-->
					<% End Select %>
				<% Case 2 %>
					<% Select Case (acao) %>
						<% Case 1 %>
							<!--#include file="i_listas.asp"-->
						<% Case 2 %>
							<!--#include file="i_dados.asp"-->
							<!--#include file="i_cadastrar_form.asp"-->
						<% Case 3 %>
							<!--#include file="i_cadastrar_gravar.asp"-->
					<% End Select %>
				<% Case 3 %>
					<% Select Case (acao) %>
						<% Case 1 %>
							<!--#include file="i_listas.asp"-->
						<% Case 2 %>
							<!--#include file="i_cadastrar_gravar.asp"-->						
					<% End Select %>
				<% Case 4 %>
					<% Select Case (acao) %>
						<% Case 1 %>
							<!--#include file="i_listas.asp"-->
						<% Case 2 %>
							<!--#include file="i_dados.asp"-->
							<!--#include file="i_listar_dados.asp"-->
					<% End Select %>
			<%End Select%>	

		</td>
	</tr>
	<tr>
		<td height="10">&nbsp;</td>
	</tr>
</table>
</body>
</html>
<%Response.Flush()%>