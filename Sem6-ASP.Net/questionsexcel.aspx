<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="questionsexcel.aspx.cs" Inherits="Quiz_Management_System.questionsexcel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Import Questions from Excel</h2>

        <asp:FileUpload ID="fileUploadExcel" runat="server" />
        <br /><br />
        <asp:Button ID="btnImport" runat="server" Text="Import Excel" OnClick="btnImport_Click"/>
        <br /><br />

        <h3>Questions List</h3>
        <asp:Repeater ID="RepeaterQuestions" runat="server">
            <ItemTemplate>
                <div style="margin-bottom:20px; border: 1px solid #ccc; padding:10px;">
                    <b>Q: <%# Eval("QUESTION_TEXT") %></b><br /><br />
                    <asp:RadioButtonList ID="OptionsList" runat="server"></asp:RadioButtonList>
                    <asp:HiddenField ID="HiddenQuestionID" runat="server" Value='<%# Eval("QUESTION_ID") %>' />
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <br /><br />
        <asp:Button ID="btnsubmit" runat="server" OnClick="btnsubmit_Click" Text="Submit" />
        <br />

        <h3>Database Table</h3>
        <asp:GridView ID="GVQuestions" runat="server"
            AutoGenerateColumns="False"
            DataKeyNames="QUESTION_ID"
            OnRowEditing="GVQuestions_RowEditing"
            OnRowCancelingEdit="GVQuestions_RowCancelingEdit"
            OnRowUpdating="GVQuestions_RowUpdating"
            OnRowDeleting="GVQuestions_RowDeleting">

            <Columns>
                <asp:BoundField DataField="QUESTION_ID" HeaderText="ID" ReadOnly="true" />

                
                <asp:TemplateField HeaderText="Question">
                    <ItemTemplate>
                        <%# Eval("QUESTION_TEXT") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtQuestion" runat="server" Text='<%# Bind("QUESTION_TEXT") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="A">
                    <ItemTemplate><%# Eval("OPTION_A") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOptionA" runat="server" Text='<%# Bind("OPTION_A") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="B">
                    <ItemTemplate><%# Eval("OPTION_B") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOptionB" runat="server" Text='<%# Bind("OPTION_B") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="C">
                    <ItemTemplate><%# Eval("OPTION_C") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOptionC" runat="server" Text='<%# Bind("OPTION_C") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="D">
                    <ItemTemplate><%# Eval("OPTION_D") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtOptionD" runat="server" Text='<%# Bind("OPTION_D") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="Correct">
                    <ItemTemplate><%# Eval("CORRECT_OPTION") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCorrect" runat="server" Text='<%# Bind("CORRECT_OPTION") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

                
                <asp:TemplateField HeaderText="Marks">
                    <ItemTemplate><%# Eval("MARKS") %></ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtMarks" runat="server" Text='<%# Bind("MARKS") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>

               
                <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
            </Columns>
        </asp:GridView>
</asp:Content>