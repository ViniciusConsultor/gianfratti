<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 25/07/2005
' Descri��o: Pagina de busca de pacientes
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<script language="javascript">
<!--
//FUN��O QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero) 
	{
	//Numero = Numero.substring(0,3) + "." + Numero.substring(4,7) + "." + Numero.substring(8,11) + "." +  Numero.substring(12,14) + '-' ; 
	window.opener.document.form.busca.value = Numero; //Envia para o campo da pagina 
	window.opener.CarregaPacientes();
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

'Fun��o que mostra todos os medicos
Function VisualizarPacientes

	dim pag
	regs = 15 'Aqui setamos quantos registros ser�o listados por p�gina. 
	pag = request.querystring("pagina")
		if pag = "" Then
		   pag = 1
		end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs

	SQL	=	"Select Id,Nome,RG,CPF From Pacientes " 
 			clausula = "WHERE "
				if Trim(Request("Nome")) <> "" Then
					sql = sql & clausula & " Nome like '%"&Trim(Replace(Request("Nome"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("RG")) <> "" Then
					sql = sql & clausula & " RG like '%"&Trim(Replace(Request("RG"),"'","''"))&"%'  "
					clausula = "and "
				end if
				if Trim(Request("CPF")) <> "" Then
					sql = sql & clausula & " CPF like '%"&Trim(Replace(Request("CPF"),"'","''"))&"%'  "
					clausula = "and "
				end if
				If Session("Tipo_Login") = "2" Then
					sql = sql & clausula & " id_Convenio = '"&Session("id_Convenio")&"'  "
					clausula = "and "								
				End if
				sql = sql & "Order By Nome "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>Nome:</Td>" & Chr(10)
							Response.Write "<Td>RG:</Td>" & Chr(10)
							Response.Write "<Td>CPF:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Verifica_Paciente_Atendimento(Rs("id"))  Then 
							imagem = "<a href=""javascript:Transfere('"&MascaraCPF(Rs("CPF"))&"' )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar este paciente'   ></a>"
							Else
							imagem = "<img src='/SmartCare/images/ico_cadeado.gif' border='0' alt='J� exsite uma solicitacao em analise para este paciente'   >" 
						End if
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td style='Cursor: Pointer;' class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&MascaraRG(Rs("RG"))&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"' >"&MascaraCPF(Rs("CPF"))&"&nbsp;</Td>" & Chr(10)
							Response.Write "<Td width='3%' class='"&zebrado&"'>"&imagem&"&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso n�o seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da pagina��o
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para n�i ter que ficar colocando em varios lugares
							VariaveisBusca = "Nome="&Request("Nome")&"&RG="&Request("RG")&"&CPF="&Request("CPF")
							Response.Write "<div align='center' class='texto'>"&"Total de registros encontrados: " & rs.RecordCount & "</Div>"
							Response.Write "<div align='center' class='texto'>P�gina <b>" & pag & "</b> de " & rs.PageCount & "</Div>"
							If rs.PageCount <= 5 Then
								pinicial = 1
								pfinal = rs.PageCount
							Else
								pinicial = pag - pag mod 15 + 1
								pfinal = pag - pag mod 15 + 15
								If pinicial = pag + 1 Then
									pinicial = pinicial - 15
									pfinal = pfinal - 15
								End If
								If pfinal > rs.PageCount Then
									pfinal = rs.PageCount
								End If
							End If
							Response.Write "<div align='center' class='texto'>"
							If pag > 1 Then Response.Write "<a href=""" & SCRIPT_NAME & "?"&VariaveisBusca&"&pagina=" & pag - 1 & """>&lt;&lt; Anterior</a> |" 
							While pinicial <= pfinal
								If trim(pinicial) = trim(n) Then Response.Write "<b>" 
								Response.Write	"<a href=""" & SCRIPT_NAME & "?"&VariaveisBusca&"&pagina=" & pinicial & """>" & pinicial & "</a> " 
								If trim(pinicial) = trim(n) Then Response.Write "</b>"
								pinicial = pinicial + 1
							Wend
							If Abs(pag) < Abs(rs.PageCount) Then Response.Write "| <a href=""" & SCRIPT_NAME & "default.asp?"&VariaveisBusca&"&pagina=" & pag + 1 & """>Pr�xima &gt;&gt;</a>" 
							Response.Write "</div>"
					'Fim da pagina��o					
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
                    "FROM HomeCare_Solicitacao_Atendimento a " &_ 
                    "WHERE a.id_Solicitacao_Status = 1 AND a.id_paciente = '"&Id_Paciente&"')) " 
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
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_Paciente/modelos/Form_Visualizar_Pacientes.htm" -->
<%
End Select

'[Fecha Conex�o Com Banco De Dados]
Conn.close
set Conn = nothing
%>
