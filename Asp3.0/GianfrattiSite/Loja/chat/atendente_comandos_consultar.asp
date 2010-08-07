<%
'******************************************************************
'  Suporte Online SuperAsp 1.0 - SuperASP.com.br - Ano 2003
'  Autor: Fabiano Dias - fdmail@ibest.com.br
'******************************************************************
'
'       DIREITOS AUTORIAIS DO SUPORTE ONLINE SUPERASP
'
'  Voc� n�o pode revender este script, alugar, disponibilizar  para
'  download ou fazer qualquer outro tipo  de  redistribui��o  sem a
'  nossa autoriza��o.
'
'  Este c�digo de programa��o usa uma t�cnica de criptografia,  que
'  identifica sua autoria, ou seja, alterar este c�digo ou revender
'  o mesmo sem contatar o autor significa estar infrigindo todas as
'  leis de direitos autorais e intelectuais,  e como tal passivo de
'  todas as aplica��es na forma da lei.
'
'******************************************************************

'N�mero total de registros a serem exibidos por p�gina
Const RegPorPag = 4

'N�mero de p�ginas a ser exibido no �ndice de pagina��o
VarPagMax = 10

'Cor da linha selecionada na tabela de registros
cor_linha_selecionada = "gainsboro"

atendente = Trim(Request.QueryString("atendente"))

If atendente <> "" Then
%>

<HTML>
<HEAD>
<TITLE>Consultar Registros</TITLE>
<meta name="copyright" content="Dataform">
<meta name="keywords" content="dataform, asp dataform, aspdataform, asp-dataform">
<meta name="robots" content="ALL">
<style type="text/css">
<!--
.texto_pagina
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
color: dimgray;
}

.tabela_registros
{
width: 100%;
background-color: white;
}

.titulos_registros
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
color: white;
background-color: gray;
}

.exibe_registros
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
width: 100%;
color: dimgray;
background-color: whitesmoke;
}

.tabela_paginacao
{
font-family: Tahoma, Verdana, Arial;
font-size: 11px;
width: 100%;
color: gray;
border-top: 1px solid gainsboro;
background-color: white;
}

.links_paginacao
{
color: dimgray;
text-decoration: none;
}

.links_paginacao:hover
{
color: gray;
text-decoration: underline;
}
a{
color: blue;
}
-->
</style>
<SCRIPT language="JavaScript">
<!--
function abre_foto(width, height, nome) {
  var top; var left;
  top = ( (screen.height/2) - (height/2) )
  left = ( (screen.width/2) - (width/2) )
  window.open('',nome,'width='+width+',height='+height+',scrollbars=yes,toolbar=no,location=no,status=no,menubar=no,resizable=no,left='+left+',top='+top);
}
function confirm_delete(form) {
  if (confirm("Tem certeza que deseja excluir este comando?")) {
	document[form].action = '<%=Request.ServerVariables("SCRIPT_NAME")%>?atendente=<%=atendente%>';
	document[form].submit();
  }
}
//-->
</SCRIPT>
</HEAD>
<BODY class=texto_pagina>
<a href="atendente_comandos_consultar.asp?atendente=<%=atendente%>" class="texto_pagina"><img src="imagens/bt_consultarcomandos.gif" width="129" height="25" border="0" align="absmiddle"></a> 
| <a href="atendente_comandos_incluir.asp?atendente=<%=atendente%>" class="texto_pagina"><img src="imagens/bt_adicionarcomando.gif" width="129" height="25" border="0" align="absmiddle"></a> 
<hr size=1 color=gainsboro><br> 

<%
If Request.QueryString("PagAtual") = "" Then
  PagAtual = 1
  NumPagMax = VarPagMax
Else
  NumPagMax = CInt(Request.QueryString("NumPagMax"))
  PagAtual = CInt(Request.QueryString("PagAtual"))
  Select Case Request.QueryString("Submit")
    Case "Anterior" : PagAtual = PagAtual - 1
    Case "Proxima" : PagAtual = PagAtual + 1
    Case "Menos" : NumPagMax = NumPagMax - VarPagMax
    Case "Mais" : NumPagMax = NumPagMax + VarPagMax
    Case Else : PagAtual = CInt(Request.QueryString("Submit"))
  End Select
  If NumPagMax < PagAtual then
    NumPagMax = NumPagMax + VarPagMax
  End If
  If NumPagMax - (VarPagMax - 1) > PagAtual then
    NumPagMax = NumPagMax - VarPagMax
  End If
End If

