using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Usuarios_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DataGridUsuarios();
        }
    }

    //Fun��o que preenche o data grid
    private void DataGridUsuarios()
    {
        try
        {
            UsuarioBO ObjUsuarioBO = new UsuarioBO();
            GridUsuario.DataSource = ObjUsuarioBO.SelectUsuarioALL(txtNome.Text, ddlUsuariosPerfil.ValorInformado, ddlUsuarioStatus.ValorInformado);
            GridUsuario.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    //Evento responsavel por chamar as fun��es
    protected void GridUsuario_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Deletar")
            {
                Deletar(Convert.ToInt32(e.CommandArgument));
            }
            if (e.CommandName == "Editar")
            {
                Editar(Convert.ToInt32(e.CommandArgument));
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }

    private void Editar(int id)
    {
        Response.Redirect("UsuarioCadastro.aspx?id=" + id);
    }

    //Fun��o para deletar um registro
    public void Deletar(int id)
    {
        try
        {
            UsuarioBO ObjUsuarioBO = new UsuarioBO();
            ObjUsuarioBO.DeleteUsuarioByID(id);
            DataGridUsuarios();
        }
        catch (Exception ex)
        {
            Response.Write(ex);
        }
    }
    //Evento Data Grid
    protected void GridUsuario_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Image Img = (Image)e.Row.FindControl("Image1");
            if (e.Row.Cells[1].Text == "Ativo")
            {
                Img.ImageUrl = "~/Template/Img/Flg_verde.gif";
                Img.AlternateText = "Usu�rio Ativo";
            }
            else if (e.Row.Cells[1].Text == "Inativo")
            {
                Img.ImageUrl = "~/Template/Img/Flg_preto.gif";
                Img.AlternateText = "Usu�rio Inativo";
            }

            //Confirma��o de Exclus�o
            ImageButton ImageButton = (ImageButton)e.Row.FindControl("ImgDelete");
            ImageButton.Attributes.Add("onclick", "javascript:return confirm('Confirma a exclus�o do usu�rio " + DataBinder.Eval(e.Row.DataItem, "Nome") + "?')");
        }
    }
    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        DataGridUsuarios();
    }
}