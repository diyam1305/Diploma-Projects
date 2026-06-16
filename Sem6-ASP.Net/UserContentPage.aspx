<%@ Page Title="" Language="C#" MasterPageFile="~/UserDashboard.Master" AutoEventWireup="true" CodeBehind="UserContentPage.aspx.cs" Inherits="Quiz_Management_System.UserContentPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        :root {
            --primary-color: #8b5cf6;
            --primary-light: #ede9fe;
            --primary-dark: #7c3aed;
            --secondary-color: #6366f1;
            --secondary-light: #e0e7ff;
            --success-color: #10b981;
            --success-light: #d1fae5;
            --warning-color: #f59e0b;
            --warning-light: #fef3c7;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --shadow-md: 0 6px 12px -1px rgba(0, 0, 0, 0.1), 0 4px 6px -1px rgba(0, 0, 0, 0.06);
            --shadow-lg: 0 10px 25px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --radius: 10px;
            --radius-lg: 14px;
            --radius-xl: 18px;
            --transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .container {
            padding: 24px;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Welcome Section */
        .welcome-section {
            margin-bottom: 40px;
            padding: 32px;
            background: linear-gradient(135deg, var(--primary-light), var(--secondary-light));
            border-radius: var(--radius-xl);
            border: 1.5px solid rgba(139, 92, 246, 0.2);
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
        }

        .welcome-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        .welcome-title {
            color: var(--gray-900);
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 12px;
            line-height: 1.2;
            position: relative;
            display: inline-block;
        }

        .welcome-title::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .welcome-sub {
            color: var(--gray-600);
            font-size: 16px;
            margin-top: 20px;
            max-width: 600px;
            line-height: 1.6;
        }

        /* Quiz Selection Section */
        .quiz-selection-section {
            background: white;
            border-radius: var(--radius-xl);
            border: 1.5px solid var(--gray-200);
            padding: 40px;
            margin-bottom: 40px;
            box-shadow: var(--shadow-md);
        }

        .selection-title {
            font-size: 24px;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .selection-title i {
            color: var(--primary-color);
            font-size: 28px;
        }

        .quiz-dropdown-wrapper {
            position: relative;
            margin-bottom: 24px;
        }

        .quiz-dropdown-label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--gray-700);
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .quiz-dropdown {
            width: 100%;
            padding: 16px 20px;
            font-size: 16px;
            border: 2px solid var(--gray-300);
            border-radius: var(--radius);
            background: white;
            color: var(--gray-900);
            cursor: pointer;
            transition: var(--transition);
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%238b5cf6' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 16px center;
            background-size: 20px;
            padding-right: 50px;
        }

        .quiz-dropdown:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px var(--primary-light);
        }

        .quiz-dropdown:hover {
            border-color: var(--primary-color);
        }

        .quiz-info-card {
            background: var(--gray-50);
            border: 1px solid var(--gray-200);
            border-radius: var(--radius-lg);
            padding: 24px;
            margin-bottom: 24px;
            display: none;
        }

        .quiz-info-card.active {
            display: block;
            animation: fadeIn 0.3s ease-out;
        }

        .quiz-info-title {
            font-size: 20px;
            font-weight: 700;
            color: var(--gray-900);
            margin-bottom: 16px;
        }

        .quiz-info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin-bottom: 20px;
        }

        .info-item {
            background: white;
            padding: 16px;
            border-radius: var(--radius);
            border: 1px solid var(--gray-200);
        }

        .info-label {
            font-size: 12px;
            color: var(--gray-600);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .info-value {
            font-size: 18px;
            font-weight: 700;
            color: var(--gray-900);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-value i {
            color: var(--primary-color);
        }

        .btn-start-quiz {
            width: 100%;
            max-width: 400px;
            padding: 16px 32px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: var(--radius);
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: var(--shadow-md);
            margin: 0 auto;
        }

        .btn-start-quiz:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            background: linear-gradient(135deg, var(--primary-dark), var(--primary-color));
        }

        .btn-start-quiz:active {
            transform: translateY(0);
        }

        .btn-start-quiz:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .btn-start-quiz i {
            transition: var(--transition);
        }

        .btn-start-quiz:hover i {
            transform: translateX(4px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 40px;
            background: var(--gray-50);
            border-radius: var(--radius-xl);
            border: 2px dashed var(--gray-300);
        }

        .empty-state-icon {
            width: 80px;
            height: 80px;
            background: var(--gray-200);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px;
            color: var(--gray-500);
            font-size: 32px;
        }

        .empty-state h4 {
            font-size: 20px;
            color: var(--gray-700);
            margin-bottom: 12px;
        }

        .empty-state p {
            color: var(--gray-600);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            
            .welcome-section,
            .quiz-selection-section {
                padding: 24px 20px;
            }
            
            .welcome-title {
                font-size: 24px;
            }
            
            .selection-title {
                font-size: 20px;
            }

            .quiz-info-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>

    <div class="container">
        <!-- Welcome Section -->
        <div class="welcome-section">
            <div class="welcome-title">
                <asp:Label ID="lblWelcome" runat="server" />
            </div>
            <div class="welcome-sub">
                Select a quiz from the dropdown below to test your knowledge and skills
            </div>
        </div>

        <!-- Quiz Selection Section -->
        <asp:PlaceHolder ID="phQuizSelection" runat="server">
            <div class="quiz-selection-section">
                <h2 class="selection-title">
                    <i class="fas fa-clipboard-list"></i>
                    Choose Your Quiz
                </h2>

                <div class="quiz-dropdown-wrapper">
                    <label class="quiz-dropdown-label">Select a Quiz</label>
                    <asp:DropDownList 
                        ID="ddlQuizzes" 
                        runat="server" 
                        CssClass="quiz-dropdown"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlQuizzes_SelectedIndexChanged">
                    </asp:DropDownList>
                </div>

                <asp:Button 
                    ID="btnStartQuiz" 
                    runat="server" 
                    Text="Start Quiz" 
                    CssClass="btn-start-quiz"
                    UseSubmitBehavior="false"
                    OnClientClick="return confirmStartQuiz();"
                    OnClick="btnStartQuiz_Click" />
                
                <!-- Hidden labels for JavaScript -->
                <asp:Label ID="lblQuizName" runat="server" style="display:none;" />
                <asp:Label ID="lblTotalQuestions" runat="server" style="display:none;" />
                <asp:Label ID="lblTimeLimit" runat="server" style="display:none;" />
            </div>
        </asp:PlaceHolder>
        
        <!-- Empty State -->
        <asp:PlaceHolder ID="phEmpty" runat="server" Visible="false">
            <div class="empty-state">
                <div class="empty-state-icon">
                    <i class="fas fa-clipboard-list"></i>
                </div>
                <h4>No Quizzes Available</h4>
                <p>Please check back later for new quizzes or contact your instructor.</p>
            </div>
        </asp:PlaceHolder>
    </div>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.32/sweetalert2.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/11.7.32/sweetalert2.all.min.js"></script>

    <script>
        function confirmStartQuiz() {
            event.preventDefault();

            const quizName = '<%= lblQuizName.Text %>';
            const totalQuestions = '<%= lblTotalQuestions.Text %>';
            const timeLimit = '<%= lblTimeLimit.Text %>';

            Swal.fire({
                title: 'Start Quiz?',
                html: `
                    <div style="text-align: left; padding: 10px;">
                        <p style="margin-bottom: 15px; font-size: 16px;">You are about to start:</p>
                        <p style="margin-bottom: 10px;"><strong>Quiz:</strong> ${quizName}</p>
                        <p style="margin-bottom: 10px;"><strong>Questions:</strong> ${totalQuestions}</p>
                    </div>
                `,
                icon: 'question',
                showCancelButton: true,
                confirmButtonColor: '#8b5cf6',
                cancelButtonColor: '#6b7280',
                confirmButtonText: '<i class="fas fa-play"></i> Yes, Start Quiz!',
                cancelButtonText: '<i class="fas fa-times"></i> Cancel',
                reverseButtons: true,
                focusConfirm: false,
                customClass: {
                    confirmButton: 'swal-btn-confirm',
                    cancelButton: 'swal-btn-cancel'
                }
            }).then((result) => {
                if (result.isConfirmed) {
                    // Show loading
                    Swal.fire({
                        title: 'Loading Quiz...',
                        text: 'Please wait while we prepare your quiz',
                        icon: 'info',
                        showConfirmButton: false,
                        allowOutsideClick: false,
                        didOpen: () => {
                            Swal.showLoading();
                        }
                    });

            // Submit the form
                    <%= Page.ClientScript.GetPostBackEventReference(btnStartQuiz, "") %>;
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