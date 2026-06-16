using ClosedXML.Excel;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System
{
    public partial class questionsexcel : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
            RepeaterQuestions.ItemDataBound += RepeaterQuestions_ItemDataBound;
        }

        protected void btnImport_Click(object sender, EventArgs e)
        {
            if (!fileUploadExcel.HasFile)
            {
                Response.Write("<script>alert('Please upload an Excel file.');</script>");
                return;
            }

            // CHANGE STARTS HERE (NO FOLDER, NO SAVE)
            using (var workbook = new XLWorkbook(fileUploadExcel.PostedFile.InputStream))
            {
                var ws = workbook.Worksheet(1);
                int rowCount = ws.LastRowUsed().RowNumber();

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    con.Open();

                    SqlCommand deleteCmd = new SqlCommand(
                        "DELETE FROM QMS_Questions WHERE USER_ID = @USER_ID", con);
                    deleteCmd.Parameters.AddWithValue("@USER_ID", Session["USER_ID"]);
                    deleteCmd.ExecuteNonQuery();

                    for (int row = 2; row <= rowCount; row++)
                    {
                        string question = ws.Cell(row, 1).GetString();
                        string A = ws.Cell(row, 2).GetString();
                        string B = ws.Cell(row, 3).GetString();
                        string C = ws.Cell(row, 4).GetString();
                        string D = ws.Cell(row, 5).GetString();
                        string correct = ws.Cell(row, 6).GetString();

                        int marks = 0;
                        int.TryParse(ws.Cell(row, 9).GetString(), out marks);

                        SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@EVENT", "Add");
                        cmd.Parameters.AddWithValue("@QUESTION_TEXT", question);
                        cmd.Parameters.AddWithValue("@OPTION_A", A);
                        cmd.Parameters.AddWithValue("@OPTION_B", B);
                        cmd.Parameters.AddWithValue("@OPTION_C", C);
                        cmd.Parameters.AddWithValue("@OPTION_D", D);
                        cmd.Parameters.AddWithValue("@CORRECT_OPTION", correct);
                        cmd.Parameters.AddWithValue("@MARKS", marks);
                        cmd.Parameters.AddWithValue("@USER_ID", Session["USER_ID"]);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            // CHANGE ENDS HERE

            BindGrid();
            BindRepeater();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EVENT", "Select");

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GVQuestions.DataSource = dt;
                GVQuestions.DataBind();
            }
        }

        private void BindRepeater()
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
                var rbl = (RadioButtonList)e.Item.FindControl("OptionsList");
                var row = (DataRowView)e.Item.DataItem;

                rbl.Items.Add(new ListItem(row["OPTION_A"].ToString(), "A"));
                rbl.Items.Add(new ListItem(row["OPTION_B"].ToString(), "B"));
                rbl.Items.Add(new ListItem(row["OPTION_C"].ToString(), "C"));
                rbl.Items.Add(new ListItem(row["OPTION_D"].ToString(), "D"));
            }
        }
        protected void GVQuestions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int questionId = Convert.ToInt32(GVQuestions.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EVENT", "Delete");
                cmd.Parameters.AddWithValue("@QUESTION_ID", questionId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindGrid();
        }

        protected void GVQuestions_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GVQuestions.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GVQuestions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GVQuestions.EditIndex = -1;
            BindGrid();
        }

        protected void GVQuestions_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(GVQuestions.DataKeys[e.RowIndex].Value);
            GridViewRow row = GVQuestions.Rows[e.RowIndex];

            string questionText = ((TextBox)row.FindControl("txtQuestion")).Text;
            string optionA = ((TextBox)row.FindControl("txtOptionA")).Text;
            string optionB = ((TextBox)row.FindControl("txtOptionB")).Text;
            string optionC = ((TextBox)row.FindControl("txtOptionC")).Text;
            string optionD = ((TextBox)row.FindControl("txtOptionD")).Text;
            string correct = ((TextBox)row.FindControl("txtCorrect")).Text;
            int marks = int.Parse(((TextBox)row.FindControl("txtMarks")).Text);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EVENT", "Update");
                cmd.Parameters.AddWithValue("@QUESTION_ID", id);
                cmd.Parameters.AddWithValue("@QUESTION_TEXT", questionText);
                cmd.Parameters.AddWithValue("@OPTION_A", optionA);
                cmd.Parameters.AddWithValue("@OPTION_B", optionB);
                cmd.Parameters.AddWithValue("@OPTION_C", optionC);
                cmd.Parameters.AddWithValue("@OPTION_D", optionD);
                cmd.Parameters.AddWithValue("@CORRECT_OPTION", correct);
                cmd.Parameters.AddWithValue("@MARKS", marks);
                cmd.Parameters.AddWithValue("@USER_ID", Session["USER_ID"]);

                con.Open();
                cmd.ExecuteNonQuery();
            }
            GVQuestions.EditIndex = -1;
            BindGrid();
        }
    }
}