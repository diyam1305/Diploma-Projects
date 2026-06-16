<%--<%@ Page Title="Quiz Result" Language="C#" MasterPageFile="~/UserDashboard.Master" AutoEventWireup="true" CodeBehind="Result.aspx.cs"  Inherits="Quiz_Management_System.Pages.Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        .result-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
        }
        .result-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 20px;
        }
        .result-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .result-details {
            margin: 25px 0;
        }
        .result-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        .result-label {
            font-weight: 500;
            color: #555;
        }
        .result-value {
            font-weight: 600;
        }
        .status-badge {
            padding: 6px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
            display: inline-block;
        }
        .status-pass {
            background: #d4edda;
            color: #155724;
        }
        .status-fail {
            background: #f8d7da;
            color: #721c24;
        }
        .result-marks {
            font-size: 20px;
            font-weight: 700;
        }
        .result-actions {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .btn-back {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s;
        }
        .btn-back:hover {
            background: #0056b3;
        }
        .marks-highlight {
            font-size: 24px;
            color: #007bff;
            font-weight: 700;
        }
    </style>

    <div class="result-container">
        <div class="result-card">
            <!-- Header -->
            <div class="result-header">
                <h3 style="margin: 0; color: #333;">Quiz Result</h3>
                <p style="color: #666; margin-top: 5px;">Your performance summary</p>
            </div>

            <!-- Result Details -->
            <div class="result-details">
                <!-- Total Marks -->
                <div class="result-row">
                    <span class="result-label">Total Marks:</span>
                    <span class="result-value">
                        <asp:Label ID="lblTotal" runat="server" CssClass="marks-highlight" />
                    </span>
                </div>

                <!-- Obtained Marks -->
                <div class="result-row">
                    <span class="result-label">Obtained Marks:</span>
                    <span class="result-value">
                        <asp:Label ID="lblObtained" runat="server" CssClass="marks-highlight" />
                    </span>
                </div>

                <!-- Status -->
                <div class="result-row">
                    <span class="result-label">Status:</span>
                    <span class="result-value">
                        <asp:Label ID="lblStatus" runat="server" />
                    </span>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="result-actions">
                <asp:Button ID="btnBack" runat="server"
                    Text="Back to Dashboard"
                    CssClass="btn-back"
                    OnClick="btnBack_Click" />
            </div>
        </div>
    </div>
</asp:Content>--%>




<%@ Page Title="Quiz Result" Language="C#" MasterPageFile="~/UserDashboard.Master" AutoEventWireup="true" CodeBehind="Result.aspx.cs"  Inherits="Quiz_Management_System.Pages.Result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>
        .result-container {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
        }
        .result-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
            margin-top: 20px;
        }
        .result-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
        }
        .result-details {
            margin: 25px 0;
        }
        .result-row {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            border-bottom: 1px solid #eee;
        }
        .result-label {
            font-weight: 500;
            color: #555;
        }
        .result-value {
            font-weight: 600;
        }
        .status-badge {
            padding: 6px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
            display: inline-block;
        }
        .status-pass {
            background: #d4edda;
            color: #155724;
        }
        .status-fail {
            background: #f8d7da;
            color: #721c24;
        }
        .result-marks {
            font-size: 20px;
            font-weight: 700;
        }
        .result-actions {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .btn-back {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.3s;
        }
        .btn-back:hover {
            background: #0056b3;
        }
        .marks-highlight {
            font-size: 24px;
            color: #007bff;
            font-weight: 700;
        }
    </style>

    <div class="result-container">
        <div class="result-card">
            <!-- Header -->
            <div class="result-header">
                <h3 style="margin: 0; color: #333;">Quiz Result</h3>
                <p style="color: #666; margin-top: 5px;">Your performance summary</p>
            </div>

            <!-- Result Details -->
            <div class="result-details">
                <!-- Total Marks -->
                <div class="result-row">
                    <span class="result-label">Total Marks:</span>
                    <span class="result-value">
                        <asp:Label ID="lblTotal" runat="server" CssClass="marks-highlight" />
                    </span>
                </div>

                <!-- Obtained Marks -->
                <div class="result-row">
                    <span class="result-label">Obtained Marks:</span>
                    <span class="result-value">
                        <asp:Label ID="lblObtained" runat="server" CssClass="marks-highlight" />
                    </span>
                </div>

                <!-- Status -->
                <div class="result-row">
                    <span class="result-label">Status:</span>
                    <span class="result-value">
                        <asp:Label ID="lblStatus" runat="server" />
                    </span>
                </div>

                <!-- Total Questions -->
                <div class="result-row" id="rowTotalQuestions" runat="server">
                    <span class="result-label">Total Questions:</span>
                    <span class="result-value">
                        <asp:Label ID="lblTotalQuestions" runat="server" />
                    </span>
                </div>

                <!-- Correct Questions -->
                <div class="result-row" id="rowCorrect" runat="server">
                    <span class="result-label">Correct Questions:</span>
                    <span class="result-value" style="color:#2ecc71;">
                        <asp:Label ID="lblCorrect" runat="server" />
                    </span>
                </div>

                <!-- Wrong Questions -->
                <div class="result-row" id="rowWrong" runat="server">
                    <span class="result-label">Wrong Questions:</span>
                    <span class="result-value" style="color:#e74c3c;">
                        <asp:Label ID="lblWrong" runat="server" />
                    </span>
                </div>

                <!-- Unattempted Questions -->
                <div class="result-row" id="rowUnattempted" runat="server">
                    <span class="result-label">Unattempted Questions:</span>
                    <span class="result-value" style="color:#f39c12;">
                        <asp:Label ID="lblUnattempted" runat="server" />
                    </span>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="result-actions">
                <asp:Button ID="btnViewIncorrect" runat="server"
                    Text="View Incorrect Questions"
                    CssClass="btn-back"
                    style="margin-bottom:10px; background:#f39c12;"
                    OnClick="btnViewIncorrect_Click" />
                <br />
                <asp:Button ID="btnBack" runat="server"
                    Text="Back to Dashboard"
                    CssClass="btn-back"
                    OnClick="btnBack_Click" />
            </div>

            <asp:Panel ID="pnlIncorrectQuestions" runat="server" Visible="false" style="margin-top: 20px; background: #fafafa; padding: 15px; border-radius: 8px; border: 1px solid #ddd; text-align: left;">
                <h4 style="margin-top: 0; margin-bottom: 15px; color: #333; text-align: center;">Incorrect Questions</h4>
                <asp:Repeater ID="rptIncorrect" runat="server">
                    <ItemTemplate>
                        <div style="border-bottom: 1px solid #eee; padding: 10px 0;">
                            <strong>Q:</strong> <%# Eval("QuestionText") %><br />
                            <strong>Your Answer:</strong> <span style="color:#e74c3c;"><%# Eval("UserAnswer") %></span><br />
                            <strong>Correct Answer:</strong> <span style="color:#2ecc71;"><%# Eval("CorrectOption") %></span>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>
        </div>
    </div>
</asp:Content>