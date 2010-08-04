<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 25/07/2005
' Descri��o: Pagina de busca de solicitacoes que ja estao aceitas
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<script language="javascript">
<!--
//FUN��O QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero) 
	{
	window.opener.document.form.busca.value = Numero; //Envia para o campo da pagina 
	//Envia o formulario da pagina de baixo automaticamente. 
	//Ele faz um evento Click no botao automaticamente, para isso basta colocar o nome do botao que no caso o name do botao esta como submit
	//Aten��o � importante lembrar que o nome do botao submit tem que ser em letras minusculas
	//window.opener.document.forms[1]['submit'].click();
	window.opener.document.forms[0]['submit'].click();
	window.close();
	return
	}
//-->
</script>
<%
'[CONEX�O COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

'Fun��o que mostra todas as solicita�oes que ja foram aceitas
Function VisualizarSolicitacoesAceitas

	'Query tras somento as solicita��es que j� foram aceitas e que nao existe atendimento em andamento
	SQL	=	"SELECT id, id_Paciente, id_Solicitacao_Status, id_Solicitacao_Requisicao_Tipo, Data_Cadastro_Solicitacao, dbo.FuncaoPacienteNome(id_Paciente) "&_ 
			"AS Paciente_Nome, dbo.FuncaoSolicitacao_Requisicao_Tipo(id_Solicitacao_Requisicao_Tipo) AS Solicitacao_Requisicao_Tipo, "&_
			"Tipo_Requisicao_Outros, dbo.FuncaoHospitalNome(id_Hospital) AS Hospital_Nome, dbo.FuncaoSolicitacao_Status(id_Solicitacao_Status) "&_
			"AS Solicitacao_Status, Data_Fechamento "&_
			"FROM         dbo.HomeCare_Solicitacao_Atendimento "&_
			"WHERE     (id_Solicitacao_Status = 2) AND (id NOT IN "&_
			"(SELECT     id_Solicitacao_Atendimento "&_
			"FROM          HomeCare_Atendimento "&_
			"WHERE      id_Atendimento_Status_Condicoes_Alta <> 1)) "
			set rs = createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>N�:</Td>" & Chr(10)
							Response.Write "<Td>Status:</Td>" & Chr(10)
							Response.Write "<Td>Dt. Abertura:</Td>" & Chr(10)
							Response.Write "<Td>Tempo:</Td>" & Chr(10)
							Response.Write "<Td>Tipo Solicitacao:</Td>" & Chr(10)
							Response.Write "<Td>Paciente:</Td>" & Chr(10)
							Response.Write "<Td colspan='2'>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Verifica_Paciente_Atendimento(Rs("id_Paciente"))  Then 
							imagem = "<a href=""javascript:Transfere("&Rs("id")&" )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para iniciar o atendimento para esta solicita��o'   ></a>"
							Else
							imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='Paciente j� se encontra em atendimento'   >" 
						End if
						Response.Write "<Tr >" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' align='center' >"&Rs("id")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Solicitacao_Status")&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&ArrumaDataHora(Rs("Data_Cadastro_Solicitacao"))&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&TempoDecorrido(ArrumaDataHora(Rs("Data_Cadastro_Solicitacao")),ArrumaDataHora(Rs("Data_Fechamento")))&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Solicitacao_Requisicao_Tipo")&"<br>"&Solicitacao_Texto&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Paciente_Nome")&"</Td>" & Chr(10)
							Response.Write "<td class='"&zebrado&"' align='center'>"& imagem& "</td>" & Chr(10) 
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
					Response.Write "<Table width='100%' border='0' ><Tr><td align ='center' class='texto'>Total de registros encontrado: <b>"&Rs.RecordCount&"</b></td></tr></Table>"
				Else 'Caso n�o seja encontrado nenhum registro
					Response.Write "<br><br><Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhuma Solicita��o aguardando abertura de atendimento</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'Fun��o resposavel por verifiar se o paciente j� possui uma solicitacao de atendimento aberto
'Caso o paciente n�o tenha nenhuma solicitacao em analise entao retorna TRUE senao, se caso tenha a solicitacao em aberta entao retorna False
Function Verifica_Paciente_Atendimento(id_Paciente)

	SQL	=	"SELECT nome, id " &_ 
			"FROM dbo.Pacientes " &_ 
			"WHERE (id = '"&Id_Paciente&"') AND (NOT EXISTS " &_ 
            	    "(SELECT TOP 1 1 " &_ 
					"FROM dbo.HomeCare_Atendimento INNER JOIN "&_ 
					"dbo.HomeCare_Solicitacao_Atendimento ON  " &_ 
					"dbo.HomeCare_Atendimento.id_Solicitacao_Atendimento = dbo.HomeCare_Solicitacao_Atendimento.id INNER JOIN "&_
					"dbo.Pacientes ON dbo.HomeCare_Solicitacao_Atendimento.id_Paciente = dbo.Pacientes.id "&_ 
					"WHERE id_Atendimento_Status_Condicoes_Alta = 1 AND id_paciente = '"&Id_Paciente&"')) " 
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not Rs.Eof Then 'Se n�o for vazio entao o paciente nao esta em atendimento
					Verifica_Paciente_Atendimento = True 'true quer dizer que o paciente nao esta em atendimento
					Else
						Verifica_Paciente_Atendimento = False 'false quer dizer que o paciente ja se encontra em atendimento
				End If
			Rs.Close
			Set Rs = Nothing

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction
	
	Case Else 
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_Solicitacao/modelos/Form_Visualizar_Solicitacoes_Aceitas.htm" -->
<%
End Select

'[Fecha Conex�o Com Banco De Dados]
Conn.close
set Conn = nothing
%>
