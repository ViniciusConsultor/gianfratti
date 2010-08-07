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
/// Summary description for RiscosOcupacionais
/// </summary>
public class RiscosOcupacionais
{
    private int mid;
    private string mDescricao;

	public RiscosOcupacionais()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int id
    {
        get { return mid; }
        set { mid = value; }
    }

    public string Descricao
    {
        get { return mDescricao; }
        set { mDescricao = value; }
    }
}