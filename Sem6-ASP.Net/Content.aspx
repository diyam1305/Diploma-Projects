<%@ Page Title="" Language="C#" MasterPageFile="~/Dashboard.Master" AutoEventWireup="true" CodeBehind="Content.aspx.cs" Inherits="Quiz_Management_System.Content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .dashboard-container {
            padding: 20px;
            width: 100%;
            box-sizing: border-box;
        }
        
        .chart-row {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .chart-container {
            flex: 1;
            min-width: 45%;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            box-sizing: border-box;
        }
        
        .chart-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #333;
            text-align: center;
        }
        
        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
            font-size: 24px;
        }
        
        .pie-chart-container {
            max-width: 400px;
            margin: 0 auto;
            width: 100%;
        }
        
        /* Mobile Responsive */
        @media (max-width: 1200px) {
            .chart-container {
                min-width: 45%;
            }
        }
        
        @media (max-width: 992px) {
            .chart-container {
                min-width: 45%;
            }
            
            .pie-chart-container {
                max-width: 350px;
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-container {
                padding: 15px;
            }
            
            .chart-row {
                gap: 15px;
                margin-bottom: 20px;
                flex-direction: column;
            }
            
            .chart-container {
                min-width: 100%;
                width: 100%;
                margin-bottom: 0;
                padding: 15px;
            }
            
            h2 {
                font-size: 22px;
                margin-bottom: 20px;
            }
            
            .chart-title {
                font-size: 16px;
                margin-bottom: 12px;
            }
            
            .pie-chart-container {
                max-width: 300px;
            }
        }
        
        @media (max-width: 576px) {
            .dashboard-container {
                padding: 10px;
            }
            
            .chart-row {
                gap: 12px;
                margin-bottom: 15px;
            }
            
            .chart-container {
                padding: 12px;
                border-radius: 6px;
            }
            
            h2 {
                font-size: 20px;
                margin-bottom: 15px;
            }
            
            .chart-title {
                font-size: 15px;
                margin-bottom: 10px;
            }
            
            .pie-chart-container {
                max-width: 280px;
            }
        }
        
        @media (max-width: 400px) {
            h2 {
                font-size: 18px;
            }
            
            .chart-title {
                font-size: 14px;
            }
            
            .pie-chart-container {
                max-width: 250px;
            }
        }
        
        /* Chart.js canvas responsive */
        canvas {
            max-width: 100%;
            height: auto !important;
        }
    </style>

    <div class="dashboard-container">
        <h2>Dashboard Statistics (Month-wise)</h2>

        <div class="chart-row">
            <div class="chart-container">
                <div class="chart-title">Users Registration Trend</div>
                <canvas id="usersChart"></canvas>
            </div>

            <div class="chart-container">
                <div class="chart-title">Quizzes Created</div>
                <canvas id="quizzesChart"></canvas>
            </div>
        </div>

        <div class="chart-row">
            <div class="chart-container">
                <div class="chart-title">Questions Added</div>
                <canvas id="questionsChart"></canvas>
            </div>

            <div class="chart-container">
                <div class="chart-title">Quiz Results Distribution</div>
                <div class="pie-chart-container">
                    <canvas id="resultsChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        // ---------- DATA FROM SERVER ----------
        let labels = JSON.parse('<%= Months %>');

        let users2025 = JSON.parse('<%= Users2025 %>');
        let users2026 = JSON.parse('<%= Users2026 %>');

        let quizzes2025 = JSON.parse('<%= Quizzes2025 %>');
        let quizzes2026 = JSON.parse('<%= Quizzes2026 %>');

        let questions2025 = JSON.parse('<%= Questions2025 %>');
        let questions2026 = JSON.parse('<%= Questions2026 %>');

        let resultsData = JSON.parse('<%= ResultsCombined %>');

        // ---------- USERS CHART ----------
        new Chart(document.getElementById('usersChart'), {
            type: 'line',
            data: {
                labels,
                datasets: [
                    { label: 'Users 2025', data: users2025 },
                    { label: 'Users 2026', data: users2026 }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true
            }
        });

        // ---------- QUIZZES CHART ----------
        new Chart(document.getElementById('quizzesChart'), {
            type: 'bar',
            data: {
                labels,
                datasets: [
                    { label: 'Quizzes 2025', data: quizzes2025 },
                    { label: 'Quizzes 2026', data: quizzes2026 }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true
            }
        });

        // ---------- QUESTIONS CHART ----------
        new Chart(document.getElementById('questionsChart'), {
            type: 'line',
            data: {
                labels,
                datasets: [
                    { label: 'Questions 2025', data: questions2025 },
                    { label: 'Questions 2026', data: questions2026 }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true
            }
        });

        // ---------- RESULTS DOUGHNUT ----------
        const monthColors = [
            '#1E88E5', '#E53935', '#FB8C00', '#FDD835',
            '#43A047', '#8E24AA', '#BDBDBD', '#039BE5',
            '#EC407A', '#F4511E', '#FBC02D', '#00897B'
        ];

        let filteredLabels = [];
        let filteredResults = [];
        let filteredColors = [];

        labels.forEach((month, index) => {
            if (resultsData[index] > 0) {
                filteredLabels.push(month);
                filteredResults.push(resultsData[index]);
                filteredColors.push(monthColors[index]);
            }
        });

        new Chart(document.getElementById('resultsChart'), {
            type: 'doughnut',
            data: {
                labels: filteredLabels,
                datasets: [{
                    data: filteredResults,
                    backgroundColor: filteredColors,
                    borderWidth: 2,
                    cutout: '60%'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'right'
                    },
                    tooltip: {
                        callbacks: {
                            label: function (context) {
                                const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                const percent = ((context.parsed / total) * 100).toFixed(1);
                                return `${context.label}: ${context.parsed} (${percent}%)`;
                            }
                        }
                    }
                }
            }
        });
    </script>
</asp:Content>