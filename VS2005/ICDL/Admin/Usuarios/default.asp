<!-- #include virtual="/icdl/admin/menu/default.htm" -->
<!-- #include virtual="/icdl/admin/usuarios/js/validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 30/12/2004
' Descri��o: Pagina de administra��o de Usuarios do sistema
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<%
'[DECLARA��O DE VARIAVEIS]
Dim id_Usuario, Usuario_Nome, Usuario_Login, Usuario_Senha

'[CONEX�O COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUN��O RESPONSAVEL POR VISUALIZAR TODAS AS Usuarios CADASTRADAS
Function VisualizarUsuarios

	SQL	=	"SELECT * From Usuarios Order by Usuario_Nome"
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatena��o
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Tit_Box_Orange'>" & Chr(10)&_
							"<Td>Usuarios:</Td>" & Chr(10)&_
							"<Td>Login:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Usuario_Nome")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Usuario_Login")&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarUsuarios&id_Usuario=" &rs("id_Usuario")& "'>Editar</a>"&"</td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id_Usuario") & " , '" & rs("Usuario_Nome") & "' , 'ATEN��O !!\nDeseja mesmo excluir o Usuario:' , 'default.asp?action=ExcluirUsuarios&id_Usuario="&rs("id_Usuario")&"' )"" >Excluir</a>"&"</td>" & Chr(10)&_
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
			VisualizarUsuarios = Content

End Function

'FUN��O RESPONSAVEL POR INCLUIR NOVAS Usuarios
Function IncluirUsuarios

	SQL = 	"INSERT INTO Usuarios (Usuario_Nome,Usuario_Login,Usuario_Senha) VALUES ( '"&Trim(Replace(Request("Usuario_Nome"),"'","''"))&"' , '"&Trim(Replace(Request("Usuario_Login"),"'","''"))&"' , '"&Trim(Replace(Request("Usuario_Senha"),"'","''"))&"' ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function EditarUsuarios

	SQL	=	"Select * From Usuarios Where id_Usuario = "&Cint(Request("id_Usuario"))&" "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
			
				id_Usuario = Rs("id_Usuario")
				Usuario_Nome = Rs("Usuario_Nome")
				Usuario_Login = Rs("Usuario_Login")
				Usuario_Senha = Rs("Usuario_Senha")
				
			Rs.Close
			Set Rs = Nothing

End Function

Function AlterarUsuarios

	SQL	=	"Update Usuarios SET Usuario_Nome = '"&Trim(Replace(Request("Usuario_Nome"),"'",""))&"' , Usuario_Login = '"&Trim(Replace(Request("Usuario_Login"),"'",""))&"' , Usuario_Senha = '"&Trim(Replace(Request("Usuario_Senha"),"'",""))&"'  Where id_Usuario = "&Cint(Request("id_Usuario"))
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

Function ExcluirUsuarios

	SQL	=	"DELETE FROM Usuarios Where id_Usuario ="&Cint(request("id_Usuario"))
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction

	Case "Form_Incluir"
%>
	<!-- #include virtual="/icdl/admin/Usuarios/modelos/form_incluir.htm" -->
<%	
	Case "IncluirUsuarios"
		Call IncluirUsuarios 'CHAMA A FUN��O QUE IRA INCLUIR A NOVA USUARIOS
		
	Case "EditarUsuarios"
		Call EditarUsuarios 'CHAMA A FUN��O QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/icdl/admin/Usuarios/modelos/form_editar.htm" -->
<%		
	Case "AlterarUsuarios"
		Call AlterarUsuarios 'CHAMA A FUN��O QUE IRA ALTERAR A USUARIOS
		
	Case "ExcluirUsuarios"
		Call ExcluirUsuarios 'CHAMA A FUN��O QUE IRA EXCLUIR A USUARIOS
		
	Case Else
%>
	<!-- #include virtual="/icdl/admin/Usuarios/modelos/form_Visualizar.htm" -->
<%
End Select

'Fecha Conex�o Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>