Set objCon = Server.CreateObject("ADODB.Connection")
objCon.Open Application("SOS_conexao")

  If Request.Form("recordno") <> "" Then
    Set objRS_delete = Server.CreateObject("ADODB.Recordset")
    objRS_delete.CursorLocation = 3
    objRS_delete.CursorType = 0
    objRS_delete.LockType = 3

    strQ_delete = Request.Form("strQ")
    indice = Trim(Request.Form("indice"))
    If indice <> "" Then strQ_delete = " SELECT * FROM comandos WHERE " & indice

    objRS_delete.Open strQ_delete, objCon, , , &H0001
    If indice = "" Then objRS_delete.Move Request.Form("recordno") - 1
    If Not objRS_delete.EOF Then
      objRS_delete.Delete
      objRS_delete.UpdateBatch
    End IF

    objRS_delete.Close
    Set objRS_delete = Nothing
    Set strQ_delete = Nothing
  End If

Set objRS = Server.CreateObject("ADODB.Recordset")
objRS.CursorLocation = 3
objRS.CursorType = 2
objRS.LockType = 1
objRS.CacheSize = RegPorPag
strQ = "SELECT * FROM comandos WHERE atendente = " & atendente

If Trim(Request("string_busca")) <> "" Then
  If Trim(Request("campo_busca")) <> "" Then
    strQ = strQ & " AND " & Trim(Request("campo_busca")) & " LIKE '%" & Trim(Request("string_busca")) & "%'"
  Else
    strQ = strQ & " AND ( tipo LIKE '%" & Trim(Request("string_busca")) & "%'"
    strQ = strQ & " Or descricao LIKE '%" & Trim(Request("string_busca")) & "%'"
    strQ = strQ & " Or atendente LIKE '%" & Trim(Request("string_busca")) & "%'"
    strQ = strQ & " Or valor LIKE '%" & Trim(Request("string_busca")) & "%')"
  End If
End If

If Trim(Request.QueryString("Ordem")) <> "" Then
  strQ = strQ & " ORDER BY " & Request.QueryString("Ordem")
End If
objRS.Open strQ, objCon, , , &H0001
objRS.PageSize = RegPorPag

Set objRS_indice = Server.CreateObject("ADODB.Recordset")
objRS_indice.CursorLocation = 2
objRS_indice.CursorType = 0
objRS_indice.LockType = 2
strQ_indice = "SELECT * FROM comandos WHERE atendente = " & atendente
objRS_indice.Open strQ_indice, objCon, , , &H0001
indice = ""
For Each item In objRS_indice.Fields
  If item.properties("IsAutoIncrement") = True Then
    indice = item.name
    Exit For
  End If
Next
objRS_indice.Close
Set objRS_indice = Nothing
Set strQ_indice = Nothing

Set objRS.ActiveConnection = Nothing
objCon.Close
Set objCon = Nothing
%>
<B><font color="#CC0000">Comandos</font></B><BR>
Abaixo minha lista de comandos:<BR>
<br>

<%
If Not(objRS.EOF) Then
  objRS.AbsolutePage = PagAtual
  TotPag = objRS.PageCount
%>

<TABLE class=tabela_registros  border='1' cellspacing='0' cellpadding='2' bordercolor=silver>
  <TR class=titulos_registros>

<%
  Response.Write "<TD align=""center"" style=""color: white"" width=""1%"" nowrap><b>Editar</b></TD>"

If Right(Request.QueryString("Ordem"), 3) = "asc" Then
  Ordem = "desc"
Else
  Ordem = "asc"
End IF
%>

  <TD style="cursor: hand" valign=top nowrap onClick="window.open('<%=Request.ServerVariables("SCRIPT_NAME")%>?atendente=<%=atendente%>Ordem=descricao+<%=Ordem%>', '_self')"><%If Left(Request.QueryString("Ordem"), 9) = "descricao" Then : Response.Write "<img src=""imagens\ordem_" & Ordem & ".gif"" width=9 height=10>&nbsp;" : End If%><b>Descricao</b></TD>
  <TD width=30% style="cursor: hand" valign=top nowrap onClick="window.open('<%=Request.ServerVariables("SCRIPT_NAME")%>?atendente=<%=atendente%>Ordem=tipo+<%=Ordem%>', '_self')"><%If Left(Request.QueryString("Ordem"), 4) = "tipo" Then : Response.Write "<img src=""imagens\ordem_" & Ordem & ".gif"" width=9 height=10>&nbsp;" : End If%><b>Comando</b></TD>
  <TD width=5% valign=top nowrap><b>Testar</b></TD>
  </TR>

<%
For Cont = 1 to objRS.PageSize
%>

  <TR class=exibe_registros onMouseOver="this.style.backgroundColor='<%=cor_linha_selecionada%>';" onMouseOut="this.style.backgroundColor='';">

