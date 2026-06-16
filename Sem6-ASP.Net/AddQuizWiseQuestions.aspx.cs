//using System;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;
//using System.Web.UI.WebControls;

//namespace Quiz_Management_System.Pages
//{
//    public partial class AddQuizWiseQuestions : System.Web.UI.Page
//    {
//        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

//        int SelectedQuizId = 0;
//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                BindQuiz(); // FIRST bind dropdown

//                if (Request.QueryString["QuizId"] != null)
//                {
//                    ddlQuiz.SelectedValue = Request.QueryString["QuizId"];
//                }

//                BindQuestions(); // THEN bind questions
//            }
//        }



//        void BindQuiz()
//        {
//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                SqlCommand cmd = new SqlCommand("SELECT Quiz_ID, Quiz_Name FROM QMS_QUIZ", con);
//                SqlDataAdapter da = new SqlDataAdapter(cmd);
//                DataTable dt = new DataTable();
//                da.Fill(dt);

//                ddlQuiz.DataSource = dt;
//                ddlQuiz.DataTextField = "Quiz_Name";
//                ddlQuiz.DataValueField = "Quiz_ID";
//                ddlQuiz.DataBind();
//                ddlQuiz.Items.Insert(0, new ListItem("--Select Quiz--", "0"));
//            }
//        }

//        void BindQuestions()
//        {
//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                SqlCommand cmd = new SqlCommand(@"
//            SELECT 
//                Q.QUESTION_ID,
//                Q.QUESTION_TEXT,
//                CASE 
//                    WHEN W.QUIZ_ID IS NULL THEN 0 
//                    ELSE 1 
//                END AS IsAdded
//            FROM QMS_QUESTIONS Q
//            LEFT JOIN QMS_Quizwisequestions W
//                ON Q.QUESTION_ID = W.QUESTION_ID
//                AND W.QUIZ_ID = @QUIZ_ID
//            ORDER BY Q.QUESTION_ID DESC
//        ", con);

//                cmd.Parameters.AddWithValue("@QUIZ_ID", ddlQuiz.SelectedValue);

//                SqlDataAdapter da = new SqlDataAdapter(cmd);
//                DataTable dt = new DataTable();
//                da.Fill(dt);

//                grdQuestions.DataSource = dt;
//                grdQuestions.DataBind();
//            }
//        }


//        int GetNextQuizWiseQuestionID()
//        {
//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                con.Open();

//                SqlCommand cmd = new SqlCommand(
//                    "SELECT ISNULL(MAX(QUIZWISEQUESTION_ID), 0) + 1 FROM QMS_Quizwisequestions",
//                    con);

//                return Convert.ToInt32(cmd.ExecuteScalar());
//            }
//        }

//        //protected void btnSave_Click(object sender, EventArgs e)
//        //{
//        //    int quizID = Convert.ToInt32(ddlQuiz.SelectedValue);

//        //    if (quizID == 0)
//        //    {
//        //        Response.Write("<script>alert('Please select a Quiz');</script>");
//        //        return;
//        //    }

//        //    using (SqlConnection con = new SqlConnection(conStr))
//        //    {
//        //        con.Open();

//        //        foreach (GridViewRow row in grdQuestions.Rows)
//        //        {
//        //            CheckBox chk = (CheckBox)row.FindControl("chkSelect");

//        //            if (chk != null && chk.Checked)
//        //            {
//        //                int questionID = Convert.ToInt32(grdQuestions.DataKeys[row.RowIndex].Value);

//        //                int newId = GetNextQuizWiseQuestionID();

//        //                SqlCommand cmd = new SqlCommand("P_QUIZWISEQUESTIONS", con);
//        //                cmd.CommandType = CommandType.StoredProcedure;

//        //                cmd.Parameters.AddWithValue("@EVENT", "Add");
//        //                cmd.Parameters.AddWithValue("@QUIZWISEQUESTION_ID", newId);
//        //                cmd.Parameters.AddWithValue("@QUIZ_ID", quizID);
//        //                cmd.Parameters.AddWithValue("@QUESTION_ID", questionID);
//        //                cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["UserID"]));

//        //                cmd.ExecuteNonQuery();
//        //            }
//        //        }
//        //    }

//        //    Response.Redirect("~/QuizWiseQuestions.aspx");
//        //}

//        protected void btnSave_Click(object sender, EventArgs e)
//        {
//            int quizID = Convert.ToInt32(ddlQuiz.SelectedValue);

