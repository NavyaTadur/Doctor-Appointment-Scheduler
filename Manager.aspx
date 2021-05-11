<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Manager.aspx.cs" Inherits="Manager" MasterPageFile="~/Site.master" %>
<%@ Register Assembly="DayPilot" Namespace="DayPilot.Web.Ui" TagPrefix="DayPilot" %>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h3 style="margin-top: 0px">Admin: To manage appointments</h3>
    <div style="display: flex;">
    <div style="margin-right: 10px;">
        <DayPilot:DayPilotNavigator 
            runat="server" 
            ID="DayPilotNavigator1" 
            ClientIDMode="Static"
            BoundDayPilotID="DayPilotScheduler1"
            ShowMonths="2"    
            SelectMode="Month"
            
            CellHeight="32"
            CellWidth="32"
            DayHeaderHeight="30"
            TitleHeight="30"
            />  
    </div>
    
    <div style="flex-grow: 1;">
        
        <%--<div class="space">Scale: <a href="javascript:scale('shifts')">Shifts</a> | <a href="javascript:scale('hours')">Hours</a></div>--%> 

        <DayPilot:DayPilotScheduler 
            runat="server" 
            ID="DayPilotScheduler1"
            ClientObjectName="dp"
            
            AllowEventOverlap="false"
            UseEventBoxes="Never"
            
            CellWidth ="80"
            DynamicEventRendering="Disabled"
            
            TimeRangeSelectedHandling="CallBack"    
            OnTimeRangeSelected="DayPilotScheduler1_OnTimeRangeSelected" 
            
            EventClickHandling="JavaScript"
            EventClickJavaScript="display(e);"
            
            EventDeleteHandling="CallBack"
            OnEventDelete="DayPilotScheduler1_OnEventDelete"
            
            OnBeforeEventRender="DayPilotScheduler1_OnBeforeEventRender"
            OnCommand="DayPilotScheduler1_OnCommand"
            >
            <TimeHeaders>
                <DayPilot:TimeHeader GroupBy="Month" />
                <DayPilot:TimeHeader GroupBy="Day" Format="ddd d"/>
                <DayPilot:TimeHeader GroupBy="Hour" Format="ht" />
            </TimeHeaders>            
        </DayPilot:DayPilotScheduler>
        
        <div class="space" style="font-size:18px; color:firebrick "><asp:LinkButton runat="server" ID="ButtonClear" OnClick="ButtonClear_OnClick">Delete All Free Slots</asp:LinkButton> (This Month)</div>

        </div>
    </div>
    
<script>
    //function scale(size) {
    //    dp.clientState.size = size;
    //    dp.commandCallBack("refresh");
    //}

    function display(e) {
        if (e.tag("AppointmentPatientName") == "Navya") {
            alert("Patient Name: " + e.tag("AppointmentPatientName") + "\nEmail:ntadur@unomaha.edu");
        }
        alert("Patient Name: " + e.tag("AppointmentPatientName") + "\nEmail: " + e.tag("AppointmentPatientName") + "@unomaha.edu");
    }

</script>    

</asp:Content>