<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 04/03/2005
' Descri��o: Pagina de busca de locais
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<%
'[DELCARA��O DAS VARIAVEIS GLOBAIS]
Dim id,Descricao
'[CONEX�O COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUN��O RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE J� EXISTEM
Function VisualizarDiagnostico

'Somente ira executar se os campos de buscas forem preenchidos, pois senao ira retornar muitos registros e isso causa um pouco de lentid�o na consulta
IF Trim(Replace(Request("Busca"),"'","")) <> "" Or Request("RESTRSEXO") <> "" Then
	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Diagnostico_Visualizar '"&Trim(Replace(Request("Busca"),"'",""))&"' , '' , '"&Request("RESTRSEXO")&"' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Response.Write "<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)
					Response.Write "<Tr class='Tit_Box_Orange'>" & Chr(10)
					Response.Write "<Td>Diagnostico:</Td>" & Chr(10)
					Response.Write "<Td>Restri��o de Sexo:</Td>" & Chr(10)
					Response.Write "</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("RESTRSEXO") = "1" Then RESTRSEXO = "v�lida apenas para homens" Else If  Rs("RESTRSEXO") = "3" Then RESTRSEXO = "v�lida apenas para mulheres" Else If  Rs("RESTRSEXO") = "5" Then RESTRSEXO = "v�lida tanto para homens como para mulheres" End if
						Response.Write "<Tr style='cursor: hand'  onClick=""location.href='default.asp?action=IncluirDiagnostico&id_Diagnostico="&rs("id")&"&id_Atendimento="&Request("id_Atendimento")&"&id_Funcionario_Medico="&Request("id_Funcionario_Medico")&" '"" >" & Chr(10)
						Response.Write "<Td class='"&zebrado&"'>"&Rs("Descricao")&"</Td>" & Chr(10)
						Response.Write "<Td class='"&zebrado&"'>"&RESTRSEXO&"</Td>" & Chr(10)
						Response.Write "</Tr>" 
					Rs.MoveNext
					Next
					Response.Write "</Table>"
				Else 'Caso n�o seja encontrado nenhum registro
					Response.Write "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
End if

End Function

'FUN��O RESPONSEVEL POR INCLUIR OS DIAGNOSTICOS NO ATENDIMENTO
Function IncluirDiagnostico

	SQL = 	"INSERT INTO AtendimentosXDiagnostico (id_atendimento,id_Funcionario_Medico,id_diagnostico) VALUES ( '"&Trim(Replace(Request("id_atendimento"),"'","''"))&"' ,'"&Trim(Replace(Request("id_Funcionario_Medico"),"'","''"))&"' , '"&Trim(Replace(Request("id_diagnostico"),"'","''"))&"'  ) "
			conn.execute(SQL)
			'APOS INCLUIR A PAGINA DE BAIXO � ATUALIZADA
			Response.Write "<Script>window.opener.location.reload();</Script>"
			Response.Write "<script>alert('Diagnostico Incluido Com Sucesso')</script>"
			'APOS A PAGINA DE BAIXO SER ATUALIZADA A PAGINA ATUAL RETORNA PARA A DEFAULT COM O ID DO ATENDIMENTO PARA SER INCLUIDO UM NOVO DIAGBOSTICO
			response.write "<script>location = 'javascript:history.go(-1)' </script>"
				
End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction

	Case "IncluirDiagnostico"
		Call IncluirDiagnostico
			
	Case Else
%>
	<!-- #include virtual="/SmartCare/Bibliotecas/Buscas/Diagnostico/modelos/Form_Visualizar_Diagnostico.htm" -->
<%
End Select

'Fecha Conex�o Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>