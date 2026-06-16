<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="ExcelPreview.aspx.cs" Inherits="Quiz_Management_System.ExcelPreview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    .preview-container {
        --primary: #217346;
        --secondary: #6c757d;
        --danger: #dc3545;
        --success: #28a745;
        --light: #f8f9fa;
        --border: #dee2e6;

        padding: 1rem;
        max-width: 1400px;
        margin: 0 auto;
    }

    /* HEADER  */
    .preview-container .preview-header {
        background: var(--primary);
        color: white;
        padding: 1rem;
        border-radius: 0.5rem;
        margin-bottom: 1rem;
    }

    .preview-container .preview-header h3 {
        margin: 0;
        font-size: 1.25rem;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    /* STATS */
    .preview-container .stats-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
        gap: 1rem;
        margin-bottom: 1rem;
    }

    .preview-container .stat-item {
        background: var(--light);
        padding: 0.75rem;
        border-radius: 0.5rem;
        border: 1px solid var(--border);
        text-align: center;
    }

    .preview-container .stat-value {
        font-size: 1.5rem;
        font-weight: bold;
        color: var(--primary);
    }

    .preview-container .stat-label {
        font-size: 0.8rem;
        color: var(--secondary);
    }

    /* GRID */
    .preview-container .grid-container {
        background: white;
        border: 1px solid var(--border);
        border-radius: 0.5rem;
        margin-bottom: 1rem;
        overflow-x: auto;
    }

    .preview-container .grid-header {
        background: var(--light);
        padding: 0.75rem 1rem;
        border-bottom: 1px solid var(--border);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 0.5rem;
    }

    .preview-container .grid-header h4 {
        margin: 0;
        font-size: 1rem;
    }

    .preview-container .controls {
        display: flex;
        gap: 0.5rem;
        align-items: center;
    }

    .preview-container .grid-table {
        width: 100%;
        border-collapse: collapse;
        min-width: 1200px;
        font-size: 0.8rem;
    }

    .preview-container .grid-table th {
        background: var(--light);
        padding: 0.5rem;
        border-bottom: 2px solid var(--border);
        text-align: center;
        white-space: nowrap;
        position: sticky;
        top: 0;
        z-index: 1;
    }

    .preview-container .grid-table td {
        padding: 0.5rem;
        border-bottom: 1px solid var(--border);
        text-align: center;
    }

    .preview-container .grid-table tr:hover {
        background-color: rgba(0,0,0,0.02);
    }

    /* COLUMN WIDTHS */
    .preview-container .col-select { width: 40px; }
    .preview-container .col-srno { width: 50px; }
    .preview-container .col-quiz { width: 120px; }
    .preview-container .col-question { width: 250px; }
    .preview-container .col-option { width: 100px; }
    .preview-container .col-correct { width: 60px; }
    .preview-container .col-marks { width: 50px; }

    /* TEXT */
    .preview-container .quiz-name {
        font-weight: 600;
        color: var(--primary);
        background: rgba(33,115,70,0.1);
        padding: 0.25rem 0.5rem;
        border-radius: 0.25rem;
        display: inline-block;
        max-width: 100%;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .preview-container .question-text {
        text-align: left;
        max-width: 250px;
        overflow: hidden;
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;
    }

    .preview-container .option-text {
        text-align: left;
        max-width: 100px;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    /* BUTTONS */
    .preview-container .action-buttons {
        display: flex;
        gap: 0.5rem;
        justify-content: center;
        margin-top: 1.5rem;
        flex-wrap: wrap;
    }

    .preview-container .btn {
        padding: 0.5rem 1rem;
        border: none;
        border-radius: 0.25rem;
        cursor: pointer;
        font-size: 0.875rem;
        min-width: 120px;
    }

    .preview-container .btn-primary { background: var(--primary); color: white; }
    .preview-container .btn-secondary { background: var(--secondary); color: white; }
    .preview-container .btn-danger { background: var(--danger); color: white; }

    .preview-container .btn-sm {
        padding: 0.25rem 0.5rem;
        min-width: auto;
        font-size: 0.75rem;
    }

    /* MESSAGE */
    .preview-container .message-box {
        padding: 0.75rem;
        margin-bottom: 1rem;
        border-radius: 0.5rem;
        font-size: 0.875rem;
    }

    .preview-container .message-success {
        background: rgba(40,167,69,0.1);
        border: 1px solid rgba(40,167,69,0.3);
        color: var(--success);
    }

    .preview-container .message-warning {
        background: rgba(255,193,7,0.1);
        border: 1px solid rgba(255,193,7,0.3);
        color: #856404;
    }

    /* MOBILE */
    @media (max-width: 768px) {
        .preview-container .stats-row { grid-template-columns: repeat(3,1fr); }
        .preview-container .action-buttons { flex-direction: column; }
        .preview-container .btn { width: 100%; }
    }
</style>

<div class="preview-container">
    <div class="preview-header">
        <h3><i class="fas fa-file-excel"></i> Excel Preview</h3>
    </div>

    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="message-box">
        <asp:Literal ID="litMessage" runat="server" />
    </asp:Panel>

   <div class="stats-row">
    <div class="stat-item">
        <div class="stat-value">
            <asp:Literal ID="litTotalQuestions" runat="server" Text="0" />
        </div>
        <div class="stat-label">Total Questions</div>
    </div>

    <div class="stat-item">
        <div class="stat-value">
            <asp:Label ID="lblSelectedCount" runat="server" Text="0" />
        </div>
        <div class="stat-label">Selected</div>
    </div>

    <div class="stat-item">
        <div class="stat-value">
            <asp:Literal ID="litTotalMarks" runat="server" Text="0" />
        </div>
        <div class="stat-label">Total Marks</div>
    </div>
</div>

<div class="grid-container">
    <div class="grid-header">
        <h4>Questions Preview</h4>
        <div class="controls">
            <asp:CheckBox ID="chkSelectAll" runat="server"
                Text="Select All"
                AutoPostBack="true"
                OnCheckedChanged="chkSelectAll_CheckedChanged"
                CssClass="select-all-checkbox" />

            <asp:Button ID="btnClearSelection" runat="server"
                Text="Clear"
                CssClass="btn btn-secondary btn-sm"
                OnClick="btnClearSelection_Click" />
        </div>
    </div>

    <asp:GridView ID="grdPreview" runat="server"
        AutoGenerateColumns="False"
        CssClass="grid-table"
        ShowHeaderWhenEmpty="true"
        EmptyDataText="No questions to preview"
        OnRowDataBound="grdPreview_RowDataBound">

        <Columns>
            <asp:TemplateField HeaderText="#">
                <ItemTemplate>
                    <asp:CheckBox ID="chkSelect" runat="server"
                        AutoPostBack="true"
                        OnCheckedChanged="chkSelect_CheckedChanged" />
                </ItemTemplate>
                <HeaderStyle CssClass="col-select" />
                <ItemStyle CssClass="col-select" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="No.">
                <ItemTemplate><%# Eval("RowNumber") %></ItemTemplate>
                <HeaderStyle CssClass="col-srno" />
                <ItemStyle CssClass="col-srno" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Quiz">
                <ItemTemplate>
                    <span class="quiz-name"><%# Eval("QuizName") %></span>
                </ItemTemplate>
                <HeaderStyle CssClass="col-quiz" />
                <ItemStyle CssClass="col-quiz" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Question">
                <ItemTemplate>
                    <div class="question-text">
                        <%# Eval("Question") %>
                        <asp:Label ID="lblError" runat="server" CssClass="error-text" Visible="false" />
                    </div>
                </ItemTemplate>
                <HeaderStyle CssClass="col-question" />
                <ItemStyle CssClass="col-question" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="A">
                <ItemTemplate>
                    <div class="option-text"><%# Eval("OptionA") %></div>
                </ItemTemplate>
                <HeaderStyle CssClass="col-option" />
                <ItemStyle CssClass="col-option" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="B">
                <ItemTemplate>
                    <div class="option-text"><%# Eval("OptionB") %></div>
                </ItemTemplate>
                <HeaderStyle CssClass="col-option" />
                <ItemStyle CssClass="col-option" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="C">
                <ItemTemplate>
                    <div class="option-text"><%# Eval("OptionC") %></div>
                </ItemTemplate>
                <HeaderStyle CssClass="col-option" />
                <ItemStyle CssClass="col-option" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="D">
                <ItemTemplate>
                    <div class="option-text"><%# Eval("OptionD") %></div>
                </ItemTemplate>
                <HeaderStyle CssClass="col-option" />
                <ItemStyle CssClass="col-option" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Correct">
                <ItemTemplate>
                    <strong><%# Eval("CorrectOption") %></strong>
                </ItemTemplate>
                <HeaderStyle CssClass="col-correct" />
                <ItemStyle CssClass="col-correct" />
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Marks">
                <ItemTemplate>
                    <strong><%# Eval("Marks") %></strong>
                </ItemTemplate>
                <HeaderStyle CssClass="col-marks" />
                <ItemStyle CssClass="col-marks" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>

<div class="action-buttons">
    <asp:Button ID="btnSaveAll" runat="server" Text="Save All"
        CssClass="btn btn-primary" OnClick="btnSaveAll_Click" />

    <asp:Button ID="btnSaveSelected" runat="server" Text="Save Selected"
        CssClass="btn btn-secondary" OnClick="btnSaveSelected_Click" />

    <asp:Button ID="btnCancel" runat="server" Text="Cancel"
        CssClass="btn btn-danger" OnClick="btnCancel_Click" />
</div>

<asp:HiddenField ID="hdnSelectedCount" runat="server" Value="0" />
<asp:HiddenField ID="hdnTotalCount" runat="server" Value="0" />


</div>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</asp:Content>
