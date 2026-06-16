<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/UserDashboard.Master" CodeBehind="UserProfile.aspx.cs" Inherits="Quiz_Management_System.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    :root {
    --primary: #667eea;
    --primary-dark: #5a67d8;
    --secondary: #764ba2;
    --success: #10b981;
    --success-dark: #059669;
    --danger: #f87171;
    --danger-dark: #ef4444;
    --light: #f8fafc;
    --dark: #1e293b;
    --gray: #64748b;
    --gray-light: #e2e8f0;
    --shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
    --radius: 12px;
}

.profile-wrapper {
    min-height: calc(100vh - 60px);
    background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
    padding: 30px 15px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.profile-card {
    width: 100%;
    max-width: 420px; 
    background: white;
    border-radius: var(--radius);
    overflow: hidden;
    box-shadow: var(--shadow);
    transition: transform 0.3s ease;
}

.profile-card:hover {
    transform: translateY(-3px);
}

.profile-header {
    background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
    padding: 30px 25px; 
    text-align: center;
    position: relative;
    overflow: hidden;
}

.profile-header::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
    background-size: 20px 20px;
    opacity: 0.3;
}

.avatar-container {
    width: 80px; 
    height: 80px; 
    position: relative;
    z-index: 2;
}

.avatar {
    width: 100%;
    height: 100%;
    background: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    border: 3px solid white; 
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15); 
}

