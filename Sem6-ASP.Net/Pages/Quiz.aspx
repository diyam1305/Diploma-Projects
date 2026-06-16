<%@ Page Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="Quiz_Management_System.Pages.Quiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- SweetAlert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    function showSaveConfirm() {
        if (!Page_ClientValidate('quiz')) {
            Swal.fire({
                icon: 'warning',
                title: 'Validation Error',
                text: 'Please fill all required fields correctly.'
            });
            return false;
        }

        Swal.fire({
            title: "Do you want to save the changes?",
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: "Save",
            denyButtonText: "Don't save"
        }).then((result) => {
            if (result.isConfirmed) {
                __doPostBack('<%= btnAdd.UniqueID %>', '');
        }
    });

        return false;
    }

    function showDeleteConfirm(btn) {
        Swal.fire({
            title: "Are you sure?",
            text: "This quiz will be permanently deleted!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#ff4d4d",
            confirmButtonText: "Yes, delete it!"
        }).then((result) => {
            if (result.isConfirmed) {
                __doPostBack(btn.name, '');
            }
        });
        return false;
    }

    function showSuccess(msg) {
        Swal.fire({
            icon: "success",
            title: msg,
            timer: 2000,
            showConfirmButton: false
        });
    }
</script>

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #f5f7fb;
        min-height: 100vh;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .container {
        max-width: 1300px;
        margin: 30px auto;
        padding: 20px;
    }

    .page-title {
        font-size: 28px;
        font-weight: 600;
        text-align: left;
        margin-bottom: 30px;
        color: #2c3e50;
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .page-title i {
        background: #4c8bf5;
        color: #ffffff;
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
    }

    .form-box, .grid-box {
        background: #ffffff;
        padding: 25px 30px;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        margin-bottom: 30px;
        border: 1px solid #e8ecf4;
    }

    .form-title {
        font-size: 20px;
        font-weight: 600;
        padding: 15px 20px;
        border-radius: 10px;
        background: #4c8bf5;
        color: white;
        margin-bottom: 25px;
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .form-title i {
        font-size: 18px;
    }

    .form-label {
        color: #4c8bf5;
        font-weight: 500;
        display: block;
        margin-bottom: 8px;
        font-size: 14px;
    }

    .form-control {
        width: 100%;
        padding: 12px 16px;
        border-radius: 8px;
        border: 1px solid #d1d9e6;
        font-size: 14px;
        outline: none;
        transition: all 0.2s ease;
        background: #f9fafc;
    }

    .form-control:focus {
        border-color: #4c8bf5;
        box-shadow: 0 0 0 3px rgba(76, 139, 245, 0.1);
        background: white;
    }

    .btn {
        background: #4c8bf5;
        color: #fff;
        padding: 12px 24px;
        border: none;
        border-radius: 8px;
        font-size: 14px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn:hover {
        background: #3a73e8;
        transform: translateY(-1px);
    }

    .btn-add {
        background: #00b894;
    }

    .btn-add:hover {
        background: #00a085;
    }

    .grid-container {
        overflow-x: auto;
        border-radius: 10px;
        border: 1px solid #e8ecf4;
    }

    .gridview-style {
        width: 100%;
        border-collapse: collapse;
        background: white;
    }

    .gridview-style th {
        background: #f8fafd;
        color: #4c8bf5;
        padding: 16px 12px;
        font-size: 14px;
        font-weight: 600;
        text-align: center;
        border-bottom: 2px solid #e8ecf4;
    }

    .gridview-style td {
        background: #ffffff;
        padding: 14px 12px;
        font-size: 13px;
        text-align: center;
        border-bottom: 1px solid #f0f3f9;
        vertical-align: middle;
    }

    .gridview-style tr:hover td {
        background: #f8fafd;
    }

    .gridview-style tr:nth-child(even) td {
        background: #fbfcff;
    }

    .action-cell {
        display: flex;
        gap: 8px;
        justify-content: center;
        flex-wrap: wrap;
    }

    .grid-btn {
        padding: 6px 16px;
        border-radius: 6px;
        font-weight: 500;
        border: none;
        cursor: pointer;
        transition: 0.2s;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
        font-size: 12px;
        min-width: 70px;
    }

    .grid-btn.edit {
        background: #4c8bf5;
        color: #fff;
    }

    .grid-btn.delete {
        background: #ff4d4d;
        color: #fff;
    }

    .grid-btn.view {
        background: #00b894;
        color: #fff;
    }

    .grid-btn:hover {
        transform: translateY(-1px);
        opacity: 0.9;
    }

    .btn-group {
        display: flex;
        gap: 12px;
        justify-content: center;
        margin-top: 25px;
    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
    }

    .quiz-card {
        background: #f8fafd;
        border-radius: 10px;
        padding: 20px;
        border: 1px solid #e8ecf4;
        transition: all 0.2s ease;
    }

    .quiz-card:hover {
        background: white;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .quiz-icon {
        width: 50px;
        height: 50px;
        border-radius: 10px;
        background: #4c8bf5;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 22px;
        margin-bottom: 15px;
    }

    .quiz-info h4 {
        margin: 0 0 10px 0;
        color: #2c3e50;
        font-size: 16px;
        font-weight: 600;
    }

    .quiz-meta {
        display: flex;
        flex-wrap: wrap;
        gap: 15px;
        font-size: 12px;
        color: #718096;
    }

    .quiz-meta span {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    /* Minimized Pagination */
    .pager-container {
        display: flex;
        justify-content: center;
        padding: 20px;
        background: white;
        border-top: 1px solid #e8ecf4;
    }

    .pager {
        display: flex;
        gap: 8px;
        align-items: center;
    }

    .pager a, .pager span {
        display: flex;
        align-items: center;
        justify-content: center;
        min-width: 36px;
        height: 36px;
        padding: 0 12px;
        border-radius: 8px;
        background: #f8fafd;
        color: #4c8bf5;
        text-decoration: none;
        font-weight: 500;
        font-size: 13px;
        transition: all 0.2s ease;
    }

    .pager a:hover {
        background: #4c8bf5;
        color: white;
    }

    .pager span {
        background: #4c8bf5;
        color: white;
        cursor: default;
    }

    @media (max-width: 768px) {
        .container {
            padding: 15px;
            margin: 15px auto;
        }

        .page-title {
            font-size: 22px;
        }

        .form-box, .grid-box {
            padding: 20px 15px;
        }

        .form-grid {
            grid-template-columns: 1fr;
        }

        .action-cell {
            flex-direction: column;
            align-items: center;
        }

        .grid-btn {
            width: 100%;
        }

        .btn-group {
            flex-direction: column;
        }

        .btn-group .btn {
            width: 100%;
        }

        .quiz-card {
            text-align: center;
        }

        .quiz-meta {
            justify-content: center;
        }

        .pager a, .pager span {
            min-width: 32px;
            height: 32px;
            font-size: 12px;
            padding: 0 10px;
        }
    }

    @media (max-width: 480px) {
        .page-title {
            flex-direction: column;
            align-items: flex-start;
            gap: 10px;
        }

        .gridview-style th,
        .gridview-style td {
            padding: 10px 8px;
            font-size: 12px;
        }

        .action-cell {
            flex-direction: column;
            align-items: center;
        }

        .grid-btn {
            width: 100%;
        }

        .pager {
            flex-wrap: wrap;
            justify-content: center;
        }

        .pager a, .pager span {
            min-width: 30px;
            height: 30px;
            font-size: 11px;
            padding: 0 8px;
            margin: 2px;
        }
    }
</style>

<div class="container">
    <asp:UpdatePanel ID="updQuiz" runat="server">
    <ContentTemplate>

    <!-- Page Header -->
    <div class="page-title">
        <i class="fas fa-brain"></i>
        Quiz Management
    </div>

    <!-- Add New Quiz Form -->
    <div class="form-box">
        <div class="form-title">
            <i class="fas fa-plus-circle"></i>
            Add New Quiz
        </div>
        
        <!-- Hidden field to store QUIZ_ID for editing -->
        <asp:HiddenField ID="hdnQuizID" runat="server" />
        
        <div class="form-grid">
            <div class="form-group">
                <label class="form-label">Quiz Name</label>
                <asp:TextBox ID="txtQuizName" runat="server" CssClass="form-control" 
                    placeholder="Enter quiz name"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="rfvQuizName"
                    runat="server"
                    ControlToValidate="txtQuizName"
                    ErrorMessage="Quiz name is required"
                    Display="None"
                    ValidationGroup="quiz" />
            </div>
            
            <%--<div class="form-group">
                <label class="form-label">Total Questions</label>
                <asp:TextBox ID="txtTotal_Questions" runat="server" CssClass="form-control" TextMode="Number" placeholder="Enter total questions" min="1" max="100"></asp:TextBox>
                <asp:RequiredFieldValidator
                    ID="rfvTotalQuestions"
                    runat="server"
                    ControlToValidate="txtTotal_Questions"
                    ErrorMessage="Total questions is required"
                    Display="None"
                    ValidationGroup="quiz" />
                <asp:RangeValidator
                    ID="rvTotalQuestions"
                    runat="server"
                    ControlToValidate="txtTotal_Questions"
                    MinimumValue="1"
                    MaximumValue="1000"
                    Type="Integer"
                    ErrorMessage="Total questions must be greater than 0"
                    Display="None"
                    ValidationGroup="quiz" />

            </div>--%>
        </div>
        
        <div class="btn-group">
            <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-add" 
                Text="Add Quiz"
                OnClientClick="return showSaveConfirm();"
                OnClick="btnAdd_Click" />

            <asp:Button ID="btnClear" runat="server" CssClass="btn" 
                Text="Clear Form" OnClick="btnClear_Click" />
        </div>
    </div>

    <!-- Quiz GridView -->
    <div class="grid-box">
        <div class="form-title" style="background: #6c5ce7;">
            <i class="fas fa-list"></i>
            Manage Quizzes
        </div>
        
        <div class="grid-container">
            <asp:GridView ID="grdData" runat="server" CssClass="gridview-style"
                DataKeyNames="QUIZ_ID"
                AutoGenerateColumns="false"
                AllowPaging="true"
                PageSize="8"
                OnPageIndexChanging="grdData_PageIndexChanging"
                OnRowDeleting="grdData_RowDeleting"
                OnRowCommand="grdData_RowCommand"
                EmptyDataText="No quizzes found. Create your first quiz above!"
                PagerStyle-CssClass="pager-container">
                
                <Columns>
                    <asp:TemplateField HeaderText="Quiz Details">
                        <ItemTemplate>
                            <div class="quiz-card">
                                <div class="quiz-info">
                                    <h4>
                                        <asp:Label ID="lblQuizName" runat="server" Text='<%# Eval("QUIZ_NAME") %>'></asp:Label>
                                    </h4>
                                    <div class="quiz-meta">
                                        <span>
                                            <i class="fas fa-user"></i>
                                            User: <asp:Label ID="lblUserID" runat="server" Text='<%# Eval("USER_ID") %>'></asp:Label>
                                        </span>
                                        <span>
                                            <i class="fas fa-question-circle"></i>
                                            Questions: <asp:Label ID="lblTotalQuestions" runat="server" Text='<%# Eval("TOTAL_QUESTIONS") %>'></asp:Label>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Created">
                        <ItemTemplate>
                            <div style="text-align: center;">
                                <div style="font-weight: 600; color: #4c8bf5;">
                                    <%# Convert.ToDateTime(Eval("CREATED")).ToString("MMM dd") %>
                                </div>
                                <div style="font-size: 12px; color: #888;">
                                    <%# Convert.ToDateTime(Eval("CREATED")).ToString("yyyy") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Last Updated">
                        <ItemTemplate>
                            <div style="text-align: center;">
                                <div style="font-weight: 600; color: #6c5ce7;">
                                    <%# Convert.ToDateTime(Eval("MODIFIED")).ToString("MMM dd") %>
                                </div>
                                <div style="font-size: 12px; color: #888;">
                                    <%# Convert.ToDateTime(Eval("MODIFIED")).ToString("HH:mm") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="action-cell">
                                <asp:Button ID="btnEdit" runat="server" CssClass="grid-btn edit" 
                                    Text="Edit" CommandName="EditQuiz" 
                                    CommandArgument='<%# Container.DataItemIndex %>' />
                                <asp:Button ID="btnDelete" runat="server" CssClass="grid-btn delete"
                                    Text="Delete"
                                    CommandName="Delete"
                                    OnClientClick="return showDeleteConfirm(this);" />

                                <asp:Button ID="btnView" runat="server" CssClass="grid-btn view" 
                                    Text="View" CommandName="ViewQuiz" 
                                    CommandArgument='<%# Eval("QUIZ_ID") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</div>
</ContentTemplate>
</asp:UpdatePanel>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</asp:Content>
