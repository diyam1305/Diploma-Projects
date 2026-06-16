
<%--<%@ Page Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="UserAdmin.aspx.cs" Inherits="Quiz_Management_System.Pages.UserAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<!--  SweetAlert CDN -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!--  SweetAlert JS Functions -->
<script>
    function showSaveConfirm() {
        Swal.fire({
            title: "Do you want to save the changes?",
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: "Save",
            denyButtonText: "Don't save"
        }).then((result) => {
            if (result.isConfirmed) {
                __doPostBack('<%= btnAdd.UniqueID %>', '');
            } else if (result.isDenied) {
                Swal.fire("Changes are not saved", "", "info");
            }
        });
        return false;
    }

    function showDeleteConfirm(btn) {
        Swal.fire({
            title: "Are you sure?",
            text: "This user will be permanently deleted!",
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

    input[type=text], input[type=password], input[type=email] {
        width: 100%;
        padding: 12px 16px;
        border-radius: 8px;
        border: 1px solid #d1d9e6;
        font-size: 14px;
        outline: none;
        transition: all 0.2s ease;
        background: #f9fafc;
    }

    input:focus {
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

    .grid-btn:hover {
        transform: translateY(-1px);
        opacity: 0.9;
    }

    .status-badge {
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 500;
    }

    .active-badge {
        background: #d4f8e8;
        color: #00b894;
    }

    .inactive-badge {
        background: #ffeaea;
        color: #ff4d4d;
    }

    .admin-badge {
        background: #e8e9ff;
        color: #6c5ce7;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 11px;
        font-weight: 500;
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

    .btn-group {
        display: flex;
        gap: 12px;
        justify-content: center;
        margin-top: 25px;
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

    @media screen and (max-width: 768px) {
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

        .action-cell {
            flex-direction: row;
        }

        .btn-group {
            flex-direction: column;
        }

        .btn-group .btn {
            width: 100%;
        }

        .form-row {
            grid-template-columns: 1fr;
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

    @media screen and (max-width: 480px) {
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
    /* Radio Button Styles */
.form-group .radio-button-list {
    display: flex;
    gap: 25px;
    align-items: center;
}

.form-group input[type="radio"] {
    width: 18px;
    height: 18px;
    cursor: pointer;
    margin-right: 8px;
    accent-color: #4c8bf5;
}

.form-group label[for] {
    font-size: 14px;
    color: #333;
    font-weight: 400;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
}

    /* Radio Button List Styling */
    #MainContent_rblIsActive,
    #MainContent_rblIsAdmin {
        display: flex;
        gap: 25px;
        padding: 12px 16px;
        background: #f9fafc;
        border-radius: 8px;
        border: 1px solid #d1d9e6;
    }

    #MainContent_rblIsActive label,
    #MainContent_rblIsAdmin label {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        font-size: 14px;
        color: #333;
        font-weight: 400;
        cursor: pointer;
        margin: 0;
    }

    #MainContent_rblIsActive input[type="radio"],
    #MainContent_rblIsAdmin input[type="radio"] {
        width: 18px;
        height: 18px;
        cursor: pointer;
        margin: 0;
        accent-color: #4c8bf5;
    }

    #MainContent_rblIsActive td,
    #MainContent_rblIsAdmin td {
        padding-right: 25px;
    }

    #MainContent_rblIsActive td:last-child,
    #MainContent_rblIsAdmin td:last-child {
        padding-right: 0;
    }

    @media screen and (max-width: 480px) {
        #MainContent_rblIsActive,
        #MainContent_rblIsAdmin {
            gap: 15px;
            padding: 10px 12px;
        }

        #MainContent_rblIsActive td,
        #MainContent_rblIsAdmin td {
            padding-right: 15px;
        }
    }</style>

<div class="container">
    <div class="page-title">
        <i class="fas fa-users-cog"></i>
        User Administration
    </div>

    <div class="form-box">
        <div class="form-title">
            <i class="fas fa-user-plus"></i>
            Add / Update User
        </div>

        <asp:HiddenField ID="hdnUserID" runat="server" />

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">First Name</label>
                <asp:TextBox ID="txtF_Name" runat="server" CssClass="form-control" />
            </div>

            <div class="form-group">
                <label class="form-label">Last Name</label>
                <asp:TextBox ID="txtL_Name" runat="server" CssClass="form-control" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Email Address</label>
                <asp:TextBox ID="txtEmail_ID" runat="server" CssClass="form-control" TextMode="Email" />
            </div>

            <div class="form-group">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
            </div>
        </div>

        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Is Active</label>
                <asp:RadioButtonList ID="rblIsActive" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Active" Value="1" Selected="True" />
                    <asp:ListItem Text="Inactive" Value="0" />
                </asp:RadioButtonList>
            </div>

            <div class="form-group">
                <label class="form-label">Is Admin</label>
                <asp:RadioButtonList ID="rblIsAdmin" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Admin" Value="1" />
                    <asp:ListItem Text="User" Value="0" Selected="True" />
                </asp:RadioButtonList>
            </div>
        </div>

        <div class="btn-group">
            <!--  UPDATED -->
            <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-add"
                Text="Add User"
                OnClientClick="return showSaveConfirm();"
                OnClick="btnAdd_Click" />

            <asp:Button ID="btnClear" runat="server" CssClass="btn"
                Text="Clear Form" OnClick="btnClear_Click" />
        </div>
    </div>

    <div class="grid-box">
        <div class="form-title" style="background:#6c5ce7;">
            <i class="fas fa-list"></i>
            Manage Users
        </div>

        <asp:GridView ID="grdData" runat="server"
            CssClass="gridview-style"
            AutoGenerateColumns="false"
            DataKeyNames="USER_ID"
            AllowPaging="true"
            PageSize="10"
            OnRowDeleting="grdData_RowDeleting"
            OnRowCommand="grdData_RowCommand"
            OnPageIndexChanging="grdData_PageIndexChanging">

            <Columns>
                <asp:TemplateField HeaderText="Sr No">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 + (grdData.PageIndex * grdData.PageSize) %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Name">
                    <ItemTemplate>
                        <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("USER_FIRSTNAME") %>' />
                        <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("USER_LASTNAME") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Email">
                    <ItemTemplate>
                        <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("USER_EMAILID") %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Is Active">
                    <ItemTemplate>
                        <asp:Label ID="lblIsActive" runat="server"
                            Text='<%# Convert.ToBoolean(Eval("ISACTIVE")) ? "Active" : "Inactive" %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Is Admin">
                    <ItemTemplate>
                        <asp:Label ID="lblIsAdmin" runat="server"
                            Text='<%# Convert.ToBoolean(Eval("ISADMIN")) ? "Admin" : "User" %>' />
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="btnEditRow" runat="server"
                            CssClass="grid-btn edit"
                            Text="Edit"
                            CommandName="EditUser"
                            CommandArgument='<%# Container.DataItemIndex %>' />

                        <!--  UPDATED -->
                        <asp:Button ID="btnDelete" runat="server"
                            CssClass="grid-btn delete"
                            Text="Delete"
                            CommandName="Delete"
                            OnClientClick="return showDeleteConfirm(this);" />
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>
        </asp:GridView>
    </div>
</div>

</asp:Content>--%>






<%--<%@ Page Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="UserAdmin.aspx.cs"
    Inherits="Quiz_Management_System.Pages.UserAdmin" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <!--  SweetAlert CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <!--  SweetAlert JS Functions -->
        <script>
            function showSaveConfirm() {
                Swal.fire({
                    title: "Do you want to save the changes?",
                    showDenyButton: true,
                    showCancelButton: true,
                    confirmButtonText: "Save",
                    denyButtonText: "Don't save"
                }).then((result) => {
                    if (result.isConfirmed) {
                        __doPostBack('<%= btnAdd.UniqueID %>', '');
                    } else if (result.isDenied) {
                        Swal.fire("Changes are not saved", "", "info");
                    }
                });
                return false;
            }

            function showDeleteConfirm(btn) {
                Swal.fire({
                    title: "Are you sure?",
                    text: "This user will be permanently deleted!",
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

            input[type=text],
            input[type=password],
            input[type=email] {
                width: 100%;
                padding: 12px 16px;
                border-radius: 8px;
                border: 1px solid #d1d9e6;
                font-size: 14px;
                outline: none;
                transition: all 0.2s ease;
                background: #f9fafc;
            }

            input:focus {
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

            .grid-btn:hover {
                transform: translateY(-1px);
                opacity: 0.9;
            }

            .status-badge {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 500;
            }

            .active-badge {
                background: #d4f8e8;
                color: #00b894;
            }

            .inactive-badge {
                background: #ffeaea;
                color: #ff4d4d;
            }

            .admin-badge {
                background: #e8e9ff;
                color: #6c5ce7;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 500;
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

            .btn-group {
                display: flex;
                gap: 12px;
                justify-content: center;
                margin-top: 25px;
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

            @media screen and (max-width: 768px) {
                .container {
                    padding: 15px;
                    margin: 15px auto;
                }

                .page-title {
                    font-size: 22px;
                }

                .form-box,
                .grid-box {
                    padding: 20px 15px;
                }

                .action-cell {
                    flex-direction: row;
                }

                .btn-group {
                    flex-direction: column;
                }

                .btn-group .btn {
                    width: 100%;
                }

                .form-row {
                    grid-template-columns: 1fr;
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

            /* Radio Button Styles */
            .form-group .radio-button-list {
                display: flex;
                gap: 25px;
                align-items: center;
            }

            .form-group input[type="radio"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
                margin-right: 8px;
                accent-color: #4c8bf5;
            }

            .form-group label[for] {
                font-size: 14px;
                color: #333;
                font-weight: 400;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
            }

            /* Radio Button List Styling */
            #MainContent_rblIsActive,
            #MainContent_rblIsAdmin {
                display: flex;
                gap: 25px;
                padding: 12px 16px;
                background: #f9fafc;
                border-radius: 8px;
                border: 1px solid #d1d9e6;
            }

            #MainContent_rblIsActive label,
            #MainContent_rblIsAdmin label {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
                color: #333;
                font-weight: 400;
                cursor: pointer;
                margin: 0;
            }

            #MainContent_rblIsActive input[type="radio"],
            #MainContent_rblIsAdmin input[type="radio"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
                margin: 0;
                accent-color: #4c8bf5;
            }

            #MainContent_rblIsActive td,
            #MainContent_rblIsAdmin td {
                padding-right: 25px;
            }

            #MainContent_rblIsActive td:last-child,
            #MainContent_rblIsAdmin td:last-child {
                padding-right: 0;
            }

            @media screen and (max-width: 480px) {

                #MainContent_rblIsActive,
                #MainContent_rblIsAdmin {
                    gap: 15px;
                    padding: 10px 12px;
                }

                #MainContent_rblIsActive td,
                #MainContent_rblIsAdmin td {
                    padding-right: 15px;
                }
            }
        </style>

        <div class="container">
            <div class="page-title">
                <i class="fas fa-users-cog"></i>
                User Administration
            </div>

            <div class="form-box">
                <div class="form-title">
                    <i class="fas fa-user-plus"></i>
                    Add / Update User
                </div>

                <asp:HiddenField ID="hdnUserID" runat="server" />

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <asp:TextBox ID="txtF_Name" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Last Name</label>
                        <asp:TextBox ID="txtL_Name" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <asp:TextBox ID="txtEmail_ID" runat="server" CssClass="form-control" TextMode="Email" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Is Active</label>
                        <asp:RadioButtonList ID="rblIsActive" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Active" Value="1" Selected="True" />
                            <asp:ListItem Text="Inactive" Value="0" />
                        </asp:RadioButtonList>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Is Admin</label>
                        <asp:RadioButtonList ID="rblIsAdmin" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Admin" Value="1" />
                            <asp:ListItem Text="User" Value="0" Selected="True" />
                        </asp:RadioButtonList>
                    </div>
                </div>

                <div class="btn-group">
                    <!--  UPDATED -->
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-add" Text="Add User"
                        OnClientClick="return showSaveConfirm();" OnClick="btnAdd_Click" />

                    <asp:Button ID="btnClear" runat="server" CssClass="btn" Text="Clear Form"
                        OnClick="btnClear_Click" />
                </div>
            </div>

            <div class="grid-box">
                <div class="form-title" style="background:#6c5ce7;">
                    <i class="fas fa-list"></i>
                    Manage Users
                </div>

                <asp:GridView ID="grdData" runat="server" CssClass="gridview-style" AutoGenerateColumns="false"
                    DataKeyNames="USER_ID" AllowPaging="true" PageSize="10" OnRowDeleting="grdData_RowDeleting"
                    OnRowCommand="grdData_RowCommand" OnPageIndexChanging="grdData_PageIndexChanging"
                    PagerStyle-CssClass="pager-container">

                    <Columns>
                        <asp:TemplateField HeaderText="Sr No">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 + (grdData.PageIndex * grdData.PageSize) %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("USER_FIRSTNAME") %>' />
                                <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("USER_LASTNAME") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("USER_EMAILID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Is Active">
                            <ItemTemplate>
                                <asp:Label ID="lblIsActive" runat="server"
                                    Text='<%# Convert.ToBoolean(Eval("ISACTIVE")) ? "Active" : "Inactive" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Is Admin">
                            <ItemTemplate>
                                <asp:Label ID="lblIsAdmin" runat="server"
                                    Text='<%# Convert.ToBoolean(Eval("ISADMIN")) ? "Admin" : "User" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnEditRow" runat="server" CssClass="grid-btn edit" Text="Edit"
                                    CommandName="EditUser" CommandArgument='<%# Container.DataItemIndex %>' />

                                <!--  UPDATED -->
                                <asp:Button ID="btnDelete" runat="server" CssClass="grid-btn delete" Text="Delete"
                                    CommandName="Delete" OnClientClick="return showDeleteConfirm(this);" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </asp:Content>--%>





<%@ Page Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="UserAdmin.aspx.cs"
    Inherits="Quiz_Management_System.Pages.UserAdmin" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <!--  SweetAlert CDN -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <!--  SweetAlert JS Functions -->
        <script>
            function showSaveConfirm() {
                Swal.fire({
                    title: "Do you want to save the changes?",
                    showDenyButton: true,
                    showCancelButton: true,
                    confirmButtonText: "Save",
                    denyButtonText: "Don't save"
                }).then((result) => {
                    if (result.isConfirmed) {
                        __doPostBack('<%= btnAdd.UniqueID %>', '');
                    } else if (result.isDenied) {
                        Swal.fire("Changes are not saved", "", "info");
                    }
                });
                return false;
            }

            function showDeleteConfirm(btn) {
                Swal.fire({
                    title: "Are you sure?",
                    text: "This user will be permanently deleted!",
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

            input[type=text],
            input[type=password],
            input[type=email] {
                width: 100%;
                padding: 12px 16px;
                border-radius: 8px;
                border: 1px solid #d1d9e6;
                font-size: 14px;
                outline: none;
                transition: all 0.2s ease;
                background: #f9fafc;
            }

            input:focus {
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

            .grid-btn:hover {
                transform: translateY(-1px);
                opacity: 0.9;
            }

            .status-badge {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 500;
            }

            .active-badge {
                background: #d4f8e8;
                color: #00b894;
            }

            .inactive-badge {
                background: #ffeaea;
                color: #ff4d4d;
            }

            .admin-badge {
                background: #e8e9ff;
                color: #6c5ce7;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: 500;
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

            .btn-group {
                display: flex;
                gap: 12px;
                justify-content: center;
                margin-top: 25px;
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

            @media screen and (max-width: 768px) {
                .container {
                    padding: 15px;
                    margin: 15px auto;
                }

                .page-title {
                    font-size: 22px;
                }

                .form-box,
                .grid-box {
                    padding: 20px 15px;
                }

                .action-cell {
                    flex-direction: row;
                }

                .btn-group {
                    flex-direction: column;
                }

                .btn-group .btn {
                    width: 100%;
                }

                .form-row {
                    grid-template-columns: 1fr;
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

            /* Radio Button Styles */
            .form-group .radio-button-list {
                display: flex;
                gap: 25px;
                align-items: center;
            }

            .form-group input[type="radio"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
                margin-right: 8px;
                accent-color: #4c8bf5;
            }

            .form-group label[for] {
                font-size: 14px;
                color: #333;
                font-weight: 400;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
            }

            /* Radio Button List Styling */
            #MainContent_rblIsActive,
            #MainContent_rblIsAdmin {
                display: flex;
                gap: 25px;
                padding: 12px 16px;
                background: #f9fafc;
                border-radius: 8px;
                border: 1px solid #d1d9e6;
            }

            #MainContent_rblIsActive label,
            #MainContent_rblIsAdmin label {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
                color: #333;
                font-weight: 400;
                cursor: pointer;
                margin: 0;
            }

            #MainContent_rblIsActive input[type="radio"],
            #MainContent_rblIsAdmin input[type="radio"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
                margin: 0;
                accent-color: #4c8bf5;
            }

            #MainContent_rblIsActive td,
            #MainContent_rblIsAdmin td {
                padding-right: 25px;
            }

            #MainContent_rblIsActive td:last-child,
            #MainContent_rblIsAdmin td:last-child {
                padding-right: 0;
            }

            @media screen and (max-width: 480px) {

                #MainContent_rblIsActive,
                #MainContent_rblIsAdmin {
                    gap: 15px;
                    padding: 10px 12px;
                }

                #MainContent_rblIsActive td,
                #MainContent_rblIsAdmin td {
                    padding-right: 15px;
                }
            }
        </style>

        <div class="container">
            <div class="page-title">
                <i class="fas fa-users-cog"></i>
                User Administration
            </div>

            <div class="form-box">
                <div class="form-title">
                    <i class="fas fa-user-plus"></i>
                    Add / Update User
                </div>

                <asp:HiddenField ID="hdnUserID" runat="server" />

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">First Name</label>
                        <asp:TextBox ID="txtF_Name" runat="server" CssClass="form-control" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Last Name</label>
                        <asp:TextBox ID="txtL_Name" runat="server" CssClass="form-control" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Email Address</label>
                        <asp:TextBox ID="txtEmail_ID" runat="server" CssClass="form-control" TextMode="Email" />
                    </div>

                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label">Is Active</label>
                        <asp:RadioButtonList ID="rblIsActive" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Active" Value="1" Selected="True" />
                            <asp:ListItem Text="Inactive" Value="0" />
                        </asp:RadioButtonList>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Is Admin</label>
                        <asp:RadioButtonList ID="rblIsAdmin" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Text="Admin" Value="1" />
                            <asp:ListItem Text="User" Value="0" Selected="True" />
                        </asp:RadioButtonList>
                    </div>
                </div>

                <div class="btn-group">
                    <!--  UPDATED -->
                    <asp:Button ID="btnAdd" runat="server" CssClass="btn btn-add" Text="Add User"
                        OnClientClick="return showSaveConfirm();" OnClick="btnAdd_Click" />

                    <asp:Button ID="btnClear" runat="server" CssClass="btn" Text="Clear Form"
                        OnClick="btnClear_Click" />
                </div>
            </div>

            <div class="grid-box">
                <div class="form-title" style="background:#6c5ce7;">
                    <i class="fas fa-list"></i>
                    Manage Users
                </div>

                <asp:GridView ID="grdData" runat="server" CssClass="gridview-style" AutoGenerateColumns="false"
                    DataKeyNames="USER_ID" AllowPaging="true" PageSize="10" OnRowDeleting="grdData_RowDeleting"
                    OnRowCommand="grdData_RowCommand" OnPageIndexChanging="grdData_PageIndexChanging"
                    PagerStyle-CssClass="pager-container">

                    <Columns>
                        <asp:TemplateField HeaderText="Sr No">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("USER_FIRSTNAME") %>' />
                                <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("USER_LASTNAME") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email">
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("USER_EMAILID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Is Active">
                            <ItemTemplate>
                                <asp:Label ID="lblIsActive" runat="server"
                                    Text='<%# Convert.ToBoolean(Eval("ISACTIVE")) ? "Active" : "Inactive" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Is Admin">
                            <ItemTemplate>
                                <asp:Label ID="lblIsAdmin" runat="server"
                                    Text='<%# Convert.ToBoolean(Eval("ISADMIN")) ? "Admin" : "User" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button ID="btnEditRow" runat="server" CssClass="grid-btn edit" Text="Edit"
                                    CommandName="EditUser" CommandArgument='<%# Container.DataItemIndex %>' />

                                <!--  UPDATED -->
                                <asp:Button ID="btnDelete" runat="server" CssClass="grid-btn delete" Text="Delete"
                                    CommandName="Delete" OnClientClick="return showDeleteConfirm(this);" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </asp:Content>