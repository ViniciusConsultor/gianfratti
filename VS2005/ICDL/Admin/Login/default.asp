<%
' Autor: Fabrizio Gianfratti Manes
' Email: fabrizio@gianfratti.con	
' Data: 20/01/2005
' Descri��o: Pagina de Login de Usuarios do sistema
' Atualizado por: -
' Data: -
' Atualiza��o: -
%>
<%
'[CONEX�O COM O BANCO DE DADOS]
set conn=server.createobject("adodb.connection")
conn.open application("connstring")

'FUN��O RESPONSAVEL POR FAZER A VERIFICACAO SE O USUARIO � VALIDO OU NAO
Function Login

	SQL	=	"SELECT * From Usuarios Where usuario_login = '"&Replace(Request("usuario"),"'","")&"' and  usuario_senha = '"&Replace(Request("senha"),"'","")&"' "
			Set rs = server.createobject("adodb.recordset")
			Rs.open SQL, CONN, 3
				IF Not rs.eof then 'Verifica se o usuario existe
					Session("Logado") = True 'CASO FOR VALIDO ENTAO LIBERA 
					Response.Write "<script>location = '../categorias/default.asp' </script>"
					Response.end	
					Else
						Session("Logado") = False 'CASO NAO FOR VALIDO N�O LIBERA
						Response.Write "<script>alert('Usuario ou Senha Invalidos')</script>"
						Response.Write "<script>location = '"&Request("pagina_retorno")&"' </script>"
						Response.end
				End if
			Rs.Close
			Set Rs = Nothing

End Function

'Fun��o responsavel por deslogar o usuario
Function Logof

	Session("Logado") = False
	Response.Write "<script>location = '../../' </script>" 'Envia para a pagina principal do site

End Function


'USAMOS CASES PARA MANUPULARAS CHAMADAS DAS FUN��ES
useraction=request("action")
select case useraction

	Case "Login"
		Call Login 'CHAMA A FUN��O QUE IRA VEIRIFICAR SE O USUARIO � VALIDO
	
	Case "Logof"
		Call Logof
		
End Select

'Fecha Conex�o Com Banco De Dados
Conn.Close
Set Conn = Nothing
%>