<%--<%@ Page Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="QuizWiseQuestions.aspx.cs" Inherits="Quiz_Management_System.Pages.QuizWiseQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script type="text/javascript">
    function showDeleteConfirm(btn) {
        Swal.fire({
            title: "Are you sure?",
            text: "This question will be permanently deleted!",
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

    function showDeleteSuccess() {
        Swal.fire({
            icon: "success",
            title: "Deleted!",
            text: "Question deleted successfully.",
            timer: 2000,
            showConfirmButton: false
        });
    }

    function showSelectQuizWarning() {
        Swal.fire({
            icon: 'warning',
            title: 'Please select a quiz first.'
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
        text-decoration: none !important;
    }

    .btn:hover {
        background: #3a73e8;
        transform: translateY(-1px);
        text-decoration: none !important;
    }

    .btn-add {
        background: #00b894;
    }

    .btn-add:hover {
        background: #00a085;
        text-decoration: none !important;
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

    .grid-btn.delete {
        background: #ff4d4d;
        color: #fff;
    }

    .grid-btn:hover {
        transform: translateY(-1px);
        opacity: 0.9;
    }

    .form-row {
        display: flex;
        gap: 20px;
        align-items: flex-end;
        margin-bottom: 20px;
    }

    .form-group {
        flex: 1;
    }

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
        text-decoration: none;
    }

    .pager span {
        background: #4c8bf5;
        color: white;
        cursor: default;
    }

    .quiz-info-card {
        background: #f8fafd;
        border-radius: 10px;
        padding: 20px;
        margin-top: 20px;
        border: 1px solid #e8ecf4;
    }

    .quiz-info-header {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 10px;
    }

    .quiz-info-header i {
        color: #4c8bf5;
        font-size: 20px;
    }

    .quiz-info-header h3 {
        margin: 0;
        color: #2c3e50;
        font-size: 18px;
    }

    .quiz-meta {
        display: flex;
        gap: 15px;
        font-size: 14px;
        color: #718096;
    }

    .quiz-meta span {
        display: flex;
        align-items: center;
        gap: 5px;
    }

    .empty-state {
        padding: 60px 20px;
        text-align: center;
        color: #718096;
    }

    .empty-icon {
        font-size: 48px;
        color: #cbd5e0;
        margin-bottom: 15px;
    }

    @media (max-width: 768px) {
        .container {
            padding: 15px;
        }
        .form-row {
            flex-direction: column;
        }
        .action-cell {
            flex-direction: column;
        }
        .quiz-meta {
            flex-direction: column;
            gap: 8px;
        }
    }
</style>

<div class="container">
    <!-- Page Header -->
    <div class="page-title">
        <i class="fas fa-question-circle"></i>
        Quiz Wise Questions
    </div>

    <!-- Select Quiz Form -->
    <div class="form-box">
        <div class="form-title">
            <i class="fas fa-filter"></i>
            Select Quiz
        </div>
        
        <!-- Single row for dropdown and button -->
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Choose Quiz</label>
                <asp:DropDownList ID="ddlQuiz" runat="server"
                    CssClass="form-control"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlQuiz_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
            
            <div style="margin-bottom: 8px;">
                <asp:LinkButton ID="btnAddQuizWise" runat="server"
                    CssClass="btn btn-add"
                    OnClick="btnAddQuizWise_Click">
                    <i class="fas fa-plus-circle"></i> Add Quiz Wise Questions
                </asp:LinkButton>
            </div>
        </div>
    </div>

    <!-- Questions Grid -->
    <div class="grid-box" id="gridBox" runat="server" visible="false">
        <div class="form-title" style="background: #6c5ce7;">
            <i class="fas fa-list"></i>
            Questions List
        </div>
        
        <div class="grid-container">
            <asp:GridView ID="grdQuizWise" runat="server"
                CssClass="gridview-style"
                AutoGenerateColumns="False"
                AllowPaging="true"
                PageSize="8"
                DataKeyNames="QUIZWISEQUESTION_ID"
                OnPageIndexChanging="grdQuizWise_PageIndexChanging"
                OnRowCommand="grdQuizWise_RowCommand"
                OnRowDataBound="grdQuizWise_RowDataBound"
                PagerStyle-CssClass="pager-container"
                EmptyDataText="No questions found for the selected quiz">
                
                <Columns>
                    <asp:TemplateField HeaderText="Sr. No.">
                        <ItemTemplate>
                            <asp:Label ID="lblSrNo" runat="server"></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Width="80px" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Question Details">
                        <ItemTemplate>
                            <div style="text-align: left; max-width: 500px; margin: 0 auto;">
                                <div style="font-weight: 500; color: #2c3e50; margin-bottom: 5px;">
                                    <%# Eval("QUESTION_TEXT") %>
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
                        <HeaderStyle Width="100px" />
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
                        <HeaderStyle Width="100px" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="action-cell">
                                <asp:Button ID="btnDelete" runat="server"
                                    Text="Delete"
                                    CssClass="grid-btn delete"
                                    CommandName="DeleteQuestion"
                                    CommandArgument='<%# Eval("QUIZWISEQUESTION_ID") %>'
                                    OnClientClick="return showDeleteConfirm(this);" />
                            </div>
                        </ItemTemplate>
                        <HeaderStyle Width="100px" />
                    </asp:TemplateField>
                </Columns>
                
                <EmptyDataTemplate>
                    <div class="empty-state">
                        <div class="empty-icon">
                            <i class="far fa-file-alt"></i>
                        </div>
                        <h4>No Questions Found</h4>
                        <p>Select a quiz to view or add questions</p>
                    </div>
                </EmptyDataTemplate>  
            </asp:GridView>
        </div>
    </div>
</div>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</asp:Content>--%>





<%@ Page Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="QuizWiseQuestions.aspx.cs"
    Inherits="Quiz_Management_System.Pages.QuizWiseQuestions" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <script type="text/javascript">
            function showDeleteConfirm(btn) {
                Swal.fire({
                    title: "Are you sure?",
                    text: "This question will be permanently deleted!",
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

            function showDeleteSuccess() {
                Swal.fire({
                    icon: "success",
                    title: "Deleted!",
                    text: "Question deleted successfully.",
                    timer: 2000,
                    showConfirmButton: false
                });
            }

            function showSelectQuizWarning() {
                Swal.fire({
                    icon: 'warning',
                    title: 'Please select a quiz first.'
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

            .form-box,
            .grid-box {
                background: #ffffff;
                padding: 25px 30px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
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
                text-decoration: none !important;
            }

            .btn:hover {
                background: #3a73e8;
                transform: translateY(-1px);
                text-decoration: none !important;
            }

            .btn-add {
                background: #00b894;
            }

            .btn-add:hover {
                background: #00a085;
                text-decoration: none !important;
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

            .grid-btn.delete {
                background: #ff4d4d;
                color: #fff;
            }

            .grid-btn:hover {
                transform: translateY(-1px);
                opacity: 0.9;
            }

            .form-row {
                display: flex;
                gap: 20px;
                align-items: flex-end;
                margin-bottom: 20px;
            }

            .form-group {
                flex: 1;
            }

            .pager-container {
                background: #f8fafd;
                padding: 12px 15px !important;
                border-top: 1px solid #e8ecf4;
                text-align: center;
            }

            .pager-container table {
                margin: 0 auto;
                border-collapse: separate;
                border-spacing: 3px;
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
                min-width: 28px;
                height: 28px;
                padding: 0 6px;
                border-radius: 5px;
                font-size: 11px;
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
                min-width: 25px;
                height: 25px;
                font-size: 10px;
                margin: 0 1px;
            }

            .pager-container .pager-navigation a {
                padding: 0 8px;
                min-width: 60px;
            }

            .quiz-info-card {
                background: #f8fafd;
                border-radius: 10px;
                padding: 20px;
                margin-top: 20px;
                border: 1px solid #e8ecf4;
            }

            .quiz-info-header {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 10px;
            }

            .quiz-info-header i {
                color: #4c8bf5;
                font-size: 20px;
            }

            .quiz-info-header h3 {
                margin: 0;
                color: #2c3e50;
                font-size: 18px;
            }

            .quiz-meta {
                display: flex;
                gap: 15px;
                font-size: 14px;
                color: #718096;
            }

            .quiz-meta span {
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .empty-state {
                padding: 60px 20px;
                text-align: center;
                color: #718096;
            }

            .empty-icon {
                font-size: 48px;
                color: #cbd5e0;
                margin-bottom: 15px;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                }

                .form-row {
                    flex-direction: column;
                }

                .action-cell {
                    flex-direction: column;
                }

                .quiz-meta {
                    flex-direction: column;
                    gap: 8px;
                }

                .pager-container {
                    padding: 10px 12px !important;
                }

                .pager-container a,
                .pager-container span {
                    min-width: 25px;
                    height: 25px;
                    font-size: 10px;
                    padding: 0 5px;
                }

                .pager-container .pager-numbers a,
                .pager-container .pager-numbers span {
                    min-width: 23px;
                    height: 23px;
                    font-size: 9px;
                }

                .pager-container .pager-navigation a {
                    min-width: 55px;
                    padding: 0 6px;
                }
            }

            @media (max-width: 480px) {
                .pager-container {
                    padding: 8px 10px !important;
                }

                .pager-container a,
                .pager-container span {
                    min-width: 23px;
                    height: 23px;
                    font-size: 9px;
                    padding: 0 4px;
                    margin: 1px;
                }

                .pager-container .pager-numbers a,
                .pager-container .pager-numbers span {
                    min-width: 22px;
                    height: 22px;
                }

                .pager-container .pager-navigation a {
                    min-width: 50px;
                    padding: 0 5px;
                }
            }
        </style>

        <div class="container">
            <!-- Page Header -->
            <div class="page-title">
                <i class="fas fa-question-circle"></i>
                Quiz Wise Questions
            </div>

            <!-- Select Quiz Form -->
            <div class="form-box">
                <div class="form-title">
                    <i class="fas fa-filter"></i>
                    Select Quiz
                </div>

                <!-- Single row for dropdown and button -->
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Choose Quiz</label>
                        <asp:DropDownList ID="ddlQuiz" runat="server" CssClass="form-control" AutoPostBack="true"
                            OnSelectedIndexChanged="ddlQuiz_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>

                    <div style="margin-bottom: 8px;">
                        <asp:LinkButton ID="btnAddQuizWise" runat="server" CssClass="btn btn-add"
                            OnClick="btnAddQuizWise_Click">
                            <i class="fas fa-plus-circle"></i> Add Quiz Wise Questions
                        </asp:LinkButton>
                    </div>
                </div>
            </div>

            <!-- Questions Grid -->
            <div class="grid-box" id="gridBox" runat="server" visible="false">
                <div class="form-title" style="background: #6c5ce7;">
                    <i class="fas fa-list"></i>
                    Questions List
                </div>

                <div class="grid-container">
                    <asp:GridView ID="grdQuizWise" runat="server" CssClass="gridview-style" AutoGenerateColumns="False"
                        AllowPaging="true" PageSize="8" DataKeyNames="QUIZWISEQUESTION_ID"
                        OnPageIndexChanging="grdQuizWise_PageIndexChanging" OnRowCommand="grdQuizWise_RowCommand"
                        OnRowDataBound="grdQuizWise_RowDataBound" PagerStyle-CssClass="pager-container"
                        EmptyDataText="No questions found for the selected quiz">

                        <Columns>
                            <asp:TemplateField HeaderText="Sr. No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Question Details">
                                <ItemTemplate>
                                    <div style="text-align: left; max-width: 500px; margin: 0 auto;">
                                        <div style="font-weight: 500; color: #2c3e50; margin-bottom: 5px;">
                                            <%# Eval("QUESTION_TEXT") %>
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
                                <HeaderStyle Width="100px" />
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
                                <HeaderStyle Width="100px" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="action-cell">
                                        <asp:Button ID="btnDelete" runat="server" Text="Delete"
                                            CssClass="grid-btn delete" CommandName="DeleteQuestion"
                                            CommandArgument='<%# Eval("QUIZWISEQUESTION_ID") %>'
                                            OnClientClick="return showDeleteConfirm(this);" />
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                            </asp:TemplateField>
                        </Columns>

                        <EmptyDataTemplate>
                            <div class="empty-state">
                                <div class="empty-icon">
                                    <i class="far fa-file-alt"></i>
                                </div>
                                <h4>No Questions Found</h4>
                                <p>Select a quiz to view or add questions</p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </asp:Content>