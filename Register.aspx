<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register"   %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <style type="text/css">
        .auto-style1 {
            width: 158px;
        }
    </style>
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
            background-color:dodgerblue;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            cursor: pointer;
            }
        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
        }
        
        .container {
            padding: 16px;
            background-color: whitesmoke;
            max-width: 340px;
            min-width: 320px;
            width: 159%;
            margin-top: 100px;
            margin-left: 360px;
            
            
            
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
<body style="text-align: center; background-image: url('/Image/backgorund_register.jpg'); background-position:center; background-size: cover; background-repeat: no-repeat; image-rendering: optimizeQuality ">
    <form id="form1" runat="server" class="frmalg">
        <div class="container">
            <h3>
            <center>Registration using Role </center>
            </h3>
            <table align ="center">  
            <tr>  
                <td colspan="2">  
                    <h3>
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>  
                        
                </td>  
            </tr>  
                <tr>
                <td>  
                <asp:Label ID="Label4" runat="server" Text="Role:" Font-Bold="True" Width="100px"  Height="100px"></asp:Label>  
                    </td>  
                <td class="auto-style1">  
                    <asp:RadioButtonList ID="rbtRole" runat="server" RepeatDirection="Vertical" OnSelectedIndexChanged="rbtRole_SelectedIndexChanged">  
                        <asp:ListItem>Admin</asp:ListItem>  
                        <asp:ListItem>Doctor</asp:ListItem>  
                        <asp:ListItem>Users   </asp:ListItem>  
                    </asp:RadioButtonList>  
                </td>  
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Select role" ControlToValidate="rbtRole"></asp:RequiredFieldValidator> </td>  
                </tr>
            <tr>  
                <td>  
                 <asp:Label ID="Label1" runat="server" Text="UserName:" Font-Bold="True" Width="100px"></asp:Label>  
                    </td>  
                <td class="auto-style1">  
                    <asp:TextBox ID="txt_UserName" runat="server" Width="150px"></asp:TextBox>  
                </td>  
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Enter UserName" ControlToValidate="txt_UserName"></asp:RequiredFieldValidator> </td>  
            </tr>  
            <tr>  
                <td>  
                 <asp:Label ID="Label2" runat="server" Text="Password:" Font-Bold="True" Width="100px"></asp:Label>  
                 </td>  
                <td class="auto-style1">  
                    <asp:TextBox ID="txt_Password"  TextMode="Password" runat="server"  
                        Width="150px"></asp:TextBox>  
                </td>  
                <td><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter Password" ControlToValidate="txt_Password"></asp:RequiredFieldValidator> </td>  
            </tr>  
            
            <tr>  
                <td>  
                    &nbsp;</td>  
                <td class="auto-style1">  
                    &nbsp;</td>  
                <td>&nbsp;</td>  
            </tr>  
            <tr>  
            <td></td>  
                <td class="auto-style1">  
                    <asp:Button ID="btn_register" runat="server" CssClass="registerbtn" Text="Register"  
                        onclick="btn_register_Click" Width="98px" />  
                </td>  
                <td><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Login.aspx"  
                        ForeColor="#663300">Click here to Login</asp:HyperLink></td>  
            </tr>  
            <tr>  
                <td align="center"  colspan="2">  
                    &nbsp;</td>  
            </tr>  
        </table>  
        </div>
    </form>
</body>
</html>