//            if (quizID == 0)
//            {
//                // Handle no quiz selected
//                return;
//            }

//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                con.Open();

//                foreach (GridViewRow row in grdQuestions.Rows)
//                {
//                    CheckBox chk = (CheckBox)row.FindControl("chkSelect");

//                    if (chk != null && chk.Checked)
//                    {
//                        int questionID = Convert.ToInt32(grdQuestions.DataKeys[row.RowIndex].Value);

//                        // Check if question is already in this quiz
//                        if (IsQuestionAlreadyInQuiz(quizID, questionID))
//                        {
//                            // Skip this duplicate question
//                            continue;
//                        }

//                        int newId = GetNextQuizWiseQuestionID();

//                        SqlCommand cmd = new SqlCommand("P_QUIZWISEQUESTIONS", con);
//                        cmd.CommandType = CommandType.StoredProcedure;

//                        cmd.Parameters.AddWithValue("@EVENT", "Add");
//                        cmd.Parameters.AddWithValue("@QUIZWISEQUESTION_ID", newId);
//                        cmd.Parameters.AddWithValue("@QUIZ_ID", quizID);
//                        cmd.Parameters.AddWithValue("@QUESTION_ID", questionID);
//                        cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["User_ID"]));

//                        cmd.ExecuteNonQuery();
//                    }
//                }
//            }

//            Response.Redirect("~/QuizWiseQuestions.aspx");
//        }

//        protected void btnCancel_Click(object sender, EventArgs e)
//        {
//            Response.Redirect("~/QuizWiseQuestions.aspx");
//        }
//        //Duplicate questions
//        private bool IsQuestionAlreadyInQuiz(int quizId, int questionId)
//        {
//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                string query = "SELECT COUNT(*) FROM QMS_Quizwisequestions WHERE QUIZ_ID = @QuizId AND QUESTION_ID = @QuestionId";
//                using (SqlCommand cmd = new SqlCommand(query, con))
//                {
//                    cmd.Parameters.AddWithValue("@QuizId", quizId);
//                    cmd.Parameters.AddWithValue("@QuestionId", questionId);

//                    con.Open();
//                    int count = (int)cmd.ExecuteScalar();
//                    return count > 0;
//                }
//            }
//        }
//        protected void grdQuestions_RowDataBound(object sender, GridViewRowEventArgs e)
//        {
//            if (e.Row.RowType == DataControlRowType.DataRow)
//            {
//                CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");
//                DataRowView drv = (DataRowView)e.Row.DataItem;

//                if (Convert.ToBoolean(drv["IsAdded"]))
//                {
//                    chk.Checked = true;
//                    chk.Enabled = false; // optional but recommended
//                }
//            }
//        }
//        protected void ddlQuiz_SelectedIndexChanged(object sender, EventArgs e)
//        {
//            BindQuestions();
//        }

//    }
//}

//using System;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//namespace Quiz_Management_System.Pages
//{
//    public partial class AddQuizWiseQuestions : System.Web.UI.Page
//    {
//        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                BindQuiz();

//                if (Request.QueryString["QuizId"] != null)
//                {
//                    ddlQuiz.SelectedValue = Request.QueryString["QuizId"];
//                }

//                BindQuestions();
//            }
//        }

//        // 🔹 Bind Quiz dropdown (NO CHANGE)
//        void BindQuiz()
//        {
//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                SqlCommand cmd = new SqlCommand(
//                    "SELECT Quiz_ID, Quiz_Name FROM QMS_QUIZ", con);

//                SqlDataAdapter da = new SqlDataAdapter(cmd);
//                DataTable dt = new DataTable();
//                da.Fill(dt);

//                ddlQuiz.DataSource = dt;
//                ddlQuiz.DataTextField = "Quiz_Name";
//                ddlQuiz.DataValueField = "Quiz_ID";
//                ddlQuiz.DataBind();
//                ddlQuiz.Items.Insert(0, new ListItem("--Select Quiz--", "0"));
//            }
//        }

//        // 🔹 Bind Questions with IsAdded flag (CORE LOGIC)
//        void BindQuestions()
//        {
//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                SqlCommand cmd = new SqlCommand(@"
//                    SELECT 
//                        Q.QUESTION_ID,
//                        Q.QUESTION_TEXT,
//                        CASE 
//                            WHEN W.QUIZ_ID IS NULL THEN 0 
//                            ELSE 1 
//                        END AS IsAdded
//                    FROM QMS_QUESTIONS Q
//                    LEFT JOIN QMS_Quizwisequestions W
//                        ON Q.QUESTION_ID = W.QUESTION_ID
//                        AND W.QUIZ_ID = @QUIZ_ID
//                    ORDER BY Q.QUESTION_ID DESC", con);

