using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System.Pages
{
    public partial class Quiz : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        void BindQuizData()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("P_QUIZ", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EVENT", "Select");

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    // Ensure Total Questions accurately reflects the number of active questions
                    if (dt.Columns.Contains("TOTAL_QUESTIONS"))
                    {
                        dt.Columns["TOTAL_QUESTIONS"].ReadOnly = false;
                        foreach (DataRow row in dt.Rows)
                        {
                            int qId = Convert.ToInt32(row["QUIZ_ID"]);
                            using (SqlCommand cmdCount = new SqlCommand("P_QuizWiseQuestions", con))
                            {
                                cmdCount.CommandType = CommandType.StoredProcedure;
                                cmdCount.Parameters.AddWithValue("@QUIZ_ID", qId);
                                cmdCount.Parameters.AddWithValue("@EVENT", "GetQuestionsByQuiz");
                                SqlDataAdapter daCount = new SqlDataAdapter(cmdCount);
                                DataTable dtCount = new DataTable();
                                daCount.Fill(dtCount);
                                row["TOTAL_QUESTIONS"] = dtCount.Rows.Count;
                            }
                        }
                    }

                    grdData.DataSource = dt;
                    grdData.DataBind();
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User_ID"] == null)
                Response.Redirect("~/LoginPage.aspx");

            if (!IsPostBack)
                BindQuizData();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    using (SqlCommand cmd = new SqlCommand("P_QUIZ", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        if (string.IsNullOrEmpty(hdnQuizID.Value)) // Add new quiz
                        {
                            cmd.Parameters.AddWithValue("@EVENT", "Add");
                        }
                        else // Update existing quiz
                        {
                            cmd.Parameters.AddWithValue("@EVENT", "Update");
                            cmd.Parameters.AddWithValue("@QUIZ_ID", Convert.ToInt32(hdnQuizID.Value));
                        }

                        cmd.Parameters.AddWithValue("@QUIZ_NAME", txtQuizName.Text.Trim());
                        //cmd.Parameters.AddWithValue("@TOTAL_QUESTIONS", Convert.ToInt32(txtTotal_Questions.Text));
                        cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["User_ID"]));

                        con.Open();
                        cmd.ExecuteNonQuery();

                        ClearControls();
                        BindQuizData();
                    }
                }
            }
            catch (Exception ex) { }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearControls();
        }

        public void ClearControls()
        {
            txtQuizName.Text = "";
            //txtTotal_Questions.Text = "";
            hdnQuizID.Value = "";
            btnAdd.Text = "Add Quiz";
        }

        protected void grdData_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdData.PageIndex = e.NewPageIndex;
            BindQuizData();
        }

        protected void grdData_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int QUIZ_ID = Convert.ToInt32(grdData.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("P_QUIZ", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EVENT", "Delete");
                    cmd.Parameters.AddWithValue("@QUIZ_ID", QUIZ_ID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindQuizData();
        }

        protected void grdData_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditQuiz")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = grdData.Rows[index];
                int quizID = Convert.ToInt32(grdData.DataKeys[index].Value);

                Label lblQuizName = row.FindControl("lblQuizName") as Label;
                Label lblTotalQuestions = row.FindControl("lblTotalQuestions") as Label;
                Label lblTimeLimit = row.FindControl("lblTimeLimit") as Label;

                // Populate form fields
                hdnQuizID.Value = quizID.ToString();
                txtQuizName.Text = lblQuizName.Text;
                //txtTotal_Questions.Text = lblTotalQuestions.Text;

                btnAdd.Text = "Update Quiz";
            }
            else if (e.CommandName == "ViewQuiz")
            {
                int quizId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"~/QuizWiseQuestions.aspx?QuizId={quizId}");
            }
        }
    }
}