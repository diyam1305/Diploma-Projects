using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System
{
    public partial class userquizquestions : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindQuestions();
            }
        }

        private void BindQuestions()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EVENT", "Select");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                RepeaterQuestions.DataSource = dt;
                RepeaterQuestions.DataBind();
            }
        }
        protected void RepeaterQuestions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item ||
                e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView row = (DataRowView)e.Item.DataItem;
                RadioButtonList rbl = (RadioButtonList)e.Item.FindControl("rblOptions");

                rbl.Items.Add(new ListItem(row["OPTION_A"].ToString(), "A"));
                rbl.Items.Add(new ListItem(row["OPTION_B"].ToString(), "B"));
                rbl.Items.Add(new ListItem(row["OPTION_C"].ToString(), "C"));
                rbl.Items.Add(new ListItem(row["OPTION_D"].ToString(), "D"));
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int totalMarks = 0;
            int obtainedMarks = 0;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                foreach (RepeaterItem item in RepeaterQuestions.Items)
                {
                    HiddenField hf = (HiddenField)item.FindControl("hfQuestionId");
                    RadioButtonList rbl = (RadioButtonList)item.FindControl("rblOptions");

                    SqlCommand cmd = new SqlCommand(
                        "SELECT CORRECT_OPTION, MARKS FROM QMS_QUESTIONS WHERE QUESTION_ID=@QID",
                        con);
                    cmd.Parameters.AddWithValue("@QID", hf.Value);

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        int marks = Convert.ToInt32(dr["MARKS"]);
                        totalMarks += marks;

                        if (rbl.SelectedItem != null &&
                            rbl.SelectedValue == dr["CORRECT_OPTION"].ToString())
                        {
                            obtainedMarks += marks;
                        }
                    }
                    dr.Close();
                }
            }

            bool resultStatus = obtainedMarks >= (totalMarks / 2);

            int userId;
            int quizId = Convert.ToInt32(Session["QUIZ_ID"]);

            // SAVE RESULT
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("P_RESULT", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EVENT", "Add"); 
                cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["USER_ID"]));
                cmd.Parameters.AddWithValue("@QUIZ_ID", Convert.ToInt32(Session["QUIZ_ID"]));
                cmd.Parameters.AddWithValue("@TOTAL_MARKS", totalMarks);
                cmd.Parameters.AddWithValue("@OBTAINED_MARKS", obtainedMarks);
                cmd.Parameters.AddWithValue("@RESULT_STATUS", resultStatus);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            Response.Redirect("Result.aspx");
        }

        protected void btnStartQuiz_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            if (!int.TryParse(btn.CommandArgument, out int quizId))
            {
                Response.Write("Invalid Quiz ID");
                return;
            }

            Session["QUIZ_ID"] = quizId;
            Response.Redirect("userquizquestions.aspx");
        }
    }
}
