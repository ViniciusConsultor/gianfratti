<script language="JavaScript">
//Fun��o que verifica o CPF do paciente
function verifica_cpf()
{

	cpf = document.form1.Confere_CPF.value
		
		if (!Valida_CPF(cpf)) //chama a fun��o global para verificar o cpf
		{
			document.form1.Confere_CPF.value = "";
			return false;
		}

}

//FUN��O QUE FAZ AS VALIDA��ES DO FORMULARIO
function valida_campo()
{
<!--

var Nome = document.form.Nome.value
if (Nome==""){
	alert("Entre com o nome do paciente");
	document.form.Nome.focus()
	return false
	}
var Sexo = document.form.Sexo.value
if (Sexo==""){
	alert("Entre com o sexo do paciente");
	document.form.Sexo.focus()
	return false
	}
/*
var Data_Nascimento = document.form.Data_Nascimento.value
if (Data_Nascimento==""){
	alert("Entre com a data de nascimento do paciente");
	document.form.Data_Nascimento.focus()
	return false
	}
*/
/*
var Responsavel = document.form.Responsavel.value
if (Responsavel == ""){
	alert("Entre com o nome de uma pessoa responsavel pelo atendimento do paciente");
	document.form.Responsavel.focus()
	return false
	}
*/
var Endereco = document.form.Endereco.value
if (Endereco==""){
	alert("Entre com endere�o do paciente");
	document.form.Endereco.focus()
	return false
	}
/*
var Cep = document.form.Cep.value
if (Cep==""){
	alert("Entre com o cep do paciente");
	document.form.Cep.focus()
	return false
	}
*/
var UF = document.form.UF.value
if (UF==""){
	alert("Entre com o estado onde o paciente reside");
	document.form.UF.focus()
	return false
	}
var Cidade = document.form.Cidade.value
if (Cidade==""){
	alert("Entre com a cidade onde o paciente reside");
	document.form.Cidade.focus()
	return false
	}
/*
var Bairro = document.form.Bairro.value
if (Bairro==""){
	alert("Entre com o bairro onde o paciente reside");
	document.form.Bairro.focus()
	return false
	}
*/
var id_cobertura = document.form.id_cobertura.value
if (id_cobertura==""){
	alert("Selecione a zona onde o pacinte mora");
	document.form.id_cobertura.focus()
	return false
	}
var Telefones = document.form.Telefones.value
if (Telefones==""){
	alert("Entre com os telefones de contato do paciente");
	document.form.Telefones.focus()
	return false
	}
/*
var Cuidador = document.form.Cuidador.value
if (Cuidador==""){
	alert("Entre o nome do cuidador do paciente");
	document.form.Cuidador.focus()
	return false
	}
*/
/*
var RG = document.form.RG.value
if (RG==""){
	alert("Entre o n�mero do RG do paciente");
	document.form.RG.focus()
	return false
	}
*/
var id_Convenio = document.form.id_Convenio.value
if (id_Convenio==""){
	alert("Entre com o convenio do paciente");
	document.form.id_Convenio.focus()
	return false
	}
var Particular = document.form.Particular.value
if (Particular==""){
	alert("Selecione se o convenio � particular ou n�o");
	document.form.Particular.focus()
	return false
	}
	document.form.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o bot�o sera desabilitado para n�o haver duplica��o de registros caso ele clique mais um uma vez
 	document.form.submit.disabled=true;
}
//-->
</script>
