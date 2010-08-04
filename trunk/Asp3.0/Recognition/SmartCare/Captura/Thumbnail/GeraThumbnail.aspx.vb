Public Class GeraThumbnail
    Inherits System.Web.UI.Page

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    'Esta pagina � chamada para Gerar os Thumbnail
    '� obrigatorio passar 2 parametros.
    '1� caminho da imagem
    '2� nome da imagem
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Para testar http://fmanes/SmartCare/Captura/thumbnail.aspx?filename=teste.jpg&width=100
        'Referencia http://www.developer.com/net/asp/article.php/3098311
        ' Initialize objects
        Dim objImage, objThumbnail As System.Drawing.Image
        Dim strServerPath, strFilename As String
        Dim shtWidth, shtHeight As Short
        ' Get image folder path on server - use "\" string if root
        strServerPath = Server.MapPath("..\Imagens\" & Request.QueryString("Caminho"))
        ' Retrieve name of file to resize from query string
        strFilename = strServerPath & Request.QueryString("filename")
        ' Retrieve file, or error.gif if not available
        Try
            objImage = objImage.FromFile(strFilename)
        Catch
            objImage = objImage.FromFile(Server.MapPath("..\Thumbnail\") & "erro.gif")
        End Try
        ' Retrieve width from query string
        If Request.QueryString("width") = Nothing Then
            shtWidth = objImage.Width
        ElseIf Request.QueryString("width") < 1 Then
            shtWidth = 80
        Else
            shtWidth = Request.QueryString("width")
        End If
        ' Work out a proportionate height from width
        shtHeight = objImage.Height / (objImage.Width / shtWidth)
        ' Create thumbnail
        objThumbnail = objImage.GetThumbnailImage(shtWidth, shtHeight, Nothing, System.IntPtr.Zero)
        ' Send down to client
        Response.ContentType = "image/jpeg"
        objThumbnail.Save(Response.OutputStream, Imaging.ImageFormat.Jpeg)
        ' Tidy up
        objImage.Dispose()
        objThumbnail.Dispose()
    End Sub

End Class
