<Script>
// Autor: Fabrizio Gianfratti Manes
// Data: 02/02/2005
// Descri��o: Pagina de Scripts JS
// Atualizado por: -
// Data: -
// Atualiza��o: -
</Script>

<Script>
//Fun��o resposavel por carregar o procedimento inserindo o Codigo da AMB
//Usamos o ActiveX XMLHTTP para buscar o nome do medicamento
//IMPORTANTE DIZER: SEMPRE USAR NO ASP A INSTRU��O Response.CharSet="iso-8859-1" POIS DESSA FORMA NAO IRA RETORNAR CARACTERES ESTRANHOS, PRINCIPALMENTE QUANDO A STRING COMTEM ACENTOS
//Importante resaltar que este precedimento tem problemas quando a includes e qualquer outro tipo de HTML que contenha na pagina onde ira retornar o registro
function CarregaAMB(Cod_AMB) //Fun��o que recebe o value(valor) do campos e a posicao do vetor que � passado
{
	try //Inicio de tratamento de erro
		{ 
			//alert(PosicaoVetor)
			var Dados; //Varivel onde ficare arazenado o resultado final
			xmlHTTP = new ActiveXObject("Microsoft.XMLHTTP"); //Cria o ActiveX do XMLHTTP
			xmlHTTP.Open('POST', 'carrega.asp?Action=BuscaAMB&Cod_AMB=' + document.formCadastro.Cod_AMB.value, false); // Seta a pagina onde ira buscar os dados.
			xmlHTTP.Send(); //Envia
 
			Dados = xmlHTTP.responseText; //Atribui o resultado obtido na busca a variavel
			Dados = Dados.split("#") //Da um splite no retorno pois o registro veio concatenado com # que � o separador

			if (Dados == "") //Verifica se a variavel esta vazia
				{ 
					alert('C�digo AMB n�o encontrado\n\nCodigo n�:'+Cod_AMB.value ) //Caso esteje vazia entao � retornado a MSG de n�o encontrado
					document.formCadastro.Cod_AMB.value = "";
					document.formCadastro.Descricao_AMB.value = "";
					document.formCadastro.QTD_CH.value = ""; 
					document.formCadastro.Numero_Auxiliares.value = ""; 
				 }
			else //Caso a Variavel n�o for vazia ent�o e atrubuido a variavel DADOS com o valor
				{ 
					//alert(Dados); //Caso queira depurar qualquer tipo de retorno que esta tenho, basta habilitar esta linha
					document.formCadastro.Descricao_AMB.value = Dados[0]; //Mostra o valor do registo no compo indicado
					document.formCadastro.QTD_CH.value = Dados[1]; //Mostra o valor do registo no compo indicado
					document.formCadastro.Numero_Auxiliares.value = Dados[2]; //Mostra o valor do registo no compo indicado
				}

		}
	catch(e)//Caso houve erro ent�o � mostrado a descri��o do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
}
</script>

<script language="JavaScript">
//FUN��O QUE FAZ AS VALIDA��ES DO FORMULARIO
function valida_campo()
{
<!--
if (document.formCadastro.id_Atendimento.value==""){
	alert("Para gravar um procedimento � obrigat�rio o preenchimento do n�mero do atendimento");
	return false
	}
if (document.formCadastro.Data_Procedimento.value==""){
	alert("Selecione a data do procedimento");
	document.formCadastro.Data_Procedimento.focus()
	return false
	}
if (document.formCadastro.Cod_AMB.value==""){
	alert("Digite o c�digo AMB para gravar um procedimento");
	document.formCadastro.Cod_AMB.focus()
	return false
	}
	document.formCadastro.submit.value="Aguarde..!!" //Se todos os campos obrigatorios foram preenchidos o bot�o sera desabilitado para n�o haver duplica��o de registros caso ele clique mais um uma vez
 	document.formCadastro.submit.disabled=true;
}
//-->
</script>

