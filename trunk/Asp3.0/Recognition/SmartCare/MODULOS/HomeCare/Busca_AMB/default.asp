<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Cargos/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 19/07/2007
' Descri��o: Pagina para busca de c�digos AMB
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<script language="javascript">
<!--
//FUN��O QUE TRANSFERE O CONTEUDO DA PAGINA PARA OUTRA PAGINA
function Transfere(Numero) 
	{
	try 
		{ 
				window.opener.document.formCadastro.Cod_AMB.value = Numero; //Envia para o campo da pagina 
				window.opener.CarregaAMB(Numero);
				window.close();
				//return

		}
	catch(e)//Caso houve erro ent�o � mostrado a descri��o do erro
			{ 
				alert(e.descripition); //Descricao do erro
			}
	}
//-->
</script>

<%
'[DELCARA��O DAS VARIAVEIS GLOBAIS]

'[CONEX�O COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUN��O RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE J� EXISTEM
Function Visualizar
	
	If request("Tabela") = "" Then
		Response.Write "<Table width='100%'><tr><td class='texto' align='center'>Selecione uma tabela para que seja feito uma busca</td></tr></table>"
		Response.end
	End if
	dim pag
	regs = 30 'Aqui setamos quantos registros ser�o listados por p�gina. 
	pag = request.querystring("pagina")
	if pag = "" Then pag = 1 end if
	set rs = createobject("adodb.recordset")
	rs.cursortype = 3 'Definimos o cursor a ser utilizado
	rs.pagesize = regs
	RS.CursorLocation = 3 
	
	SQL	=	"SELECT  * From AMB_"&request("Tabela")&" " &_ 
			"Where tbcodDescricao Like '%"&Request("Descricao")&"%' Or tbcodCodTabela = '"&Request("Codigo")&"' " &_ 
			"Order By tbcodCodTabela "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					rs.absolutepage = pag
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >"
					Response.Write "<Tr class='Titulo_Tabela'>"
					Response.Write "<Td>C�digo AMB:</Td>" 
					Response.Write "<Td>Descri��o:</Td>"
					Response.Write "<Td>Qtd. CH:</Td>"
					Response.Write "<Td>Auxiliar:</Td>"
					Response.Write "<Td>&nbsp;</Td>"
					Response.Write "</Tr>"
					For x = 1 To Rs.Pagesize
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Response.Write "<Tr>"
						Response.Write "<Td class='"&zebrado&"'>"&Rs("tbcodCodTabela")&"</Td>"
						Response.Write "<td class='"&zebrado&"'>"&rs("tbcodDescricao")&"</td>"
						Response.Write "<td class='"&zebrado&"'>"&rs("Qtd_CH")&"</td>"
						Response.Write "<td class='"&zebrado&"'>"&rs("tbcodNroAuxiliar")&"</td>"
						Response.Write "<Td class='"&zebrado&"'>"&"<a href=""javascript:Transfere('"&Rs("tbcodCodTabela")&"' )"" ><img src='/SmartCare/images/ico_seta_baixo.gif' border='0' alt='Clique para selecionar este c�digo'   ></a>"&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso n�o seja encontrado nenhum registro
					Response.Write "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
					'Inicio da pagina��o
							'Caso tenha algum campo de busca na pagina coloque aqui o nome dele. Isso foi feito para n�i ter que ficar colocando em varios lugares
							VariaveisBusca = "Action="&Request("action")&"&Tabela="&Request("Tabela")&"&Posicao_Vetor="&Request("Posicao_Vetor")&"&Nome="&Request("Nome")&"&id_Cobertura="&Request("id_Cobertura")&"&id_Departamento="&Request("id_Departamento")&"&id_Cargo="&Request("id_Cargo")&"&id_Disponibilidade="&Request("id_Disponibilidade")&"&id_Especializacao="&Request("id_Especializacao")&"&id_Cor_Pele="&Request("id_Cor_Pele")&"&Sexo="&Request("Sexo")&"  "
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
<!-- #include virtual="/SmartCare/Modulos/HomeCare/Busca_AMB/Modelos/Form_Visualizar.htm" -->
<%
End Select

'Fecha Conex�o Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>


