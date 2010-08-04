<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Cobertura/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 17/01/2005
' Descri��o: Pagina de administra��o de �reas de Coberturas que os M�dicos iram atender
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<%
'[DELCARA��O DAS VARIAVEIS GLOBAIS]
Dim id,Nome
'[CONEX�O COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUN��O RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE J� EXISTEM
Function VisualizarCobertura

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC dbo.Cobertura_Visualizar '' , '' "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatena��o
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Cobertura:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Nome")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarCobertura&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Nome") & "' , 'ATEN��O !!\nDeseja mesmo excluir a cobertura:' , 'default.asp?action=ExcluirCobertura&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
						"</Tr>" 
					Rs.MoveNext
					Next
					Content = Content &_
					"</Table>"
				Else 'Caso n�o seja encontrado nenhum registro
					Content = Content & "<Table><tr><td class='erro' >Nenhum Registro Encontrado</td></tr></Table>"
				End if
			Rs.Close
			Set Rs = Nothing
			VisualizarCobertura = Content

End Function

'FUN��O RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirCobertura

	SQL = 	"INSERT INTO COBERTURA (Nome) VALUES ( '"&Trim(Replace(Request("Nome"),"'","''"))&"'  ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUN��O RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarCobertura

	SQL	=	"Select * From COBERTURA Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				Nome = Trim(Rs("Nome"))
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUN��O RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarCobertura

	SQL	=	"Update COBERTURA SET Nome= '"&Trim(Replace(Request("Nome"),"'",""))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUN��O RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirCobertura

	SQL	=	"DELETE FROM COBERTURA Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction

	Case "IncluirCobertura"
		Call IncluirCobertura 'CHAMA A FUN��O QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarCobertura"
		Call EditarCobertura 'CHAMA A FUN��O QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Cobertura/modelos/Form_Editar_Cobertura.htm" -->
<%		
	Case "AlterarCobertura"
		Call AlterarCobertura 'CHAMA A FUN��O QUE IRA ALTERAR
		
	Case "ExcluirCobertura"
		Call ExcluirCobertura 'CHAMA A FUN��O QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Cobertura/modelos/Form_Incluir_Cobertura.htm" -->
<%
End Select

'Fecha Conex�o Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

