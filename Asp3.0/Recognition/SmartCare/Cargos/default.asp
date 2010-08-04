<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Cargos/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 13/01/2005
' Descri��o: Pagina de administra��o de Cargos
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<%
'[DELCARA��O DAS VARIAVEIS GLOBAIS]
Dim id,Cargo
'[CONEX�O COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUN��O RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE J� EXISTEM
Function VisualizarCargos

	SQL	=	"SELECT * From CARGOS Order by Cargo"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatena��o
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>Cargos:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Cargo")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarCargos&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Cargo") & "' , 'ATEN��O !!\nDeseja mesmo excluir o cargo:' , 'default.asp?action=ExcluirCargos&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarCargos = Content

End Function

'FUN��O RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirCargos

	SQL = 	"INSERT INTO CARGOS (Cargo) VALUES ( '"&Trim(Replace(Request("Cargo"),"'","''"))&"'  ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUN��O RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarCargos

	SQL	=	"Select * From CARGOS Where id = "&Cint(Request("id"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id = Rs("id")
				Cargo = Trim(Rs("Cargo"))
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUN��O RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarCargos

	SQL	=	"Update CARGOS SET Cargo= '"&Trim(Replace(Request("Cargo"),"'",""))&"' Where id = "&Cint(Request("id"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUN��O RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirCargos

	SQL	=	"DELETE FROM CARGOS Where id ="&Cint(request("id"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction

	Case "IncluirCargos"
		Call IncluirCargos 'CHAMA A FUN��O QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarCargos"
		Call EditarCargos 'CHAMA A FUN��O QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Cargos/modelos/Form_Editar_Cargos.htm" -->
<%		
	Case "AlterarCargos"
		Call AlterarCargos 'CHAMA A FUN��O QUE IRA ALTERAR
		
	Case "ExcluirCargos"
		Call ExcluirCargos 'CHAMA A FUN��O QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Cargos/modelos/Form_Incluir_Cargos.htm" -->
<%
End Select

'Fecha Conex�o Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

