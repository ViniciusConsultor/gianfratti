Public Class _Default
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents txtCodigoSeg As System.Web.UI.WebControls.TextBox
    Protected WithEvents Btn_Verificar As System.Web.UI.WebControls.Button

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    'Variavel usada para enviar as msg de erros
    Public Erro As String = ""

    'Evento executado ao clicar no botao
    Private Sub Btn_Verificar_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Verificar.Click
        'Verifica se o cookie existe
        If Not Request.Cookies("codseg") Is Nothing Then
            'Verifica se o c�digo digitado � igual ao cookie,
            'novamente usando a criptografia b�sica
            If txtCodigoSeg.Text.ToUpper.GetHashCode = Request.Cookies("codseg")("hash") Then
                Response.Write("Parab�ns. Voc� digitou corretamente o c�digo.")
                Response.Write("<a href='Default.aspx'>Clique aqui para voltar � p�gina inicial.</a>")
                Response.End()
            Else
                Erro = "O c�digo n�o foi digitado corretamente.\nTente novamente!"
            End If
        Else
            Erro = "O cookie n�o foi gravado. \nVerifique se seu navegador suporta cookies."
        End If
    End Sub

End Class
