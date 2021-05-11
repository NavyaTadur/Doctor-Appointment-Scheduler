/* Copyright © 2015 Annpoint, s.r.o.
   Use of this software is subject to license terms. 
   http://www.daypilot.org/

   If you have purchased a DayPilot Pro license, you are allowed to use this 
   code under the conditions of DayPilot Pro License Agreement:

   http://www.daypilot.org/files/LicenseAgreement.pdf

   Otherwise, you are allowed to use it for evaluation purposes only under 
   the conditions of DayPilot Pro Trial License Agreement:
   
   http://www.daypilot.org/files/LicenseAgreementTrial.pdf
   
*/

using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using DayPilot.Web.Ui.Events.Calendar;
using Newtonsoft.Json;
using BeforeCellRenderEventArgs = DayPilot.Web.Ui.Events.Navigator.BeforeCellRenderEventArgs;
using CommandEventArgs = DayPilot.Web.Ui.Events.CommandEventArgs;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using DayPilot.Web.Ui.Events;

public partial class _Patient : System.Web.UI.Page 
{
    private DataTable _appointments;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (String.IsNullOrEmpty(Request.QueryString["id"]))
            {
                //Schedule.Visible = false;
                //return;
                DataRow first = Db.LoadFirstService();
                if (first != null)
                {
                    Response.Redirect("Patient.aspx?id=" + first["Service"], true);
                    return;
                }
            }
            //Console.WriteLine(Request.QueryString["id"]);
            string service = Request.QueryString["id"];
            //int id = int.TryParse(Request.QueryString["id"]);
            //int id = Convert.ToInt32(Request.QueryString["id"]);  // basic validation
            //DropDownListService.SelectedValue = id.ToString();
            //DropDownListService.SelectedIndex = 0;
            DropDownListService.SelectedValue = service.ToString();
            ////Db.LoadFreeAndMyAppointments(DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd, Session.SessionID, id);
            //DataRow doctor = Db.LoadDoctor(id);
            DataRow firstService = Db.LoadService(service);
            if (firstService == null)
            {
                //Db.LoadFreeAndMyAppointments(DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd, Session.SessionID,id);
                //Schedule.Visible = false;
                //System.out.println("Empty");
                return;
            }

           DropDownListService.AppendDataBoundItems = false;

            LoadServices();
            
            LoadCalendarData();
            LoadNavigatorData();
            string name = Session["Username"].ToString();
        }

    }

    private void LoadServices()
    {
        //DataTable dt= Db.LoadServices();
        DropDownListService.DataSource = Db.LoadServices();
        DropDownListService.DataTextField = "Service";
        DropDownListService.DataValueField ="Service";
        //DropDownListService.DataTextField = dt.Columns["Service"].ToString();
        //DropDownListService.DataValueField = dt.Columns["DoctorId"].ToString();
        DropDownListService.DataBind();
    }

    private void LoadNavigatorData()
    {
        if (_appointments == null)
        {
            LoadAppointments();
        }

        DayPilotNavigator1.DataSource = _appointments;
        DayPilotNavigator1.DataStartField = "AppointmentStart";
        DayPilotNavigator1.DataEndField = "AppointmentEnd";
        DayPilotNavigator1.DataIdField = "AppointmentId";
        DayPilotNavigator1.DataBind();
    }

    private void LoadCalendarData()
    {
        if (_appointments == null)
        {
            LoadAppointments();
        }
        
        DayPilotCalendar1.DataSource = _appointments;
        DayPilotCalendar1.DataStartField = "AppointmentStart";
        DayPilotCalendar1.DataEndField = "AppointmentEnd";
        DayPilotCalendar1.DataIdField = "AppointmentId";
        DayPilotCalendar1.DataTextField = "DoctorName";
        DayPilotCalendar1.DataTagFields = "AppointmentStatus, DoctorName, Service";
        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();
    }

    private void LoadAppointments()
    {
        string id = Request.QueryString["id"];
        //int id = Convert.ToInt32(Request.QueryString["id"]);  // basic validation
        //_appointments = Db.LoadFreeAndMyAppointments(DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd, Session.SessionID,id);
        _appointments = Db.LoadFreeAndMyAppointments(DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd, name, id);
    }


    protected void DayPilotCalendar1_OnCommand(object sender, CommandEventArgs e)
    {
        switch (e.Command)
        {
            case "navigate":
                DayPilotCalendar1.StartDate = (DateTime) e.Data["day"];
                LoadCalendarData();
                break;
            case "refresh":
                LoadCalendarData();
                break;
        }
        
    }

    protected void DropDownListService_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string selected = DropDownListService.SelectedValue;
        if (selected == "NONE")
        {
            Response.Redirect("Patient.aspx", true);
            return;
        }

        Response.Redirect("Patient.aspx?id=" + selected, true);
    }

    protected void DayPilotNavigator1_OnBeforeCellRender(object sender, BeforeCellRenderEventArgs e)
    {
    }

    protected void DayPilotCalendar1_OnBeforeEventRender(object sender, BeforeEventRenderEventArgs e)
    {
        string status = e.Tag["AppointmentStatus"];
        

        switch (status)
        {
            case "free":
                e.DurationBarColor = "#6aa84f";  // green
                e.Html = "Available";
                e.ToolTip = "Book this slot!";
                break;
            case "waiting":
                e.DurationBarColor = "#e69138";  // orange
                e.Html = "Confirmation Waiting";
                e.EventClickEnabled = false;
                break;
            case "confirmed":
                e.DurationBarColor = "#cc0000";   // red
                
                e.Html = "Confirmed!"+ e.Tag["DoctorName"]+"  "+ e.Tag["Service"];
                e.EventClickEnabled = true;
                break;
        }
    }
    
    [WebMethod(EnableSession = true), ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string SaveRequest(int id, string name)
    {
        // int id = Convert.ToInt32(idStr);
        Db.RequestAppointment(id, name, HttpContext.Current.Session.SessionID);
        Hashtable result = new Hashtable();
        result["status"] = "OK";
        return JsonConvert.SerializeObject(result);
    }



    protected void DropDownListSeverity_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string selected_severity = DropDownListSeverity.SelectedValue;
        string id = Request.QueryString["id"];
        //_appointments = Db.LoadFreeAndMyAppointments(DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd, Session.SessionID, id, selected_severity);
        _appointments = Db.LoadFreeAndMyAppointments(DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd, name, id);
        LoadCalendarData();
        //if (selected == "1")
        //{
        //    Response.Redirect("Patient.aspx", true);
        //    return;
        //}

        //Response.Redirect("Patient.aspx?id=" + selected, true);
    }
}
