<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Pacientes/Js/Validacoes.js" -->

<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">

<%
' Autor: Fabrizio Gianfratti Manes
' Data: 18/01/2005
' Descri��o: Pagina de busca de pacientes
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<script language="javascript">
<!--
//FUN��O QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Id, Nome) 
	{
	window.opener.document.form.id_Paciente.value = Id; //Envia para o campo da pagina 
	window.opener.document.form.Paciente_Nome.value = Nome; //Envia para o campo da pagina
	//window.opener.location = '/SmartCare/Atendimentos/default.asp?action=Form_Incluir_Atendimentos&id_paciente=' + Id + '&Paciente_Nome=' + Nome ; //Envia para a pagina de baixo com os parametros que o formulario recupera
	window.close();
	return
	}
//-->
</script>
<%
'[DELCARA��O DAS VARIAVEIS GLOBAIS]
Dim id,Nome,Sexo,Data_Nascimento,Responsavel,Endereco,Cep,UF,Cidade,Bairro,Fone1,Fone2,Fone3,Contato1,Contato2,Contato3,Data_Vencimento,Particular,Numero_Convenio,id_Convenio
'[CONEX�O COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUN��O RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE J� EXISTEM
Function VisualizarPacientes

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Pacientes_Visualizar '"&Replace(Request("Busca"),"'","")&"' , '"&Request("id_Convenio")&"' , '"&Request("UF")&"' , '"&Request("Particular")&"' , '' , '1' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatena��o
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Nome:</Td>" & Chr(10)&_
							"<Td>Convenio:</Td>" & Chr(10)&_
							"<Td>Particular:</Td>" & Chr(10)&_
							"<Td>Numero:</Td>" & Chr(10)&_
							"<Td>Vencimento:</Td>" & Chr(10)&_
							"<Td>Qtd Dias Venc.:</Td>" & Chr(10)&_
							"<Td>&nbsp;</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Rs("Particular") = True Then Particular = "Sim" Else Particular = "N�o" End If
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						'Verifica se a quantidade de dias para o vencimento � menor que zero, caso seja entao � colocado uma imagem GIF piscando "VENCIDO" envez de uma contagem negativa
						'� colodo tamb�m uma imgem de fundo na TD para ficar piscando caso a data de vencimento do convenio esteja vencida
						If Rs("QTD_Dias_Para_Vencimento_Convenio") < 0 Then 
							FundoPiscando = "background='"&Application("Dominio")&"/images/FundoPiscando.gif'"
							Img_Selecionar = "&nbsp;"
							QTD_Dias_Para_Vencimento_Convenio = "<img src='"&Application("Dominio")&"/images/VencidoPequeno.gif' Border='0'>" 
							Else 
							FundoPiscando = ""
							Img_Selecionar = "<a href=""javascript:Transfere(" & rs("id") & " , '" & rs("Nome") & "'  )"" > <img src='/SmartCare/images/Selecionar.gif'  border='0'> </a> </a>"
							QTD_Dias_Para_Vencimento_Convenio = Rs("QTD_Dias_Para_Vencimento_Convenio")
						End if
						'Verifica se a data de vencimento do convenio esta NULA, caso esteja entao � colocado o valor INDETERMINADO envez da data de vencimento
						IF Isnull(Rs("Data_Vencimento"))  Then Data_Vencimento = "<b>INDETERMINADO</b>" Else  Data_Vencimento = ArrumaData(Rs("Data_Vencimento")) End IF

						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"' "&FundoPiscando&" >"&Rs("Nome")&"</Td>" & Chr(10)&_
							"<Td align='center' class='"&zebrado&"' "&FundoPiscando&" >"&Rs("Convenio")&"</Td>" & Chr(10)&_
							"<Td align='center' class='"&zebrado&"' "&FundoPiscando&" >"&Particular&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"' "&FundoPiscando&" >"&Rs("Numero_Convenio")&"</Td>" & Chr(10)&_
							"<Td align='center' class='"&zebrado&"' "&FundoPiscando&" >"&Data_Vencimento&"</Td>" & Chr(10)&_
							"<Td align='center' class='"&zebrado&"' "&FundoPiscando&" >"&QTD_Dias_Para_Vencimento_Convenio&"&nbsp;</Td>" & Chr(10)&_
							"<Td align='center' class='"&zebrado&"' "&FundoPiscando&" >"&Img_Selecionar&"</td>" & Chr(10) &_ 
						"</Tr>" 
					Rs.MoveNext
					Next
					Content = Content &_
					"</Table>"
					Content = Content & "<Table><tr><td class='texto' >Total de pacientes encontrados ("&Rs.RecordCount&")</td></tr></Table>"
				Else 'Caso n�o seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			VisualizarPacientes = Content

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction
		
	Case "Form_Incluir_Pacientes"
%>
	<!-- #include virtual="/SmartCare/Pacientes/modelos/Form_Incluir_Pacientes.htm" -->
<%
	Case "IncluirPacientes"
		Call IncluirPacientes 'CHAMA A FUN��O QUE IRA INCLUIR UM NOVO PACIENTE, ESTA FUN��O � GLOBAL
	
	Case Else
%>
	<!-- #include virtual="/SmartCare/Bibliotecas/Buscas/Pacientes/modelos/Form_Visualizar_Pacientes.htm" -->
<%
End Select

'Fecha Conex�o Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>