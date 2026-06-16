<%@ Page Language="C#" MasterPageFile="~/UserDashboard.Master" AutoEventWireup="true" CodeBehind="userquizquestions.aspx.cs" Inherits="Quiz_Management_System.userquizquestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>User Quiz</h2>
   <asp:Button ID="btnStartQuiz" runat="server" Text="Start Quiz" CommandArgument='<%# Eval("QUIZ_ID") %>' OnClick="btnStartQuiz_Click" />

    <asp:Repeater ID="RepeaterQuestions" runat="server"
        OnItemDataBound="RepeaterQuestions_ItemDataBound">

        <ItemTemplate>
            <div style="border:1px solid #ccc; padding:10px; margin-bottom:15px;">
                
                <asp:HiddenField ID="hfQuestionId" runat="server"
                    Value='<%# Eval("QUESTION_ID") %>' />

                <b>
                    <%# Container.ItemIndex + 1 %>.
                    <%# Eval("QUESTION_TEXT") %>
                </b>
                <br /><br />
                <asp:RadioButtonList ID="rblOptions" runat="server"></asp:RadioButtonList>
            </div>
        </ItemTemplate>

    </asp:Repeater>

    <asp:Button ID="btnSubmit" runat="server" Text="Submit Quiz"OnClick="btnSubmit_Click" />
</asp:Content>