<link rel="stylesheet" type="text/css" href="/SmartCare/bibliotecas/css/default.css">
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.asp" -->
<!-- #include virtual="/SmartCare/Bibliotecas/Funcoes/Funcoes.js" -->
<!-- #include virtual="/SmartCare/Menu_Categorias/Js/Validacoes.js" -->
<%
' Autor: Fabrizio Gianfratti Manes
' Data: 22/04/2005
' Descri��o: Pagina de administra��o de Categorias dos menus
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<%
'[DELCARA��O DAS VARIAVEIS GLOBAIS]
Dim id,Categoria,Ordem,FlgAtivo,Visibilidade

'[CONEX�O COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUN��O RESPONSAVEL POR VISUALIZAR OS REGISTROS QUE J� EXISTEM
Function VisualizarCategorias

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = "EXEC Menu_Categorias_Visualizar  "
			Rs.open SQL, CONN, 3
				IF not rs.eof then 'Verifica se existem registros
					Content = "" 'Variavel usada para fazer a concatena��o
					Content = Content &_
					"<table width='100%' border='0' cellspacing='0' cellpadding='0' class='borda' >" & Chr(10)&_
						"<Tr class='Titulo_Tabela'>" & Chr(10)&_
							"<Td>ID:</Td>" & Chr(10)&_
							"<Td>Categoria:</Td>" & Chr(10)&_
							"<Td>Ordem:</Td>" & Chr(10)&_
							"<Td>Ativado:</Td>" & Chr(10)&_
							"<Td>Visivel:</Td>" & Chr(10)&_
							"<Td>Editar:</Td>" & Chr(10)&_
							"<Td>Excluir:</Td>" & Chr(10)&_
						"</Tr>"
					For x = 1 To Rs.RecordCount
						If Rs.Eof Then Exit For 'Quando chegar no fim entao exit
						If zebrado = "zebra1" Then zebrado = "zebra2" Else zebrado = "zebra1" End If
						If Rs("FlgAtivo") Then FlgAtivo = "Sim" Else FlgAtivo = "N�o" End If
						If Rs("Visibilidade") Then Visibilidade = "Sim" Else Visibilidade = "N�o" End If
						Content = Content &_
						"<Tr>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("ID")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Categoria")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Rs("Ordem")&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&FlgAtivo&"</Td>" & Chr(10)&_
							"<Td class='"&zebrado&"'>"&Visibilidade&"</Td>" & Chr(10)&_
							"<td class='"&zebrado&"'>"&"<a href='default.asp?action=EditarCategorias&id=" &rs("id")& "'>Editar</a>"&"</td>" & Chr(10) &_ 
							"<Td class='"&zebrado&"'>"&"<a href=""javascript:Confirmar(" & rs("id") & " , '" & rs("Categoria") & "' , 'ATEN��O !!\nDeseja mesmo excluir o Menu:' , 'default.asp?action=ExcluirCategorias&id="&rs("id")&"' )"" >Excluir</a>"&"</td>" & Chr(10) &_ 
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
			VisualizarCategorias = Content

End Function

'FUN��O RESPONSAVEL POR N�O DEIXAR GRAVAR A MESMA ORDEM 2X NO BANCO DE DADOS.
'EXEMPLO 2 CATEGORIAS DISTINTAS TEREM A MESMA ORDEM
Function Verifica_Ordem(Ordem)

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"Select * From Menu_Categorias_Admin Where Ordem = "&Ordem&"  "
			Rs.open SQL, CONN, 3
				
				If Not Rs.Eof Then		
					Categoria = Trim(Rs("Categoria"))
					Response.write "<Script>alert('A ordem de n� "&Rs("Ordem")&" selecionada j� est� em uso para a categoria "&Rs("Categoria")&"  ');</Script>"
					response.write "<script>location = 'javascript:history.go(-1)' </script>"
					Response.end
				End if
				
			Rs.Close
			Set Rs = Nothing


End Function