//                cmd.Parameters.AddWithValue("@QUIZ_ID", ddlQuiz.SelectedValue);

//                SqlDataAdapter da = new SqlDataAdapter(cmd);
//                DataTable dt = new DataTable();
//                da.Fill(dt);

//                grdQuestions.DataSource = dt;
//                grdQuestions.DataBind();
//            }
//        }

//        // 🔹 Auto-check already-added questions (NO UI CHANGE)
//        protected void grdQuestions_RowDataBound(object sender, GridViewRowEventArgs e)
//        {
//            if (e.Row.RowType == DataControlRowType.DataRow)
//            {
//                CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");
//                DataRowView drv = (DataRowView)e.Row.DataItem;

//                if (Convert.ToBoolean(drv["IsAdded"]))
//                {
//                    chk.Checked = true;
//                    chk.Enabled = false; // prevents duplicate selection
//                }
//            }
//        }

//        //protected void grdQuestions_RowDataBound(object sender, GridViewRowEventArgs e)
//        //{
//        //    if (e.Row.RowType == DataControlRowType.DataRow)
//        //    {
//        //        CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");
//        //        DataRowView drv = (DataRowView)e.Row.DataItem;

//        //        if (Convert.ToBoolean(drv["IsAdded"]))
//        //        {
//        //            chk.Enabled = false; // disable duplicates
//        //        }
//        //    }
//        //}


//        // 🔹 Save selected questions safely
//        protected void btnSave_Click(object sender, EventArgs e)
//        {
//            int quizID = Convert.ToInt32(ddlQuiz.SelectedValue);

//            if (quizID == 0)
//                return;

//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                con.Open();

//                foreach (GridViewRow row in grdQuestions.Rows)
//                {
//                    CheckBox chk = (CheckBox)row.FindControl("chkSelect");

//                    if (chk != null && chk.Checked)
//                    {
//                        int questionID = Convert.ToInt32(
//                            grdQuestions.DataKeys[row.RowIndex].Value);

//                        // 🔒 Backend duplicate safety
//                        if (IsQuestionAlreadyInQuiz(quizID, questionID))
//                            continue;

//                        int newId = GetNextQuizWiseQuestionID();

//                        SqlCommand cmd = new SqlCommand("P_QUIZWISEQUESTIONS", con);
//                        cmd.CommandType = CommandType.StoredProcedure;

//                        cmd.Parameters.AddWithValue("@EVENT", "Add");
//                        cmd.Parameters.AddWithValue("@QUIZWISEQUESTION_ID", newId);
//                        cmd.Parameters.AddWithValue("@QUIZ_ID", quizID);
//                        cmd.Parameters.AddWithValue("@QUESTION_ID", questionID);
//                        cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["User_ID"]));

//                        cmd.ExecuteNonQuery();
//                    }
//                }
//            }

//            Response.Redirect("~/QuizWiseQuestions.aspx");
//        }

//        // 🔹 Cancel button
//        protected void btnCancel_Click(object sender, EventArgs e)
//        {
//            Response.Redirect("~/QuizWiseQuestions.aspx");
//        }

//        // 🔹 Get next primary key (NO CHANGE)
//        int GetNextQuizWiseQuestionID()
//        {
//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                con.Open();

//                SqlCommand cmd = new SqlCommand(
//                    "SELECT ISNULL(MAX(QUIZWISEQUESTION_ID), 0) + 1 FROM QMS_Quizwisequestions", con);

//                return Convert.ToInt32(cmd.ExecuteScalar());
//            }
//        }

//        // 🔹 Final duplicate protection
//        private bool IsQuestionAlreadyInQuiz(int quizId, int questionId)
//        {
//            using (SqlConnection con = new SqlConnection(conStr))
//            {
//                string query = @"SELECT COUNT(*) 
//                                 FROM QMS_Quizwisequestions 
//                                 WHERE QUIZ_ID = @QuizId 
//                                 AND QUESTION_ID = @QuestionId";

//                using (SqlCommand cmd = new SqlCommand(query, con))
//                {
//                    cmd.Parameters.AddWithValue("@QuizId", quizId);
//                    cmd.Parameters.AddWithValue("@QuestionId", questionId);

