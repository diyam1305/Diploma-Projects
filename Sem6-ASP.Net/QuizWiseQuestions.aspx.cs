using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System.Pages
{
    public partial class QuizWiseQuestions : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindQuizDropdown();
                gridBox.Visible = false;  // Hide grid initially

                // Check if QuizId is passed via QueryString
                if (Request.QueryString["QuizId"] != null)
                {
                    int quizId = 0;
                    if (int.TryParse(Request.QueryString["QuizId"], out quizId))
                    {
                        // Auto-select in dropdown
                        if (ddlQuiz.Items.FindByValue(quizId.ToString()) != null)
                        {
                            ddlQuiz.SelectedValue = quizId.ToString();
                            BindQuizWiseQuestions(quizId); // Bind the grid automatically
                        }
                    }
                }
            }
        }
        // Load quiz names
        void BindQuizDropdown()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT QUIZ_ID, QUIZ_NAME FROM QMS_QUIZ ORDER BY QUIZ_NAME", con))
                {
                    con.Open();
                    ddlQuiz.DataSource = cmd.ExecuteReader();
                    ddlQuiz.DataTextField = "QUIZ_NAME";
                    ddlQuiz.DataValueField = "QUIZ_ID";
                    ddlQuiz.DataBind();
                }
            }
            ddlQuiz.Items.Insert(0, new ListItem("-- Select Quiz --", "0"));
        }

        // Bind questions grid
        void BindQuizWiseQuestions(int quizId)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("P_QuizWiseQuestions", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    if (quizId > 0)
                    {
                        cmd.Parameters.AddWithValue("@EVENT", "SelectByQuiz");
                        cmd.Parameters.AddWithValue("@QUIZ_ID", quizId);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@EVENT", "SelectAll");
                    }
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    grdQuizWise.DataSource = dt;
                    grdQuizWise.DataBind();

                    // Show grid only if data exists
                    gridBox.Visible = dt.Rows.Count > 0;
                }
            }
        }

        protected void ddlQuiz_SelectedIndexChanged(object sender, EventArgs e)
        {
            int quizId = Convert.ToInt32(ddlQuiz.SelectedValue);
            BindQuizWiseQuestions(quizId);
        }

        protected void grdQuizWise_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdQuizWise.PageIndex = e.NewPageIndex;
            BindQuizWiseQuestions(Convert.ToInt32(ddlQuiz.SelectedValue));
        }

        protected void grdQuizWise_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteQuestion")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    using (SqlCommand cmd = new SqlCommand("P_QuizWiseQuestions", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@EVENT", "DELETE");
                        cmd.Parameters.AddWithValue("@QUIZWISEQUESTION_ID", id);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "deleteSuccess",
                    "showDeleteSuccess();",
                    true
                );
                BindQuizWiseQuestions(Convert.ToInt32(ddlQuiz.SelectedValue));
            }
        }
        protected void grdQuizWise_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lbl = (Label)e.Row.FindControl("lblSrNo");
                lbl.Text = ((grdQuizWise.PageIndex * grdQuizWise.PageSize)
                            + e.Row.RowIndex + 1).ToString();
            }
        }

        protected void btnAddQuizWise_Click(object sender, EventArgs e)
        {
            // Optional safety check
            if (ddlQuiz.SelectedValue == "0")
            {
                ScriptManager.RegisterStartupScript(
                    this,
                    GetType(),
                    "selectQuiz",
                    "Swal.fire({ icon: 'warning', title: 'Please select a quiz first.' });",
                    true
                );
                return;
            }
            Response.Redirect("~/AddQuizWiseQuestions.aspx?QuizId="  + ddlQuiz.SelectedValue);
        }
    }
}