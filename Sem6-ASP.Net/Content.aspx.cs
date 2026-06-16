//using System;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;
//using System.Web.UI.DataVisualization.Charting;

//namespace Quiz_Management_System
//{
//    public partial class Content : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                LoadDashboardChart();
//            }
//        }

//        private void LoadDashboardChart()
//        {
//            string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
//            using (SqlConnection con = new SqlConnection(cs))
//            {
//                using (SqlCommand cmd = new SqlCommand("P_DASHBOARD_STATS", con))
//                {
//                    cmd.CommandType = CommandType.StoredProcedure;
//                    SqlDataAdapter da = new SqlDataAdapter(cmd);
//                    DataTable dt = new DataTable();
//                    da.Fill(dt);

//                    if (dt.Rows.Count > 0)
//                    {
//                        ChartDashboard.Series["Users"].Points.Clear();
//                        ChartDashboard.Series["Quizzes"].Points.Clear();
//                        ChartDashboard.Series["Questions"].Points.Clear();
//                        ChartDashboard.Series["Results"].Points.Clear();

//                        foreach (DataRow row in dt.Rows)
//                        {
//                            string month = row["MonthName"].ToString();
//                            ChartDashboard.Series["Users"].Points.AddXY(month, row["TotalUsers"]);
//                            ChartDashboard.Series["Quizzes"].Points.AddXY(month, row["TotalQuizzes"]);
//                            ChartDashboard.Series["Questions"].Points.AddXY(month, row["TotalQuestions"]);
//                            ChartDashboard.Series["Results"].Points.AddXY(month, row["TotalResults"]);
//                        }

//                        ChartDashboard.ChartAreas[0].AxisX.Title = "Months";
//                        ChartDashboard.ChartAreas[0].AxisY.Title = "Count";
//                        ChartDashboard.Legends[0].Docking = Docking.Top;
//                    }
//                }
//            }
//        }

//        protected void lnkLogout_Click(object sender, EventArgs e)
//        {
//            Response.Redirect("~/Logout.aspx");
//        }
//    }
//}




//using System;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;
//using System.Collections.Generic;
//using System.Web.Script.Serialization;
//using System.Diagnostics;

//namespace Quiz_Management_System
//{
//    public partial class Content : System.Web.UI.Page
//    {
//        public string Months = "[]";
//        public string UsersData = "[]";
//        public string QuizzesData = "[]";
//        public string QuestionsData = "[]";
//        public string ResultsData = "[]";

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                LoadDashboardCharts();
//            }
//        }

//        private void LoadDashboardCharts()
//        {
//            string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
//            List<string> months = new List<string>();
//            List<int> users = new List<int>();
//            List<int> quizzes = new List<int>();
//            List<int> questions = new List<int>();
//            List<int> results = new List<int>();

//            try
//            {
//                using (SqlConnection con = new SqlConnection(cs))
//                {
//                    con.Open();
//                    SqlCommand cmd = new SqlCommand("P_DASHBOARD_STATS", con);
//                    cmd.CommandType = CommandType.StoredProcedure;

//                    SqlDataAdapter da = new SqlDataAdapter(cmd);
//                    DataTable dt = new DataTable();
//                    da.Fill(dt);

//                    // Debug: Check if data is retrieved
//                    Debug.WriteLine($"Total Rows Retrieved: {dt.Rows.Count}");

//                    if (dt.Rows.Count > 0)
//                    {
//                        // Debug: Print column names
//                        foreach (DataColumn col in dt.Columns)
//                        {
//                            Debug.WriteLine($"Column: {col.ColumnName}");
//                        }

//                        foreach (DataRow row in dt.Rows)
//                        {
//                            string monthName = row["MonthName"].ToString();
//                            int totalUsers = row["TotalUsers"] != DBNull.Value ? Convert.ToInt32(row["TotalUsers"]) : 0;
//                            int totalQuizzes = row["TotalQuizzes"] != DBNull.Value ? Convert.ToInt32(row["TotalQuizzes"]) : 0;
//                            int totalQuestions = row["TotalQuestions"] != DBNull.Value ? Convert.ToInt32(row["TotalQuestions"]) : 0;
//                            int totalResults = row["TotalResults"] != DBNull.Value ? Convert.ToInt32(row["TotalResults"]) : 0;

//                            months.Add(monthName);
//                            users.Add(totalUsers);
//                            quizzes.Add(totalQuizzes);
//                            questions.Add(totalQuestions);
//                            results.Add(totalResults);

