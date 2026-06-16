using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Quiz_Management_System
{
    public partial class StartQuiz : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["mycon"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check user login
                if (Session["USER_ID"] == null)
                {
                    Response.Redirect("~/LoginPage.aspx");
                    return;
                }

                // Get quizId from query string
                if (Request.QueryString["quizId"] == null)
                {
                    Response.Redirect("~/UserContentPage.aspx");
                    return;
                }

                int quizId;
                if (!int.TryParse(Request.QueryString["quizId"], out quizId))
                {
                    Response.Redirect("~/UserContentPage.aspx");
                    return;
                }

                // Save in session
                Session["QUIZ_ID"] = quizId;

                // Load questions
                LoadQuestions();

                // Initialize sessions
                Session["PageIndex"] = 0;
                Session["Score"] = 0;
                Session["UserAnswers"] = new System.Collections.Generic.Dictionary<int, string>();

                // Show first page of questions
                ShowQuestionsPage();
            }
        }

        // Load questions from database
        private void LoadQuestions()
        {
            SqlCommand cmd = new SqlCommand("P_QuizWiseQuestions", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@QUIZ_ID", Session["QUIZ_ID"]);
            cmd.Parameters.AddWithValue("@EVENT", "GetQuestionsByQuiz");

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            Session["Questions"] = dt;
        }

        // Display questions page
        private void ShowQuestionsPage()
        {
            DataTable dt = (DataTable)Session["Questions"];
            int totalQuestions = dt.Rows.Count;
            int pageIndex = (int)Session["PageIndex"];
            int startIndex = pageIndex * 3;

            // Hide all questions
            question1.Visible = question2.Visible = question3.Visible = false;
            rblOptions1.Items.Clear();
            rblOptions2.Items.Clear();
            rblOptions3.Items.Clear();

            var userAnswers = (System.Collections.Generic.Dictionary<int, string>)Session["UserAnswers"];
            if (userAnswers == null) userAnswers = new System.Collections.Generic.Dictionary<int, string>();

            if (startIndex < totalQuestions)
            {
                lblQuestion1.Text = (startIndex + 1) + ". " + dt.Rows[startIndex]["QUESTION_TEXT"].ToString();
                AddOptions(rblOptions1, dt.Rows[startIndex]);
                if (userAnswers.ContainsKey(startIndex))
                    rblOptions1.SelectedValue = userAnswers[startIndex];
                question1.Visible = true;
            }

            if (startIndex + 1 < totalQuestions)
            {
                lblQuestion2.Text = (startIndex + 2) + ". " + dt.Rows[startIndex + 1]["QUESTION_TEXT"].ToString();
                AddOptions(rblOptions2, dt.Rows[startIndex + 1]);
                if (userAnswers.ContainsKey(startIndex + 1))
                    rblOptions2.SelectedValue = userAnswers[startIndex + 1];
                question2.Visible = true;
            }

            if (startIndex + 2 < totalQuestions)
            {
                lblQuestion3.Text = (startIndex + 3) + ". " + dt.Rows[startIndex + 2]["QUESTION_TEXT"].ToString();
                AddOptions(rblOptions3, dt.Rows[startIndex + 2]);
                if (userAnswers.ContainsKey(startIndex + 2))
                    rblOptions3.SelectedValue = userAnswers[startIndex + 2];
                question3.Visible = true;
            }

            // Update page info
            int pageNumber = pageIndex + 1;
            int totalPages = (int)Math.Ceiling((double)totalQuestions / 3);
            if (totalPages == 0) totalPages = 1;
            lblPageInfo.Text = $" (Page {pageNumber} of {totalPages})";

            btnPrevious.Visible = (pageIndex > 0);

            if (pageNumber >= totalPages)
            {
                btnNext.Text = "Submit";
            }
            else
            {
                btnNext.Text = "Next";
            }

            CalculateScoreAndProgress();
        }

        // Add options to RadioButtonList
        private void AddOptions(RadioButtonList rbl, DataRow row)
        {
            rbl.Items.Add(new ListItem(row["OPTION_A"].ToString(), row["OPTION_A"].ToString()));
            rbl.Items.Add(new ListItem(row["OPTION_B"].ToString(), row["OPTION_B"].ToString()));
            rbl.Items.Add(new ListItem(row["OPTION_C"].ToString(), row["OPTION_C"].ToString()));
            rbl.Items.Add(new ListItem(row["OPTION_D"].ToString(), row["OPTION_D"].ToString()));
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)Session["Questions"];
            int pageIndex = (int)Session["PageIndex"];
            int startIndex = pageIndex * 3;

            ProcessAnswers(startIndex);

            if (pageIndex > 0)
            {
                pageIndex--;
                Session["PageIndex"] = pageIndex;
            }

            ShowQuestionsPage();
        }

        // Next button click
        protected void btnNext_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)Session["Questions"];
            int pageIndex = (int)Session["PageIndex"];
            int startIndex = pageIndex * 3;

            ProcessAnswers(startIndex);

            pageIndex++;
            Session["PageIndex"] = pageIndex;

            if (pageIndex * 3 >= dt.Rows.Count)
            {
                CalculateScoreAndProgress();
                SaveResult();
                Response.Redirect("~/Result.aspx");
            }
            else
            {
                ShowQuestionsPage();
            }
        }

        // Process selected answers
        private void ProcessAnswers(int startIndex)
        {
            var userAnswers = (System.Collections.Generic.Dictionary<int, string>)Session["UserAnswers"];
            if (userAnswers == null) userAnswers = new System.Collections.Generic.Dictionary<int, string>();

            if (question1.Visible && rblOptions1.SelectedItem != null)
                userAnswers[startIndex] = rblOptions1.SelectedValue;

            if (question2.Visible && rblOptions2.SelectedItem != null)
                userAnswers[startIndex + 1] = rblOptions2.SelectedValue;

            if (question3.Visible && rblOptions3.SelectedItem != null)
                userAnswers[startIndex + 2] = rblOptions3.SelectedValue;

            Session["UserAnswers"] = userAnswers;
        }

        private void CalculateScoreAndProgress()
        {
            DataTable dt = (DataTable)Session["Questions"];
            var userAnswers = (System.Collections.Generic.Dictionary<int, string>)Session["UserAnswers"];
            if (userAnswers == null) userAnswers = new System.Collections.Generic.Dictionary<int, string>();

            int score = 0;
            int answered = userAnswers.Count;

            foreach (var kvp in userAnswers)
            {
                int qIndex = kvp.Key;
                string selectedOption = kvp.Value;
                if (qIndex < dt.Rows.Count)
                {
                    if (selectedOption.Equals(dt.Rows[qIndex]["CORRECT_OPTION"].ToString(), StringComparison.OrdinalIgnoreCase))
                    {
                        score += Convert.ToInt32(dt.Rows[qIndex]["MARKS"]);
                    }
                }
            }

            Session["Score"] = score;
            lblCurrentScore.Text = score.ToString();

            int totalQuestions = dt.Rows.Count;
            int progress = totalQuestions == 0 ? 0 : (int)((double)answered / totalQuestions * 100);
            lblProgress.Text = progress + "%";
            progressFill.Style["width"] = progress + "%";
        }

        // Save result to database
        private void SaveResult()
        {
            DataTable dt = (DataTable)Session["Questions"];
            int obtained = (int)Session["Score"];
            int total = 0;

            foreach (DataRow row in dt.Rows)
                total += Convert.ToInt32(row["MARKS"]);

            SqlCommand cmd = new SqlCommand("P_RESULT", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@USER_ID", Session["USER_ID"]);
            cmd.Parameters.AddWithValue("@QUIZ_ID", Session["QUIZ_ID"]);
            cmd.Parameters.AddWithValue("@TOTAL_MARKS", total);
            cmd.Parameters.AddWithValue("@OBTAINED_MARKS", obtained);
            cmd.Parameters.AddWithValue("@EVENT", "Add");

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }
}