'FUN��O RESPONSAVEL POR INCLUIR NOVOS REGISTROS
Function IncluirCategorias

	'CHAMA A FUN��O QUE CONTROLA AS ORDENS, PARA NAO GRAVAR ORDENS DO MESMO NUMERO
	Call Verifica_Ordem(Replace(Request("Ordem"),"'",""))
	
	'EXECUTA A PROCEDURE QUE IRA INCLUIR O REGISTRO
	SQL = 	"INSERT INTO Menu_Categorias_Admin (Categoria,Ordem,FlgAtivo,Visibilidade) VALUES ( '"&Trim(Replace(Request("Categoria"),"'",""))&"' , '"&Trim(Replace(Request("Ordem"),"'",""))&"' , '"&Trim(Replace(Request("FlgAtivo"),"'",""))&"' , '"&Trim(Replace(Request("Visibilidade"),"'",""))&"'   ) "
				conn.execute(SQL)
				response.write "<script>location = 'default.asp' </script>"

End Function

'FUN��O RESPONSAVEL POR CARREGAR OS REGISTROS PARA MOSTRAR NO FORMULARIO
Public Function EditarCategorias

	Set RS = Server.CreateObject("ADODB.Recordset")
	RS.CursorLocation = 3 
	'EXECUTA A PROCEDURE QUE IRA RETORNAR OS REGISTROS
	SQL = 	"Select id,Categoria,Ordem,FlgAtivo,Visibilidade From Menu_Categorias_Admin Where id = '"&Replace(Cint(Request("id")),"'","")&"'  "
			Rs.open SQL, CONN, 3
			
				'FAZ O CARREGAMENTO DOS CAMPOS NO BANCO DE DADOS PARA EDI��O DO REGISTRO
				id = Rs("id")
				Categoria = Trim(Rs("Categoria"))
				Ordem = Trim(Rs("Ordem"))
				FlgAtivo = ABS(Rs("FlgAtivo"))
				Visibilidade = ABS(Rs("Visibilidade"))
				
			Rs.Close
			Set Rs = Nothing

End Function

'FUN��O RESPONSAVEL POR ALTERAR REGISTROS
Function AlterarCategorias

	If Request("Ordem_Antiga") <> Request("Ordem") Then
		'CHAMA A FUN��O QUE CONTROLA AS ORDENS, PARA NAO GRAVAR ORDENS DO MESMO NUMERO
		Call Verifica_Ordem(Replace(Request("Ordem"),"'",""))
	End If
	
	'EXECUTA A PROCEDURE QUE IRA ALTERAR O REGISTRO
	SQL	=	"Update Menu_Categorias_Admin SET Categoria = '"&Trim(Replace(Request("Categoria"),"'",""))&"' , Ordem = '"&Trim(Replace(Request("Ordem"),"'","''"))&"' , FlgAtivo = '"&Trim(Replace(Request("FlgAtivo"),"'","''"))&"' , Visibilidade = '"&Trim(Replace(Request("Visibilidade"),"'",""))&"'  Where id = '"&Cint(Request("id"))&"' " 
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'FUN��O RESPONSAVEL POR EXCLUIR REGISTROS
Function ExcluirCategorias

	'EXECUTA A PROCEDURE QUE IRA EXCLUIR O REGISTRO
	SQL = 	"Delete From Menu_Categorias_Admin Where id = '"&Replace(Cint(Request("id")),"'","")&"'  "
			conn.execute(SQL)
			response.write "<script>location = 'default.asp' </script>"

End Function

'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction

	Case "Form_Incluir_Categorias" 
%>
	<!-- #include virtual="/SmartCare/Menu_Categorias/modelos/Form_Incluir_Categorias.htm" -->
<%
	Case "IncluirCategorias"
		Call IncluirCategorias 'CHAMA A FUN��O QUE IRA INCLUIR UM NOVO REGISTRO
		
	Case "EditarCategorias"
		Call EditarCategorias 'CHAMA A FUN��O QUE IRA CARREGAR OS REGISTROS PARA EDITAR O FORMULARIO
%>
	<!-- #include virtual="/SmartCare/Menu_Categorias/modelos/Form_Editar_Categorias.htm" -->
<%		
	Case "AlterarCategorias"
		Call AlterarCategorias 'CHAMA A FUN��O QUE IRA ALTERAR
		
	Case "ExcluirCategorias"
		Call ExcluirCategorias 'CHAMA A FUN��O QUE IRA EXCLUIR
		
	Case Else
%>
	<!-- #include virtual="/SmartCare/Menu_Categorias/modelos/Form_Visualizar_Categorias.htm" -->
<%
End Select

'Fecha Conex�o Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>

