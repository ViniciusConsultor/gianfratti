<table cellpadding='0' cellspacing='0' width='100%' align='center' border='0'>
	<tr>
		<td>
			<table cellpadding='0' cellspacing='0' width='600' height='18' border='0' onselectstart="return false">
				<tr>
					<td width='10' class='BordaPretoBottomSolid'>&nbsp;</td>
					<td align='center' width='80' <% If opcao=1 Then %>class='BordaPretaMenu1'<% Else %>class='BordaPretaMenu2' onMouseOver="this.className='BordaPretaMenu2Over'" onMouseOut="this.className='BordaPretaMenu2'"<% End if %> onclick='location.href("../grupos/p_grupos.asp?opcao=1&acao=1");'>CADASTRAR</td>
					<td align='center' width='80' <% If opcao=2 Then %>class='BordaPretaMenu1'<% Else %>class='BordaPretaMenu2' onMouseOver="this.className='BordaPretaMenu2Over'" onMouseOut="this.className='BordaPretaMenu2'"<% End if %> onclick='location.href("../grupos/p_grupos.asp?opcao=2&acao=1");'>ALTERAR</td>
					<td align='center' width='80' <% If opcao=3 Then %>class='BordaPretaMenu1'<% Else %>class='BordaPretaMenu2' onMouseOver="this.className='BordaPretaMenu2Over'" onMouseOut="this.className='BordaPretaMenu2'"<% End if %> onclick='location.href("../grupos/p_grupos.asp?opcao=3&acao=1");'>EXCLUIR</td>
					<td align='center' width='80' <% If opcao=4 Then %>class='BordaPretaMenu1'<% Else %>class='BordaPretaMenu2' onMouseOver="this.className='BordaPretaMenu2Over'" onMouseOut="this.className='BordaPretaMenu2'"<% End if %> onclick='location.href("../grupos/p_grupos.asp?opcao=4&acao=1");'>LISTAR</td>
					<td align='center' width='230' <% If opcao=5 Then %>class='BordaPretaMenu4'<% Else %>class='BordaPretaMenu3' onMouseOver="this.className='BordaPretaMenu3Over'" onMouseOut="this.className='BordaPretaMenu3'"<% End if %> onclick='location.href("../grupos/p_grupos.asp?opcao=5&acao=1");'>ADICIONAR CONTATOS AO GRUPO</td>
				</tr>
			</table>
		</td>
		<td width='100%' class='BordaPretoBottomSolid'>&nbsp;</td>
	</tr>
</table>