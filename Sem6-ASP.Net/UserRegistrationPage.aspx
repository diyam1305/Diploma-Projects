<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserRegistrationPage.aspx.cs" Inherits="Quiz_Management_System.UserRegistrationPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register - Quiz Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Montserrat:wght@600;700&display=swap" rel="stylesheet" />
    <link href="~/CSS/UserRegistration.css" rel="stylesheet" />
</head>

<body>
    <!-- Real Mountain Background -->
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
            <!-- Icon at top -->
            <div class="register-icon">👤</div>
            
            <!-- Header -->
            <div class="register-header">
                <h1 class="register-title">CREATE ACCOUNT</h1>
                <p class="register-subtitle">Join Quiz Management System</p>
            </div>

            <!-- Error Message -->
            <asp:Label ID="lblMessage" runat="server" CssClass="message-label"></asp:Label>

            <!-- First Name -->
            <div class="form-group">
                <label class="form-label">FIRST NAME</label>
                <div class="input-wrapper">
                    <i class="fas fa-user input-icon"></i>
                    <asp:TextBox ID="txtfirstname" runat="server" CssClass="form-input" 
                        placeholder="Enter first name" />
                </div>
            </div>

            <!-- Last Name -->
            <div class="form-group">
                <label class="form-label">LAST NAME</label>
                <div class="input-wrapper">
                    <i class="fas fa-user input-icon"></i>
                    <asp:TextBox ID="txtlastname" runat="server" CssClass="form-input" 
                        placeholder="Enter last name" />
                </div>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label class="form-label">EMAIL ADDRESS</label>
                <div class="input-wrapper">
                    <i class="fas fa-envelope input-icon"></i>
                    <asp:TextBox ID="txtemailid" runat="server" CssClass="form-input" 
                        placeholder="Enter your email" />
                </div>
            </div>

            <!-- Password -->
            <div class="form-group">
                <label class="form-label">PASSWORD</label>
                <div class="password-wrapper">
                    <div class="input-wrapper">
                        <i class="fas fa-lock input-icon"></i>
                        <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" 
                            CssClass="form-input" placeholder="Enter password" />
                    </div>
                    <button type="button" class="password-toggle" onclick="togglePassword()">
                        <i id="passwordIcon" class="fas fa-eye"></i>
                    </button>
                </div>
                <div class="password-hint">
                    Must contain: 8+ chars, uppercase, lowercase, number, special character
                </div>
            </div>

            <!-- Confirm Password -->
            <div class="form-group">
                <label class="form-label">CONFIRM PASSWORD</label>
                <div class="input-wrapper">
                    <i class="fas fa-lock input-icon"></i>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" 
                        CssClass="form-input" placeholder="Confirm password" />
                </div>
            </div>

            <!-- Register Button -->
            <asp:Button ID="btnRegister" runat="server" Text="Register" 
                CssClass="register-btn" OnClick="btnRegister_Click" OnClientClick="return validateForm()" />
            
            <!-- Footer -->
            <div class="register-footer">
                <span>Already have an account?</span>
                <asp:LinkButton ID="lnkBackToLogin" runat="server" 
                    CssClass="login-link" OnClick="lnkBackToLogin_Click">
                    Back to Login
                </asp:LinkButton>
            </div>
        </div>
    </form>
        <script>
            function togglePassword() {
                var passwordInput = document.getElementById('<%= txtpassword.ClientID %>');
                var icon = document.getElementById('passwordIcon');

                if (passwordInput.type === "password") {
                    passwordInput.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                }
                else {
                    passwordInput.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }

            function validateForm() {
                var isValid = true;
                clearErrors();

                var messageLabel = document.getElementById('<%= lblMessage.ClientID %>');
                var messageLabel.innerHTML = '';
                var messageLabel.classList.remove('show');
                var messageLabel.style.display = 'none';

                var firstName = document.getElementById('<%= txtfirstname.ClientID %>');
                var lastName = document.getElementById('<%= txtlastname.ClientID %>');
                var email = document.getElementById('<%= txtemailid.ClientID %>');
                var password = document.getElementById('<%= txtpassword.ClientID %>');
                var confirmPassword = document.getElementById('<%= txtConfirmPassword.ClientID %>');

                if (!firstName.value.trim()) {
                    showError(firstName, 'First name is required');
                    isValid = false;
                }

                if (!lastName.value.trim()) {
                    showError(lastName, 'Last name is required');
                    isValid = false;
                }

                var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                if (!email.value.trim()) {
                    showError(email, 'Email is required');
                    isValid = false;
                } else if (!emailRegex.test(email.value.trim())) {
                    showError(email, 'Please enter a valid email address');
                    isValid = false;
                }

            var passwordPattern =
                /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

            if (!password.value) {
                showError(password, 'Password is required');
                isValid = false;
            } else if (!passwordPattern.test(password.value)) {
                showError(password, 'Password must be strong');
                isValid = false;
            }

            if (!confirmPassword.value) {
                showError(confirmPassword, 'Please confirm your password');
                isValid = false;
            } else if (password.value !== confirmPassword.value) {
                showError(confirmPassword, 'Passwords do not match');
                isValid = false;
            }

            if (!isValid) {
                messageLabel.innerHTML = "Please correct the highlighted errors.";
                messageLabel.classList.add('show');
                messageLabel.style.display = 'block';
            }
            return isValid;
        }

    function showError(input, message) {
        input.classList.add('error');
        var errorDiv = document.createElement('div');
        errorDiv.className = 'field-error';
        errorDiv.textContent = message;
        input.closest('.form-group').appendChild(errorDiv);
    }

    function clearErrors() {
        document.querySelectorAll('.form-input').forEach(i =>
            i.classList.remove('error', 'success')
        );
        document.querySelectorAll('.field-error').forEach(e => e.remove());
    }

    window.onload = function () {
        var messageLabel = document.getElementById('<%= lblMessage.ClientID %>');
            if (messageLabel && messageLabel.innerHTML.trim() !== '') {
                messageLabel.classList.add('show');
            messageLabel.style.display = 'block';
        }
    };
    </script>
</body>
</html>