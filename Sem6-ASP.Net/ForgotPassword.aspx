<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="Quiz_Management_System.ForgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Forgot Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <!-- Font Awesome -->
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        *{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI'}
        body{
            background:linear-gradient(135deg,#667eea,#764ba2);
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
        }
        .container{
            width:100%;
            max-width:420px;
            background:#fff;
            border-radius:18px;
            box-shadow:0 15px 35px rgba(0,0,0,.2);
            overflow:hidden;
        }
        .header{
            background:linear-gradient(135deg,#667eea,#764ba2);
            color:#fff;
            padding:25px;
            text-align:center;
        }
        .content{padding:30px}

        /* Steps */
        .step-indicator{display:flex;justify-content:center;margin-bottom:25px}
        .step{
            width:38px;height:38px;border-radius:50%;
            background:#ddd;color:#555;
            display:flex;align-items:center;justify-content:center;
            font-weight:600;margin:0 10px;position:relative;
        }
        .step.active{background:#667eea;color:#fff}
        .step.completed{background:#28a745;color:#fff}
        .step::before{
            content:'';
            width:40px;height:2px;
            background:#ddd;
            position:absolute;
            right:-40px;top:50%;
        }
        .step:last-child::before{display:none}

        /* Inputs */
        .input-group{position:relative;margin-bottom:18px}
        .input-icon{
            position:absolute;
            left:14px;
            top:50%;
            transform:translateY(-50%);
            color:#667eea;
            font-size:16px;
        }
        .form-control{
            width:100%;
            padding:14px 14px 14px 42px;
            border:2px solid #ddd;
            border-radius:12px;
            font-size:15px;
        }

        /* Buttons */
        .btn{
            width:100%;
            padding:14px;
            border:none;
            border-radius:12px;
            background:linear-gradient(135deg,#667eea,#764ba2);
            color:#fff;
            font-weight:600;
            cursor:pointer;
        }

        /* Messages */
        .message-box{
            padding:12px;
            border-radius:10px;
            text-align:center;
            margin-bottom:15px;
        }
        .success{background:#e8f7ee;color:#28a745}
        .error{background:#fee;color:#dc3545}
    </style>
</head>

<body>
<form id="form1" runat="server">

<div class="container">
    <div class="header">
        <h2><i class="fas fa-key"></i> Forgot Password</h2>
        <p>Reset your password</p>
    </div>

    <div class="content">

        <!-- STEPS -->
        <div class="step-indicator">
            <div class="step" id="step1">1</div>
            <div class="step" id="step2">2</div>
            <div class="step" id="step3">3</div>
        </div>

        <!-- MESSAGE -->
        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message-box">
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </asp:Panel>

        <!-- EMAIL -->
        <asp:Panel ID="pnlEmail" runat="server">
            <div class="input-group">
                <div class="input-icon"><i class="fas fa-envelope"></i></div>
                <asp:TextBox ID="txtEmail" runat="server"
                    CssClass="form-control"
                    Placeholder="Enter Email"
                    TextMode="Email" />
            </div>
            <asp:Button ID="btnSendOTP" runat="server"
                Text="Send OTP" CssClass="btn"
                OnClick="btnSendOTP_Click" />
        </asp:Panel>

        <!-- OTP -->
        <asp:Panel ID="pnlOTP" runat="server" Visible="false">
            <div class="input-group">
                <div class="input-icon"><i class="fas fa-shield-alt"></i></div>
                <asp:TextBox ID="txtOTP" runat="server"
                    CssClass="form-control"
                    Placeholder="Enter OTP" MaxLength="6" />
            </div>
            <asp:Button ID="btnVerifyOTP" runat="server"
                Text="Verify OTP" CssClass="btn"
                OnClick="btnVerifyOTP_Click" />
        </asp:Panel>

        <!-- RESET -->
        <asp:Panel ID="pnlReset" runat="server" Visible="false">
            <div class="input-group">
                <div class="input-icon"><i class="fas fa-lock"></i></div>
                <asp:TextBox ID="txtNewPassword" runat="server"
                    CssClass="form-control"
                    Placeholder="New Password" TextMode="Password" />
            </div>
            <div class="input-group">
                <div class="input-icon"><i class="fas fa-lock"></i></div>
                <asp:TextBox ID="txtConfirmPassword" runat="server"
                    CssClass="form-control"
                    Placeholder="Confirm Password" TextMode="Password" />
            </div>
            <asp:Button ID="btnResetPassword" runat="server"
                Text="Reset Password" CssClass="btn"
                OnClick="btnResetPassword_Click" />
        </asp:Panel>

    </div>
</div>

</form>

<script>
    function updateSteps(step) {
        document.querySelectorAll('.step').forEach((s, i) => {
            s.classList.remove('active', 'completed');
            if (step === 4) s.classList.add('completed');
            else if (i + 1 < step) s.classList.add('completed');
            else if (i + 1 === step) s.classList.add('active');
        });
    }

    function currentStep() {
        if ('<%= Session["ResetCompleted"] %>') return 4;
    if (document.getElementById('<%= pnlReset.ClientID %>').style.display!=='none') return 3;
    if(document.getElementById('<%= pnlOTP.ClientID %>').style.display !== 'none') return 2;
        return 1;
    }

    document.addEventListener('DOMContentLoaded', () => {
        updateSteps(currentStep());
    });
</script>
</body>
</html>