//                            // Debug: Print each row
//                            Debug.WriteLine($"{monthName}: U={totalUsers}, Q={totalQuizzes}, QS={totalQuestions}, R={totalResults}");
//                        }
//                    }
//                    else
//                    {
//                        Debug.WriteLine("No data returned from stored procedure");
//                        // Add default data for testing
//                        string[] defaultMonths = { "January", "February", "March", "April", "May", "June",
//                                                  "July", "August", "September", "October", "November", "December" };
//                        months.AddRange(defaultMonths);
//                        for (int i = 0; i < 12; i++)
//                        {
//                            users.Add(0);
//                            quizzes.Add(0);
//                            questions.Add(0);
//                            results.Add(0);
//                        }
//                    }
//                }

//                // Use JavaScriptSerializer for better compatibility
//                JavaScriptSerializer serializer = new JavaScriptSerializer();

//                Months = serializer.Serialize(months);
//                UsersData = serializer.Serialize(users);
//                QuizzesData = serializer.Serialize(quizzes);
//                QuestionsData = serializer.Serialize(questions);
//                ResultsData = serializer.Serialize(results);

//                // Debug: Print serialized data
//                Debug.WriteLine($"Months JSON: {Months}");
//                Debug.WriteLine($"Users JSON: {UsersData}");
//                Debug.WriteLine($"Quizzes JSON: {QuizzesData}");
//                Debug.WriteLine($"Questions JSON: {QuestionsData}");
//                Debug.WriteLine($"Results JSON: {ResultsData}");
//            }
//            catch (Exception ex)
//            {
//                Debug.WriteLine($"Error in LoadDashboardCharts: {ex.Message}");
//                Debug.WriteLine($"Stack Trace: {ex.StackTrace}");

//                // Set default empty data on error
//                Months = "[\"Jan\",\"Feb\",\"Mar\",\"Apr\",\"May\",\"Jun\",\"Jul\",\"Aug\",\"Sep\",\"Oct\",\"Nov\",\"Dec\"]";
//                UsersData = "[0,0,0,0,0,0,0,0,0,0,0,0]";
//                QuizzesData = "[0,0,0,0,0,0,0,0,0,0,0,0]";
//                QuestionsData = "[0,0,0,0,0,0,0,0,0,0,0,0]";
//                ResultsData = "[0,0,0,0,0,0,0,0,0,0,0,0]";

//                throw; // Re-throw to see error on page during development
//            }
//        }
//    }
//}





//using System;
//using System.Collections.Generic;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Diagnostics;
//using System.Linq;
//using System.Web;
//using System.Web.Script.Serialization;

//namespace Quiz_Management_System
//{
//    public partial class Content : System.Web.UI.Page
//    {
//        public string Months = "[]";

//        public string Users2025 = "[]";
//        public string Users2026 = "[]";

//        public string Quizzes2025 = "[]";
//        public string Quizzes2026 = "[]";

//        public string Questions2025 = "[]";
//        public string Questions2026 = "[]";

//        public string ResultsCombined = "[]";

//        JavaScriptSerializer serializer = new JavaScriptSerializer();

//        //protected void Page_Load(object sender, EventArgs e)
//        //{
//        //    if (!IsPostBack)
//        //    {
//        //        LoadDashboardCharts();
//        //    }
//        //}

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            // Stop browser caching
//            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
//            //Response.Cache.SetNoStore();
//            //Response.Cache.SetExpires(DateTime.UtcNow.AddSeconds(-1));
//            //Response.Cache.SetRevalidation(HttpCacheRevalidation.AllCaches);
//            //Response.Cache.SetProxyMaxAge(TimeSpan.Zero);
//            //Response.Cache.SetValidUntilExpires(false);

//            //// Authentication check
//            //if (Session["USER_ID"] == null)
//            //{
//            //    Response.Redirect("~/LoginPage.aspx", false);
//            //    Context.ApplicationInstance.CompleteRequest();
//            //    return;
//            //}

//            // Page-specific code below

//            if (!IsPostBack)
//          {
//               LoadDashboardCharts();
//          }
//        }


//        private void LoadDashboardCharts()
//        {
//            string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

//            List<string> months = new List<string>();

//            List<int> users2025 = new List<int>();
//            List<int> users2026 = new List<int>();

//            List<int> quizzes2025 = new List<int>();
//            List<int> quizzes2026 = new List<int>();

//            List<int> questions2025 = new List<int>();
//            List<int> questions2026 = new List<int>();

//            // PIE data
//            Dictionary<string, int> monthlyResults = new Dictionary<string, int>();

//            try
//            {
//                using (SqlConnection con = new SqlConnection(cs))
//                {
//                    con.Open();
//                    SqlCommand cmd = new SqlCommand("P_DASHBOARD_STATS", con);
//                    cmd.CommandType = CommandType.StoredProcedure;

//                    SqlDataAdapter da = new SqlDataAdapter(cmd);
//                    DataTable dt = new DataTable();
//                    da.Fill(dt);

//                    // -------- MAIN LOOP --------
//                    foreach (DataRow row in dt.Rows)
//                    {
//                        int year = Convert.ToInt32(row["YearValue"]);
//                        string monthName = row["MonthName"].ToString();

