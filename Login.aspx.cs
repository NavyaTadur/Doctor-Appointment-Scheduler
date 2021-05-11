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

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    string strConnString = ConfigurationManager.ConnectionStrings["daypilot"].ConnectionString;
    string str, UserName, Password;
    SqlCommand com;
    SqlDataAdapter sqlda;
    DataTable dt;
    int RowCount;
    protected void btn_Login_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(strConnString);
        con.Open();
        str = "Select * from [User]";
        com = new SqlCommand(str);
        sqlda = new SqlDataAdapter(com.CommandText, con);
        dt = new DataTable();
        sqlda.Fill(dt);
        RowCount = dt.Rows.Count;
        for (int i = 0; i < RowCount; i++)
        {
            UserName = dt.Rows[i]["Name"].ToString();
            Password = dt.Rows[i]["Password"].ToString();
            if (UserName == TextBox1_user_name.Text && Password == TextBox2_password.Text)
            {
                Session["UserName"] = UserName;
                if (dt.Rows[i]["Role"].ToString() == "Admin")
                    Response.Redirect("~/Manager.aspx");
                else if (dt.Rows[i]["Role"].ToString() == "User")
                    Response.Redirect("~/Patient.aspx");
                else if (dt.Rows[i]["Role"].ToString() == "Doctor")
                    Response.Redirect("~/Doctor.aspx");
            }
            else
            {
                lb1.Text = "Invalid User Name or Password! Please try again!";
                lb1.Visible=true;
            }
        }
    }

   
}