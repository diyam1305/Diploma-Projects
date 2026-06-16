using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System
{
    public partial class Questions : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User_ID"] == null)
                Response.Redirect("~/LoginPage.aspx");

            if (!IsPostBack)
            {
                // Hide grid on initial page load
                divGridBox.Visible = false;

                btnUpdate.Visible = false;
                btnCancel.Visible = false;
                lblFormTitle.Text = "Add New Question";

                // Check if redirected from Excel import
                if (Request.QueryString["import"] == "success")
                {
                    BindQuestions();
                    divGridBox.Visible = true;
                    ShowMessage("Questions imported successfully!", "success");
                }
            }
            else
            {
                // On postback, keep the grid visible if it was visible before
                if (ViewState["GridVisible"] != null && (bool)ViewState["GridVisible"])
                {
                    divGridBox.Visible = true;
                }
            }
        }

        void BindQuestions()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EVENT", "Select");

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    System.Diagnostics.Debug.WriteLine($"BindQuestions - Rows returned: {dt.Rows.Count}");

                    if (dt.Rows.Count > 0)
                    {
                        System.Diagnostics.Debug.WriteLine($"First question: {dt.Rows[0]["QUESTION_TEXT"]}");
                    }

                    grdQuestions.DataSource = dt;
                    grdQuestions.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"BindQuestions Error: {ex.Message}");
                ShowMessage($"Error loading questions: {ex.Message}", "error");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Validate form
            if (string.IsNullOrEmpty(txtQuestionText.Text) ||
                string.IsNullOrEmpty(txtA.Text) ||
                string.IsNullOrEmpty(txtB.Text) ||
                string.IsNullOrEmpty(txtC.Text) ||
                string.IsNullOrEmpty(txtD.Text) ||
                string.IsNullOrEmpty(txtMarks.Text))
            {
                ShowMessage("Please fill all required fields!", "warning");
                return;
            }

            string correctOption = "";
            if (rbA.Checked) correctOption = "A";
            else if (rbB.Checked) correctOption = "B";
            else if (rbC.Checked) correctOption = "C";
            else if (rbD.Checked) correctOption = "D";

            if (string.IsNullOrEmpty(correctOption))
            {
                ShowMessage("Please select correct option!", "warning");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@QUESTION_TEXT", txtQuestionText.Text);
                    cmd.Parameters.AddWithValue("@OPTION_A", txtA.Text);
                    cmd.Parameters.AddWithValue("@OPTION_B", txtB.Text);
                    cmd.Parameters.AddWithValue("@OPTION_C", txtC.Text);
                    cmd.Parameters.AddWithValue("@OPTION_D", txtD.Text);
                    cmd.Parameters.AddWithValue("@CORRECT_OPTION", correctOption);
                    cmd.Parameters.AddWithValue("@MARKS", txtMarks.Text);
                    cmd.Parameters.AddWithValue("@CREATED", DateTime.Now);
                    cmd.Parameters.AddWithValue("@MODIFIED", DateTime.Now);
                    cmd.Parameters.AddWithValue("@USER_ID", Session["User_ID"]);
                    cmd.Parameters.AddWithValue("@EVENT", "Add");

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    System.Diagnostics.Debug.WriteLine($"Question added - Rows affected: {rowsAffected}");
                }

                Clear();

                // Show the GridView and bind data
                divGridBox.Visible = true;
                ViewState["GridVisible"] = true;

                System.Diagnostics.Debug.WriteLine("Grid visibility set to true");

                BindQuestions();

                ShowMessage("Question added successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error adding question: {ex.Message}", "error");
            }
        }

        protected void grdQuestions_RowEditing(object sender, GridViewEditEventArgs e)
        {
            int id = Convert.ToInt32(grdQuestions.DataKeys[e.NewEditIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@QUESTION_ID", id);
                cmd.Parameters.AddWithValue("@EVENT", "SelectbyID");

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    hdnQuestionID.Value = id.ToString();
                    txtQuestionText.Text = dr["QUESTION_TEXT"].ToString();
                    txtA.Text = dr["OPTION_A"].ToString();
                    txtB.Text = dr["OPTION_B"].ToString();
                    txtC.Text = dr["OPTION_C"].ToString();
                    txtD.Text = dr["OPTION_D"].ToString();

                    string correctOption = dr["CORRECT_OPTION"].ToString();
                    rbA.Checked = (correctOption == "A");
                    rbB.Checked = (correctOption == "B");
                    rbC.Checked = (correctOption == "C");
                    rbD.Checked = (correctOption == "D");

                    txtMarks.Text = dr["MARKS"].ToString();
                }
            }

            btnSave.Visible = false;
            btnUpdate.Visible = true;
            btnCancel.Visible = true;
            lblFormTitle.Text = "Update Question";
            grdQuestions.EditIndex = -1;

            // Keep grid visible during edit
            divGridBox.Visible = true;
            ViewState["GridVisible"] = true;

            // Scroll to top
            Page.SetFocus(txtQuestionText);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Validate form
            if (string.IsNullOrEmpty(txtQuestionText.Text) ||
                string.IsNullOrEmpty(txtA.Text) ||
                string.IsNullOrEmpty(txtB.Text) ||
                string.IsNullOrEmpty(txtC.Text) ||
                string.IsNullOrEmpty(txtD.Text) ||
                string.IsNullOrEmpty(txtMarks.Text))
            {
                ShowMessage("Please fill all required fields!", "warning");
                return;
            }

            string correctOption = "";
            if (rbA.Checked) correctOption = "A";
            else if (rbB.Checked) correctOption = "B";
            else if (rbC.Checked) correctOption = "C";
            else if (rbD.Checked) correctOption = "D";

            if (string.IsNullOrEmpty(correctOption))
            {
                ShowMessage("Please select correct option!", "warning");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@QUESTION_ID", hdnQuestionID.Value);
                    cmd.Parameters.AddWithValue("@QUESTION_TEXT", txtQuestionText.Text);
                    cmd.Parameters.AddWithValue("@OPTION_A", txtA.Text);
                    cmd.Parameters.AddWithValue("@OPTION_B", txtB.Text);
                    cmd.Parameters.AddWithValue("@OPTION_C", txtC.Text);
                    cmd.Parameters.AddWithValue("@OPTION_D", txtD.Text);
                    cmd.Parameters.AddWithValue("@CORRECT_OPTION", correctOption);
                    cmd.Parameters.AddWithValue("@MARKS", txtMarks.Text);
                    cmd.Parameters.AddWithValue("@MODIFIED", DateTime.Now);
                    cmd.Parameters.AddWithValue("@USER_ID", Session["User_ID"]);
                    cmd.Parameters.AddWithValue("@EVENT", "Update");

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                Clear();
                BindQuestions();

                btnSave.Visible = true;
                btnUpdate.Visible = false;
                btnCancel.Visible = false;
                lblFormTitle.Text = "Add New Question";

                // Keep grid visible after update
                divGridBox.Visible = true;
                ViewState["GridVisible"] = true;

                ShowMessage("Question updated successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error updating question: {ex.Message}", "error");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
            btnSave.Visible = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
            lblFormTitle.Text = "Add New Question";

            // Keep grid visible after cancel
            divGridBox.Visible = true;
            ViewState["GridVisible"] = true;
        }

        protected void grdQuestions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(grdQuestions.DataKeys[e.RowIndex].Value);

            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@QUESTION_ID", id);
                    cmd.Parameters.AddWithValue("@EVENT", "Delete");

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                BindQuestions();

                // Keep grid visible after delete
                divGridBox.Visible = true;
                ViewState["GridVisible"] = true;

                ShowMessage("Question deleted successfully!", "success");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error deleting question: {ex.Message}", "error");
            }
        }

        protected void grdQuestions_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdQuestions.PageIndex = e.NewPageIndex;
            BindQuestions();

            // Keep grid visible during pagination
            divGridBox.Visible = true;
            ViewState["GridVisible"] = true;
        }

        protected void grdQuestions_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int srNo = e.Row.RowIndex + 1 + (grdQuestions.PageIndex * grdQuestions.PageSize);
                Label lbl = (Label)e.Row.FindControl("lblSrNo");
                if (lbl != null)
                {
                    lbl.Text = srNo.ToString();
                }
            }
        }
        void Clear()
        {
            txtQuestionText.Text = "";
            txtA.Text = "";
            txtB.Text = "";
            txtC.Text = "";
            txtD.Text = "";
            txtMarks.Text = "";
            rbA.Checked = false;
            rbB.Checked = false;
            rbC.Checked = false;
            rbD.Checked = false;
            hdnQuestionID.Value = "";
        }

        void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
            lblMessage.CssClass = "message-label";

            // Add specific type class
            switch (type.ToLower())
            {
                case "success":
                    lblMessage.CssClass += " message-success";
                    break;
                case "error":
                    lblMessage.CssClass += " message-error";
                    break;
                case "warning":
                    lblMessage.CssClass += " message-warning";
                    break;
            }
        }
    }
}