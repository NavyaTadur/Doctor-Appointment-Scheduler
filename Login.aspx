<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Form</title>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }
        form1 {
            border: 3px solid #f1f1f1;
            max-width: 600px;
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
        .cnbtn {
            background-color: #ec3f3f;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 49%;
        }
        .lgnbtn {
            background-color:deepskyblue;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 50%;
        }
        .imgcontainer {
            text-align: center;
            margin: 24px 0 12px 0;
        }
        img.avatar {
            width: 40%;
            border-radius: 50%;
        }
        .container {
            padding: 16px;
            background-color: whitesmoke;
            max-width: 600px;
            min-width: 320px;
            width: 88%;
            margin-top: 120px;
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
            .cnbtn {
                width: 100%;
            }
        }
        .frmalg {
            margin: auto;
            width: 39%;
            
        }
    </style>

</head>
<body style="text-align: center; background-image: url('/Image/background2.jpg'); background-position:initial; background-size:cover; background-repeat: no-repeat; image-rendering: optimizeQuality;">
    <form id="form1" runat="server" class="frmalg">

        <div class="container">
            <%--//<center>--%>
                <h3>Login</h3>
            <p>
                <asp:Label ID="lb1" runat="server" Text="Label" Visible="False"></asp:Label>
            </p>
            <%--//</center>--%>
            <label for="uname"><b>Username</b></label>
            <asp:TextBox runat="server" ID="TextBox1_user_name" placeholder="Enter Username"></asp:TextBox>
            <label for="psw"><b>Password</b></label>
            <asp:TextBox runat="server" ID="TextBox2_password" TextMode="Password" placeholder="Enter Password"></asp:TextBox>
            <asp:Button runat="server" ID="btn_Login" CssClass="lgnbtn" Text="Login" OnClick="btn_Login_Click" />
            <asp:Button runat="server" ID="btn_cancel" Text="Cancel" class="cnbtn" />
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Register.aspx"  
                        ForeColor="Red">No account yet? Click here to register</asp:HyperLink>
        </div>
    </form>
</body>
</html>