.avatar i {
    font-size: 40px; 
    background: linear-gradient(135deg, var(--primary), var(--secondary));
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

.profile-title {
    color: white;
    font-size: 24px; 
    font-weight: 700;
    margin: 0 0 6px 0; 
    position: relative;
    z-index: 2;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.profile-subtitle {
    color: rgba(255, 255, 255, 0.9);
    font-size: 13px; 
    font-weight: 400;
    margin: 0;
    position: relative;
    z-index: 2;
}

.profile-content {
    padding: 30px; 
}

/* Message Box */
.message-box {
    margin-bottom: 25px; 
    padding: 14px 18px; 
    border-radius: 10px; 
    font-size: 14px;
    font-weight: 500;
    text-align: center;
    animation: slideDown 0.3s ease-out;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    border-left: 3px solid transparent; 
}

@keyframes slideDown {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

.message-success {
    background: linear-gradient(135deg, #10b98115 0%, #05966915 100%);
    color: var(--success-dark);
    border-left-color: var(--success);
}

.message-error {
    background: linear-gradient(135deg, #f8717115 0%, #ef444415 100%);
    color: var(--danger-dark);
    border-left-color: var(--danger);
}

.message-info {
    background: linear-gradient(135deg, #667eea15 0%, #764ba215 100%);
    color: var(--primary-dark);
    border-left-color: var(--primary);
}

/* Form Groups */
.form-group {
    margin-bottom: 22px; 
    position: relative;
}

.form-label {
    display: block;
    color: var(--dark);
    font-size: 12px; 
    font-weight: 600;
    margin-bottom: 8px;
    padding-left: 4px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    display: flex;
    align-items: center;
    gap: 6px; 
}

.form-label i {
    color: var(--primary);
    font-size: 13px; 
}

.input-container {
    position: relative;
}

.input-icon {
    position: absolute;
    left: 16px; 
    top: 50%;
    transform: translateY(-50%);
    color: var(--gray);
    font-size: 16px; 
    transition: color 0.2s ease;
}

.profile-input {
    width: 100%;
    padding: 14px 18px 14px 48px;
    border: 2px solid var(--gray-light);
    border-radius: 10px; 
    font-size: 14px;
    color: var(--dark);
    background: var(--light);
    transition: all 0.3s ease;
    box-sizing: border-box;
    font-family: inherit;
}

.profile-input:hover {
    border-color: var(--primary);
    background: white;
}

.profile-input:focus {
    outline: none;
    border-color: var(--primary);
    background: white;
    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15); 
}

.profile-input[readonly] {
    background: #f1f5f9;
    border-color: #e2e8f0;
    color: var(--gray);
    cursor: not-allowed;
}

.profile-input[readonly]:hover {
    border-color: #e2e8f0;
    background: #f1f5f9;
}

/* Validation */
.validator {
    display: block;
    color: var(--danger);
    font-size: 11px; 
    margin-top: 5px; 
    padding-left: 4px;
    animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

/* Button Group */
.button-group {
    display: flex;
    gap: 12px; 
    margin-top: 35px; 
    padding-top: 25px; 
    border-top: 1px solid var(--gray-light);
}

.btn {
    flex: 1;
    padding: 14px 20px;
    border: none;
    border-radius: 10px; 
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    text-align: center;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 6px; 
}

.btn::after {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    width: 5px;
    height: 5px;
    background: rgba(255, 255, 255, 0.5);
    opacity: 0;
    border-radius: 100%;
    transform: scale(1, 1) translate(-50%);
    transform-origin: 50% 50%;
}

.btn:focus:not(:active)::after {
    animation: ripple 1s ease-out;
}

@keyframes ripple {
    0% {
        transform: scale(0, 0);
        opacity: 0.5;
    }
    100% {
        transform: scale(20, 20);
        opacity: 0;
    }
}

.btn-edit {
    background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
    color: white;
    box-shadow: 0 3px 10px rgba(102, 126, 234, 0.25); 
}

.btn-edit:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.35); 
}

.btn-save {
    background: linear-gradient(135deg, var(--success) 0%, var(--success-dark) 100%);
    color: white;
    box-shadow: 0 3px 10px rgba(16, 185, 129, 0.25); 
}

.btn-save:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(16, 185, 129, 0.35); 
}

.btn-cancel {
    background: linear-gradient(135deg, var(--danger) 0%, var(--danger-dark) 100%);
    color: white;
    box-shadow: 0 3px 10px rgba(239, 68, 68, 0.25); 
}

.btn-cancel:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(239, 68, 68, 0.35); 
}

/* Responsive Design */
@media (max-width: 768px) {
    .profile-wrapper {
        padding: 20px 12px; 
    }
    
    .profile-header {
        padding: 25px 20px; 
    }
    
    .profile-content {
        padding: 25px 20px; 
    }
    
    .avatar-container {
        width: 70px; 
        height: 70px; 
    }
    
    .avatar i {
        font-size: 36px; 
    }
    
    .profile-title {
        font-size: 22px; 
    }
}

@media (max-width: 576px) {
    .button-group {
        flex-direction: column;
        gap: 10px; 
    }
    
    .btn {
        padding: 13px 18px; 
    }
    
    .profile-content {
        padding: 20px 18px;
    }
    
    .profile-input {
        padding: 12px 14px 12px 45px; 
    }
}

/* Loading Animation */
.btn.loading {
    pointer-events: none;
    opacity: 0.8;
}

.btn.loading::before {
    content: '';
    width: 14px; 
    height: 14px; 
    border: 2px solid rgba(255, 255, 255, 0.3);
    border-top-color: white;
    border-radius: 50%;
    animation: spin 0.6s linear infinite;
    margin-right: 6px; 
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

/* Status Badge */
.status-badge {
    display: inline-block;
    padding: 5px 10px; 
    background: linear-gradient(135deg, #10b98115 0%, #05966915 100%);
    color: var(--success-dark);
    border-radius: 18px;
    font-size: 11px;
    font-weight: 600;
    margin-left: 8px;
    border: 1px solid rgba(16, 185, 129, 0.2);
}
</style>

<div class="profile-wrapper">
    <div class="profile-card">
        <!-- Header -->
        <div class="profile-header">
            <div class="avatar-container">
                <div class="avatar">
                    <i class="fas fa-user-circle"></i>
                </div>
            </div>
            <h1 class="profile-title">My Profile</h1>
            <p class="profile-subtitle">Manage your personal information</p>
        </div>
        
        <!-- Content -->
        <div class="profile-content">
            <!-- Message -->
            <asp:Label ID="lblMsg" runat="server" CssClass="message-box message-info" Visible="false"></asp:Label>
            
            <!-- First Name -->
            <div class="form-group">
                <label class="form-label" for="<%= txtFirstName.ClientID %>">
                    <i class="fas fa-user"></i>
                    FIRST NAME
                </label>
                <div class="input-container">
                    <div class="input-icon">
                        <i class="fas fa-id-card"></i>
                    </div>
                    <asp:TextBox ID="txtFirstName" runat="server" 
                        CssClass="profile-input"
                        ReadOnly="true"
                        placeholder="Enter your first name"
                        MaxLength="50"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                    ControlToValidate="txtFirstName"
                    ErrorMessage="First name is required"
                    CssClass="validator"
                    Display="Dynamic"
                    Enabled="false">
                </asp:RequiredFieldValidator>
            </div>
            
            <!-- Last Name -->
            <div class="form-group">
                <label class="form-label" for="<%= txtLastName.ClientID %>">
                    <i class="fas fa-user-tag"></i>
                    LAST NAME
                </label>
                <div class="input-container">
                    <div class="input-icon">
                        <i class="fas fa-id-card-alt"></i>
                    </div>
                    <asp:TextBox ID="txtLastName" runat="server" 
                        CssClass="profile-input"
                        ReadOnly="true"
                        placeholder="Enter your last name"
                        MaxLength="50"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                    ControlToValidate="txtLastName"
                    ErrorMessage="Last name is required"
                    CssClass="validator"
                    Display="Dynamic"
                    Enabled="false">
                </asp:RequiredFieldValidator>
            </div>
            
            <!-- Email -->
            <div class="form-group">
                <label class="form-label" for="<%= txtEmail.ClientID %>">
                    <i class="fas fa-envelope"></i>
                    EMAIL ADDRESS
                </label>
                <div class="input-container">
                    <div class="input-icon">
                        <i class="fas fa-at"></i>
                    </div>
                    <asp:TextBox ID="txtEmail" runat="server" 
                        CssClass="profile-input"
                        ReadOnly="true"
                        placeholder="your.email@example.com"
                        TextMode="Email"
                        MaxLength="100"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                    ControlToValidate="txtEmail"
                    ErrorMessage="Email is required"
                    CssClass="validator"
                    Display="Dynamic"
                    Enabled="false">
                </asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail"
                    ErrorMessage="Please enter a valid email address"
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                    CssClass="validator"
                    Display="Dynamic"
                    Enabled="false">
                </asp:RegularExpressionValidator>
            </div>
            
            <!-- Buttons -->
            <div class="button-group">
                <asp:Button ID="btnEdit" runat="server" Text="EDIT PROFILE" 
                    CssClass="btn btn-edit" 
                    OnClick="btnEdit_Click" 
                    CausesValidation="false" />
                    
                <asp:Button ID="btnSave" runat="server" Text="SAVE CHANGES" 
                    CssClass="btn btn-save" 
                    Visible="false" 
                    OnClick="btnSave_Click" />
                    
                <asp:Button ID="btnCancel" runat="server" Text="CANCEL" 
                    CssClass="btn btn-cancel" 
                    Visible="false" 
                    OnClick="btnCancel_Click" 
                    CausesValidation="false" />
            </div>
        </div>
    </div>
</div>

<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<!-- JavaScript for enhanced UX -->
<script>
    function showLoading(button) {
        button.classList.add('loading');
        button.innerHTML = '<span>Processing...</span>';
    }

    // Add input focus effects
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.profile-input');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('.input-icon').style.color = '#667eea';
            });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.querySelector('.input-icon').style.color = '#64748b';
                }
            });
        });

        // Prevent form submission on Enter key in readonly mode
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                const readonlyInputs = document.querySelectorAll('.profile-input[readonly]');
                if (readonlyInputs.length > 0 && document.activeElement && 
                    document.activeElement.classList.contains('profile-input') && 
                    document.activeElement.readOnly) {
                    e.preventDefault();
                }
            }
        });
    });
</script>
</asp:Content>