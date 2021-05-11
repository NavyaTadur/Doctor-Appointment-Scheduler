<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Doctor.aspx.cs" Inherits="Doctor" MasterPageFile="~/Site.master" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <link href='css/main.css' type="text/css" rel="stylesheet"/>
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <h2 style="margin-top: 0px; margin-bottom: 0px"> Doctor's Schedule</h2>

    

    <asp:Panel runat="server" ID="Schedule">
        <div style="display: flex;">
            <div style="margin-right: 10px;">
                <DayPilot:DayPilotNavigator
                    runat="server"
                    ID="DayPilotNavigator1"
                    ClientIDMode="Static"
                    BoundDayPilotID="DayPilotCalendar1"
                    ShowMonths="2"
                    SelectMode="Week"
                    CellHeight="36"
                    CellWidth="36"
                    DayHeaderHeight="30"
                    TitleHeight="30"

                    OnBeforeCellRender="DayPilotNavigator1_OnBeforeCellRender"/>
            </div>

            <div style="flex-grow: 1;">
                <DayPilot:DayPilotCalendar
                    runat="server"
                    ID="DayPilotCalendar1"
                    ClientObjectName="dp"
                    ClientIDMode="Static"
                    ViewType="Week"

                    CellHeight="30"
                    HeaderHeight="30"

                    OnCommand="DayPilotCalendar1_OnCommand"
                    TimeRangeSelectedHandling="CallBack"
                    OnTimeRangeSelected="DayPilotCalendar1_OnTimeRangeSelected"
                    OnBeforeEventRender="DayPilotCalendar1_OnBeforeEventRender"
                    EventClickHandling="JavaScript"
                    EventClickJavaScript="edit(e);"
                    EventMoveHandling="CallBack"
                    OnEventMove="DayPilotCalendar1_OnEventMove"
                    EventResizeHandling="CallBack"
                    OnEventResize="DayPilotCalendar1_OnEventResize"
                    EventDeleteHandling="CallBack"
                    OnEventDelete="DayPilotCalendar1_OnEventDelete"/>
            </div>
        </div>
    </asp:Panel>


    <script>

        function edit(e) {
            var statuses = [
                { name: "Free", id: "free" },
                { name: "Waiting", id: "waiting" },
                { name: "Confirmed", id: "confirmed" }
                //{ name: "Cancelled", id:"cancelled"}
            ];

            var form = [
                { name: "Start", id: "start", dateFormat: "MMMM d, yyyy hh:mm tt", disabled: true },
                { name: "End", id: "end", dateFormat: "MMMM d, yyyy hh:mm tt", disabled: true },
                { name: "Status", id: "status", options: statuses, type: "select" },
                { name: "Patient Name", id: "name" }
            ];

            var data = {
                id: e.id(),
                start: e.start(),
                end: e.end(),
                status: e.tag("AppointmentStatus"),
                name: e.tag("AppointmentPatientName")
            };

            DayPilot.Modal.form(form, data).then(function(modal) {
                if (modal.canceled) {
                    return;
                }
                DayPilot.Http.ajax({
                    url: "Doctor.aspx/Save",
                    data: modal.result,
                    success: function(ajax) {
                        dp.commandCallBack('refresh');
                        dp.message("Saved");
                    }
                });
            });
        }
    </script>
</asp:Content>