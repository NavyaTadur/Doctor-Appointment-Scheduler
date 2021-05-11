using System;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }


    protected void btn_Logout_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
}
