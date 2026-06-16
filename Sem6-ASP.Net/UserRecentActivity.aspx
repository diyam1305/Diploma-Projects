<%@ Page Title="Recent Activity" Language="C#" MasterPageFile="~/UserDashboard.Master" AutoEventWireup="true"
    CodeBehind="UserRecentActivity.aspx.cs" Inherits="Quiz_Management_System.UserRecentActivity" %>

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
                justify-content: space-between;
                gap: 12px;
            }

            .form-title i {
                font-size: 18px;
            }

            .stats-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 20px;
                margin-bottom: 30px;
            }

            .stat-card {
                background: #ffffff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                border: 1px solid #e8ecf4;
                transition: transform 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
            }

            .stat-card i {
                font-size: 32px;
                margin-bottom: 15px;
                width: 60px;
                height: 60px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .stat-card .icon-attempts {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .stat-card .icon-pass {
                background: linear-gradient(135deg, #00b894 0%, #00a085 100%);
                color: white;
            }

            .stat-card .icon-fail {
                background: linear-gradient(135deg, #ff4d4d 0%, #e53935 100%);
                color: white;
            }

            .stat-card .icon-rate {
                background: linear-gradient(135deg, #4c8bf5 0%, #3a73e8 100%);
                color: white;
            }

            .stat-label {
                font-size: 14px;
                color: #6c757d;
                font-weight: 500;
                margin-bottom: 8px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .stat-value {
                font-size: 32px;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 5px;
            }

            .stat-subtext {
                font-size: 12px;
                color: #95a5a6;
                font-weight: 500;
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

            .btn-refresh {
                background: #00b894;
            }

            .btn-refresh:hover {
                background: #00a085;
            }

            .btn-delete {
                background: #ffeaea;
                color: #ff4d4d;
                border: 1px solid #ff4d4d;
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 12px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                text-decoration: none;
            }

            .btn-delete:hover {
                background: #ff4d4d;
                color: #ffffff;
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(255, 77, 77, 0.2);
            }

            .btn-delete-all {
                background: #ffffff;
                color: #ff4d4d;
                border: 1px solid #ffffff;
                padding: 6px 14px;
                border-radius: 6px;
                font-size: 13px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 6px;
                text-decoration: none;
            }

            .btn-delete-all:hover {
                background: #ffeaea;
                color: #ff4d4d;
                border-color: #ffeaea;
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .result-badge {
                padding: 8px 20px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                display: inline-block;
                min-width: 80px;
            }

            .result-pass {
                background: #d4f8e8;
                color: #00b894;
                border: 1px solid #00b894;
            }

            .result-fail {
                background: #ffeaea;
                color: #ff4d4d;
                border: 1px solid #ff4d4d;
            }

            .score-highlight {
                font-weight: 700;
                font-size: 16px;
                color: #2c3e50;
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

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                background: #f8fafd;
                border-radius: 10px;
                margin: 20px 0;
            }

            .empty-state i {
                font-size: 64px;
                color: #d1d9e6;
                margin-bottom: 20px;
            }

            .empty-state h4 {
                color: #6c757d;
                margin-bottom: 10px;
                font-weight: 500;
            }

            .empty-state p {
                color: #95a5a6;
                margin-bottom: 25px;
                font-size: 14px;
            }

            @media screen and (max-width: 768px) {
                .container {
                    padding: 15px;
                    margin: 15px auto;
                }

                .page-title {
                    font-size: 22px;
                }

                .grid-box {
                    padding: 20px 15px;
                }

                .stats-container {
                    grid-template-columns: repeat(2, 1fr);
                    gap: 15px;
                }

                .stat-card {
                    padding: 20px;
                }

                .stat-value {
                    font-size: 24px;
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
                    gap: 10px;
                }

                .page-title i {
                    width: 40px;
                    height: 40px;
                    font-size: 18px;
                }

                .stats-container {
                    grid-template-columns: 1fr;
                }

                .gridview-style th,
                .gridview-style td {
                    padding: 10px 8px;
                    font-size: 12px;
                }

                .form-title {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 10px;
                }

                .form-title .btn {
                    width: 100%;
                }

                .result-badge {
                    padding: 6px 15px;
                    font-size: 11px;
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
                <i class="fas fa-history"></i>
                Recent Activity
            </div>

            <!-- Stats Cards -->
            <div class="stats-container">
                <div class="stat-card">
                    <div class="d-flex align-items-start">
                        <div>
                            <i class="fas fa-list-alt icon-attempts"></i>
                        </div>
                        <div class="ms-3">
                            <div class="stat-label">Total Attempts</div>
                            <div class="stat-value">
                                <asp:Label ID="lblTotalAttempts" runat="server" Text="0"></asp:Label>
                            </div>
                            <div class="stat-subtext">All quiz attempts</div>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="d-flex align-items-start">
                        <div>
                            <i class="fas fa-check-circle icon-pass"></i>
                        </div>
                        <div class="ms-3">
                            <div class="stat-label">Passed</div>
                            <div class="stat-value">
                                <asp:Label ID="lblPassed" runat="server" Text="0"></asp:Label>
                            </div>
                            <div class="stat-subtext">Successful attempts</div>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="d-flex align-items-start">
                        <div>
                            <i class="fas fa-times-circle icon-fail"></i>
                        </div>
                        <div class="ms-3">
                            <div class="stat-label">Failed</div>
                            <div class="stat-value">
                                <asp:Label ID="lblFailed" runat="server" Text="0"></asp:Label>
                            </div>
                            <div class="stat-subtext">Unsuccessful attempts</div>
                        </div>
                    </div>
                </div>

                <div class="stat-card">
                    <div class="d-flex align-items-start">
                        <div>
                            <i class="fas fa-chart-line icon-rate"></i>
                        </div>
                        <div class="ms-3">
                            <div class="stat-label">Success Rate</div>
                            <div class="stat-value">
                                <asp:Label ID="lblSuccessRate" runat="server" Text="0%"></asp:Label>
                            </div>
                            <div class="stat-subtext">Overall performance</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid-box">
                <div class="form-title" style="background: #00b894;">
                    <div>
                        <i class="fas fa-clipboard-list"></i>
                        Your Recent Quiz Attempts
                    </div>
                    <asp:LinkButton ID="btnDeleteAll" runat="server" CssClass="btn-delete-all"
                        OnClick="btnDeleteAll_Click" OnClientClick="return confirmDeleteAllActivities(this, event);">
                        <i class="fas fa-trash-alt"></i> Delete All
                    </asp:LinkButton>
                </div>

                <div class="grid-container">
                    <asp:GridView ID="gvRecentActivity" runat="server" CssClass="gridview-style"
                        AutoGenerateColumns="false" AllowPaging="true" PageSize="10"
                        OnPageIndexChanging="gvRecentActivity_PageIndexChanging" PagerStyle-CssClass="pager-container"
                        OnRowDataBound="gvRecentActivity_RowDataBound" EmptyDataText="No quiz attempts found."
                        OnRowCommand="gvRecentActivity_RowCommand">

                        <Columns>
                            <asp:TemplateField HeaderText="Sr. No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblSrNo" runat="server"></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle Width="80px" />
                                <ItemStyle HorizontalAlign="Center" Font-Bold="true" />
                            </asp:TemplateField>


                            <asp:BoundField DataField="QUIZ_NAME" HeaderText="Quiz Name">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                            <asp:TemplateField HeaderText="Score Obtained">
                                <ItemTemplate>
                                    <span class="score-highlight">
                                        <%# Eval("OBTAINED_MARKS") %>
                                    </span>
                                </ItemTemplate>
                                <HeaderStyle Width="120px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Result">
                                <ItemTemplate>
                                    <span
                                        class='result-badge <%# Eval("RESULT_STATUS").ToString() == "Pass" ? "result-pass" : "result-fail" %>'>
                                        <%# Eval("RESULT_STATUS") %>
                                    </span>
                                </ItemTemplate>
                                <HeaderStyle Width="100px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <span style="color: #6c757d; font-weight: 500;">
                                        <i class="far fa-calendar-alt" style="margin-right: 5px;"></i>
                                        <%# Eval("CREATED", "{0:dd MMM yyyy}") %>
                                    </span>
                                </ItemTemplate>
                                <HeaderStyle Width="140px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDelete" runat="server" CssClass="btn-delete"
                                        CommandName="DeleteActivity" CommandArgument='<%# Eval("RESULT_ID") %>'
                                        OnClientClick="return confirmDeleteActivity(this, event);">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </asp:LinkButton>
                                </ItemTemplate>
                                <HeaderStyle Width="120px" />
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>

                        <EmptyDataTemplate>
                            <div class="empty-state" style="padding: 50px 30px; text-align: center; background: #ffffff;">
                                <i class="fas fa-folder-open" style="font-size: 60px; color: #cbd5e1; margin-bottom: 20px;"></i>
                                <h4 style="font-size: 20px; font-weight: 600; color: #334155; margin: 0 0 10px 0;">No Recent Activities Found</h4>
                                <p style="font-size: 14px; color: #64748b; max-width: 420px; margin: 0 auto; line-height: 1.5;">
                                    Your recent quiz attempt history is currently empty. Start taking quizzes to see your records here!
                                </p>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        
        <!-- SweetAlert2 -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.32/sweetalert2.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.32/sweetalert2.all.min.js"></script>

        <script>
            function confirmDeleteActivity(element, event) {
                event.preventDefault();
                const href = element.getAttribute('href');
                
                Swal.fire({
                    title: 'Delete Activity Attempt?',
                    text: 'Are you sure you want to delete this activity attempt? This action cannot be undone.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#ff4d4d',
                    cancelButtonColor: '#6b7280',
                    confirmButtonText: '<i class="fas fa-trash-alt"></i> Yes, Delete it!',
                    cancelButtonText: '<i class="fas fa-times"></i> Cancel',
                    reverseButtons: true,
                    customClass: {
                        confirmButton: 'swal-btn-confirm',
                        cancelButton: 'swal-btn-cancel'
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire({
                            title: 'Deleting...',
                            text: 'Please wait while we delete the activity',
                            icon: 'info',
                            showConfirmButton: false,
                            allowOutsideClick: false,
                            didOpen: () => {
                                Swal.showLoading();
                            }
                        });
                        
                        if (href) {
                            var js = href.replace(/^javascript:/i, '');
                            eval(js);
                        }
                    }
                });
                return false;
            }

            function confirmDeleteAllActivities(element, event) {
                event.preventDefault();
                const href = element.getAttribute('href');
                
                Swal.fire({
                    title: 'Delete All Activities?',
                    text: 'Are you sure you want to delete all your quiz attempts? This action is permanent and cannot be undone!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#ff4d4d',
                    cancelButtonColor: '#6b7280',
                    confirmButtonText: '<i class="fas fa-trash-alt"></i> Yes, Delete All!',
                    cancelButtonText: '<i class="fas fa-times"></i> Cancel',
                    reverseButtons: true,
                    customClass: {
                        confirmButton: 'swal-btn-confirm',
                        cancelButton: 'swal-btn-cancel'
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        Swal.fire({
                            title: 'Deleting All...',
                            text: 'Please wait while we clear your activities',
                            icon: 'info',
                            showConfirmButton: false,
                            allowOutsideClick: false,
                            didOpen: () => {
                                Swal.showLoading();
                            }
                        });
                        
                        if (href) {
                            var js = href.replace(/^javascript:/i, '');
                            eval(js);
                        }
                    }
                });
                return false;
            }
        </script>

        <style>
            .swal-btn-confirm,
            .swal-btn-cancel {
                padding: 12px 24px !important;
                font-weight: 600 !important;
                border-radius: 8px !important;
                font-size: 15px !important;
            }
        </style>
    </asp:Content>