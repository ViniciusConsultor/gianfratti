using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for ClienteFuncionarioStatusBO
/// </summary>
public class ClienteFuncionarioStatusBO
{
	public ClienteFuncionarioStatusBO()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    /// <summary>
    /// Retorna um DropDownList
    /// </summary>
    /// <returns></returns>
    public DataTable DropDownList()
    {
        ClienteFuncionarioStatusDAL ObjClienteFuncionarioStatusDAL = new ClienteFuncionarioStatusDAL();
        return ObjClienteFuncionarioStatusDAL.DropDownList();
    }
}
