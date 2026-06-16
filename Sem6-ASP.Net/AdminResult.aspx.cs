using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Quiz_Management_System.Pages
{
    public partial class AdminResult : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["mycon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GridViewResults.PageIndex = 0; 
                LoadUserNames();
                BindAllResults();
                LoadSummaryStatistics();
                GridViewResults.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            }
        }

        /* ===================== LOAD USER DROPDOWN ===================== */
        private void LoadUserNames()
        {
            string query = @"SELECT USER_ID,
                             USER_FIRSTNAME + ' ' + USER_LASTNAME AS FullName
                             FROM QMS_UserAdmin
                             WHERE ISACTIVE = 1
                             ORDER BY USER_FIRSTNAME";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlUserName.DataSource = dt;
                ddlUserName.DataTextField = "FullName";
                ddlUserName.DataValueField = "USER_ID";
                ddlUserName.DataBind();

                ddlUserName.Items.Insert(0, new ListItem("All Users", ""));
            }
        }

        /* ===================== BIND ALL RESULTS ===================== */
        private void BindAllResults()
        {
            string query = @"SELECT 
                                R.RESULT_ID, 
                                R.USER_ID, 
                                U.USER_FIRSTNAME, 
                                U.USER_LASTNAME, 
                                U.USER_EMAILID,
                                R.QUIZ_ID, 
                                R.TOTAL_MARKS, 
                                R.OBTAINED_MARKS, 
                                R.RESULT_STATUS,
                                CASE 
                                    WHEN R.TOTAL_MARKS > 0 
                                    THEN CAST((R.OBTAINED_MARKS * 100.0 / R.TOTAL_MARKS) AS DECIMAL(5,2))
                                    ELSE 0 
                                END AS PERCENTAGE
                             FROM QMS_Result R
                             INNER JOIN QMS_UserAdmin U ON R.USER_ID = U.USER_ID
                             WHERE U.ISACTIVE = 1
                             ORDER BY R.RESULT_ID DESC";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ViewState["ResultsData"] = dt;

                GridViewResults.DataSource = dt;
                GridViewResults.DataBind();

                lblRecordCount.Text = dt.Rows.Count + " records";
            }
        }

        /* ===================== SEARCH RESULTS ===================== */
        private void SearchResults()
        {
            string query = @"SELECT 
                                R.RESULT_ID, 
                                R.USER_ID, 
                                U.USER_FIRSTNAME, 
                                U.USER_LASTNAME, 
                                U.USER_EMAILID,
                                R.QUIZ_ID, 
                                R.TOTAL_MARKS, 
                                R.OBTAINED_MARKS, 
                                R.RESULT_STATUS,
                                CASE 
                                    WHEN R.TOTAL_MARKS > 0 
                                    THEN CAST((R.OBTAINED_MARKS * 100.0 / R.TOTAL_MARKS) AS DECIMAL(5,2))
                                    ELSE 0 
                                END AS PERCENTAGE
                             FROM QMS_Result R
                             INNER JOIN QMS_UserAdmin U ON R.USER_ID = U.USER_ID
                             WHERE U.ISACTIVE = 1";

            if (!string.IsNullOrEmpty(ddlUserName.SelectedValue))
                query += " AND R.USER_ID = @UserID";

            if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                query += " AND R.RESULT_STATUS = @Status";

            query += " ORDER BY R.RESULT_ID DESC";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);

                if (!string.IsNullOrEmpty(ddlUserName.SelectedValue))
                    cmd.Parameters.AddWithValue("@UserID", ddlUserName.SelectedValue);

                if (!string.IsNullOrEmpty(ddlStatus.SelectedValue))
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ViewState["ResultsData"] = dt;

                GridViewResults.DataSource = dt;
                GridViewResults.DataBind();

                lblRecordCount.Text = dt.Rows.Count + " records";
            }

            LoadSummaryStatistics();
        }

        /* ===================== SUMMARY ===================== */
        private void LoadSummaryStatistics()
        {
            DataTable dt = ViewState["ResultsData"] as DataTable;

            if (dt != null && dt.Rows.Count > 0)
            {
                int passed = 0, failed = 0;
                decimal totalPercentage = 0;

                foreach (DataRow row in dt.Rows)
                {
                    if (Convert.ToInt32(row["RESULT_STATUS"]) == 1)
                        passed++;
                    else
                        failed++;

                    totalPercentage += Convert.ToDecimal(row["PERCENTAGE"]);
                }

                lblTotalAttempts.Text = dt.Rows.Count.ToString();
                lblPassed.Text = passed.ToString();
                lblFailed.Text = failed.ToString();
                lblAvgScore.Text = (totalPercentage / dt.Rows.Count).ToString("F2") + "%";
            }
            else
            {
                lblTotalAttempts.Text = "0";
                lblPassed.Text = "0";
                lblFailed.Text = "0";
                lblAvgScore.Text = "0%";
                lblRecordCount.Text = "0 records";
            }
        }

        /* ===================== EVENTS ===================== */
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            GridViewResults.PageIndex = 0;   // ✅ FIX
            SearchResults();
        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            GridViewResults.PageIndex = 0;   // ✅ FIX
            ddlUserName.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            BindAllResults();
            LoadSummaryStatistics();
        }

        protected void GridViewResults_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewResults.PageIndex = e.NewPageIndex;

            if (ViewState["ResultsData"] != null)
            {
                GridViewResults.DataSource = ViewState["ResultsData"] as DataTable;
                GridViewResults.DataBind();
            }
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewResults.PageSize = Convert.ToInt32(ddlPageSize.SelectedValue);
            GridViewResults.PageIndex = 0;

            if (ViewState["ResultsData"] != null)
            {
                GridViewResults.DataSource = ViewState["ResultsData"] as DataTable;
                GridViewResults.DataBind();
            }
        }

    }
}
