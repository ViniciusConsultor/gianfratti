Public Class Funcoes

    'FUN��O QUE PREENCHE ZEROS A ESQUERDA DE UMA STRING PASSADA PARA A FUN��O
    'EX: SE VOC� PASSAR UMA STRING DE DATA 1/8/2005 NESSE FORMATO ENTAO ESTA FUN��O FAZ A FORMATA��O PARA 01/08/2005
    'PARA USAR: FunStrZero(string,2) numero que foi passado � a quantidade de numeros que a string tera que ter
    Function StrZero(ByVal Str, ByVal Size)
        Dim x As Integer
        Dim Content As String
        Content = ""
        For x = 1 To Size 'Faz o la�o for at� o numero que foi passado como parametro na fun��o
            Content = Content & "0"
        Next
        StrZero = Right(Content & Str, Size)
    End Function

    'FUN��O QUE ARRUMA A DATA PARA O FORMATA DD/MM/AAAA
    'PARA EXECUTAR USE ArrumaData(variavel)
    Function ArrumaData(ByVal Data)

        If Len(Trim(Data)) > 8 Then   'Verifica se a variavel passada n�o esta vazia

            'Usamos a fun��o SrtZero para arrumar a quantidade de certa de numeros. Ex: 1/1/2005 a fun��o formata para 01/01/2005
            ArrumaData = StrZero(Day(Data), 2) & "/" & StrZero(Month(Data), 2) & "/" & Right(Year(Data), 4)

        End If

    End Function
End Class
