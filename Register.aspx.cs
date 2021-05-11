using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Newtonsoft.Json;
using System.Configuration;
using System.Data;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.Collections;
public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    string strConnString = ConfigurationManager.ConnectionStrings["daypilot"].ConnectionString;
    SqlCommand com;
    protected void btn_register_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(strConnString);
        com = new SqlCommand();
        com.Connection = con;
        com.CommandType = CommandType.Text;
       
        com.CommandText = "Insert into [User] values(@UserName,@Password,@Role)";
        com.Parameters.Clear();
        com.Parameters.AddWithValue("@UserName", txt_UserName.Text);
        com.Parameters.AddWithValue("@Password", txt_Password.Text);
        com.Parameters.AddWithValue("@Role", rbtRole.SelectedValue);
        Session["Register_Name"] = txt_UserName.Text; 
        if (con.State == ConnectionState.Closed)
            con.Open();
        com.ExecuteNonQuery();
        con.Close();
        if (rbtRole.SelectedValue == "Doctor")
        {
            Response.Redirect("~/Register_Doctor.aspx");
        }
        lblmsg.Text = "Successfully Registered!!!";
        clear();
    }
    private void clear()
    {
        txt_UserName.Text = "";
        rbtRole.ClearSelection();
    }

    protected void rbtRole_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}