<script language="JavaScript">
//FUN��O QUE FAZ AS VALIDA��ES DO FORMULARIO
function valida_campo()
{
<!--
var id_Menu_Categorias_Admin = document.form.id_Menu_Categorias_Admin.value
if (id_Menu_Categorias_Admin==""){
	alert("Selecione a categoria onde a nova p�gina ira ser cadastrada");
	document.form.id_Menu_Categorias_Admin.focus()
	return false
	}
var Nome = document.form.Nome.value
if (Nome==""){
	alert("Entre com o nome do modulo do sistema");
	document.form.Nome.focus()
	return false
	}
var Link = document.form.Link.value
if (Link==""){
	alert("Entre com o link onde o novo modulo do sistema de econtra\n\nEx: /Admin/NovoModuloSistema/Default.asp");
	document.form.Link.focus()
	return false
	}
var Ordem = document.form.Ordem.value
if (Ordem==""){
	alert("Entre com a ordem da categoria");
	document.form.Ordem.focus()
	return false
	}
var FlgAtivo = document.form.FlgAtivo.value
if (FlgAtivo==""){
	alert("Selecione se o modulo cadastrado ficara disponivel");
	document.form.FlgAtivo.focus()
	return false
	}
	document.form.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o bot�o sera desabilitado para n�o haver duplica��o de registros caso ele clique mais um uma vez
 	document.form.submit.disabled=true;
}
//-->
</script>
