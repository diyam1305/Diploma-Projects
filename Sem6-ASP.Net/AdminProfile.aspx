<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Dashboard.Master" CodeBehind="AdminProfile.aspx.cs" Inherits="Quiz_Management_System.AdminProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    :root {
    --primary: #4361ee;
    --primary-dark: #3a56d4;
    --secondary: #7209b7;
    --success: #4cc9f0;
    --success-dark: #00b4d8;
    --danger: #f72585;
    --danger-dark: #b5179e;
    --light: #f8fafc;
    --dark: #1a1a2e;
    --gray: #64748b;
    --gray-light: #e2e8f0;
    --shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
    --radius: 12px;
}

.profile-wrapper {
    min-height: calc(100vh - 100px);
    background: transparent;
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
    margin: 0 auto;
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
    margin: 15px 0 6px 0; 
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

.btn-edit {
    background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
    color: white;
    box-shadow: 0 3px 10px rgba(67, 97, 238, 0.25); 
}

.btn-edit:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(67, 97, 238, 0.35); 
}

.btn-save {
    background: linear-gradient(135deg, var(--success) 0%, var(--success-dark) 100%);
    color: white;
    box-shadow: 0 3px 10px rgba(76, 201, 240, 0.25); 
}

.btn-save:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(76, 201, 240, 0.35); 
}

.btn-cancel {
    background: linear-gradient(135deg, var(--danger) 0%, var(--danger-dark) 100%);
    color: white;
    box-shadow: 0 3px 10px rgba(247, 37, 133, 0.25); 
}

.btn-cancel:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(247, 37, 133, 0.35); 
}
</style>

<div class="profile-wrapper">
    <div class="profile-card">
        <!-- Header -->
        <div class="profile-header">
            <div class="avatar-container">
                <div class="avatar">
                    <i class="fas fa-user-shield"></i>
                </div>
            </div>
            <h1 class="profile-title">Admin Profile</h1>
            <p class="profile-subtitle">View your admin information</p>
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

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const inputs = document.querySelectorAll('.profile-input');
        inputs.forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.querySelector('.input-icon').style.color = '#4361ee';
            });
            
            input.addEventListener('blur', function() {
                if (!this.value) {
                    this.parentElement.querySelector('.input-icon').style.color = '#64748b';
                }
            });
        });
    });
</script>

</asp:Content>
