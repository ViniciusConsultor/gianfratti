<%



s = request.servervariables("REMOTE_ADDR")
IP	= Left(S,3)



Response.Write(IP)


If IP = "192" Then
	Response.Write("Endere�o Interno"
Else
	Response.Write("Endere�o Externo")
End If



%>