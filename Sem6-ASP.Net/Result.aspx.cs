using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;

namespace Quiz_Management_System.Pages
{
    public partial class Result : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["USER_ID"] == null || Session["QUIZ_ID"] == null)
                {
                    Response.Redirect("~/UserContentPage.aspx");
                    return;
                }
                LoadResult();
                CalculateStats();
            }
        }

        void LoadResult()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["mycon"].ConnectionString))
                {
                    SqlCommand cmd = new SqlCommand("P_RESULT", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["USER_ID"]));
                    cmd.Parameters.AddWithValue("@QUIZ_ID", Convert.ToInt32(Session["QUIZ_ID"]));
                    cmd.Parameters.AddWithValue("@EVENT", "SelectLastResult");

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        lblTotal.Text = dt.Rows[0]["TOTAL_MARKS"].ToString();
                        lblObtained.Text = dt.Rows[0]["OBTAINED_MARKS"].ToString();

                        bool status = Convert.ToBoolean(dt.Rows[0]["RESULT_STATUS"]);
                        lblStatus.Text = status ? "PASS" : "FAIL";
                        lblStatus.CssClass = status
                            ? "status-badge status-pass"
                            : "status-badge status-fail";
                    }
                    else
                    {
                        // No result found - show message
                        lblTotal.Text = "N/A";
                        lblObtained.Text = "N/A";
                        lblStatus.Text = "No result found";
                        lblStatus.CssClass = "status-badge status-fail";
                    }
                }
            }
            catch (Exception ex)
            {
                // Error handling
                lblTotal.Text = "Error";
                lblObtained.Text = "Error";
                lblStatus.Text = "Error loading result: " + ex.Message;
                lblStatus.CssClass = "status-badge status-fail";
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Clear quiz-related session data
            Session.Remove("QUIZ_ID");
            Session.Remove("Questions");
            Session.Remove("Index");
            Session.Remove("PageIndex");
            Session.Remove("Score");

            Response.Redirect("~/UserContentPage.aspx");
        }

        void CalculateStats()
        {
            if (Session["Questions"] == null || Session["UserAnswers"] == null)
            {
                btnViewIncorrect.Visible = false;
                rowTotalQuestions.Visible = false;
                rowCorrect.Visible = false;
                rowWrong.Visible = false;
                rowUnattempted.Visible = false;
                return;
            }

            DataTable dt = (DataTable)Session["Questions"];
            var userAnswers = (Dictionary<int, string>)Session["UserAnswers"];
            
            int totalQuestions = dt.Rows.Count;
            int correct = 0;
            int unattempted = 0;
            int wrong = 0;

            var incorrectList = new List<object>();

            for (int i = 0; i < totalQuestions; i++)
            {
                DataRow row = dt.Rows[i];
                string correctOption = row["CORRECT_OPTION"].ToString();
                string questionText = row["QUESTION_TEXT"].ToString();
                
                if (userAnswers.ContainsKey(i))
                {
                    string userAnswer = userAnswers[i];
                    if (userAnswer.Equals(correctOption, StringComparison.OrdinalIgnoreCase))
                    {
                        correct++;
                    }
                    else
                    {
                        wrong++;
                        incorrectList.Add(new { QuestionText = questionText, UserAnswer = userAnswer, CorrectOption = correctOption });
                    }
                }
                else
                {
                    unattempted++;
                    incorrectList.Add(new { QuestionText = questionText, UserAnswer = "Not Attempted", CorrectOption = correctOption });
                }
            }

            lblTotalQuestions.Text = totalQuestions.ToString();
            lblCorrect.Text = correct.ToString();
            lblWrong.Text = wrong.ToString();
            lblUnattempted.Text = unattempted.ToString();

            rptIncorrect.DataSource = incorrectList;
            rptIncorrect.DataBind();
        }

        protected void btnViewIncorrect_Click(object sender, EventArgs e)
        {
            pnlIncorrectQuestions.Visible = !pnlIncorrectQuestions.Visible;
            if (pnlIncorrectQuestions.Visible)
            {
                btnViewIncorrect.Text = "Hide Incorrect Questions";
            }
            else
            {
                btnViewIncorrect.Text = "View Incorrect Questions";
            }
        }
    }
}