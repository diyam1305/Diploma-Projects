using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Quiz_Management_System
{
    public partial class UserRecentActivity : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["mycon"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            // Session check
            if (Session["USER_ID"] == null)
            {
                Response.Redirect("LoginPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadRecentActivity();
            }
        }

        private void LoadRecentActivity()
        {
            try
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("P_USER_RECENT_ACTIVITY", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["USER_ID"]));

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Store in ViewState for paging
                        ViewState["ActivityData"] = dt;

                        // Bind GridView
                        gvRecentActivity.DataSource = dt;
                        gvRecentActivity.DataBind();

                        // Set visibility of Delete All button
                        btnDeleteAll.Visible = (dt.Rows.Count > 0);

                        // Calculate and display stats
                        UpdateStats(dt);
                    }
                }
            }
            catch (Exception ex)
            {
                // Display error in a clean way
                gvRecentActivity.DataSource = null;
                gvRecentActivity.DataBind();

                btnDeleteAll.Visible = false;

                // Reset stats on error
                lblTotalAttempts.Text = "0";
                lblPassed.Text = "0";
                lblFailed.Text = "0";
                lblSuccessRate.Text = "0%";

                // Show error in empty state
                gvRecentActivity.EmptyDataText = "Error loading data. Please try again.";
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        private void UpdateStats(DataTable dt)
        {
            int totalAttempts = dt.Rows.Count;
            int passedCount = 0;

            foreach (DataRow row in dt.Rows)
            {
                if (row["RESULT_STATUS"].ToString() == "Pass")
                    passedCount++;
            }

            int failedCount = totalAttempts - passedCount;
            double successRate = totalAttempts > 0 ? Math.Round((passedCount * 100.0) / totalAttempts, 1) : 0;

            // Update stat labels
            lblTotalAttempts.Text = totalAttempts.ToString();
            lblPassed.Text = passedCount.ToString();
            lblFailed.Text = failedCount.ToString();
            lblSuccessRate.Text = successRate.ToString("0.0") + "%";
        }
        protected void gvRecentActivity_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvRecentActivity.PageIndex = e.NewPageIndex;

            if (ViewState["ActivityData"] != null)
            {
                DataTable dt = ViewState["ActivityData"] as DataTable;
                gvRecentActivity.DataSource = dt;
                gvRecentActivity.DataBind();
            }
            else
            {
                LoadRecentActivity();
            }
        }
        protected void gvRecentActivity_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int serialNo = (gvRecentActivity.PageIndex * gvRecentActivity.PageSize) + e.Row.RowIndex + 1;

                Label lblSrNo = (Label)e.Row.FindControl("lblSrNo");
                lblSrNo.Text = serialNo.ToString();
            }
        }

        protected void gvRecentActivity_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteActivity")
            {
                int resultId = Convert.ToInt32(e.CommandArgument);
                DeleteActivity(resultId);
            }
        }

        private void DeleteActivity(int resultId)
        {
            try
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM QMS_Result WHERE RESULT_ID = @RESULT_ID", con))
                {
                    cmd.Parameters.AddWithValue("@RESULT_ID", resultId);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Handle deletion error cleanly
                string script = "alert('Error deleting activity: " + ex.Message.Replace("'", "\\'") + "');";
                ClientScript.RegisterStartupScript(this.GetType(), "DeleteError", script, true);
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

            // Reload recent activity and update stats
            LoadRecentActivity();
        }

        protected void btnDeleteAll_Click(object sender, EventArgs e)
        {
            DeleteAllActivities();
        }

        private void DeleteAllActivities()
        {
            try
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM QMS_Result WHERE USER_ID = @USER_ID", con))
                {
                    cmd.Parameters.AddWithValue("@USER_ID", Convert.ToInt32(Session["USER_ID"]));
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {
                // Handle deletion error cleanly
                string script = "alert('Error deleting all activities: " + ex.Message.Replace("'", "\\'") + "');";
                ClientScript.RegisterStartupScript(this.GetType(), "DeleteAllError", script, true);
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                    con.Close();
            }

            // Reload recent activity and update stats
            LoadRecentActivity();
        }
    }
}