using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Quiz_Management_System
{
    public partial class UserContentPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["USER_ID"] == null)
            {
                Response.Redirect("~/LoginPage.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            if (!IsPostBack)
            {
                LoadQuizDropdown();
            }
        }

        private void LoadQuizDropdown()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mycon"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("P_QUIZ", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EVENT", "Select");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    ddlQuizzes.DataSource = dt;
                    ddlQuizzes.DataTextField = "QUIZ_NAME";
                    ddlQuizzes.DataValueField = "QUIZ_ID";
                    ddlQuizzes.DataBind();

                    ddlQuizzes.Items.Insert(0, new ListItem("-- Select a Quiz --", "0"));

                    phQuizSelection.Visible = true;
                    phEmpty.Visible = false;
                }
                else
                {
                    phQuizSelection.Visible = false;
                    phEmpty.Visible = true;
                }
            }
        }

        protected void ddlQuizzes_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlQuizzes.SelectedValue != "0")
            {
                int quizId = Convert.ToInt32(ddlQuizzes.SelectedValue);
                LoadQuizDetails(quizId);
            }
        }

        private void LoadQuizDetails(int quizId)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mycon"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("P_QUIZ", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EVENT", "SelectById");
                cmd.Parameters.AddWithValue("@QUIZ_ID", quizId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    lblQuizName.Text = row["QUIZ_NAME"].ToString();
                    
                    // Fetch the correct count of questions by using the exact stored procedure used during the quiz
                    SqlCommand cmdCount = new SqlCommand("P_QuizWiseQuestions", con);
                    cmdCount.CommandType = CommandType.StoredProcedure;
                    cmdCount.Parameters.AddWithValue("@QUIZ_ID", quizId);
                    cmdCount.Parameters.AddWithValue("@EVENT", "GetQuestionsByQuiz");
                    
                    SqlDataAdapter daCount = new SqlDataAdapter(cmdCount);
                    DataTable dtCount = new DataTable();
                    daCount.Fill(dtCount);
                    int actualQuestions = dtCount.Rows.Count;
                    
                    lblTotalQuestions.Text = actualQuestions.ToString();
                    lblTimeLimit.Text = row["TIMELIMIT"].ToString();

                    // Store quiz ID in ViewState for later use
                    ViewState["SelectedQuizId"] = quizId;
                }
            }
        }

        protected void btnStartQuiz_Click(object sender, EventArgs e)
        {
            if (ViewState["SelectedQuizId"] != null)
            {
                int quizId = Convert.ToInt32(ViewState["SelectedQuizId"]);
                Response.Redirect($"StartQuiz.aspx?quizId={quizId}");
            }
        }
    }
}