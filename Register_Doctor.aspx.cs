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
public partial class Register_Doctor : System.Web.UI.Page
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
        com.CommandText = "Insert into [Doctor] values(@DoctorName,@Service)";
        com.Parameters.Clear();
        com.Parameters.AddWithValue("@DoctorName", "Dr. "+ Session["Register_Name"]);
        com.Parameters.AddWithValue("@Service", ddl_service.Text);
        if (con.State == ConnectionState.Closed)
            con.Open();
        com.ExecuteNonQuery();
        con.Close();
        Label4.Text = "Successfully Registered!!!";
        Label4.Visible=true;
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}