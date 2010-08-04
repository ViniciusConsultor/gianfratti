
PamellaGridClass v1.2
=====================
Classe para exibi��o de recordset, com recursos de pagina��o e pesquisa.
Desenvolvido por Rubens Farias (rubensf@bigfoot.com) em Dez/2000.
Caso interesse algu�m, "Pamella" ser� o nome de minha filha, que nascer� em Mar/2001 :)

Vale o de sempre:

 - Esta classe foi desenvolvida para uso pessoal. O uso comercial � *vedado*,
   sem a pr�via autoriza��o do autor.  Isso  significa  que  voc�  n�o  pode
   comercializar esta classe ou incorpor�-la em nenhum projeto comercial.

 - O autor n�o pode ser responsabilizado pela utiliza��o correta ou incorreta
   desta classe. Em caso de d�vidas, n�o a use.

 - Cart�es postais s�o bem vindos. Caso possa enviar-me um cart�o postal de sua
   regi�o, contacte-me por email, para que eu possa passar o endere�o.

 - Sugest�es/coment�rios s�o altamente bem vindos. Caso tenha gostado,
   n�o hesite em enviar-me um email.


Propriedades:
-------------

 cSQL                    : SQL a ser executado
 nMaxRows                : N�mero m�ximo de registros por p�gina. Default 15.
 oConnection             : Conex�o com o banco de dados
 oRecordset              : Recordset, definido com o pelo par�metro cSQL ou passado
 bDestroyRecordset       : Indica se o recordset ser� destruido ao final. Default true.

 cFormName               : Nome do formul�rio (uso futuro). Default "form".
 cFormAttribs            : Propriedades da tag <FORM>*

 cTableAttribs           : Atributos da tag <TABLE>*
 cPageBrowserAttribs     : Atributos da tag <SELECT>*

 cHeaderLabel            : T�tulo da tabela, inserido entre <THs>*.
                           Default "PamellaGridClass Demo"
 cHeaderAttribs          : Atributos da tag <TR> com o cabe�alho*
 cFooterAttribs          : Atributos da tag <TR> com o rodap� (pagina��o)*
 
 cEvenRowAttribs         : Atributo das linhas �mpares, na tag <TR>*
 cOddRowAttribs          : Atributo das linhas pares, na tag <TR>*
 
 cNextLabel              : Texto que ser� inclu�do na tag <A>,
                           indicando pr�xima p�gina. Default "Next".
 cNextAttribs            : Atributos da tag <A> para a pr�xima p�gina*
 
 cPreviousLabel          : Idem acima, para a p�gina anterior. Default "Previous".
 cPreviousAttribs
 
 cOrderAttribs           : Idem, com os atributos dos links de ordena��o do recordset

 bCanSearch              : Valor l�gico, indicando se o recordset pode ser pesquisado.
                           Default false.
 cSearchButtonAttribs    : Atributos da tag <INPUT TYPE=Button>*
 cSearchButtonLabel      : Texto do bot�o da pesquisa (VALUE=""). Default "Search!".
 cSearchTextAttribs      : Atributos da tag <INPUT TYPE=Text>*
 cSearchOperatorsAttribs : Atributos do <SELECT> com os operadores de pesquisa*
 cSearchFieldsAttribs    : Atributos do <SELECT> com os campos a serem pesquisados*
 
 Keys                    : Chaves para execu��o da classe. Recebe uma array com at� cinco
                           chaves para identifica��o da vers�o comercial. Caso nenhuma
                           seja v�lida, uma mensagem indicando que se trata de uma vers�o
                           de demonstra��o � exibida. Esta � a �nica diferen�a entre a
                           vers�o comercial da demo. A chave que � distribu�da neste demo
                           sup�e que o nome do servidor seja "localhost".
 Version                 : Retorna a vers�o atual da classe (read-only)


* Quando � dito "atributos da tag", significa que �  permitida a utiliza��o de  quaisquer
  propriedades da tag (class, border, bgcolor, etc), n�o sendo feita nenhuma consist�ncia
  nestes valores, uma vez que s�o dependentes da vers�o do HTML que est� sendo processada.
  Assim, o programador precisa preocupar-se com a  compatibilidade  entre  browsers,  bem
  como com a correta sintaxe dos mesmos. A demonstra��o que acompanha este pacote faz uso
  intensivo de propriedades CSS, que s�o dependentes de browser, sendo testadas no  IE5.5
  SP1 apenas.


