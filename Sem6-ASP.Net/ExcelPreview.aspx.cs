using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Collections.Generic;

namespace Quiz_Management_System
{
    public partial class ExcelPreview : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User_ID"] == null)
                Response.Redirect("~/LoginPage.aspx");

            if (!IsPostBack)
            {
                if (Session["ExcelData"] == null)
                    Response.Redirect("~/Excel.aspx");

                BindGrid();
                UpdateStatistics();
            }
        }

        private void BindGrid()
        {
            DataTable dt = (DataTable)Session["ExcelData"];
            grdPreview.DataSource = dt;
            grdPreview.DataBind();
        }

        private void UpdateStatistics()
        {
            if (Session["ExcelData"] != null)
            {
                DataTable dt = (DataTable)Session["ExcelData"];

                // Total Questions
                litTotalQuestions.Text = dt.Rows.Count.ToString();
                hdnTotalCount.Value = dt.Rows.Count.ToString();

                // Total Marks
                int totalMarks = 0;
                foreach (DataRow row in dt.Rows)
                {
                    if (row["Marks"] != DBNull.Value)
                    {
                        totalMarks += Convert.ToInt32(row["Marks"]);
                    }
                }
                litTotalMarks.Text = totalMarks.ToString();
            }
        }

        protected void btnSaveAll_Click(object sender, EventArgs e)
        {
            try
            {
                SaveQuestions(true);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving questions: " + ex.Message, "warning");
            }
        }

        protected void btnSaveSelected_Click(object sender, EventArgs e)
        {
            try
            {
                SaveQuestions(false);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving selected questions: " + ex.Message, "warning");
            }
        }

        private void SaveQuestions(bool saveAll)
        {
            try
            {
                DataTable dt = (DataTable)Session["ExcelData"];
                DataRow[] rowsToSave;

                if (saveAll)
                {
                    rowsToSave = dt.Select();
                }
                else
                {
                    List<DataRow> selectedRows = new List<DataRow>();
                    foreach (GridViewRow row in grdPreview.Rows)
                    {
                        CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                        if (chk != null && chk.Checked)
                        {
                            int rowIndex = row.RowIndex;
                            if (rowIndex < dt.Rows.Count)
                            {
                                selectedRows.Add(dt.Rows[rowIndex]);
                            }
                        }
                    }

                    if (selectedRows.Count == 0)
                    {
                        ShowMessage("Please select at least one question.", "warning");
                        return;
                    }

                    rowsToSave = selectedRows.ToArray();
                }

                var result = SaveQuestionsWithQuiz(rowsToSave);

                Cleanup();
                ShowSuccessAndRedirect(result.successCount, result.skippedCount, result.skippedQuizzes);
            }
            catch (Exception ex)
            {
                ShowMessage("Error saving questions: " + ex.Message, "warning");
            }
        }

        private (int successCount, int skippedCount, List<string> skippedQuizzes) SaveQuestionsWithQuiz(DataRow[] rows)
        {
            int successCount = 0;
            int skippedCount = 0;
            List<string> skippedQuizzes = new List<string>();

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                foreach (DataRow r in rows)
                {
                    string quizName = r["QuizName"].ToString().Trim();
                    string questionText = r["Question"].ToString().Trim();

                    // Validate required fields
                    if (string.IsNullOrEmpty(questionText))
                    {
                        skippedCount++;
                        continue;
                    }

                    // Get Quiz ID by name
                    int quizId = GetQuizIdByName(con, quizName);

                    if (quizId == 0)
                    {
                        skippedCount++;
                        if (!skippedQuizzes.Contains(quizName))
                            skippedQuizzes.Add(quizName);
                        continue;
                    }

                    // Check if question exists in this quiz
                    if (IsQuestionInQuiz(con, quizId, questionText))
                    {
                        skippedCount++;
                        continue;
                    }

                    // Get or create question
                    int questionId = GetExistingQuestionId(con, questionText);

                    if (questionId == 0)
                    {
                        questionId = CreateQuestion(con, r);
                    }

                    // Link question to quiz
                    if (questionId > 0 && LinkQuestionToQuiz(con, quizId, questionId))
                    {
                        successCount++;
                    }
                }
            }

            return (successCount, skippedCount, skippedQuizzes);
        }

        private int GetQuizIdByName(SqlConnection con, string quizName)
        {
            string query = "SELECT QUIZ_ID FROM QMS_QUIZ WHERE LOWER(QUIZ_NAME) = LOWER(@QuizName)";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@QuizName", quizName);
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : 0;
            }
        }

        private int GetExistingQuestionId(SqlConnection con, string questionText)
        {
            string query = @"SELECT QUESTION_ID FROM QMS_QUESTIONS 
                            WHERE LOWER(QUESTION_TEXT) = LOWER(@QuestionText)";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@QuestionText", questionText);
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToInt32(result) : 0;
            }
        }

        private bool IsQuestionInQuiz(SqlConnection con, int quizId, string questionText)
        {
            string query = @"
                SELECT COUNT(*) 
                FROM QMS_Quizwisequestions QW
                INNER JOIN QMS_QUESTIONS QS ON QW.QUESTION_ID = QS.QUESTION_ID
                WHERE QW.QUIZ_ID = @QuizId
                AND LOWER(QS.QUESTION_TEXT) = LOWER(@QuestionText)";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@QuizId", quizId);
                cmd.Parameters.AddWithValue("@QuestionText", questionText);
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }

        private int CreateQuestion(SqlConnection con, DataRow r)
        {
            try
            {
                // Get next Question ID
                SqlCommand getIdCmd = new SqlCommand(
                    "SELECT ISNULL(MAX(QUESTION_ID), 0) + 1 FROM QMS_QUESTIONS", con);
                int questionId = Convert.ToInt32(getIdCmd.ExecuteScalar());

                SqlCommand cmd = new SqlCommand("P_QUESTION", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EVENT", "Add");
                cmd.Parameters.AddWithValue("@QUESTION_ID", questionId);
                cmd.Parameters.AddWithValue("@QUESTION_TEXT", r["Question"].ToString());
                cmd.Parameters.AddWithValue("@OPTION_A", r["OptionA"].ToString());
                cmd.Parameters.AddWithValue("@OPTION_B", r["OptionB"].ToString());
                cmd.Parameters.AddWithValue("@OPTION_C", r["OptionC"].ToString());
                cmd.Parameters.AddWithValue("@OPTION_D", r["OptionD"].ToString());
                cmd.Parameters.AddWithValue("@CORRECT_OPTION", r["CorrectOption"].ToString());
                cmd.Parameters.AddWithValue("@MARKS", Convert.ToInt32(r["Marks"]));
                cmd.Parameters.AddWithValue("@CREATED", DateTime.Now);
                cmd.Parameters.AddWithValue("@MODIFIED", DateTime.Now);
                cmd.Parameters.AddWithValue("@USER_ID", Session["User_ID"]);

                cmd.ExecuteNonQuery();
                return questionId;
            }
            catch (Exception)
            {
                return 0;
            }
        }

        private bool LinkQuestionToQuiz(SqlConnection con, int quizId, int questionId)
        {
            try
            {
                // Check if already linked
                string checkQuery = @"SELECT COUNT(*) FROM QMS_Quizwisequestions 
                                    WHERE QUIZ_ID = @QuizId AND QUESTION_ID = @QuestionId";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                {
                    checkCmd.Parameters.AddWithValue("@QuizId", quizId);
                    checkCmd.Parameters.AddWithValue("@QuestionId", questionId);
                    int exists = (int)checkCmd.ExecuteScalar();

                    if (exists > 0)
                        return false; 
                }

                // Get next QuizWiseQuestion ID
                SqlCommand getIdCmd = new SqlCommand(
                    "SELECT ISNULL(MAX(QUIZWISEQUESTION_ID), 0) + 1 FROM QMS_Quizwisequestions", con);
                int quizWiseQuestionId = Convert.ToInt32(getIdCmd.ExecuteScalar());

                SqlCommand cmd = new SqlCommand("P_QUIZWISEQUESTIONS", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EVENT", "Add");
                cmd.Parameters.AddWithValue("@QUIZWISEQUESTION_ID", quizWiseQuestionId);
                cmd.Parameters.AddWithValue("@QUIZ_ID", quizId);
                cmd.Parameters.AddWithValue("@QUESTION_ID", questionId);
                cmd.Parameters.AddWithValue("@USER_ID", Session["User_ID"]);

                cmd.ExecuteNonQuery();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Cleanup();
            Response.Redirect("~/QuizWiseQuestions.aspx");
        }

        protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
        {
            bool isChecked = ((CheckBox)sender).Checked;
            int count = 0;

            foreach (GridViewRow row in grdPreview.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null)
                {
                    chk.Checked = isChecked;
                    if (isChecked) count++;
                }
            }

            UpdateSelectedCount(count);
        }

        protected void chkSelect_CheckedChanged(object sender, EventArgs e)
        {
            int count = 0;

            foreach (GridViewRow row in grdPreview.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null && chk.Checked)
                {
                    count++;
                }
            }

            UpdateSelectedCount(count);

            // Update Select All checkbox
            int totalRows = grdPreview.Rows.Count;
            chkSelectAll.Checked = (count == totalRows && totalRows > 0);
        }

        protected void btnClearSelection_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in grdPreview.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelect");
                if (chk != null)
                {
                    chk.Checked = false;
                }
            }

            chkSelectAll.Checked = false;
            UpdateSelectedCount(0);
        }

        private void UpdateSelectedCount(int count)
        {
            lblSelectedCount.Text = count.ToString();
            hdnSelectedCount.Value = count.ToString();
        }

        protected void grdPreview_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView rowView = (DataRowView)e.Row.DataItem;
                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");

                // Validation for empty questions
                if (string.IsNullOrWhiteSpace(rowView["Question"].ToString()))
                {
                    e.Row.CssClass += " invalid-row";
                    Label lblError = (Label)e.Row.FindControl("lblError");
                    if (lblError != null)
                    {
                        lblError.Text = "Question text is empty";
                        lblError.Visible = true;
                    }
                    if (chkSelect != null)
                    {
                        chkSelect.Enabled = false;
                        chkSelect.ToolTip = "Cannot select empty question";
                    }
                }

                // Check if question already exists in the quiz
                if (chkSelect != null && chkSelect.Enabled)
                {
                    string quizName = rowView["QuizName"].ToString().Trim();
                    string questionText = rowView["Question"].ToString().Trim();

                    bool isAlreadyAdded = CheckIfQuestionExistsInQuiz(quizName, questionText);

                    if (isAlreadyAdded)
                    {
                        chkSelect.Checked = true;
                        chkSelect.Enabled = false;
                        chkSelect.ToolTip = "Already added to this quiz";
                        e.Row.CssClass += " already-added";
                    }
                }

                // Format option text for display
                FormatCellText(e.Row, "OptionA");
                FormatCellText(e.Row, "OptionB");
                FormatCellText(e.Row, "OptionC");
                FormatCellText(e.Row, "OptionD");
            }
        }

        private void FormatCellText(GridViewRow row, string optionField)
        {
            // Find and format option text cells
            int columnIndex = -1;
            switch (optionField)
            {
                case "OptionA": columnIndex = 4; break;
                case "OptionB": columnIndex = 5; break;
                case "OptionC": columnIndex = 6; break;
                case "OptionD": columnIndex = 7; break;
            }

            if (columnIndex >= 0 && columnIndex < row.Cells.Count)
            {
                var cell = row.Cells[columnIndex];
                string text = cell.Text;

                // Remove HTML encoding if present
                text = Server.HtmlDecode(text);

                // Trim and format
                if (text.Length > 15)
                {
                    cell.Text = text.Substring(0, 12) + "...";
                    cell.ToolTip = text;
                }
            }
        }

        private bool CheckIfQuestionExistsInQuiz(string quizName, string questionText)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"
                    SELECT COUNT(*) 
                    FROM QMS_Quizwisequestions QW
                    INNER JOIN QMS_QUIZ Q ON QW.QUIZ_ID = Q.QUIZ_ID
                    INNER JOIN QMS_QUESTIONS QS ON QW.QUESTION_ID = QS.QUESTION_ID
                    WHERE LOWER(Q.QUIZ_NAME) = LOWER(@QuizName)
                    AND LOWER(QS.QUESTION_TEXT) = LOWER(@QuestionText)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizName", quizName);
                    cmd.Parameters.AddWithValue("@QuestionText", questionText);

                    con.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

        private void Cleanup()
        {
            try
            {
                if (Session["ExcelFilePath"] != null)
                {
                    string filePath = Session["ExcelFilePath"].ToString();
                    if (File.Exists(filePath))
                        File.Delete(filePath);
                }
            }
            catch { /* Ignore file deletion errors */ }

            Session.Remove("ExcelData");
            Session.Remove("ExcelFilePath");
        }

        private void ShowMessage(string message, string type)
        {
            // Set appropriate CSS class based on message type
            string cssClass = "message-box ";
            cssClass += type == "success" ? "message-success" : "message-warning";

            pnlMessage.CssClass = cssClass;
            litMessage.Text = message;
            pnlMessage.Visible = true;
        }

        private void ShowSuccessAndRedirect(int success, int skipped, List<string> skippedQuizzes)
        {
            string message;
            string icon;

            if (success > 0)
            {
                message = $"Successfully saved {success} question(s)";
                if (skipped > 0)
                {
                    message += $"<br><small>{skipped} question(s) were skipped</small>";
                    if (skippedQuizzes.Count > 0)
                    {
                        message += $"<br><small>Missing quizzes: {string.Join(", ", skippedQuizzes)}</small>";
                    }
                    icon = "warning";
                }
                else
                {
                    icon = "success";
                }
            }
            else
            {
                message = "No questions were saved. Please check if:<br>" +
                         "• Quizzes exist in the system<br>" +
                         "• Questions are not already added<br>" +
                         "• Question text is not empty";
                icon = "error";
            }

            string script = $@"
                Swal.fire({{
                    icon: '{icon}',
                    title: 'Import Complete',
                    html: `{message}`,
                    confirmButtonText: 'OK',
                    confirmButtonColor: '#217346'
                }}).then((result) => {{
                    if (result.isConfirmed) {{
                        window.location.href = 'QuizWiseQuestions.aspx';
                    }}
                }});";

            ScriptManager.RegisterStartupScript(this, GetType(), "redirect", script, true);
        }
    }
}