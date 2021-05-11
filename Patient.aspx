<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Patient.aspx.cs" Inherits="_Patient" MasterPageFile="~/Site.master" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">    
    <style type="text/css">
        .space1 {
            width: 166px;
        }
    </style>
</asp:Content>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="Heading">
    <%--<h2 style="height: 34px ;margin-top: 2px">Request an Appointment</h2>--%>
    <h3 style="margin-top: 0px">Request an Appointment</h3>
     <div class="space">
        Service:
        <asp:DropDownList runat="server" ID="DropDownListService" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="DropDownListService_OnSelectedIndexChanged" Height="30px">
            <asp:ListItem Value="NONE">(no service specified)</asp:ListItem>
        </asp:DropDownList>
    </div>
    <div class="space1">
        Severity:
        <asp:DropDownList runat="server" ID="DropDownListSeverity" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="DropDownListSeverity_OnSelectedIndexChanged" Height="30px">
            <asp:ListItem Value="normal">Normal</asp:ListItem>
            <asp:ListItem Value="critical">Crticial</asp:ListItem>
        </asp:DropDownList>
    </div>
       
    </asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div style="display: flex; background-color:transparent">
        <div style="margin-right: 10px; margin-top: 0px;">
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
        <div style="flex-grow: 1;margin-top:2px">
            <%--<p>Available time slots:</p>--%>
            <DayPilot:DayPilotCalendar
                runat="server"
                ID="DayPilotCalendar1"
                ClientIDMode="Static"
                ClientObjectName="dp"
                ViewType="Week"

                DurationBarWidth="60"
                
                CellHeight="32"
                HeaderHeight="25"

                OnCommand="DayPilotCalendar1_OnCommand"
                OnBeforeEventRender="DayPilotCalendar1_OnBeforeEventRender"

                EventClickHandling="JavaScript"
                EventClickJavaScript="edit(e)" style="top: 0px; left: 0px; height: 573px"/>
        </div>
    </div>


    <script>
        function edit(e) {
            new DayPilot.Modal({
                onClosed: function(args) {
                    if (args.result == "OK") {
                        dp.commandCallBack('refresh');
                    }
                }
            }).showUrl("Request.aspx?id=" + e.id());
        }


        function edit(e) {           

            var form = [
                { name: "Start DateTime", id: "start", dateFormat: "MMMM d, yyyy hh:mm tt", disabled: true },
                { name: "End DateTime", id: "end", dateFormat: "MMMM d, yyyy hh:mm tt", disabled: true },
                { name: "Patient Name", id: "name" },
            ];

            var data = {
                id: e.id(),
                start: e.start(),
                end: e.end()
            };

            DayPilot.Modal.form(form, data).then(function(modal) {
                if (modal.canceled) {
                    return;
                }
                DayPilot.Http.ajax({
                    url: "Patient.aspx/SaveRequest",
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