M�todos:
--------

 AddColumn  : Adiciona uma coluna do recordset a ser mostrada.
              Recebe cinco par�metros:
               - Nome do campo: Campo do recordset a ser mostrado
               - Descri��o    : Nome que ser� mostrado no cabe�alho da tabela
               - Formato      : Defini��o do formato para a coluna.
                                Qualquer propriedade v�lida para tags TD.
               - Pesquis�vel  : Valor l�gico, indicando se o campo pode ser pesquisado
               - Tipo do dado : Define o tipo do dado, para concatena��o de strings na
                                pesquisa. Pode ser: C, D, N ou B, indicando  os  tipos
                                Char, Date, Number e Boolean.
               - Express�o    : Uma express�o que ser� avaliada quando a coluna for
                                exibida. Nomes de campos devem estar entre {{ }}, qdo
                                ser� avaliada literalmente ou entre [[]], quando ser�
                                adicionado o Server.URLEncode � express�o. Por exemplo:
                                "{{ RecordId }}". Se n�o informada, ser� utilizado o
                                conte�do de "Nome do campo".

 DelColumn  : Remove uma coluna da lista de colunas que ser�o mostradas
              Recebe como par�metro o nome do campo a ser removido. Este m�todo tamb�m �
              chamado internamente, caso o campo a ser exibido n�o exista no recordset.

 AllColumns : Adiciona automaticamente todos os campos do recordset ao Grid.
              Recebe como par�metro uma array, contendo todos os cabe�alhos das colunas.
              Caso o n�mero de elementos desta array seja menor  que  o  de  campos  do
              recorset, os nomes dos campos ser�o usados como t�tulos.

 BuildGrid  : Monta o grid, com base nas informa��es fornecidas


Software server-side necess�rio:
--------------------------------

 - VBScript 5.1 Build 5010 ou superior.

   Atualiza��es podem ser obtidas em http://msdn.microsoft.com/scripting/vbscript/
   Voc� pode checar a vers�o do VBScript instalada com o seguinte script:

   <%@ LANGUAGE = VBScript %>
   <% response.write ScriptEngine & "<BR>" & _
                     "Vers�o: " & ScriptEngineMajorVersion() & "." & ScriptEngineMinorVersion() & "<BR>" & _
                     "Build: "  & ScriptEngineBuildVersion() & "<BR>" %>

 - ADO 2.5

   Atualiza��es para o Microsoft Data Access Components (MDAC) podem ser obtidas em http://www.microsoft.com/ado/
   Voc� pode checar a vers�o do ADO instalada com o seguinte script:
   
   <%@ LANGUAGE = VBScript %>
   <% Set objConn = Server.CreateObject("ADODB.Connection")
      On Error Resume Next
      If Err.Number <> 0 Then
         Response.Write "Objeto ADODB.Connection <B>n�o instalado.</B>"
      Else
         Response.Write "ADO vers�o " & objConn.Version & " instalado"
      End If
      Set objConn = nothing
    %>


Bugs conhecidos:
----------------

 Nenhum, at� o momento.


Hist�rico de vers�es:
---------------------

 1.0  (19.12.2000)
  - Pre-release de testes (tks Mau!)

 1.0a (20.12.2000)
  - Documenta��o ampliada, com alguma otimiza��o de c�digo
  - Inclu�do o m�todo DelColumn
  - Verifica��o da exist�ncia das colunas, antes de mostr�-las.
  - Incluidas as propriedades:
     cHeaderLabel, bCanSearch, cSearchButtonAttribs,
     cSearchButtonLabel, cSearchTextAttribs,
     cSearchOperatorsAttribs e cSearchFieldsAttribs.
  - Incluidas as propriedades Searchable e DataType no m�todo AddColumn.
  - Consertado bug caso haja apenas uma coluna a ser exibida

 1.0b (21.12.2000)
  - Novas otimiza��es de c�digo e modifica��es/acertos na documenta��o
  - Incluida a propriedade oRecordset. Caso passado, a propriedade cSQL � ignorada
  - Incluida a propriedade bDestroyRecordset.

 1.1 (16.01.2001)
  - Incluido workaround para VBS 5.1 (redim)
  - Incluida a propriedade Expression (tks Vinicius Soares!), possibilitando
    montar express�es a serem avaliadas (ex: links)
  - Inclu�da a possibilidade de ordenar o recordset por colunas!
  - Incluida a propriedade cOrderAttribs, em decorr�ncia do acr�scimo das
    rotinas necess�rias para a ordena��o por colunas
  - A pagina��o agora � feita por envio de formul�rio, mantendo assim a
    refer�ncia � URL atual.
  - Incluida a propriedade read-only Version, retornando a vers�o da classe.
  - Incluida a propriedade Keys, por ter surgido a possibilidade de comercializar
    a classe.

 1.2 (29.06.2001)
  - Incluido o m�todo AllColumns
  - C�digo formatado com a adi��o de mais coment�rios, uma vez que o c�digo foi
    liberado para dom�nio p�blico.
  - Houveram outras altera��es (infelizmente n�o as documentei), mas tamb�m mantive
    o meu "ToDoList". Caso fa�a alguma altera��o que acredite ser interessante a
    outras pessoas, n�o deixe de enviar-me um email.

Enjoy! :)
