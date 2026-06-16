<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="Quiz_Management_System.LoginPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login | Quiz Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@600;700&display=swap" rel="stylesheet" />
    <link href="~/CSS/LoginPage.css" rel="stylesheet" />

</head>

<body>
    <div class="mountain-background">
        <div class="mountain-layer"></div>
        <div class="mountain-overlay"></div>
        <div class="stars-overlay"></div>
        <div class="moon"></div>
        <div class="moonlight-glow"></div>
        <div class="mountain-mist"></div>
        <div class="lake-reflection">
            <div class="water-waves">
                <div class="wave wave-1"></div>
                <div class="wave wave-2"></div>
            </div>
        </div>
    </div>

    <form id="form1" runat="server">
        <div class="glass-container">
            <div class="login-header">
                <div class="logo-icon">
                    <i class="fas fa-brain"></i>
                </div>
                <h1 class="welcome-text">Welcome back!</h1>
                <p class="subtitle">Sign in to your account to continue</p>
            </div>

            <!-- Error Message -->
            <div id="lblErrorMessage" class="error-message" runat="server"></div>

            <!-- Email -->
            <div class="form-group">
                <label class="form-label">EMAIL ADDRESS</label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope input-icon"></i>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input" 
                        placeholder="user@gmail.com" />
                </div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label class="form-label">PASSWORD</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock input-icon"></i>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                        CssClass="form-input" placeholder="••••••••" />
                    <button type="button" class="password-toggle" onclick="togglePassword()">
                        <i id="passwordIcon" class="fas fa-eye"></i>
                    </button>
                </div>
                <!-- Forgot Password Link -->
                <div style="text-align: right; margin-top: 5px;">
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        CssClass="forgot-link" NavigateUrl="~/ForgotPassword.aspx">
                        Forget password?
                    </asp:HyperLink>
                </div>
            </div>

            <!-- Login Type -->
            <div class="login-type-group">
                <label class="login-type-label">LOGIN AS</label>
                <div class="login-type-options">
                    <div class="login-type-option">
                        <asp:RadioButton ID="rbUser" runat="server" GroupName="LoginType" Checked="true" />
                        <label for="rbUser">User</label>
                    </div>
                    <div class="login-type-option">
                        <asp:RadioButton ID="rbAdmin" runat="server" GroupName="LoginType" />
                        <label for="rbAdmin">Admin</label>
                    </div>
                </div>
            </div>

            <!-- Login Button -->
            <asp:Button ID="btnLogin" runat="server" Text="Login" 
                CssClass="login-btn" OnClick="btnLogin_Click" />
            
            <!-- Footer -->
            <div class="login-footer">
                <span>Not a member yet?</span>
                <asp:LinkButton ID="lnkRegister" runat="server" 
                    CssClass="signup-link" OnClick="lnkRegister_Click">
                    Sign up
                </asp:LinkButton>
            </div>
        </div>
    </form>

    <script>
        (function () {
            // Clear any cached styles
            var stylesheets = document.querySelectorAll('link[rel="stylesheet"]');
            stylesheets.forEach(function (sheet) {
                var href = sheet.href;
                if (href && href.indexOf('?') === -1) {
                    sheet.href = href + '?v=' + new Date().getTime();
                }
            });

            // Clear inline style cache
            var styleTags = document.querySelectorAll('style');
            styleTags.forEach(function (style) {
                if (style.textContent) {
                    style.textContent = style.textContent;
                }
            });

            // Prevent back/forward cache issues
            window.onpageshow = function (event) {
                if (event.persisted) {
                    window.location.reload();
                }
            };
        })();

        function togglePassword() {
            var passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
            var icon = document.getElementById('passwordIcon');

            if (passwordInput.type === "password") {
                passwordInput.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                passwordInput.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }

        // Form validation
        document.addEventListener('DOMContentLoaded', function () {
            var form = document.getElementById('form1');
            form.addEventListener('submit', function (e) {
                var errorDiv = document.getElementById('<%= lblErrorMessage.ClientID %>');
                errorDiv.classList.remove('show');
                errorDiv.innerHTML = '';

                var emailInput = document.getElementById('<%= txtEmail.ClientID %>');
                var passwordInput = document.getElementById('<%= txtPassword.ClientID %>');

                if (!emailInput.value.trim()) {
                    showError('Please enter your email address.');
                    e.preventDefault();
                    return;
                }

                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(emailInput.value)) {
                    showError('Please enter a valid email address.');
                    e.preventDefault();
                    return;
                }

                if (!passwordInput.value) {
                    showError('Please enter your password.');
                    e.preventDefault();
                    return;
                }
            });

            function showError(message) {
                var errorDiv = document.getElementById('<%= lblErrorMessage.ClientID %>');
                errorDiv.innerHTML = message;
                errorDiv.classList.add('show');
            }

            // Mobile optimization
            if (window.innerWidth <= 768) {
                document.body.style.padding = '10px';
            }

            // Ensure all background elements are visible
            var bgElements = document.querySelectorAll('.mountain-layer, .mountain-overlay, .stars-overlay, .moon, .lake-reflection');
            bgElements.forEach(function (el) {
                el.style.display = 'block';
                el.style.visibility = 'visible';
                el.style.opacity = '1';
            });
        });
    </script>
</body>
</html>