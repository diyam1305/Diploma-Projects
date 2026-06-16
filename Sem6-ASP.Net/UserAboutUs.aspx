<%@ Page Title="About Us" Language="C#" MasterPageFile="~/UserDashboard.Master" AutoEventWireup="true" CodeBehind="UserAboutUs.aspx.cs" Inherits="Quiz_Management_System.UserAboutUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    About Us
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .about-container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .about-header {
            text-align: center;
            margin-bottom: 40px;
            padding: 25px;
            background: linear-gradient(135deg, #e8eaf6 0%, #c5cae9 100%);
            border-radius: 15px;
            color: #1a237e;
            box-shadow: 0 5px 15px rgba(26, 35, 126, 0.15);
        }

        .about-header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 600;
        }

        .about-tagline {
            font-size: 1.1rem;
            opacity: 0.9;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
            color: #1e3c72;
        }

        .about-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .about-card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid #eef2f7;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .about-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .about-card h2 {
            font-size: 1.5rem;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Project Guide Card - Blue Theme */
        .guide-card h2 {
            color: #1e3c72;
            border-bottom-color: #1e3c72;
        }

        .guide-card {
            border-top: 4px solid #1e3c72;
        }

        /* Lab TAs Card - Green Theme */
        .ta-card h2 {
            color: #2e7d32;
            border-bottom-color: #2e7d32;
        }

        .ta-card {
            border-top: 4px solid #2e7d32;
        }

        /* Team Card - Purple Theme */
        .team-card h2 {
            color: #6a1b9a;
            border-bottom-color: #6a1b9a;
        }

        .team-card {
            border-top: 4px solid #6a1b9a;
        }

        .team-member {
            display: flex;
            align-items: center;
            padding: 15px;
            margin-bottom: 12px;
            background: #f8fafc;
            border-radius: 10px;
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
        }

        .team-member:hover {
            background: #edf2f7;
            transform: translateX(5px);
        }

        /* Guide member specific */
        .guide-card .team-member {
            border-left-color: #1e3c72;
            background: linear-gradient(to right, #f0f7ff, #ffffff);
        }

        /* TA member specific */
        .ta-card .team-member {
            border-left-color: #2e7d32;
            background: linear-gradient(to right, #f0fff4, #ffffff);
        }

        /* Team member specific */
        .team-card .team-member {
            border-left-color: #6a1b9a;
            background: linear-gradient(to right, #f3e5f5, #ffffff);
        }

        .member-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            font-size: 1.2rem;
            margin-right: 15px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        /* Guide avatar */
        .guide-card .member-avatar {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
        }

        /* TA avatar */
        .ta-card .member-avatar {
            background: linear-gradient(135deg, #2e7d32, #4caf50);
        }

        /* Team avatar */
        .team-card .member-avatar {
            background: linear-gradient(135deg, #6a1b9a, #9c27b0);
        }

        .member-info {
            flex: 1;
        }

        .member-name {
            font-weight: 600;
            font-size: 1.1rem;
            margin-bottom: 5px;
        }

        /* Guide text colors */
        .guide-card .member-name {
            color: #1e3c72;
        }

        /* TA text colors */
        .ta-card .member-name {
            color: #2e7d32;
        }

        /* Team text colors */
        .team-card .member-name {
            color: #6a1b9a;
        }

        .member-role {
            color: #666;
            font-size: 0.95rem;
            opacity: 0.8;
        }

        .project-mission {
            background: linear-gradient(135deg, #e8eaf6 0%, #c5cae9 100%);
            color: #1a237e;
            box-shadow: 0 5px 15px rgba(26, 35, 126, 0.15);
            border-radius: 12px;
            padding: 30px;
            margin-top: 40px;
        }

        .project-mission h3 {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 1.5rem;
        }

        .mission-text {
            line-height: 1.7;
            font-size: 1.05rem;
            opacity: 0.95;
            color: #1a237e
        }

        .icon {
            font-size: 1.2rem;
        }

        @media (max-width: 768px) {
            .about-grid {
                grid-template-columns: 1fr;
            }
            
            .about-header h1 {
                font-size: 2rem;
            }
            
            .about-container {
                padding: 10px;
            }
            
            .team-member {
                padding: 12px;
            }
        }
        .mission-mail {
            margin-top: 20px;
            font-size: 1rem;
        }

        .mission-mail a {
            color: #1e88e5;
            font-weight: 600;
            text-decoration: none;
        }

        .mission-mail a:hover {
            text-decoration: underline;
        }

    </style>

    <div class="about-container">
        
        <div class="about-header">
            <h1>About Quiz Management System</h1>
            <p class="about-tagline">
                An academic project designed to revolutionize online assessments with interactive 
                and efficient quiz management capabilities.
            </p>
        </div>

        <div class="about-grid">
            <!-- Project Guide Card -->
            <div class="about-card guide-card">
                <h2><span class="icon">👨‍🏫</span> Project Guide</h2>
                <div class="team-member">
                    <div class="member-avatar">AN</div>
                    <div class="member-info">
                        <div class="member-name">Prof. Akash N. Siddhpura</div>
                        <div class="member-role">Project Supervisor</div>
                    </div>
                </div>
            </div>

            <!-- Lab TAs Card -->
            <div class="about-card ta-card">
                <h2><span class="icon">🧑‍💻</span> Lab Teaching Assistants</h2>
                <div class="team-member">
                    <div class="member-avatar">SR</div>
                    <div class="member-info">
                        <div class="member-name">Mr. Smit Ranipa</div>
                        <div class="member-role">Lab Assistant</div>
                    </div>
                </div>
                <div class="team-member">
                    <div class="member-avatar">NR</div>
                    <div class="member-info">
                        <div class="member-name">Mr. Nikunj Rathod</div>
                        <div class="member-role">Lab Assistant</div>
                    </div>
                </div>
            </div>

            <!-- Team Members Card -->
            <div class="about-card team-card">
                <h2><span class="icon">👥</span> Development Team</h2>
                <div class="team-member">
                    <div class="member-avatar">DM</div>
                    <div class="member-info">
                        <div class="member-name">Ms.Diya Maru</div>
                        <div class="member-role">Developer</div>
                    </div>
                </div>
                <div class="team-member">
                    <div class="member-avatar">DT</div>
                    <div class="member-info">
                        <div class="member-name">Ms.Drashti Thanki</div>
                        <div class="member-role">Developer</div>
                    </div>
                </div>
                <div class="team-member">
                    <div class="member-avatar">RK</div>
                    <div class="member-info">
                        <div class="member-name">Ms.Rutvi Kagda</div>
                        <div class="member-role">Developer</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="project-mission">
            <h3><span class="icon">🎯</span> Project Mission</h3>
            <p class="mission-text">
                This Quiz Management System is developed as part of our academic curriculum to provide 
                a modern, intuitive, and scalable platform for conducting online assessments. Our goal 
                is to create an engaging experience for both quiz administrators and participants while 
                maintaining robustness and ease of use.
            </p>

            <div class="mission-mail">
                For any queries, contact us at
                <a href="mailto:quiz1324@gmail.com">
                    quiz1324@gmail.com
                </a>
            </div>
        </div>
    </div>
</asp:Content>