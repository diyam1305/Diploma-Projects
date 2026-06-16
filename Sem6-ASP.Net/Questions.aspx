<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="Questions.aspx.cs" Inherits="Quiz_Management_System.Questions" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
        font-size: 15px; 
        font-weight: 600;
        text-align: left;
        margin-bottom: 25px; 
        color: #2c3e50;
        display: flex;
        align-items: center;
        gap: 12px; 
    }

    .page-title i {
        background: #4c8bf5;
        color: #ffffff;
        width: 45px; 
        height: 45px; 
        border-radius: 10px; 
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px; 
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

    .form-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 20px;
        margin-bottom: 20px;
    }

    .form-group {
        margin-bottom: 0;
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
        text-decoration: none;
    }

    .btn:hover {
        background: #3a73e8;
        transform: translateY(-1px);
    }

    .btn-primary {
        background: #00b894;
    }

    .btn-primary:hover {
        background: #00a085;
    }

    .btn-secondary {
        background: #6c5ce7;
        margin-left: 15px;
    }

    .btn-secondary:hover {
        background: #5a4bd6;
    }

    .btn-excel {
        background: #217346;
        margin-bottom: 20px;
    }

    .btn-excel:hover {
        background: #1a5c37;
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

    .action-buttons {
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

    .btn-edit {
        background: #4c8bf5;
        color: #fff;
    }

    .btn-delete {
        background: #ff4d4d;
        color: #fff;
    }

    .grid-btn:hover {
        transform: translateY(-1px);
        opacity: 0.9;
    }

    /* Badges */
    .correct-badge {
        background: #d4f8e8;
        color: #00b894;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 500;
        display: inline-block;
    }

    .marks-badge {
        background: #fff4e5;
        color: #ff9e00;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 500;
        display: inline-block;
    }

    /* Question text */
    .question-text {
        font-weight: 500;
        color: #2c3e50;
        text-align: left;
        padding: 5px 0;
        word-wrap: break-word;
        white-space: normal;
        max-width: 400px;
    }

    .option-text {
        font-size: 13px;
        color: #666;
        text-align: left;
        padding: 3px 0;
        word-wrap: break-word;
        white-space: normal;
    }

    /* Radio Button List Styling */
    .radio-list {
        display: flex;
        gap: 15px;
        margin: 15px 0;
        flex-wrap: wrap;
    }

    .radio-item {
        display: flex;
        align-items: center;
        gap: 8px;
        padding: 8px 16px;
        background: #f8fafc;
        border-radius: 8px;
        border: 1px solid #e1e8f1;
        transition: all 0.2s ease;
        cursor: pointer;
    }

    .radio-item:hover {
        border-color: #4c8bf5;
        background: white;
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

    /* Button Group */
    .btn-group {
        display: flex;
        gap: 12px;
        justify-content: center;
        margin-top: 25px;
    }

    .full-width {
        grid-column: 1 / -1;
    }

    .question-textarea {
        min-height: 100px;
        resize: vertical;
    }

    @media (max-width: 768px) {
        .container {
            padding: 15px;
            margin: 15px auto;
        }

        .page-title {
            font-size: 20px; 
        }

        .form-box, .grid-box {
            padding: 20px 15px;
        }

        .form-row {
            grid-template-columns: 1fr;
        }

        .action-buttons {
            flex-direction: row;
        }

        .btn-group {
            flex-direction: column;
        }

        .btn-group .btn {
            width: 100%;
            margin-left: 0 !important;
        }

        .radio-list {
            flex-direction: column;
            gap: 10px;
        }

        .question-text, .option-text {
            max-width: 100%;
        }

        .pager-container {
            padding: 12px 15px !important;
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

        .action-buttons {
            flex-direction: column;
            align-items: center;
        }

        .grid-btn {
            width: 100%;
        }
    }
</style>

<div class="container">
    <div class="page-title">
        <div style="background: #4c8bf5; color: #ffffff; width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 22px;">
            <i class="fas fa-question-circle"></i>
        </div>
        <h1 style="margin: 0;">Question Management</h1>
    </div>

    <!-- Message Label -->
    <asp:Label ID="lblMessage" runat="server" CssClass="message-label" Visible="false"></asp:Label>

    <!-- Add New Question Form -->
    <div class="form-box">
        <div class="form-title">
            <i class="fas fa-plus-circle"></i>
            <asp:Label ID="lblFormTitle" runat="server" Text="Add New Question"></asp:Label>
        </div>
        
        <asp:HiddenField ID="hdnQuestionID" runat="server" />
        
        <div class="form-row">
            <div class="full-width">
                <label class="form-label">Question Text</label>
                <asp:TextBox ID="txtQuestionText" runat="server" CssClass="input-box question-textarea" 
                    placeholder="Enter your question here..." TextMode="MultiLine" Rows="4"></asp:TextBox>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Option A</label>
                <asp:TextBox ID="txtA" runat="server" CssClass="input-box" 
                    placeholder="Enter option A"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label class="form-label">Option B</label>
                <asp:TextBox ID="txtB" runat="server" CssClass="input-box" 
                    placeholder="Enter option B"></asp:TextBox>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Option C</label>
                <asp:TextBox ID="txtC" runat="server" CssClass="input-box" 
                    placeholder="Enter option C"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label class="form-label">Option D</label>
                <asp:TextBox ID="txtD" runat="server" CssClass="input-box" 
                    placeholder="Enter option D"></asp:TextBox>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Correct Option</label>
                <div class="radio-list">
                    <div class="radio-item">
                        <asp:RadioButton ID="rbA" runat="server" GroupName="CorrectOption" Value="A" />
                        <label for="<%= rbA.ClientID %>">A</label>
                    </div>
                    <div class="radio-item">
                        <asp:RadioButton ID="rbB" runat="server" GroupName="CorrectOption" Value="B" />
                        <label for="<%= rbB.ClientID %>">B</label>
                    </div>
                    <div class="radio-item">
                        <asp:RadioButton ID="rbC" runat="server" GroupName="CorrectOption" Value="C" />
                        <label for="<%= rbC.ClientID %>">C</label>
                    </div>
                    <div class="radio-item">
                        <asp:RadioButton ID="rbD" runat="server" GroupName="CorrectOption" Value="D" />
                        <label for="<%= rbD.ClientID %>">D</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label class="form-label">Marks</label>
                <asp:TextBox ID="txtMarks" runat="server" CssClass="input-box" 
                    placeholder="Enter marks" TextMode="Number" min="1" max="100"></asp:TextBox>
            </div>
        </div>
        
        <div class="btn-group">
            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" 
                Text="Add Question" OnClick="btnSave_Click" />
            <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-secondary" 
                Text="Update Question" Visible="false" OnClick="btnUpdate_Click" />
            <asp:Button ID="btnCancel" runat="server" CssClass="btn" 
                Text="Clear Form" OnClick="btnCancel_Click" Visible="false" />
        </div>
    </div>

    <!-- Questions GridView (Initially Hidden) -->
    <div class="grid-box" id="divGridBox" runat="server" visible="false">
        <div class="form-title" style="background: #6c5ce7;">
            <i class="fas fa-list"></i>
            Questions List
        </div>
        
        <div class="grid-container">
            <asp:GridView ID="grdQuestions" runat="server" AutoGenerateColumns="False"
                DataKeyNames="QUESTION_ID"
                CssClass="gridview-style"
                OnRowEditing="grdQuestions_RowEditing"
                OnRowDeleting="grdQuestions_RowDeleting"
                OnPageIndexChanging="grdQuestions_PageIndexChanging"
                OnRowDataBound="grdQuestions_RowDataBound"
                AllowPaging="true"
                PageSize="10"
                PagerStyle-CssClass="pager-container">
                
                <Columns>
                    <asp:TemplateField HeaderText="Sr. No.">
                        <ItemTemplate>
                            <asp:Label ID="lblSrNo" runat="server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Question">
                        <ItemTemplate>
                            <div class="question-text">
                                <%# Eval("QUESTION_TEXT") %>
                            </div>
                        </ItemTemplate>
                        <ItemStyle Width="350px" HorizontalAlign="Left" />
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Options">
                        <ItemTemplate>
                            <div style="display: flex; flex-direction: column; gap: 4px;">
                                <div class="option-text">
                                    <strong>A:</strong> <%# Eval("OPTION_A") %>
                                </div>
                                <div class="option-text">
                                    <strong>B:</strong> <%# Eval("OPTION_B") %>
                                </div>
                                <div class="option-text">
                                    <strong>C:</strong> <%# Eval("OPTION_C") %>
                                </div>
                                <div class="option-text">
                                    <strong>D:</strong> <%# Eval("OPTION_D") %>
                                </div>
                            </div>
                        </ItemTemplate>
                        <ItemStyle Width="250px" HorizontalAlign="Left" />
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Correct">
                        <ItemTemplate>
                            <span class="correct-badge">
                                <%# Eval("CORRECT_OPTION") %>
                            </span>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Marks">
                        <ItemTemplate>
                            <span class="marks-badge">
                                <%# Eval("MARKS") %>
                            </span>
                        </ItemTemplate>
                        <ItemStyle Width="80px" />
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="CREATED" HeaderText="Created" 
                        DataFormatString="{0:MMM dd, yyyy}" >
                        <ItemStyle Width="100px" />
                    </asp:BoundField>
                    
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="action-buttons">
                                <asp:Button ID="btnEdit" runat="server" CssClass="grid-btn btn-edit" 
                                    Text="Edit" CommandName="Edit" />
                                <asp:Button ID="btnDelete" runat="server" CssClass="grid-btn btn-delete" 
                                    Text="Delete" CommandName="Delete" 
                                    OnClientClick="return confirm('Are you sure you want to delete this question?');" />
                            </div>
                        </ItemTemplate>
                        <ItemStyle Width="120px" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</div>

<!-- Add Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</asp:Content>--%>





<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true"
    CodeBehind="Questions.aspx.cs" Inherits="Quiz_Management_System.Questions" %>

    <asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
                font-size: 15px;
                font-weight: 600;
                text-align: left;
                margin-bottom: 25px;
                color: #2c3e50;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .page-title i {
                background: #4c8bf5;
                color: #ffffff;
                width: 45px;
                height: 45px;
                border-radius: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
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

            .form-row {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                gap: 20px;
                margin-bottom: 20px;
            }

            .form-group {
                margin-bottom: 0;
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
                text-decoration: none;
            }

            .btn:hover {
                background: #3a73e8;
                transform: translateY(-1px);
            }

            .btn-primary {
                background: #00b894;
            }

            .btn-primary:hover {
                background: #00a085;
            }

            .btn-secondary {
                background: #6c5ce7;
                margin-left: 15px;
            }

            .btn-secondary:hover {
                background: #5a4bd6;
            }

            .btn-excel {
                background: #217346;
                margin-bottom: 20px;
            }

            .btn-excel:hover {
                background: #1a5c37;
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

            .action-buttons {
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

            .btn-edit {
                background: #4c8bf5;
                color: #fff;
            }

            .btn-delete {
                background: #ff4d4d;
                color: #fff;
            }

            .grid-btn:hover {
                transform: translateY(-1px);
                opacity: 0.9;
            }

            /* Badges */
            .correct-badge {
                background: #d4f8e8;
                color: #00b894;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 500;
                display: inline-block;
            }

            .marks-badge {
                background: #fff4e5;
                color: #ff9e00;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 500;
                display: inline-block;
            }

            /* Question text */
            .question-text {
                font-weight: 500;
                color: #2c3e50;
                text-align: left;
                padding: 5px 0;
                word-wrap: break-word;
                white-space: normal;
                max-width: 400px;
            }

            .option-text {
                font-size: 13px;
                color: #666;
                text-align: left;
                padding: 3px 0;
                word-wrap: break-word;
                white-space: normal;
            }

            /* Radio Button List Styling */
            .radio-list {
                display: flex;
                gap: 15px;
                margin: 15px 0;
                flex-wrap: wrap;
            }

            .radio-item {
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 8px 16px;
                background: #f8fafc;
                border-radius: 8px;
                border: 1px solid #e1e8f1;
                transition: all 0.2s ease;
                cursor: pointer;
            }

            .radio-item:hover {
                border-color: #4c8bf5;
                background: white;
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

            /* Button Group */
            .btn-group {
                display: flex;
                gap: 12px;
                justify-content: center;
                margin-top: 25px;
            }

            .full-width {
                grid-column: 1 / -1;
            }

            .question-textarea {
                min-height: 100px;
                resize: vertical;
            }

            @media (max-width: 768px) {
                .container {
                    padding: 15px;
                    margin: 15px auto;
                }

                .page-title {
                    font-size: 20px;
                }

                .form-box,
                .grid-box {
                    padding: 20px 15px;
                }

                .form-row {
                    grid-template-columns: 1fr;
                }

                .action-buttons {
                    flex-direction: row;
                }

                .btn-group {
                    flex-direction: column;
                }

                .btn-group .btn {
                    width: 100%;
                    margin-left: 0 !important;
                }

                .radio-list {
                    flex-direction: column;
                    gap: 10px;
                }

                .question-text,
                .option-text {
                    max-width: 100%;
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

                .action-buttons {
                    flex-direction: column;
                    align-items: center;
                }

                .grid-btn {
                    width: 100%;
                }

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
            <div class="page-title">
                <div
                    style="background: #4c8bf5; color: #ffffff; width: 50px; height: 50px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 22px;">
                    <i class="fas fa-question-circle"></i>
                </div>
                <h1 style="margin: 0;">Question Management</h1>
            </div>

            <!-- Message Label -->
            <asp:Label ID="lblMessage" runat="server" CssClass="message-label" Visible="false"></asp:Label>

            <!-- Add New Question Form -->
            <div class="form-box">
                <div class="form-title">
                    <i class="fas fa-plus-circle"></i>
                    <asp:Label ID="lblFormTitle" runat="server" Text="Add New Question"></asp:Label>
                </div>

                <asp:HiddenField ID="hdnQuestionID" runat="server" />

                <div class="form-row">
                    <div class="full-width">
                        <label class="form-label">Question Text</label>
                        <asp:TextBox ID="txtQuestionText" runat="server" CssClass="input-box question-textarea"
                            placeholder="Enter your question here..." TextMode="MultiLine" Rows="4"></asp:TextBox>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Option A</label>
                        <asp:TextBox ID="txtA" runat="server" CssClass="input-box" placeholder="Enter option A">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Option B</label>
                        <asp:TextBox ID="txtB" runat="server" CssClass="input-box" placeholder="Enter option B">
                        </asp:TextBox>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Option C</label>
                        <asp:TextBox ID="txtC" runat="server" CssClass="input-box" placeholder="Enter option C">
                        </asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Option D</label>
                        <asp:TextBox ID="txtD" runat="server" CssClass="input-box" placeholder="Enter option D">
                        </asp:TextBox>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Correct Option</label>
                        <div class="radio-list">
                            <div class="radio-item">
                                <asp:RadioButton ID="rbA" runat="server" GroupName="CorrectOption" Value="A" />
                                <label for="<%= rbA.ClientID %>">A</label>
                            </div>
                            <div class="radio-item">
                                <asp:RadioButton ID="rbB" runat="server" GroupName="CorrectOption" Value="B" />
                                <label for="<%= rbB.ClientID %>">B</label>
                            </div>
                            <div class="radio-item">
                                <asp:RadioButton ID="rbC" runat="server" GroupName="CorrectOption" Value="C" />
                                <label for="<%= rbC.ClientID %>">C</label>
                            </div>
                            <div class="radio-item">
                                <asp:RadioButton ID="rbD" runat="server" GroupName="CorrectOption" Value="D" />
                                <label for="<%= rbD.ClientID %>">D</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Marks</label>
                        <asp:TextBox ID="txtMarks" runat="server" CssClass="input-box" placeholder="Enter marks"
                            TextMode="Number" min="1" max="100"></asp:TextBox>
                    </div>
                </div>

                <div class="btn-group">
                    <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text="Add Question"
                        OnClick="btnSave_Click" />
                    <asp:Button ID="btnUpdate" runat="server" CssClass="btn btn-secondary" Text="Update Question"
                        Visible="false" OnClick="btnUpdate_Click" />
                    <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text="Clear Form" OnClick="btnCancel_Click"
                        Visible="false" />
                </div>
            </div>

            <!-- Questions GridView (Initially Hidden) -->
            <div class="grid-box" id="divGridBox" runat="server" visible="false">
                <div class="form-title" style="background: #6c5ce7;">
                    <i class="fas fa-list"></i>
                    Questions List
                </div>

                <div class="grid-container">
                    <asp:GridView ID="grdQuestions" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="QUESTION_ID" CssClass="gridview-style" OnRowEditing="grdQuestions_RowEditing"
                        OnRowDeleting="grdQuestions_RowDeleting" OnPageIndexChanging="grdQuestions_PageIndexChanging"
                        OnRowDataBound="grdQuestions_RowDataBound" AllowPaging="true" PageSize="10"
                        PagerStyle-CssClass="pager-container">

                        <Columns>
                            <asp:TemplateField HeaderText="Sr. No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Question">
                                <ItemTemplate>
                                    <div class="question-text">
                                        <%# Eval("QUESTION_TEXT") %>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="350px" HorizontalAlign="Left" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Options">
                                <ItemTemplate>
                                    <div style="display: flex; flex-direction: column; gap: 4px;">
                                        <div class="option-text">
                                            <strong>A:</strong>
                                            <%# Eval("OPTION_A") %>
                                        </div>
                                        <div class="option-text">
                                            <strong>B:</strong>
                                            <%# Eval("OPTION_B") %>
                                        </div>
                                        <div class="option-text">
                                            <strong>C:</strong>
                                            <%# Eval("OPTION_C") %>
                                        </div>
                                        <div class="option-text">
                                            <strong>D:</strong>
                                            <%# Eval("OPTION_D") %>
                                        </div>
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="250px" HorizontalAlign="Left" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Correct">
                                <ItemTemplate>
                                    <span class="correct-badge">
                                        <%# Eval("CORRECT_OPTION") %>
                                    </span>
                                </ItemTemplate>
                                <ItemStyle Width="80px" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Marks">
                                <ItemTemplate>
                                    <span class="marks-badge">
                                        <%# Eval("MARKS") %>
                                    </span>
                                </ItemTemplate>
                                <ItemStyle Width="80px" />
                            </asp:TemplateField>

                            <asp:BoundField DataField="CREATED" HeaderText="Created"
                                DataFormatString="{0:MMM dd, yyyy}">
                                <ItemStyle Width="100px" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <div class="action-buttons">
                                        <asp:Button ID="btnEdit" runat="server" CssClass="grid-btn btn-edit" Text="Edit"
                                            CommandName="Edit" />
                                        <asp:Button ID="btnDelete" runat="server" CssClass="grid-btn btn-delete"
                                            Text="Delete" CommandName="Delete"
                                            OnClientClick="return confirm('Are you sure you want to delete this question?');" />
                                    </div>
                                </ItemTemplate>
                                <ItemStyle Width="120px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>

        <!-- Add Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </asp:Content>