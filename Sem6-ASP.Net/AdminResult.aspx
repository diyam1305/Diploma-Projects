<%@ Page Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="AdminResult.aspx.cs" Inherits="Quiz_Management_System.Pages.AdminResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style>
    .navbar, 
    header, 
    .navbar-expand-lg {
        min-height: 60px !important;
        height: 60px !important;
        padding-top: 0.25rem !important;
        padding-bottom: 0.25rem !important;
    }
    
    .navbar-brand {
        font-size: 1.2rem !important;
        padding: 0.3rem 0 !important;
    }
    
    .navbar-nav .nav-link {
        font-size: 0.85rem !important;
        padding: 0.4rem 0.8rem !important;
    }
    
    .user-welcome,
    .welcome-text {
        font-size: 0.85rem !important;
        margin: 0 !important;
    }
    
    .navbar .fa-icon,
    .navbar i {
        font-size: 0.9rem !important;
    }

    /* MAIN PAGE STYLES */
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
        margin: 20px auto;
        padding: 15px;
    }

    .page-title {
        font-size: 24px;
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

    .stats-container {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        margin-bottom: 25px;
    }

    .stat-card {
        background: #ffffff;
        padding: 20px 15px;
        border-radius: 10px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.06);
        border: 1px solid #e8ecf4;
        text-align: center;
        transition: transform 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .stat-icon {
        width: 45px;
        height: 45px;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 12px;
        font-size: 18px;
    }

    .stat-icon.total {
        background: rgba(76, 139, 245, 0.1);
        color: #4c8bf5;
    }

    .stat-icon.passed {
        background: rgba(0, 184, 148, 0.1);
        color: #00b894;
    }

    .stat-icon.failed {
        background: rgba(255, 77, 77, 0.1);
        color: #ff4d4d;
    }

    .stat-icon.avg {
        background: rgba(255, 193, 7, 0.1);
        color: #ffc107;
    }

    .stat-value {
        font-size: 24px;
        font-weight: 700;
        margin: 8px 0;
        line-height: 1;
    }

    .stat-label {
        font-size: 13px;
        color: #666;
        font-weight: 500;
    }

    .search-box, .grid-box {
        background: #ffffff;
        padding: 20px 25px;
        border-radius: 10px;
        box-shadow: 0 3px 10px rgba(0,0,0,0.06);
        margin-bottom: 25px;
        border: 1px solid #e8ecf4;
    }

    .form-title {
        font-size: 18px;
        font-weight: 600;
        padding: 12px 15px;
        border-radius: 8px;
        background: #4c8bf5;
        color: white;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .form-title i {
        font-size: 16px;
    }

    .search-row {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        margin-bottom: 15px;
    }

    .form-group {
        margin-bottom: 0;
    }

    .form-label {
        color: #4c8bf5;
        font-weight: 500;
        display: block;
        margin-bottom: 6px;
        font-size: 13px;
    }

    input[type=text], input[type=number] {
        width: 100%;
        padding: 10px 14px;
        border-radius: 6px;
        border: 1px solid #d1d9e6;
        font-size: 13px;
        outline: none;
        transition: all 0.2s ease;
        background: #f9fafc;
    }

    input:focus {
        border-color: #4c8bf5;
        box-shadow: 0 0 0 3px rgba(76, 139, 245, 0.1);
        background: white;
    }

    .form-dropdown {
        width: 100%;
        padding: 10px 14px;
        border-radius: 6px;
        border: 1px solid #d1d9e6;
        font-size: 13px;
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

    .btn {
        background: #4c8bf5;
        color: #fff;
        padding: 10px 20px;
        border: none;
        border-radius: 6px;
        font-size: 13px;
        font-weight: 500;
        cursor: pointer;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;
    }

    .btn:hover {
        background: #3a73e8;
        transform: translateY(-1px);
    }

    .btn-search {
        background: #4c8bf5;
    }

    .btn-show-all {
        background: #6c757d;
    }

    .btn-show-all:hover {
        background: #5a6268;
    }

    .btn-export {
        background: #00b894;
    }

    .btn-export:hover {
        background: #00a085;
    }

    .btn-group {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
        margin-top: 20px;
        flex-wrap: wrap;
    }

    .grid-container {
        overflow-x: auto;
        border-radius: 8px;
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
        padding: 14px 10px;
        font-size: 13px;
        font-weight: 600;
        text-align: center;
        border-bottom: 2px solid #e8ecf4;
    }

    .gridview-style td {
        background: #ffffff;
        padding: 12px 10px;
        font-size: 12px;
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

    .user-info {
        text-align: left;
        padding-left: 12px !important;
    }

    .user-name {
        font-weight: 600;
        color: #2c3e50;
        margin-bottom: 2px;
        font-size: 13px;
    }

    .user-id {
        font-size: 11px;
        color: #7f8c8d;
    }

    .progress-container {
        display: flex;
        align-items: center;
        gap: 8px;
        justify-content: center;
    }

    .progress-wrapper {
        width: 90px;
        height: 5px;
        background: #e8ecf4;
        border-radius: 3px;
        overflow: hidden;
    }

    .progress-bar {
        height: 100%;
        border-radius: 3px;
        transition: width 0.3s ease;
    }

    .progress-success {
        background: #00b894;
    }

    .progress-danger {
        background: #ff4d4d;
    }

    .score-text {
        font-weight: 600;
        color: #2c3e50;
        white-space: nowrap;
        font-size: 12px;
    }

    .status-badge {
        padding: 5px 12px;
        border-radius: 15px;
        font-size: 11px;
        font-weight: 500;
        display: inline-block;
    }

    .status-pass {
        background: #d4f8e8;
        color: #00b894;
    }

    .status-fail {
        background: #ffeaea;
        color: #ff4d4d;
    }

    .percentage-text {
        font-weight: 700;
        font-size: 13px;
    }

    .percentage-high {
        color: #00b894;
    }

    .percentage-low {
        color: #ff4d4d;
    }

    .record-count {
        background: #f8fafd;
        padding: 6px 12px;
        border-radius: 15px;
        font-size: 12px;
        color: #4c8bf5;
        font-weight: 500;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .header-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }

    /* Pagination */
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

    @media screen and (max-width: 768px) {
        .container {
            padding: 10px;
            margin: 10px auto;
        }

        .page-title {
            font-size: 20px;
            margin-bottom: 20px;
        }

        .search-box, .grid-box {
            padding: 15px;
        }

        .stats-container {
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }

        .btn-group {
            flex-direction: column;
            width: 100%;
        }

        .btn-group .btn {
            width: 100%;
        }

        .search-row {
            grid-template-columns: 1fr;
        }

        .header-row {
            flex-direction: column;
            gap: 12px;
            align-items: flex-start;
        }

        .record-count {
            align-self: flex-start;
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

    @media screen and (max-width: 480px) {
        .page-title {
            flex-direction: column;
            align-items: flex-start;
            gap: 8px;
        }

        .stats-container {
            grid-template-columns: 1fr;
        }

        .gridview-style th,
        .gridview-style td {
            padding: 10px 8px;
            font-size: 11px;
        }

        .progress-container {
            flex-direction: column;
            gap: 4px;
        }

        .progress-wrapper {
            width: 70px;
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
        <i class="fas fa-poll"></i>
        Results Management
    </div>

    <!-- Statistics Cards -->
    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-icon total">
                <i class="fas fa-chart-bar"></i>
            </div>
            <div class="stat-value">
                <asp:Label ID="lblTotalAttempts" runat="server" Text="0"></asp:Label>
            </div>
            <div class="stat-label">Total Attempts</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon passed">
                <i class="fas fa-check-circle"></i>
            </div>
            <div class="stat-value text-success">
                <asp:Label ID="lblPassed" runat="server" Text="0"></asp:Label>
            </div>
            <div class="stat-label">Passed</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon failed">
                <i class="fas fa-times-circle"></i>
            </div>
            <div class="stat-value text-danger">
                <asp:Label ID="lblFailed" runat="server" Text="0"></asp:Label>
            </div>
            <div class="stat-label">Failed</div>
        </div>
        
        <div class="stat-card">
            <div class="stat-icon avg">
                <i class="fas fa-percentage"></i>
            </div>
            <div class="stat-value text-warning">
                <asp:Label ID="lblAvgScore" runat="server" Text="0%"></asp:Label>
            </div>
            <div class="stat-label">Average Score</div>
        </div>
    </div>

    <!-- Search Box -->
    <div class="search-box">
        <div class="form-title">
            <i class="fas fa-search"></i>
            Search Filters
        </div>
        
        <div class="search-row">
           <div class="form-group">
        <label class="form-label">Show Records</label>
        <asp:DropDownList 
            ID="ddlPageSize" 
            runat="server" 
            CssClass="form-dropdown"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged">
        
            <asp:ListItem Text="5" Value="5" />
            <asp:ListItem Text="10" Value="10" Selected="True" />
            <asp:ListItem Text="15" Value="15" />
            <asp:ListItem Text="20" Value="20" />
            <asp:ListItem Text="50" Value="50" />
            <asp:ListItem Text="100" Value="100" />
        </asp:DropDownList>
    </div>

            
            <div class="form-group">
                <label class="form-label">Username</label>
                <asp:DropDownList ID="ddlUserName" runat="server" CssClass="form-dropdown">
                    <asp:ListItem Value="">All Users</asp:ListItem>
                </asp:DropDownList>
            </div>
            
            <div class="form-group">
                <label class="form-label">Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-dropdown">
                    <asp:ListItem Value="">All Status</asp:ListItem>
                    <asp:ListItem Value="1">Pass</asp:ListItem>
                    <asp:ListItem Value="0">Fail</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        
        <div class="btn-group">
            <asp:Button ID="btnSearch" runat="server" 
                CssClass="btn btn-search" 
                Text="Search" 
                OnClick="btnSearch_Click" />
            <asp:Button ID="btnShowAll" runat="server" 
                CssClass="btn btn-show-all" 
                Text="Show All" 
                OnClick="btnShowAll_Click" />
        </div>
    </div>

    <!-- Results Grid -->
    <div class="grid-box">
        <div class="header-row">
            <div class="form-title" style="background: #6c5ce7; margin-bottom: 0; padding: 10px 15px;">
                <i class="fas fa-list"></i>
                Results List
            </div>
            <span class="record-count">
                <i class="fas fa-database"></i>
                <asp:Label ID="lblRecordCount" runat="server" Text="0 records"></asp:Label>
            </span>
        </div>
        
        <div class="grid-container">
            <asp:GridView ID="GridViewResults" runat="server" 
                CssClass="gridview-style"
                AutoGenerateColumns="False"
                EmptyDataText="No results found"
                AllowPaging="True"
                PageSize="10"
                OnPageIndexChanging="GridViewResults_PageIndexChanging"
                ShowHeaderWhenEmpty="True"
                PagerStyle-CssClass="pager-container">
                
                <Columns>
                    <asp:TemplateField HeaderText="Sr. No.">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    
                    <asp:TemplateField HeaderText="User">
                        <ItemTemplate>
                            <div class="user-info">
                                <div class="user-name">
                                    <%# Eval("USER_FIRSTNAME") %> <%# Eval("USER_LASTNAME") %>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:BoundField DataField="QUIZ_ID" HeaderText="Quiz ID" />
                    
                    <asp:TemplateField HeaderText="Score">
                        <ItemTemplate>
                            <div class="progress-container">
                                <div class="score-text">
                                    <%# Eval("OBTAINED_MARKS") %>/<%# Eval("TOTAL_MARKS") %>
                                </div>
                                <div class="progress-wrapper">
                                    <div class='progress-bar <%# Convert.ToInt32(Eval("RESULT_STATUS")) == 1 ? "progress-success" : "progress-danger" %>' 
                                        style='width: <%# Eval("PERCENTAGE") %>%;'>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='status-badge <%# Convert.ToInt32(Eval("RESULT_STATUS")) == 1 ? "status-pass" : "status-fail" %>'>
                                <%# Convert.ToInt32(Eval("RESULT_STATUS")) == 1 ? "Pass" : "Fail" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Percentage">
                        <ItemTemplate>
                            <div class='percentage-text <%# Convert.ToInt32(Eval("PERCENTAGE")) >= 40 ? "percentage-high" : "percentage-low" %>'>
                                <%# Eval("PERCENTAGE") %>%
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</div>
    
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</asp:Content>