<%
  Response.Write "<FORM name=""form_edit_" & Cont & """ action='atendente_comandos_alterar.asp?atendente=" & atendente & "' method=post>"
  Response.Write "<TD  align=""center"" nowrap style=""background-color: gainsboro""  nowrap>&nbsp;"
  If indice <> "" Then Response.Write "<input type=""hidden"" name=""indice"" value=""" & indice & "=" & objRS.Fields.Item(indice).Value & """>"
  Response.Write "<INPUT type=hidden name=recordno value=""" & (objRS.AbsolutePosition) & """>"
  Response.Write "<INPUT type=hidden name=strQ value=""" & strQ & """>"
  Response.Write "<INPUT type=image src=""imagens\edit.gif"" alt=""Alterar Registro"" name=alterar value=alterar>"
  Response.Write "&nbsp;<IMG src=""imagens\delete.gif"" alt=""Excluir Registro"" name=delete border=0 style=""cursor:hand"" OnClick=""confirm_delete('form_edit_" & Cont & "')"">"
  Response.Write "&nbsp;</TD>"
  Response.Write "</FORM>"
%>

    <TD><font color='#3E6497'><b><%=(objRS.Fields.Item("descricao").Value)%></b></font></TD>
    <TD>
	<%
	Select Case objRS.Fields.Item("tipo").Value
	Case 1 : Response.Write "Mensagem"
	Case 2 : Response.Write "Imagem"
	Case 3 : Response.Write "Link"
	Case 4 : Response.Write "Abrir Janela"
	End Select
	%>
	</TD>
    <TD><a href="comandos_testar.asp?id=<%=(objRS.Fields.Item("id").Value)%>" target="_blank">Executar</a></TD>
  </TR>

<%
  objRS.MoveNext
  If objRS.Eof then Exit For
Next
Set Cont = Nothing
%>

</TABLE>

<%
  LinksNavegacao()
  objRS.Close
  Set objRS = Nothing
Else
%>

<B>Nenhum comando foi adicionado</B><BR><BR>

<%
End If
%>

</BODY>
</HTML>

<%
Sub LinksNavegacao()
'O c�digo a seguir insere uma tabela com todos os links de navega��o das p�ginas
Response.Write "<TABLE border=0 cellPadding=2 cellSpacing=0 class=tabela_paginacao>"
Response.Write "<TR><TD align=center vAlign=top noWrap colspan=5>"
Response.Write "P�gina " & PagAtual & " de " & TotPag
Response.Write "</TD></TR><TR><TD width=33% align=right vAlign=top noWrap>"
If PagAtual > 1 Then
  Response.Write "<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?atendente=" & atendente & "&PagAtual=" &  PagAtual &"&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax & "&Submit=Anterior&Ordem=" & Request.QueryString("Ordem")& "&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca"))  & """ class=links_paginacao>&lt; Anterior</A>"
End If
Response.Write "</TD><TD width=33% align=middle vAlign=top noWrap>"
If NumPagMax - VarPagMax <> 0 then
  Response.Write "&nbsp;<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?atendente=" & atendente & "&PagAtual=" & NumPagMax - VarPagMax & "&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax - VarPagMax & "&Submit=Menos&Ordem=" & Request.QueryString("Ordem") & "&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca")) & """ class=links_paginacao>&lt;&lt;</A>&nbsp;&nbsp;"
End If
for i = NumPagMax - (VarPagMax - 1) to NumPagMax
  If i <= TotPag then
    If i <> CInt(PagAtual) then
      Response.Write "&nbsp;<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?atendente=" & atendente & "&PagAtual=" & PagAtual & "&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax & "&Submit=" & i & "&Ordem=" & Request.QueryString("Ordem") & "&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca")) & """ class=links_paginacao>" & i & "</A>&nbsp;"
    Else
      If PagAtual <> TotPag Then
        Response.Write "&nbsp;" & i & "&nbsp;"
      End If
    End If
  End If
Next
If NumPagMax  < TotPag then
  Response.Write "&nbsp;&nbsp;<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?atendente=" & atendente & "&PagAtual=" & NumPagMax + 1 & "&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax + VarPagMax & "&Submit=Mais&Ordem=" & Request.QueryString("Ordem") & "&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca")) & """ class=links_paginacao>&gt;&gt;</A>"
End If
Response.Write "</TD><TD width=33% align=left vAlign=top noWrap>"
If PagAtual <> TotPag Then
  Response.Write "&nbsp;&nbsp;<A href=""" & Request.ServerVariables("SCRIPT_NAME") & "?atendente=" & atendente & "&PagAtual=" & PagAtual & "&VarPagMax=" & VarPagMax & "&NumPagMax=" & NumPagMax & "&Submit=Proxima&Ordem=" & Request.QueryString("Ordem") & "&string_busca=" & Server.URLEncode(Request("string_busca")) & "&campo_busca=" & Server.URLEncode(Request("campo_busca")) & """ class=links_paginacao>Proxima &gt;</A>"
End If
Response.Write "</TD></TR></TABLE>"
End Sub

End If
%>