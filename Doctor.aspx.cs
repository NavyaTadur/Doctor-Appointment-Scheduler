using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DayPilot.Web.Ui.Events;
using DayPilot.Web.Ui.Events.Calendar;
using Newtonsoft.Json;
using BeforeCellRenderEventArgs = DayPilot.Web.Ui.Events.Navigator.BeforeCellRenderEventArgs;
using CommandEventArgs = DayPilot.Web.Ui.Events.CommandEventArgs;

public partial class Doctor : System.Web.UI.Page
{

    private DataTable _appointments;
    private int doctorID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            
            
            //String doctorName= Session["Username"].ToString();
            //DataRow doctor = Db.LoadDoctor(doctorName);
            //if (doctor == null)
            //{
            //    Schedule.Visible = false;
            //    return;
            //}
            //doctorID = Convert.ToInt32(doctor["DoctorId"]);
            

            
            LoadNavigatorData();
            LoadCalendarData();
        }
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
        DayPilotCalendar1.DataTextField = "AppointmentPatientName";
        DayPilotCalendar1.DataTagFields = "AppointmentStatus, AppointmentPatientName";
        DayPilotCalendar1.DataBind();
        DayPilotCalendar1.Update();
    }

    private void LoadAppointments()
    {

        String doctorName = Session["Username"].ToString();
        DataRow doctor = Db.LoadDoctor(doctorName);
        if (doctor == null)
        {
            Schedule.Visible = false;
            return;
        }
        doctorID = Convert.ToInt32(doctor["DoctorId"]);

        _appointments = Db.LoadAppointmentsForDoctor(doctorID, DayPilotNavigator1.VisibleStart, DayPilotNavigator1.VisibleEnd);
    }

    protected void DayPilotCalendar1_OnCommand(object sender, CommandEventArgs e)
    {
        switch (e.Command)
        {
            case "navigate":
                DayPilotCalendar1.StartDate = (DateTime)e.Data["day"];
                LoadCalendarData();
                break;
            case "refresh":
                LoadCalendarData();
                break;
        }
    }

    protected void DayPilotNavigator1_OnBeforeCellRender(object sender, BeforeCellRenderEventArgs e)
    {
    }



    protected void DayPilotCalendar1_OnTimeRangeSelected(object sender, TimeRangeSelectedEventArgs e)
    {
        //int doctor = Convert.ToInt32(Request.QueryString["id"]);
        String doctorName = Session["Username"].ToString();
        DataRow doctor = Db.LoadDoctor(doctorName);
        if (doctor == null)
        {
            Schedule.Visible = false;
            return;
        }
        doctorID = Convert.ToInt32(doctor["DoctorId"]);


        Db.CreateAppointment(doctorID, e.Start, e.End);

        LoadCalendarData();

    }

    protected void DayPilotCalendar1_OnBeforeEventRender(object sender, BeforeEventRenderEventArgs e)
    {
        string status = e.Tag["AppointmentStatus"];
        switch (status)
        {
            case "free":
                e.DurationBarColor = "#6aa84f";  // green
                break;
            case "waiting":
                e.DurationBarColor = "#e69138";   // orange
                break;
            case "confirmed":
                e.DurationBarColor = "#cc0000";  // red            
                break;
        }
    }

    protected void DayPilotCalendar1_OnEventMove(object sender, EventMoveEventArgs e)
    {
        Db.MoveAppointment(e.Id, e.NewStart, e.NewEnd);
        LoadCalendarData();
    }

    protected void DayPilotCalendar1_OnEventResize(object sender, EventResizeEventArgs e)
    {
        Db.MoveAppointment(e.Id, e.NewStart, e.NewEnd);
        LoadCalendarData();
    }

    [WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string Save(int id, string status, string name)
    {
        var dr = Db.LoadAppointment(id);

        DateTime start = (DateTime)dr["AppointmentStart"];
        DateTime end = (DateTime)dr["AppointmentEnd"];
        int doctor = (int)dr["DoctorId"];

        Db.UpdateAppointment(id, start, end, name, doctor, status);
        
        Hashtable result = new Hashtable();
        result["status"] = "OK";
        return JsonConvert.SerializeObject(result);
    }

    protected void DayPilotCalendar1_OnEventDelete(object sender, EventDeleteEventArgs e)
    {
        int id = Convert.ToInt32(e.Id);
        if(e.Tag["AppointmentStatus"] == "free")
        {
            Db.DeleteAppointmentIfFree(id);
        }
        Db.DeleteAppointment(id);
        
        LoadCalendarData();
    }
}