//                        int users = Convert.ToInt32(row["TotalUsers"]);
//                        int quizzes = Convert.ToInt32(row["TotalQuizzes"]);
//                        int questions = Convert.ToInt32(row["TotalQuestions"]);
//                        int results = Convert.ToInt32(row["TotalResults"]);

//                        if (!months.Contains(monthName))
//                            months.Add(monthName);

//                        if (year == 2025)
//                        {
//                            users2025.Add(users);
//                            quizzes2025.Add(quizzes);
//                            questions2025.Add(questions);
//                        }
//                        else if (year == 2026)
//                        {
//                            users2026.Add(users);
//                            quizzes2026.Add(quizzes);
//                            questions2026.Add(questions);
//                        }

//                        // -------- PIE: SUM RESULTS (2025 + 2026) --------
//                        if (!monthlyResults.ContainsKey(monthName))
//                            monthlyResults[monthName] = 0;

//                        monthlyResults[monthName] += results;
//                    }
//                }

//                // -------- ORDER MONTHS Jan → Dec --------
//                var orderedResults = monthlyResults
//                    .OrderBy(m => DateTime.ParseExact(m.Key, "MMMM", null).Month)
//                    .ToList();

//                Months = serializer.Serialize(orderedResults.Select(x => x.Key));
//                ResultsCombined = serializer.Serialize(orderedResults.Select(x => x.Value));

//                // -------- SERIALIZE LINE CHART DATA --------
//                Users2025 = serializer.Serialize(users2025);
//                Users2026 = serializer.Serialize(users2026);

//                Quizzes2025 = serializer.Serialize(quizzes2025);
//                Quizzes2026 = serializer.Serialize(quizzes2026);

//                Questions2025 = serializer.Serialize(questions2025);
//                Questions2026 = serializer.Serialize(questions2026);
//            }
//            catch (Exception ex)
//            {
//                Debug.WriteLine(ex.Message);
//                throw;
//            }
//        }

//    }
//}

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web.Script.Serialization;

namespace Quiz_Management_System
{
    public partial class Content : System.Web.UI.Page
    {
        public string Months = "[]";

        public string Users2025 = "[]";
        public string Users2026 = "[]";

        public string Quizzes2025 = "[]";
        public string Quizzes2026 = "[]";

        public string Questions2025 = "[]";
        public string Questions2026 = "[]";

        public string ResultsCombined = "[]";

        JavaScriptSerializer serializer = new JavaScriptSerializer();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboardCharts();
            }
        }

        private void LoadDashboardCharts()
        {
            string cs = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

            List<string> months = new List<string>();
            List<int> users2025 = new List<int>();
            List<int> users2026 = new List<int>();
            List<int> quizzes2025 = new List<int>();
            List<int> quizzes2026 = new List<int>();
            List<int> questions2025 = new List<int>();
            List<int> questions2026 = new List<int>();

            Dictionary<string, int> monthlyResults = new Dictionary<string, int>();

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("P_DASHBOARD_STATS", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        int year = Convert.ToInt32(row["YearValue"]);
                        string monthName = row["MonthName"].ToString();

                        int users = Convert.ToInt32(row["TotalUsers"]);
                        int quizzes = Convert.ToInt32(row["TotalQuizzes"]);
                        int questions = Convert.ToInt32(row["TotalQuestions"]);
                        int results = Convert.ToInt32(row["TotalResults"]);

                        if (!months.Contains(monthName))
                            months.Add(monthName);

                        if (year == 2025)
                        {
                            users2025.Add(users);
                            quizzes2025.Add(quizzes);
                            questions2025.Add(questions);
                        }
                        else if (year == 2026)
                        {
                            users2026.Add(users);
                            quizzes2026.Add(quizzes);
                            questions2026.Add(questions);
                        }

                        if (!monthlyResults.ContainsKey(monthName))
                            monthlyResults[monthName] = 0;

                        monthlyResults[monthName] += results;
                    }
                }

                // Order months Jan → Dec
                var orderedResults = monthlyResults
                    .OrderBy(m => DateTime.ParseExact(m.Key, "MMMM", null).Month)
                    .ToList();

                Months = serializer.Serialize(orderedResults.Select(x => x.Key));
                ResultsCombined = serializer.Serialize(orderedResults.Select(x => x.Value));

                Users2025 = serializer.Serialize(users2025);
                Users2026 = serializer.Serialize(users2026);

                Quizzes2025 = serializer.Serialize(quizzes2025);
                Quizzes2026 = serializer.Serialize(quizzes2026);

                Questions2025 = serializer.Serialize(questions2025);
                Questions2026 = serializer.Serialize(questions2026);
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw;
            }
        }
    }
}

