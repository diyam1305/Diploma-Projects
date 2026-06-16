using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Quiz_Management_System
{
    public partial class AdminProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User_ID"] == null)
            {
                Response.Redirect("~/LoginPage.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            lblMsg.Text = "";
            lblMsg.Visible = false;

            int userId = Convert.ToInt32(Session["User_ID"]);

            using (SqlConnection con = new SqlConnection(
                   ConfigurationManager.ConnectionStrings["mycon"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("P_UserAdmin", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Event", "SelectbyID");
                    cmd.Parameters.AddWithValue("@USER_ID", userId);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        txtFirstName.Text = dr["USER_FIRSTNAME"].ToString();
                        txtLastName.Text = dr["USER_LASTNAME"].ToString();
                        txtEmail.Text = dr["USER_EMAILID"].ToString();

                        SetReadOnly(true);
                        btnEdit.Visible = true;
                        btnSave.Visible = false;
                        btnCancel.Visible = false;
                    }
                    else
                    {
                        lblMsg.Text = "Profile data not found.";
                        lblMsg.CssClass = "message-box message-error";
                        lblMsg.Visible = true;
                    }
                }
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            SetReadOnly(false);
            btnEdit.Visible = false;
            btnSave.Visible = true;
            btnCancel.Visible = true;

            // Enable validators
            rfvFirstName.Enabled = true;
            rfvLastName.Enabled = true;
            rfvEmail.Enabled = true;
            revEmail.Enabled = true;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            // Validate page
            if (!Page.IsValid)
            {
                return;
            }

            int userId = Convert.ToInt32(Session["User_ID"]);

            using (SqlConnection con = new SqlConnection(
                   ConfigurationManager.ConnectionStrings["mycon"].ConnectionString))
            {
                // Get current ISACTIVE and ISADMIN values
                int isActive = 1;
                int isAdmin = 1; // Admins should remain admins
                string currentPassword = "";

                using (SqlCommand getCmd = new SqlCommand(
                    "SELECT ISACTIVE, ISADMIN, USER_PASSWORD FROM QMS_UserAdmin WHERE USER_ID = @USER_ID", con))
                {
                    getCmd.Parameters.AddWithValue("@USER_ID", userId);
                    con.Open();

                    using (SqlDataReader dr = getCmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            isActive = dr["ISACTIVE"] != DBNull.Value ? Convert.ToInt32(dr["ISACTIVE"]) : 1;
                            isAdmin = dr["ISADMIN"] != DBNull.Value ? Convert.ToInt32(dr["ISADMIN"]) : 1;
                            currentPassword = dr["USER_PASSWORD"] != DBNull.Value ? dr["USER_PASSWORD"].ToString() : "";
                        }
                    }
                    con.Close();
                }

                // Now update with all required values
                using (SqlCommand cmd = new SqlCommand("P_UserAdmin", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@Event", "Update");
                    cmd.Parameters.AddWithValue("@USER_ID", userId);
                    cmd.Parameters.AddWithValue("@USER_FIRSTNAME", txtFirstName.Text.Trim());
                    cmd.Parameters.AddWithValue("@USER_LASTNAME", txtLastName.Text.Trim());
                    cmd.Parameters.AddWithValue("@USER_EMAILID", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@USER_PASSWORD", currentPassword); // Keep existing password
                    cmd.Parameters.AddWithValue("@ISACTIVE", isActive); // Pass the actual value
                    cmd.Parameters.AddWithValue("@ISADMIN", isAdmin); // Pass the actual value

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            lblMsg.Text = "✓ Profile updated successfully!";
            lblMsg.CssClass = "message-box message-success";
            lblMsg.Visible = true;

            // Update session variable as well so the master page header is updated
            Session["USERNAME"] = txtFirstName.Text.Trim() + " " + txtLastName.Text.Trim();

            SetReadOnly(true);
            btnEdit.Visible = true;
            btnSave.Visible = false;
            btnCancel.Visible = false;

            // Disable validators
            rfvFirstName.Enabled = false;
            rfvLastName.Enabled = false;
            rfvEmail.Enabled = false;
            revEmail.Enabled = false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            // Disable validators
            rfvFirstName.Enabled = false;
            rfvLastName.Enabled = false;
            rfvEmail.Enabled = false;
            revEmail.Enabled = false;

            LoadProfile();
        }

        private void SetReadOnly(bool value)
        {
            txtFirstName.ReadOnly = value;
            txtLastName.ReadOnly = value;
            txtEmail.ReadOnly = value;
        }
    }
}
