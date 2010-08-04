<% 
'######################################################################
'#  Fun��o: Monta Vetor Automatico                                                        
'#  Autro: Fabrizio Gianfratti                                                            
'#  Site: www.gianfratti.com      Email: fabrizio@gianfratti.com                          
'#  PARAMETROS DA FUN��O                                                                  
'#  Acao: Inserir ou Excluir                                                           
'#  Valor: � o valor que ira ser incluido ou excluido do vetor                            
'#  COMO CHAMAR A FUN��O PARA INCLUIR UM VETOR                                           
'#  Ex: Call VetorMonta("Incluir",16) 'Para Incluir uma posicao no vetor "numerica"       
'#  Ex: Call VetorMonta("Incluir","Fabrizio") 'Para Incluir uma posicao no vetor "string" 
'#  COMO CHAMAR A FUN��O PARA EXCLUIR UMA POSICAO DO VETOR                                
'#  Ex: Call VetorMonta("Excluir",15) 'Para Excluir uma posicocao do vetor                
'#  COMO VISUALIZAR A SESSION ONDE ESTAO OS VETORES                                       
'#  For x = 0 To Ubound(session("GuardaVetor"))                                           
'#   Response.Write session("GuardaVetor")(x) & "<br>"                                 
'#  Next                                                                                  
'#####################################################################
Function VetorMonta(Acao,Valor)
 Select Case Trim(Acao) 'Usamos o case para manipular a a��o da fun��o
  Case "Incluir" 'Inclui nova posicao ao vetor
   Vetor = Session("GuardaVetor") 'Guarda na variavel Vetor o conteudo da Session
   If Not IsArray(Vetor) Then Vetor = Array() End if 'Verifica se a Variavel Vetor � um Array, caso nao for entao definimos ela um Array
   If InStr(Join(Vetor), Valor) = 0 Then 'Verifica se o Valor que esta sendo inserido j� esta no Vetor se estiver entao nao inseri para nao haver duplicidades do vetor
    ReDim preserve Vetor(UBound(Vetor)+1) 'Este comando ira preservar o vetor e adciona + 1 valor
    Vetor(Ubound(Vetor )) = Valor 'Este � o valor que estamos adicionando no vetor
    Session("GuardaVetor") = Vetor 'Coloca o conteudo da variavel vetor dentro da Session
   End if
  Case "Excluir" 'Apaga uma determinada posicao do vetor
   Vetor = Array() 'Inicia a varivel vetor como vazia
   AuxVetor = Session("GuardaVetor") 'Criamos uma nova variavel Auxiliar e guardamos o valor da Session
   Session("GuardaVetor") = Array() 'Definine a Session como um Array vazio
   For i = 0 To Ubound(AuxVetor) 'Faz um la�o em todas as posi��es do vetor
    If AuxVetor(i) <> Valor Then 'Verifica se o valor passado para excluir do vetor � diferente do valor que esta dentro da variavel Auxiliar
     ReDim preserve Vetor (UBound(Vetor)+1) 'Este comando ira preservar o vetor e adciona + 1 valor
     Vetor (Ubound(Vetor)) = AuxVetor(i) 'Este � o valor que estamos adicionando no vetor
     Session("GuardaVetor") = Vetor 'Coloca o conteudo da variavel vetor dentro da Session
    End If
   Next
 End Select 'Fim do Case
End Function

Call VetorMonta("Incluir",5) 'Executa a fun��o que ira criar uma posi��o do vetor, basta passar a acao e o valor
'Call VetorMonta("Excluir",10) 'Executa a fun��o que ira deletar uma posi��o do vetor, basra passar a acao e o valor

'Mostra os vetores criados, apenas um exemplo
For x = 0 To ubound(session("GuardaVetor")) 'ira fazer um la�o mostrando todos os vetores criados
 Response.Write session("GuardaVetor")(x) & "<br>" 'Imprime o Vetor na tela
Next
%>
