<!-- #include virtual="/SmartCare/VerificaUsuarioLogado.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 16/08/2005
' Descri��o: Pagina de busca de produtos Simpro
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<script language="javascript">
<!--
//FUN��O QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero,Tipo_Busca_Simpro,Posicao_Vetor) 
	{
	try //Estou usando tratamento de erro pois caso for da solicitacao de atendimento o campo tem um nome e se vier da abertura do atendimento o campo tem outro nome
		{ 
				window.opener.document.formCadastro.Cod_Exame[Posicao_Vetor].value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaExames(window.opener.document.formCadastro.Cod_Exame,Posicao_Vetor);
				window.close();
				return
		}
	catch(e)//Caso houve erro ent�o � mostrado a descri��o do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
	}
//-->
</script>
<%
'[CONEX�O COM O BANCO DE DADOS]
set Conn = Server.CreateObject( "ADODB.Connection" )
Conn.CursorLocation = 3 'adUserClient
Conn.Open application("connstring")

'Fun��o que mostra todos os Exames
Function VisualizarExames

	dim pag
	regs = 25 'Aqui setamos quantos registros ser�o listados por p�gina. 
	pag = request.querystring("pagina")
		if pag = "" Then
		   pag = 1
		end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs

	SQL	=	"Exec BuscaExames '"&Trim(Replace(Request("Tit_Exame"),"'","''"))&"' "
			'clausula = " WHERE  "
			'	if Trim(Request("id")) <> "" Then
			'		sql = sql & clausula & " id = '"&Trim(Replace(Request("id"),"'","''"))&"'  "
			'		clausula = "and "
			'	end if
			'	if Trim(Request("Tit_Exame")) <> "" Then
			'		sql = sql & clausula & " Tit_Exame like '%"&Trim(Replace(Request("Tit_Exame"),"'","''"))&"%'  "
			'		clausula = "and "
			'	end if
			'	sql = sql & "Order By Tit_Exame "
			'Response.Write(sql): Response.End()
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
						Response.Write "<Tr class='Titulo_Tabela'>" & Chr(10)
							Response.Write "<Td>C�digo:</Td>" & Chr(10)
							Response.Write "<Td>Titulo:</Td>" & Chr(10)
							Response.Write "<Td>&nbsp;</Td>" & Chr(10)
						Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If Not Response.IsClientConnected  Then Rs.close : Set Rs = Nothing : Conn.Close : set Conn = nothing  : Response.end 'Verifica se o usuario ainda esta conectado na consulta
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Response.Write "<Tr>" & Chr(10)
							Response.Write "<Td style='Cursor: Pointer;' class='"&zebrado&"'>"&Rs("id")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&Rs("Tit_Exame")&"</Td>" & Chr(10)
							Response.Write "<Td class='"&zebrado&"'>"&"<a href=""javascript:Transfere('"&Rs("id")&"' , '"&Request("Tipo_Busca_Simpro")&"' , '"&Request("Posicao_Vetor")&"'  )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar este m�dico'   ></a>"&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso n�o seja encontrado nenhum registro
					Response.Write "<Table width='100%' border='0'><tr><td align ='center' class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da pagina��o
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para n�i ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&Cod_Simpro="&Request("Cod_Simpro")&"&Descricao="&Request("Descricao")&"&Fabrica="&Request("Fabrica")&"&Tipo_Busca_Simpro="&Request("Tipo_Busca_Simpro")&"&Posicao_Vetor="&Request("Posicao_Vetor")
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

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction
	
	Case Else
%>
	<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_Exames/modelos/Form_Visualizar_Exames.htm" -->
<%
End Select

'[Fecha Conex�o Com Banco De Dados]
Conn.close
set Conn = nothing
%>