//                    con.Open();
//                    return (int)cmd.ExecuteScalar() > 0;
//                }
//            }
//        }

//        // 🔹 Quiz dropdown change
//        protected void ddlQuiz_SelectedIndexChanged(object sender, EventArgs e)
//        {
//            BindQuestions();
//        }
//    }
//}




using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System.Pages
{
    public partial class AddQuizWiseQuestions : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindQuiz();

                if (Request.QueryString["QuizId"] != null)
                {
                    string quizId = Request.QueryString["QuizId"];
                    if (ddlQuiz.Items.FindByValue(quizId) != null)
                    {
                        ddlQuiz.SelectedValue = quizId;
                    }
                }

                // Always bind questions after setting dropdown
                if (ddlQuiz.SelectedValue != "0")
                {
                    BindQuestions();
                }
            }
        }

        void BindQuiz()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("SELECT Quiz_ID, Quiz_Name FROM QMS_QUIZ", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlQuiz.DataSource = dt;
                ddlQuiz.DataTextField = "Quiz_Name";
                ddlQuiz.DataValueField = "Quiz_ID";
                ddlQuiz.DataBind();
                ddlQuiz.Items.Insert(0, new ListItem("--Select Quiz--", "0"));
            }
        }

        void BindQuestions()
        {
            int quizId = Convert.ToInt32(ddlQuiz.SelectedValue);

            if (quizId == 0)
            {
                grdQuestions.DataSource = null;
                grdQuestions.DataBind();
                return;
            }

            using (SqlConnection con = new SqlConnection(conStr))
            {
                // THIS IS THE KEY QUERY - Make sure it returns IsAdded correctly
                SqlCommand cmd = new SqlCommand(@"
                    SELECT 
                        Q.QUESTION_ID,
                        Q.QUESTION_TEXT,
                        CASE 
                            WHEN W.QUIZWISEQUESTION_ID IS NOT NULL THEN 1 
                            ELSE 0 
                        END AS IsAdded
                    FROM QMS_QUESTIONS Q
                    LEFT JOIN QMS_Quizwisequestions W
                        ON Q.QUESTION_ID = W.QUESTION_ID
                        AND W.QUIZ_ID = @QUIZ_ID
                    ORDER BY Q.QUESTION_ID DESC", con);

                cmd.Parameters.AddWithValue("@QUIZ_ID", quizId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                grdQuestions.DataSource = dt;
                grdQuestions.DataBind();
            }
        }

        // THIS IS THE CRITICAL METHOD - Must run AFTER DataBind
        //protected void grdQuestions_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        // Find the checkbox
        //        CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");

        //        if (chk != null)
        //        {
        //            // Get the data
        //            DataRowView drv = (DataRowView)e.Row.DataItem;

        //            // Check if this question is already added
        //            int isAdded = Convert.ToInt32(drv["IsAdded"]);

        //            if (isAdded == 1)
        //            {
        //                chk.Enabled = false;          // Disable it
        //                chk.ToolTip = "Already added"; // Add tooltip
        //            }
        //        }
        //    }
        //}

        protected void grdQuestions_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chk = (CheckBox)e.Row.FindControl("chkSelect");
                DataRowView drv = (DataRowView)e.Row.DataItem;

                if (chk != null)
                {
                    int isAdded = Convert.ToInt32(drv["IsAdded"]);

                    // ✅ Preselect if already in DB
                    chk.Checked = (isAdded == 1);

                    // ✅ MUST stay enabled so admin can untick
                    chk.Enabled = true;
                }
            }
        }


        protected void ddlQuiz_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindQuestions();
        }

        //protected void btnSave_Click(object sender, EventArgs e)
        //{
        //    int quizID = Convert.ToInt32(ddlQuiz.SelectedValue);

        //    if (quizID == 0)
        //    {
        //        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
        //            "alert('Please select a Quiz');", true);
        //        return;
        //    }

        //    int savedCount = 0;

        //    using (SqlConnection con = new SqlConnection(conStr))
        //    {
        //        con.Open();

        //        foreach (GridViewRow row in grdQuestions.Rows)
        //        {
        //            CheckBox chk = (CheckBox)row.FindControl("chkSelect");

        //            // Only process ENABLED and CHECKED checkboxes
        //            if (chk != null && chk.Checked && chk.Enabled)
        //            {
        //                int questionID = Convert.ToInt32(grdQuestions.DataKeys[row.RowIndex].Value);

        //                // Double-check not already in DB
        //                if (IsQuestionAlreadyInQuiz(quizID, questionID))
        //                    continue;

        //                int newId = GetNextQuizWiseQuestionID();

        //                SqlCommand cmd = new SqlCommand("P_QUIZWISEQUESTIONS", con);
        //                cmd.CommandType = CommandType.StoredProcedure;

        //                cmd.Parameters.AddWithValue("@EVENT", "Add");
        //                cmd.Parameters.AddWithValue("@QUIZWISEQUESTION_ID", newId);
        //                cmd.Parameters.AddWithValue("@QUIZ_ID", quizID);
        //                cmd.Parameters.AddWithValue("@QUESTION_ID", questionID);
        //                cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["User_ID"]));

        //                cmd.ExecuteNonQuery();
        //                savedCount++;
        //            }
        //        }
        //    }

        //    if (savedCount > 0)
        //    {
        //        Response.Redirect("~/QuizWiseQuestions.aspx");
        //    }
        //    else
        //    {
        //        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
        //            "alert('No new questions selected');", true);
        //    }
        //}

        protected void btnSave_Click(object sender, EventArgs e)
        {
            int quizID = Convert.ToInt32(ddlQuiz.SelectedValue);

            if (quizID == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "alert('Please select a Quiz');", true);
                return;
            }

            int addedCount = 0;
            int removedCount = 0;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                foreach (GridViewRow row in grdQuestions.Rows)
                {
                    CheckBox chk = (CheckBox)row.FindControl("chkSelect");

                    if (chk != null)
                    {
                        int questionID = Convert.ToInt32(grdQuestions.DataKeys[row.RowIndex].Value);
                        bool isCurrentlyInQuiz = IsQuestionAlreadyInQuiz(quizID, questionID);

                        // If checked and NOT in quiz - ADD it
                        if (chk.Checked && !isCurrentlyInQuiz)
                        {
                            int newId = GetNextQuizWiseQuestionID();

                            SqlCommand cmd = new SqlCommand("P_QUIZWISEQUESTIONS", con);
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue("@EVENT", "Add");
                            cmd.Parameters.AddWithValue("@QUIZWISEQUESTION_ID", newId);
                            cmd.Parameters.AddWithValue("@QUIZ_ID", quizID);
                            cmd.Parameters.AddWithValue("@QUESTION_ID", questionID);
                            cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["User_ID"]));

                            cmd.ExecuteNonQuery();
                            addedCount++;
                        }
                        // If NOT checked and IS in quiz - REMOVE it
                        else if (!chk.Checked && isCurrentlyInQuiz)
                        {
                            int quizWiseQuestionId = GetQuizWiseQuestionID(quizID, questionID);

                            SqlCommand cmd = new SqlCommand("P_QUIZWISEQUESTIONS", con);
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.AddWithValue("@EVENT", "DELETE");
                            cmd.Parameters.AddWithValue("@QUIZWISEQUESTION_ID", quizWiseQuestionId);

                            cmd.ExecuteNonQuery();
                            removedCount++;
                        }
                    }
                }
            }

            ScriptManager.RegisterStartupScript(
                this,
                this.GetType(),
                "resultAlert",
                $"showResultAlert({addedCount}, {removedCount});",
                true
            );

            // Refresh the grid
            Response.Redirect("~/QuizWiseQuestions.aspx?QuizId=" + quizID);

        }

        private int GetQuizWiseQuestionID(int quizId, int questionId)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"SELECT QUIZWISEQUESTION_ID 
                         FROM QMS_Quizwisequestions 
                         WHERE QUIZ_ID = @QuizId 
                         AND QUESTION_ID = @QuestionId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@QuestionId", questionId);

                    con.Open();
                    object result = cmd.ExecuteScalar();
                    return result != null ? Convert.ToInt32(result) : 0;
                }
            }
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/QuizWiseQuestions.aspx");
        }

        int GetNextQuizWiseQuestionID()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT ISNULL(MAX(QUIZWISEQUESTION_ID), 0) + 1 FROM QMS_Quizwisequestions", con);
                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private bool IsQuestionAlreadyInQuiz(int quizId, int questionId)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"SELECT COUNT(*) 
                                 FROM QMS_Quizwisequestions 
                                 WHERE QUIZ_ID = @QuizId 
                                 AND QUESTION_ID = @QuestionId";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuizId", quizId);
                    cmd.Parameters.AddWithValue("@QuestionId", questionId);

                    con.Open();
                    return (int)cmd.ExecuteScalar() > 0;
                }
            }
        }

    }
}