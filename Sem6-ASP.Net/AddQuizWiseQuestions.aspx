<%@ Page Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="AddQuizWiseQuestions.aspx.cs" Inherits="Quiz_Management_System.Pages.AddQuizWiseQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

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

    .input-box {
        width: 100%;
        padding: 12px 16px;
        border-radius: 8px;
        border: 1px solid #d1d9e6;
        font-size: 14px;
        outline: none;
        transition: all 0.2s ease;
        background: #f9fafc;
    }

    .input-box:focus {
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

    .btn-save {
        background: #00b894;
        padding: 14px 32px;
        font-size: 15px;
    }

    .btn-save:hover {
        background: #00a085;
    }

    .btn-cancel {
        background: #ff9e00;
        margin-left: 15px;
    }

    .btn-cancel:hover {
        background: #e68a00;
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

    .btn-group {
        display: flex;
        gap: 12px;
        justify-content: center;
        margin-top: 25px;
    }

    /* Form Dropdown Styles */
    .form-dropdown {
        width: 100%;
        padding: 12px 16px;
        border-radius: 8px;
        border: 1px solid #d1d9e6;
        font-size: 14px;
        outline: none;
        transition: all 0.2s ease;
        background: #f9fafc;
        cursor: pointer;
    }

    .form-dropdown:focus {
        border-color: #4c8bf5;
        box-shadow: 0 0 0 3px rgba(76, 139, 245, 0.1);
        background: white;
    }

    /* Question Card Styling */
    .question-card {
        background: #f8fafd;
        border-radius: 10px;
        padding: 15px;
        border: 1px solid #e8ecf4;
        transition: all 0.2s ease;
    }

    .question-card:hover {
        background: white;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
    }

    .question-icon {
        width: 40px;
        height: 40px;
        border-radius: 8px;
        background: #4c8bf5;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 18px;
        margin-bottom: 10px;
    }

    .question-text {
        font-weight: 500;
        color: #2c3e50;
        font-size: 14px;
        margin-bottom: 8px;
        line-height: 1.4;
        word-wrap: break-word;
        white-space: normal;
    }

    .question-id {
        font-size: 11px;
        color: #718096;
        background: #f0f4ff;
        padding: 3px 8px;
        border-radius: 12px;
        display: inline-block;
        font-weight: 500;
    }

    /* Checkbox Styling */
    .checkbox-container {
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 8px;
    }

    .custom-checkbox {
        width: 32px;
        height: 32px;
        border: 2px solid #e1e8f1;
        border-radius: 5px;
        background: white;
        cursor: pointer;
        transition: all 0.2s ease;
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .custom-checkbox:hover {
        border-color: #4c8bf5;
        background: #f0f4ff;
    }

    .custom-checkbox input[type="checkbox"] {
        position: absolute;
        opacity: 0;
        cursor: pointer;
        width: 100%;
        height: 100%;
    }

    .checkmark {
        width: 18px;
        height: 18px;
        background: #00b894;
        border-radius: 2px;
        opacity: 0;
        transition: all 0.2s ease;
    }

    .custom-checkbox input[type="checkbox"]:checked ~ .checkmark {
        opacity: 1;
    }

    .pager-container {
        background: #f8fafd;
        padding: 15px 20px !important;
        border-top: 1px solid #e8ecf4;
        text-align: center;
    }

    .pager-container table {
        margin: 0 auto;
        border-collapse: separate;
        border-spacing: 4px;
    }

    .pager-container td {
        padding: 2px !important;
        border: none !important;
        background: transparent !important;
    }

    .pager-container a,
    .pager-container span {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 32px;
        height: 32px;
        padding: 0 8px;
        border-radius: 6px;
        font-size: 12px;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .pager-container a {
        background: #ffffff;
        color: #4c8bf5;
        border: 1px solid #e1e8f1;
    }

    .pager-container a:hover {
        background: #4c8bf5;
        color: white;
        border-color: #4c8bf5;
        transform: translateY(-1px);
    }

    .pager-container span {
        background: #4c8bf5;
        color: white;
        border: 1px solid #4c8bf5;
        cursor: default;
    }

    .pager-container .pager-numbers a,
    .pager-container .pager-numbers span {
        min-width: 28px;
        height: 28px;
        font-size: 11px;
        margin: 0 1px;
    }

    /* Navigation buttons (First, Previous, Next, Last) */
    .pager-container .pager-navigation a {
        padding: 0 10px;
        min-width: 70px;
    }

    /* Empty State */
    .empty-state {
        text-align: center;
        padding: 40px 20px;
        color: #718096;
    }

    .empty-state i {
        font-size: 36px;
        color: #e1e8f1;
        margin-bottom: 15px;
    }

    .empty-state h4 {
        font-size: 16px;
        color: #2c3e50;
        margin-bottom: 10px;
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

        .btn-group {
            flex-direction: column;
        }

        .btn-group .btn {
            width: 100%;
            margin-left: 0 !important;
        }

        .question-card {
            text-align: center;
        }

        .pager-container {
            padding: 12px 15px !important;
        }

        .pager-container a,
        .pager-container span {
            min-width: 28px;
            height: 28px;
            font-size: 11px;
            padding: 0 6px;
        }

        .pager-container .pager-numbers a,
        .pager-container .pager-numbers span {
            min-width: 26px;
            height: 26px;
            font-size: 10px;
        }

        .pager-container .pager-navigation a {
            min-width: 60px;
            padding: 0 8px;
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

        .pager-container {
            padding: 10px !important;
        }

        .pager-container a,
        .pager-container span {
            min-width: 26px;
            height: 26px;
            font-size: 10px;
            padding: 0 5px;
            margin: 1px;
        }

        .pager-container .pager-numbers a,
        .pager-container .pager-numbers span {
            min-width: 24px;
            height: 24px;
        }

        .pager-container .pager-navigation a {
            min-width: 50px;
            padding: 0 6px;
        }
    }
</style>


<div class="container">
    <asp:UpdatePanel ID="addques" runat="server">
<ContentTemplate>
    <!-- Page Header -->
    <div class="page-title">
        <i class="fas fa-plus-circle"></i>
        Add Questions to Quiz
    </div>

    <!-- Quiz Selection Form -->
    <div class="form-box">
        <div class="form-title">
            <i class="fas fa-clipboard-list"></i>
            Select Quiz
        </div>
        
        <label class="form-label">Select Quiz</label>
        <asp:DropDownList ID="ddlQuiz"
            runat="server"
            CssClass="form-dropdown"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlQuiz_SelectedIndexChanged">
            <asp:ListItem Value="0" Text="-- Select Quiz --"></asp:ListItem>
        </asp:DropDownList>

    </div>

    <!-- Questions Grid -->
    <div class="grid-box">
        <div class="form-title" style="background: #6c5ce7;">
            <i class="fas fa-question-circle"></i>
            Available Questions
        </div>
        
        <div class="grid-container">
            <asp:GridView ID="grdQuestions" runat="server" AutoGenerateColumns="False"
                CssClass="gridview-style" DataKeyNames="QUESTION_ID"
                EmptyDataText="No questions available. Please add questions first!"
                EmptyDataRowStyle-CssClass="empty-state"
                OnRowDataBound="grdQuestions_RowDataBound">
                
                <Columns>
                    <asp:TemplateField HeaderText="Question">
                        <ItemTemplate>
                            <div class="question-card">
                                <div class="question-icon">
                                    <i class="fas fa-question"></i>
                                </div>
                                <div>
                                    <div class="question-text">
                                        <%# Eval("QUESTION_TEXT") %>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

            <asp:TemplateField HeaderText="Select">
                <ItemTemplate>
                    <div class="checkbox-container">
                        <label class="custom-checkbox">
                            <asp:CheckBox ID="chkSelect" runat="server" />
                            <span class="checkmark"></span>
                        </label>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>


                </Columns>
            </asp:GridView>
        </div>
    </div>

    <!-- Action Buttons -->
    <div class="btn-group">
        <asp:Button ID="btnSave" runat="server" CssClass="btn btn-save" 
            Text="Save Questions" OnClick="btnSave_Click" />
        <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-cancel" 
            Text="Cancel" OnClick="btnCancel_Click" />
    </div>

</div>
    </ContentTemplate>
        </asp:UpdatePanel>

    <script>
    function showResultAlert(added, removed) {
        Swal.fire({
            title: "Changes Saved",
            html: `<b>Added:</b> ${added} questions<br/><b>Removed:</b> ${removed} questions`,
            icon: "success",
            confirmButtonText: "OK"
        });
    }
    </script>


<!-- Add Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
