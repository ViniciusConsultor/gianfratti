<%
If opcao=1 then
	opcao=1
	acao=2
Elseif opcao=2 Then
	opcao=2
	acao=3
End if
%>
<table id="Cliente" cellpadding="0" cellspacing="0" width="98%" border="0">
	<tr>
		<td valign="top">

			<fieldset>
			<legend> &nbsp;DADOS DO USU�RIO&nbsp;</legend>
			<table cellpadding="2" cellspacing="2" width="550" border="0">
				<tr>
					<td colspan="2"><img src="../Shared/img/spacer.gif" width="1" height="10"></td>
				</tr>
				<tr>
					<td align="right">C�digo do Usu�rio:</td>
					<td width="70%"><b><% =Usuario_CD %></b></td>
				</tr>
				<tr>
					<td align="right">Nome do Usu�rio:</td>
					<td><b><% =Usuario_NM %></b></td>
				</tr>
				<tr>
					<td align="right">E-mail do Usu�rio:</td>
					<td><b><% =Usuario_eMail %></b></td>
				</tr>
				<tr>
					<td align="right">Login do Usu�rio:</td>
					<td><b><% =Usuario_Login %></b></td>
				</tr>
				<tr>
					<td colspan="2" height="10">&nbsp;</td>
				</tr>
				
			</table>
			</fieldset>

		</td>
	</tr>
	<tr>
		<td height="10">&nbsp;</td>
	</tr>
</table>