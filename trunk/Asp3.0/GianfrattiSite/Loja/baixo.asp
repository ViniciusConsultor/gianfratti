<% 
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################
'#
'#  C�DIGO: VirtuaStore Vers�o OPEN - Copyright 2001-2004 VirtuaStore
'#  URL: http://comunidade.virtuastore.com.br
'#  E-MAIL: comunidade@virtuastore.com.br
'#  AUTORES: Ot�vio Dias(Desenvolvedor)
'# 
'#     Este programa � um software livre; voc� pode redistribu�-lo e/ou 
'#     modific�-lo sob os termos do GNU General Public License como 
'#     publicado pela Free Software Foundation.
'#     � importante lembrar que qualquer altera��o feita no programa 
'#     deve ser informada e enviada para os criadores, atrav�s de e-mail 
'#     ou da p�gina de onde foi baixado o c�digo.
'#
'#  //-------------------------------------------------------------------------------------
'#  // LEIA COM ATEN��O: O software VirtuaStore OPEN deve conter as frases
'#  // "Powered by VirtuaStore OPEN" ou "Software derivado de VirtuaStore 1.2" e 
'#  // o link para o site http://comunidade.virtuastore.com.br no cr�ditos da 
'#  // sua loja virtual para ser utilizado gratuitamente. Se o link e/ou uma das 
'#  // frases n�o estiver presentes ou visiveis este software deixar� de ser
'#  // considerado Open-source(gratuito) e o uso sem autoriza��o ter� 
'#  // penalidades judiciais de acordo com as leis de pirataria de software.
'#  //--------------------------------------------------------------------------------------
'#      
'#     Este programa � distribu�do com a esperan�a de que lhe seja �til,
'#     por�m SEM NENHUMA GARANTIA. Veja a GNU General Public License
'#     abaixo (GNU Licen�a P�blica Geral) para mais detalhes.
'# 
'#     Voc� deve receber a c�pia da Licen�a GNU com este programa, 
'#     caso contr�rio escreva para
'#     Free Software Foundation, Inc., 59 Temple Place, Suite 330, 
'#     Boston, MA  02111-1307  USA
'# 
'#     Para enviar suas d�vidas, sugest�es e/ou contratar a VirtuaWorks 
'#     Internet Design entre em contato atrav�s do e-mail 
'#     contato@virtuaworks.com.br ou pelo endere�o abaixo: 
'#     Rua Ven�ncio Aires, 1001 - Niter�i - Canoas - RS - Brasil. Cep 92110-000.
'#
'#     Para ajuda e suporte acesse um dos sites abaixo:
'#	   http://comunidade.virtuastore.com.br
'#	   http://br.groups.yahoo.com/group/virtuastore
'#
'#     BOM PROVEITO!          
'#     Equipe VirtuaStore
'#     []'s
'#
'#########################################################################################
'#----------------------------------------------------------------------------------------
'#########################################################################################

'IN�CIO DO C�DIGO

'Este c�digo est� otimizado e roda tanto em Windows 2000/NT/XP/ME/98 quanto em servidores UNIX-LINUX com chilli!ASP
%>
	  </td></tr></table>
	</table>
		

<!-- ////   Sombra do Rodape -->


<!-- ////   Fim da Sombra do Rodape -->


<!--   /////   Rodape    -->


<TABLE cellSpacing=0 cellPadding=0 width="780" bgColor=#f0f0f0 border=0>
  <TBODY>
  <TR>
    <TD align=middle><IMG height=3 
      src="<%= dirlingua %>/imagens/spacer_1x1.gif" width=1 border=0><BR>
      <TABLE cellSpacing=0 cellPadding=2 width="50%" border=0>
        <TBODY>
        <TR>
          <TD align="center"><a href="default.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg4%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg4%></font></a><SPAN 
            > | </SPAN>
<%
Set menui = abredb.Execute("SELECT * FROM sessoes WHERE ver='s' ORDER by nome;")
While Not menui.EOF%>
	  	  				<a href="sessoes.asp?item=<%= menui("id") %>"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%= menui("nome") %>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%= menui("nome") %></font></a> <SPAN> | </SPAN>
<%menui.MoveNext
Wend
menui.Close
Set menui = Nothing%> 
</TD></TR><TR>
          <TD noWrap align="center">
		  <br>
		  <a href="quemsomos.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg20%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg20%></font></a><SPAN > | </SPAN>
			<a href="seguranca.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg19%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg19%></font></a><SPAN 
            > | </SPAN>
			<a href="como.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg16%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg16%></font></a><SPAN 
            > | </SPAN>
			<a href="carrinhodecompras.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg51%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg51%></font></a><SPAN 
            > | </SPAN>
			<a href="<%=link%>"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg8%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg8%></font></a><SPAN 
            > | </SPAN><a href="registro.asp"  onMouseOut="window.status='';return true;" onMouseOver="window.status='<%=strLg5%>';return true;"><FONT 
                        face="verdana, arial, helvetica" color=#0000ff 
                        size=1><%=strLg5%></font></a>
			<SPAN ></SPAN></TD></TR></TBODY></TABLE>
     <br></TD></TR></TBODY></TABLE>



<!-- ////   Sombra do Rodape -->


<!-- ////   Fim da Sombra do Rodape -->
			
<TABLE cellSpacing=0 cellPadding=0 width="780" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#ffffff><div align="center"><img src="fundo_baixo.jpg" width="778" height="27" /></div></TD>
  </TR></TBODY></TABLE>
			

<!-- ////   Sombra da Barra de Botoes -->


<TABLE cellSpacing=0 cellPadding=0 width="780" border=0>
  <TBODY>
  <TR>
    <TD bgColor=#808080><IMG height=1 
      src="<%= dirlingua %>/imagens/spacer.gif" width=1></TD></TR></TBODY></TABLE>

<!-- ////   Fim da Sombra da Barra de Botoes -->

			
<TABLE cellSpacing=0 cellPadding=0 width="780" bgColor=<%= Cor_principal%> border=0>
  <TBODY>
  <TR>
    <TD align=middle><IMG height=3 
      src="<%= dirlingua %>/imagens/spacer_1x1.gif" width=1 border=0><BR>
      <TABLE cellSpacing=0 cellPadding=2 width="50%" border=0>
        <TBODY>
        <TR>
          <TD noWrap align="center"> 
<font size="1" color="#ffffff"><%= nomeloja %> - <%= Slogan_da_sua_loja %>
<br>
VirtuaStore Open 3.0 &nbsp;| &nbsp;<�ll BaixoC()%> &nbsp;| &nbsp;<�ll BaixoComunidade() %></font><br><br>
</TD></TR></TBODY></TABLE>
      </TD></TR></TBODY></TABLE>
			
			


<!--   /////   Fim do Rodape    -->
	

<%
'Fecha o banco de bados
abredb.close
set abredb = nothing
%>
