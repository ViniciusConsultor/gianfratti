<% If Session("iUser") = "" Then %>
	<script language="JavaScript">
		window.open('../login/p_login.asp?Erro=3','_top','');
		//alert("Sua sess�o expirou!\nVoc� ser� redirecionado para a p�gina de login.\nInforme novamente seu Login e Senha para acessar o sistema.");
	</script>
<% End if %>