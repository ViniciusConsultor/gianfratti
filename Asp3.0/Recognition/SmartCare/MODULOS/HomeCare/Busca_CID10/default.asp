<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 04/05/2005
' Descri��o: Pagina de administra��o de Diagnosticos - CID10 - Esta pagina so serve para montar as categorias e subcategorias com Iframes
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction

	Case Else
%>
	<!-- #include virtual="/SmartCare/CID10/modelos/Form_Visualizar_Cid10.asp" -->
<%
End Select

%>
