<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register_Doctor.aspx.cs" Inherits="Register_Doctor"  %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Doctor_Registration</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }
        form1 {
            border: 4px solid #f1f1f1;
            max-width: 400px;
            min-width: 320px;
            width: 88%;
            margin-top: 79px;
        }
        input[type=text], input[type=password] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
           
        }
        button:hover {
            opacity: 0.8;
        }
        
        .registerbtn{
            border-style: none;
            border-color: inherit;
            border-width: medium;
            background-color:steelblue;
            color: white;
            padding: 14px 20px;
            margin: 16px 0 8px 0;
            cursor: pointer;
            text-align:center;
        }
        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
        }
        
        .container {
            padding: 16px;
            background-color:floralwhite;
            max-width: 340px;
            min-width: 320px;
            width: 152%;
            margin-top: 100px;
            margin-left: 200px;
            
            
            
        }
        span.psw {
            float: right;
            padding-top: 16px;
        }
        /* Change styles for span and cancel button on extra small screens */
        @media screen and (max-width: 300px) {
            span.psw {
                display: block;
                float: none;
            }
           
        }
        .frmalg {
            margin: auto;
            width: 39%;
            
        }
    </style>
</head>
<body style="text-align: center; background-image: url('/Image/backgorund_register.jpg'); background-position:center; background-size: cover; background-repeat: no-repeat; image-rendering: optimizeQuality;">
    <form id="form1" runat="server" class="frmalg">
        <div class="container">
            <asp:Label ID="Label4" runat="server" style="text-align: center" Text="Label" Visible="false"></asp:Label>
        
            <table align ="center">  
            <tr>  
                <td>  
                    &nbsp;</td>  
                <td>  
                    &nbsp;</td>  
                <td>&nbsp;</td>  
            </tr>  
            <tr>  
                <td>  
                    &nbsp;</td>  
                <td>  
                    &nbsp;</td>  
                <td>&nbsp;</td>  
            </tr>  
            <tr>  
                <td>  
                    <asp:Label ID="label3" runat="server" Text="Service:" Width="100px" ></asp:Label>
                </td>  
                <td>  
                    <asp:DropDownList ID="ddl_service" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                        <asp:ListItem Value="Select"></asp:ListItem>
                        <asp:ListItem Value="General Physician"></asp:ListItem>
                        <asp:ListItem Value="Covid Test"></asp:ListItem>
                        <asp:ListItem Value="Flu Shot"></asp:ListItem>
                        <asp:ListItem Value="Pregnancy Check-up"></asp:ListItem>
                        <asp:ListItem Value="ENT specialist"></asp:ListItem>
                    </asp:DropDownList>
                </td>  
                <td>&nbsp;</td>  
            </tr>  
            <tr>  
            <td>  
                    <asp:Button ID="btn_register" runat="server" cssClass="registerbtn" Text="Register" text-align="center"  
                        onclick="btn_register_Click" Width="92px" Height="47px" />  
                </td>  
                <td>  
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Login.aspx"  
                        ForeColor="#663300">Click here to Login</asp:HyperLink>  
                </td>  
                <td>&nbsp;</td>  
            </tr>  
        </table>  
        
            </div>
    </form>
</body>
</html>
