<%@ Page Language="C#" MasterPageFile="~/Template/TemplateEmpresa.master" AutoEventWireup="true" CodeFile="DescricaoCirurgicaPreenchido.aspx.cs" Inherits="DescricaoCirurgica_DescricaoCirurgica" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<fieldset>
		<legend align="center">Descri��o Cirurgica</legend>
        <fieldset>
            <legend>Dados Paciente</legend>
            <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
             <tr>
              <td width="30%">Nome do Paciente </td>
              <td width="25%">Registro Geral </td>
              <td width="15%">Quarto/Leito</td>
              <td width="25%">Data</td>
             </tr>
              <tr>
                <td>
                    Maria da Silva</td>
               <td>
                   111 111</td>
             <td>
                 702</td>
             <td>
                 20/11/2007</td>
             </tr>
            </table>
         <table class="texto" width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="30%">N&ordm; Atendimento </td>
            <td width="25%">Cor</td>
            <td width="15%">Idade</td>
            <td width="25%">Sexo</td>
          </tr>
          <tr>
            <td>
                3450</td>
            <td>
                parda</td>
            <td>
                61</td>
            <td>
                Fem</td>
          </tr>
        </table>
        </fieldset>      
		<fieldset>
			<legend>Descri��o</legend>
    	    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
				<tr>
				  <td>
                      DDH<br />
                      Incisao obliqua flanco esquerdo e fossa iliaca esquerda
                      <br />
                      Acesso retroperitonial
                      <br />
                      Dissec��o da art�ria e veia il�aca externa
                      <br />
                      Anastomose termino-lateral da art�ria do rim com art�ria e veia il�aca externa
                      <br />
                      Anastomose do ureter na bexiga tipo Gregoir
                      <br />
                      Hemostasia Fechamento por planos</td>
				</tr>
			</table>
		</fieldset>
		<fieldset>
		    <legend>Equipe M�dica</legend>
		    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="texto">
		        <tr>
		            <td>
                        Equipe 1: Dr Fausto Miranda Jr
                        <br />
                        Equipe 2: Dr Jose C Baptista
                        <br />
                        Equipe 3: Dr Mario
                        <br />
                        Equipe 4: Dr Claudio</td>
		        </tr>
		    </table>
		</fieldset>
	</fieldset>
</asp:Content>

